resource "kubectl_manifest" "kubeflow-pvc-viewer-controller-crd-pvcviewers" {
  yaml_body = <<YAML
apiVersion: apiextensions.k8s.io/v1
kind: CustomResourceDefinition
metadata:
  annotations:
    cert-manager.io/inject-ca-from: kubeflow/pvcviewer-serving-cert
    controller-gen.kubebuilder.io/version: v0.10.0
  labels:
    app: pvcviewer
  name: pvcviewers.kubeflow.org
spec:
  conversion:
    strategy: Webhook
    webhook:
      clientConfig:
        service:
          name: pvcviewer-webhook-service
          namespace: kubeflow
          path: /convert
      conversionReviewVersions:
      - v1
  group: kubeflow.org
  names:
    kind: PVCViewer
    listKind: PVCViewerList
    plural: pvcviewers
    singular: pvcviewer
  scope: Namespaced
  versions:
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
              networking:
                properties:
                  basePrefix:
                    type: string
                  rewrite:
                    type: string
                  targetPort:
                    anyOf:
                    - type: integer
                    - type: string
                    x-kubernetes-int-or-string: true
                  timeout:
                    type: string
                type: object
              podSpec:
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
                                  x-kubernetes-map-type: atomic
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
                                  x-kubernetes-map-type: atomic
                                type: array
                            required:
                            - nodeSelectorTerms
                            type: object
                            x-kubernetes-map-type: atomic
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
                                      x-kubernetes-map-type: atomic
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
                                      x-kubernetes-map-type: atomic
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
                                  x-kubernetes-map-type: atomic
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
                                  x-kubernetes-map-type: atomic
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
                                      x-kubernetes-map-type: atomic
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
                                      x-kubernetes-map-type: atomic
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
                                  x-kubernetes-map-type: atomic
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
                                  x-kubernetes-map-type: atomic
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
                                    x-kubernetes-map-type: atomic
                                  fieldRef:
                                    properties:
                                      apiVersion:
                                        type: string
                                      fieldPath:
                                        type: string
                                    required:
                                    - fieldPath
                                    type: object
                                    x-kubernetes-map-type: atomic
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
                                    x-kubernetes-map-type: atomic
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
                                    x-kubernetes-map-type: atomic
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
                                x-kubernetes-map-type: atomic
                              prefix:
                                type: string
                              secretRef:
                                properties:
                                  name:
                                    type: string
                                  optional:
                                    type: boolean
                                type: object
                                x-kubernetes-map-type: atomic
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
                                    x-kubernetes-map-type: atomic
                                  fieldRef:
                                    properties:
                                      apiVersion:
                                        type: string
                                      fieldPath:
                                        type: string
                                    required:
                                    - fieldPath
                                    type: object
                                    x-kubernetes-map-type: atomic
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
                                    x-kubernetes-map-type: atomic
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
                                    x-kubernetes-map-type: atomic
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
                                x-kubernetes-map-type: atomic
                              prefix:
                                type: string
                              secretRef:
                                properties:
                                  name:
                                    type: string
                                  optional:
                                    type: boolean
                                type: object
                                x-kubernetes-map-type: atomic
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
                  hostUsers:
                    type: boolean
                  hostname:
                    type: string
                  imagePullSecrets:
                    items:
                      properties:
                        name:
                          type: string
                      type: object
                      x-kubernetes-map-type: atomic
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
                                    x-kubernetes-map-type: atomic
                                  fieldRef:
                                    properties:
                                      apiVersion:
                                        type: string
                                      fieldPath:
                                        type: string
                                    required:
                                    - fieldPath
                                    type: object
                                    x-kubernetes-map-type: atomic
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
                                    x-kubernetes-map-type: atomic
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
                                    x-kubernetes-map-type: atomic
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
                                x-kubernetes-map-type: atomic
                              prefix:
                                type: string
                              secretRef:
                                properties:
                                  name:
                                    type: string
                                  optional:
                                    type: boolean
                                type: object
                                x-kubernetes-map-type: atomic
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
                          x-kubernetes-map-type: atomic
                        matchLabelKeys:
                          items:
                            type: string
                          type: array
                          x-kubernetes-list-type: atomic
                        maxSkew:
                          format: int32
                          type: integer
                        minDomains:
                          format: int32
                          type: integer
                        nodeAffinityPolicy:
                          type: string
                        nodeTaintsPolicy:
                          type: string
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
                              x-kubernetes-map-type: atomic
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
                              x-kubernetes-map-type: atomic
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
                          x-kubernetes-map-type: atomic
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
                              x-kubernetes-map-type: atomic
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
                                    x-kubernetes-map-type: atomic
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
                                    x-kubernetes-map-type: atomic
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
                                      x-kubernetes-map-type: atomic
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
                                      x-kubernetes-map-type: atomic
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
                                      x-kubernetes-map-type: atomic
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
                              x-kubernetes-map-type: atomic
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
                              x-kubernetes-map-type: atomic
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
                                    x-kubernetes-map-type: atomic
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
                                              x-kubernetes-map-type: atomic
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
                                              x-kubernetes-map-type: atomic
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
                                    x-kubernetes-map-type: atomic
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
                              x-kubernetes-map-type: atomic
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
                              x-kubernetes-map-type: atomic
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
                              x-kubernetes-map-type: atomic
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
              pvc:
                type: string
              rwoScheduling:
                default: false
                type: boolean
            required:
            - pvc
            - rwoScheduling
            type: object
          status:
            properties:
              conditions:
                items:
                  properties:
                    lastTransitionTime:
                      format: date-time
                      type: string
                    lastUpdateTime:
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
              ready:
                default: false
                type: boolean
              url:
                type: string
            required:
            - ready
            type: object
        type: object
    served: true
    storage: true
    subresources:
      status: {}
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool]
}

resource "kubectl_manifest" "kubeflow-pvc-viewer-controller-serviceaccount-pvcviewer-controller-manager" {
  yaml_body = <<YAML
apiVersion: v1
kind: ServiceAccount
metadata:
  labels:
    app: pvcviewer
    app.kubernetes.io/component: rbac
    app.kubernetes.io/created-by: pvc-viewer
    app.kubernetes.io/instance: controller-manager-sa
    app.kubernetes.io/managed-by: kustomize
    app.kubernetes.io/name: serviceaccount
    app.kubernetes.io/part-of: pvc-viewer
  name: pvcviewer-controller-manager
  namespace: kubeflow
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool, kubectl_manifest.kubeflow-kubeflow-namespace]
}

resource "kubectl_manifest" "kubeflow-pvc-viewer-controller-role-pvcviewer-leader-election-role" {
  yaml_body = <<YAML
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  labels:
    app: pvcviewer
    app.kubernetes.io/component: rbac
    app.kubernetes.io/created-by: pvc-viewer
    app.kubernetes.io/instance: leader-election-role
    app.kubernetes.io/managed-by: kustomize
    app.kubernetes.io/name: role
    app.kubernetes.io/part-of: pvc-viewer
  name: pvcviewer-leader-election-role
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

resource "kubectl_manifest" "kubeflow-pvc-viewer-controller-clusterrole-pvcviewer-metrics-reader" {
  yaml_body = <<YAML
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  labels:
    app: pvcviewer
    app.kubernetes.io/component: kube-rbac-proxy
    app.kubernetes.io/created-by: pvc-viewer
    app.kubernetes.io/instance: metrics-reader
    app.kubernetes.io/managed-by: kustomize
    app.kubernetes.io/name: clusterrole
    app.kubernetes.io/part-of: pvc-viewer
  name: pvcviewer-metrics-reader
rules:
- nonResourceURLs:
  - /metrics
  verbs:
  - get
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool]
}

resource "kubectl_manifest" "kubeflow-pvc-viewer-controller-clusterrole-pvcviewer-proxy-role" {
  yaml_body = <<YAML
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  labels:
    app: pvcviewer
    app.kubernetes.io/component: kube-rbac-proxy
    app.kubernetes.io/created-by: pvc-viewer
    app.kubernetes.io/instance: proxy-role
    app.kubernetes.io/managed-by: kustomize
    app.kubernetes.io/name: clusterrole
    app.kubernetes.io/part-of: pvc-viewer
  name: pvcviewer-proxy-role
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

resource "kubectl_manifest" "kubeflow-pvc-viewer-controller-clusterrole-pvcviewer-role" {
  yaml_body = <<YAML
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  labels:
    app: pvcviewer
  name: pvcviewer-role
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
  - kubeflow.org
  resources:
  - pvcviewers
  verbs:
  - create
  - delete
  - get
  - list
  - patch
  - update
  - watch
- apiGroups:
  - kubeflow.org
  resources:
  - pvcviewers/finalizers
  verbs:
  - update
- apiGroups:
  - kubeflow.org
  resources:
  - pvcviewers/status
  verbs:
  - get
  - patch
  - update
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
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool]
}

resource "kubectl_manifest" "kubeflow-pvc-viewer-controller-rolebinding-pvcviewer-leader-election-rolebinding" {
  yaml_body = <<YAML
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  labels:
    app: pvcviewer
    app.kubernetes.io/component: rbac
    app.kubernetes.io/created-by: pvc-viewer
    app.kubernetes.io/instance: leader-election-rolebinding
    app.kubernetes.io/managed-by: kustomize
    app.kubernetes.io/name: rolebinding
    app.kubernetes.io/part-of: pvc-viewer
  name: pvcviewer-leader-election-rolebinding
  namespace: kubeflow
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: Role
  name: pvcviewer-leader-election-role
subjects:
- kind: ServiceAccount
  name: pvcviewer-controller-manager
  namespace: kubeflow
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool, kubectl_manifest.kubeflow-kubeflow-namespace]
}

resource "kubectl_manifest" "kubeflow-pvc-viewer-controller-clusterrolebinding-pvcviewer-manager-rolebinding" {
  yaml_body = <<YAML
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  labels:
    app: pvcviewer
    app.kubernetes.io/component: rbac
    app.kubernetes.io/created-by: pvc-viewer
    app.kubernetes.io/instance: manager-rolebinding
    app.kubernetes.io/managed-by: kustomize
    app.kubernetes.io/name: clusterrolebinding
    app.kubernetes.io/part-of: pvc-viewer
  name: pvcviewer-manager-rolebinding
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: pvcviewer-role
subjects:
- kind: ServiceAccount
  name: pvcviewer-controller-manager
  namespace: kubeflow
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool, kubectl_manifest.kubeflow-kubeflow-namespace]
}

resource "kubectl_manifest" "kubeflow-pvc-viewer-controller-clusterrolebinding-pvcviewer-proxy-rolebinding" {
  yaml_body = <<YAML
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  labels:
    app: pvcviewer
    app.kubernetes.io/component: kube-rbac-proxy
    app.kubernetes.io/created-by: pvc-viewer
    app.kubernetes.io/instance: proxy-rolebinding
    app.kubernetes.io/managed-by: kustomize
    app.kubernetes.io/name: clusterrolebinding
    app.kubernetes.io/part-of: pvc-viewer
  name: pvcviewer-proxy-rolebinding
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: pvcviewer-proxy-role
subjects:
- kind: ServiceAccount
  name: pvcviewer-controller-manager
  namespace: kubeflow
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool, kubectl_manifest.kubeflow-kubeflow-namespace]
}

resource "kubectl_manifest" "kubeflow-pvc-viewer-controller-service-pvcviewer-controller-manager-metrics-service" {
  yaml_body = <<YAML
apiVersion: v1
kind: Service
metadata:
  labels:
    app: pvcviewer
    app.kubernetes.io/component: kube-rbac-proxy
    app.kubernetes.io/created-by: pvc-viewer
    app.kubernetes.io/instance: controller-manager-metrics-service
    app.kubernetes.io/managed-by: kustomize
    app.kubernetes.io/name: service
    app.kubernetes.io/part-of: pvc-viewer
    control-plane: controller-manager
  name: pvcviewer-controller-manager-metrics-service
  namespace: kubeflow
spec:
  ports:
  - name: https
    port: 8443
    protocol: TCP
    targetPort: https
  selector:
    app: pvcviewer
    control-plane: controller-manager
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool, kubectl_manifest.kubeflow-kubeflow-namespace]
}

resource "kubectl_manifest" "kubeflow-pvc-viewer-controller-service-pvcviewer-webhook-service" {
  yaml_body = <<YAML
apiVersion: v1
kind: Service
metadata:
  labels:
    app: pvcviewer
    app.kubernetes.io/component: webhook
    app.kubernetes.io/created-by: pvc-viewer
    app.kubernetes.io/instance: webhook-service
    app.kubernetes.io/managed-by: kustomize
    app.kubernetes.io/name: service
    app.kubernetes.io/part-of: pvc-viewer
  name: pvcviewer-webhook-service
  namespace: kubeflow
spec:
  ports:
  - port: 443
    protocol: TCP
    targetPort: 9443
  selector:
    app: pvcviewer
    control-plane: controller-manager
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool, kubectl_manifest.kubeflow-kubeflow-namespace]
}

resource "kubectl_manifest" "kubeflow-pvc-viewer-controller-deployment-pvcviewer-controller-manager" {
  yaml_body = <<YAML
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: pvcviewer
    app.kubernetes.io/component: manager
    app.kubernetes.io/created-by: pvc-viewer
    app.kubernetes.io/instance: controller-manager
    app.kubernetes.io/managed-by: kustomize
    app.kubernetes.io/name: deployment
    app.kubernetes.io/part-of: pvc-viewer
    control-plane: controller-manager
  name: pvcviewer-controller-manager
  namespace: kubeflow
spec:
  replicas: 1
  selector:
    matchLabels:
      app: pvcviewer
      control-plane: controller-manager
  template:
    metadata:
      annotations:
        kubectl.kubernetes.io/default-container: manager
        traffic.sidecar.istio.io/excludeInboundPorts: "9443"
      labels:
        app: pvcviewer
        control-plane: controller-manager
    spec:
      affinity:
        nodeAffinity:
          requiredDuringSchedulingIgnoredDuringExecution:
            nodeSelectorTerms:
            - matchExpressions:
              - key: kubernetes.io/arch
                operator: In
                values:
                - amd64
                - arm64
                - ppc64le
                - s390x
              - key: kubernetes.io/os
                operator: In
                values:
                - linux
      containers:
      - args:
        - --health-probe-bind-address=:8081
        - --metrics-bind-address=127.0.0.1:8080
        - --leader-elect
        command:
        - /manager
        image: docker.io/kubeflownotebookswg/pvcviewer-controller
        imagePullPolicy: IfNotPresent
        livenessProbe:
          httpGet:
            path: /healthz
            port: 8081
          initialDelaySeconds: 15
          periodSeconds: 20
        name: manager
        ports:
        - containerPort: 9443
          name: webhook-server
          protocol: TCP
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
          capabilities:
            drop:
            - ALL
        volumeMounts:
        - mountPath: /tmp/k8s-webhook-server/serving-certs
          name: cert
          readOnly: true
      - args:
        - --secure-listen-address=0.0.0.0:8443
        - --upstream=http://127.0.0.1:8080/
        - --logtostderr=true
        - --v=0
        image: gcr.io/kubebuilder/kube-rbac-proxy:v0.13.1
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
          allowPrivilegeEscalation: false
          capabilities:
            drop:
            - ALL
      securityContext:
        runAsNonRoot: true
        seccompProfile:
          type: RuntimeDefault
      serviceAccountName: pvcviewer-controller-manager
      terminationGracePeriodSeconds: 10
      volumes:
      - name: cert
        secret:
          defaultMode: 420
          secretName: webhook-server-cert
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

resource "kubectl_manifest" "kubeflow-pvc-viewer-controller-certificate-pvcviewer-serving-cert" {
  yaml_body = <<YAML
apiVersion: cert-manager.io/v1
kind: Certificate
metadata:
  labels:
    app: pvcviewer
    app.kubernetes.io/component: certificate
    app.kubernetes.io/created-by: pvc-viewer
    app.kubernetes.io/instance: serving-cert
    app.kubernetes.io/managed-by: kustomize
    app.kubernetes.io/name: certificate
    app.kubernetes.io/part-of: pvc-viewer
  name: pvcviewer-serving-cert
  namespace: kubeflow
spec:
  dnsNames:
  - pvcviewer-webhook-service.kubeflow.svc
  - pvcviewer-webhook-service.kubeflow.svc.cluster.local
  issuerRef:
    kind: Issuer
    name: pvcviewer-selfsigned-issuer
  secretName: webhook-server-cert
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool, kubectl_manifest.kubeflow-kubeflow-namespace, kubectl_manifest.kubeflow-cert-manager-deployment-webhook]
}

resource "kubectl_manifest" "kubeflow-pvc-viewer-controller-issuer-pvcviewer-selfsigned-issuer" {
  yaml_body = <<YAML
apiVersion: cert-manager.io/v1
kind: Issuer
metadata:
  labels:
    app: pvcviewer
    app.kubernetes.io/component: certificate
    app.kubernetes.io/created-by: pvc-viewer
    app.kubernetes.io/instance: serving-cert
    app.kubernetes.io/managed-by: kustomize
    app.kubernetes.io/name: certificate
    app.kubernetes.io/part-of: pvc-viewer
  name: pvcviewer-selfsigned-issuer
  namespace: kubeflow
spec:
  selfSigned: {}
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool, kubectl_manifest.kubeflow-kubeflow-namespace, kubectl_manifest.kubeflow-cert-manager-crd-issuers, kubectl_manifest.kubeflow-cert-manager-deployment-webhook]
}

resource "kubectl_manifest" "kubeflow-pvc-viewer-controller-mutatingwebhookconfiguration-pvcviewer-mutating-webhook-configuration" {
  yaml_body = <<YAML
apiVersion: admissionregistration.k8s.io/v1
kind: MutatingWebhookConfiguration
metadata:
  annotations:
    cert-manager.io/inject-ca-from: kubeflow/pvcviewer-serving-cert
  labels:
    app: pvcviewer
    app.kubernetes.io/component: webhook
    app.kubernetes.io/created-by: pvc-viewer
    app.kubernetes.io/instance: mutating-webhook-configuration
    app.kubernetes.io/managed-by: kustomize
    app.kubernetes.io/name: mutatingwebhookconfiguration
    app.kubernetes.io/part-of: pvc-viewer
  name: pvcviewer-mutating-webhook-configuration
webhooks:
- admissionReviewVersions:
  - v1
  clientConfig:
    service:
      name: pvcviewer-webhook-service
      namespace: kubeflow
      path: /mutate-kubeflow-org-v1alpha1-pvcviewer
  failurePolicy: Fail
  name: mpvcviewer.kb.io
  rules:
  - apiGroups:
    - kubeflow.org
    apiVersions:
    - v1alpha1
    operations:
    - CREATE
    - UPDATE
    resources:
    - pvcviewers
  sideEffects: None
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool, kubectl_manifest.kubeflow-kubeflow-namespace]
}

resource "kubectl_manifest" "kubeflow-pvc-viewer-controller-validationwebhookconfiguration-pvcviewer-validating-webhook-configuration" {
  yaml_body = <<YAML
apiVersion: admissionregistration.k8s.io/v1
kind: ValidatingWebhookConfiguration
metadata:
  annotations:
    cert-manager.io/inject-ca-from: kubeflow/pvcviewer-serving-cert
  labels:
    app: pvcviewer
    app.kubernetes.io/component: webhook
    app.kubernetes.io/created-by: pvc-viewer
    app.kubernetes.io/instance: validating-webhook-configuration
    app.kubernetes.io/managed-by: kustomize
    app.kubernetes.io/name: validatingwebhookconfiguration
    app.kubernetes.io/part-of: pvc-viewer
  name: pvcviewer-validating-webhook-configuration
webhooks:
- admissionReviewVersions:
  - v1
  clientConfig:
    service:
      name: pvcviewer-webhook-service
      namespace: kubeflow
      path: /validate-kubeflow-org-v1alpha1-pvcviewer
  failurePolicy: Fail
  name: vpvcviewer.kb.io
  rules:
  - apiGroups:
    - kubeflow.org
    apiVersions:
    - v1alpha1
    operations:
    - CREATE
    - UPDATE
    resources:
    - pvcviewers
  sideEffects: None
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool, kubectl_manifest.kubeflow-kubeflow-namespace]
}