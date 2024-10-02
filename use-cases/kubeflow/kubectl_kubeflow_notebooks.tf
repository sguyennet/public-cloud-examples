resource "kubectl_manifest" "kubeflow-notebooks-crd-notebooks" {
  yaml_body = <<YAML
apiVersion: apiextensions.k8s.io/v1
kind: CustomResourceDefinition
metadata:
  annotations:
    controller-gen.kubebuilder.io/version: v0.8.0
  creationTimestamp: null
  labels:
    app: notebook-controller
    kustomize.component: notebook-controller
  name: notebooks.kubeflow.org
spec:
  conversion:
    strategy: None
  group: kubeflow.org
  names:
    kind: Notebook
    listKind: NotebookList
    plural: notebooks
    singular: notebook
  preserveUnknownFields: false
  scope: Namespaced
  versions:
  - name: v1
    schema:
      openAPIV3Schema:
        properties:
          apiVersion:
            type: string
          kind:
            type: string
          metadata:
            type: object
          spec:
            properties:
              template:
                properties:
                  spec:
                    properties:
                      activeDeadlineSeconds:
                        format: int64
                        type: integer
                      affinity:
                        properties:
                          nodeAffinity:
                            properties:
                              preferredDuringSchedulingIgnoredDuringExecution:
                                items:
                                  properties:
                                    preference:
                                      properties:
                                        matchExpressions:
                                          items:
                                            properties:
                                              key:
                                                type: string
                                              operator:
                                                type: string
                                              values:
                                                items:
                                                  type: string
                                                type: array
                                            required:
                                            - key
                                            - operator
                                            type: object
                                          type: array
                                        matchFields:
                                          items:
                                            properties:
                                              key:
                                                type: string
                                              operator:
                                                type: string
                                              values:
                                                items:
                                                  type: string
                                                type: array
                                            required:
                                            - key
                                            - operator
                                            type: object
                                          type: array
                                      type: object
                                    weight:
                                      format: int32
                                      type: integer
                                  required:
                                  - preference
                                  - weight
                                  type: object
                                type: array
                              requiredDuringSchedulingIgnoredDuringExecution:
                                properties:
                                  nodeSelectorTerms:
                                    items:
                                      properties:
                                        matchExpressions:
                                          items:
                                            properties:
                                              key:
                                                type: string
                                              operator:
                                                type: string
                                              values:
                                                items:
                                                  type: string
                                                type: array
                                            required:
                                            - key
                                            - operator
                                            type: object
                                          type: array
                                        matchFields:
                                          items:
                                            properties:
                                              key:
                                                type: string
                                              operator:
                                                type: string
                                              values:
                                                items:
                                                  type: string
                                                type: array
                                            required:
                                            - key
                                            - operator
                                            type: object
                                          type: array
                                      type: object
                                    type: array
                                required:
                                - nodeSelectorTerms
                                type: object
                            type: object
                          podAffinity:
                            properties:
                              preferredDuringSchedulingIgnoredDuringExecution:
                                items:
                                  properties:
                                    podAffinityTerm:
                                      properties:
                                        labelSelector:
                                          properties:
                                            matchExpressions:
                                              items:
                                                properties:
                                                  key:
                                                    type: string
                                                  operator:
                                                    type: string
                                                  values:
                                                    items:
                                                      type: string
                                                    type: array
                                                required:
                                                - key
                                                - operator
                                                type: object
                                              type: array
                                            matchLabels:
                                              additionalProperties:
                                                type: string
                                              type: object
                                          type: object
                                        namespaceSelector:
                                          properties:
                                            matchExpressions:
                                              items:
                                                properties:
                                                  key:
                                                    type: string
                                                  operator:
                                                    type: string
                                                  values:
                                                    items:
                                                      type: string
                                                    type: array
                                                required:
                                                - key
                                                - operator
                                                type: object
                                              type: array
                                            matchLabels:
                                              additionalProperties:
                                                type: string
                                              type: object
                                          type: object
                                        namespaces:
                                          items:
                                            type: string
                                          type: array
                                        topologyKey:
                                          type: string
                                      required:
                                      - topologyKey
                                      type: object
                                    weight:
                                      format: int32
                                      type: integer
                                  required:
                                  - podAffinityTerm
                                  - weight
                                  type: object
                                type: array
                              requiredDuringSchedulingIgnoredDuringExecution:
                                items:
                                  properties:
                                    labelSelector:
                                      properties:
                                        matchExpressions:
                                          items:
                                            properties:
                                              key:
                                                type: string
                                              operator:
                                                type: string
                                              values:
                                                items:
                                                  type: string
                                                type: array
                                            required:
                                            - key
                                            - operator
                                            type: object
                                          type: array
                                        matchLabels:
                                          additionalProperties:
                                            type: string
                                          type: object
                                      type: object
                                    namespaceSelector:
                                      properties:
                                        matchExpressions:
                                          items:
                                            properties:
                                              key:
                                                type: string
                                              operator:
                                                type: string
                                              values:
                                                items:
                                                  type: string
                                                type: array
                                            required:
                                            - key
                                            - operator
                                            type: object
                                          type: array
                                        matchLabels:
                                          additionalProperties:
                                            type: string
                                          type: object
                                      type: object
                                    namespaces:
                                      items:
                                        type: string
                                      type: array
                                    topologyKey:
                                      type: string
                                  required:
                                  - topologyKey
                                  type: object
                                type: array
                            type: object
                          podAntiAffinity:
                            properties:
                              preferredDuringSchedulingIgnoredDuringExecution:
                                items:
                                  properties:
                                    podAffinityTerm:
                                      properties:
                                        labelSelector:
                                          properties:
                                            matchExpressions:
                                              items:
                                                properties:
                                                  key:
                                                    type: string
                                                  operator:
                                                    type: string
                                                  values:
                                                    items:
                                                      type: string
                                                    type: array
                                                required:
                                                - key
                                                - operator
                                                type: object
                                              type: array
                                            matchLabels:
                                              additionalProperties:
                                                type: string
                                              type: object
                                          type: object
                                        namespaceSelector:
                                          properties:
                                            matchExpressions:
                                              items:
                                                properties:
                                                  key:
                                                    type: string
                                                  operator:
                                                    type: string
                                                  values:
                                                    items:
                                                      type: string
                                                    type: array
                                                required:
                                                - key
                                                - operator
                                                type: object
                                              type: array
                                            matchLabels:
                                              additionalProperties:
                                                type: string
                                              type: object
                                          type: object
                                        namespaces:
                                          items:
                                            type: string
                                          type: array
                                        topologyKey:
                                          type: string
                                      required:
                                      - topologyKey
                                      type: object
                                    weight:
                                      format: int32
                                      type: integer
                                  required:
                                  - podAffinityTerm
                                  - weight
                                  type: object
                                type: array
                              requiredDuringSchedulingIgnoredDuringExecution:
                                items:
                                  properties:
                                    labelSelector:
                                      properties:
                                        matchExpressions:
                                          items:
                                            properties:
                                              key:
                                                type: string
                                              operator:
                                                type: string
                                              values:
                                                items:
                                                  type: string
                                                type: array
                                            required:
                                            - key
                                            - operator
                                            type: object
                                          type: array
                                        matchLabels:
                                          additionalProperties:
                                            type: string
                                          type: object
                                      type: object
                                    namespaceSelector:
                                      properties:
                                        matchExpressions:
                                          items:
                                            properties:
                                              key:
                                                type: string
                                              operator:
                                                type: string
                                              values:
                                                items:
                                                  type: string
                                                type: array
                                            required:
                                            - key
                                            - operator
                                            type: object
                                          type: array
                                        matchLabels:
                                          additionalProperties:
                                            type: string
                                          type: object
                                      type: object
                                    namespaces:
                                      items:
                                        type: string
                                      type: array
                                    topologyKey:
                                      type: string
                                  required:
                                  - topologyKey
                                  type: object
                                type: array
                            type: object
                        type: object
                      automountServiceAccountToken:
                        type: boolean
                      containers:
                        items:
                          properties:
                            args:
                              items:
                                type: string
                              type: array
                            command:
                              items:
                                type: string
                              type: array
                            env:
                              items:
                                properties:
                                  name:
                                    type: string
                                  value:
                                    type: string
                                  valueFrom:
                                    properties:
                                      configMapKeyRef:
                                        properties:
                                          key:
                                            type: string
                                          name:
                                            type: string
                                          optional:
                                            type: boolean
                                        required:
                                        - key
                                        type: object
                                      fieldRef:
                                        properties:
                                          apiVersion:
                                            type: string
                                          fieldPath:
                                            type: string
                                        required:
                                        - fieldPath
                                        type: object
                                      resourceFieldRef:
                                        properties:
                                          containerName:
                                            type: string
                                          divisor:
                                            anyOf:
                                            - type: integer
                                            - type: string
                                            pattern: ^(\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))))?$
                                            x-kubernetes-int-or-string: true
                                          resource:
                                            type: string
                                        required:
                                        - resource
                                        type: object
                                      secretKeyRef:
                                        properties:
                                          key:
                                            type: string
                                          name:
                                            type: string
                                          optional:
                                            type: boolean
                                        required:
                                        - key
                                        type: object
                                    type: object
                                required:
                                - name
                                type: object
                              type: array
                            envFrom:
                              items:
                                properties:
                                  configMapRef:
                                    properties:
                                      name:
                                        type: string
                                      optional:
                                        type: boolean
                                    type: object
                                  prefix:
                                    type: string
                                  secretRef:
                                    properties:
                                      name:
                                        type: string
                                      optional:
                                        type: boolean
                                    type: object
                                type: object
                              type: array
                            image:
                              type: string
                            imagePullPolicy:
                              type: string
                            lifecycle:
                              properties:
                                postStart:
                                  properties:
                                    exec:
                                      properties:
                                        command:
                                          items:
                                            type: string
                                          type: array
                                      type: object
                                    httpGet:
                                      properties:
                                        host:
                                          type: string
                                        httpHeaders:
                                          items:
                                            properties:
                                              name:
                                                type: string
                                              value:
                                                type: string
                                            required:
                                            - name
                                            - value
                                            type: object
                                          type: array
                                        path:
                                          type: string
                                        port:
                                          anyOf:
                                          - type: integer
                                          - type: string
                                          x-kubernetes-int-or-string: true
                                        scheme:
                                          type: string
                                      required:
                                      - port
                                      type: object
                                    tcpSocket:
                                      properties:
                                        host:
                                          type: string
                                        port:
                                          anyOf:
                                          - type: integer
                                          - type: string
                                          x-kubernetes-int-or-string: true
                                      required:
                                      - port
                                      type: object
                                  type: object
                                preStop:
                                  properties:
                                    exec:
                                      properties:
                                        command:
                                          items:
                                            type: string
                                          type: array
                                      type: object
                                    httpGet:
                                      properties:
                                        host:
                                          type: string
                                        httpHeaders:
                                          items:
                                            properties:
                                              name:
                                                type: string
                                              value:
                                                type: string
                                            required:
                                            - name
                                            - value
                                            type: object
                                          type: array
                                        path:
                                          type: string
                                        port:
                                          anyOf:
                                          - type: integer
                                          - type: string
                                          x-kubernetes-int-or-string: true
                                        scheme:
                                          type: string
                                      required:
                                      - port
                                      type: object
                                    tcpSocket:
                                      properties:
                                        host:
                                          type: string
                                        port:
                                          anyOf:
                                          - type: integer
                                          - type: string
                                          x-kubernetes-int-or-string: true
                                      required:
                                      - port
                                      type: object
                                  type: object
                              type: object
                            livenessProbe:
                              properties:
                                exec:
                                  properties:
                                    command:
                                      items:
                                        type: string
                                      type: array
                                  type: object
                                failureThreshold:
                                  format: int32
                                  type: integer
                                grpc:
                                  properties:
                                    port:
                                      format: int32
                                      type: integer
                                    service:
                                      type: string
                                  required:
                                  - port
                                  type: object
                                httpGet:
                                  properties:
                                    host:
                                      type: string
                                    httpHeaders:
                                      items:
                                        properties:
                                          name:
                                            type: string
                                          value:
                                            type: string
                                        required:
                                        - name
                                        - value
                                        type: object
                                      type: array
                                    path:
                                      type: string
                                    port:
                                      anyOf:
                                      - type: integer
                                      - type: string
                                      x-kubernetes-int-or-string: true
                                    scheme:
                                      type: string
                                  required:
                                  - port
                                  type: object
                                initialDelaySeconds:
                                  format: int32
                                  type: integer
                                periodSeconds:
                                  format: int32
                                  type: integer
                                successThreshold:
                                  format: int32
                                  type: integer
                                tcpSocket:
                                  properties:
                                    host:
                                      type: string
                                    port:
                                      anyOf:
                                      - type: integer
                                      - type: string
                                      x-kubernetes-int-or-string: true
                                  required:
                                  - port
                                  type: object
                                terminationGracePeriodSeconds:
                                  format: int64
                                  type: integer
                                timeoutSeconds:
                                  format: int32
                                  type: integer
                              type: object
                            name:
                              type: string
                            ports:
                              items:
                                properties:
                                  containerPort:
                                    format: int32
                                    type: integer
                                  hostIP:
                                    type: string
                                  hostPort:
                                    format: int32
                                    type: integer
                                  name:
                                    type: string
                                  protocol:
                                    default: TCP
                                    type: string
                                required:
                                - containerPort
                                type: object
                              type: array
                              x-kubernetes-list-map-keys:
                              - containerPort
                              - protocol
                              x-kubernetes-list-type: map
                            readinessProbe:
                              properties:
                                exec:
                                  properties:
                                    command:
                                      items:
                                        type: string
                                      type: array
                                  type: object
                                failureThreshold:
                                  format: int32
                                  type: integer
                                grpc:
                                  properties:
                                    port:
                                      format: int32
                                      type: integer
                                    service:
                                      type: string
                                  required:
                                  - port
                                  type: object
                                httpGet:
                                  properties:
                                    host:
                                      type: string
                                    httpHeaders:
                                      items:
                                        properties:
                                          name:
                                            type: string
                                          value:
                                            type: string
                                        required:
                                        - name
                                        - value
                                        type: object
                                      type: array
                                    path:
                                      type: string
                                    port:
                                      anyOf:
                                      - type: integer
                                      - type: string
                                      x-kubernetes-int-or-string: true
                                    scheme:
                                      type: string
                                  required:
                                  - port
                                  type: object
                                initialDelaySeconds:
                                  format: int32
                                  type: integer
                                periodSeconds:
                                  format: int32
                                  type: integer
                                successThreshold:
                                  format: int32
                                  type: integer
                                tcpSocket:
                                  properties:
                                    host:
                                      type: string
                                    port:
                                      anyOf:
                                      - type: integer
                                      - type: string
                                      x-kubernetes-int-or-string: true
                                  required:
                                  - port
                                  type: object
                                terminationGracePeriodSeconds:
                                  format: int64
                                  type: integer
                                timeoutSeconds:
                                  format: int32
                                  type: integer
                              type: object
                            resources:
                              properties:
                                limits:
                                  additionalProperties:
                                    anyOf:
                                    - type: integer
                                    - type: string
                                    pattern: ^(\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))))?$
                                    x-kubernetes-int-or-string: true
                                  type: object
                                requests:
                                  additionalProperties:
                                    anyOf:
                                    - type: integer
                                    - type: string
                                    pattern: ^(\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))))?$
                                    x-kubernetes-int-or-string: true
                                  type: object
                              type: object
                            securityContext:
                              properties:
                                allowPrivilegeEscalation:
                                  type: boolean
                                capabilities:
                                  properties:
                                    add:
                                      items:
                                        type: string
                                      type: array
                                    drop:
                                      items:
                                        type: string
                                      type: array
                                  type: object
                                privileged:
                                  type: boolean
                                procMount:
                                  type: string
                                readOnlyRootFilesystem:
                                  type: boolean
                                runAsGroup:
                                  format: int64
                                  type: integer
                                runAsNonRoot:
                                  type: boolean
                                runAsUser:
                                  format: int64
                                  type: integer
                                seLinuxOptions:
                                  properties:
                                    level:
                                      type: string
                                    role:
                                      type: string
                                    type:
                                      type: string
                                    user:
                                      type: string
                                  type: object
                                seccompProfile:
                                  properties:
                                    localhostProfile:
                                      type: string
                                    type:
                                      type: string
                                  required:
                                  - type
                                  type: object
                                windowsOptions:
                                  properties:
                                    gmsaCredentialSpec:
                                      type: string
                                    gmsaCredentialSpecName:
                                      type: string
                                    hostProcess:
                                      type: boolean
                                    runAsUserName:
                                      type: string
                                  type: object
                              type: object
                            startupProbe:
                              properties:
                                exec:
                                  properties:
                                    command:
                                      items:
                                        type: string
                                      type: array
                                  type: object
                                failureThreshold:
                                  format: int32
                                  type: integer
                                grpc:
                                  properties:
                                    port:
                                      format: int32
                                      type: integer
                                    service:
                                      type: string
                                  required:
                                  - port
                                  type: object
                                httpGet:
                                  properties:
                                    host:
                                      type: string
                                    httpHeaders:
                                      items:
                                        properties:
                                          name:
                                            type: string
                                          value:
                                            type: string
                                        required:
                                        - name
                                        - value
                                        type: object
                                      type: array
                                    path:
                                      type: string
                                    port:
                                      anyOf:
                                      - type: integer
                                      - type: string
                                      x-kubernetes-int-or-string: true
                                    scheme:
                                      type: string
                                  required:
                                  - port
                                  type: object
                                initialDelaySeconds:
                                  format: int32
                                  type: integer
                                periodSeconds:
                                  format: int32
                                  type: integer
                                successThreshold:
                                  format: int32
                                  type: integer
                                tcpSocket:
                                  properties:
                                    host:
                                      type: string
                                    port:
                                      anyOf:
                                      - type: integer
                                      - type: string
                                      x-kubernetes-int-or-string: true
                                  required:
                                  - port
                                  type: object
                                terminationGracePeriodSeconds:
                                  format: int64
                                  type: integer
                                timeoutSeconds:
                                  format: int32
                                  type: integer
                              type: object
                            stdin:
                              type: boolean
                            stdinOnce:
                              type: boolean
                            terminationMessagePath:
                              type: string
                            terminationMessagePolicy:
                              type: string
                            tty:
                              type: boolean
                            volumeDevices:
                              items:
                                properties:
                                  devicePath:
                                    type: string
                                  name:
                                    type: string
                                required:
                                - devicePath
                                - name
                                type: object
                              type: array
                            volumeMounts:
                              items:
                                properties:
                                  mountPath:
                                    type: string
                                  mountPropagation:
                                    type: string
                                  name:
                                    type: string
                                  readOnly:
                                    type: boolean
                                  subPath:
                                    type: string
                                  subPathExpr:
                                    type: string
                                required:
                                - mountPath
                                - name
                                type: object
                              type: array
                            workingDir:
                              type: string
                          required:
                          - name
                          type: object
                        type: array
                      dnsConfig:
                        properties:
                          nameservers:
                            items:
                              type: string
                            type: array
                          options:
                            items:
                              properties:
                                name:
                                  type: string
                                value:
                                  type: string
                              type: object
                            type: array
                          searches:
                            items:
                              type: string
                            type: array
                        type: object
                      dnsPolicy:
                        type: string
                      enableServiceLinks:
                        type: boolean
                      ephemeralContainers:
                        items:
                          properties:
                            args:
                              items:
                                type: string
                              type: array
                            command:
                              items:
                                type: string
                              type: array
                            env:
                              items:
                                properties:
                                  name:
                                    type: string
                                  value:
                                    type: string
                                  valueFrom:
                                    properties:
                                      configMapKeyRef:
                                        properties:
                                          key:
                                            type: string
                                          name:
                                            type: string
                                          optional:
                                            type: boolean
                                        required:
                                        - key
                                        type: object
                                      fieldRef:
                                        properties:
                                          apiVersion:
                                            type: string
                                          fieldPath:
                                            type: string
                                        required:
                                        - fieldPath
                                        type: object
                                      resourceFieldRef:
                                        properties:
                                          containerName:
                                            type: string
                                          divisor:
                                            anyOf:
                                            - type: integer
                                            - type: string
                                            pattern: ^(\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))))?$
                                            x-kubernetes-int-or-string: true
                                          resource:
                                            type: string
                                        required:
                                        - resource
                                        type: object
                                      secretKeyRef:
                                        properties:
                                          key:
                                            type: string
                                          name:
                                            type: string
                                          optional:
                                            type: boolean
                                        required:
                                        - key
                                        type: object
                                    type: object
                                required:
                                - name
                                type: object
                              type: array
                            envFrom:
                              items:
                                properties:
                                  configMapRef:
                                    properties:
                                      name:
                                        type: string
                                      optional:
                                        type: boolean
                                    type: object
                                  prefix:
                                    type: string
                                  secretRef:
                                    properties:
                                      name:
                                        type: string
                                      optional:
                                        type: boolean
                                    type: object
                                type: object
                              type: array
                            image:
                              type: string
                            imagePullPolicy:
                              type: string
                            lifecycle:
                              properties:
                                postStart:
                                  properties:
                                    exec:
                                      properties:
                                        command:
                                          items:
                                            type: string
                                          type: array
                                      type: object
                                    httpGet:
                                      properties:
                                        host:
                                          type: string
                                        httpHeaders:
                                          items:
                                            properties:
                                              name:
                                                type: string
                                              value:
                                                type: string
                                            required:
                                            - name
                                            - value
                                            type: object
                                          type: array
                                        path:
                                          type: string
                                        port:
                                          anyOf:
                                          - type: integer
                                          - type: string
                                          x-kubernetes-int-or-string: true
                                        scheme:
                                          type: string
                                      required:
                                      - port
                                      type: object
                                    tcpSocket:
                                      properties:
                                        host:
                                          type: string
                                        port:
                                          anyOf:
                                          - type: integer
                                          - type: string
                                          x-kubernetes-int-or-string: true
                                      required:
                                      - port
                                      type: object
                                  type: object
                                preStop:
                                  properties:
                                    exec:
                                      properties:
                                        command:
                                          items:
                                            type: string
                                          type: array
                                      type: object
                                    httpGet:
                                      properties:
                                        host:
                                          type: string
                                        httpHeaders:
                                          items:
                                            properties:
                                              name:
                                                type: string
                                              value:
                                                type: string
                                            required:
                                            - name
                                            - value
                                            type: object
                                          type: array
                                        path:
                                          type: string
                                        port:
                                          anyOf:
                                          - type: integer
                                          - type: string
                                          x-kubernetes-int-or-string: true
                                        scheme:
                                          type: string
                                      required:
                                      - port
                                      type: object
                                    tcpSocket:
                                      properties:
                                        host:
                                          type: string
                                        port:
                                          anyOf:
                                          - type: integer
                                          - type: string
                                          x-kubernetes-int-or-string: true
                                      required:
                                      - port
                                      type: object
                                  type: object
                              type: object
                            livenessProbe:
                              properties:
                                exec:
                                  properties:
                                    command:
                                      items:
                                        type: string
                                      type: array
                                  type: object
                                failureThreshold:
                                  format: int32
                                  type: integer
                                grpc:
                                  properties:
                                    port:
                                      format: int32
                                      type: integer
                                    service:
                                      type: string
                                  required:
                                  - port
                                  type: object
                                httpGet:
                                  properties:
                                    host:
                                      type: string
                                    httpHeaders:
                                      items:
                                        properties:
                                          name:
                                            type: string
                                          value:
                                            type: string
                                        required:
                                        - name
                                        - value
                                        type: object
                                      type: array
                                    path:
                                      type: string
                                    port:
                                      anyOf:
                                      - type: integer
                                      - type: string
                                      x-kubernetes-int-or-string: true
                                    scheme:
                                      type: string
                                  required:
                                  - port
                                  type: object
                                initialDelaySeconds:
                                  format: int32
                                  type: integer
                                periodSeconds:
                                  format: int32
                                  type: integer
                                successThreshold:
                                  format: int32
                                  type: integer
                                tcpSocket:
                                  properties:
                                    host:
                                      type: string
                                    port:
                                      anyOf:
                                      - type: integer
                                      - type: string
                                      x-kubernetes-int-or-string: true
                                  required:
                                  - port
                                  type: object
                                terminationGracePeriodSeconds:
                                  format: int64
                                  type: integer
                                timeoutSeconds:
                                  format: int32
                                  type: integer
                              type: object
                            name:
                              type: string
                            ports:
                              items:
                                properties:
                                  containerPort:
                                    format: int32
                                    type: integer
                                  hostIP:
                                    type: string
                                  hostPort:
                                    format: int32
                                    type: integer
                                  name:
                                    type: string
                                  protocol:
                                    default: TCP
                                    type: string
                                required:
                                - containerPort
                                type: object
                              type: array
                              x-kubernetes-list-map-keys:
                              - containerPort
                              - protocol
                              x-kubernetes-list-type: map
                            readinessProbe:
                              properties:
                                exec:
                                  properties:
                                    command:
                                      items:
                                        type: string
                                      type: array
                                  type: object
                                failureThreshold:
                                  format: int32
                                  type: integer
                                grpc:
                                  properties:
                                    port:
                                      format: int32
                                      type: integer
                                    service:
                                      type: string
                                  required:
                                  - port
                                  type: object
                                httpGet:
                                  properties:
                                    host:
                                      type: string
                                    httpHeaders:
                                      items:
                                        properties:
                                          name:
                                            type: string
                                          value:
                                            type: string
                                        required:
                                        - name
                                        - value
                                        type: object
                                      type: array
                                    path:
                                      type: string
                                    port:
                                      anyOf:
                                      - type: integer
                                      - type: string
                                      x-kubernetes-int-or-string: true
                                    scheme:
                                      type: string
                                  required:
                                  - port
                                  type: object
                                initialDelaySeconds:
                                  format: int32
                                  type: integer
                                periodSeconds:
                                  format: int32
                                  type: integer
                                successThreshold:
                                  format: int32
                                  type: integer
                                tcpSocket:
                                  properties:
                                    host:
                                      type: string
                                    port:
                                      anyOf:
                                      - type: integer
                                      - type: string
                                      x-kubernetes-int-or-string: true
                                  required:
                                  - port
                                  type: object
                                terminationGracePeriodSeconds:
                                  format: int64
                                  type: integer
                                timeoutSeconds:
                                  format: int32
                                  type: integer
                              type: object
                            resources:
                              properties:
                                limits:
                                  additionalProperties:
                                    anyOf:
                                    - type: integer
                                    - type: string
                                    pattern: ^(\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))))?$
                                    x-kubernetes-int-or-string: true
                                  type: object
                                requests:
                                  additionalProperties:
                                    anyOf:
                                    - type: integer
                                    - type: string
                                    pattern: ^(\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))))?$
                                    x-kubernetes-int-or-string: true
                                  type: object
                              type: object
                            securityContext:
                              properties:
                                allowPrivilegeEscalation:
                                  type: boolean
                                capabilities:
                                  properties:
                                    add:
                                      items:
                                        type: string
                                      type: array
                                    drop:
                                      items:
                                        type: string
                                      type: array
                                  type: object
                                privileged:
                                  type: boolean
                                procMount:
                                  type: string
                                readOnlyRootFilesystem:
                                  type: boolean
                                runAsGroup:
                                  format: int64
                                  type: integer
                                runAsNonRoot:
                                  type: boolean
                                runAsUser:
                                  format: int64
                                  type: integer
                                seLinuxOptions:
                                  properties:
                                    level:
                                      type: string
                                    role:
                                      type: string
                                    type:
                                      type: string
                                    user:
                                      type: string
                                  type: object
                                seccompProfile:
                                  properties:
                                    localhostProfile:
                                      type: string
                                    type:
                                      type: string
                                  required:
                                  - type
                                  type: object
                                windowsOptions:
                                  properties:
                                    gmsaCredentialSpec:
                                      type: string
                                    gmsaCredentialSpecName:
                                      type: string
                                    hostProcess:
                                      type: boolean
                                    runAsUserName:
                                      type: string
                                  type: object
                              type: object
                            startupProbe:
                              properties:
                                exec:
                                  properties:
                                    command:
                                      items:
                                        type: string
                                      type: array
                                  type: object
                                failureThreshold:
                                  format: int32
                                  type: integer
                                grpc:
                                  properties:
                                    port:
                                      format: int32
                                      type: integer
                                    service:
                                      type: string
                                  required:
                                  - port
                                  type: object
                                httpGet:
                                  properties:
                                    host:
                                      type: string
                                    httpHeaders:
                                      items:
                                        properties:
                                          name:
                                            type: string
                                          value:
                                            type: string
                                        required:
                                        - name
                                        - value
                                        type: object
                                      type: array
                                    path:
                                      type: string
                                    port:
                                      anyOf:
                                      - type: integer
                                      - type: string
                                      x-kubernetes-int-or-string: true
                                    scheme:
                                      type: string
                                  required:
                                  - port
                                  type: object
                                initialDelaySeconds:
                                  format: int32
                                  type: integer
                                periodSeconds:
                                  format: int32
                                  type: integer
                                successThreshold:
                                  format: int32
                                  type: integer
                                tcpSocket:
                                  properties:
                                    host:
                                      type: string
                                    port:
                                      anyOf:
                                      - type: integer
                                      - type: string
                                      x-kubernetes-int-or-string: true
                                  required:
                                  - port
                                  type: object
                                terminationGracePeriodSeconds:
                                  format: int64
                                  type: integer
                                timeoutSeconds:
                                  format: int32
                                  type: integer
                              type: object
                            stdin:
                              type: boolean
                            stdinOnce:
                              type: boolean
                            targetContainerName:
                              type: string
                            terminationMessagePath:
                              type: string
                            terminationMessagePolicy:
                              type: string
                            tty:
                              type: boolean
                            volumeDevices:
                              items:
                                properties:
                                  devicePath:
                                    type: string
                                  name:
                                    type: string
                                required:
                                - devicePath
                                - name
                                type: object
                              type: array
                            volumeMounts:
                              items:
                                properties:
                                  mountPath:
                                    type: string
                                  mountPropagation:
                                    type: string
                                  name:
                                    type: string
                                  readOnly:
                                    type: boolean
                                  subPath:
                                    type: string
                                  subPathExpr:
                                    type: string
                                required:
                                - mountPath
                                - name
                                type: object
                              type: array
                            workingDir:
                              type: string
                          required:
                          - name
                          type: object
                        type: array
                      hostAliases:
                        items:
                          properties:
                            hostnames:
                              items:
                                type: string
                              type: array
                            ip:
                              type: string
                          type: object
                        type: array
                      hostIPC:
                        type: boolean
                      hostNetwork:
                        type: boolean
                      hostPID:
                        type: boolean
                      hostname:
                        type: string
                      imagePullSecrets:
                        items:
                          properties:
                            name:
                              type: string
                          type: object
                        type: array
                      initContainers:
                        items:
                          properties:
                            args:
                              items:
                                type: string
                              type: array
                            command:
                              items:
                                type: string
                              type: array
                            env:
                              items:
                                properties:
                                  name:
                                    type: string
                                  value:
                                    type: string
                                  valueFrom:
                                    properties:
                                      configMapKeyRef:
                                        properties:
                                          key:
                                            type: string
                                          name:
                                            type: string
                                          optional:
                                            type: boolean
                                        required:
                                        - key
                                        type: object
                                      fieldRef:
                                        properties:
                                          apiVersion:
                                            type: string
                                          fieldPath:
                                            type: string
                                        required:
                                        - fieldPath
                                        type: object
                                      resourceFieldRef:
                                        properties:
                                          containerName:
                                            type: string
                                          divisor:
                                            anyOf:
                                            - type: integer
                                            - type: string
                                            pattern: ^(\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))))?$
                                            x-kubernetes-int-or-string: true
                                          resource:
                                            type: string
                                        required:
                                        - resource
                                        type: object
                                      secretKeyRef:
                                        properties:
                                          key:
                                            type: string
                                          name:
                                            type: string
                                          optional:
                                            type: boolean
                                        required:
                                        - key
                                        type: object
                                    type: object
                                required:
                                - name
                                type: object
                              type: array
                            envFrom:
                              items:
                                properties:
                                  configMapRef:
                                    properties:
                                      name:
                                        type: string
                                      optional:
                                        type: boolean
                                    type: object
                                  prefix:
                                    type: string
                                  secretRef:
                                    properties:
                                      name:
                                        type: string
                                      optional:
                                        type: boolean
                                    type: object
                                type: object
                              type: array
                            image:
                              type: string
                            imagePullPolicy:
                              type: string
                            lifecycle:
                              properties:
                                postStart:
                                  properties:
                                    exec:
                                      properties:
                                        command:
                                          items:
                                            type: string
                                          type: array
                                      type: object
                                    httpGet:
                                      properties:
                                        host:
                                          type: string
                                        httpHeaders:
                                          items:
                                            properties:
                                              name:
                                                type: string
                                              value:
                                                type: string
                                            required:
                                            - name
                                            - value
                                            type: object
                                          type: array
                                        path:
                                          type: string
                                        port:
                                          anyOf:
                                          - type: integer
                                          - type: string
                                          x-kubernetes-int-or-string: true
                                        scheme:
                                          type: string
                                      required:
                                      - port
                                      type: object
                                    tcpSocket:
                                      properties:
                                        host:
                                          type: string
                                        port:
                                          anyOf:
                                          - type: integer
                                          - type: string
                                          x-kubernetes-int-or-string: true
                                      required:
                                      - port
                                      type: object
                                  type: object
                                preStop:
                                  properties:
                                    exec:
                                      properties:
                                        command:
                                          items:
                                            type: string
                                          type: array
                                      type: object
                                    httpGet:
                                      properties:
                                        host:
                                          type: string
                                        httpHeaders:
                                          items:
                                            properties:
                                              name:
                                                type: string
                                              value:
                                                type: string
                                            required:
                                            - name
                                            - value
                                            type: object
                                          type: array
                                        path:
                                          type: string
                                        port:
                                          anyOf:
                                          - type: integer
                                          - type: string
                                          x-kubernetes-int-or-string: true
                                        scheme:
                                          type: string
                                      required:
                                      - port
                                      type: object
                                    tcpSocket:
                                      properties:
                                        host:
                                          type: string
                                        port:
                                          anyOf:
                                          - type: integer
                                          - type: string
                                          x-kubernetes-int-or-string: true
                                      required:
                                      - port
                                      type: object
                                  type: object
                              type: object
                            livenessProbe:
                              properties:
                                exec:
                                  properties:
                                    command:
                                      items:
                                        type: string
                                      type: array
                                  type: object
                                failureThreshold:
                                  format: int32
                                  type: integer
                                grpc:
                                  properties:
                                    port:
                                      format: int32
                                      type: integer
                                    service:
                                      type: string
                                  required:
                                  - port
                                  type: object
                                httpGet:
                                  properties:
                                    host:
                                      type: string
                                    httpHeaders:
                                      items:
                                        properties:
                                          name:
                                            type: string
                                          value:
                                            type: string
                                        required:
                                        - name
                                        - value
                                        type: object
                                      type: array
                                    path:
                                      type: string
                                    port:
                                      anyOf:
                                      - type: integer
                                      - type: string
                                      x-kubernetes-int-or-string: true
                                    scheme:
                                      type: string
                                  required:
                                  - port
                                  type: object
                                initialDelaySeconds:
                                  format: int32
                                  type: integer
                                periodSeconds:
                                  format: int32
                                  type: integer
                                successThreshold:
                                  format: int32
                                  type: integer
                                tcpSocket:
                                  properties:
                                    host:
                                      type: string
                                    port:
                                      anyOf:
                                      - type: integer
                                      - type: string
                                      x-kubernetes-int-or-string: true
                                  required:
                                  - port
                                  type: object
                                terminationGracePeriodSeconds:
                                  format: int64
                                  type: integer
                                timeoutSeconds:
                                  format: int32
                                  type: integer
                              type: object
                            name:
                              type: string
                            ports:
                              items:
                                properties:
                                  containerPort:
                                    format: int32
                                    type: integer
                                  hostIP:
                                    type: string
                                  hostPort:
                                    format: int32
                                    type: integer
                                  name:
                                    type: string
                                  protocol:
                                    default: TCP
                                    type: string
                                required:
                                - containerPort
                                type: object
                              type: array
                              x-kubernetes-list-map-keys:
                              - containerPort
                              - protocol
                              x-kubernetes-list-type: map
                            readinessProbe:
                              properties:
                                exec:
                                  properties:
                                    command:
                                      items:
                                        type: string
                                      type: array
                                  type: object
                                failureThreshold:
                                  format: int32
                                  type: integer
                                grpc:
                                  properties:
                                    port:
                                      format: int32
                                      type: integer
                                    service:
                                      type: string
                                  required:
                                  - port
                                  type: object
                                httpGet:
                                  properties:
                                    host:
                                      type: string
                                    httpHeaders:
                                      items:
                                        properties:
                                          name:
                                            type: string
                                          value:
                                            type: string
                                        required:
                                        - name
                                        - value
                                        type: object
                                      type: array
                                    path:
                                      type: string
                                    port:
                                      anyOf:
                                      - type: integer
                                      - type: string
                                      x-kubernetes-int-or-string: true
                                    scheme:
                                      type: string
                                  required:
                                  - port
                                  type: object
                                initialDelaySeconds:
                                  format: int32
                                  type: integer
                                periodSeconds:
                                  format: int32
                                  type: integer
                                successThreshold:
                                  format: int32
                                  type: integer
                                tcpSocket:
                                  properties:
                                    host:
                                      type: string
                                    port:
                                      anyOf:
                                      - type: integer
                                      - type: string
                                      x-kubernetes-int-or-string: true
                                  required:
                                  - port
                                  type: object
                                terminationGracePeriodSeconds:
                                  format: int64
                                  type: integer
                                timeoutSeconds:
                                  format: int32
                                  type: integer
                              type: object
                            resources:
                              properties:
                                limits:
                                  additionalProperties:
                                    anyOf:
                                    - type: integer
                                    - type: string
                                    pattern: ^(\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))))?$
                                    x-kubernetes-int-or-string: true
                                  type: object
                                requests:
                                  additionalProperties:
                                    anyOf:
                                    - type: integer
                                    - type: string
                                    pattern: ^(\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))))?$
                                    x-kubernetes-int-or-string: true
                                  type: object
                              type: object
                            securityContext:
                              properties:
                                allowPrivilegeEscalation:
                                  type: boolean
                                capabilities:
                                  properties:
                                    add:
                                      items:
                                        type: string
                                      type: array
                                    drop:
                                      items:
                                        type: string
                                      type: array
                                  type: object
                                privileged:
                                  type: boolean
                                procMount:
                                  type: string
                                readOnlyRootFilesystem:
                                  type: boolean
                                runAsGroup:
                                  format: int64
                                  type: integer
                                runAsNonRoot:
                                  type: boolean
                                runAsUser:
                                  format: int64
                                  type: integer
                                seLinuxOptions:
                                  properties:
                                    level:
                                      type: string
                                    role:
                                      type: string
                                    type:
                                      type: string
                                    user:
                                      type: string
                                  type: object
                                seccompProfile:
                                  properties:
                                    localhostProfile:
                                      type: string
                                    type:
                                      type: string
                                  required:
                                  - type
                                  type: object
                                windowsOptions:
                                  properties:
                                    gmsaCredentialSpec:
                                      type: string
                                    gmsaCredentialSpecName:
                                      type: string
                                    hostProcess:
                                      type: boolean
                                    runAsUserName:
                                      type: string
                                  type: object
                              type: object
                            startupProbe:
                              properties:
                                exec:
                                  properties:
                                    command:
                                      items:
                                        type: string
                                      type: array
                                  type: object
                                failureThreshold:
                                  format: int32
                                  type: integer
                                grpc:
                                  properties:
                                    port:
                                      format: int32
                                      type: integer
                                    service:
                                      type: string
                                  required:
                                  - port
                                  type: object
                                httpGet:
                                  properties:
                                    host:
                                      type: string
                                    httpHeaders:
                                      items:
                                        properties:
                                          name:
                                            type: string
                                          value:
                                            type: string
                                        required:
                                        - name
                                        - value
                                        type: object
                                      type: array
                                    path:
                                      type: string
                                    port:
                                      anyOf:
                                      - type: integer
                                      - type: string
                                      x-kubernetes-int-or-string: true
                                    scheme:
                                      type: string
                                  required:
                                  - port
                                  type: object
                                initialDelaySeconds:
                                  format: int32
                                  type: integer
                                periodSeconds:
                                  format: int32
                                  type: integer
                                successThreshold:
                                  format: int32
                                  type: integer
                                tcpSocket:
                                  properties:
                                    host:
                                      type: string
                                    port:
                                      anyOf:
                                      - type: integer
                                      - type: string
                                      x-kubernetes-int-or-string: true
                                  required:
                                  - port
                                  type: object
                                terminationGracePeriodSeconds:
                                  format: int64
                                  type: integer
                                timeoutSeconds:
                                  format: int32
                                  type: integer
                              type: object
                            stdin:
                              type: boolean
                            stdinOnce:
                              type: boolean
                            terminationMessagePath:
                              type: string
                            terminationMessagePolicy:
                              type: string
                            tty:
                              type: boolean
                            volumeDevices:
                              items:
                                properties:
                                  devicePath:
                                    type: string
                                  name:
                                    type: string
                                required:
                                - devicePath
                                - name
                                type: object
                              type: array
                            volumeMounts:
                              items:
                                properties:
                                  mountPath:
                                    type: string
                                  mountPropagation:
                                    type: string
                                  name:
                                    type: string
                                  readOnly:
                                    type: boolean
                                  subPath:
                                    type: string
                                  subPathExpr:
                                    type: string
                                required:
                                - mountPath
                                - name
                                type: object
                              type: array
                            workingDir:
                              type: string
                          required:
                          - name
                          type: object
                        type: array
                      nodeName:
                        type: string
                      nodeSelector:
                        additionalProperties:
                          type: string
                        type: object
                        x-kubernetes-map-type: atomic
                      os:
                        properties:
                          name:
                            type: string
                        required:
                        - name
                        type: object
                      overhead:
                        additionalProperties:
                          anyOf:
                          - type: integer
                          - type: string
                          pattern: ^(\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))))?$
                          x-kubernetes-int-or-string: true
                        type: object
                      preemptionPolicy:
                        type: string
                      priority:
                        format: int32
                        type: integer
                      priorityClassName:
                        type: string
                      readinessGates:
                        items:
                          properties:
                            conditionType:
                              type: string
                          required:
                          - conditionType
                          type: object
                        type: array
                      restartPolicy:
                        type: string
                      runtimeClassName:
                        type: string
                      schedulerName:
                        type: string
                      securityContext:
                        properties:
                          fsGroup:
                            format: int64
                            type: integer
                          fsGroupChangePolicy:
                            type: string
                          runAsGroup:
                            format: int64
                            type: integer
                          runAsNonRoot:
                            type: boolean
                          runAsUser:
                            format: int64
                            type: integer
                          seLinuxOptions:
                            properties:
                              level:
                                type: string
                              role:
                                type: string
                              type:
                                type: string
                              user:
                                type: string
                            type: object
                          seccompProfile:
                            properties:
                              localhostProfile:
                                type: string
                              type:
                                type: string
                            required:
                            - type
                            type: object
                          supplementalGroups:
                            items:
                              format: int64
                              type: integer
                            type: array
                          sysctls:
                            items:
                              properties:
                                name:
                                  type: string
                                value:
                                  type: string
                              required:
                              - name
                              - value
                              type: object
                            type: array
                          windowsOptions:
                            properties:
                              gmsaCredentialSpec:
                                type: string
                              gmsaCredentialSpecName:
                                type: string
                              hostProcess:
                                type: boolean
                              runAsUserName:
                                type: string
                            type: object
                        type: object
                      serviceAccount:
                        type: string
                      serviceAccountName:
                        type: string
                      setHostnameAsFQDN:
                        type: boolean
                      shareProcessNamespace:
                        type: boolean
                      subdomain:
                        type: string
                      terminationGracePeriodSeconds:
                        format: int64
                        type: integer
                      tolerations:
                        items:
                          properties:
                            effect:
                              type: string
                            key:
                              type: string
                            operator:
                              type: string
                            tolerationSeconds:
                              format: int64
                              type: integer
                            value:
                              type: string
                          type: object
                        type: array
                      topologySpreadConstraints:
                        items:
                          properties:
                            labelSelector:
                              properties:
                                matchExpressions:
                                  items:
                                    properties:
                                      key:
                                        type: string
                                      operator:
                                        type: string
                                      values:
                                        items:
                                          type: string
                                        type: array
                                    required:
                                    - key
                                    - operator
                                    type: object
                                  type: array
                                matchLabels:
                                  additionalProperties:
                                    type: string
                                  type: object
                              type: object
                            maxSkew:
                              format: int32
                              type: integer
                            topologyKey:
                              type: string
                            whenUnsatisfiable:
                              type: string
                          required:
                          - maxSkew
                          - topologyKey
                          - whenUnsatisfiable
                          type: object
                        type: array
                        x-kubernetes-list-map-keys:
                        - topologyKey
                        - whenUnsatisfiable
                        x-kubernetes-list-type: map
                      volumes:
                        items:
                          properties:
                            awsElasticBlockStore:
                              properties:
                                fsType:
                                  type: string
                                partition:
                                  format: int32
                                  type: integer
                                readOnly:
                                  type: boolean
                                volumeID:
                                  type: string
                              required:
                              - volumeID
                              type: object
                            azureDisk:
                              properties:
                                cachingMode:
                                  type: string
                                diskName:
                                  type: string
                                diskURI:
                                  type: string
                                fsType:
                                  type: string
                                kind:
                                  type: string
                                readOnly:
                                  type: boolean
                              required:
                              - diskName
                              - diskURI
                              type: object
                            azureFile:
                              properties:
                                readOnly:
                                  type: boolean
                                secretName:
                                  type: string
                                shareName:
                                  type: string
                              required:
                              - secretName
                              - shareName
                              type: object
                            cephfs:
                              properties:
                                monitors:
                                  items:
                                    type: string
                                  type: array
                                path:
                                  type: string
                                readOnly:
                                  type: boolean
                                secretFile:
                                  type: string
                                secretRef:
                                  properties:
                                    name:
                                      type: string
                                  type: object
                                user:
                                  type: string
                              required:
                              - monitors
                              type: object
                            cinder:
                              properties:
                                fsType:
                                  type: string
                                readOnly:
                                  type: boolean
                                secretRef:
                                  properties:
                                    name:
                                      type: string
                                  type: object
                                volumeID:
                                  type: string
                              required:
                              - volumeID
                              type: object
                            configMap:
                              properties:
                                defaultMode:
                                  format: int32
                                  type: integer
                                items:
                                  items:
                                    properties:
                                      key:
                                        type: string
                                      mode:
                                        format: int32
                                        type: integer
                                      path:
                                        type: string
                                    required:
                                    - key
                                    - path
                                    type: object
                                  type: array
                                name:
                                  type: string
                                optional:
                                  type: boolean
                              type: object
                            csi:
                              properties:
                                driver:
                                  type: string
                                fsType:
                                  type: string
                                nodePublishSecretRef:
                                  properties:
                                    name:
                                      type: string
                                  type: object
                                readOnly:
                                  type: boolean
                                volumeAttributes:
                                  additionalProperties:
                                    type: string
                                  type: object
                              required:
                              - driver
                              type: object
                            downwardAPI:
                              properties:
                                defaultMode:
                                  format: int32
                                  type: integer
                                items:
                                  items:
                                    properties:
                                      fieldRef:
                                        properties:
                                          apiVersion:
                                            type: string
                                          fieldPath:
                                            type: string
                                        required:
                                        - fieldPath
                                        type: object
                                      mode:
                                        format: int32
                                        type: integer
                                      path:
                                        type: string
                                      resourceFieldRef:
                                        properties:
                                          containerName:
                                            type: string
                                          divisor:
                                            anyOf:
                                            - type: integer
                                            - type: string
                                            pattern: ^(\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))))?$
                                            x-kubernetes-int-or-string: true
                                          resource:
                                            type: string
                                        required:
                                        - resource
                                        type: object
                                    required:
                                    - path
                                    type: object
                                  type: array
                              type: object
                            emptyDir:
                              properties:
                                medium:
                                  type: string
                                sizeLimit:
                                  anyOf:
                                  - type: integer
                                  - type: string
                                  pattern: ^(\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))))?$
                                  x-kubernetes-int-or-string: true
                              type: object
                            ephemeral:
                              properties:
                                volumeClaimTemplate:
                                  properties:
                                    metadata:
                                      type: object
                                    spec:
                                      properties:
                                        accessModes:
                                          items:
                                            type: string
                                          type: array
                                        dataSource:
                                          properties:
                                            apiGroup:
                                              type: string
                                            kind:
                                              type: string
                                            name:
                                              type: string
                                          required:
                                          - kind
                                          - name
                                          type: object
                                        dataSourceRef:
                                          properties:
                                            apiGroup:
                                              type: string
                                            kind:
                                              type: string
                                            name:
                                              type: string
                                          required:
                                          - kind
                                          - name
                                          type: object
                                        resources:
                                          properties:
                                            limits:
                                              additionalProperties:
                                                anyOf:
                                                - type: integer
                                                - type: string
                                                pattern: ^(\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))))?$
                                                x-kubernetes-int-or-string: true
                                              type: object
                                            requests:
                                              additionalProperties:
                                                anyOf:
                                                - type: integer
                                                - type: string
                                                pattern: ^(\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))))?$
                                                x-kubernetes-int-or-string: true
                                              type: object
                                          type: object
                                        selector:
                                          properties:
                                            matchExpressions:
                                              items:
                                                properties:
                                                  key:
                                                    type: string
                                                  operator:
                                                    type: string
                                                  values:
                                                    items:
                                                      type: string
                                                    type: array
                                                required:
                                                - key
                                                - operator
                                                type: object
                                              type: array
                                            matchLabels:
                                              additionalProperties:
                                                type: string
                                              type: object
                                          type: object
                                        storageClassName:
                                          type: string
                                        volumeMode:
                                          type: string
                                        volumeName:
                                          type: string
                                      type: object
                                  required:
                                  - spec
                                  type: object
                              type: object
                            fc:
                              properties:
                                fsType:
                                  type: string
                                lun:
                                  format: int32
                                  type: integer
                                readOnly:
                                  type: boolean
                                targetWWNs:
                                  items:
                                    type: string
                                  type: array
                                wwids:
                                  items:
                                    type: string
                                  type: array
                              type: object
                            flexVolume:
                              properties:
                                driver:
                                  type: string
                                fsType:
                                  type: string
                                options:
                                  additionalProperties:
                                    type: string
                                  type: object
                                readOnly:
                                  type: boolean
                                secretRef:
                                  properties:
                                    name:
                                      type: string
                                  type: object
                              required:
                              - driver
                              type: object
                            flocker:
                              properties:
                                datasetName:
                                  type: string
                                datasetUUID:
                                  type: string
                              type: object
                            gcePersistentDisk:
                              properties:
                                fsType:
                                  type: string
                                partition:
                                  format: int32
                                  type: integer
                                pdName:
                                  type: string
                                readOnly:
                                  type: boolean
                              required:
                              - pdName
                              type: object
                            gitRepo:
                              properties:
                                directory:
                                  type: string
                                repository:
                                  type: string
                                revision:
                                  type: string
                              required:
                              - repository
                              type: object
                            glusterfs:
                              properties:
                                endpoints:
                                  type: string
                                path:
                                  type: string
                                readOnly:
                                  type: boolean
                              required:
                              - endpoints
                              - path
                              type: object
                            hostPath:
                              properties:
                                path:
                                  type: string
                                type:
                                  type: string
                              required:
                              - path
                              type: object
                            iscsi:
                              properties:
                                chapAuthDiscovery:
                                  type: boolean
                                chapAuthSession:
                                  type: boolean
                                fsType:
                                  type: string
                                initiatorName:
                                  type: string
                                iqn:
                                  type: string
                                iscsiInterface:
                                  type: string
                                lun:
                                  format: int32
                                  type: integer
                                portals:
                                  items:
                                    type: string
                                  type: array
                                readOnly:
                                  type: boolean
                                secretRef:
                                  properties:
                                    name:
                                      type: string
                                  type: object
                                targetPortal:
                                  type: string
                              required:
                              - iqn
                              - lun
                              - targetPortal
                              type: object
                            name:
                              type: string
                            nfs:
                              properties:
                                path:
                                  type: string
                                readOnly:
                                  type: boolean
                                server:
                                  type: string
                              required:
                              - path
                              - server
                              type: object
                            persistentVolumeClaim:
                              properties:
                                claimName:
                                  type: string
                                readOnly:
                                  type: boolean
                              required:
                              - claimName
                              type: object
                            photonPersistentDisk:
                              properties:
                                fsType:
                                  type: string
                                pdID:
                                  type: string
                              required:
                              - pdID
                              type: object
                            portworxVolume:
                              properties:
                                fsType:
                                  type: string
                                readOnly:
                                  type: boolean
                                volumeID:
                                  type: string
                              required:
                              - volumeID
                              type: object
                            projected:
                              properties:
                                defaultMode:
                                  format: int32
                                  type: integer
                                sources:
                                  items:
                                    properties:
                                      configMap:
                                        properties:
                                          items:
                                            items:
                                              properties:
                                                key:
                                                  type: string
                                                mode:
                                                  format: int32
                                                  type: integer
                                                path:
                                                  type: string
                                              required:
                                              - key
                                              - path
                                              type: object
                                            type: array
                                          name:
                                            type: string
                                          optional:
                                            type: boolean
                                        type: object
                                      downwardAPI:
                                        properties:
                                          items:
                                            items:
                                              properties:
                                                fieldRef:
                                                  properties:
                                                    apiVersion:
                                                      type: string
                                                    fieldPath:
                                                      type: string
                                                  required:
                                                  - fieldPath
                                                  type: object
                                                mode:
                                                  format: int32
                                                  type: integer
                                                path:
                                                  type: string
                                                resourceFieldRef:
                                                  properties:
                                                    containerName:
                                                      type: string
                                                    divisor:
                                                      anyOf:
                                                      - type: integer
                                                      - type: string
                                                      pattern: ^(\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))))?$
                                                      x-kubernetes-int-or-string: true
                                                    resource:
                                                      type: string
                                                  required:
                                                  - resource
                                                  type: object
                                              required:
                                              - path
                                              type: object
                                            type: array
                                        type: object
                                      secret:
                                        properties:
                                          items:
                                            items:
                                              properties:
                                                key:
                                                  type: string
                                                mode:
                                                  format: int32
                                                  type: integer
                                                path:
                                                  type: string
                                              required:
                                              - key
                                              - path
                                              type: object
                                            type: array
                                          name:
                                            type: string
                                          optional:
                                            type: boolean
                                        type: object
                                      serviceAccountToken:
                                        properties:
                                          audience:
                                            type: string
                                          expirationSeconds:
                                            format: int64
                                            type: integer
                                          path:
                                            type: string
                                        required:
                                        - path
                                        type: object
                                    type: object
                                  type: array
                              type: object
                            quobyte:
                              properties:
                                group:
                                  type: string
                                readOnly:
                                  type: boolean
                                registry:
                                  type: string
                                tenant:
                                  type: string
                                user:
                                  type: string
                                volume:
                                  type: string
                              required:
                              - registry
                              - volume
                              type: object
                            rbd:
                              properties:
                                fsType:
                                  type: string
                                image:
                                  type: string
                                keyring:
                                  type: string
                                monitors:
                                  items:
                                    type: string
                                  type: array
                                pool:
                                  type: string
                                readOnly:
                                  type: boolean
                                secretRef:
                                  properties:
                                    name:
                                      type: string
                                  type: object
                                user:
                                  type: string
                              required:
                              - image
                              - monitors
                              type: object
                            scaleIO:
                              properties:
                                fsType:
                                  type: string
                                gateway:
                                  type: string
                                protectionDomain:
                                  type: string
                                readOnly:
                                  type: boolean
                                secretRef:
                                  properties:
                                    name:
                                      type: string
                                  type: object
                                sslEnabled:
                                  type: boolean
                                storageMode:
                                  type: string
                                storagePool:
                                  type: string
                                system:
                                  type: string
                                volumeName:
                                  type: string
                              required:
                              - gateway
                              - secretRef
                              - system
                              type: object
                            secret:
                              properties:
                                defaultMode:
                                  format: int32
                                  type: integer
                                items:
                                  items:
                                    properties:
                                      key:
                                        type: string
                                      mode:
                                        format: int32
                                        type: integer
                                      path:
                                        type: string
                                    required:
                                    - key
                                    - path
                                    type: object
                                  type: array
                                optional:
                                  type: boolean
                                secretName:
                                  type: string
                              type: object
                            storageos:
                              properties:
                                fsType:
                                  type: string
                                readOnly:
                                  type: boolean
                                secretRef:
                                  properties:
                                    name:
                                      type: string
                                  type: object
                                volumeName:
                                  type: string
                                volumeNamespace:
                                  type: string
                              type: object
                            vsphereVolume:
                              properties:
                                fsType:
                                  type: string
                                storagePolicyID:
                                  type: string
                                storagePolicyName:
                                  type: string
                                volumePath:
                                  type: string
                              required:
                              - volumePath
                              type: object
                          required:
                          - name
                          type: object
                        type: array
                    required:
                    - containers
                    type: object
                type: object
            type: object
          status:
            properties:
              conditions:
                items:
                  properties:
                    lastProbeTime:
                      format: date-time
                      type: string
                    lastTransitionTime:
                      format: date-time
                      type: string
                    message:
                      type: string
                    reason:
                      type: string
                    status:
                      type: string
                    type:
                      type: string
                  required:
                  - status
                  - type
                  type: object
                type: array
              containerState:
                properties:
                  running:
                    properties:
                      startedAt:
                        format: date-time
                        type: string
                    type: object
                  terminated:
                    properties:
                      containerID:
                        type: string
                      exitCode:
                        format: int32
                        type: integer
                      finishedAt:
                        format: date-time
                        type: string
                      message:
                        type: string
                      reason:
                        type: string
                      signal:
                        format: int32
                        type: integer
                      startedAt:
                        format: date-time
                        type: string
                    required:
                    - exitCode
                    type: object
                  waiting:
                    properties:
                      message:
                        type: string
                      reason:
                        type: string
                    type: object
                type: object
              readyReplicas:
                format: int32
                type: integer
            required:
            - conditions
            - containerState
            - readyReplicas
            type: object
        type: object
    served: true
    storage: true
    subresources:
      status: {}
  - name: v1alpha1
    schema:
      openAPIV3Schema:
        properties:
          apiVersion:
            type: string
          kind:
            type: string
          metadata:
            type: object
          spec:
            properties:
              template:
                properties:
                  spec:
                    properties:
                      activeDeadlineSeconds:
                        format: int64
                        type: integer
                      affinity:
                        properties:
                          nodeAffinity:
                            properties:
                              preferredDuringSchedulingIgnoredDuringExecution:
                                items:
                                  properties:
                                    preference:
                                      properties:
                                        matchExpressions:
                                          items:
                                            properties:
                                              key:
                                                type: string
                                              operator:
                                                type: string
                                              values:
                                                items:
                                                  type: string
                                                type: array
                                            required:
                                            - key
                                            - operator
                                            type: object
                                          type: array
                                        matchFields:
                                          items:
                                            properties:
                                              key:
                                                type: string
                                              operator:
                                                type: string
                                              values:
                                                items:
                                                  type: string
                                                type: array
                                            required:
                                            - key
                                            - operator
                                            type: object
                                          type: array
                                      type: object
                                    weight:
                                      format: int32
                                      type: integer
                                  required:
                                  - preference
                                  - weight
                                  type: object
                                type: array
                              requiredDuringSchedulingIgnoredDuringExecution:
                                properties:
                                  nodeSelectorTerms:
                                    items:
                                      properties:
                                        matchExpressions:
                                          items:
                                            properties:
                                              key:
                                                type: string
                                              operator:
                                                type: string
                                              values:
                                                items:
                                                  type: string
                                                type: array
                                            required:
                                            - key
                                            - operator
                                            type: object
                                          type: array
                                        matchFields:
                                          items:
                                            properties:
                                              key:
                                                type: string
                                              operator:
                                                type: string
                                              values:
                                                items:
                                                  type: string
                                                type: array
                                            required:
                                            - key
                                            - operator
                                            type: object
                                          type: array
                                      type: object
                                    type: array
                                required:
                                - nodeSelectorTerms
                                type: object
                            type: object
                          podAffinity:
                            properties:
                              preferredDuringSchedulingIgnoredDuringExecution:
                                items:
                                  properties:
                                    podAffinityTerm:
                                      properties:
                                        labelSelector:
                                          properties:
                                            matchExpressions:
                                              items:
                                                properties:
                                                  key:
                                                    type: string
                                                  operator:
                                                    type: string
                                                  values:
                                                    items:
                                                      type: string
                                                    type: array
                                                required:
                                                - key
                                                - operator
                                                type: object
                                              type: array
                                            matchLabels:
                                              additionalProperties:
                                                type: string
                                              type: object
                                          type: object
                                        namespaceSelector:
                                          properties:
                                            matchExpressions:
                                              items:
                                                properties:
                                                  key:
                                                    type: string
                                                  operator:
                                                    type: string
                                                  values:
                                                    items:
                                                      type: string
                                                    type: array
                                                required:
                                                - key
                                                - operator
                                                type: object
                                              type: array
                                            matchLabels:
                                              additionalProperties:
                                                type: string
                                              type: object
                                          type: object
                                        namespaces:
                                          items:
                                            type: string
                                          type: array
                                        topologyKey:
                                          type: string
                                      required:
                                      - topologyKey
                                      type: object
                                    weight:
                                      format: int32
                                      type: integer
                                  required:
                                  - podAffinityTerm
                                  - weight
                                  type: object
                                type: array
                              requiredDuringSchedulingIgnoredDuringExecution:
                                items:
                                  properties:
                                    labelSelector:
                                      properties:
                                        matchExpressions:
                                          items:
                                            properties:
                                              key:
                                                type: string
                                              operator:
                                                type: string
                                              values:
                                                items:
                                                  type: string
                                                type: array
                                            required:
                                            - key
                                            - operator
                                            type: object
                                          type: array
                                        matchLabels:
                                          additionalProperties:
                                            type: string
                                          type: object
                                      type: object
                                    namespaceSelector:
                                      properties:
                                        matchExpressions:
                                          items:
                                            properties:
                                              key:
                                                type: string
                                              operator:
                                                type: string
                                              values:
                                                items:
                                                  type: string
                                                type: array
                                            required:
                                            - key
                                            - operator
                                            type: object
                                          type: array
                                        matchLabels:
                                          additionalProperties:
                                            type: string
                                          type: object
                                      type: object
                                    namespaces:
                                      items:
                                        type: string
                                      type: array
                                    topologyKey:
                                      type: string
                                  required:
                                  - topologyKey
                                  type: object
                                type: array
                            type: object
                          podAntiAffinity:
                            properties:
                              preferredDuringSchedulingIgnoredDuringExecution:
                                items:
                                  properties:
                                    podAffinityTerm:
                                      properties:
                                        labelSelector:
                                          properties:
                                            matchExpressions:
                                              items:
                                                properties:
                                                  key:
                                                    type: string
                                                  operator:
                                                    type: string
                                                  values:
                                                    items:
                                                      type: string
                                                    type: array
                                                required:
                                                - key
                                                - operator
                                                type: object
                                              type: array
                                            matchLabels:
                                              additionalProperties:
                                                type: string
                                              type: object
                                          type: object
                                        namespaceSelector:
                                          properties:
                                            matchExpressions:
                                              items:
                                                properties:
                                                  key:
                                                    type: string
                                                  operator:
                                                    type: string
                                                  values:
                                                    items:
                                                      type: string
                                                    type: array
                                                required:
                                                - key
                                                - operator
                                                type: object
                                              type: array
                                            matchLabels:
                                              additionalProperties:
                                                type: string
                                              type: object
                                          type: object
                                        namespaces:
                                          items:
                                            type: string
                                          type: array
                                        topologyKey:
                                          type: string
                                      required:
                                      - topologyKey
                                      type: object
                                    weight:
                                      format: int32
                                      type: integer
                                  required:
                                  - podAffinityTerm
                                  - weight
                                  type: object
                                type: array
                              requiredDuringSchedulingIgnoredDuringExecution:
                                items:
                                  properties:
                                    labelSelector:
                                      properties:
                                        matchExpressions:
                                          items:
                                            properties:
                                              key:
                                                type: string
                                              operator:
                                                type: string
                                              values:
                                                items:
                                                  type: string
                                                type: array
                                            required:
                                            - key
                                            - operator
                                            type: object
                                          type: array
                                        matchLabels:
                                          additionalProperties:
                                            type: string
                                          type: object
                                      type: object
                                    namespaceSelector:
                                      properties:
                                        matchExpressions:
                                          items:
                                            properties:
                                              key:
                                                type: string
                                              operator:
                                                type: string
                                              values:
                                                items:
                                                  type: string
                                                type: array
                                            required:
                                            - key
                                            - operator
                                            type: object
                                          type: array
                                        matchLabels:
                                          additionalProperties:
                                            type: string
                                          type: object
                                      type: object
                                    namespaces:
                                      items:
                                        type: string
                                      type: array
                                    topologyKey:
                                      type: string
                                  required:
                                  - topologyKey
                                  type: object
                                type: array
                            type: object
                        type: object
                      automountServiceAccountToken:
                        type: boolean
                      containers:
                        items:
                          properties:
                            args:
                              items:
                                type: string
                              type: array
                            command:
                              items:
                                type: string
                              type: array
                            env:
                              items:
                                properties:
                                  name:
                                    type: string
                                  value:
                                    type: string
                                  valueFrom:
                                    properties:
                                      configMapKeyRef:
                                        properties:
                                          key:
                                            type: string
                                          name:
                                            type: string
                                          optional:
                                            type: boolean
                                        required:
                                        - key
                                        type: object
                                      fieldRef:
                                        properties:
                                          apiVersion:
                                            type: string
                                          fieldPath:
                                            type: string
                                        required:
                                        - fieldPath
                                        type: object
                                      resourceFieldRef:
                                        properties:
                                          containerName:
                                            type: string
                                          divisor:
                                            anyOf:
                                            - type: integer
                                            - type: string
                                            pattern: ^(\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))))?$
                                            x-kubernetes-int-or-string: true
                                          resource:
                                            type: string
                                        required:
                                        - resource
                                        type: object
                                      secretKeyRef:
                                        properties:
                                          key:
                                            type: string
                                          name:
                                            type: string
                                          optional:
                                            type: boolean
                                        required:
                                        - key
                                        type: object
                                    type: object
                                required:
                                - name
                                type: object
                              type: array
                            envFrom:
                              items:
                                properties:
                                  configMapRef:
                                    properties:
                                      name:
                                        type: string
                                      optional:
                                        type: boolean
                                    type: object
                                  prefix:
                                    type: string
                                  secretRef:
                                    properties:
                                      name:
                                        type: string
                                      optional:
                                        type: boolean
                                    type: object
                                type: object
                              type: array
                            image:
                              type: string
                            imagePullPolicy:
                              type: string
                            lifecycle:
                              properties:
                                postStart:
                                  properties:
                                    exec:
                                      properties:
                                        command:
                                          items:
                                            type: string
                                          type: array
                                      type: object
                                    httpGet:
                                      properties:
                                        host:
                                          type: string
                                        httpHeaders:
                                          items:
                                            properties:
                                              name:
                                                type: string
                                              value:
                                                type: string
                                            required:
                                            - name
                                            - value
                                            type: object
                                          type: array
                                        path:
                                          type: string
                                        port:
                                          anyOf:
                                          - type: integer
                                          - type: string
                                          x-kubernetes-int-or-string: true
                                        scheme:
                                          type: string
                                      required:
                                      - port
                                      type: object
                                    tcpSocket:
                                      properties:
                                        host:
                                          type: string
                                        port:
                                          anyOf:
                                          - type: integer
                                          - type: string
                                          x-kubernetes-int-or-string: true
                                      required:
                                      - port
                                      type: object
                                  type: object
                                preStop:
                                  properties:
                                    exec:
                                      properties:
                                        command:
                                          items:
                                            type: string
                                          type: array
                                      type: object
                                    httpGet:
                                      properties:
                                        host:
                                          type: string
                                        httpHeaders:
                                          items:
                                            properties:
                                              name:
                                                type: string
                                              value:
                                                type: string
                                            required:
                                            - name
                                            - value
                                            type: object
                                          type: array
                                        path:
                                          type: string
                                        port:
                                          anyOf:
                                          - type: integer
                                          - type: string
                                          x-kubernetes-int-or-string: true
                                        scheme:
                                          type: string
                                      required:
                                      - port
                                      type: object
                                    tcpSocket:
                                      properties:
                                        host:
                                          type: string
                                        port:
                                          anyOf:
                                          - type: integer
                                          - type: string
                                          x-kubernetes-int-or-string: true
                                      required:
                                      - port
                                      type: object
                                  type: object
                              type: object
                            livenessProbe:
                              properties:
                                exec:
                                  properties:
                                    command:
                                      items:
                                        type: string
                                      type: array
                                  type: object
                                failureThreshold:
                                  format: int32
                                  type: integer
                                grpc:
                                  properties:
                                    port:
                                      format: int32
                                      type: integer
                                    service:
                                      type: string
                                  required:
                                  - port
                                  type: object
                                httpGet:
                                  properties:
                                    host:
                                      type: string
                                    httpHeaders:
                                      items:
                                        properties:
                                          name:
                                            type: string
                                          value:
                                            type: string
                                        required:
                                        - name
                                        - value
                                        type: object
                                      type: array
                                    path:
                                      type: string
                                    port:
                                      anyOf:
                                      - type: integer
                                      - type: string
                                      x-kubernetes-int-or-string: true
                                    scheme:
                                      type: string
                                  required:
                                  - port
                                  type: object
                                initialDelaySeconds:
                                  format: int32
                                  type: integer
                                periodSeconds:
                                  format: int32
                                  type: integer
                                successThreshold:
                                  format: int32
                                  type: integer
                                tcpSocket:
                                  properties:
                                    host:
                                      type: string
                                    port:
                                      anyOf:
                                      - type: integer
                                      - type: string
                                      x-kubernetes-int-or-string: true
                                  required:
                                  - port
                                  type: object
                                terminationGracePeriodSeconds:
                                  format: int64
                                  type: integer
                                timeoutSeconds:
                                  format: int32
                                  type: integer
                              type: object
                            name:
                              type: string
                            ports:
                              items:
                                properties:
                                  containerPort:
                                    format: int32
                                    type: integer
                                  hostIP:
                                    type: string
                                  hostPort:
                                    format: int32
                                    type: integer
                                  name:
                                    type: string
                                  protocol:
                                    default: TCP
                                    type: string
                                required:
                                - containerPort
                                type: object
                              type: array
                              x-kubernetes-list-map-keys:
                              - containerPort
                              - protocol
                              x-kubernetes-list-type: map
                            readinessProbe:
                              properties:
                                exec:
                                  properties:
                                    command:
                                      items:
                                        type: string
                                      type: array
                                  type: object
                                failureThreshold:
                                  format: int32
                                  type: integer
                                grpc:
                                  properties:
                                    port:
                                      format: int32
                                      type: integer
                                    service:
                                      type: string
                                  required:
                                  - port
                                  type: object
                                httpGet:
                                  properties:
                                    host:
                                      type: string
                                    httpHeaders:
                                      items:
                                        properties:
                                          name:
                                            type: string
                                          value:
                                            type: string
                                        required:
                                        - name
                                        - value
                                        type: object
                                      type: array
                                    path:
                                      type: string
                                    port:
                                      anyOf:
                                      - type: integer
                                      - type: string
                                      x-kubernetes-int-or-string: true
                                    scheme:
                                      type: string
                                  required:
                                  - port
                                  type: object
                                initialDelaySeconds:
                                  format: int32
                                  type: integer
                                periodSeconds:
                                  format: int32
                                  type: integer
                                successThreshold:
                                  format: int32
                                  type: integer
                                tcpSocket:
                                  properties:
                                    host:
                                      type: string
                                    port:
                                      anyOf:
                                      - type: integer
                                      - type: string
                                      x-kubernetes-int-or-string: true
                                  required:
                                  - port
                                  type: object
                                terminationGracePeriodSeconds:
                                  format: int64
                                  type: integer
                                timeoutSeconds:
                                  format: int32
                                  type: integer
                              type: object
                            resources:
                              properties:
                                limits:
                                  additionalProperties:
                                    anyOf:
                                    - type: integer
                                    - type: string
                                    pattern: ^(\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))))?$
                                    x-kubernetes-int-or-string: true
                                  type: object
                                requests:
                                  additionalProperties:
                                    anyOf:
                                    - type: integer
                                    - type: string
                                    pattern: ^(\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))))?$
                                    x-kubernetes-int-or-string: true
                                  type: object
                              type: object
                            securityContext:
                              properties:
                                allowPrivilegeEscalation:
                                  type: boolean
                                capabilities:
                                  properties:
                                    add:
                                      items:
                                        type: string
                                      type: array
                                    drop:
                                      items:
                                        type: string
                                      type: array
                                  type: object
                                privileged:
                                  type: boolean
                                procMount:
                                  type: string
                                readOnlyRootFilesystem:
                                  type: boolean
                                runAsGroup:
                                  format: int64
                                  type: integer
                                runAsNonRoot:
                                  type: boolean
                                runAsUser:
                                  format: int64
                                  type: integer
                                seLinuxOptions:
                                  properties:
                                    level:
                                      type: string
                                    role:
                                      type: string
                                    type:
                                      type: string
                                    user:
                                      type: string
                                  type: object
                                seccompProfile:
                                  properties:
                                    localhostProfile:
                                      type: string
                                    type:
                                      type: string
                                  required:
                                  - type
                                  type: object
                                windowsOptions:
                                  properties:
                                    gmsaCredentialSpec:
                                      type: string
                                    gmsaCredentialSpecName:
                                      type: string
                                    hostProcess:
                                      type: boolean
                                    runAsUserName:
                                      type: string
                                  type: object
                              type: object
                            startupProbe:
                              properties:
                                exec:
                                  properties:
                                    command:
                                      items:
                                        type: string
                                      type: array
                                  type: object
                                failureThreshold:
                                  format: int32
                                  type: integer
                                grpc:
                                  properties:
                                    port:
                                      format: int32
                                      type: integer
                                    service:
                                      type: string
                                  required:
                                  - port
                                  type: object
                                httpGet:
                                  properties:
                                    host:
                                      type: string
                                    httpHeaders:
                                      items:
                                        properties:
                                          name:
                                            type: string
                                          value:
                                            type: string
                                        required:
                                        - name
                                        - value
                                        type: object
                                      type: array
                                    path:
                                      type: string
                                    port:
                                      anyOf:
                                      - type: integer
                                      - type: string
                                      x-kubernetes-int-or-string: true
                                    scheme:
                                      type: string
                                  required:
                                  - port
                                  type: object
                                initialDelaySeconds:
                                  format: int32
                                  type: integer
                                periodSeconds:
                                  format: int32
                                  type: integer
                                successThreshold:
                                  format: int32
                                  type: integer
                                tcpSocket:
                                  properties:
                                    host:
                                      type: string
                                    port:
                                      anyOf:
                                      - type: integer
                                      - type: string
                                      x-kubernetes-int-or-string: true
                                  required:
                                  - port
                                  type: object
                                terminationGracePeriodSeconds:
                                  format: int64
                                  type: integer
                                timeoutSeconds:
                                  format: int32
                                  type: integer
                              type: object
                            stdin:
                              type: boolean
                            stdinOnce:
                              type: boolean
                            terminationMessagePath:
                              type: string
                            terminationMessagePolicy:
                              type: string
                            tty:
                              type: boolean
                            volumeDevices:
                              items:
                                properties:
                                  devicePath:
                                    type: string
                                  name:
                                    type: string
                                required:
                                - devicePath
                                - name
                                type: object
                              type: array
                            volumeMounts:
                              items:
                                properties:
                                  mountPath:
                                    type: string
                                  mountPropagation:
                                    type: string
                                  name:
                                    type: string
                                  readOnly:
                                    type: boolean
                                  subPath:
                                    type: string
                                  subPathExpr:
                                    type: string
                                required:
                                - mountPath
                                - name
                                type: object
                              type: array
                            workingDir:
                              type: string
                          required:
                          - name
                          type: object
                        type: array
                      dnsConfig:
                        properties:
                          nameservers:
                            items:
                              type: string
                            type: array
                          options:
                            items:
                              properties:
                                name:
                                  type: string
                                value:
                                  type: string
                              type: object
                            type: array
                          searches:
                            items:
                              type: string
                            type: array
                        type: object
                      dnsPolicy:
                        type: string
                      enableServiceLinks:
                        type: boolean
                      ephemeralContainers:
                        items:
                          properties:
                            args:
                              items:
                                type: string
                              type: array
                            command:
                              items:
                                type: string
                              type: array
                            env:
                              items:
                                properties:
                                  name:
                                    type: string
                                  value:
                                    type: string
                                  valueFrom:
                                    properties:
                                      configMapKeyRef:
                                        properties:
                                          key:
                                            type: string
                                          name:
                                            type: string
                                          optional:
                                            type: boolean
                                        required:
                                        - key
                                        type: object
                                      fieldRef:
                                        properties:
                                          apiVersion:
                                            type: string
                                          fieldPath:
                                            type: string
                                        required:
                                        - fieldPath
                                        type: object
                                      resourceFieldRef:
                                        properties:
                                          containerName:
                                            type: string
                                          divisor:
                                            anyOf:
                                            - type: integer
                                            - type: string
                                            pattern: ^(\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))))?$
                                            x-kubernetes-int-or-string: true
                                          resource:
                                            type: string
                                        required:
                                        - resource
                                        type: object
                                      secretKeyRef:
                                        properties:
                                          key:
                                            type: string
                                          name:
                                            type: string
                                          optional:
                                            type: boolean
                                        required:
                                        - key
                                        type: object
                                    type: object
                                required:
                                - name
                                type: object
                              type: array
                            envFrom:
                              items:
                                properties:
                                  configMapRef:
                                    properties:
                                      name:
                                        type: string
                                      optional:
                                        type: boolean
                                    type: object
                                  prefix:
                                    type: string
                                  secretRef:
                                    properties:
                                      name:
                                        type: string
                                      optional:
                                        type: boolean
                                    type: object
                                type: object
                              type: array
                            image:
                              type: string
                            imagePullPolicy:
                              type: string
                            lifecycle:
                              properties:
                                postStart:
                                  properties:
                                    exec:
                                      properties:
                                        command:
                                          items:
                                            type: string
                                          type: array
                                      type: object
                                    httpGet:
                                      properties:
                                        host:
                                          type: string
                                        httpHeaders:
                                          items:
                                            properties:
                                              name:
                                                type: string
                                              value:
                                                type: string
                                            required:
                                            - name
                                            - value
                                            type: object
                                          type: array
                                        path:
                                          type: string
                                        port:
                                          anyOf:
                                          - type: integer
                                          - type: string
                                          x-kubernetes-int-or-string: true
                                        scheme:
                                          type: string
                                      required:
                                      - port
                                      type: object
                                    tcpSocket:
                                      properties:
                                        host:
                                          type: string
                                        port:
                                          anyOf:
                                          - type: integer
                                          - type: string
                                          x-kubernetes-int-or-string: true
                                      required:
                                      - port
                                      type: object
                                  type: object
                                preStop:
                                  properties:
                                    exec:
                                      properties:
                                        command:
                                          items:
                                            type: string
                                          type: array
                                      type: object
                                    httpGet:
                                      properties:
                                        host:
                                          type: string
                                        httpHeaders:
                                          items:
                                            properties:
                                              name:
                                                type: string
                                              value:
                                                type: string
                                            required:
                                            - name
                                            - value
                                            type: object
                                          type: array
                                        path:
                                          type: string
                                        port:
                                          anyOf:
                                          - type: integer
                                          - type: string
                                          x-kubernetes-int-or-string: true
                                        scheme:
                                          type: string
                                      required:
                                      - port
                                      type: object
                                    tcpSocket:
                                      properties:
                                        host:
                                          type: string
                                        port:
                                          anyOf:
                                          - type: integer
                                          - type: string
                                          x-kubernetes-int-or-string: true
                                      required:
                                      - port
                                      type: object
                                  type: object
                              type: object
                            livenessProbe:
                              properties:
                                exec:
                                  properties:
                                    command:
                                      items:
                                        type: string
                                      type: array
                                  type: object
                                failureThreshold:
                                  format: int32
                                  type: integer
                                grpc:
                                  properties:
                                    port:
                                      format: int32
                                      type: integer
                                    service:
                                      type: string
                                  required:
                                  - port
                                  type: object
                                httpGet:
                                  properties:
                                    host:
                                      type: string
                                    httpHeaders:
                                      items:
                                        properties:
                                          name:
                                            type: string
                                          value:
                                            type: string
                                        required:
                                        - name
                                        - value
                                        type: object
                                      type: array
                                    path:
                                      type: string
                                    port:
                                      anyOf:
                                      - type: integer
                                      - type: string
                                      x-kubernetes-int-or-string: true
                                    scheme:
                                      type: string
                                  required:
                                  - port
                                  type: object
                                initialDelaySeconds:
                                  format: int32
                                  type: integer
                                periodSeconds:
                                  format: int32
                                  type: integer
                                successThreshold:
                                  format: int32
                                  type: integer
                                tcpSocket:
                                  properties:
                                    host:
                                      type: string
                                    port:
                                      anyOf:
                                      - type: integer
                                      - type: string
                                      x-kubernetes-int-or-string: true
                                  required:
                                  - port
                                  type: object
                                terminationGracePeriodSeconds:
                                  format: int64
                                  type: integer
                                timeoutSeconds:
                                  format: int32
                                  type: integer
                              type: object
                            name:
                              type: string
                            ports:
                              items:
                                properties:
                                  containerPort:
                                    format: int32
                                    type: integer
                                  hostIP:
                                    type: string
                                  hostPort:
                                    format: int32
                                    type: integer
                                  name:
                                    type: string
                                  protocol:
                                    default: TCP
                                    type: string
                                required:
                                - containerPort
                                type: object
                              type: array
                              x-kubernetes-list-map-keys:
                              - containerPort
                              - protocol
                              x-kubernetes-list-type: map
                            readinessProbe:
                              properties:
                                exec:
                                  properties:
                                    command:
                                      items:
                                        type: string
                                      type: array
                                  type: object
                                failureThreshold:
                                  format: int32
                                  type: integer
                                grpc:
                                  properties:
                                    port:
                                      format: int32
                                      type: integer
                                    service:
                                      type: string
                                  required:
                                  - port
                                  type: object
                                httpGet:
                                  properties:
                                    host:
                                      type: string
                                    httpHeaders:
                                      items:
                                        properties:
                                          name:
                                            type: string
                                          value:
                                            type: string
                                        required:
                                        - name
                                        - value
                                        type: object
                                      type: array
                                    path:
                                      type: string
                                    port:
                                      anyOf:
                                      - type: integer
                                      - type: string
                                      x-kubernetes-int-or-string: true
                                    scheme:
                                      type: string
                                  required:
                                  - port
                                  type: object
                                initialDelaySeconds:
                                  format: int32
                                  type: integer
                                periodSeconds:
                                  format: int32
                                  type: integer
                                successThreshold:
                                  format: int32
                                  type: integer
                                tcpSocket:
                                  properties:
                                    host:
                                      type: string
                                    port:
                                      anyOf:
                                      - type: integer
                                      - type: string
                                      x-kubernetes-int-or-string: true
                                  required:
                                  - port
                                  type: object
                                terminationGracePeriodSeconds:
                                  format: int64
                                  type: integer
                                timeoutSeconds:
                                  format: int32
                                  type: integer
                              type: object
                            resources:
                              properties:
                                limits:
                                  additionalProperties:
                                    anyOf:
                                    - type: integer
                                    - type: string
                                    pattern: ^(\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))))?$
                                    x-kubernetes-int-or-string: true
                                  type: object
                                requests:
                                  additionalProperties:
                                    anyOf:
                                    - type: integer
                                    - type: string
                                    pattern: ^(\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))))?$
                                    x-kubernetes-int-or-string: true
                                  type: object
                              type: object
                            securityContext:
                              properties:
                                allowPrivilegeEscalation:
                                  type: boolean
                                capabilities:
                                  properties:
                                    add:
                                      items:
                                        type: string
                                      type: array
                                    drop:
                                      items:
                                        type: string
                                      type: array
                                  type: object
                                privileged:
                                  type: boolean
                                procMount:
                                  type: string
                                readOnlyRootFilesystem:
                                  type: boolean
                                runAsGroup:
                                  format: int64
                                  type: integer
                                runAsNonRoot:
                                  type: boolean
                                runAsUser:
                                  format: int64
                                  type: integer
                                seLinuxOptions:
                                  properties:
                                    level:
                                      type: string
                                    role:
                                      type: string
                                    type:
                                      type: string
                                    user:
                                      type: string
                                  type: object
                                seccompProfile:
                                  properties:
                                    localhostProfile:
                                      type: string
                                    type:
                                      type: string
                                  required:
                                  - type
                                  type: object
                                windowsOptions:
                                  properties:
                                    gmsaCredentialSpec:
                                      type: string
                                    gmsaCredentialSpecName:
                                      type: string
                                    hostProcess:
                                      type: boolean
                                    runAsUserName:
                                      type: string
                                  type: object
                              type: object
                            startupProbe:
                              properties:
                                exec:
                                  properties:
                                    command:
                                      items:
                                        type: string
                                      type: array
                                  type: object
                                failureThreshold:
                                  format: int32
                                  type: integer
                                grpc:
                                  properties:
                                    port:
                                      format: int32
                                      type: integer
                                    service:
                                      type: string
                                  required:
                                  - port
                                  type: object
                                httpGet:
                                  properties:
                                    host:
                                      type: string
                                    httpHeaders:
                                      items:
                                        properties:
                                          name:
                                            type: string
                                          value:
                                            type: string
                                        required:
                                        - name
                                        - value
                                        type: object
                                      type: array
                                    path:
                                      type: string
                                    port:
                                      anyOf:
                                      - type: integer
                                      - type: string
                                      x-kubernetes-int-or-string: true
                                    scheme:
                                      type: string
                                  required:
                                  - port
                                  type: object
                                initialDelaySeconds:
                                  format: int32
                                  type: integer
                                periodSeconds:
                                  format: int32
                                  type: integer
                                successThreshold:
                                  format: int32
                                  type: integer
                                tcpSocket:
                                  properties:
                                    host:
                                      type: string
                                    port:
                                      anyOf:
                                      - type: integer
                                      - type: string
                                      x-kubernetes-int-or-string: true
                                  required:
                                  - port
                                  type: object
                                terminationGracePeriodSeconds:
                                  format: int64
                                  type: integer
                                timeoutSeconds:
                                  format: int32
                                  type: integer
                              type: object
                            stdin:
                              type: boolean
                            stdinOnce:
                              type: boolean
                            targetContainerName:
                              type: string
                            terminationMessagePath:
                              type: string
                            terminationMessagePolicy:
                              type: string
                            tty:
                              type: boolean
                            volumeDevices:
                              items:
                                properties:
                                  devicePath:
                                    type: string
                                  name:
                                    type: string
                                required:
                                - devicePath
                                - name
                                type: object
                              type: array
                            volumeMounts:
                              items:
                                properties:
                                  mountPath:
                                    type: string
                                  mountPropagation:
                                    type: string
                                  name:
                                    type: string
                                  readOnly:
                                    type: boolean
                                  subPath:
                                    type: string
                                  subPathExpr:
                                    type: string
                                required:
                                - mountPath
                                - name
                                type: object
                              type: array
                            workingDir:
                              type: string
                          required:
                          - name
                          type: object
                        type: array
                      hostAliases:
                        items:
                          properties:
                            hostnames:
                              items:
                                type: string
                              type: array
                            ip:
                              type: string
                          type: object
                        type: array
                      hostIPC:
                        type: boolean
                      hostNetwork:
                        type: boolean
                      hostPID:
                        type: boolean
                      hostname:
                        type: string
                      imagePullSecrets:
                        items:
                          properties:
                            name:
                              type: string
                          type: object
                        type: array
                      initContainers:
                        items:
                          properties:
                            args:
                              items:
                                type: string
                              type: array
                            command:
                              items:
                                type: string
                              type: array
                            env:
                              items:
                                properties:
                                  name:
                                    type: string
                                  value:
                                    type: string
                                  valueFrom:
                                    properties:
                                      configMapKeyRef:
                                        properties:
                                          key:
                                            type: string
                                          name:
                                            type: string
                                          optional:
                                            type: boolean
                                        required:
                                        - key
                                        type: object
                                      fieldRef:
                                        properties:
                                          apiVersion:
                                            type: string
                                          fieldPath:
                                            type: string
                                        required:
                                        - fieldPath
                                        type: object
                                      resourceFieldRef:
                                        properties:
                                          containerName:
                                            type: string
                                          divisor:
                                            anyOf:
                                            - type: integer
                                            - type: string
                                            pattern: ^(\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))))?$
                                            x-kubernetes-int-or-string: true
                                          resource:
                                            type: string
                                        required:
                                        - resource
                                        type: object
                                      secretKeyRef:
                                        properties:
                                          key:
                                            type: string
                                          name:
                                            type: string
                                          optional:
                                            type: boolean
                                        required:
                                        - key
                                        type: object
                                    type: object
                                required:
                                - name
                                type: object
                              type: array
                            envFrom:
                              items:
                                properties:
                                  configMapRef:
                                    properties:
                                      name:
                                        type: string
                                      optional:
                                        type: boolean
                                    type: object
                                  prefix:
                                    type: string
                                  secretRef:
                                    properties:
                                      name:
                                        type: string
                                      optional:
                                        type: boolean
                                    type: object
                                type: object
                              type: array
                            image:
                              type: string
                            imagePullPolicy:
                              type: string
                            lifecycle:
                              properties:
                                postStart:
                                  properties:
                                    exec:
                                      properties:
                                        command:
                                          items:
                                            type: string
                                          type: array
                                      type: object
                                    httpGet:
                                      properties:
                                        host:
                                          type: string
                                        httpHeaders:
                                          items:
                                            properties:
                                              name:
                                                type: string
                                              value:
                                                type: string
                                            required:
                                            - name
                                            - value
                                            type: object
                                          type: array
                                        path:
                                          type: string
                                        port:
                                          anyOf:
                                          - type: integer
                                          - type: string
                                          x-kubernetes-int-or-string: true
                                        scheme:
                                          type: string
                                      required:
                                      - port
                                      type: object
                                    tcpSocket:
                                      properties:
                                        host:
                                          type: string
                                        port:
                                          anyOf:
                                          - type: integer
                                          - type: string
                                          x-kubernetes-int-or-string: true
                                      required:
                                      - port
                                      type: object
                                  type: object
                                preStop:
                                  properties:
                                    exec:
                                      properties:
                                        command:
                                          items:
                                            type: string
                                          type: array
                                      type: object
                                    httpGet:
                                      properties:
                                        host:
                                          type: string
                                        httpHeaders:
                                          items:
                                            properties:
                                              name:
                                                type: string
                                              value:
                                                type: string
                                            required:
                                            - name
                                            - value
                                            type: object
                                          type: array
                                        path:
                                          type: string
                                        port:
                                          anyOf:
                                          - type: integer
                                          - type: string
                                          x-kubernetes-int-or-string: true
                                        scheme:
                                          type: string
                                      required:
                                      - port
                                      type: object
                                    tcpSocket:
                                      properties:
                                        host:
                                          type: string
                                        port:
                                          anyOf:
                                          - type: integer
                                          - type: string
                                          x-kubernetes-int-or-string: true
                                      required:
                                      - port
                                      type: object
                                  type: object
                              type: object
                            livenessProbe:
                              properties:
                                exec:
                                  properties:
                                    command:
                                      items:
                                        type: string
                                      type: array
                                  type: object
                                failureThreshold:
                                  format: int32
                                  type: integer
                                grpc:
                                  properties:
                                    port:
                                      format: int32
                                      type: integer
                                    service:
                                      type: string
                                  required:
                                  - port
                                  type: object
                                httpGet:
                                  properties:
                                    host:
                                      type: string
                                    httpHeaders:
                                      items:
                                        properties:
                                          name:
                                            type: string
                                          value:
                                            type: string
                                        required:
                                        - name
                                        - value
                                        type: object
                                      type: array
                                    path:
                                      type: string
                                    port:
                                      anyOf:
                                      - type: integer
                                      - type: string
                                      x-kubernetes-int-or-string: true
                                    scheme:
                                      type: string
                                  required:
                                  - port
                                  type: object
                                initialDelaySeconds:
                                  format: int32
                                  type: integer
                                periodSeconds:
                                  format: int32
                                  type: integer
                                successThreshold:
                                  format: int32
                                  type: integer
                                tcpSocket:
                                  properties:
                                    host:
                                      type: string
                                    port:
                                      anyOf:
                                      - type: integer
                                      - type: string
                                      x-kubernetes-int-or-string: true
                                  required:
                                  - port
                                  type: object
                                terminationGracePeriodSeconds:
                                  format: int64
                                  type: integer
                                timeoutSeconds:
                                  format: int32
                                  type: integer
                              type: object
                            name:
                              type: string
                            ports:
                              items:
                                properties:
                                  containerPort:
                                    format: int32
                                    type: integer
                                  hostIP:
                                    type: string
                                  hostPort:
                                    format: int32
                                    type: integer
                                  name:
                                    type: string
                                  protocol:
                                    default: TCP
                                    type: string
                                required:
                                - containerPort
                                type: object
                              type: array
                              x-kubernetes-list-map-keys:
                              - containerPort
                              - protocol
                              x-kubernetes-list-type: map
                            readinessProbe:
                              properties:
                                exec:
                                  properties:
                                    command:
                                      items:
                                        type: string
                                      type: array
                                  type: object
                                failureThreshold:
                                  format: int32
                                  type: integer
                                grpc:
                                  properties:
                                    port:
                                      format: int32
                                      type: integer
                                    service:
                                      type: string
                                  required:
                                  - port
                                  type: object
                                httpGet:
                                  properties:
                                    host:
                                      type: string
                                    httpHeaders:
                                      items:
                                        properties:
                                          name:
                                            type: string
                                          value:
                                            type: string
                                        required:
                                        - name
                                        - value
                                        type: object
                                      type: array
                                    path:
                                      type: string
                                    port:
                                      anyOf:
                                      - type: integer
                                      - type: string
                                      x-kubernetes-int-or-string: true
                                    scheme:
                                      type: string
                                  required:
                                  - port
                                  type: object
                                initialDelaySeconds:
                                  format: int32
                                  type: integer
                                periodSeconds:
                                  format: int32
                                  type: integer
                                successThreshold:
                                  format: int32
                                  type: integer
                                tcpSocket:
                                  properties:
                                    host:
                                      type: string
                                    port:
                                      anyOf:
                                      - type: integer
                                      - type: string
                                      x-kubernetes-int-or-string: true
                                  required:
                                  - port
                                  type: object
                                terminationGracePeriodSeconds:
                                  format: int64
                                  type: integer
                                timeoutSeconds:
                                  format: int32
                                  type: integer
                              type: object
                            resources:
                              properties:
                                limits:
                                  additionalProperties:
                                    anyOf:
                                    - type: integer
                                    - type: string
                                    pattern: ^(\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))))?$
                                    x-kubernetes-int-or-string: true
                                  type: object
                                requests:
                                  additionalProperties:
                                    anyOf:
                                    - type: integer
                                    - type: string
                                    pattern: ^(\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))))?$
                                    x-kubernetes-int-or-string: true
                                  type: object
                              type: object
                            securityContext:
                              properties:
                                allowPrivilegeEscalation:
                                  type: boolean
                                capabilities:
                                  properties:
                                    add:
                                      items:
                                        type: string
                                      type: array
                                    drop:
                                      items:
                                        type: string
                                      type: array
                                  type: object
                                privileged:
                                  type: boolean
                                procMount:
                                  type: string
                                readOnlyRootFilesystem:
                                  type: boolean
                                runAsGroup:
                                  format: int64
                                  type: integer
                                runAsNonRoot:
                                  type: boolean
                                runAsUser:
                                  format: int64
                                  type: integer
                                seLinuxOptions:
                                  properties:
                                    level:
                                      type: string
                                    role:
                                      type: string
                                    type:
                                      type: string
                                    user:
                                      type: string
                                  type: object
                                seccompProfile:
                                  properties:
                                    localhostProfile:
                                      type: string
                                    type:
                                      type: string
                                  required:
                                  - type
                                  type: object
                                windowsOptions:
                                  properties:
                                    gmsaCredentialSpec:
                                      type: string
                                    gmsaCredentialSpecName:
                                      type: string
                                    hostProcess:
                                      type: boolean
                                    runAsUserName:
                                      type: string
                                  type: object
                              type: object
                            startupProbe:
                              properties:
                                exec:
                                  properties:
                                    command:
                                      items:
                                        type: string
                                      type: array
                                  type: object
                                failureThreshold:
                                  format: int32
                                  type: integer
                                grpc:
                                  properties:
                                    port:
                                      format: int32
                                      type: integer
                                    service:
                                      type: string
                                  required:
                                  - port
                                  type: object
                                httpGet:
                                  properties:
                                    host:
                                      type: string
                                    httpHeaders:
                                      items:
                                        properties:
                                          name:
                                            type: string
                                          value:
                                            type: string
                                        required:
                                        - name
                                        - value
                                        type: object
                                      type: array
                                    path:
                                      type: string
                                    port:
                                      anyOf:
                                      - type: integer
                                      - type: string
                                      x-kubernetes-int-or-string: true
                                    scheme:
                                      type: string
                                  required:
                                  - port
                                  type: object
                                initialDelaySeconds:
                                  format: int32
                                  type: integer
                                periodSeconds:
                                  format: int32
                                  type: integer
                                successThreshold:
                                  format: int32
                                  type: integer
                                tcpSocket:
                                  properties:
                                    host:
                                      type: string
                                    port:
                                      anyOf:
                                      - type: integer
                                      - type: string
                                      x-kubernetes-int-or-string: true
                                  required:
                                  - port
                                  type: object
                                terminationGracePeriodSeconds:
                                  format: int64
                                  type: integer
                                timeoutSeconds:
                                  format: int32
                                  type: integer
                              type: object
                            stdin:
                              type: boolean
                            stdinOnce:
                              type: boolean
                            terminationMessagePath:
                              type: string
                            terminationMessagePolicy:
                              type: string
                            tty:
                              type: boolean
                            volumeDevices:
                              items:
                                properties:
                                  devicePath:
                                    type: string
                                  name:
                                    type: string
                                required:
                                - devicePath
                                - name
                                type: object
                              type: array
                            volumeMounts:
                              items:
                                properties:
                                  mountPath:
                                    type: string
                                  mountPropagation:
                                    type: string
                                  name:
                                    type: string
                                  readOnly:
                                    type: boolean
                                  subPath:
                                    type: string
                                  subPathExpr:
                                    type: string
                                required:
                                - mountPath
                                - name
                                type: object
                              type: array
                            workingDir:
                              type: string
                          required:
                          - name
                          type: object
                        type: array
                      nodeName:
                        type: string
                      nodeSelector:
                        additionalProperties:
                          type: string
                        type: object
                        x-kubernetes-map-type: atomic
                      os:
                        properties:
                          name:
                            type: string
                        required:
                        - name
                        type: object
                      overhead:
                        additionalProperties:
                          anyOf:
                          - type: integer
                          - type: string
                          pattern: ^(\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))))?$
                          x-kubernetes-int-or-string: true
                        type: object
                      preemptionPolicy:
                        type: string
                      priority:
                        format: int32
                        type: integer
                      priorityClassName:
                        type: string
                      readinessGates:
                        items:
                          properties:
                            conditionType:
                              type: string
                          required:
                          - conditionType
                          type: object
                        type: array
                      restartPolicy:
                        type: string
                      runtimeClassName:
                        type: string
                      schedulerName:
                        type: string
                      securityContext:
                        properties:
                          fsGroup:
                            format: int64
                            type: integer
                          fsGroupChangePolicy:
                            type: string
                          runAsGroup:
                            format: int64
                            type: integer
                          runAsNonRoot:
                            type: boolean
                          runAsUser:
                            format: int64
                            type: integer
                          seLinuxOptions:
                            properties:
                              level:
                                type: string
                              role:
                                type: string
                              type:
                                type: string
                              user:
                                type: string
                            type: object
                          seccompProfile:
                            properties:
                              localhostProfile:
                                type: string
                              type:
                                type: string
                            required:
                            - type
                            type: object
                          supplementalGroups:
                            items:
                              format: int64
                              type: integer
                            type: array
                          sysctls:
                            items:
                              properties:
                                name:
                                  type: string
                                value:
                                  type: string
                              required:
                              - name
                              - value
                              type: object
                            type: array
                          windowsOptions:
                            properties:
                              gmsaCredentialSpec:
                                type: string
                              gmsaCredentialSpecName:
                                type: string
                              hostProcess:
                                type: boolean
                              runAsUserName:
                                type: string
                            type: object
                        type: object
                      serviceAccount:
                        type: string
                      serviceAccountName:
                        type: string
                      setHostnameAsFQDN:
                        type: boolean
                      shareProcessNamespace:
                        type: boolean
                      subdomain:
                        type: string
                      terminationGracePeriodSeconds:
                        format: int64
                        type: integer
                      tolerations:
                        items:
                          properties:
                            effect:
                              type: string
                            key:
                              type: string
                            operator:
                              type: string
                            tolerationSeconds:
                              format: int64
                              type: integer
                            value:
                              type: string
                          type: object
                        type: array
                      topologySpreadConstraints:
                        items:
                          properties:
                            labelSelector:
                              properties:
                                matchExpressions:
                                  items:
                                    properties:
                                      key:
                                        type: string
                                      operator:
                                        type: string
                                      values:
                                        items:
                                          type: string
                                        type: array
                                    required:
                                    - key
                                    - operator
                                    type: object
                                  type: array
                                matchLabels:
                                  additionalProperties:
                                    type: string
                                  type: object
                              type: object
                            maxSkew:
                              format: int32
                              type: integer
                            topologyKey:
                              type: string
                            whenUnsatisfiable:
                              type: string
                          required:
                          - maxSkew
                          - topologyKey
                          - whenUnsatisfiable
                          type: object
                        type: array
                        x-kubernetes-list-map-keys:
                        - topologyKey
                        - whenUnsatisfiable
                        x-kubernetes-list-type: map
                      volumes:
                        items:
                          properties:
                            awsElasticBlockStore:
                              properties:
                                fsType:
                                  type: string
                                partition:
                                  format: int32
                                  type: integer
                                readOnly:
                                  type: boolean
                                volumeID:
                                  type: string
                              required:
                              - volumeID
                              type: object
                            azureDisk:
                              properties:
                                cachingMode:
                                  type: string
                                diskName:
                                  type: string
                                diskURI:
                                  type: string
                                fsType:
                                  type: string
                                kind:
                                  type: string
                                readOnly:
                                  type: boolean
                              required:
                              - diskName
                              - diskURI
                              type: object
                            azureFile:
                              properties:
                                readOnly:
                                  type: boolean
                                secretName:
                                  type: string
                                shareName:
                                  type: string
                              required:
                              - secretName
                              - shareName
                              type: object
                            cephfs:
                              properties:
                                monitors:
                                  items:
                                    type: string
                                  type: array
                                path:
                                  type: string
                                readOnly:
                                  type: boolean
                                secretFile:
                                  type: string
                                secretRef:
                                  properties:
                                    name:
                                      type: string
                                  type: object
                                user:
                                  type: string
                              required:
                              - monitors
                              type: object
                            cinder:
                              properties:
                                fsType:
                                  type: string
                                readOnly:
                                  type: boolean
                                secretRef:
                                  properties:
                                    name:
                                      type: string
                                  type: object
                                volumeID:
                                  type: string
                              required:
                              - volumeID
                              type: object
                            configMap:
                              properties:
                                defaultMode:
                                  format: int32
                                  type: integer
                                items:
                                  items:
                                    properties:
                                      key:
                                        type: string
                                      mode:
                                        format: int32
                                        type: integer
                                      path:
                                        type: string
                                    required:
                                    - key
                                    - path
                                    type: object
                                  type: array
                                name:
                                  type: string
                                optional:
                                  type: boolean
                              type: object
                            csi:
                              properties:
                                driver:
                                  type: string
                                fsType:
                                  type: string
                                nodePublishSecretRef:
                                  properties:
                                    name:
                                      type: string
                                  type: object
                                readOnly:
                                  type: boolean
                                volumeAttributes:
                                  additionalProperties:
                                    type: string
                                  type: object
                              required:
                              - driver
                              type: object
                            downwardAPI:
                              properties:
                                defaultMode:
                                  format: int32
                                  type: integer
                                items:
                                  items:
                                    properties:
                                      fieldRef:
                                        properties:
                                          apiVersion:
                                            type: string
                                          fieldPath:
                                            type: string
                                        required:
                                        - fieldPath
                                        type: object
                                      mode:
                                        format: int32
                                        type: integer
                                      path:
                                        type: string
                                      resourceFieldRef:
                                        properties:
                                          containerName:
                                            type: string
                                          divisor:
                                            anyOf:
                                            - type: integer
                                            - type: string
                                            pattern: ^(\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))))?$
                                            x-kubernetes-int-or-string: true
                                          resource:
                                            type: string
                                        required:
                                        - resource
                                        type: object
                                    required:
                                    - path
                                    type: object
                                  type: array
                              type: object
                            emptyDir:
                              properties:
                                medium:
                                  type: string
                                sizeLimit:
                                  anyOf:
                                  - type: integer
                                  - type: string
                                  pattern: ^(\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))))?$
                                  x-kubernetes-int-or-string: true
                              type: object
                            ephemeral:
                              properties:
                                volumeClaimTemplate:
                                  properties:
                                    metadata:
                                      type: object
                                    spec:
                                      properties:
                                        accessModes:
                                          items:
                                            type: string
                                          type: array
                                        dataSource:
                                          properties:
                                            apiGroup:
                                              type: string
                                            kind:
                                              type: string
                                            name:
                                              type: string
                                          required:
                                          - kind
                                          - name
                                          type: object
                                        dataSourceRef:
                                          properties:
                                            apiGroup:
                                              type: string
                                            kind:
                                              type: string
                                            name:
                                              type: string
                                          required:
                                          - kind
                                          - name
                                          type: object
                                        resources:
                                          properties:
                                            limits:
                                              additionalProperties:
                                                anyOf:
                                                - type: integer
                                                - type: string
                                                pattern: ^(\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))))?$
                                                x-kubernetes-int-or-string: true
                                              type: object
                                            requests:
                                              additionalProperties:
                                                anyOf:
                                                - type: integer
                                                - type: string
                                                pattern: ^(\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))))?$
                                                x-kubernetes-int-or-string: true
                                              type: object
                                          type: object
                                        selector:
                                          properties:
                                            matchExpressions:
                                              items:
                                                properties:
                                                  key:
                                                    type: string
                                                  operator:
                                                    type: string
                                                  values:
                                                    items:
                                                      type: string
                                                    type: array
                                                required:
                                                - key
                                                - operator
                                                type: object
                                              type: array
                                            matchLabels:
                                              additionalProperties:
                                                type: string
                                              type: object
                                          type: object
                                        storageClassName:
                                          type: string
                                        volumeMode:
                                          type: string
                                        volumeName:
                                          type: string
                                      type: object
                                  required:
                                  - spec
                                  type: object
                              type: object
                            fc:
                              properties:
                                fsType:
                                  type: string
                                lun:
                                  format: int32
                                  type: integer
                                readOnly:
                                  type: boolean
                                targetWWNs:
                                  items:
                                    type: string
                                  type: array
                                wwids:
                                  items:
                                    type: string
                                  type: array
                              type: object
                            flexVolume:
                              properties:
                                driver:
                                  type: string
                                fsType:
                                  type: string
                                options:
                                  additionalProperties:
                                    type: string
                                  type: object
                                readOnly:
                                  type: boolean
                                secretRef:
                                  properties:
                                    name:
                                      type: string
                                  type: object
                              required:
                              - driver
                              type: object
                            flocker:
                              properties:
                                datasetName:
                                  type: string
                                datasetUUID:
                                  type: string
                              type: object
                            gcePersistentDisk:
                              properties:
                                fsType:
                                  type: string
                                partition:
                                  format: int32
                                  type: integer
                                pdName:
                                  type: string
                                readOnly:
                                  type: boolean
                              required:
                              - pdName
                              type: object
                            gitRepo:
                              properties:
                                directory:
                                  type: string
                                repository:
                                  type: string
                                revision:
                                  type: string
                              required:
                              - repository
                              type: object
                            glusterfs:
                              properties:
                                endpoints:
                                  type: string
                                path:
                                  type: string
                                readOnly:
                                  type: boolean
                              required:
                              - endpoints
                              - path
                              type: object
                            hostPath:
                              properties:
                                path:
                                  type: string
                                type:
                                  type: string
                              required:
                              - path
                              type: object
                            iscsi:
                              properties:
                                chapAuthDiscovery:
                                  type: boolean
                                chapAuthSession:
                                  type: boolean
                                fsType:
                                  type: string
                                initiatorName:
                                  type: string
                                iqn:
                                  type: string
                                iscsiInterface:
                                  type: string
                                lun:
                                  format: int32
                                  type: integer
                                portals:
                                  items:
                                    type: string
                                  type: array
                                readOnly:
                                  type: boolean
                                secretRef:
                                  properties:
                                    name:
                                      type: string
                                  type: object
                                targetPortal:
                                  type: string
                              required:
                              - iqn
                              - lun
                              - targetPortal
                              type: object
                            name:
                              type: string
                            nfs:
                              properties:
                                path:
                                  type: string
                                readOnly:
                                  type: boolean
                                server:
                                  type: string
                              required:
                              - path
                              - server
                              type: object
                            persistentVolumeClaim:
                              properties:
                                claimName:
                                  type: string
                                readOnly:
                                  type: boolean
                              required:
                              - claimName
                              type: object
                            photonPersistentDisk:
                              properties:
                                fsType:
                                  type: string
                                pdID:
                                  type: string
                              required:
                              - pdID
                              type: object
                            portworxVolume:
                              properties:
                                fsType:
                                  type: string
                                readOnly:
                                  type: boolean
                                volumeID:
                                  type: string
                              required:
                              - volumeID
                              type: object
                            projected:
                              properties:
                                defaultMode:
                                  format: int32
                                  type: integer
                                sources:
                                  items:
                                    properties:
                                      configMap:
                                        properties:
                                          items:
                                            items:
                                              properties:
                                                key:
                                                  type: string
                                                mode:
                                                  format: int32
                                                  type: integer
                                                path:
                                                  type: string
                                              required:
                                              - key
                                              - path
                                              type: object
                                            type: array
                                          name:
                                            type: string
                                          optional:
                                            type: boolean
                                        type: object
                                      downwardAPI:
                                        properties:
                                          items:
                                            items:
                                              properties:
                                                fieldRef:
                                                  properties:
                                                    apiVersion:
                                                      type: string
                                                    fieldPath:
                                                      type: string
                                                  required:
                                                  - fieldPath
                                                  type: object
                                                mode:
                                                  format: int32
                                                  type: integer
                                                path:
                                                  type: string
                                                resourceFieldRef:
                                                  properties:
                                                    containerName:
                                                      type: string
                                                    divisor:
                                                      anyOf:
                                                      - type: integer
                                                      - type: string
                                                      pattern: ^(\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))))?$
                                                      x-kubernetes-int-or-string: true
                                                    resource:
                                                      type: string
                                                  required:
                                                  - resource
                                                  type: object
                                              required:
                                              - path
                                              type: object
                                            type: array
                                        type: object
                                      secret:
                                        properties:
                                          items:
                                            items:
                                              properties:
                                                key:
                                                  type: string
                                                mode:
                                                  format: int32
                                                  type: integer
                                                path:
                                                  type: string
                                              required:
                                              - key
                                              - path
                                              type: object
                                            type: array
                                          name:
                                            type: string
                                          optional:
                                            type: boolean
                                        type: object
                                      serviceAccountToken:
                                        properties:
                                          audience:
                                            type: string
                                          expirationSeconds:
                                            format: int64
                                            type: integer
                                          path:
                                            type: string
                                        required:
                                        - path
                                        type: object
                                    type: object
                                  type: array
                              type: object
                            quobyte:
                              properties:
                                group:
                                  type: string
                                readOnly:
                                  type: boolean
                                registry:
                                  type: string
                                tenant:
                                  type: string
                                user:
                                  type: string
                                volume:
                                  type: string
                              required:
                              - registry
                              - volume
                              type: object
                            rbd:
                              properties:
                                fsType:
                                  type: string
                                image:
                                  type: string
                                keyring:
                                  type: string
                                monitors:
                                  items:
                                    type: string
                                  type: array
                                pool:
                                  type: string
                                readOnly:
                                  type: boolean
                                secretRef:
                                  properties:
                                    name:
                                      type: string
                                  type: object
                                user:
                                  type: string
                              required:
                              - image
                              - monitors
                              type: object
                            scaleIO:
                              properties:
                                fsType:
                                  type: string
                                gateway:
                                  type: string
                                protectionDomain:
                                  type: string
                                readOnly:
                                  type: boolean
                                secretRef:
                                  properties:
                                    name:
                                      type: string
                                  type: object
                                sslEnabled:
                                  type: boolean
                                storageMode:
                                  type: string
                                storagePool:
                                  type: string
                                system:
                                  type: string
                                volumeName:
                                  type: string
                              required:
                              - gateway
                              - secretRef
                              - system
                              type: object
                            secret:
                              properties:
                                defaultMode:
                                  format: int32
                                  type: integer
                                items:
                                  items:
                                    properties:
                                      key:
                                        type: string
                                      mode:
                                        format: int32
                                        type: integer
                                      path:
                                        type: string
                                    required:
                                    - key
                                    - path
                                    type: object
                                  type: array
                                optional:
                                  type: boolean
                                secretName:
                                  type: string
                              type: object
                            storageos:
                              properties:
                                fsType:
                                  type: string
                                readOnly:
                                  type: boolean
                                secretRef:
                                  properties:
                                    name:
                                      type: string
                                  type: object
                                volumeName:
                                  type: string
                                volumeNamespace:
                                  type: string
                              type: object
                            vsphereVolume:
                              properties:
                                fsType:
                                  type: string
                                storagePolicyID:
                                  type: string
                                storagePolicyName:
                                  type: string
                                volumePath:
                                  type: string
                              required:
                              - volumePath
                              type: object
                          required:
                          - name
                          type: object
                        type: array
                    required:
                    - containers
                    type: object
                type: object
            type: object
          status:
            properties:
              conditions:
                items:
                  properties:
                    lastProbeTime:
                      format: date-time
                      type: string
                    lastTransitionTime:
                      format: date-time
                      type: string
                    message:
                      type: string
                    reason:
                      type: string
                    status:
                      type: string
                    type:
                      type: string
                  required:
                  - status
                  - type
                  type: object
                type: array
              containerState:
                properties:
                  running:
                    properties:
                      startedAt:
                        format: date-time
                        type: string
                    type: object
                  terminated:
                    properties:
                      containerID:
                        type: string
                      exitCode:
                        format: int32
                        type: integer
                      finishedAt:
                        format: date-time
                        type: string
                      message:
                        type: string
                      reason:
                        type: string
                      signal:
                        format: int32
                        type: integer
                      startedAt:
                        format: date-time
                        type: string
                    required:
                    - exitCode
                    type: object
                  waiting:
                    properties:
                      message:
                        type: string
                      reason:
                        type: string
                    type: object
                type: object
              readyReplicas:
                format: int32
                type: integer
            required:
            - conditions
            - containerState
            - readyReplicas
            type: object
        type: object
    served: true
    storage: false
    subresources:
      status: {}
  - name: v1beta1
    schema:
      openAPIV3Schema:
        properties:
          apiVersion:
            type: string
          kind:
            type: string
          metadata:
            type: object
          spec:
            properties:
              template:
                properties:
                  spec:
                    properties:
                      activeDeadlineSeconds:
                        format: int64
                        type: integer
                      affinity:
                        properties:
                          nodeAffinity:
                            properties:
                              preferredDuringSchedulingIgnoredDuringExecution:
                                items:
                                  properties:
                                    preference:
                                      properties:
                                        matchExpressions:
                                          items:
                                            properties:
                                              key:
                                                type: string
                                              operator:
                                                type: string
                                              values:
                                                items:
                                                  type: string
                                                type: array
                                            required:
                                            - key
                                            - operator
                                            type: object
                                          type: array
                                        matchFields:
                                          items:
                                            properties:
                                              key:
                                                type: string
                                              operator:
                                                type: string
                                              values:
                                                items:
                                                  type: string
                                                type: array
                                            required:
                                            - key
                                            - operator
                                            type: object
                                          type: array
                                      type: object
                                    weight:
                                      format: int32
                                      type: integer
                                  required:
                                  - preference
                                  - weight
                                  type: object
                                type: array
                              requiredDuringSchedulingIgnoredDuringExecution:
                                properties:
                                  nodeSelectorTerms:
                                    items:
                                      properties:
                                        matchExpressions:
                                          items:
                                            properties:
                                              key:
                                                type: string
                                              operator:
                                                type: string
                                              values:
                                                items:
                                                  type: string
                                                type: array
                                            required:
                                            - key
                                            - operator
                                            type: object
                                          type: array
                                        matchFields:
                                          items:
                                            properties:
                                              key:
                                                type: string
                                              operator:
                                                type: string
                                              values:
                                                items:
                                                  type: string
                                                type: array
                                            required:
                                            - key
                                            - operator
                                            type: object
                                          type: array
                                      type: object
                                    type: array
                                required:
                                - nodeSelectorTerms
                                type: object
                            type: object
                          podAffinity:
                            properties:
                              preferredDuringSchedulingIgnoredDuringExecution:
                                items:
                                  properties:
                                    podAffinityTerm:
                                      properties:
                                        labelSelector:
                                          properties:
                                            matchExpressions:
                                              items:
                                                properties:
                                                  key:
                                                    type: string
                                                  operator:
                                                    type: string
                                                  values:
                                                    items:
                                                      type: string
                                                    type: array
                                                required:
                                                - key
                                                - operator
                                                type: object
                                              type: array
                                            matchLabels:
                                              additionalProperties:
                                                type: string
                                              type: object
                                          type: object
                                        namespaceSelector:
                                          properties:
                                            matchExpressions:
                                              items:
                                                properties:
                                                  key:
                                                    type: string
                                                  operator:
                                                    type: string
                                                  values:
                                                    items:
                                                      type: string
                                                    type: array
                                                required:
                                                - key
                                                - operator
                                                type: object
                                              type: array
                                            matchLabels:
                                              additionalProperties:
                                                type: string
                                              type: object
                                          type: object
                                        namespaces:
                                          items:
                                            type: string
                                          type: array
                                        topologyKey:
                                          type: string
                                      required:
                                      - topologyKey
                                      type: object
                                    weight:
                                      format: int32
                                      type: integer
                                  required:
                                  - podAffinityTerm
                                  - weight
                                  type: object
                                type: array
                              requiredDuringSchedulingIgnoredDuringExecution:
                                items:
                                  properties:
                                    labelSelector:
                                      properties:
                                        matchExpressions:
                                          items:
                                            properties:
                                              key:
                                                type: string
                                              operator:
                                                type: string
                                              values:
                                                items:
                                                  type: string
                                                type: array
                                            required:
                                            - key
                                            - operator
                                            type: object
                                          type: array
                                        matchLabels:
                                          additionalProperties:
                                            type: string
                                          type: object
                                      type: object
                                    namespaceSelector:
                                      properties:
                                        matchExpressions:
                                          items:
                                            properties:
                                              key:
                                                type: string
                                              operator:
                                                type: string
                                              values:
                                                items:
                                                  type: string
                                                type: array
                                            required:
                                            - key
                                            - operator
                                            type: object
                                          type: array
                                        matchLabels:
                                          additionalProperties:
                                            type: string
                                          type: object
                                      type: object
                                    namespaces:
                                      items:
                                        type: string
                                      type: array
                                    topologyKey:
                                      type: string
                                  required:
                                  - topologyKey
                                  type: object
                                type: array
                            type: object
                          podAntiAffinity:
                            properties:
                              preferredDuringSchedulingIgnoredDuringExecution:
                                items:
                                  properties:
                                    podAffinityTerm:
                                      properties:
                                        labelSelector:
                                          properties:
                                            matchExpressions:
                                              items:
                                                properties:
                                                  key:
                                                    type: string
                                                  operator:
                                                    type: string
                                                  values:
                                                    items:
                                                      type: string
                                                    type: array
                                                required:
                                                - key
                                                - operator
                                                type: object
                                              type: array
                                            matchLabels:
                                              additionalProperties:
                                                type: string
                                              type: object
                                          type: object
                                        namespaceSelector:
                                          properties:
                                            matchExpressions:
                                              items:
                                                properties:
                                                  key:
                                                    type: string
                                                  operator:
                                                    type: string
                                                  values:
                                                    items:
                                                      type: string
                                                    type: array
                                                required:
                                                - key
                                                - operator
                                                type: object
                                              type: array
                                            matchLabels:
                                              additionalProperties:
                                                type: string
                                              type: object
                                          type: object
                                        namespaces:
                                          items:
                                            type: string
                                          type: array
                                        topologyKey:
                                          type: string
                                      required:
                                      - topologyKey
                                      type: object
                                    weight:
                                      format: int32
                                      type: integer
                                  required:
                                  - podAffinityTerm
                                  - weight
                                  type: object
                                type: array
                              requiredDuringSchedulingIgnoredDuringExecution:
                                items:
                                  properties:
                                    labelSelector:
                                      properties:
                                        matchExpressions:
                                          items:
                                            properties:
                                              key:
                                                type: string
                                              operator:
                                                type: string
                                              values:
                                                items:
                                                  type: string
                                                type: array
                                            required:
                                            - key
                                            - operator
                                            type: object
                                          type: array
                                        matchLabels:
                                          additionalProperties:
                                            type: string
                                          type: object
                                      type: object
                                    namespaceSelector:
                                      properties:
                                        matchExpressions:
                                          items:
                                            properties:
                                              key:
                                                type: string
                                              operator:
                                                type: string
                                              values:
                                                items:
                                                  type: string
                                                type: array
                                            required:
                                            - key
                                            - operator
                                            type: object
                                          type: array
                                        matchLabels:
                                          additionalProperties:
                                            type: string
                                          type: object
                                      type: object
                                    namespaces:
                                      items:
                                        type: string
                                      type: array
                                    topologyKey:
                                      type: string
                                  required:
                                  - topologyKey
                                  type: object
                                type: array
                            type: object
                        type: object
                      automountServiceAccountToken:
                        type: boolean
                      containers:
                        items:
                          properties:
                            args:
                              items:
                                type: string
                              type: array
                            command:
                              items:
                                type: string
                              type: array
                            env:
                              items:
                                properties:
                                  name:
                                    type: string
                                  value:
                                    type: string
                                  valueFrom:
                                    properties:
                                      configMapKeyRef:
                                        properties:
                                          key:
                                            type: string
                                          name:
                                            type: string
                                          optional:
                                            type: boolean
                                        required:
                                        - key
                                        type: object
                                      fieldRef:
                                        properties:
                                          apiVersion:
                                            type: string
                                          fieldPath:
                                            type: string
                                        required:
                                        - fieldPath
                                        type: object
                                      resourceFieldRef:
                                        properties:
                                          containerName:
                                            type: string
                                          divisor:
                                            anyOf:
                                            - type: integer
                                            - type: string
                                            pattern: ^(\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))))?$
                                            x-kubernetes-int-or-string: true
                                          resource:
                                            type: string
                                        required:
                                        - resource
                                        type: object
                                      secretKeyRef:
                                        properties:
                                          key:
                                            type: string
                                          name:
                                            type: string
                                          optional:
                                            type: boolean
                                        required:
                                        - key
                                        type: object
                                    type: object
                                required:
                                - name
                                type: object
                              type: array
                            envFrom:
                              items:
                                properties:
                                  configMapRef:
                                    properties:
                                      name:
                                        type: string
                                      optional:
                                        type: boolean
                                    type: object
                                  prefix:
                                    type: string
                                  secretRef:
                                    properties:
                                      name:
                                        type: string
                                      optional:
                                        type: boolean
                                    type: object
                                type: object
                              type: array
                            image:
                              type: string
                            imagePullPolicy:
                              type: string
                            lifecycle:
                              properties:
                                postStart:
                                  properties:
                                    exec:
                                      properties:
                                        command:
                                          items:
                                            type: string
                                          type: array
                                      type: object
                                    httpGet:
                                      properties:
                                        host:
                                          type: string
                                        httpHeaders:
                                          items:
                                            properties:
                                              name:
                                                type: string
                                              value:
                                                type: string
                                            required:
                                            - name
                                            - value
                                            type: object
                                          type: array
                                        path:
                                          type: string
                                        port:
                                          anyOf:
                                          - type: integer
                                          - type: string
                                          x-kubernetes-int-or-string: true
                                        scheme:
                                          type: string
                                      required:
                                      - port
                                      type: object
                                    tcpSocket:
                                      properties:
                                        host:
                                          type: string
                                        port:
                                          anyOf:
                                          - type: integer
                                          - type: string
                                          x-kubernetes-int-or-string: true
                                      required:
                                      - port
                                      type: object
                                  type: object
                                preStop:
                                  properties:
                                    exec:
                                      properties:
                                        command:
                                          items:
                                            type: string
                                          type: array
                                      type: object
                                    httpGet:
                                      properties:
                                        host:
                                          type: string
                                        httpHeaders:
                                          items:
                                            properties:
                                              name:
                                                type: string
                                              value:
                                                type: string
                                            required:
                                            - name
                                            - value
                                            type: object
                                          type: array
                                        path:
                                          type: string
                                        port:
                                          anyOf:
                                          - type: integer
                                          - type: string
                                          x-kubernetes-int-or-string: true
                                        scheme:
                                          type: string
                                      required:
                                      - port
                                      type: object
                                    tcpSocket:
                                      properties:
                                        host:
                                          type: string
                                        port:
                                          anyOf:
                                          - type: integer
                                          - type: string
                                          x-kubernetes-int-or-string: true
                                      required:
                                      - port
                                      type: object
                                  type: object
                              type: object
                            livenessProbe:
                              properties:
                                exec:
                                  properties:
                                    command:
                                      items:
                                        type: string
                                      type: array
                                  type: object
                                failureThreshold:
                                  format: int32
                                  type: integer
                                grpc:
                                  properties:
                                    port:
                                      format: int32
                                      type: integer
                                    service:
                                      type: string
                                  required:
                                  - port
                                  type: object
                                httpGet:
                                  properties:
                                    host:
                                      type: string
                                    httpHeaders:
                                      items:
                                        properties:
                                          name:
                                            type: string
                                          value:
                                            type: string
                                        required:
                                        - name
                                        - value
                                        type: object
                                      type: array
                                    path:
                                      type: string
                                    port:
                                      anyOf:
                                      - type: integer
                                      - type: string
                                      x-kubernetes-int-or-string: true
                                    scheme:
                                      type: string
                                  required:
                                  - port
                                  type: object
                                initialDelaySeconds:
                                  format: int32
                                  type: integer
                                periodSeconds:
                                  format: int32
                                  type: integer
                                successThreshold:
                                  format: int32
                                  type: integer
                                tcpSocket:
                                  properties:
                                    host:
                                      type: string
                                    port:
                                      anyOf:
                                      - type: integer
                                      - type: string
                                      x-kubernetes-int-or-string: true
                                  required:
                                  - port
                                  type: object
                                terminationGracePeriodSeconds:
                                  format: int64
                                  type: integer
                                timeoutSeconds:
                                  format: int32
                                  type: integer
                              type: object
                            name:
                              type: string
                            ports:
                              items:
                                properties:
                                  containerPort:
                                    format: int32
                                    type: integer
                                  hostIP:
                                    type: string
                                  hostPort:
                                    format: int32
                                    type: integer
                                  name:
                                    type: string
                                  protocol:
                                    default: TCP
                                    type: string
                                required:
                                - containerPort
                                type: object
                              type: array
                              x-kubernetes-list-map-keys:
                              - containerPort
                              - protocol
                              x-kubernetes-list-type: map
                            readinessProbe:
                              properties:
                                exec:
                                  properties:
                                    command:
                                      items:
                                        type: string
                                      type: array
                                  type: object
                                failureThreshold:
                                  format: int32
                                  type: integer
                                grpc:
                                  properties:
                                    port:
                                      format: int32
                                      type: integer
                                    service:
                                      type: string
                                  required:
                                  - port
                                  type: object
                                httpGet:
                                  properties:
                                    host:
                                      type: string
                                    httpHeaders:
                                      items:
                                        properties:
                                          name:
                                            type: string
                                          value:
                                            type: string
                                        required:
                                        - name
                                        - value
                                        type: object
                                      type: array
                                    path:
                                      type: string
                                    port:
                                      anyOf:
                                      - type: integer
                                      - type: string
                                      x-kubernetes-int-or-string: true
                                    scheme:
                                      type: string
                                  required:
                                  - port
                                  type: object
                                initialDelaySeconds:
                                  format: int32
                                  type: integer
                                periodSeconds:
                                  format: int32
                                  type: integer
                                successThreshold:
                                  format: int32
                                  type: integer
                                tcpSocket:
                                  properties:
                                    host:
                                      type: string
                                    port:
                                      anyOf:
                                      - type: integer
                                      - type: string
                                      x-kubernetes-int-or-string: true
                                  required:
                                  - port
                                  type: object
                                terminationGracePeriodSeconds:
                                  format: int64
                                  type: integer
                                timeoutSeconds:
                                  format: int32
                                  type: integer
                              type: object
                            resources:
                              properties:
                                limits:
                                  additionalProperties:
                                    anyOf:
                                    - type: integer
                                    - type: string
                                    pattern: ^(\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))))?$
                                    x-kubernetes-int-or-string: true
                                  type: object
                                requests:
                                  additionalProperties:
                                    anyOf:
                                    - type: integer
                                    - type: string
                                    pattern: ^(\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))))?$
                                    x-kubernetes-int-or-string: true
                                  type: object
                              type: object
                            securityContext:
                              properties:
                                allowPrivilegeEscalation:
                                  type: boolean
                                capabilities:
                                  properties:
                                    add:
                                      items:
                                        type: string
                                      type: array
                                    drop:
                                      items:
                                        type: string
                                      type: array
                                  type: object
                                privileged:
                                  type: boolean
                                procMount:
                                  type: string
                                readOnlyRootFilesystem:
                                  type: boolean
                                runAsGroup:
                                  format: int64
                                  type: integer
                                runAsNonRoot:
                                  type: boolean
                                runAsUser:
                                  format: int64
                                  type: integer
                                seLinuxOptions:
                                  properties:
                                    level:
                                      type: string
                                    role:
                                      type: string
                                    type:
                                      type: string
                                    user:
                                      type: string
                                  type: object
                                seccompProfile:
                                  properties:
                                    localhostProfile:
                                      type: string
                                    type:
                                      type: string
                                  required:
                                  - type
                                  type: object
                                windowsOptions:
                                  properties:
                                    gmsaCredentialSpec:
                                      type: string
                                    gmsaCredentialSpecName:
                                      type: string
                                    hostProcess:
                                      type: boolean
                                    runAsUserName:
                                      type: string
                                  type: object
                              type: object
                            startupProbe:
                              properties:
                                exec:
                                  properties:
                                    command:
                                      items:
                                        type: string
                                      type: array
                                  type: object
                                failureThreshold:
                                  format: int32
                                  type: integer
                                grpc:
                                  properties:
                                    port:
                                      format: int32
                                      type: integer
                                    service:
                                      type: string
                                  required:
                                  - port
                                  type: object
                                httpGet:
                                  properties:
                                    host:
                                      type: string
                                    httpHeaders:
                                      items:
                                        properties:
                                          name:
                                            type: string
                                          value:
                                            type: string
                                        required:
                                        - name
                                        - value
                                        type: object
                                      type: array
                                    path:
                                      type: string
                                    port:
                                      anyOf:
                                      - type: integer
                                      - type: string
                                      x-kubernetes-int-or-string: true
                                    scheme:
                                      type: string
                                  required:
                                  - port
                                  type: object
                                initialDelaySeconds:
                                  format: int32
                                  type: integer
                                periodSeconds:
                                  format: int32
                                  type: integer
                                successThreshold:
                                  format: int32
                                  type: integer
                                tcpSocket:
                                  properties:
                                    host:
                                      type: string
                                    port:
                                      anyOf:
                                      - type: integer
                                      - type: string
                                      x-kubernetes-int-or-string: true
                                  required:
                                  - port
                                  type: object
                                terminationGracePeriodSeconds:
                                  format: int64
                                  type: integer
                                timeoutSeconds:
                                  format: int32
                                  type: integer
                              type: object
                            stdin:
                              type: boolean
                            stdinOnce:
                              type: boolean
                            terminationMessagePath:
                              type: string
                            terminationMessagePolicy:
                              type: string
                            tty:
                              type: boolean
                            volumeDevices:
                              items:
                                properties:
                                  devicePath:
                                    type: string
                                  name:
                                    type: string
                                required:
                                - devicePath
                                - name
                                type: object
                              type: array
                            volumeMounts:
                              items:
                                properties:
                                  mountPath:
                                    type: string
                                  mountPropagation:
                                    type: string
                                  name:
                                    type: string
                                  readOnly:
                                    type: boolean
                                  subPath:
                                    type: string
                                  subPathExpr:
                                    type: string
                                required:
                                - mountPath
                                - name
                                type: object
                              type: array
                            workingDir:
                              type: string
                          required:
                          - name
                          type: object
                        type: array
                      dnsConfig:
                        properties:
                          nameservers:
                            items:
                              type: string
                            type: array
                          options:
                            items:
                              properties:
                                name:
                                  type: string
                                value:
                                  type: string
                              type: object
                            type: array
                          searches:
                            items:
                              type: string
                            type: array
                        type: object
                      dnsPolicy:
                        type: string
                      enableServiceLinks:
                        type: boolean
                      ephemeralContainers:
                        items:
                          properties:
                            args:
                              items:
                                type: string
                              type: array
                            command:
                              items:
                                type: string
                              type: array
                            env:
                              items:
                                properties:
                                  name:
                                    type: string
                                  value:
                                    type: string
                                  valueFrom:
                                    properties:
                                      configMapKeyRef:
                                        properties:
                                          key:
                                            type: string
                                          name:
                                            type: string
                                          optional:
                                            type: boolean
                                        required:
                                        - key
                                        type: object
                                      fieldRef:
                                        properties:
                                          apiVersion:
                                            type: string
                                          fieldPath:
                                            type: string
                                        required:
                                        - fieldPath
                                        type: object
                                      resourceFieldRef:
                                        properties:
                                          containerName:
                                            type: string
                                          divisor:
                                            anyOf:
                                            - type: integer
                                            - type: string
                                            pattern: ^(\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))))?$
                                            x-kubernetes-int-or-string: true
                                          resource:
                                            type: string
                                        required:
                                        - resource
                                        type: object
                                      secretKeyRef:
                                        properties:
                                          key:
                                            type: string
                                          name:
                                            type: string
                                          optional:
                                            type: boolean
                                        required:
                                        - key
                                        type: object
                                    type: object
                                required:
                                - name
                                type: object
                              type: array
                            envFrom:
                              items:
                                properties:
                                  configMapRef:
                                    properties:
                                      name:
                                        type: string
                                      optional:
                                        type: boolean
                                    type: object
                                  prefix:
                                    type: string
                                  secretRef:
                                    properties:
                                      name:
                                        type: string
                                      optional:
                                        type: boolean
                                    type: object
                                type: object
                              type: array
                            image:
                              type: string
                            imagePullPolicy:
                              type: string
                            lifecycle:
                              properties:
                                postStart:
                                  properties:
                                    exec:
                                      properties:
                                        command:
                                          items:
                                            type: string
                                          type: array
                                      type: object
                                    httpGet:
                                      properties:
                                        host:
                                          type: string
                                        httpHeaders:
                                          items:
                                            properties:
                                              name:
                                                type: string
                                              value:
                                                type: string
                                            required:
                                            - name
                                            - value
                                            type: object
                                          type: array
                                        path:
                                          type: string
                                        port:
                                          anyOf:
                                          - type: integer
                                          - type: string
                                          x-kubernetes-int-or-string: true
                                        scheme:
                                          type: string
                                      required:
                                      - port
                                      type: object
                                    tcpSocket:
                                      properties:
                                        host:
                                          type: string
                                        port:
                                          anyOf:
                                          - type: integer
                                          - type: string
                                          x-kubernetes-int-or-string: true
                                      required:
                                      - port
                                      type: object
                                  type: object
                                preStop:
                                  properties:
                                    exec:
                                      properties:
                                        command:
                                          items:
                                            type: string
                                          type: array
                                      type: object
                                    httpGet:
                                      properties:
                                        host:
                                          type: string
                                        httpHeaders:
                                          items:
                                            properties:
                                              name:
                                                type: string
                                              value:
                                                type: string
                                            required:
                                            - name
                                            - value
                                            type: object
                                          type: array
                                        path:
                                          type: string
                                        port:
                                          anyOf:
                                          - type: integer
                                          - type: string
                                          x-kubernetes-int-or-string: true
                                        scheme:
                                          type: string
                                      required:
                                      - port
                                      type: object
                                    tcpSocket:
                                      properties:
                                        host:
                                          type: string
                                        port:
                                          anyOf:
                                          - type: integer
                                          - type: string
                                          x-kubernetes-int-or-string: true
                                      required:
                                      - port
                                      type: object
                                  type: object
                              type: object
                            livenessProbe:
                              properties:
                                exec:
                                  properties:
                                    command:
                                      items:
                                        type: string
                                      type: array
                                  type: object
                                failureThreshold:
                                  format: int32
                                  type: integer
                                grpc:
                                  properties:
                                    port:
                                      format: int32
                                      type: integer
                                    service:
                                      type: string
                                  required:
                                  - port
                                  type: object
                                httpGet:
                                  properties:
                                    host:
                                      type: string
                                    httpHeaders:
                                      items:
                                        properties:
                                          name:
                                            type: string
                                          value:
                                            type: string
                                        required:
                                        - name
                                        - value
                                        type: object
                                      type: array
                                    path:
                                      type: string
                                    port:
                                      anyOf:
                                      - type: integer
                                      - type: string
                                      x-kubernetes-int-or-string: true
                                    scheme:
                                      type: string
                                  required:
                                  - port
                                  type: object
                                initialDelaySeconds:
                                  format: int32
                                  type: integer
                                periodSeconds:
                                  format: int32
                                  type: integer
                                successThreshold:
                                  format: int32
                                  type: integer
                                tcpSocket:
                                  properties:
                                    host:
                                      type: string
                                    port:
                                      anyOf:
                                      - type: integer
                                      - type: string
                                      x-kubernetes-int-or-string: true
                                  required:
                                  - port
                                  type: object
                                terminationGracePeriodSeconds:
                                  format: int64
                                  type: integer
                                timeoutSeconds:
                                  format: int32
                                  type: integer
                              type: object
                            name:
                              type: string
                            ports:
                              items:
                                properties:
                                  containerPort:
                                    format: int32
                                    type: integer
                                  hostIP:
                                    type: string
                                  hostPort:
                                    format: int32
                                    type: integer
                                  name:
                                    type: string
                                  protocol:
                                    default: TCP
                                    type: string
                                required:
                                - containerPort
                                type: object
                              type: array
                              x-kubernetes-list-map-keys:
                              - containerPort
                              - protocol
                              x-kubernetes-list-type: map
                            readinessProbe:
                              properties:
                                exec:
                                  properties:
                                    command:
                                      items:
                                        type: string
                                      type: array
                                  type: object
                                failureThreshold:
                                  format: int32
                                  type: integer
                                grpc:
                                  properties:
                                    port:
                                      format: int32
                                      type: integer
                                    service:
                                      type: string
                                  required:
                                  - port
                                  type: object
                                httpGet:
                                  properties:
                                    host:
                                      type: string
                                    httpHeaders:
                                      items:
                                        properties:
                                          name:
                                            type: string
                                          value:
                                            type: string
                                        required:
                                        - name
                                        - value
                                        type: object
                                      type: array
                                    path:
                                      type: string
                                    port:
                                      anyOf:
                                      - type: integer
                                      - type: string
                                      x-kubernetes-int-or-string: true
                                    scheme:
                                      type: string
                                  required:
                                  - port
                                  type: object
                                initialDelaySeconds:
                                  format: int32
                                  type: integer
                                periodSeconds:
                                  format: int32
                                  type: integer
                                successThreshold:
                                  format: int32
                                  type: integer
                                tcpSocket:
                                  properties:
                                    host:
                                      type: string
                                    port:
                                      anyOf:
                                      - type: integer
                                      - type: string
                                      x-kubernetes-int-or-string: true
                                  required:
                                  - port
                                  type: object
                                terminationGracePeriodSeconds:
                                  format: int64
                                  type: integer
                                timeoutSeconds:
                                  format: int32
                                  type: integer
                              type: object
                            resources:
                              properties:
                                limits:
                                  additionalProperties:
                                    anyOf:
                                    - type: integer
                                    - type: string
                                    pattern: ^(\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))))?$
                                    x-kubernetes-int-or-string: true
                                  type: object
                                requests:
                                  additionalProperties:
                                    anyOf:
                                    - type: integer
                                    - type: string
                                    pattern: ^(\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))))?$
                                    x-kubernetes-int-or-string: true
                                  type: object
                              type: object
                            securityContext:
                              properties:
                                allowPrivilegeEscalation:
                                  type: boolean
                                capabilities:
                                  properties:
                                    add:
                                      items:
                                        type: string
                                      type: array
                                    drop:
                                      items:
                                        type: string
                                      type: array
                                  type: object
                                privileged:
                                  type: boolean
                                procMount:
                                  type: string
                                readOnlyRootFilesystem:
                                  type: boolean
                                runAsGroup:
                                  format: int64
                                  type: integer
                                runAsNonRoot:
                                  type: boolean
                                runAsUser:
                                  format: int64
                                  type: integer
                                seLinuxOptions:
                                  properties:
                                    level:
                                      type: string
                                    role:
                                      type: string
                                    type:
                                      type: string
                                    user:
                                      type: string
                                  type: object
                                seccompProfile:
                                  properties:
                                    localhostProfile:
                                      type: string
                                    type:
                                      type: string
                                  required:
                                  - type
                                  type: object
                                windowsOptions:
                                  properties:
                                    gmsaCredentialSpec:
                                      type: string
                                    gmsaCredentialSpecName:
                                      type: string
                                    hostProcess:
                                      type: boolean
                                    runAsUserName:
                                      type: string
                                  type: object
                              type: object
                            startupProbe:
                              properties:
                                exec:
                                  properties:
                                    command:
                                      items:
                                        type: string
                                      type: array
                                  type: object
                                failureThreshold:
                                  format: int32
                                  type: integer
                                grpc:
                                  properties:
                                    port:
                                      format: int32
                                      type: integer
                                    service:
                                      type: string
                                  required:
                                  - port
                                  type: object
                                httpGet:
                                  properties:
                                    host:
                                      type: string
                                    httpHeaders:
                                      items:
                                        properties:
                                          name:
                                            type: string
                                          value:
                                            type: string
                                        required:
                                        - name
                                        - value
                                        type: object
                                      type: array
                                    path:
                                      type: string
                                    port:
                                      anyOf:
                                      - type: integer
                                      - type: string
                                      x-kubernetes-int-or-string: true
                                    scheme:
                                      type: string
                                  required:
                                  - port
                                  type: object
                                initialDelaySeconds:
                                  format: int32
                                  type: integer
                                periodSeconds:
                                  format: int32
                                  type: integer
                                successThreshold:
                                  format: int32
                                  type: integer
                                tcpSocket:
                                  properties:
                                    host:
                                      type: string
                                    port:
                                      anyOf:
                                      - type: integer
                                      - type: string
                                      x-kubernetes-int-or-string: true
                                  required:
                                  - port
                                  type: object
                                terminationGracePeriodSeconds:
                                  format: int64
                                  type: integer
                                timeoutSeconds:
                                  format: int32
                                  type: integer
                              type: object
                            stdin:
                              type: boolean
                            stdinOnce:
                              type: boolean
                            targetContainerName:
                              type: string
                            terminationMessagePath:
                              type: string
                            terminationMessagePolicy:
                              type: string
                            tty:
                              type: boolean
                            volumeDevices:
                              items:
                                properties:
                                  devicePath:
                                    type: string
                                  name:
                                    type: string
                                required:
                                - devicePath
                                - name
                                type: object
                              type: array
                            volumeMounts:
                              items:
                                properties:
                                  mountPath:
                                    type: string
                                  mountPropagation:
                                    type: string
                                  name:
                                    type: string
                                  readOnly:
                                    type: boolean
                                  subPath:
                                    type: string
                                  subPathExpr:
                                    type: string
                                required:
                                - mountPath
                                - name
                                type: object
                              type: array
                            workingDir:
                              type: string
                          required:
                          - name
                          type: object
                        type: array
                      hostAliases:
                        items:
                          properties:
                            hostnames:
                              items:
                                type: string
                              type: array
                            ip:
                              type: string
                          type: object
                        type: array
                      hostIPC:
                        type: boolean
                      hostNetwork:
                        type: boolean
                      hostPID:
                        type: boolean
                      hostname:
                        type: string
                      imagePullSecrets:
                        items:
                          properties:
                            name:
                              type: string
                          type: object
                        type: array
                      initContainers:
                        items:
                          properties:
                            args:
                              items:
                                type: string
                              type: array
                            command:
                              items:
                                type: string
                              type: array
                            env:
                              items:
                                properties:
                                  name:
                                    type: string
                                  value:
                                    type: string
                                  valueFrom:
                                    properties:
                                      configMapKeyRef:
                                        properties:
                                          key:
                                            type: string
                                          name:
                                            type: string
                                          optional:
                                            type: boolean
                                        required:
                                        - key
                                        type: object
                                      fieldRef:
                                        properties:
                                          apiVersion:
                                            type: string
                                          fieldPath:
                                            type: string
                                        required:
                                        - fieldPath
                                        type: object
                                      resourceFieldRef:
                                        properties:
                                          containerName:
                                            type: string
                                          divisor:
                                            anyOf:
                                            - type: integer
                                            - type: string
                                            pattern: ^(\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))))?$
                                            x-kubernetes-int-or-string: true
                                          resource:
                                            type: string
                                        required:
                                        - resource
                                        type: object
                                      secretKeyRef:
                                        properties:
                                          key:
                                            type: string
                                          name:
                                            type: string
                                          optional:
                                            type: boolean
                                        required:
                                        - key
                                        type: object
                                    type: object
                                required:
                                - name
                                type: object
                              type: array
                            envFrom:
                              items:
                                properties:
                                  configMapRef:
                                    properties:
                                      name:
                                        type: string
                                      optional:
                                        type: boolean
                                    type: object
                                  prefix:
                                    type: string
                                  secretRef:
                                    properties:
                                      name:
                                        type: string
                                      optional:
                                        type: boolean
                                    type: object
                                type: object
                              type: array
                            image:
                              type: string
                            imagePullPolicy:
                              type: string
                            lifecycle:
                              properties:
                                postStart:
                                  properties:
                                    exec:
                                      properties:
                                        command:
                                          items:
                                            type: string
                                          type: array
                                      type: object
                                    httpGet:
                                      properties:
                                        host:
                                          type: string
                                        httpHeaders:
                                          items:
                                            properties:
                                              name:
                                                type: string
                                              value:
                                                type: string
                                            required:
                                            - name
                                            - value
                                            type: object
                                          type: array
                                        path:
                                          type: string
                                        port:
                                          anyOf:
                                          - type: integer
                                          - type: string
                                          x-kubernetes-int-or-string: true
                                        scheme:
                                          type: string
                                      required:
                                      - port
                                      type: object
                                    tcpSocket:
                                      properties:
                                        host:
                                          type: string
                                        port:
                                          anyOf:
                                          - type: integer
                                          - type: string
                                          x-kubernetes-int-or-string: true
                                      required:
                                      - port
                                      type: object
                                  type: object
                                preStop:
                                  properties:
                                    exec:
                                      properties:
                                        command:
                                          items:
                                            type: string
                                          type: array
                                      type: object
                                    httpGet:
                                      properties:
                                        host:
                                          type: string
                                        httpHeaders:
                                          items:
                                            properties:
                                              name:
                                                type: string
                                              value:
                                                type: string
                                            required:
                                            - name
                                            - value
                                            type: object
                                          type: array
                                        path:
                                          type: string
                                        port:
                                          anyOf:
                                          - type: integer
                                          - type: string
                                          x-kubernetes-int-or-string: true
                                        scheme:
                                          type: string
                                      required:
                                      - port
                                      type: object
                                    tcpSocket:
                                      properties:
                                        host:
                                          type: string
                                        port:
                                          anyOf:
                                          - type: integer
                                          - type: string
                                          x-kubernetes-int-or-string: true
                                      required:
                                      - port
                                      type: object
                                  type: object
                              type: object
                            livenessProbe:
                              properties:
                                exec:
                                  properties:
                                    command:
                                      items:
                                        type: string
                                      type: array
                                  type: object
                                failureThreshold:
                                  format: int32
                                  type: integer
                                grpc:
                                  properties:
                                    port:
                                      format: int32
                                      type: integer
                                    service:
                                      type: string
                                  required:
                                  - port
                                  type: object
                                httpGet:
                                  properties:
                                    host:
                                      type: string
                                    httpHeaders:
                                      items:
                                        properties:
                                          name:
                                            type: string
                                          value:
                                            type: string
                                        required:
                                        - name
                                        - value
                                        type: object
                                      type: array
                                    path:
                                      type: string
                                    port:
                                      anyOf:
                                      - type: integer
                                      - type: string
                                      x-kubernetes-int-or-string: true
                                    scheme:
                                      type: string
                                  required:
                                  - port
                                  type: object
                                initialDelaySeconds:
                                  format: int32
                                  type: integer
                                periodSeconds:
                                  format: int32
                                  type: integer
                                successThreshold:
                                  format: int32
                                  type: integer
                                tcpSocket:
                                  properties:
                                    host:
                                      type: string
                                    port:
                                      anyOf:
                                      - type: integer
                                      - type: string
                                      x-kubernetes-int-or-string: true
                                  required:
                                  - port
                                  type: object
                                terminationGracePeriodSeconds:
                                  format: int64
                                  type: integer
                                timeoutSeconds:
                                  format: int32
                                  type: integer
                              type: object
                            name:
                              type: string
                            ports:
                              items:
                                properties:
                                  containerPort:
                                    format: int32
                                    type: integer
                                  hostIP:
                                    type: string
                                  hostPort:
                                    format: int32
                                    type: integer
                                  name:
                                    type: string
                                  protocol:
                                    default: TCP
                                    type: string
                                required:
                                - containerPort
                                type: object
                              type: array
                              x-kubernetes-list-map-keys:
                              - containerPort
                              - protocol
                              x-kubernetes-list-type: map
                            readinessProbe:
                              properties:
                                exec:
                                  properties:
                                    command:
                                      items:
                                        type: string
                                      type: array
                                  type: object
                                failureThreshold:
                                  format: int32
                                  type: integer
                                grpc:
                                  properties:
                                    port:
                                      format: int32
                                      type: integer
                                    service:
                                      type: string
                                  required:
                                  - port
                                  type: object
                                httpGet:
                                  properties:
                                    host:
                                      type: string
                                    httpHeaders:
                                      items:
                                        properties:
                                          name:
                                            type: string
                                          value:
                                            type: string
                                        required:
                                        - name
                                        - value
                                        type: object
                                      type: array
                                    path:
                                      type: string
                                    port:
                                      anyOf:
                                      - type: integer
                                      - type: string
                                      x-kubernetes-int-or-string: true
                                    scheme:
                                      type: string
                                  required:
                                  - port
                                  type: object
                                initialDelaySeconds:
                                  format: int32
                                  type: integer
                                periodSeconds:
                                  format: int32
                                  type: integer
                                successThreshold:
                                  format: int32
                                  type: integer
                                tcpSocket:
                                  properties:
                                    host:
                                      type: string
                                    port:
                                      anyOf:
                                      - type: integer
                                      - type: string
                                      x-kubernetes-int-or-string: true
                                  required:
                                  - port
                                  type: object
                                terminationGracePeriodSeconds:
                                  format: int64
                                  type: integer
                                timeoutSeconds:
                                  format: int32
                                  type: integer
                              type: object
                            resources:
                              properties:
                                limits:
                                  additionalProperties:
                                    anyOf:
                                    - type: integer
                                    - type: string
                                    pattern: ^(\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))))?$
                                    x-kubernetes-int-or-string: true
                                  type: object
                                requests:
                                  additionalProperties:
                                    anyOf:
                                    - type: integer
                                    - type: string
                                    pattern: ^(\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))))?$
                                    x-kubernetes-int-or-string: true
                                  type: object
                              type: object
                            securityContext:
                              properties:
                                allowPrivilegeEscalation:
                                  type: boolean
                                capabilities:
                                  properties:
                                    add:
                                      items:
                                        type: string
                                      type: array
                                    drop:
                                      items:
                                        type: string
                                      type: array
                                  type: object
                                privileged:
                                  type: boolean
                                procMount:
                                  type: string
                                readOnlyRootFilesystem:
                                  type: boolean
                                runAsGroup:
                                  format: int64
                                  type: integer
                                runAsNonRoot:
                                  type: boolean
                                runAsUser:
                                  format: int64
                                  type: integer
                                seLinuxOptions:
                                  properties:
                                    level:
                                      type: string
                                    role:
                                      type: string
                                    type:
                                      type: string
                                    user:
                                      type: string
                                  type: object
                                seccompProfile:
                                  properties:
                                    localhostProfile:
                                      type: string
                                    type:
                                      type: string
                                  required:
                                  - type
                                  type: object
                                windowsOptions:
                                  properties:
                                    gmsaCredentialSpec:
                                      type: string
                                    gmsaCredentialSpecName:
                                      type: string
                                    hostProcess:
                                      type: boolean
                                    runAsUserName:
                                      type: string
                                  type: object
                              type: object
                            startupProbe:
                              properties:
                                exec:
                                  properties:
                                    command:
                                      items:
                                        type: string
                                      type: array
                                  type: object
                                failureThreshold:
                                  format: int32
                                  type: integer
                                grpc:
                                  properties:
                                    port:
                                      format: int32
                                      type: integer
                                    service:
                                      type: string
                                  required:
                                  - port
                                  type: object
                                httpGet:
                                  properties:
                                    host:
                                      type: string
                                    httpHeaders:
                                      items:
                                        properties:
                                          name:
                                            type: string
                                          value:
                                            type: string
                                        required:
                                        - name
                                        - value
                                        type: object
                                      type: array
                                    path:
                                      type: string
                                    port:
                                      anyOf:
                                      - type: integer
                                      - type: string
                                      x-kubernetes-int-or-string: true
                                    scheme:
                                      type: string
                                  required:
                                  - port
                                  type: object
                                initialDelaySeconds:
                                  format: int32
                                  type: integer
                                periodSeconds:
                                  format: int32
                                  type: integer
                                successThreshold:
                                  format: int32
                                  type: integer
                                tcpSocket:
                                  properties:
                                    host:
                                      type: string
                                    port:
                                      anyOf:
                                      - type: integer
                                      - type: string
                                      x-kubernetes-int-or-string: true
                                  required:
                                  - port
                                  type: object
                                terminationGracePeriodSeconds:
                                  format: int64
                                  type: integer
                                timeoutSeconds:
                                  format: int32
                                  type: integer
                              type: object
                            stdin:
                              type: boolean
                            stdinOnce:
                              type: boolean
                            terminationMessagePath:
                              type: string
                            terminationMessagePolicy:
                              type: string
                            tty:
                              type: boolean
                            volumeDevices:
                              items:
                                properties:
                                  devicePath:
                                    type: string
                                  name:
                                    type: string
                                required:
                                - devicePath
                                - name
                                type: object
                              type: array
                            volumeMounts:
                              items:
                                properties:
                                  mountPath:
                                    type: string
                                  mountPropagation:
                                    type: string
                                  name:
                                    type: string
                                  readOnly:
                                    type: boolean
                                  subPath:
                                    type: string
                                  subPathExpr:
                                    type: string
                                required:
                                - mountPath
                                - name
                                type: object
                              type: array
                            workingDir:
                              type: string
                          required:
                          - name
                          type: object
                        type: array
                      nodeName:
                        type: string
                      nodeSelector:
                        additionalProperties:
                          type: string
                        type: object
                        x-kubernetes-map-type: atomic
                      os:
                        properties:
                          name:
                            type: string
                        required:
                        - name
                        type: object
                      overhead:
                        additionalProperties:
                          anyOf:
                          - type: integer
                          - type: string
                          pattern: ^(\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))))?$
                          x-kubernetes-int-or-string: true
                        type: object
                      preemptionPolicy:
                        type: string
                      priority:
                        format: int32
                        type: integer
                      priorityClassName:
                        type: string
                      readinessGates:
                        items:
                          properties:
                            conditionType:
                              type: string
                          required:
                          - conditionType
                          type: object
                        type: array
                      restartPolicy:
                        type: string
                      runtimeClassName:
                        type: string
                      schedulerName:
                        type: string
                      securityContext:
                        properties:
                          fsGroup:
                            format: int64
                            type: integer
                          fsGroupChangePolicy:
                            type: string
                          runAsGroup:
                            format: int64
                            type: integer
                          runAsNonRoot:
                            type: boolean
                          runAsUser:
                            format: int64
                            type: integer
                          seLinuxOptions:
                            properties:
                              level:
                                type: string
                              role:
                                type: string
                              type:
                                type: string
                              user:
                                type: string
                            type: object
                          seccompProfile:
                            properties:
                              localhostProfile:
                                type: string
                              type:
                                type: string
                            required:
                            - type
                            type: object
                          supplementalGroups:
                            items:
                              format: int64
                              type: integer
                            type: array
                          sysctls:
                            items:
                              properties:
                                name:
                                  type: string
                                value:
                                  type: string
                              required:
                              - name
                              - value
                              type: object
                            type: array
                          windowsOptions:
                            properties:
                              gmsaCredentialSpec:
                                type: string
                              gmsaCredentialSpecName:
                                type: string
                              hostProcess:
                                type: boolean
                              runAsUserName:
                                type: string
                            type: object
                        type: object
                      serviceAccount:
                        type: string
                      serviceAccountName:
                        type: string
                      setHostnameAsFQDN:
                        type: boolean
                      shareProcessNamespace:
                        type: boolean
                      subdomain:
                        type: string
                      terminationGracePeriodSeconds:
                        format: int64
                        type: integer
                      tolerations:
                        items:
                          properties:
                            effect:
                              type: string
                            key:
                              type: string
                            operator:
                              type: string
                            tolerationSeconds:
                              format: int64
                              type: integer
                            value:
                              type: string
                          type: object
                        type: array
                      topologySpreadConstraints:
                        items:
                          properties:
                            labelSelector:
                              properties:
                                matchExpressions:
                                  items:
                                    properties:
                                      key:
                                        type: string
                                      operator:
                                        type: string
                                      values:
                                        items:
                                          type: string
                                        type: array
                                    required:
                                    - key
                                    - operator
                                    type: object
                                  type: array
                                matchLabels:
                                  additionalProperties:
                                    type: string
                                  type: object
                              type: object
                            maxSkew:
                              format: int32
                              type: integer
                            topologyKey:
                              type: string
                            whenUnsatisfiable:
                              type: string
                          required:
                          - maxSkew
                          - topologyKey
                          - whenUnsatisfiable
                          type: object
                        type: array
                        x-kubernetes-list-map-keys:
                        - topologyKey
                        - whenUnsatisfiable
                        x-kubernetes-list-type: map
                      volumes:
                        items:
                          properties:
                            awsElasticBlockStore:
                              properties:
                                fsType:
                                  type: string
                                partition:
                                  format: int32
                                  type: integer
                                readOnly:
                                  type: boolean
                                volumeID:
                                  type: string
                              required:
                              - volumeID
                              type: object
                            azureDisk:
                              properties:
                                cachingMode:
                                  type: string
                                diskName:
                                  type: string
                                diskURI:
                                  type: string
                                fsType:
                                  type: string
                                kind:
                                  type: string
                                readOnly:
                                  type: boolean
                              required:
                              - diskName
                              - diskURI
                              type: object
                            azureFile:
                              properties:
                                readOnly:
                                  type: boolean
                                secretName:
                                  type: string
                                shareName:
                                  type: string
                              required:
                              - secretName
                              - shareName
                              type: object
                            cephfs:
                              properties:
                                monitors:
                                  items:
                                    type: string
                                  type: array
                                path:
                                  type: string
                                readOnly:
                                  type: boolean
                                secretFile:
                                  type: string
                                secretRef:
                                  properties:
                                    name:
                                      type: string
                                  type: object
                                user:
                                  type: string
                              required:
                              - monitors
                              type: object
                            cinder:
                              properties:
                                fsType:
                                  type: string
                                readOnly:
                                  type: boolean
                                secretRef:
                                  properties:
                                    name:
                                      type: string
                                  type: object
                                volumeID:
                                  type: string
                              required:
                              - volumeID
                              type: object
                            configMap:
                              properties:
                                defaultMode:
                                  format: int32
                                  type: integer
                                items:
                                  items:
                                    properties:
                                      key:
                                        type: string
                                      mode:
                                        format: int32
                                        type: integer
                                      path:
                                        type: string
                                    required:
                                    - key
                                    - path
                                    type: object
                                  type: array
                                name:
                                  type: string
                                optional:
                                  type: boolean
                              type: object
                            csi:
                              properties:
                                driver:
                                  type: string
                                fsType:
                                  type: string
                                nodePublishSecretRef:
                                  properties:
                                    name:
                                      type: string
                                  type: object
                                readOnly:
                                  type: boolean
                                volumeAttributes:
                                  additionalProperties:
                                    type: string
                                  type: object
                              required:
                              - driver
                              type: object
                            downwardAPI:
                              properties:
                                defaultMode:
                                  format: int32
                                  type: integer
                                items:
                                  items:
                                    properties:
                                      fieldRef:
                                        properties:
                                          apiVersion:
                                            type: string
                                          fieldPath:
                                            type: string
                                        required:
                                        - fieldPath
                                        type: object
                                      mode:
                                        format: int32
                                        type: integer
                                      path:
                                        type: string
                                      resourceFieldRef:
                                        properties:
                                          containerName:
                                            type: string
                                          divisor:
                                            anyOf:
                                            - type: integer
                                            - type: string
                                            pattern: ^(\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))))?$
                                            x-kubernetes-int-or-string: true
                                          resource:
                                            type: string
                                        required:
                                        - resource
                                        type: object
                                    required:
                                    - path
                                    type: object
                                  type: array
                              type: object
                            emptyDir:
                              properties:
                                medium:
                                  type: string
                                sizeLimit:
                                  anyOf:
                                  - type: integer
                                  - type: string
                                  pattern: ^(\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))))?$
                                  x-kubernetes-int-or-string: true
                              type: object
                            ephemeral:
                              properties:
                                volumeClaimTemplate:
                                  properties:
                                    metadata:
                                      type: object
                                    spec:
                                      properties:
                                        accessModes:
                                          items:
                                            type: string
                                          type: array
                                        dataSource:
                                          properties:
                                            apiGroup:
                                              type: string
                                            kind:
                                              type: string
                                            name:
                                              type: string
                                          required:
                                          - kind
                                          - name
                                          type: object
                                        dataSourceRef:
                                          properties:
                                            apiGroup:
                                              type: string
                                            kind:
                                              type: string
                                            name:
                                              type: string
                                          required:
                                          - kind
                                          - name
                                          type: object
                                        resources:
                                          properties:
                                            limits:
                                              additionalProperties:
                                                anyOf:
                                                - type: integer
                                                - type: string
                                                pattern: ^(\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))))?$
                                                x-kubernetes-int-or-string: true
                                              type: object
                                            requests:
                                              additionalProperties:
                                                anyOf:
                                                - type: integer
                                                - type: string
                                                pattern: ^(\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))))?$
                                                x-kubernetes-int-or-string: true
                                              type: object
                                          type: object
                                        selector:
                                          properties:
                                            matchExpressions:
                                              items:
                                                properties:
                                                  key:
                                                    type: string
                                                  operator:
                                                    type: string
                                                  values:
                                                    items:
                                                      type: string
                                                    type: array
                                                required:
                                                - key
                                                - operator
                                                type: object
                                              type: array
                                            matchLabels:
                                              additionalProperties:
                                                type: string
                                              type: object
                                          type: object
                                        storageClassName:
                                          type: string
                                        volumeMode:
                                          type: string
                                        volumeName:
                                          type: string
                                      type: object
                                  required:
                                  - spec
                                  type: object
                              type: object
                            fc:
                              properties:
                                fsType:
                                  type: string
                                lun:
                                  format: int32
                                  type: integer
                                readOnly:
                                  type: boolean
                                targetWWNs:
                                  items:
                                    type: string
                                  type: array
                                wwids:
                                  items:
                                    type: string
                                  type: array
                              type: object
                            flexVolume:
                              properties:
                                driver:
                                  type: string
                                fsType:
                                  type: string
                                options:
                                  additionalProperties:
                                    type: string
                                  type: object
                                readOnly:
                                  type: boolean
                                secretRef:
                                  properties:
                                    name:
                                      type: string
                                  type: object
                              required:
                              - driver
                              type: object
                            flocker:
                              properties:
                                datasetName:
                                  type: string
                                datasetUUID:
                                  type: string
                              type: object
                            gcePersistentDisk:
                              properties:
                                fsType:
                                  type: string
                                partition:
                                  format: int32
                                  type: integer
                                pdName:
                                  type: string
                                readOnly:
                                  type: boolean
                              required:
                              - pdName
                              type: object
                            gitRepo:
                              properties:
                                directory:
                                  type: string
                                repository:
                                  type: string
                                revision:
                                  type: string
                              required:
                              - repository
                              type: object
                            glusterfs:
                              properties:
                                endpoints:
                                  type: string
                                path:
                                  type: string
                                readOnly:
                                  type: boolean
                              required:
                              - endpoints
                              - path
                              type: object
                            hostPath:
                              properties:
                                path:
                                  type: string
                                type:
                                  type: string
                              required:
                              - path
                              type: object
                            iscsi:
                              properties:
                                chapAuthDiscovery:
                                  type: boolean
                                chapAuthSession:
                                  type: boolean
                                fsType:
                                  type: string
                                initiatorName:
                                  type: string
                                iqn:
                                  type: string
                                iscsiInterface:
                                  type: string
                                lun:
                                  format: int32
                                  type: integer
                                portals:
                                  items:
                                    type: string
                                  type: array
                                readOnly:
                                  type: boolean
                                secretRef:
                                  properties:
                                    name:
                                      type: string
                                  type: object
                                targetPortal:
                                  type: string
                              required:
                              - iqn
                              - lun
                              - targetPortal
                              type: object
                            name:
                              type: string
                            nfs:
                              properties:
                                path:
                                  type: string
                                readOnly:
                                  type: boolean
                                server:
                                  type: string
                              required:
                              - path
                              - server
                              type: object
                            persistentVolumeClaim:
                              properties:
                                claimName:
                                  type: string
                                readOnly:
                                  type: boolean
                              required:
                              - claimName
                              type: object
                            photonPersistentDisk:
                              properties:
                                fsType:
                                  type: string
                                pdID:
                                  type: string
                              required:
                              - pdID
                              type: object
                            portworxVolume:
                              properties:
                                fsType:
                                  type: string
                                readOnly:
                                  type: boolean
                                volumeID:
                                  type: string
                              required:
                              - volumeID
                              type: object
                            projected:
                              properties:
                                defaultMode:
                                  format: int32
                                  type: integer
                                sources:
                                  items:
                                    properties:
                                      configMap:
                                        properties:
                                          items:
                                            items:
                                              properties:
                                                key:
                                                  type: string
                                                mode:
                                                  format: int32
                                                  type: integer
                                                path:
                                                  type: string
                                              required:
                                              - key
                                              - path
                                              type: object
                                            type: array
                                          name:
                                            type: string
                                          optional:
                                            type: boolean
                                        type: object
                                      downwardAPI:
                                        properties:
                                          items:
                                            items:
                                              properties:
                                                fieldRef:
                                                  properties:
                                                    apiVersion:
                                                      type: string
                                                    fieldPath:
                                                      type: string
                                                  required:
                                                  - fieldPath
                                                  type: object
                                                mode:
                                                  format: int32
                                                  type: integer
                                                path:
                                                  type: string
                                                resourceFieldRef:
                                                  properties:
                                                    containerName:
                                                      type: string
                                                    divisor:
                                                      anyOf:
                                                      - type: integer
                                                      - type: string
                                                      pattern: ^(\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))))?$
                                                      x-kubernetes-int-or-string: true
                                                    resource:
                                                      type: string
                                                  required:
                                                  - resource
                                                  type: object
                                              required:
                                              - path
                                              type: object
                                            type: array
                                        type: object
                                      secret:
                                        properties:
                                          items:
                                            items:
                                              properties:
                                                key:
                                                  type: string
                                                mode:
                                                  format: int32
                                                  type: integer
                                                path:
                                                  type: string
                                              required:
                                              - key
                                              - path
                                              type: object
                                            type: array
                                          name:
                                            type: string
                                          optional:
                                            type: boolean
                                        type: object
                                      serviceAccountToken:
                                        properties:
                                          audience:
                                            type: string
                                          expirationSeconds:
                                            format: int64
                                            type: integer
                                          path:
                                            type: string
                                        required:
                                        - path
                                        type: object
                                    type: object
                                  type: array
                              type: object
                            quobyte:
                              properties:
                                group:
                                  type: string
                                readOnly:
                                  type: boolean
                                registry:
                                  type: string
                                tenant:
                                  type: string
                                user:
                                  type: string
                                volume:
                                  type: string
                              required:
                              - registry
                              - volume
                              type: object
                            rbd:
                              properties:
                                fsType:
                                  type: string
                                image:
                                  type: string
                                keyring:
                                  type: string
                                monitors:
                                  items:
                                    type: string
                                  type: array
                                pool:
                                  type: string
                                readOnly:
                                  type: boolean
                                secretRef:
                                  properties:
                                    name:
                                      type: string
                                  type: object
                                user:
                                  type: string
                              required:
                              - image
                              - monitors
                              type: object
                            scaleIO:
                              properties:
                                fsType:
                                  type: string
                                gateway:
                                  type: string
                                protectionDomain:
                                  type: string
                                readOnly:
                                  type: boolean
                                secretRef:
                                  properties:
                                    name:
                                      type: string
                                  type: object
                                sslEnabled:
                                  type: boolean
                                storageMode:
                                  type: string
                                storagePool:
                                  type: string
                                system:
                                  type: string
                                volumeName:
                                  type: string
                              required:
                              - gateway
                              - secretRef
                              - system
                              type: object
                            secret:
                              properties:
                                defaultMode:
                                  format: int32
                                  type: integer
                                items:
                                  items:
                                    properties:
                                      key:
                                        type: string
                                      mode:
                                        format: int32
                                        type: integer
                                      path:
                                        type: string
                                    required:
                                    - key
                                    - path
                                    type: object
                                  type: array
                                optional:
                                  type: boolean
                                secretName:
                                  type: string
                              type: object
                            storageos:
                              properties:
                                fsType:
                                  type: string
                                readOnly:
                                  type: boolean
                                secretRef:
                                  properties:
                                    name:
                                      type: string
                                  type: object
                                volumeName:
                                  type: string
                                volumeNamespace:
                                  type: string
                              type: object
                            vsphereVolume:
                              properties:
                                fsType:
                                  type: string
                                storagePolicyID:
                                  type: string
                                storagePolicyName:
                                  type: string
                                volumePath:
                                  type: string
                              required:
                              - volumePath
                              type: object
                          required:
                          - name
                          type: object
                        type: array
                    required:
                    - containers
                    type: object
                type: object
            type: object
          status:
            properties:
              conditions:
                items:
                  properties:
                    lastProbeTime:
                      format: date-time
                      type: string
                    lastTransitionTime:
                      format: date-time
                      type: string
                    message:
                      type: string
                    reason:
                      type: string
                    status:
                      type: string
                    type:
                      type: string
                  required:
                  - status
                  - type
                  type: object
                type: array
              containerState:
                properties:
                  running:
                    properties:
                      startedAt:
                        format: date-time
                        type: string
                    type: object
                  terminated:
                    properties:
                      containerID:
                        type: string
                      exitCode:
                        format: int32
                        type: integer
                      finishedAt:
                        format: date-time
                        type: string
                      message:
                        type: string
                      reason:
                        type: string
                      signal:
                        format: int32
                        type: integer
                      startedAt:
                        format: date-time
                        type: string
                    required:
                    - exitCode
                    type: object
                  waiting:
                    properties:
                      message:
                        type: string
                      reason:
                        type: string
                    type: object
                type: object
              readyReplicas:
                format: int32
                type: integer
            required:
            - conditions
            - containerState
            - readyReplicas
            type: object
        type: object
    served: true
    storage: false
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

resource "kubectl_manifest" "kubeflow-notebooks-serviceaccount-notebook-controller-service-account" {
  yaml_body = <<YAML
apiVersion: v1
kind: ServiceAccount
metadata:
  labels:
    app: notebook-controller
    kustomize.component: notebook-controller
  name: notebook-controller-service-account
  namespace: kubeflow
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool, kubectl_manifest.kubeflow-kubeflow-namespace]
}

resource "kubectl_manifest" "kubeflow-notebooks-role-notebook-controller-leader-election-role" {
  yaml_body = <<YAML
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  labels:
    app: notebook-controller
    kustomize.component: notebook-controller
  name: notebook-controller-leader-election-role
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
  - ""
  resources:
  - configmaps/status
  verbs:
  - get
  - update
  - patch
- apiGroups:
  - ""
  resources:
  - events
  verbs:
  - create
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool, kubectl_manifest.kubeflow-kubeflow-namespace]
}

resource "kubectl_manifest" "kubeflow-notebooks-clusterrole-notebook-controller-kubeflow-notebooks-admin" {
  yaml_body = <<YAML
aggregationRule:
  clusterRoleSelectors:
  - matchLabels:
      rbac.authorization.kubeflow.org/aggregate-to-kubeflow-notebooks-admin: "true"
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  labels:
    app: notebook-controller
    kustomize.component: notebook-controller
    rbac.authorization.kubeflow.org/aggregate-to-kubeflow-admin: "true"
  name: notebook-controller-kubeflow-notebooks-admin
rules: []
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool]
}

resource "kubectl_manifest" "kubeflow-notebooks-clusterrole-notebook-controller-kubeflow-notebooks-edit" {
  yaml_body = <<YAML
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  labels:
    app: notebook-controller
    kustomize.component: notebook-controller
    rbac.authorization.kubeflow.org/aggregate-to-kubeflow-edit: "true"
    rbac.authorization.kubeflow.org/aggregate-to-kubeflow-notebooks-admin: "true"
  name: notebook-controller-kubeflow-notebooks-edit
rules:
- apiGroups:
  - kubeflow.org
  resources:
  - notebooks
  - notebooks/status
  verbs:
  - get
  - list
  - watch
  - create
  - delete
  - deletecollection
  - patch
  - update
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool]
}

resource "kubectl_manifest" "kubeflow-notebooks-clusterrole-notebook-controller-kubeflow-notebooks-view" {
  yaml_body = <<YAML
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  labels:
    app: notebook-controller
    kustomize.component: notebook-controller
    rbac.authorization.kubeflow.org/aggregate-to-kubeflow-view: "true"
  name: notebook-controller-kubeflow-notebooks-view
rules:
- apiGroups:
  - kubeflow.org
  resources:
  - notebooks
  - notebooks/status
  verbs:
  - get
  - list
  - watch
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool]
}

resource "kubectl_manifest" "kubeflow-notebooks-clusterrole-notebook-controller-role" {
  yaml_body = <<YAML
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  creationTimestamp: null
  labels:
    app: notebook-controller
    kustomize.component: notebook-controller
  name: notebook-controller-role
rules:
- apiGroups:
  - apps
  resources:
  - statefulsets
  verbs:
  - '*'
- apiGroups:
  - ""
  resources:
  - events
  verbs:
  - create
  - get
  - list
  - patch
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
  - '*'
- apiGroups:
  - kubeflow.org
  resources:
  - notebooks
  - notebooks/finalizers
  - notebooks/status
  verbs:
  - '*'
- apiGroups:
  - networking.istio.io
  resources:
  - virtualservices
  verbs:
  - '*'
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool]
}

resource "kubectl_manifest" "kubeflow-notebooks-rolebinding-notebook-controller-leader-election-rolebinding" {
  yaml_body = <<YAML
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  labels:
    app: notebook-controller
    kustomize.component: notebook-controller
  name: notebook-controller-leader-election-rolebinding
  namespace: kubeflow
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: Role
  name: notebook-controller-leader-election-role
subjects:
- kind: ServiceAccount
  name: notebook-controller-service-account
  namespace: kubeflow
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool, kubectl_manifest.kubeflow-kubeflow-namespace]
}

resource "kubectl_manifest" "kubeflow-notebooks-clusterrolebinding-notebook-controller-role-binding" {
  yaml_body = <<YAML
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  labels:
    app: notebook-controller
    kustomize.component: notebook-controller
  name: notebook-controller-role-binding
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: notebook-controller-role
subjects:
- kind: ServiceAccount
  name: notebook-controller-service-account
  namespace: kubeflow
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool, kubectl_manifest.kubeflow-kubeflow-namespace]
}

resource "kubectl_manifest" "kubeflow-notebooks-configmap-notebook-controller-config" {
  yaml_body = <<YAML
apiVersion: v1
data:
  CLUSTER_DOMAIN: cluster.local
  CULL_IDLE_TIME: "1440"
  ENABLE_CULLING: "false"
  IDLENESS_CHECK_PERIOD: "1"
  ISTIO_GATEWAY: kubeflow/kubeflow-gateway
  USE_ISTIO: "true"
kind: ConfigMap
metadata:
  labels:
    app: notebook-controller
    kustomize.component: notebook-controller
  name: notebook-controller-config-dm5b6dd458
  namespace: kubeflow
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool, kubectl_manifest.kubeflow-kubeflow-namespace]
}

resource "kubectl_manifest" "kubeflow-notebooks-service-notebook-controller-service" {
  yaml_body = <<YAML
apiVersion: v1
kind: Service
metadata:
  labels:
    app: notebook-controller
    kustomize.component: notebook-controller
  name: notebook-controller-service
  namespace: kubeflow
spec:
  ports:
  - port: 443
  selector:
    app: notebook-controller
    kustomize.component: notebook-controller
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool, kubectl_manifest.kubeflow-kubeflow-namespace]
}

resource "kubectl_manifest" "kubeflow-notebooks-deployment-notebook-controller-deployment" {
  yaml_body = <<YAML
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: notebook-controller
    kustomize.component: notebook-controller
  name: notebook-controller-deployment
  namespace: kubeflow
spec:
  selector:
    matchLabels:
      app: notebook-controller
      kustomize.component: notebook-controller
  template:
    metadata:
      labels:
        app: notebook-controller
        kustomize.component: notebook-controller
    spec:
      containers:
      - command:
        - /manager
        env:
        - name: USE_ISTIO
          valueFrom:
            configMapKeyRef:
              key: USE_ISTIO
              name: notebook-controller-config-dm5b6dd458
        - name: ISTIO_GATEWAY
          valueFrom:
            configMapKeyRef:
              key: ISTIO_GATEWAY
              name: notebook-controller-config-dm5b6dd458
        - name: CLUSTER_DOMAIN
          valueFrom:
            configMapKeyRef:
              key: CLUSTER_DOMAIN
              name: notebook-controller-config-dm5b6dd458
        - name: ENABLE_CULLING
          valueFrom:
            configMapKeyRef:
              key: ENABLE_CULLING
              name: notebook-controller-config-dm5b6dd458
        - name: CULL_IDLE_TIME
          valueFrom:
            configMapKeyRef:
              key: CULL_IDLE_TIME
              name: notebook-controller-config-dm5b6dd458
        - name: IDLENESS_CHECK_PERIOD
          valueFrom:
            configMapKeyRef:
              key: IDLENESS_CHECK_PERIOD
              name: notebook-controller-config-dm5b6dd458
        image: docker.io/kubeflownotebookswg/notebook-controller:v1.7.0
        imagePullPolicy: IfNotPresent
        livenessProbe:
          httpGet:
            path: /healthz
            port: 8081
          initialDelaySeconds: 5
          periodSeconds: 10
        name: manager
        readinessProbe:
          httpGet:
            path: /readyz
            port: 8081
          initialDelaySeconds: 5
          periodSeconds: 10
      serviceAccountName: notebook-controller-service-account
      tolerations:
      - key: "kubeflow"
        operator: "Equal"
        value: "control-plane"
        effect: "NoSchedule"
      nodeSelector:
        kubeflow: control-plane
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool, kubectl_manifest.kubeflow-kubeflow-namespace, kubectl_manifest.kubeflow-istio-deployment-istiod, kubectl_manifest.kubeflow-istio-mutatingwebhookconfiguration-sidecar-injector]
}

resource "kubectl_manifest" "kubeflow-notebooks-serviceaccount-jupyter-web-app-service-account" {
  yaml_body = <<YAML
apiVersion: v1
kind: ServiceAccount
metadata:
  labels:
    app: jupyter-web-app
    kustomize.component: jupyter-web-app
  name: jupyter-web-app-service-account
  namespace: kubeflow
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool, kubectl_manifest.kubeflow-kubeflow-namespace]
}

resource "kubectl_manifest" "kubeflow-notebooks-role-jupyter-web-app-jupyter-notebook-role" {
  yaml_body = <<YAML
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  labels:
    app: jupyter-web-app
    kustomize.component: jupyter-web-app
  name: jupyter-web-app-jupyter-notebook-role
  namespace: kubeflow
rules:
- apiGroups:
  - authorization.k8s.io
  resources:
  - subjectaccessreviews
  verbs:
  - create
- apiGroups:
  - kubeflow.org
  resources:
  - notebooks
  - notebooks/finalizers
  - poddefaults
  verbs:
  - get
  - list
  - create
  - delete
  - patch
  - update
- apiGroups:
  - ""
  resources:
  - persistentvolumeclaims
  verbs:
  - create
  - delete
  - get
  - list
- apiGroups:
  - ""
  resources:
  - events
  - nodes
  verbs:
  - list
- apiGroups:
  - storage.k8s.io
  resources:
  - storageclasses
  verbs:
  - get
  - list
  - watch
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool, kubectl_manifest.kubeflow-kubeflow-namespace]
}

resource "kubectl_manifest" "kubeflow-notebooks-clusterrole-jupyter-web-app-cluster-role" {
  yaml_body = <<YAML
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  labels:
    app: jupyter-web-app
    kustomize.component: jupyter-web-app
  name: jupyter-web-app-cluster-role
rules:
- apiGroups:
  - authorization.k8s.io
  resources:
  - subjectaccessreviews
  verbs:
  - create
- apiGroups:
  - kubeflow.org
  resources:
  - notebooks
  - notebooks/finalizers
  - poddefaults
  verbs:
  - get
  - list
  - create
  - delete
  - patch
  - update
- apiGroups:
  - ""
  resources:
  - persistentvolumeclaims
  verbs:
  - create
  - delete
  - get
  - list
- apiGroups:
  - ""
  resources:
  - events
  - nodes
  verbs:
  - list
- apiGroups:
  - storage.k8s.io
  resources:
  - storageclasses
  verbs:
  - get
  - list
  - watch
- apiGroups:
  - ""
  resources:
  - pods
  - pods/log
  verbs:
  - list
  - get
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool]
}

resource "kubectl_manifest" "kubeflow-notebooks-clusterrole-jupyter-web-app-kubeflow-notebook-ui-admin" {
  yaml_body = <<YAML
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  labels:
    app: jupyter-web-app
    kustomize.component: jupyter-web-app
    rbac.authorization.kubeflow.org/aggregate-to-kubeflow-admin: "true"
  name: jupyter-web-app-kubeflow-notebook-ui-admin
rules: []
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool]
}

resource "kubectl_manifest" "kubeflow-notebooks-clusterrole-jupyter-web-app-kubeflow-notebook-ui-edit" {
  yaml_body = <<YAML
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  labels:
    app: jupyter-web-app
    kustomize.component: jupyter-web-app
    rbac.authorization.kubeflow.org/aggregate-to-kubeflow-edit: "true"
  name: jupyter-web-app-kubeflow-notebook-ui-edit
rules:
- apiGroups:
  - kubeflow.org
  resources:
  - notebooks
  - notebooks/finalizers
  - poddefaults
  verbs:
  - get
  - list
  - create
  - delete
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool]
}

resource "kubectl_manifest" "kubeflow-notebooks-clusterrole-jupiter-web-app-kubeflow-notebook-ui-view" {
  yaml_body = <<YAML
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  labels:
    app: jupyter-web-app
    kustomize.component: jupyter-web-app
    rbac.authorization.kubeflow.org/aggregate-to-kubeflow-view: "true"
  name: jupyter-web-app-kubeflow-notebook-ui-view
rules:
- apiGroups:
  - kubeflow.org
  resources:
  - notebooks
  - notebooks/finalizers
  - poddefaults
  verbs:
  - get
  - list
- apiGroups:
  - storage.k8s.io
  resources:
  - storageclasses
  verbs:
  - get
  - list
  - watch
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool]
}

resource "kubectl_manifest" "kubeflow-notebooks-rolebinding-jupyter-web-app-jupyter-notebook-role-binding" {
  yaml_body = <<YAML
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  labels:
    app: jupyter-web-app
    kustomize.component: jupyter-web-app
  name: jupyter-web-app-jupyter-notebook-role-binding
  namespace: kubeflow
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: Role
  name: jupyter-web-app-jupyter-notebook-role
subjects:
- kind: ServiceAccount
  name: jupyter-notebook
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool, kubectl_manifest.kubeflow-kubeflow-namespace]
}

resource "kubectl_manifest" "kubeflow-notebooks-clusterrolebinding-jupyter-web-app-cluster-role-binding" {
  yaml_body = <<YAML
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  labels:
    app: jupyter-web-app
    kustomize.component: jupyter-web-app
  name: jupyter-web-app-cluster-role-binding
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: jupyter-web-app-cluster-role
subjects:
- kind: ServiceAccount
  name: jupyter-web-app-service-account
  namespace: kubeflow
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool, kubectl_manifest.kubeflow-kubeflow-namespace]
}

resource "kubectl_manifest" "kubeflow-notebooks-configmap-jupyter-web-app-config" {
  yaml_body = <<YAML
apiVersion: v1
data:
  spawner_ui_config.yaml: |
    # Configuration file for the Jupyter UI.
    #
    # Each Jupyter UI option is configured by two keys: 'value' and 'readOnly'
    # - The 'value' key contains the default value
    # - The 'readOnly' key determines if the option will be available to users
    #
    # If the 'readOnly' key is present and set to 'true', the respective option
    # will be disabled for users and only set by the admin. Also when a
    # Notebook is POSTED to the API if a necessary field is not present then
    # the value from the config will be used.
    #
    # If the 'readOnly' key is missing (defaults to 'false'), the respective option
    # will be available for users to edit.
    #
    # Note that some values can be templated. Such values are the names of the
    # Volumes as well as their StorageClass
    spawnerFormDefaults:
      image:
        # The container Image for the user's Jupyter Notebook
        value: kubeflownotebookswg/jupyter-scipy:v1.7.0
        # The list of available standard container Images
        options:
        - kubeflownotebookswg/jupyter-scipy:v1.7.0
        - kubeflownotebookswg/jupyter-pytorch-full:v1.7.0
        - kubeflownotebookswg/jupyter-pytorch-cuda-full:v1.7.0
        - kubeflownotebookswg/jupyter-tensorflow-full:v1.7.0
        - kubeflownotebookswg/jupyter-tensorflow-cuda-full:v1.7.0
      imageGroupOne:
        # The container Image for the user's Group One Server
        # The annotation `notebooks.kubeflow.org/http-rewrite-uri: /`
        # is applied to notebook in this group, configuring
        # the Istio rewrite for containers that host their web UI at `/`
        value: kubeflownotebookswg/codeserver-python:v1.7.0
        # The list of available standard container Images
        options:
        - kubeflownotebookswg/codeserver-python:v1.7.0
      imageGroupTwo:
        # The container Image for the user's Group Two Server
        # The annotation `notebooks.kubeflow.org/http-rewrite-uri: /`
        # is applied to notebook in this group, configuring
        # the Istio rewrite for containers that host their web UI at `/`
        # The annotation `notebooks.kubeflow.org/http-headers-request-set`
        # is applied to notebook in this group, configuring Istio
        # to add the `X-RStudio-Root-Path` header to requests
        value: kubeflownotebookswg/rstudio-tidyverse:v1.7.0
        # The list of available standard container Images
        options:
        - kubeflownotebookswg/rstudio-tidyverse:v1.7.0
      # If true, hide registry and/or tag name in the image selection dropdown
      hideRegistry: true
      hideTag: false
      allowCustomImage: true
      # If true, users can input custom images
      # If false, users can only select from the images in this config
      imagePullPolicy:
        # Supported values: Always, IfNotPresent, Never
        value: IfNotPresent
        readOnly: false
      cpu:
        # CPU for user's Notebook
        value: '0.5'
        # Factor by with to multiply request to calculate limit
        # if no limit is set, to disable set "none"
        limitFactor: "1.2"
        readOnly: false
      memory:
        # Memory for user's Notebook
        value: 1.0Gi
        # Factor by with to multiply request to calculate limit
        # if no limit is set, to disable set "none"
        limitFactor: "1.2"
        readOnly: false
      environment:
        value: {}
        readOnly: false
      workspaceVolume:
        # Workspace Volume to be attached to user's Notebook
        # If you don't want a workspace volume then delete the 'value' key
        value:
          mount: /home/jovyan
          newPvc:
            metadata:
              name: '{notebook-name}-workspace'
            spec:
              resources:
                requests:
                  storage: 10Gi
              accessModes:
              - ReadWriteOnce
        readOnly: false
      dataVolumes:
        # List of additional Data Volumes to be attached to the user's Notebook
        value: []
        # For example, a list with 2 Data Volumes:
        # value:
        #   - mount: /home/jovyan/datavol-1
        #     newPvc:
        #       metadata:
        #         name: '{notebook-name}-datavol-1'
        #       spec:
        #         resources:
        #           requests:
        #             storage: 5Gi
        #         accessModes:
        #           - ReadWriteOnce
        #   - mount: /home/jovyan/datavol-1
        #     existingSource:
        #       persistentVolumeClaim:
        #         claimName: test-pvc
        readOnly: false
      gpus:
        # Number of GPUs to be assigned to the Notebook Container
        value:
          # values: "none", "1", "2", "4", "8"
          num: "none"
          # Determines what the UI will show and send to the backend
          vendors:
          - limitsKey: "nvidia.com/gpu"
            uiName: "NVIDIA"
          # Values: "" or a `limits-key` from the vendors list
          vendor: "nvidia.com/gpu"
        readOnly: false
      affinityConfig:
        # If readonly, the default value will be the only option
        # value is a list of `configKey`s that we want to be selected by default
        value: ""
        # The list of available affinity configs
        options: []
        #options:
        #  - configKey: "exclusive__n1-standard-2"
        #    displayName: "Exclusive: n1-standard-2"
        #    affinity:
        #      # (Require) Node having label: `control_plane_pool=notebook-n1-standard-2`
        #      nodeAffinity:
        #        requiredDuringSchedulingIgnoredDuringExecution:
        #          nodeSelectorTerms:
        #            - matchExpressions:
        #                - key: "control_plane_pool"
        #                  operator: "In"
        #                  values:
        #                   - "notebook-n1-standard-2"
        #      # (Require) Node WITHOUT existing Pod having label: `notebook-name`
        #      podAntiAffinity:
        #        requiredDuringSchedulingIgnoredDuringExecution:
        #          - labelSelector:
        #              matchExpressions:
        #                - key: "notebook-name"
        #                  operator: "Exists"
        #            namespaces: []
        #            topologyKey: "kubernetes.io/hostname"
        #readOnly: false
      tolerationGroup:
        # The default `groupKey` from the options list
        # If readonly, the default value will be the only option
        value: ""
        # The list of available tolerationGroup configs
        options: []
        #options:
        #  - groupKey: "group_1"
        #    displayName: "Group 1: description"
        #    tolerations:
        #      - key: "key1"
        #        operator: "Equal"
        #        value: "value1"
        #        effect: "NoSchedule"
        #      - key: "key2"
        #        operator: "Equal"
        #        value: "value2"
        #        effect: "NoSchedule"
        readOnly: false
      shm:
        value: true
        readOnly: false
      configurations:
        # List of labels to be selected, these are the labels from PodDefaults
        # value:
        #   - add-gcp-secret
        #   - default-editor
        value: []
        readOnly: false
kind: ConfigMap
metadata:
  labels:
    app: jupyter-web-app
    kustomize.component: jupyter-web-app
  name: jupyter-web-app-config-84khm987mh
  namespace: kubeflow
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool, kubectl_manifest.kubeflow-kubeflow-namespace]
}

resource "kubectl_manifest" "kubeflow-notebooks-configmap-jupyter-web-app-logo" {
  yaml_body = <<YAML
apiVersion: v1
data:
  group-one-icon.svg: |-
    <?xml version="1.0" encoding="utf-8"?>
    <!-- Generator: Adobe Illustrator 13.0.2, SVG Export Plug-In . SVG Version: 6.00 Build 14948)  -->
    <!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">
    <svg version="1.1" id="Ebene_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px"
      width="14.35px" height="42.88px" viewBox="0 0 14.35 42.88" enable-background="new 0 0 14.35 42.88" xml:space="preserve">
    <g>
      <path d="M9.442,30.084H7.333V16.643c-0.508,0.484-1.174,0.969-1.998,1.453s-1.564,0.848-2.221,1.09v-2.039
        c1.18-0.555,2.211-1.227,3.094-2.016s1.508-1.555,1.875-2.297h1.359V30.084z"/>
    </g>
    </svg>
  group-one-logo.svg: |-
    <?xml version="1.0" encoding="utf-8"?>
    <!-- Generator: Adobe Illustrator 13.0.2, SVG Export Plug-In . SVG Version: 6.00 Build 14948)  -->
    <!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">
    <svg version="1.1" id="Ebene_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px"
      width="14.35px" height="42.88px" viewBox="0 0 14.35 42.88" enable-background="new 0 0 14.35 42.88" xml:space="preserve">
    <g>
      <path d="M9.442,30.084H7.333V16.643c-0.508,0.484-1.174,0.969-1.998,1.453s-1.564,0.848-2.221,1.09v-2.039
        c1.18-0.555,2.211-1.227,3.094-2.016s1.508-1.555,1.875-2.297h1.359V30.084z"/>
    </g>
    </svg>
  group-two-icon.svg: |-
    <?xml version="1.0" encoding="utf-8"?>
    <!-- Generator: Adobe Illustrator 13.0.2, SVG Export Plug-In . SVG Version: 6.00 Build 14948)  -->
    <!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">
    <svg version="1.1" id="Ebene_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px"
      width="14.35px" height="42.88px" viewBox="0 0 14.35 42.88" enable-background="new 0 0 14.35 42.88" xml:space="preserve">
    <g>
      <path d="M12.583,28.057v2.027H1.228c-0.016-0.508,0.066-0.996,0.246-1.465c0.289-0.773,0.752-1.535,1.389-2.285
        s1.557-1.617,2.76-2.602c1.867-1.531,3.129-2.744,3.785-3.639s0.984-1.74,0.984-2.537c0-0.836-0.299-1.541-0.896-2.115
        s-1.377-0.861-2.338-0.861c-1.016,0-1.828,0.305-2.438,0.914s-0.918,1.453-0.926,2.531l-2.168-0.223
        c0.148-1.617,0.707-2.85,1.676-3.697s2.27-1.271,3.902-1.271c1.648,0,2.953,0.457,3.914,1.371s1.441,2.047,1.441,3.398
        c0,0.688-0.141,1.363-0.422,2.027s-0.748,1.363-1.4,2.098s-1.736,1.742-3.252,3.023c-1.266,1.063-2.078,1.783-2.438,2.162
        s-0.656,0.76-0.891,1.143H12.583z"/>
    </g>
    </svg>
  group-two-logo.svg: |-
    <?xml version="1.0" encoding="utf-8"?>
    <!-- Generator: Adobe Illustrator 13.0.2, SVG Export Plug-In . SVG Version: 6.00 Build 14948)  -->
    <!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">
    <svg version="1.1" id="Ebene_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px"
      width="14.35px" height="42.88px" viewBox="0 0 14.35 42.88" enable-background="new 0 0 14.35 42.88" xml:space="preserve">
    <g>
      <path d="M12.583,28.057v2.027H1.228c-0.016-0.508,0.066-0.996,0.246-1.465c0.289-0.773,0.752-1.535,1.389-2.285
        s1.557-1.617,2.76-2.602c1.867-1.531,3.129-2.744,3.785-3.639s0.984-1.74,0.984-2.537c0-0.836-0.299-1.541-0.896-2.115
        s-1.377-0.861-2.338-0.861c-1.016,0-1.828,0.305-2.438,0.914s-0.918,1.453-0.926,2.531l-2.168-0.223
        c0.148-1.617,0.707-2.85,1.676-3.697s2.27-1.271,3.902-1.271c1.648,0,2.953,0.457,3.914,1.371s1.441,2.047,1.441,3.398
        c0,0.688-0.141,1.363-0.422,2.027s-0.748,1.363-1.4,2.098s-1.736,1.742-3.252,3.023c-1.266,1.063-2.078,1.783-2.438,2.162
        s-0.656,0.76-0.891,1.143H12.583z"/>
    </g>
    </svg>
  jupyter-icon.svg: |
    <svg width="44" height="51" viewBox="0 0 44 51" version="2.0" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:figma="http://www.figma.com/figma/ns">
    <desc>Created using Figma 0.90</desc>
    <g id="Canvas" transform="translate(-1640 -2453)" figma:type="canvas">
    <g id="Group" style="mix-blend-mode:normal;" figma:type="group">
    <g id="Group" style="mix-blend-mode:normal;" figma:type="group">
    <g id="Group" style="mix-blend-mode:normal;" figma:type="group">
    <g id="g" style="mix-blend-mode:normal;" figma:type="group">
    <g id="path" style="mix-blend-mode:normal;" figma:type="group">
    <g id="path9 fill" style="mix-blend-mode:normal;" figma:type="vector">
    <use xlink:href="#path0_fill" transform="translate(1640.54 2474.36)" fill="#4E4E4E" style="mix-blend-mode:normal;"/>
    </g>
    </g>
    <g id="path" style="mix-blend-mode:normal;" figma:type="group">
    <g id="path10 fill" style="mix-blend-mode:normal;" figma:type="vector">
    <use xlink:href="#path1_fill" transform="translate(1645.68 2474.37)" fill="#4E4E4E" style="mix-blend-mode:normal;"/>
    </g>
    </g>
    <g id="path" style="mix-blend-mode:normal;" figma:type="group">
    <g id="path11 fill" style="mix-blend-mode:normal;" figma:type="vector">
    <use xlink:href="#path2_fill" transform="translate(1653.39 2474.26)" fill="#4E4E4E" style="mix-blend-mode:normal;"/>
    </g>
    </g>
    <g id="path" style="mix-blend-mode:normal;" figma:type="group">
    <g id="path12 fill" style="mix-blend-mode:normal;" figma:type="vector">
    <use xlink:href="#path3_fill" transform="translate(1660.43 2474.39)" fill="#4E4E4E" style="mix-blend-mode:normal;"/>
    </g>
    </g>
    <g id="path" style="mix-blend-mode:normal;" figma:type="group">
    <g id="path13 fill" style="mix-blend-mode:normal;" figma:type="vector">
    <use xlink:href="#path4_fill" transform="translate(1667.55 2472.54)" fill="#4E4E4E" style="mix-blend-mode:normal;"/>
    </g>
    </g>
    <g id="path" style="mix-blend-mode:normal;" figma:type="group">
    <g id="path14 fill" style="mix-blend-mode:normal;" figma:type="vector">
    <use xlink:href="#path5_fill" transform="translate(1672.47 2474.29)" fill="#4E4E4E" style="mix-blend-mode:normal;"/>
    </g>
    </g>
    <g id="path" style="mix-blend-mode:normal;" figma:type="group">
    <g id="path15 fill" style="mix-blend-mode:normal;" figma:type="vector">
    <use xlink:href="#path6_fill" transform="translate(1679.98 2474.24)" fill="#4E4E4E" style="mix-blend-mode:normal;"/>
    </g>
    </g>
    </g>
    </g>
    <g id="g" style="mix-blend-mode:normal;" figma:type="group">
    <g id="path" style="mix-blend-mode:normal;" figma:type="group">
    <g id="path16 fill" style="mix-blend-mode:normal;" figma:type="vector">
    <use xlink:href="#path7_fill" transform="translate(1673.48 2453.69)" fill="#767677" style="mix-blend-mode:normal;"/>
    </g>
    </g>
    <g id="path" style="mix-blend-mode:normal;" figma:type="group">
    <g id="path17 fill" style="mix-blend-mode:normal;" figma:type="vector">
    <use xlink:href="#path8_fill" transform="translate(1643.21 2484.27)" fill="#F37726" style="mix-blend-mode:normal;"/>
    </g>
    </g>
    <g id="path" style="mix-blend-mode:normal;" figma:type="group">
    <g id="path18 fill" style="mix-blend-mode:normal;" figma:type="vector">
    <use xlink:href="#path9_fill" transform="translate(1643.21 2457.88)" fill="#F37726" style="mix-blend-mode:normal;"/>
    </g>
    </g>
    <g id="path" style="mix-blend-mode:normal;" figma:type="group">
    <g id="path19 fill" style="mix-blend-mode:normal;" figma:type="vector">
    <use xlink:href="#path10_fill" transform="translate(1643.28 2496.09)" fill="#9E9E9E" style="mix-blend-mode:normal;"/>
    </g>
    </g>
    <g id="path" style="mix-blend-mode:normal;" figma:type="group">
    <g id="path20 fill" style="mix-blend-mode:normal;" figma:type="vector">
    <use xlink:href="#path11_fill" transform="translate(1641.87 2458.43)" fill="#616262" style="mix-blend-mode:normal;"/>
    </g>
    </g>
    </g>
    </g>
    </g>
    </g>
    <defs>
    <path id="path0_fill" d="M 1.74498 5.47533C 1.74498 7.03335 1.62034 7.54082 1.29983 7.91474C 0.943119 8.23595 0.480024 8.41358 0 8.41331L 0.124642 9.3036C 0.86884 9.31366 1.59095 9.05078 2.15452 8.56466C 2.45775 8.19487 2.6834 7.76781 2.818 7.30893C 2.95261 6.85005 2.99341 6.36876 2.93798 5.89377L 2.93798 0L 1.74498 0L 1.74498 5.43972L 1.74498 5.47533Z"/>
    <path id="path1_fill" d="M 5.50204 4.76309C 5.50204 5.43081 5.50204 6.02731 5.55545 6.54368L 4.496 6.54368L 4.42478 5.48423C 4.20318 5.85909 3.88627 6.16858 3.50628 6.38125C 3.12628 6.59392 2.69675 6.70219 2.26135 6.69503C 1.22861 6.69503 0 6.13415 0 3.84608L 0 0.0445149L 1.193 0.0445149L 1.193 3.6057C 1.193 4.84322 1.57583 5.67119 2.65309 5.67119C 2.87472 5.67358 3.09459 5.63168 3.29982 5.54796C 3.50505 5.46424 3.69149 5.34039 3.84822 5.18366C 4.00494 5.02694 4.1288 4.84049 4.21252 4.63527C 4.29623 4.43004 4.33813 4.21016 4.33575 3.98853L 4.33575 0L 5.52874 0L 5.52874 4.72748L 5.50204 4.76309Z"/>
    <path id="path2_fill" d="M 0.0534178 2.27264C 0.0534178 1.44466 0.0534178 0.768036 0 0.153731L 1.06836 0.153731L 1.12177 1.2666C 1.3598 0.864535 1.70247 0.534594 2.11325 0.311954C 2.52404 0.0893145 2.98754 -0.0176786 3.45435 0.00238095C 5.03908 0.00238095 6.23208 1.32892 6.23208 3.30538C 6.23208 5.63796 4.7987 6.79535 3.24958 6.79535C 2.85309 6.81304 2.45874 6.7281 2.10469 6.54874C 1.75064 6.36937 1.44888 6.10166 1.22861 5.77151L 1.22861 5.77151L 1.22861 9.33269L 0.0534178 9.33269L 0.0534178 2.29935L 0.0534178 2.27264ZM 1.22861 4.00872C 1.23184 4.17026 1.24972 4.33117 1.28203 4.48948C 1.38304 4.88479 1.61299 5.23513 1.93548 5.48506C 2.25798 5.735 2.65461 5.87026 3.06262 5.86944C 4.31794 5.86944 5.05689 4.8456 5.05689 3.3588C 5.05689 2.05897 4.36246 0.946096 3.10714 0.946096C 2.61036 0.986777 2.14548 1.20726 1.79965 1.5662C 1.45382 1.92514 1.25079 2.3979 1.22861 2.89585L 1.22861 4.00872Z"/>
    <path id="path3_fill" d="M 1.31764 0.0178059L 2.75102 3.85499C 2.90237 4.28233 3.06262 4.7987 3.16946 5.18153C 3.2941 4.7898 3.42764 4.29123 3.5879 3.82828L 4.88773 0.0178059L 6.14305 0.0178059L 4.36246 4.64735C 3.47216 6.87309 2.92908 8.02158 2.11 8.71601C 1.69745 9.09283 1.19448 9.35658 0.649917 9.48166L 0.356119 8.48453C 0.736886 8.35942 1.09038 8.16304 1.39777 7.90584C 1.8321 7.55188 2.17678 7.10044 2.4038 6.5882C 2.45239 6.49949 2.48551 6.40314 2.50173 6.3033C 2.49161 6.19586 2.46457 6.0907 2.42161 5.9917L 0 0L 1.29983 0L 1.31764 0.0178059Z"/>
    <path id="path4_fill" d="M 2.19013 0L 2.19013 1.86962L 3.8995 1.86962L 3.8995 2.75992L 2.19013 2.75992L 2.19013 6.26769C 2.19013 7.06896 2.42161 7.53191 3.08043 7.53191C 3.31442 7.53574 3.54789 7.5088 3.77486 7.45179L 3.82828 8.34208C 3.48794 8.45999 3.12881 8.51431 2.76882 8.50234C 2.53042 8.51726 2.29161 8.48043 2.06878 8.39437C 1.84595 8.30831 1.64438 8.17506 1.47789 8.00377C 1.11525 7.51873 0.949826 6.91431 1.01494 6.31221L 1.01494 2.75102L 0 2.75102L 0 1.86072L 1.03274 1.86072L 1.03274 0.275992L 2.19013 0Z"/>
    <path id="path5_fill" d="M 1.17716 3.57899C 1.153 3.88093 1.19468 4.18451 1.29933 4.46876C 1.40398 4.75301 1.5691 5.01114 1.78329 5.22532C 1.99747 5.43951 2.2556 5.60463 2.53985 5.70928C 2.8241 5.81393 3.12768 5.85561 3.42962 5.83145C 4.04033 5.84511 4.64706 5.72983 5.21021 5.49313L 5.41498 6.38343C 4.72393 6.66809 3.98085 6.80458 3.23375 6.78406C 2.79821 6.81388 2.36138 6.74914 1.95322 6.59427C 1.54505 6.43941 1.17522 6.19809 0.869071 5.88688C 0.562928 5.57566 0.327723 5.2019 0.179591 4.79125C 0.0314584 4.38059 -0.0260962 3.94276 0.0108748 3.50777C 0.0108748 1.54912 1.17716 0 3.0824 0C 5.21911 0 5.75329 1.86962 5.75329 3.06262C 5.76471 3.24644 5.76471 3.43079 5.75329 3.61461L 1.15046 3.61461L 1.17716 3.57899ZM 4.66713 2.6887C 4.70149 2.45067 4.68443 2.20805 4.61709 1.97718C 4.54976 1.74631 4.43372 1.53255 4.2768 1.35031C 4.11987 1.16808 3.92571 1.0216 3.70739 0.920744C 3.48907 0.81989 3.25166 0.767006 3.01118 0.765656C 2.52201 0.801064 2.06371 1.01788 1.72609 1.37362C 1.38847 1.72935 1.19588 2.19835 1.18607 2.6887L 4.66713 2.6887Z"/>
    <path id="path6_fill" d="M 0.0534178 2.19228C 0.0534178 1.42663 0.0534178 0.767806 0 0.162404L 1.06836 0.162404L 1.06836 1.43553L 1.12177 1.43553C 1.23391 1.04259 1.4656 0.694314 1.78468 0.439049C 2.10376 0.183783 2.4944 0.034196 2.90237 0.0110538C 3.01466 -0.00368459 3.12839 -0.00368459 3.24068 0.0110538L 3.24068 1.12393C 3.10462 1.10817 2.9672 1.10817 2.83114 1.12393C 2.427 1.13958 2.04237 1.30182 1.7491 1.58035C 1.45583 1.85887 1.27398 2.23462 1.23751 2.63743C 1.20422 2.8196 1.18635 3.00425 1.1841 3.18941L 1.1841 6.65267L 0.00890297 6.65267L 0.00890297 2.20118L 0.0534178 2.19228Z"/>
    <path id="path7_fill" d="M 6.03059 2.83565C 6.06715 3.43376 5.92485 4.02921 5.6218 4.54615C 5.31875 5.0631 4.86869 5.47813 4.32893 5.73839C 3.78917 5.99864 3.18416 6.09233 2.59097 6.00753C 1.99778 5.92272 1.44326 5.66326 0.998048 5.26219C 0.552837 4.86113 0.23709 4.33661 0.0910307 3.75546C -0.0550287 3.17431 -0.0247891 2.56283 0.177897 1.99893C 0.380583 1.43503 0.746541 0.944221 1.22915 0.589037C 1.71176 0.233853 2.28918 0.0303686 2.88784 0.00450543C 3.28035 -0.0170932 3.67326 0.0391144 4.04396 0.169896C 4.41467 0.300677 4.75587 0.503453 5.04794 0.766561C 5.34 1.02967 5.57718 1.34792 5.74582 1.70301C 5.91446 2.0581 6.01124 2.44303 6.03059 2.83565L 6.03059 2.83565Z"/>
    <path id="path8_fill" d="M 18.6962 7.12238C 10.6836 7.12238 3.64131 4.24672 0 0C 1.41284 3.82041 3.96215 7.1163 7.30479 9.44404C 10.6474 11.7718 14.623 13.0196 18.6962 13.0196C 22.7695 13.0196 26.745 11.7718 30.0877 9.44404C 33.4303 7.1163 35.9796 3.82041 37.3925 4.0486e-13C 33.7601 4.24672 26.7445 7.12238 18.6962 7.12238Z"/>
    <path id="path9_fill" d="M 18.6962 5.89725C 26.7089 5.89725 33.7512 8.77291 37.3925 13.0196C 35.9796 9.19922 33.4303 5.90333 30.0877 3.57559C 26.745 1.24785 22.7695 4.0486e-13 18.6962 0C 14.623 4.0486e-13 10.6474 1.24785 7.30479 3.57559C 3.96215 5.90333 1.41284 9.19922 0 13.0196C 3.64131 8.76401 10.648 5.89725 18.6962 5.89725Z"/>
    <path id="path10_fill" d="M 7.59576 3.56656C 7.64276 4.31992 7.46442 5.07022 7.08347 5.72186C 6.70251 6.3735 6.13619 6.89698 5.45666 7.22561C 4.77713 7.55424 4.01515 7.67314 3.26781 7.56716C 2.52046 7.46117 1.82158 7.13511 1.26021 6.63051C 0.698839 6.12591 0.300394 5.46561 0.115637 4.73375C -0.0691191 4.00188 -0.0318219 3.23159 0.222777 2.52099C 0.477376 1.8104 0.93775 1.19169 1.54524 0.743685C 2.15274 0.295678 2.87985 0.0386595 3.63394 0.00537589C 4.12793 -0.0210471 4.62229 0.0501173 5.08878 0.214803C 5.55526 0.37949 5.98473 0.63447 6.35264 0.965179C 6.72055 1.29589 7.01971 1.69584 7.233 2.1422C 7.4463 2.58855 7.56957 3.07256 7.59576 3.56656L 7.59576 3.56656Z"/>
    <path id="path11_fill" d="M 2.25061 4.37943C 1.81886 4.39135 1.39322 4.27535 1.02722 4.04602C 0.661224 3.81668 0.371206 3.48424 0.193641 3.09052C 0.0160762 2.69679 -0.0411078 2.25935 0.0292804 1.83321C 0.0996686 1.40707 0.294486 1.01125 0.589233 0.695542C 0.883981 0.37983 1.2655 0.158316 1.68581 0.0588577C 2.10611 -0.0406005 2.54644 -0.0135622 2.95143 0.136572C 3.35641 0.286707 3.70796 0.553234 3.96186 0.902636C 4.21577 1.25204 4.3607 1.66872 4.37842 2.10027C 4.39529 2.6838 4.18131 3.25044 3.78293 3.67715C 3.38455 4.10387 2.83392 4.35623 2.25061 4.37943Z"/>
    </defs>
    </svg>
  jupyterlab-logo.svg: |
    <svg xmlns="http://www.w3.org/2000/svg" width="200" viewBox="0 0 1860.8 475">
      <g class="jp-icon2" fill="#4E4E4E" transform="translate(480.136401, 64.271493)">
        <g transform="translate(0.000000, 58.875566)">
          <g transform="translate(0.087603, 0.140294)">
            <path d="M-426.9,169.8c0,48.7-3.7,64.7-13.6,76.4c-10.8,10-25,15.5-39.7,15.5l3.7,29 c22.8,0.3,44.8-7.9,61.9-23.1c17.8-18.5,24-44.1,24-83.3V0H-427v170.1L-426.9,169.8L-426.9,169.8z"/>
          </g>
        </g>
        <g transform="translate(155.045296, 56.837104)">
          <g transform="translate(1.562453, 1.799842)">
            <path d="M-312,148c0,21,0,39.5,1.7,55.4h-31.8l-2.1-33.3h-0.8c-6.7,11.6-16.4,21.3-28,27.9 c-11.6,6.6-24.8,10-38.2,9.8c-31.4,0-69-17.7-69-89V0h36.4v112.7c0,38.7,11.6,64.7,44.6,64.7c10.3-0.2,20.4-3.5,28.9-9.4 c8.5-5.9,15.1-14.3,18.9-23.9c2.2-6.1,3.3-12.5,3.3-18.9V0.2h36.4V148H-312L-312,148z"/>
          </g>
        </g>
        <g transform="translate(390.013322, 53.479638)">
          <g transform="translate(1.706458, 0.231425)">
            <path d="M-478.6,71.4c0-26-0.8-47-1.7-66.7h32.7l1.7,34.8h0.8c7.1-12.5,17.5-22.8,30.1-29.7 c12.5-7,26.7-10.3,41-9.8c48.3,0,84.7,41.7,84.7,103.3c0,73.1-43.7,109.2-91,109.2c-12.1,0.5-24.2-2.2-35-7.8 c-10.8-5.6-19.9-13.9-26.6-24.2h-0.8V291h-36v-220L-478.6,71.4L-478.6,71.4z M-442.6,125.6c0.1,5.1,0.6,10.1,1.7,15.1 c3,12.3,9.9,23.3,19.8,31.1c9.9,7.8,22.1,12.1,34.7,12.1c38.5,0,60.7-31.9,60.7-78.5c0-40.7-21.1-75.6-59.5-75.6 c-12.9,0.4-25.3,5.1-35.3,13.4c-9.9,8.3-16.9,19.7-19.6,32.4c-1.5,4.9-2.3,10-2.5,15.1V125.6L-442.6,125.6L-442.6,125.6z"/>
          </g>
        </g>
        <g transform="translate(606.740726, 56.837104)">
          <g transform="translate(0.751226, 1.989299)">
            <path d="M-440.8,0l43.7,120.1c4.5,13.4,9.5,29.4,12.8,41.7h0.8c3.7-12.2,7.9-27.7,12.8-42.4 l39.7-119.2h38.5L-346.9,145c-26,69.7-43.7,105.4-68.6,127.2c-12.5,11.7-27.9,20-44.6,23.9l-9.1-31.1 c11.7-3.9,22.5-10.1,31.8-18.1c13.2-11.1,23.7-25.2,30.6-41.2c1.5-2.8,2.5-5.7,2.9-8.8c-0.3-3.3-1.2-6.6-2.5-9.7L-480.2,0.1 h39.7L-440.8,0L-440.8,0z"/>
          </g>
        </g>
        <g transform="translate(822.748104, 0.000000)">
          <g transform="translate(1.464050, 0.378914)">
            <path d="M-413.7,0v58.3h52v28.2h-52V196c0,25,7,39.5,27.3,39.5c7.1,0.1,14.2-0.7,21.1-2.5 l1.7,27.7c-10.3,3.7-21.3,5.4-32.2,5c-7.3,0.4-14.6-0.7-21.3-3.4c-6.8-2.7-12.9-6.8-17.9-12.1c-10.3-10.9-14.1-29-14.1-52.9 V86.5h-31V58.3h31V9.6L-413.7,0L-413.7,0z"/>
          </g>
        </g>
        <g transform="translate(974.433286, 53.479638)">
          <g transform="translate(0.990034, 0.610339)">
            <path d="M-445.8,113c0.8,50,32.2,70.6,68.6,70.6c19,0.6,37.9-3,55.3-10.5l6.2,26.4 c-20.9,8.9-43.5,13.1-66.2,12.6c-61.5,0-98.3-41.2-98.3-102.5C-480.2,48.2-444.7,0-386.5,0c65.2,0,82.7,58.3,82.7,95.7 c-0.1,5.8-0.5,11.5-1.2,17.2h-140.6H-445.8L-445.8,113z M-339.2,86.6c0.4-23.5-9.5-60.1-50.4-60.1 c-36.8,0-52.8,34.4-55.7,60.1H-339.2L-339.2,86.6L-339.2,86.6z"/>
          </g>
        </g>
        <g transform="translate(1201.961058, 53.479638)">
          <g transform="translate(1.179640, 0.705068)">
            <path d="M-478.6,68c0-23.9-0.4-44.5-1.7-63.4h31.8l1.2,39.9h1.7c9.1-27.3,31-44.5,55.3-44.5 c3.5-0.1,7,0.4,10.3,1.2v34.8c-4.1-0.9-8.2-1.3-12.4-1.2c-25.6,0-43.7,19.7-48.7,47.4c-1,5.7-1.6,11.5-1.7,17.2v108.3h-36V68 L-478.6,68z"/>
          </g>
        </g>
      </g>

      <g class="jp-icon-warn0" fill="#F37726">
        <path d="M1352.3,326.2h37V28h-37V326.2z M1604.8,326.2c-2.5-13.9-3.4-31.1-3.4-48.7v-76 c0-40.7-15.1-83.1-77.3-83.1c-25.6,0-50,7.1-66.8,18.1l8.4,24.4c14.3-9.2,34-15.1,53-15.1c41.6,0,46.2,30.2,46.2,47v4.2 c-78.6-0.4-122.3,26.5-122.3,75.6c0,29.4,21,58.4,62.2,58.4c29,0,50.9-14.3,62.2-30.2h1.3l2.9,25.6H1604.8z M1565.7,257.7 c0,3.8-0.8,8-2.1,11.8c-5.9,17.2-22.7,34-49.2,34c-18.9,0-34.9-11.3-34.9-35.3c0-39.5,45.8-46.6,86.2-45.8V257.7z M1698.5,326.2 l1.7-33.6h1.3c15.1,26.9,38.7,38.2,68.1,38.2c45.4,0,91.2-36.1,91.2-108.8c0.4-61.7-35.3-103.7-85.7-103.7 c-32.8,0-56.3,14.7-69.3,37.4h-0.8V28h-36.6v245.7c0,18.1-0.8,38.6-1.7,52.5H1698.5z M1704.8,208.2c0-5.9,1.3-10.9,2.1-15.1 c7.6-28.1,31.1-45.4,56.3-45.4c39.5,0,60.5,34.9,60.5,75.6c0,46.6-23.1,78.1-61.8,78.1c-26.9,0-48.3-17.6-55.5-43.3 c-0.8-4.2-1.7-8.8-1.7-13.4V208.2z"/>
      </g>
    </svg>
kind: ConfigMap
metadata:
  labels:
    app: jupyter-web-app
    kustomize.component: jupyter-web-app
  name: jupyter-web-app-logos
  namespace: kubeflow
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool, kubectl_manifest.kubeflow-kubeflow-namespace]
}

resource "kubectl_manifest" "kubeflow-notebooks-configmap-jupyter-web-app-parameters" {
  yaml_body = <<YAML
apiVersion: v1
data:
  JWA_APP_SECURE_COOKIES: "true"
  JWA_CLUSTER_DOMAIN: cluster.local
  JWA_PREFIX: /jupyter
  JWA_UI: default
  JWA_USERID_HEADER: kubeflow-userid
  JWA_USERID_PREFIX: ""
kind: ConfigMap
metadata:
  labels:
    app: jupyter-web-app
    kustomize.component: jupyter-web-app
  name: jupyter-web-app-parameters-42k97gcbmb
  namespace: kubeflow
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool, kubectl_manifest.kubeflow-kubeflow-namespace]
}

resource "kubectl_manifest" "kubeflow-notebooks-service-jupyter-web-app-service" {
  yaml_body = <<YAML
apiVersion: v1
kind: Service
metadata:
  labels:
    app: jupyter-web-app
    kustomize.component: jupyter-web-app
    run: jupyter-web-app
  name: jupyter-web-app-service
  namespace: kubeflow
spec:
  ports:
  - name: http
    port: 80
    protocol: TCP
    targetPort: 5000
  selector:
    app: jupyter-web-app
    kustomize.component: jupyter-web-app
  type: ClusterIP
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool, kubectl_manifest.kubeflow-kubeflow-namespace]
}

resource "kubectl_manifest" "kubeflow-notebooks-deployment-jupyter-web-app-deployment" {
  yaml_body = <<YAML
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: jupyter-web-app
    kustomize.component: jupyter-web-app
  name: jupyter-web-app-deployment
  namespace: kubeflow
spec:
  replicas: 1
  selector:
    matchLabels:
      app: jupyter-web-app
      kustomize.component: jupyter-web-app
  template:
    metadata:
      labels:
        app: jupyter-web-app
        kustomize.component: jupyter-web-app
    spec:
      containers:
      - env:
        - name: APP_PREFIX
          value: /jupyter
        - name: UI
          value: default
        - name: USERID_HEADER
          value: kubeflow-userid
        - name: USERID_PREFIX
          value: ""
        - name: APP_SECURE_COOKIES
          value: "true"
        image: docker.io/kubeflownotebookswg/jupyter-web-app:v1.7.0
        name: jupyter-web-app
        ports:
        - containerPort: 5000
        volumeMounts:
        - mountPath: /etc/config
          name: config-volume
        - mountPath: /src/apps/default/static/assets/logos
          name: logos-volume
      serviceAccountName: jupyter-web-app-service-account
      volumes:
      - configMap:
          name: jupyter-web-app-config-84khm987mh
        name: config-volume
      - configMap:
          name: jupyter-web-app-logos
        name: logos-volume
      tolerations:
      - key: "kubeflow"
        operator: "Equal"
        value: "control-plane"
        effect: "NoSchedule"
      nodeSelector:
        kubeflow: control-plane
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool, kubectl_manifest.kubeflow-kubeflow-namespace, kubectl_manifest.kubeflow-notebooks-configmap-jupyter-web-app-config, kubectl_manifest.kubeflow-notebooks-configmap-jupyter-web-app-logo, kubectl_manifest.kubeflow-istio-deployment-istiod, kubectl_manifest.kubeflow-istio-mutatingwebhookconfiguration-sidecar-injector]
}

resource "kubectl_manifest" "kubeflow-notebooks-destinationrule-jupyter-web-app" {
  yaml_body = <<YAML
apiVersion: networking.istio.io/v1alpha3
kind: DestinationRule
metadata:
  labels:
    app: jupyter-web-app
    kustomize.component: jupyter-web-app
  name: jupyter-web-app
  namespace: kubeflow
spec:
  host: jupyter-web-app-service.kubeflow.svc.cluster.local
  trafficPolicy:
    tls:
      mode: ISTIO_MUTUAL
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool, kubectl_manifest.kubeflow-istio-crd-destinationrules, kubectl_manifest.kubeflow-kubeflow-namespace]
}

resource "kubectl_manifest" "kubeflow-notebooks-virtualservice-jupyter-web-app-jupyter-web-app" {
  yaml_body = <<YAML
apiVersion: networking.istio.io/v1alpha3
kind: VirtualService
metadata:
  labels:
    app: jupyter-web-app
    kustomize.component: jupyter-web-app
  name: jupyter-web-app-jupyter-web-app
  namespace: kubeflow
spec:
  gateways:
  - kubeflow-gateway
  hosts:
  - '*'
  http:
  - headers:
      request:
        add:
          x-forwarded-prefix: /jupyter
    match:
    - uri:
        prefix: /jupyter/
    rewrite:
      uri: /
    route:
    - destination:
        host: jupyter-web-app-service.kubeflow.svc.cluster.local
        port:
          number: 80
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool, kubectl_manifest.kubeflow-kubeflow-namespace]
}

resource "kubectl_manifest" "kubeflow-notebooks-authorizationpolicy-jupyter-web-app" {
  yaml_body = <<YAML
apiVersion: security.istio.io/v1beta1
kind: AuthorizationPolicy
metadata:
  labels:
    app: jupyter-web-app
    kustomize.component: jupyter-web-app
  name: jupyter-web-app
  namespace: kubeflow
spec:
  action: ALLOW
  rules:
  - from:
    - source:
        principals:
        - cluster.local/ns/istio-system/sa/istio-ingressgateway-service-account
  selector:
    matchLabels:
      app: jupyter-web-app
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool, kubectl_manifest.kubeflow-kubeflow-namespace]
}