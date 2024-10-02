resource "kubectl_manifest" "kubeflow-tensorboard-controller-crd-tensorboards" {
  yaml_body = <<YAML
apiVersion: apiextensions.k8s.io/v1
kind: CustomResourceDefinition
metadata:
  annotations:
    controller-gen.kubebuilder.io/version: v0.8.0
  creationTimestamp: null
  labels:
    app: tensorboard-controller
    kustomize.component: tensorboard-controller
  name: tensorboards.tensorboard.kubeflow.org
spec:
  group: tensorboard.kubeflow.org
  names:
    kind: Tensorboard
    listKind: TensorboardList
    plural: tensorboards
    singular: tensorboard
  scope: Namespaced
  versions:
  - name: v1alpha1
    schema:
      openAPIV3Schema:
        description: Tensorboard is the Schema for the tensorboards API
        properties:
          apiVersion:
            description: 'APIVersion defines the versioned schema of this representation
              of an object. Servers should convert recognized schemas to the latest
              internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources'
            type: string
          kind:
            description: 'Kind is a string value representing the REST resource this
              object represents. Servers may infer this from the endpoint the client
              submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds'
            type: string
          metadata:
            type: object
          spec:
            description: TensorboardSpec defines the desired state of Tensorboard
            properties:
              logspath:
                description: 'INSERT ADDITIONAL SPEC FIELDS - desired state of cluster
                  Important: Run "make" to regenerate code after modifying this file'
                type: string
            required:
            - logspath
            type: object
          status:
            description: TensorboardStatus defines the observed state of Tensorboard
            properties:
              conditions:
                description: Conditions is an array of current conditions
                items:
                  description: TensorboardCondition defines the observed state of
                    Tensorboard
                  properties:
                    deploymentState:
                      description: Deployment status, 'Available', 'Progressing',
                        'ReplicaFailure' .
                      type: string
                    lastProbeTime:
                      description: Last time we probed the condition.
                      format: date-time
                      type: string
                  required:
                  - deploymentState
                  type: object
                type: array
              readyReplicas:
                description: ReadyReplicas defines the number of Tensorboard Servers
                  that are available to connect. The value of ReadyReplicas can be
                  either 0 or 1
                format: int32
                type: integer
            required:
            - conditions
            - readyReplicas
            type: object
        type: object
    served: true
    storage: true
    subresources:
      status: {}
status:
  acceptedNames:
    kind: ""
    plural: ""
  conditions: []
  storedVersions: []
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool]
}

resource "kubectl_manifest" "kubeflow-tensorboard-controller-serviceaccount-tensorboard-controller-manager" {
  yaml_body = <<YAML
apiVersion: v1
kind: ServiceAccount
metadata:
  labels:
    app: tensorboard-controller
    kustomize.component: tensorboard-controller
  name: tensorboard-controller-controller-manager
  namespace: kubeflow
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool, kubectl_manifest.kubeflow-kubeflow-namespace]
}

resource "kubectl_manifest" "kubeflow-tensorboard-controller-role-tensorboard-controller-leader-election-role" {
  yaml_body = <<YAML
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  labels:
    app: tensorboard-controller
    kustomize.component: tensorboard-controller
  name: tensorboard-controller-leader-election-role
  namespace: kubeflow
rules:
- apiGroups:
  - ""
  resources:
  - configmaps
  verbs:
  - get
  - list
  - watch
  - create
  - update
  - patch
  - delete
- apiGroups:
  - coordination.k8s.io
  resources:
  - leases
  verbs:
  - get
  - list
  - watch
  - create
  - update
  - patch
  - delete
- apiGroups:
  - ""
  resources:
  - events
  verbs:
  - create
  - patch
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool, kubectl_manifest.kubeflow-kubeflow-namespace]
}

resource "kubectl_manifest" "kubeflow-tensorboard-controller-clusterrole-tensorboard-controller-manager-role" {
  yaml_body = <<YAML
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  creationTimestamp: null
  labels:
    app: tensorboard-controller
    kustomize.component: tensorboard-controller
  name: tensorboard-controller-manager-role
rules:
- apiGroups:
  - apps
  resources:
  - deployments
  verbs:
  - create
  - get
  - list
  - update
  - watch
- apiGroups:
  - ""
  resources:
  - persistentvolumeclaims
  verbs:
  - get
  - list
  - watch
- apiGroups:
  - ""
  resources:
  - pods
  verbs:
  - get
  - list
  - watch
- apiGroups:
  - ""
  resources:
  - services
  verbs:
  - create
  - get
  - list
  - update
  - watch
- apiGroups:
  - networking.istio.io
  resources:
  - virtualservices
  verbs:
  - create
  - get
  - list
  - update
  - watch
- apiGroups:
  - tensorboard.kubeflow.org
  resources:
  - tensorboards
  verbs:
  - create
  - delete
  - get
  - list
  - patch
  - update
  - watch
- apiGroups:
  - tensorboard.kubeflow.org
  resources:
  - tensorboards/finalizers
  verbs:
  - update
- apiGroups:
  - tensorboard.kubeflow.org
  resources:
  - tensorboards/status
  verbs:
  - get
  - patch
  - update
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool]
}

resource "kubectl_manifest" "kubeflow-tensorboard-controller-clusterrole-tensorboard-controller-metrics-reader" {
  yaml_body = <<YAML
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  labels:
    app: tensorboard-controller
    kustomize.component: tensorboard-controller
  name: tensorboard-controller-metrics-reader
rules:
- nonResourceURLs:
  - /metrics
  verbs:
  - get
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool]
}

resource "kubectl_manifest" "kubeflow-tensorboard-controller-clusterrole-tensorboard-controller-proxy-role" {
  yaml_body = <<YAML
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  labels:
    app: tensorboard-controller
    kustomize.component: tensorboard-controller
  name: tensorboard-controller-proxy-role
rules:
- apiGroups:
  - authentication.k8s.io
  resources:
  - tokenreviews
  verbs:
  - create
- apiGroups:
  - authorization.k8s.io
  resources:
  - subjectaccessreviews
  verbs:
  - create
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool]
}

resource "kubectl_manifest" "kubeflow-tensorboard-controller-rolebinding-tensorboard-controller-leader-election-rolebinding" {
  yaml_body = <<YAML
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  labels:
    app: tensorboard-controller
    kustomize.component: tensorboard-controller
  name: tensorboard-controller-leader-election-rolebinding
  namespace: kubeflow
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: Role
  name: tensorboard-controller-leader-election-role
subjects:
- kind: ServiceAccount
  name: tensorboard-controller-controller-manager
  namespace: kubeflow
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool, kubectl_manifest.kubeflow-kubeflow-namespace]
}

resource "kubectl_manifest" "kubeflow-tensorboard-controller-clusterrolebinding-tensorboard-controller-manager-rolebinding" {
  yaml_body = <<YAML
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  labels:
    app: tensorboard-controller
    kustomize.component: tensorboard-controller
  name: tensorboard-controller-manager-rolebinding
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: tensorboard-controller-manager-role
subjects:
- kind: ServiceAccount
  name: tensorboard-controller-controller-manager
  namespace: kubeflow
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool, kubectl_manifest.kubeflow-kubeflow-namespace]
}

resource "kubectl_manifest" "kubeflow-tensorboard-controller-clusterrolebinding-tensorboard-controller-proxy-rolebinding" {
  yaml_body = <<YAML
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  labels:
    app: tensorboard-controller
    kustomize.component: tensorboard-controller
  name: tensorboard-controller-proxy-rolebinding
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: tensorboard-controller-proxy-role
subjects:
- kind: ServiceAccount
  name: tensorboard-controller-controller-manager
  namespace: kubeflow
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool, kubectl_manifest.kubeflow-kubeflow-namespace]
}

resource "kubectl_manifest" "kubeflow-tensorboard-controller-configmap-tensorboard-controller-config" {
  yaml_body = <<YAML
apiVersion: v1
data:
  ISTIO_GATEWAY: kubeflow/kubeflow-gateway
  RWO_PVC_SCHEDULING: "True"
  TENSORBOARD_IMAGE: tensorflow/tensorflow:2.5.1
kind: ConfigMap
metadata:
  name: tensorboard-controller-config-b98cb9gk9k
  namespace: kubeflow
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool, kubectl_manifest.kubeflow-kubeflow-namespace, kubectl_manifest.kubeflow-istio-deployment-istiod, kubectl_manifest.kubeflow-istio-mutatingwebhookconfiguration-sidecar-injector]
}

resource "kubectl_manifest" "kubeflow-tensorboard-controller-service-tensorboard-controller-controller-manager-metrics-service" {
  yaml_body = <<YAML
apiVersion: v1
kind: Service
metadata:
  labels:
    app: tensorboard-controller
    control-plane: controller-manager
    kustomize.component: tensorboard-controller
  name: tensorboard-controller-controller-manager-metrics-service
  namespace: kubeflow
spec:
  ports:
  - name: https
    port: 8443
    protocol: TCP
    targetPort: https
  selector:
    app: tensorboard-controller
    control-plane: controller-manager
    kustomize.component: tensorboard-controller
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool, kubectl_manifest.kubeflow-kubeflow-namespace]
}

resource "kubectl_manifest" "kubeflow-tensorboard-controller-deployment-tensorboard-controller-deployment" {
  yaml_body = <<YAML
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: tensorboard-controller
    control-plane: controller-manager
    kustomize.component: tensorboard-controller
  name: tensorboard-controller-deployment
  namespace: kubeflow
spec:
  replicas: 1
  selector:
    matchLabels:
      app: tensorboard-controller
      control-plane: controller-manager
      kustomize.component: tensorboard-controller
  template:
    metadata:
      annotations:
        kubectl.kubernetes.io/default-container: manager
      labels:
        app: tensorboard-controller
        control-plane: controller-manager
        kustomize.component: tensorboard-controller
    spec:
      containers:
      - args:
        - --health-probe-bind-address=:8081
        - --metrics-bind-address=127.0.0.1:8080
        command:
        - /manager
        envFrom:
        - configMapRef:
            name: tensorboard-controller-config-b98cb9gk9k
        image: docker.io/kubeflownotebookswg/tensorboard-controller:v1.7.0
        livenessProbe:
          httpGet:
            path: /healthz
            port: 8081
          initialDelaySeconds: 15
          periodSeconds: 20
        name: manager
        readinessProbe:
          httpGet:
            path: /readyz
            port: 8081
          initialDelaySeconds: 5
          periodSeconds: 10
        resources:
          limits:
            cpu: 500m
            memory: 128Mi
          requests:
            cpu: 10m
            memory: 64Mi
        securityContext:
          allowPrivilegeEscalation: false
      - args:
        - --secure-listen-address=0.0.0.0:8443
        - --upstream=http://127.0.0.1:8080/
        - --logtostderr=true
        - --v=0
        image: gcr.io/kubebuilder/kube-rbac-proxy:v0.8.0
        name: kube-rbac-proxy
        ports:
        - containerPort: 8443
          name: https
          protocol: TCP
        resources:
          limits:
            cpu: 500m
            memory: 128Mi
          requests:
            cpu: 5m
            memory: 64Mi
      securityContext:
        runAsNonRoot: true
        runAsUser: 999
      serviceAccountName: tensorboard-controller-controller-manager
      terminationGracePeriodSeconds: 10
      tolerations:
      - key: "kubeflow"
        operator: "Equal"
        value: "control-plane"
        effect: "NoSchedule"
      nodeSelector:
        kubeflow: control-plane
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool, kubectl_manifest.kubeflow-kubeflow-namespace, kubectl_manifest.kubeflow-tensorboard-controller-configmap-tensorboard-controller-config, kubectl_manifest.kubeflow-istio-deployment-istiod, kubectl_manifest.kubeflow-istio-mutatingwebhookconfiguration-sidecar-injector]
}