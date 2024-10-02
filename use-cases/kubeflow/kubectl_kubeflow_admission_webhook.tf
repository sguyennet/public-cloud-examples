resource "kubectl_manifest" "kubeflow-admission-webhook-crd-poddefaults" {
  yaml_body = <<YAML
apiVersion: apiextensions.k8s.io/v1
kind: CustomResourceDefinition
metadata:
  annotations:
    controller-gen.kubebuilder.io/version: v0.8.0
  creationTimestamp: null
  labels:
    app: poddefaults
    app.kubernetes.io/component: poddefaults
    app.kubernetes.io/name: poddefaults
    kustomize.component: poddefaults
  name: poddefaults.kubeflow.org
spec:
  group: kubeflow.org
  names:
    kind: PodDefault
    listKind: PodDefaultList
    plural: poddefaults
    singular: poddefault
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
              annotations:
                additionalProperties:
                  type: string
                type: object
              args:
                items:
                  type: string
                type: array
              automountServiceAccountToken:
                type: boolean
              command:
                items:
                  type: string
                type: array
              desc:
                type: string
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
              labels:
                additionalProperties:
                  type: string
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
              serviceAccountName:
                type: string
              sidecars:
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
            - selector
            type: object
          status:
            type: object
        type: object
    served: true
    storage: true
status:
  acceptedNames:
    kind: ""
    plural: ""
  conditions: []
  storedVersions: []
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool]
}

resource "kubectl_manifest" "kubeflow-admission-webhook-serviceaccount-admission-webhook-service-account" {
  yaml_body = <<YAML
apiVersion: v1
kind: ServiceAccount
metadata:
  labels:
    app: poddefaults
    app.kubernetes.io/component: poddefaults
    app.kubernetes.io/name: poddefaults
    kustomize.component: poddefaults
  name: admission-webhook-service-account
  namespace: kubeflow
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool, kubectl_manifest.kubeflow-kubeflow-namespace]
}

resource "kubectl_manifest" "kubeflow-admission-webhook-clusterrole-admission-webhook-cluster-role" {
  yaml_body = <<YAML
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  labels:
    app: poddefaults
    app.kubernetes.io/component: poddefaults
    app.kubernetes.io/name: poddefaults
    kustomize.component: poddefaults
  name: admission-webhook-cluster-role
rules:
- apiGroups:
  - kubeflow.org
  resources:
  - poddefaults
  verbs:
  - get
  - watch
  - list
  - update
  - create
  - patch
  - delete
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool]
}

resource "kubectl_manifest" "kubeflow-admission-webhook-clusterrole-admission-webhook-kubeflow-poddefaults-admin" {
  yaml_body = <<YAML
aggregationRule:
  clusterRoleSelectors:
  - matchLabels:
      rbac.authorization.kubeflow.org/aggregate-to-kubeflow-poddefaults-admin: "true"
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  labels:
    app: poddefaults
    app.kubernetes.io/component: poddefaults
    app.kubernetes.io/name: poddefaults
    kustomize.component: poddefaults
    rbac.authorization.kubeflow.org/aggregate-to-kubeflow-admin: "true"
  name: admission-webhook-kubeflow-poddefaults-admin
rules: []
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool]
}

resource "kubectl_manifest" "kubeflow-admission-webhook-clusterrole-admission-webhook-kubeflow-poddefaults-edit" {
  yaml_body = <<YAML
aggregationRule:
  clusterRoleSelectors:
  - matchLabels:
      rbac.authorization.kubeflow.org/aggregate-to-kubeflow-poddefaults-edit: "true"
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  labels:
    app: poddefaults
    app.kubernetes.io/component: poddefaults
    app.kubernetes.io/name: poddefaults
    kustomize.component: poddefaults
    rbac.authorization.kubeflow.org/aggregate-to-kubeflow-edit: "true"
  name: admission-webhook-kubeflow-poddefaults-edit
rules: []
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool]
}

resource "kubectl_manifest" "kubeflow-admission-webhook-clusterrole-admission-webhook-kubeflow-poddefaults-view" {
  yaml_body = <<YAML
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  labels:
    app: poddefaults
    app.kubernetes.io/component: poddefaults
    app.kubernetes.io/name: poddefaults
    kustomize.component: poddefaults
    rbac.authorization.kubeflow.org/aggregate-to-kubeflow-poddefaults-admin: "true"
    rbac.authorization.kubeflow.org/aggregate-to-kubeflow-poddefaults-edit: "true"
    rbac.authorization.kubeflow.org/aggregate-to-kubeflow-view: "true"
  name: admission-webhook-kubeflow-poddefaults-view
rules:
- apiGroups:
  - kubeflow.org
  resources:
  - poddefaults
  verbs:
  - get
  - list
  - watch
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool]
}

resource "kubectl_manifest" "kubeflow-admission-webhook-clusterrolebinding-admission-webhook-cluster-role-binding" {
  yaml_body = <<YAML
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  labels:
    app: poddefaults
    app.kubernetes.io/component: poddefaults
    app.kubernetes.io/name: poddefaults
    kustomize.component: poddefaults
  name: admission-webhook-cluster-role-binding
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: admission-webhook-cluster-role
subjects:
- kind: ServiceAccount
  name: admission-webhook-service-account
  namespace: kubeflow
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool]
}

resource "kubectl_manifest" "kubeflow-admission-webhook-service-admission-webhook-service" {
  yaml_body = <<YAML
apiVersion: v1
kind: Service
metadata:
  labels:
    app: poddefaults
    app.kubernetes.io/component: poddefaults
    app.kubernetes.io/name: poddefaults
    kustomize.component: poddefaults
  name: admission-webhook-service
  namespace: kubeflow
spec:
  ports:
  - name: https-webhook
    port: 443
    targetPort: https-webhook
  selector:
    app: poddefaults
    app.kubernetes.io/component: poddefaults
    app.kubernetes.io/name: poddefaults
    kustomize.component: poddefaults
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool, kubectl_manifest.kubeflow-kubeflow-namespace]
}

resource "kubectl_manifest" "kubeflow-admission-webhook-deployment-admission-webhook-deployment" {
  yaml_body = <<YAML
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: poddefaults
    app.kubernetes.io/component: poddefaults
    app.kubernetes.io/name: poddefaults
    kustomize.component: poddefaults
  name: admission-webhook-deployment
  namespace: kubeflow
spec:
  selector:
    matchLabels:
      app: poddefaults
      app.kubernetes.io/component: poddefaults
      app.kubernetes.io/name: poddefaults
      kustomize.component: poddefaults
  template:
    metadata:
      annotations:
        sidecar.istio.io/inject: "false"
      labels:
        app: poddefaults
        app.kubernetes.io/component: poddefaults
        app.kubernetes.io/name: poddefaults
        kustomize.component: poddefaults
    spec:
      containers:
      - args:
        - --tlsCertFile=/etc/webhook/certs/tls.crt
        - --tlsKeyFile=/etc/webhook/certs/tls.key
        image: docker.io/kubeflownotebookswg/poddefaults-webhook:v1.7.0
        name: admission-webhook
        ports:
        - containerPort: 4443
          name: https-webhook
        volumeMounts:
        - mountPath: /etc/webhook/certs
          name: webhook-cert
          readOnly: true
      serviceAccountName: admission-webhook-service-account
      volumes:
      - name: webhook-cert
        secret:
          secretName: webhook-certs
      tolerations:
      - key: "kubeflow"
        operator: "Equal"
        value: "control-plane"
        effect: "NoSchedule"
      nodeSelector:
        kubeflow: control-plane
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool, kubectl_manifest.kubeflow-kubeflow-namespace, kubectl_manifest.kubeflow-admission-webhook-certificate-admission-webhook-cert, kubectl_manifest.kubeflow-istio-deployment-istiod, kubectl_manifest.kubeflow-istio-mutatingwebhookconfiguration-sidecar-injector]
}

resource "kubectl_manifest" "kubeflow-admission-webhook-certificate-admission-webhook-cert" {
  yaml_body = <<YAML
apiVersion: cert-manager.io/v1
kind: Certificate
metadata:
  labels:
    app: poddefaults
    app.kubernetes.io/component: poddefaults
    app.kubernetes.io/name: poddefaults
    kustomize.component: poddefaults
  name: admission-webhook-cert
  namespace: kubeflow
spec:
  commonName: admission-webhook-service.kubeflow.svc
  dnsNames:
  - admission-webhook-service.kubeflow.svc
  - admission-webhook-service.kubeflow.svc.cluster.local
  isCA: true
  issuerRef:
    kind: Issuer
    name: admission-webhook-selfsigned-issuer
  secretName: webhook-certs
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool, kubectl_manifest.kubeflow-kubeflow-namespace, kubectl_manifest.kubeflow-cert-manager-deployment-webhook]
}

resource "kubectl_manifest" "kubeflow-admission-webhook-issuer-admission-webhook-selfsigned-issuer" {
  yaml_body = <<YAML
apiVersion: cert-manager.io/v1
kind: Issuer
metadata:
  labels:
    app: poddefaults
    app.kubernetes.io/component: poddefaults
    app.kubernetes.io/name: poddefaults
    kustomize.component: poddefaults
  name: admission-webhook-selfsigned-issuer
  namespace: kubeflow
spec:
  selfSigned: {}
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool, kubectl_manifest.kubeflow-kubeflow-namespace, kubectl_manifest.kubeflow-cert-manager-crd-issuers, kubectl_manifest.kubeflow-cert-manager-deployment-webhook]
}

resource "kubectl_manifest" "kubeflow-admission-webhook-mutatingwebhookconfiguration-admission-webhook-mutating-webhook-configuration" {
  yaml_body = <<YAML
apiVersion: admissionregistration.k8s.io/v1
kind: MutatingWebhookConfiguration
metadata:
  annotations:
    cert-manager.io/inject-ca-from: kubeflow/admission-webhook-cert
  labels:
    app: poddefaults
    app.kubernetes.io/component: poddefaults
    app.kubernetes.io/name: poddefaults
    kustomize.component: poddefaults
  name: admission-webhook-mutating-webhook-configuration
webhooks:
- admissionReviewVersions:
  - v1beta1
  - v1
  clientConfig:
    caBundle: ""
    service:
      name: admission-webhook-service
      namespace: kubeflow
      path: /apply-poddefault
  failurePolicy: Fail
  name: admission-webhook-deployment.kubeflow.org
  namespaceSelector:
    matchLabels:
      app.kubernetes.io/part-of: kubeflow-profile
  rules:
  - apiGroups:
    - ""
    apiVersions:
    - v1
    operations:
    - CREATE
    resources:
    - pods
  sideEffects: None
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool, kubectl_manifest.kubeflow-kubeflow-namespace]
}