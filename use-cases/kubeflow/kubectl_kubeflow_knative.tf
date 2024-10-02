resource "kubectl_manifest" "kubeflow-knative-namespace" {
  yaml_body = <<YAML
apiVersion: v1
kind: Namespace
metadata:
  labels:
    app.kubernetes.io/name: knative-serving
    app.kubernetes.io/version: 1.8.0
    istio-injection: enabled
  name: knative-serving
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool]
}

resource "kubectl_manifest" "kubeflow-knative-customresourcedefinition-certificates" {
  yaml_body = <<YAML
apiVersion: apiextensions.k8s.io/v1
kind: CustomResourceDefinition
metadata:
  labels:
    app.kubernetes.io/component: networking
    app.kubernetes.io/name: knative-serving
    app.kubernetes.io/version: 1.8.0
    knative.dev/crd-install: "true"
  name: certificates.networking.internal.knative.dev
spec:
  group: networking.internal.knative.dev
  names:
    categories:
    - knative-internal
    - networking
    kind: Certificate
    plural: certificates
    shortNames:
    - kcert
    singular: certificate
  scope: Namespaced
  versions:
  - additionalPrinterColumns:
    - jsonPath: .status.conditions[?(@.type=="Ready")].status
      name: Ready
      type: string
    - jsonPath: .status.conditions[?(@.type=="Ready")].reason
      name: Reason
      type: string
    name: v1alpha1
    schema:
      openAPIV3Schema:
        description: Certificate is responsible for provisioning a SSL certificate
          for the given hosts. It is a Knative abstraction for various SSL certificate
          provisioning solutions (such as cert-manager or self-signed SSL certificate).
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
            description: 'Spec is the desired state of the Certificate. More info:
              https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status'
            properties:
              dnsNames:
                description: DNSNames is a list of DNS names the Certificate could
                  support. The wildcard format of DNSNames (e.g. *.default.example.com)
                  is supported.
                items:
                  type: string
                type: array
              secretName:
                description: SecretName is the name of the secret resource to store
                  the SSL certificate in.
                type: string
            required:
            - dnsNames
            - secretName
            type: object
          status:
            description: 'Status is the current state of the Certificate. More info:
              https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status'
            properties:
              annotations:
                additionalProperties:
                  type: string
                description: Annotations is additional Status fields for the Resource
                  to save some additional State as well as convey more information
                  to the user. This is roughly akin to Annotations on any k8s resource,
                  just the reconciler conveying richer information outwards.
                type: object
              conditions:
                description: Conditions the latest available observations of a resource's
                  current state.
                items:
                  description: 'Condition defines a readiness condition for a Knative
                    resource. See: https://github.com/kubernetes/community/blob/master/contributors/devel/sig-architecture/api-conventions.md#typical-status-properties'
                  properties:
                    lastTransitionTime:
                      description: LastTransitionTime is the last time the condition
                        transitioned from one status to another. We use VolatileTime
                        in place of metav1.Time to exclude this from creating equality.Semantic
                        differences (all other things held constant).
                      type: string
                    message:
                      description: A human readable message indicating details about
                        the transition.
                      type: string
                    reason:
                      description: The reason for the condition's last transition.
                      type: string
                    severity:
                      description: Severity with which to treat failures of this type
                        of condition. When this is not specified, it defaults to Error.
                      type: string
                    status:
                      description: Status of the condition, one of True, False, Unknown.
                      type: string
                    type:
                      description: Type of condition.
                      type: string
                  required:
                  - status
                  - type
                  type: object
                type: array
              http01Challenges:
                description: HTTP01Challenges is a list of HTTP01 challenges that
                  need to be fulfilled in order to get the TLS certificate..
                items:
                  description: HTTP01Challenge defines the status of a HTTP01 challenge
                    that a certificate needs to fulfill.
                  properties:
                    serviceName:
                      description: ServiceName is the name of the service to serve
                        HTTP01 challenge requests.
                      type: string
                    serviceNamespace:
                      description: ServiceNamespace is the namespace of the service
                        to serve HTTP01 challenge requests.
                      type: string
                    servicePort:
                      anyOf:
                      - type: integer
                      - type: string
                      description: ServicePort is the port of the service to serve
                        HTTP01 challenge requests.
                      x-kubernetes-int-or-string: true
                    url:
                      description: URL is the URL that the HTTP01 challenge is expected
                        to serve on.
                      type: string
                  type: object
                type: array
              notAfter:
                description: The expiration time of the TLS certificate stored in
                  the secret named by this resource in spec.secretName.
                format: date-time
                type: string
              observedGeneration:
                description: ObservedGeneration is the 'Generation' of the Service
                  that was last processed by the controller.
                format: int64
                type: integer
            type: object
        type: object
    served: true
    storage: true
    subresources:
      status: {}
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool]
}

resource "kubectl_manifest" "kubeflow-knative-customresourcedefinition-clusterdomainclaims" {
  yaml_body = <<YAML
apiVersion: apiextensions.k8s.io/v1
kind: CustomResourceDefinition
metadata:
  labels:
    app.kubernetes.io/component: networking
    app.kubernetes.io/name: knative-serving
    app.kubernetes.io/version: 1.8.0
    knative.dev/crd-install: "true"
  name: clusterdomainclaims.networking.internal.knative.dev
spec:
  group: networking.internal.knative.dev
  names:
    categories:
    - knative-internal
    - networking
    kind: ClusterDomainClaim
    plural: clusterdomainclaims
    shortNames:
    - cdc
    singular: clusterdomainclaim
  scope: Cluster
  versions:
  - name: v1alpha1
    schema:
      openAPIV3Schema:
        description: ClusterDomainClaim is a cluster-wide reservation for a particular
          domain name.
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
            description: 'Spec is the desired state of the ClusterDomainClaim. More
              info: https://github.com/kubernetes/community/blob/master/contributors/devel/sig-architecture/api-conventions.md#spec-and-status'
            properties:
              namespace:
                description: Namespace is the namespace which is allowed to create
                  a DomainMapping using this ClusterDomainClaim's name.
                type: string
            required:
            - namespace
            type: object
        type: object
    served: true
    storage: true
    subresources:
      status: {}
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool]
}

resource "kubectl_manifest" "kubeflow-knative-customresourcedefinition-configurations" {
  yaml_body = <<YAML
apiVersion: apiextensions.k8s.io/v1
kind: CustomResourceDefinition
metadata:
  labels:
    app.kubernetes.io/name: knative-serving
    app.kubernetes.io/version: 1.8.0
    duck.knative.dev/podspecable: "true"
    knative.dev/crd-install: "true"
  name: configurations.serving.knative.dev
spec:
  group: serving.knative.dev
  names:
    categories:
    - all
    - knative
    - serving
    kind: Configuration
    plural: configurations
    shortNames:
    - config
    - cfg
    singular: configuration
  scope: Namespaced
  versions:
  - additionalPrinterColumns:
    - jsonPath: .status.latestCreatedRevisionName
      name: LatestCreated
      type: string
    - jsonPath: .status.latestReadyRevisionName
      name: LatestReady
      type: string
    - jsonPath: .status.conditions[?(@.type=='Ready')].status
      name: Ready
      type: string
    - jsonPath: .status.conditions[?(@.type=='Ready')].reason
      name: Reason
      type: string
    name: v1
    schema:
      openAPIV3Schema:
        description: 'Configuration represents the "floating HEAD" of a linear history
          of Revisions. Users create new Revisions by updating the Configuration''s
          spec. The "latest created" revision''s name is available under status, as
          is the "latest ready" revision''s name. See also: https://github.com/knative/serving/blob/main/docs/spec/overview.md#configuration'
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
            description: ConfigurationSpec holds the desired state of the Configuration
              (from the client).
            properties:
              template:
                description: Template holds the latest specification for the Revision
                  to be stamped out.
                properties:
                  metadata:
                    properties:
                      annotations:
                        additionalProperties:
                          type: string
                        type: object
                      finalizers:
                        items:
                          type: string
                        type: array
                      labels:
                        additionalProperties:
                          type: string
                        type: object
                      name:
                        type: string
                      namespace:
                        type: string
                    type: object
                    x-kubernetes-preserve-unknown-fields: true
                  spec:
                    description: RevisionSpec holds the desired state of the Revision
                      (from the client).
                    properties:
                      affinity:
                        description: This is accessible behind a feature flag - kubernetes.podspec-affinity
                        type: object
                        x-kubernetes-preserve-unknown-fields: true
                      automountServiceAccountToken:
                        description: AutomountServiceAccountToken indicates whether
                          a service account token should be automatically mounted.
                        type: boolean
                      containerConcurrency:
                        description: ContainerConcurrency specifies the maximum allowed
                          in-flight (concurrent) requests per container of the Revision.  Defaults
                          to `0` which means concurrency to the application is not
                          limited, and the system decides the target concurrency for
                          the autoscaler.
                        format: int64
                        type: integer
                      containers:
                        description: List of containers belonging to the pod. Containers
                          cannot currently be added or removed. There must be at least
                          one container in a Pod. Cannot be updated.
                        items:
                          description: A single application container that you want
                            to run within a pod.
                          properties:
                            args:
                              description: 'Arguments to the entrypoint. The container
                                image''s CMD is used if this is not provided. Variable
                                references $(VAR_NAME) are expanded using the container''s
                                environment. If a variable cannot be resolved, the
                                reference in the input string will be unchanged. Double
                                $$ are reduced to a single $, which allows for escaping
                                the $(VAR_NAME) syntax: i.e. "$$(VAR_NAME)" will produce
                                the string literal "$(VAR_NAME)". Escaped references
                                will never be expanded, regardless of whether the
                                variable exists or not. Cannot be updated. More info:
                                https://kubernetes.io/docs/tasks/inject-data-application/define-command-argument-container/#running-a-command-in-a-shell'
                              items:
                                type: string
                              type: array
                            command:
                              description: 'Entrypoint array. Not executed within
                                a shell. The container image''s ENTRYPOINT is used
                                if this is not provided. Variable references $(VAR_NAME)
                                are expanded using the container''s environment. If
                                a variable cannot be resolved, the reference in the
                                input string will be unchanged. Double $$ are reduced
                                to a single $, which allows for escaping the $(VAR_NAME)
                                syntax: i.e. "$$(VAR_NAME)" will produce the string
                                literal "$(VAR_NAME)". Escaped references will never
                                be expanded, regardless of whether the variable exists
                                or not. Cannot be updated. More info: https://kubernetes.io/docs/tasks/inject-data-application/define-command-argument-container/#running-a-command-in-a-shell'
                              items:
                                type: string
                              type: array
                            env:
                              description: List of environment variables to set in
                                the container. Cannot be updated.
                              items:
                                description: EnvVar represents an environment variable
                                  present in a Container.
                                properties:
                                  name:
                                    description: Name of the environment variable.
                                      Must be a C_IDENTIFIER.
                                    type: string
                                  value:
                                    description: 'Variable references $(VAR_NAME)
                                      are expanded using the previously defined environment
                                      variables in the container and any service environment
                                      variables. If a variable cannot be resolved,
                                      the reference in the input string will be unchanged.
                                      Double $$ are reduced to a single $, which allows
                                      for escaping the $(VAR_NAME) syntax: i.e. "$$(VAR_NAME)"
                                      will produce the string literal "$(VAR_NAME)".
                                      Escaped references will never be expanded, regardless
                                      of whether the variable exists or not. Defaults
                                      to "".'
                                    type: string
                                  valueFrom:
                                    description: Source for the environment variable's
                                      value. Cannot be used if value is not empty.
                                    properties:
                                      configMapKeyRef:
                                        description: Selects a key of a ConfigMap.
                                        properties:
                                          key:
                                            description: The key to select.
                                            type: string
                                          name:
                                            description: 'Name of the referent. More
                                              info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
                                              TODO: Add other useful fields. apiVersion,
                                              kind, uid?'
                                            type: string
                                          optional:
                                            description: Specify whether the ConfigMap
                                              or its key must be defined
                                            type: boolean
                                        required:
                                        - key
                                        type: object
                                        x-kubernetes-map-type: atomic
                                      fieldRef:
                                        description: This is accessible behind a feature
                                          flag - kubernetes.podspec-fieldref
                                        type: object
                                        x-kubernetes-map-type: atomic
                                        x-kubernetes-preserve-unknown-fields: true
                                      resourceFieldRef:
                                        description: This is accessible behind a feature
                                          flag - kubernetes.podspec-fieldref
                                        type: object
                                        x-kubernetes-map-type: atomic
                                        x-kubernetes-preserve-unknown-fields: true
                                      secretKeyRef:
                                        description: Selects a key of a secret in
                                          the pod's namespace
                                        properties:
                                          key:
                                            description: The key of the secret to
                                              select from.  Must be a valid secret
                                              key.
                                            type: string
                                          name:
                                            description: 'Name of the referent. More
                                              info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
                                              TODO: Add other useful fields. apiVersion,
                                              kind, uid?'
                                            type: string
                                          optional:
                                            description: Specify whether the Secret
                                              or its key must be defined
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
                              description: List of sources to populate environment
                                variables in the container. The keys defined within
                                a source must be a C_IDENTIFIER. All invalid keys
                                will be reported as an event when the container is
                                starting. When a key exists in multiple sources, the
                                value associated with the last source will take precedence.
                                Values defined by an Env with a duplicate key will
                                take precedence. Cannot be updated.
                              items:
                                description: EnvFromSource represents the source of
                                  a set of ConfigMaps
                                properties:
                                  configMapRef:
                                    description: The ConfigMap to select from
                                    properties:
                                      name:
                                        description: 'Name of the referent. More info:
                                          https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
                                          TODO: Add other useful fields. apiVersion,
                                          kind, uid?'
                                        type: string
                                      optional:
                                        description: Specify whether the ConfigMap
                                          must be defined
                                        type: boolean
                                    type: object
                                    x-kubernetes-map-type: atomic
                                  prefix:
                                    description: An optional identifier to prepend
                                      to each key in the ConfigMap. Must be a C_IDENTIFIER.
                                    type: string
                                  secretRef:
                                    description: The Secret to select from
                                    properties:
                                      name:
                                        description: 'Name of the referent. More info:
                                          https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
                                          TODO: Add other useful fields. apiVersion,
                                          kind, uid?'
                                        type: string
                                      optional:
                                        description: Specify whether the Secret must
                                          be defined
                                        type: boolean
                                    type: object
                                    x-kubernetes-map-type: atomic
                                type: object
                              type: array
                            image:
                              description: 'Container image name. More info: https://kubernetes.io/docs/concepts/containers/images
                                This field is optional to allow higher level config
                                management to default or override container images
                                in workload controllers like Deployments and StatefulSets.'
                              type: string
                            imagePullPolicy:
                              description: 'Image pull policy. One of Always, Never,
                                IfNotPresent. Defaults to Always if :latest tag is
                                specified, or IfNotPresent otherwise. Cannot be updated.
                                More info: https://kubernetes.io/docs/concepts/containers/images#updating-images'
                              type: string
                            livenessProbe:
                              description: 'Periodic probe of container liveness.
                                Container will be restarted if the probe fails. Cannot
                                be updated. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes'
                              properties:
                                exec:
                                  description: Exec specifies the action to take.
                                  properties:
                                    command:
                                      description: Command is the command line to
                                        execute inside the container, the working
                                        directory for the command  is root ('/') in
                                        the container's filesystem. The command is
                                        simply exec'd, it is not run inside a shell,
                                        so traditional shell instructions ('|', etc)
                                        won't work. To use a shell, you need to explicitly
                                        call out to that shell. Exit status of 0 is
                                        treated as live/healthy and non-zero is unhealthy.
                                      items:
                                        type: string
                                      type: array
                                  type: object
                                failureThreshold:
                                  description: Minimum consecutive failures for the
                                    probe to be considered failed after having succeeded.
                                    Defaults to 3. Minimum value is 1.
                                  format: int32
                                  type: integer
                                httpGet:
                                  description: HTTPGet specifies the http request
                                    to perform.
                                  properties:
                                    host:
                                      description: Host name to connect to, defaults
                                        to the pod IP. You probably want to set "Host"
                                        in httpHeaders instead.
                                      type: string
                                    httpHeaders:
                                      description: Custom headers to set in the request.
                                        HTTP allows repeated headers.
                                      items:
                                        description: HTTPHeader describes a custom
                                          header to be used in HTTP probes
                                        properties:
                                          name:
                                            description: The header field name
                                            type: string
                                          value:
                                            description: The header field value
                                            type: string
                                        required:
                                        - name
                                        - value
                                        type: object
                                      type: array
                                    path:
                                      description: Path to access on the HTTP server.
                                      type: string
                                    port:
                                      anyOf:
                                      - type: integer
                                      - type: string
                                      description: Name or number of the port to access
                                        on the container. Number must be in the range
                                        1 to 65535. Name must be an IANA_SVC_NAME.
                                      x-kubernetes-int-or-string: true
                                    scheme:
                                      description: Scheme to use for connecting to
                                        the host. Defaults to HTTP.
                                      type: string
                                  type: object
                                initialDelaySeconds:
                                  description: 'Number of seconds after the container
                                    has started before liveness probes are initiated.
                                    More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes'
                                  format: int32
                                  type: integer
                                periodSeconds:
                                  description: How often (in seconds) to perform the
                                    probe.
                                  format: int32
                                  type: integer
                                successThreshold:
                                  description: Minimum consecutive successes for the
                                    probe to be considered successful after having
                                    failed. Defaults to 1. Must be 1 for liveness
                                    and startup. Minimum value is 1.
                                  format: int32
                                  type: integer
                                tcpSocket:
                                  description: TCPSocket specifies an action involving
                                    a TCP port.
                                  properties:
                                    host:
                                      description: 'Optional: Host name to connect
                                        to, defaults to the pod IP.'
                                      type: string
                                    port:
                                      anyOf:
                                      - type: integer
                                      - type: string
                                      description: Number or name of the port to access
                                        on the container. Number must be in the range
                                        1 to 65535. Name must be an IANA_SVC_NAME.
                                      x-kubernetes-int-or-string: true
                                  type: object
                                timeoutSeconds:
                                  description: 'Number of seconds after which the
                                    probe times out. Defaults to 1 second. Minimum
                                    value is 1. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes'
                                  format: int32
                                  type: integer
                              type: object
                            name:
                              description: Name of the container specified as a DNS_LABEL.
                                Each container in a pod must have a unique name (DNS_LABEL).
                                Cannot be updated.
                              type: string
                            ports:
                              description: List of ports to expose from the container.
                                Not specifying a port here DOES NOT prevent that port
                                from being exposed. Any port which is listening on
                                the default "0.0.0.0" address inside a container will
                                be accessible from the network. Modifying this array
                                with strategic merge patch may corrupt the data. For
                                more information See https://github.com/kubernetes/kubernetes/issues/108255.
                                Cannot be updated.
                              items:
                                description: ContainerPort represents a network port
                                  in a single container.
                                properties:
                                  containerPort:
                                    description: Number of port to expose on the pod's
                                      IP address. This must be a valid port number,
                                      0 < x < 65536.
                                    format: int32
                                    type: integer
                                  name:
                                    description: If specified, this must be an IANA_SVC_NAME
                                      and unique within the pod. Each named port in
                                      a pod must have a unique name. Name for the
                                      port that can be referred to by services.
                                    type: string
                                  protocol:
                                    default: TCP
                                    description: Protocol for port. Must be UDP, TCP,
                                      or SCTP. Defaults to "TCP".
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
                              description: 'Periodic probe of container service readiness.
                                Container will be removed from service endpoints if
                                the probe fails. Cannot be updated. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes'
                              properties:
                                exec:
                                  description: Exec specifies the action to take.
                                  properties:
                                    command:
                                      description: Command is the command line to
                                        execute inside the container, the working
                                        directory for the command  is root ('/') in
                                        the container's filesystem. The command is
                                        simply exec'd, it is not run inside a shell,
                                        so traditional shell instructions ('|', etc)
                                        won't work. To use a shell, you need to explicitly
                                        call out to that shell. Exit status of 0 is
                                        treated as live/healthy and non-zero is unhealthy.
                                      items:
                                        type: string
                                      type: array
                                  type: object
                                failureThreshold:
                                  description: Minimum consecutive failures for the
                                    probe to be considered failed after having succeeded.
                                    Defaults to 3. Minimum value is 1.
                                  format: int32
                                  type: integer
                                httpGet:
                                  description: HTTPGet specifies the http request
                                    to perform.
                                  properties:
                                    host:
                                      description: Host name to connect to, defaults
                                        to the pod IP. You probably want to set "Host"
                                        in httpHeaders instead.
                                      type: string
                                    httpHeaders:
                                      description: Custom headers to set in the request.
                                        HTTP allows repeated headers.
                                      items:
                                        description: HTTPHeader describes a custom
                                          header to be used in HTTP probes
                                        properties:
                                          name:
                                            description: The header field name
                                            type: string
                                          value:
                                            description: The header field value
                                            type: string
                                        required:
                                        - name
                                        - value
                                        type: object
                                      type: array
                                    path:
                                      description: Path to access on the HTTP server.
                                      type: string
                                    port:
                                      anyOf:
                                      - type: integer
                                      - type: string
                                      description: Name or number of the port to access
                                        on the container. Number must be in the range
                                        1 to 65535. Name must be an IANA_SVC_NAME.
                                      x-kubernetes-int-or-string: true
                                    scheme:
                                      description: Scheme to use for connecting to
                                        the host. Defaults to HTTP.
                                      type: string
                                  type: object
                                initialDelaySeconds:
                                  description: 'Number of seconds after the container
                                    has started before liveness probes are initiated.
                                    More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes'
                                  format: int32
                                  type: integer
                                periodSeconds:
                                  description: How often (in seconds) to perform the
                                    probe.
                                  format: int32
                                  type: integer
                                successThreshold:
                                  description: Minimum consecutive successes for the
                                    probe to be considered successful after having
                                    failed. Defaults to 1. Must be 1 for liveness
                                    and startup. Minimum value is 1.
                                  format: int32
                                  type: integer
                                tcpSocket:
                                  description: TCPSocket specifies an action involving
                                    a TCP port.
                                  properties:
                                    host:
                                      description: 'Optional: Host name to connect
                                        to, defaults to the pod IP.'
                                      type: string
                                    port:
                                      anyOf:
                                      - type: integer
                                      - type: string
                                      description: Number or name of the port to access
                                        on the container. Number must be in the range
                                        1 to 65535. Name must be an IANA_SVC_NAME.
                                      x-kubernetes-int-or-string: true
                                  type: object
                                timeoutSeconds:
                                  description: 'Number of seconds after which the
                                    probe times out. Defaults to 1 second. Minimum
                                    value is 1. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes'
                                  format: int32
                                  type: integer
                              type: object
                            resources:
                              description: 'Compute Resources required by this container.
                                Cannot be updated. More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/'
                              properties:
                                limits:
                                  additionalProperties:
                                    anyOf:
                                    - type: integer
                                    - type: string
                                    pattern: ^(\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))))?$
                                    x-kubernetes-int-or-string: true
                                  description: 'Limits describes the maximum amount
                                    of compute resources allowed. More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/'
                                  type: object
                                requests:
                                  additionalProperties:
                                    anyOf:
                                    - type: integer
                                    - type: string
                                    pattern: ^(\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))))?$
                                    x-kubernetes-int-or-string: true
                                  description: 'Requests describes the minimum amount
                                    of compute resources required. If Requests is
                                    omitted for a container, it defaults to Limits
                                    if that is explicitly specified, otherwise to
                                    an implementation-defined value. More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/'
                                  type: object
                              type: object
                            securityContext:
                              description: 'SecurityContext defines the security options
                                the container should be run with. If set, the fields
                                of SecurityContext override the equivalent fields
                                of PodSecurityContext. More info: https://kubernetes.io/docs/tasks/configure-pod-container/security-context/'
                              properties:
                                allowPrivilegeEscalation:
                                  description: 'AllowPrivilegeEscalation controls
                                    whether a process can gain more privileges than
                                    its parent process. This bool directly controls
                                    if the no_new_privs flag will be set on the container
                                    process. AllowPrivilegeEscalation is true always
                                    when the container is: 1) run as Privileged 2)
                                    has CAP_SYS_ADMIN Note that this field cannot
                                    be set when spec.os.name is windows.'
                                  type: boolean
                                capabilities:
                                  description: The capabilities to add/drop when running
                                    containers. Defaults to the default set of capabilities
                                    granted by the container runtime. Note that this
                                    field cannot be set when spec.os.name is windows.
                                  properties:
                                    add:
                                      description: This is accessible behind a feature
                                        flag - kubernetes.containerspec-addcapabilities
                                      items:
                                        description: Capability represent POSIX capabilities
                                          type
                                        type: string
                                      type: array
                                    drop:
                                      description: Removed capabilities
                                      items:
                                        description: Capability represent POSIX capabilities
                                          type
                                        type: string
                                      type: array
                                  type: object
                                readOnlyRootFilesystem:
                                  description: Whether this container has a read-only
                                    root filesystem. Default is false. Note that this
                                    field cannot be set when spec.os.name is windows.
                                  type: boolean
                                runAsGroup:
                                  description: The GID to run the entrypoint of the
                                    container process. Uses runtime default if unset.
                                    May also be set in PodSecurityContext.  If set
                                    in both SecurityContext and PodSecurityContext,
                                    the value specified in SecurityContext takes precedence.
                                    Note that this field cannot be set when spec.os.name
                                    is windows.
                                  format: int64
                                  type: integer
                                runAsNonRoot:
                                  description: Indicates that the container must run
                                    as a non-root user. If true, the Kubelet will
                                    validate the image at runtime to ensure that it
                                    does not run as UID 0 (root) and fail to start
                                    the container if it does. If unset or false, no
                                    such validation will be performed. May also be
                                    set in PodSecurityContext.  If set in both SecurityContext
                                    and PodSecurityContext, the value specified in
                                    SecurityContext takes precedence.
                                  type: boolean
                                runAsUser:
                                  description: The UID to run the entrypoint of the
                                    container process. Defaults to user specified
                                    in image metadata if unspecified. May also be
                                    set in PodSecurityContext.  If set in both SecurityContext
                                    and PodSecurityContext, the value specified in
                                    SecurityContext takes precedence. Note that this
                                    field cannot be set when spec.os.name is windows.
                                  format: int64
                                  type: integer
                              type: object
                            terminationMessagePath:
                              description: 'Optional: Path at which the file to which
                                the container''s termination message will be written
                                is mounted into the container''s filesystem. Message
                                written is intended to be brief final status, such
                                as an assertion failure message. Will be truncated
                                by the node if greater than 4096 bytes. The total
                                message length across all containers will be limited
                                to 12kb. Defaults to /dev/termination-log. Cannot
                                be updated.'
                              type: string
                            terminationMessagePolicy:
                              description: Indicate how the termination message should
                                be populated. File will use the contents of terminationMessagePath
                                to populate the container status message on both success
                                and failure. FallbackToLogsOnError will use the last
                                chunk of container log output if the termination message
                                file is empty and the container exited with an error.
                                The log output is limited to 2048 bytes or 80 lines,
                                whichever is smaller. Defaults to File. Cannot be
                                updated.
                              type: string
                            volumeMounts:
                              description: Pod volumes to mount into the container's
                                filesystem. Cannot be updated.
                              items:
                                description: VolumeMount describes a mounting of a
                                  Volume within a container.
                                properties:
                                  mountPath:
                                    description: Path within the container at which
                                      the volume should be mounted.  Must not contain
                                      ':'.
                                    type: string
                                  name:
                                    description: This must match the Name of a Volume.
                                    type: string
                                  readOnly:
                                    description: Mounted read-only if true, read-write
                                      otherwise (false or unspecified). Defaults to
                                      false.
                                    type: boolean
                                  subPath:
                                    description: Path within the volume from which
                                      the container's volume should be mounted. Defaults
                                      to "" (volume's root).
                                    type: string
                                required:
                                - mountPath
                                - name
                                type: object
                              type: array
                            workingDir:
                              description: Container's working directory. If not specified,
                                the container runtime's default will be used, which
                                might be configured in the container image. Cannot
                                be updated.
                              type: string
                          type: object
                        type: array
                      dnsConfig:
                        description: This is accessible behind a feature flag - kubernetes.podspec-dnsconfig
                        type: object
                        x-kubernetes-preserve-unknown-fields: true
                      dnsPolicy:
                        description: This is accessible behind a feature flag - kubernetes.podspec-dnspolicy
                        type: string
                      enableServiceLinks:
                        description: 'EnableServiceLinks indicates whether information
                          about services should be injected into pod''s environment
                          variables, matching the syntax of Docker links. Optional:
                          Knative defaults this to false.'
                        type: boolean
                      hostAliases:
                        description: This is accessible behind a feature flag - kubernetes.podspec-hostaliases
                        items:
                          description: This is accessible behind a feature flag -
                            kubernetes.podspec-hostaliases
                          type: object
                          x-kubernetes-preserve-unknown-fields: true
                        type: array
                      idleTimeoutSeconds:
                        description: IdleTimeoutSeconds is the maximum duration in
                          seconds a request will be allowed to stay open while not
                          receiving any bytes from the user's application. If unspecified,
                          a system default will be provided.
                        format: int64
                        type: integer
                      imagePullSecrets:
                        description: 'ImagePullSecrets is an optional list of references
                          to secrets in the same namespace to use for pulling any
                          of the images used by this PodSpec. If specified, these
                          secrets will be passed to individual puller implementations
                          for them to use. More info: https://kubernetes.io/docs/concepts/containers/images#specifying-imagepullsecrets-on-a-pod'
                        items:
                          description: LocalObjectReference contains enough information
                            to let you locate the referenced object inside the same
                            namespace.
                          properties:
                            name:
                              description: 'Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
                                TODO: Add other useful fields. apiVersion, kind, uid?'
                              type: string
                          type: object
                          x-kubernetes-map-type: atomic
                        type: array
                      initContainers:
                        description: 'List of initialization containers belonging
                          to the pod. Init containers are executed in order prior
                          to containers being started. If any init container fails,
                          the pod is considered to have failed and is handled according
                          to its restartPolicy. The name for an init container or
                          normal container must be unique among all containers. Init
                          containers may not have Lifecycle actions, Readiness probes,
                          Liveness probes, or Startup probes. The resourceRequirements
                          of an init container are taken into account during scheduling
                          by finding the highest request/limit for each resource type,
                          and then using the max of of that value or the sum of the
                          normal containers. Limits are applied to init containers
                          in a similar fashion. Init containers cannot currently be
                          added or removed. Cannot be updated. More info: https://kubernetes.io/docs/concepts/workloads/pods/init-containers/'
                        items:
                          description: This is accessible behind a feature flag -
                            kubernetes.podspec-init-containers
                          type: object
                          x-kubernetes-preserve-unknown-fields: true
                        type: array
                      nodeSelector:
                        description: This is accessible behind a feature flag - kubernetes.podspec-nodeselector
                        type: object
                        x-kubernetes-map-type: atomic
                        x-kubernetes-preserve-unknown-fields: true
                      priorityClassName:
                        description: This is accessible behind a feature flag - kubernetes.podspec-priorityclassname
                        type: string
                        x-kubernetes-preserve-unknown-fields: true
                      responseStartTimeoutSeconds:
                        description: ResponseStartTimeoutSeconds is the maximum duration
                          in seconds that the request routing layer will wait for
                          a request delivered to a container to begin sending any
                          network traffic.
                        format: int64
                        type: integer
                      runtimeClassName:
                        description: This is accessible behind a feature flag - kubernetes.podspec-runtimeclassname
                        type: string
                        x-kubernetes-preserve-unknown-fields: true
                      schedulerName:
                        description: This is accessible behind a feature flag - kubernetes.podspec-schedulername
                        type: string
                        x-kubernetes-preserve-unknown-fields: true
                      securityContext:
                        description: This is accessible behind a feature flag - kubernetes.podspec-securitycontext
                        type: object
                        x-kubernetes-preserve-unknown-fields: true
                      serviceAccountName:
                        description: 'ServiceAccountName is the name of the ServiceAccount
                          to use to run this pod. More info: https://kubernetes.io/docs/tasks/configure-pod-container/configure-service-account/'
                        type: string
                      timeoutSeconds:
                        description: TimeoutSeconds is the maximum duration in seconds
                          that the request instance is allowed to respond to a request.
                          If unspecified, a system default will be provided.
                        format: int64
                        type: integer
                      tolerations:
                        description: This is accessible behind a feature flag - kubernetes.podspec-tolerations
                        items:
                          description: This is accessible behind a feature flag -
                            kubernetes.podspec-tolerations
                          type: object
                          x-kubernetes-preserve-unknown-fields: true
                        type: array
                      topologySpreadConstraints:
                        description: This is accessible behind a feature flag - kubernetes.podspec-topologyspreadconstraints
                        items:
                          description: This is accessible behind a feature flag -
                            kubernetes.podspec-topologyspreadconstraints
                          type: object
                          x-kubernetes-preserve-unknown-fields: true
                        type: array
                      volumes:
                        description: 'List of volumes that can be mounted by containers
                          belonging to the pod. More info: https://kubernetes.io/docs/concepts/storage/volumes'
                        items:
                          description: Volume represents a named volume in a pod that
                            may be accessed by any container in the pod.
                          properties:
                            configMap:
                              description: configMap represents a configMap that should
                                populate this volume
                              properties:
                                defaultMode:
                                  description: 'defaultMode is optional: mode bits
                                    used to set permissions on created files by default.
                                    Must be an octal value between 0000 and 0777 or
                                    a decimal value between 0 and 511. YAML accepts
                                    both octal and decimal values, JSON requires decimal
                                    values for mode bits. Defaults to 0644. Directories
                                    within the path are not affected by this setting.
                                    This might be in conflict with other options that
                                    affect the file mode, like fsGroup, and the result
                                    can be other mode bits set.'
                                  format: int32
                                  type: integer
                                items:
                                  description: items if unspecified, each key-value
                                    pair in the Data field of the referenced ConfigMap
                                    will be projected into the volume as a file whose
                                    name is the key and content is the value. If specified,
                                    the listed keys will be projected into the specified
                                    paths, and unlisted keys will not be present.
                                    If a key is specified which is not present in
                                    the ConfigMap, the volume setup will error unless
                                    it is marked optional. Paths must be relative
                                    and may not contain the '..' path or start with
                                    '..'.
                                  items:
                                    description: Maps a string key to a path within
                                      a volume.
                                    properties:
                                      key:
                                        description: key is the key to project.
                                        type: string
                                      mode:
                                        description: 'mode is Optional: mode bits
                                          used to set permissions on this file. Must
                                          be an octal value between 0000 and 0777
                                          or a decimal value between 0 and 511. YAML
                                          accepts both octal and decimal values, JSON
                                          requires decimal values for mode bits. If
                                          not specified, the volume defaultMode will
                                          be used. This might be in conflict with
                                          other options that affect the file mode,
                                          like fsGroup, and the result can be other
                                          mode bits set.'
                                        format: int32
                                        type: integer
                                      path:
                                        description: path is the relative path of
                                          the file to map the key to. May not be an
                                          absolute path. May not contain the path
                                          element '..'. May not start with the string
                                          '..'.
                                        type: string
                                    required:
                                    - key
                                    - path
                                    type: object
                                  type: array
                                name:
                                  description: 'Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
                                    TODO: Add other useful fields. apiVersion, kind,
                                    uid?'
                                  type: string
                                optional:
                                  description: optional specify whether the ConfigMap
                                    or its keys must be defined
                                  type: boolean
                              type: object
                              x-kubernetes-map-type: atomic
                            emptyDir:
                              description: This is accessible behind a feature flag
                                - kubernetes.podspec-emptydir
                              type: object
                              x-kubernetes-preserve-unknown-fields: true
                            name:
                              description: 'name of the volume. Must be a DNS_LABEL
                                and unique within the pod. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names'
                              type: string
                            persistentVolumeClaim:
                              description: This is accessible behind a feature flag
                                - kubernetes.podspec-persistent-volume-claim
                              type: object
                              x-kubernetes-preserve-unknown-fields: true
                            projected:
                              description: projected items for all in one resources
                                secrets, configmaps, and downward API
                              properties:
                                defaultMode:
                                  description: defaultMode are the mode bits used
                                    to set permissions on created files by default.
                                    Must be an octal value between 0000 and 0777 or
                                    a decimal value between 0 and 511. YAML accepts
                                    both octal and decimal values, JSON requires decimal
                                    values for mode bits. Directories within the path
                                    are not affected by this setting. This might be
                                    in conflict with other options that affect the
                                    file mode, like fsGroup, and the result can be
                                    other mode bits set.
                                  format: int32
                                  type: integer
                                sources:
                                  description: sources is the list of volume projections
                                  items:
                                    description: Projection that may be projected
                                      along with other supported volume types
                                    properties:
                                      configMap:
                                        description: configMap information about the
                                          configMap data to project
                                        properties:
                                          items:
                                            description: items if unspecified, each
                                              key-value pair in the Data field of
                                              the referenced ConfigMap will be projected
                                              into the volume as a file whose name
                                              is the key and content is the value.
                                              If specified, the listed keys will be
                                              projected into the specified paths,
                                              and unlisted keys will not be present.
                                              If a key is specified which is not present
                                              in the ConfigMap, the volume setup will
                                              error unless it is marked optional.
                                              Paths must be relative and may not contain
                                              the '..' path or start with '..'.
                                            items:
                                              description: Maps a string key to a
                                                path within a volume.
                                              properties:
                                                key:
                                                  description: key is the key to project.
                                                  type: string
                                                mode:
                                                  description: 'mode is Optional:
                                                    mode bits used to set permissions
                                                    on this file. Must be an octal
                                                    value between 0000 and 0777 or
                                                    a decimal value between 0 and
                                                    511. YAML accepts both octal and
                                                    decimal values, JSON requires
                                                    decimal values for mode bits.
                                                    If not specified, the volume defaultMode
                                                    will be used. This might be in
                                                    conflict with other options that
                                                    affect the file mode, like fsGroup,
                                                    and the result can be other mode
                                                    bits set.'
                                                  format: int32
                                                  type: integer
                                                path:
                                                  description: path is the relative
                                                    path of the file to map the key
                                                    to. May not be an absolute path.
                                                    May not contain the path element
                                                    '..'. May not start with the string
                                                    '..'.
                                                  type: string
                                              required:
                                              - key
                                              - path
                                              type: object
                                            type: array
                                          name:
                                            description: 'Name of the referent. More
                                              info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
                                              TODO: Add other useful fields. apiVersion,
                                              kind, uid?'
                                            type: string
                                          optional:
                                            description: optional specify whether
                                              the ConfigMap or its keys must be defined
                                            type: boolean
                                        type: object
                                        x-kubernetes-map-type: atomic
                                      secret:
                                        description: secret information about the
                                          secret data to project
                                        properties:
                                          items:
                                            description: items if unspecified, each
                                              key-value pair in the Data field of
                                              the referenced Secret will be projected
                                              into the volume as a file whose name
                                              is the key and content is the value.
                                              If specified, the listed keys will be
                                              projected into the specified paths,
                                              and unlisted keys will not be present.
                                              If a key is specified which is not present
                                              in the Secret, the volume setup will
                                              error unless it is marked optional.
                                              Paths must be relative and may not contain
                                              the '..' path or start with '..'.
                                            items:
                                              description: Maps a string key to a
                                                path within a volume.
                                              properties:
                                                key:
                                                  description: key is the key to project.
                                                  type: string
                                                mode:
                                                  description: 'mode is Optional:
                                                    mode bits used to set permissions
                                                    on this file. Must be an octal
                                                    value between 0000 and 0777 or
                                                    a decimal value between 0 and
                                                    511. YAML accepts both octal and
                                                    decimal values, JSON requires
                                                    decimal values for mode bits.
                                                    If not specified, the volume defaultMode
                                                    will be used. This might be in
                                                    conflict with other options that
                                                    affect the file mode, like fsGroup,
                                                    and the result can be other mode
                                                    bits set.'
                                                  format: int32
                                                  type: integer
                                                path:
                                                  description: path is the relative
                                                    path of the file to map the key
                                                    to. May not be an absolute path.
                                                    May not contain the path element
                                                    '..'. May not start with the string
                                                    '..'.
                                                  type: string
                                              required:
                                              - key
                                              - path
                                              type: object
                                            type: array
                                          name:
                                            description: 'Name of the referent. More
                                              info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
                                              TODO: Add other useful fields. apiVersion,
                                              kind, uid?'
                                            type: string
                                          optional:
                                            description: optional field specify whether
                                              the Secret or its key must be defined
                                            type: boolean
                                        type: object
                                        x-kubernetes-map-type: atomic
                                      serviceAccountToken:
                                        description: serviceAccountToken is information
                                          about the serviceAccountToken data to project
                                        properties:
                                          audience:
                                            description: audience is the intended
                                              audience of the token. A recipient of
                                              a token must identify itself with an
                                              identifier specified in the audience
                                              of the token, and otherwise should reject
                                              the token. The audience defaults to
                                              the identifier of the apiserver.
                                            type: string
                                          expirationSeconds:
                                            description: expirationSeconds is the
                                              requested duration of validity of the
                                              service account token. As the token
                                              approaches expiration, the kubelet volume
                                              plugin will proactively rotate the service
                                              account token. The kubelet will start
                                              trying to rotate the token if the token
                                              is older than 80 percent of its time
                                              to live or if the token is older than
                                              24 hours.Defaults to 1 hour and must
                                              be at least 10 minutes.
                                            format: int64
                                            type: integer
                                          path:
                                            description: path is the path relative
                                              to the mount point of the file to project
                                              the token into.
                                            type: string
                                        required:
                                        - path
                                        type: object
                                    type: object
                                  type: array
                              type: object
                            secret:
                              description: 'secret represents a secret that should
                                populate this volume. More info: https://kubernetes.io/docs/concepts/storage/volumes#secret'
                              properties:
                                defaultMode:
                                  description: 'defaultMode is Optional: mode bits
                                    used to set permissions on created files by default.
                                    Must be an octal value between 0000 and 0777 or
                                    a decimal value between 0 and 511. YAML accepts
                                    both octal and decimal values, JSON requires decimal
                                    values for mode bits. Defaults to 0644. Directories
                                    within the path are not affected by this setting.
                                    This might be in conflict with other options that
                                    affect the file mode, like fsGroup, and the result
                                    can be other mode bits set.'
                                  format: int32
                                  type: integer
                                items:
                                  description: items If unspecified, each key-value
                                    pair in the Data field of the referenced Secret
                                    will be projected into the volume as a file whose
                                    name is the key and content is the value. If specified,
                                    the listed keys will be projected into the specified
                                    paths, and unlisted keys will not be present.
                                    If a key is specified which is not present in
                                    the Secret, the volume setup will error unless
                                    it is marked optional. Paths must be relative
                                    and may not contain the '..' path or start with
                                    '..'.
                                  items:
                                    description: Maps a string key to a path within
                                      a volume.
                                    properties:
                                      key:
                                        description: key is the key to project.
                                        type: string
                                      mode:
                                        description: 'mode is Optional: mode bits
                                          used to set permissions on this file. Must
                                          be an octal value between 0000 and 0777
                                          or a decimal value between 0 and 511. YAML
                                          accepts both octal and decimal values, JSON
                                          requires decimal values for mode bits. If
                                          not specified, the volume defaultMode will
                                          be used. This might be in conflict with
                                          other options that affect the file mode,
                                          like fsGroup, and the result can be other
                                          mode bits set.'
                                        format: int32
                                        type: integer
                                      path:
                                        description: path is the relative path of
                                          the file to map the key to. May not be an
                                          absolute path. May not contain the path
                                          element '..'. May not start with the string
                                          '..'.
                                        type: string
                                    required:
                                    - key
                                    - path
                                    type: object
                                  type: array
                                optional:
                                  description: optional field specify whether the
                                    Secret or its keys must be defined
                                  type: boolean
                                secretName:
                                  description: 'secretName is the name of the secret
                                    in the pod''s namespace to use. More info: https://kubernetes.io/docs/concepts/storage/volumes#secret'
                                  type: string
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
            description: ConfigurationStatus communicates the observed state of the
              Configuration (from the controller).
            properties:
              annotations:
                additionalProperties:
                  type: string
                description: Annotations is additional Status fields for the Resource
                  to save some additional State as well as convey more information
                  to the user. This is roughly akin to Annotations on any k8s resource,
                  just the reconciler conveying richer information outwards.
                type: object
              conditions:
                description: Conditions the latest available observations of a resource's
                  current state.
                items:
                  description: 'Condition defines a readiness condition for a Knative
                    resource. See: https://github.com/kubernetes/community/blob/master/contributors/devel/sig-architecture/api-conventions.md#typical-status-properties'
                  properties:
                    lastTransitionTime:
                      description: LastTransitionTime is the last time the condition
                        transitioned from one status to another. We use VolatileTime
                        in place of metav1.Time to exclude this from creating equality.Semantic
                        differences (all other things held constant).
                      type: string
                    message:
                      description: A human readable message indicating details about
                        the transition.
                      type: string
                    reason:
                      description: The reason for the condition's last transition.
                      type: string
                    severity:
                      description: Severity with which to treat failures of this type
                        of condition. When this is not specified, it defaults to Error.
                      type: string
                    status:
                      description: Status of the condition, one of True, False, Unknown.
                      type: string
                    type:
                      description: Type of condition.
                      type: string
                  required:
                  - status
                  - type
                  type: object
                type: array
              latestCreatedRevisionName:
                description: LatestCreatedRevisionName is the last revision that was
                  created from this Configuration. It might not be ready yet, for
                  that use LatestReadyRevisionName.
                type: string
              latestReadyRevisionName:
                description: LatestReadyRevisionName holds the name of the latest
                  Revision stamped out from this Configuration that has had its "Ready"
                  condition become "True".
                type: string
              observedGeneration:
                description: ObservedGeneration is the 'Generation' of the Service
                  that was last processed by the controller.
                format: int64
                type: integer
            type: object
        type: object
    served: true
    storage: true
    subresources:
      status: {}
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool]
}

resource "kubectl_manifest" "kubeflow-knative-customresourcedefinition-domainmappings" {
  yaml_body = <<YAML
apiVersion: apiextensions.k8s.io/v1
kind: CustomResourceDefinition
metadata:
  labels:
    app.kubernetes.io/name: knative-serving
    app.kubernetes.io/version: 1.8.0
    knative.dev/crd-install: "true"
  name: domainmappings.serving.knative.dev
spec:
  group: serving.knative.dev
  names:
    categories:
    - all
    - knative
    - serving
    kind: DomainMapping
    plural: domainmappings
    shortNames:
    - dm
    singular: domainmapping
  scope: Namespaced
  versions:
  - additionalPrinterColumns:
    - jsonPath: .status.url
      name: URL
      type: string
    - jsonPath: .status.conditions[?(@.type=='Ready')].status
      name: Ready
      type: string
    - jsonPath: .status.conditions[?(@.type=='Ready')].reason
      name: Reason
      type: string
    name: v1beta1
    schema:
      openAPIV3Schema:
        description: DomainMapping is a mapping from a custom hostname to an Addressable.
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
            description: 'Spec is the desired state of the DomainMapping. More info:
              https://github.com/kubernetes/community/blob/master/contributors/devel/sig-architecture/api-conventions.md#spec-and-status'
            properties:
              ref:
                description: "Ref specifies the target of the Domain Mapping. \n The
                  object identified by the Ref must be an Addressable with a URL of
                  the form `{name}.{namespace}.{domain}` where `{domain}` is the cluster
                  domain, and `{name}` and `{namespace}` are the name and namespace
                  of a Kubernetes Service. \n This contract is satisfied by Knative
                  types such as Knative Services and Knative Routes, and by Kubernetes
                  Services."
                properties:
                  apiVersion:
                    description: API version of the referent.
                    type: string
                  group:
                    description: 'Group of the API, without the version of the group.
                      This can be used as an alternative to the APIVersion, and then
                      resolved using ResolveGroup. Note: This API is EXPERIMENTAL
                      and might break anytime. For more details: https://github.com/knative/eventing/issues/5086'
                    type: string
                  kind:
                    description: 'Kind of the referent. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds'
                    type: string
                  name:
                    description: 'Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names'
                    type: string
                  namespace:
                    description: 'Namespace of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/
                      This is optional field, it gets defaulted to the object holding
                      it if left out.'
                    type: string
                required:
                - kind
                - name
                type: object
              tls:
                description: TLS allows the DomainMapping to terminate TLS traffic
                  with an existing secret.
                properties:
                  secretName:
                    description: SecretName is the name of the existing secret used
                      to terminate TLS traffic.
                    type: string
                required:
                - secretName
                type: object
            required:
            - ref
            type: object
          status:
            description: 'Status is the current state of the DomainMapping. More info:
              https://github.com/kubernetes/community/blob/master/contributors/devel/sig-architecture/api-conventions.md#spec-and-status'
            properties:
              address:
                description: Address holds the information needed for a DomainMapping
                  to be the target of an event.
                properties:
                  url:
                    type: string
                type: object
              annotations:
                additionalProperties:
                  type: string
                description: Annotations is additional Status fields for the Resource
                  to save some additional State as well as convey more information
                  to the user. This is roughly akin to Annotations on any k8s resource,
                  just the reconciler conveying richer information outwards.
                type: object
              conditions:
                description: Conditions the latest available observations of a resource's
                  current state.
                items:
                  description: 'Condition defines a readiness condition for a Knative
                    resource. See: https://github.com/kubernetes/community/blob/master/contributors/devel/sig-architecture/api-conventions.md#typical-status-properties'
                  properties:
                    lastTransitionTime:
                      description: LastTransitionTime is the last time the condition
                        transitioned from one status to another. We use VolatileTime
                        in place of metav1.Time to exclude this from creating equality.Semantic
                        differences (all other things held constant).
                      type: string
                    message:
                      description: A human readable message indicating details about
                        the transition.
                      type: string
                    reason:
                      description: The reason for the condition's last transition.
                      type: string
                    severity:
                      description: Severity with which to treat failures of this type
                        of condition. When this is not specified, it defaults to Error.
                      type: string
                    status:
                      description: Status of the condition, one of True, False, Unknown.
                      type: string
                    type:
                      description: Type of condition.
                      type: string
                  required:
                  - status
                  - type
                  type: object
                type: array
              observedGeneration:
                description: ObservedGeneration is the 'Generation' of the Service
                  that was last processed by the controller.
                format: int64
                type: integer
              url:
                description: URL is the URL of this DomainMapping.
                type: string
            type: object
        type: object
    served: true
    storage: false
    subresources:
      status: {}
  - additionalPrinterColumns:
    - jsonPath: .status.url
      name: URL
      type: string
    - jsonPath: .status.conditions[?(@.type=='Ready')].status
      name: Ready
      type: string
    - jsonPath: .status.conditions[?(@.type=='Ready')].reason
      name: Reason
      type: string
    name: v1alpha1
    schema:
      openAPIV3Schema:
        description: DomainMapping is a mapping from a custom hostname to an Addressable.
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
            description: 'Spec is the desired state of the DomainMapping. More info:
              https://github.com/kubernetes/community/blob/master/contributors/devel/sig-architecture/api-conventions.md#spec-and-status'
            properties:
              ref:
                description: "Ref specifies the target of the Domain Mapping. \n The
                  object identified by the Ref must be an Addressable with a URL of
                  the form `{name}.{namespace}.{domain}` where `{domain}` is the cluster
                  domain, and `{name}` and `{namespace}` are the name and namespace
                  of a Kubernetes Service. \n This contract is satisfied by Knative
                  types such as Knative Services and Knative Routes, and by Kubernetes
                  Services."
                properties:
                  apiVersion:
                    description: API version of the referent.
                    type: string
                  group:
                    description: 'Group of the API, without the version of the group.
                      This can be used as an alternative to the APIVersion, and then
                      resolved using ResolveGroup. Note: This API is EXPERIMENTAL
                      and might break anytime. For more details: https://github.com/knative/eventing/issues/5086'
                    type: string
                  kind:
                    description: 'Kind of the referent. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds'
                    type: string
                  name:
                    description: 'Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names'
                    type: string
                  namespace:
                    description: 'Namespace of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/
                      This is optional field, it gets defaulted to the object holding
                      it if left out.'
                    type: string
                required:
                - kind
                - name
                type: object
              tls:
                description: TLS allows the DomainMapping to terminate TLS traffic
                  with an existing secret.
                properties:
                  secretName:
                    description: SecretName is the name of the existing secret used
                      to terminate TLS traffic.
                    type: string
                required:
                - secretName
                type: object
            required:
            - ref
            type: object
          status:
            description: 'Status is the current state of the DomainMapping. More info:
              https://github.com/kubernetes/community/blob/master/contributors/devel/sig-architecture/api-conventions.md#spec-and-status'
            properties:
              address:
                description: Address holds the information needed for a DomainMapping
                  to be the target of an event.
                properties:
                  url:
                    type: string
                type: object
              annotations:
                additionalProperties:
                  type: string
                description: Annotations is additional Status fields for the Resource
                  to save some additional State as well as convey more information
                  to the user. This is roughly akin to Annotations on any k8s resource,
                  just the reconciler conveying richer information outwards.
                type: object
              conditions:
                description: Conditions the latest available observations of a resource's
                  current state.
                items:
                  description: 'Condition defines a readiness condition for a Knative
                    resource. See: https://github.com/kubernetes/community/blob/master/contributors/devel/sig-architecture/api-conventions.md#typical-status-properties'
                  properties:
                    lastTransitionTime:
                      description: LastTransitionTime is the last time the condition
                        transitioned from one status to another. We use VolatileTime
                        in place of metav1.Time to exclude this from creating equality.Semantic
                        differences (all other things held constant).
                      type: string
                    message:
                      description: A human readable message indicating details about
                        the transition.
                      type: string
                    reason:
                      description: The reason for the condition's last transition.
                      type: string
                    severity:
                      description: Severity with which to treat failures of this type
                        of condition. When this is not specified, it defaults to Error.
                      type: string
                    status:
                      description: Status of the condition, one of True, False, Unknown.
                      type: string
                    type:
                      description: Type of condition.
                      type: string
                  required:
                  - status
                  - type
                  type: object
                type: array
              observedGeneration:
                description: ObservedGeneration is the 'Generation' of the Service
                  that was last processed by the controller.
                format: int64
                type: integer
              url:
                description: URL is the URL of this DomainMapping.
                type: string
            type: object
        type: object
    served: true
    storage: true
    subresources:
      status: {}
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool]
}

resource "kubectl_manifest" "kubeflow-knative-customresourcedefinition-images" {
  yaml_body = <<YAML
apiVersion: apiextensions.k8s.io/v1
kind: CustomResourceDefinition
metadata:
  labels:
    app.kubernetes.io/name: knative-serving
    app.kubernetes.io/version: 1.8.0
    knative.dev/crd-install: "true"
  name: images.caching.internal.knative.dev
spec:
  group: caching.internal.knative.dev
  names:
    categories:
    - knative-internal
    - caching
    kind: Image
    plural: images
    singular: image
  scope: Namespaced
  versions:
  - additionalPrinterColumns:
    - jsonPath: .spec.image
      name: Image
      type: string
    name: v1alpha1
    schema:
      openAPIV3Schema:
        description: Image is a Knative abstraction that encapsulates the interface
          by which Knative components express a desire to have a particular image
          cached.
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
            description: Spec holds the desired state of the Image (from the client).
            properties:
              image:
                description: Image is the name of the container image url to cache
                  across the cluster.
                type: string
              imagePullSecrets:
                description: ImagePullSecrets contains the names of the Kubernetes
                  Secrets containing login information used by the Pods which will
                  run this container.
                items:
                  description: LocalObjectReference contains enough information to
                    let you locate the referenced object inside the same namespace.
                  properties:
                    name:
                      description: 'Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
                        TODO: Add other useful fields. apiVersion, kind, uid?'
                      type: string
                  type: object
                  x-kubernetes-map-type: atomic
                type: array
              serviceAccountName:
                description: 'ServiceAccountName is the name of the Kubernetes ServiceAccount
                  as which the Pods will run this container.  This is potentially
                  used to authenticate the image pull if the service account has attached
                  pull secrets.  For more information: https://kubernetes.io/docs/tasks/configure-pod-container/configure-service-account/#add-imagepullsecrets-to-a-service-account'
                type: string
            required:
            - image
            type: object
          status:
            description: Status communicates the observed state of the Image (from
              the controller).
            properties:
              annotations:
                additionalProperties:
                  type: string
                description: Annotations is additional Status fields for the Resource
                  to save some additional State as well as convey more information
                  to the user. This is roughly akin to Annotations on any k8s resource,
                  just the reconciler conveying richer information outwards.
                type: object
              conditions:
                description: Conditions the latest available observations of a resource's
                  current state.
                items:
                  description: 'Condition defines a readiness condition for a Knative
                    resource. See: https://github.com/kubernetes/community/blob/master/contributors/devel/sig-architecture/api-conventions.md#typical-status-properties'
                  properties:
                    lastTransitionTime:
                      description: LastTransitionTime is the last time the condition
                        transitioned from one status to another. We use VolatileTime
                        in place of metav1.Time to exclude this from creating equality.Semantic
                        differences (all other things held constant).
                      type: string
                    message:
                      description: A human readable message indicating details about
                        the transition.
                      type: string
                    reason:
                      description: The reason for the condition's last transition.
                      type: string
                    severity:
                      description: Severity with which to treat failures of this type
                        of condition. When this is not specified, it defaults to Error.
                      type: string
                    status:
                      description: Status of the condition, one of True, False, Unknown.
                      type: string
                    type:
                      description: Type of condition.
                      type: string
                  required:
                  - status
                  - type
                  type: object
                type: array
              observedGeneration:
                description: ObservedGeneration is the 'Generation' of the Service
                  that was last processed by the controller.
                format: int64
                type: integer
            type: object
        type: object
    served: true
    storage: true
    subresources:
      status: {}
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool]
}

resource "kubectl_manifest" "kubeflow-knative-customresourcedefinition-ingresses" {
  yaml_body = <<YAML
apiVersion: apiextensions.k8s.io/v1
kind: CustomResourceDefinition
metadata:
  labels:
    app.kubernetes.io/component: networking
    app.kubernetes.io/name: knative-serving
    app.kubernetes.io/version: 1.8.0
    knative.dev/crd-install: "true"
  name: ingresses.networking.internal.knative.dev
spec:
  group: networking.internal.knative.dev
  names:
    categories:
    - knative-internal
    - networking
    kind: Ingress
    plural: ingresses
    shortNames:
    - kingress
    - king
    singular: ingress
  scope: Namespaced
  versions:
  - additionalPrinterColumns:
    - jsonPath: .status.conditions[?(@.type=='Ready')].status
      name: Ready
      type: string
    - jsonPath: .status.conditions[?(@.type=='Ready')].reason
      name: Reason
      type: string
    name: v1alpha1
    schema:
      openAPIV3Schema:
        description: "Ingress is a collection of rules that allow inbound connections
          to reach the endpoints defined by a backend. An Ingress can be configured
          to give services externally-reachable URLs, load balance traffic, offer
          name based virtual hosting, etc. \n This is heavily based on K8s Ingress
          https://godoc.org/k8s.io/api/networking/v1beta1#Ingress which some highlighted
          modifications."
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
            description: 'Spec is the desired state of the Ingress. More info: https://github.com/kubernetes/community/blob/master/contributors/devel/sig-architecture/api-conventions.md#spec-and-status'
            properties:
              httpOption:
                description: 'HTTPOption is the option of HTTP. It has the following
                  two values: `HTTPOptionEnabled`, `HTTPOptionRedirected`'
                type: string
              rules:
                description: A list of host rules used to configure the Ingress.
                items:
                  description: IngressRule represents the rules mapping the paths
                    under a specified host to the related backend services. Incoming
                    requests are first evaluated for a host match, then routed to
                    the backend associated with the matching IngressRuleValue.
                  properties:
                    hosts:
                      description: 'Host is the fully qualified domain name of a network
                        host, as defined by RFC 3986. Note the following deviations
                        from the "host" part of the URI as defined in the RFC: 1.
                        IPs are not allowed. Currently a rule value can only apply
                        to the IP in the Spec of the parent . 2. The `:` delimiter
                        is not respected because ports are not allowed. Currently
                        the port of an Ingress is implicitly :80 for http and :443
                        for https. Both these may change in the future. If the host
                        is unspecified, the Ingress routes all traffic based on the
                        specified IngressRuleValue. If multiple matching Hosts were
                        provided, the first rule will take precedent.'
                      items:
                        type: string
                      type: array
                    http:
                      description: HTTP represents a rule to apply against incoming
                        requests. If the rule is satisfied, the request is routed
                        to the specified backend.
                      properties:
                        paths:
                          description: "A collection of paths that map requests to
                            backends. \n If they are multiple matching paths, the
                            first match takes precedence."
                          items:
                            description: HTTPIngressPath associates a path regex with
                              a backend. Incoming URLs matching the path are forwarded
                              to the backend.
                            properties:
                              appendHeaders:
                                additionalProperties:
                                  type: string
                                description: "AppendHeaders allow specifying additional
                                  HTTP headers to add before forwarding a request
                                  to the destination service. \n NOTE: This differs
                                  from K8s Ingress which doesn't allow header appending."
                                type: object
                              headers:
                                additionalProperties:
                                  description: HeaderMatch represents a matching value
                                    of Headers in HTTPIngressPath. Currently, only
                                    the exact matching is supported.
                                  properties:
                                    exact:
                                      type: string
                                  required:
                                  - exact
                                  type: object
                                description: Headers defines header matching rules
                                  which is a map from a header name to HeaderMatch
                                  which specify a matching condition. When a request
                                  matched with all the header matching rules, the
                                  request is routed by the corresponding ingress rule.
                                  If it is empty, the headers are not used for matching
                                type: object
                              path:
                                description: Path represents a literal prefix to which
                                  this rule should apply. Currently it can contain
                                  characters disallowed from the conventional "path"
                                  part of a URL as defined by RFC 3986. Paths must
                                  begin with a '/'. If unspecified, the path defaults
                                  to a catch all sending traffic to the backend.
                                type: string
                              rewriteHost:
                                description: "RewriteHost rewrites the incoming request's
                                  host header. \n This field is currently experimental
                                  and not supported by all Ingress implementations."
                                type: string
                              splits:
                                description: Splits defines the referenced service
                                  endpoints to which the traffic will be forwarded
                                  to.
                                items:
                                  description: IngressBackendSplit describes all endpoints
                                    for a given service and port.
                                  properties:
                                    appendHeaders:
                                      additionalProperties:
                                        type: string
                                      description: "AppendHeaders allow specifying
                                        additional HTTP headers to add before forwarding
                                        a request to the destination service. \n NOTE:
                                        This differs from K8s Ingress which doesn't
                                        allow header appending."
                                      type: object
                                    percent:
                                      description: "Specifies the split percentage,
                                        a number between 0 and 100.  If only one split
                                        is specified, we default to 100. \n NOTE:
                                        This differs from K8s Ingress to allow percentage
                                        split."
                                      type: integer
                                    serviceName:
                                      description: Specifies the name of the referenced
                                        service.
                                      type: string
                                    serviceNamespace:
                                      description: "Specifies the namespace of the
                                        referenced service. \n NOTE: This differs
                                        from K8s Ingress to allow routing to different
                                        namespaces."
                                      type: string
                                    servicePort:
                                      anyOf:
                                      - type: integer
                                      - type: string
                                      description: Specifies the port of the referenced
                                        service.
                                      x-kubernetes-int-or-string: true
                                  required:
                                  - serviceName
                                  - serviceNamespace
                                  - servicePort
                                  type: object
                                type: array
                            required:
                            - splits
                            type: object
                          type: array
                      required:
                      - paths
                      type: object
                    visibility:
                      description: Visibility signifies whether this rule should `ClusterLocal`.
                        If it's not specified then it defaults to `ExternalIP`.
                      type: string
                  type: object
                type: array
              tls:
                description: 'TLS configuration. Currently Ingress only supports a
                  single TLS port: 443. If multiple members of this list specify different
                  hosts, they will be multiplexed on the same port according to the
                  hostname specified through the SNI TLS extension, if the ingress
                  controller fulfilling the ingress supports SNI.'
                items:
                  description: IngressTLS describes the transport layer security associated
                    with an Ingress.
                  properties:
                    hosts:
                      description: Hosts is a list of hosts included in the TLS certificate.
                        The values in this list must match the name/s used in the
                        tlsSecret. Defaults to the wildcard host setting for the loadbalancer
                        controller fulfilling this Ingress, if left unspecified.
                      items:
                        type: string
                      type: array
                    secretName:
                      description: SecretName is the name of the secret used to terminate
                        SSL traffic.
                      type: string
                    secretNamespace:
                      description: SecretNamespace is the namespace of the secret
                        used to terminate SSL traffic. If not set the namespace should
                        be assumed to be the same as the Ingress. If set the secret
                        should have the same namespace as the Ingress otherwise the
                        behaviour is undefined and not supported.
                      type: string
                  type: object
                type: array
            type: object
          status:
            description: 'Status is the current state of the Ingress. More info: https://github.com/kubernetes/community/blob/master/contributors/devel/sig-architecture/api-conventions.md#spec-and-status'
            properties:
              annotations:
                additionalProperties:
                  type: string
                description: Annotations is additional Status fields for the Resource
                  to save some additional State as well as convey more information
                  to the user. This is roughly akin to Annotations on any k8s resource,
                  just the reconciler conveying richer information outwards.
                type: object
              conditions:
                description: Conditions the latest available observations of a resource's
                  current state.
                items:
                  description: 'Condition defines a readiness condition for a Knative
                    resource. See: https://github.com/kubernetes/community/blob/master/contributors/devel/sig-architecture/api-conventions.md#typical-status-properties'
                  properties:
                    lastTransitionTime:
                      description: LastTransitionTime is the last time the condition
                        transitioned from one status to another. We use VolatileTime
                        in place of metav1.Time to exclude this from creating equality.Semantic
                        differences (all other things held constant).
                      type: string
                    message:
                      description: A human readable message indicating details about
                        the transition.
                      type: string
                    reason:
                      description: The reason for the condition's last transition.
                      type: string
                    severity:
                      description: Severity with which to treat failures of this type
                        of condition. When this is not specified, it defaults to Error.
                      type: string
                    status:
                      description: Status of the condition, one of True, False, Unknown.
                      type: string
                    type:
                      description: Type of condition.
                      type: string
                  required:
                  - status
                  - type
                  type: object
                type: array
              observedGeneration:
                description: ObservedGeneration is the 'Generation' of the Service
                  that was last processed by the controller.
                format: int64
                type: integer
              privateLoadBalancer:
                description: PrivateLoadBalancer contains the current status of the
                  load-balancer.
                properties:
                  ingress:
                    description: Ingress is a list containing ingress points for the
                      load-balancer. Traffic intended for the service should be sent
                      to these ingress points.
                    items:
                      description: 'LoadBalancerIngressStatus represents the status
                        of a load-balancer ingress point: traffic intended for the
                        service should be sent to an ingress point.'
                      properties:
                        domain:
                          description: Domain is set for load-balancer ingress points
                            that are DNS based (typically AWS load-balancers)
                          type: string
                        domainInternal:
                          description: "DomainInternal is set if there is a cluster-local
                            DNS name to access the Ingress. \n NOTE: This differs
                            from K8s Ingress, since we also desire to have a cluster-local
                            DNS name to allow routing in case of not having a mesh."
                          type: string
                        ip:
                          description: IP is set for load-balancer ingress points
                            that are IP based (typically GCE or OpenStack load-balancers)
                          type: string
                        meshOnly:
                          description: MeshOnly is set if the Ingress is only load-balanced
                            through a Service mesh.
                          type: boolean
                      type: object
                    type: array
                type: object
              publicLoadBalancer:
                description: PublicLoadBalancer contains the current status of the
                  load-balancer.
                properties:
                  ingress:
                    description: Ingress is a list containing ingress points for the
                      load-balancer. Traffic intended for the service should be sent
                      to these ingress points.
                    items:
                      description: 'LoadBalancerIngressStatus represents the status
                        of a load-balancer ingress point: traffic intended for the
                        service should be sent to an ingress point.'
                      properties:
                        domain:
                          description: Domain is set for load-balancer ingress points
                            that are DNS based (typically AWS load-balancers)
                          type: string
                        domainInternal:
                          description: "DomainInternal is set if there is a cluster-local
                            DNS name to access the Ingress. \n NOTE: This differs
                            from K8s Ingress, since we also desire to have a cluster-local
                            DNS name to allow routing in case of not having a mesh."
                          type: string
                        ip:
                          description: IP is set for load-balancer ingress points
                            that are IP based (typically GCE or OpenStack load-balancers)
                          type: string
                        meshOnly:
                          description: MeshOnly is set if the Ingress is only load-balanced
                            through a Service mesh.
                          type: boolean
                      type: object
                    type: array
                type: object
            type: object
        type: object
    served: true
    storage: true
    subresources:
      status: {}
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool]
}

resource "kubectl_manifest" "kubeflow-knative-customresourcedefinition-metrics" {
  yaml_body = <<YAML
apiVersion: apiextensions.k8s.io/v1
kind: CustomResourceDefinition
metadata:
  labels:
    app.kubernetes.io/name: knative-serving
    app.kubernetes.io/version: 1.8.0
    knative.dev/crd-install: "true"
  name: metrics.autoscaling.internal.knative.dev
spec:
  group: autoscaling.internal.knative.dev
  names:
    categories:
    - knative-internal
    - autoscaling
    kind: Metric
    plural: metrics
    singular: metric
  scope: Namespaced
  versions:
  - additionalPrinterColumns:
    - jsonPath: .status.conditions[?(@.type=='Ready')].status
      name: Ready
      type: string
    - jsonPath: .status.conditions[?(@.type=='Ready')].reason
      name: Reason
      type: string
    name: v1alpha1
    schema:
      openAPIV3Schema:
        description: Metric represents a resource to configure the metric collector
          with.
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
            description: Spec holds the desired state of the Metric (from the client).
            properties:
              panicWindow:
                description: PanicWindow is the aggregation window for metrics where
                  quick reactions are needed.
                format: int64
                type: integer
              scrapeTarget:
                description: ScrapeTarget is the K8s service that publishes the metric
                  endpoint.
                type: string
              stableWindow:
                description: StableWindow is the aggregation window for metrics in
                  a stable state.
                format: int64
                type: integer
            required:
            - panicWindow
            - scrapeTarget
            - stableWindow
            type: object
          status:
            description: Status communicates the observed state of the Metric (from
              the controller).
            properties:
              annotations:
                additionalProperties:
                  type: string
                description: Annotations is additional Status fields for the Resource
                  to save some additional State as well as convey more information
                  to the user. This is roughly akin to Annotations on any k8s resource,
                  just the reconciler conveying richer information outwards.
                type: object
              conditions:
                description: Conditions the latest available observations of a resource's
                  current state.
                items:
                  description: 'Condition defines a readiness condition for a Knative
                    resource. See: https://github.com/kubernetes/community/blob/master/contributors/devel/sig-architecture/api-conventions.md#typical-status-properties'
                  properties:
                    lastTransitionTime:
                      description: LastTransitionTime is the last time the condition
                        transitioned from one status to another. We use VolatileTime
                        in place of metav1.Time to exclude this from creating equality.Semantic
                        differences (all other things held constant).
                      type: string
                    message:
                      description: A human readable message indicating details about
                        the transition.
                      type: string
                    reason:
                      description: The reason for the condition's last transition.
                      type: string
                    severity:
                      description: Severity with which to treat failures of this type
                        of condition. When this is not specified, it defaults to Error.
                      type: string
                    status:
                      description: Status of the condition, one of True, False, Unknown.
                      type: string
                    type:
                      description: Type of condition.
                      type: string
                  required:
                  - status
                  - type
                  type: object
                type: array
              observedGeneration:
                description: ObservedGeneration is the 'Generation' of the Service
                  that was last processed by the controller.
                format: int64
                type: integer
            type: object
        type: object
    served: true
    storage: true
    subresources:
      status: {}
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool]
}

resource "kubectl_manifest" "kubeflow-knative-customresourcedefinition-podautoscalers" {
  yaml_body = <<YAML
apiVersion: apiextensions.k8s.io/v1
kind: CustomResourceDefinition
metadata:
  labels:
    app.kubernetes.io/name: knative-serving
    app.kubernetes.io/version: 1.8.0
    knative.dev/crd-install: "true"
  name: podautoscalers.autoscaling.internal.knative.dev
spec:
  group: autoscaling.internal.knative.dev
  names:
    categories:
    - knative-internal
    - autoscaling
    kind: PodAutoscaler
    plural: podautoscalers
    shortNames:
    - kpa
    - pa
    singular: podautoscaler
  scope: Namespaced
  versions:
  - additionalPrinterColumns:
    - jsonPath: .status.desiredScale
      name: DesiredScale
      type: integer
    - jsonPath: .status.actualScale
      name: ActualScale
      type: integer
    - jsonPath: .status.conditions[?(@.type=='Ready')].status
      name: Ready
      type: string
    - jsonPath: .status.conditions[?(@.type=='Ready')].reason
      name: Reason
      type: string
    name: v1alpha1
    schema:
      openAPIV3Schema:
        description: 'PodAutoscaler is a Knative abstraction that encapsulates the
          interface by which Knative components instantiate autoscalers.  This definition
          is an abstraction that may be backed by multiple definitions.  For more
          information, see the Knative Pluggability presentation: https://docs.google.com/presentation/d/19vW9HFZ6Puxt31biNZF3uLRejDmu82rxJIk1cWmxF7w/edit'
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
            description: Spec holds the desired state of the PodAutoscaler (from the
              client).
            properties:
              containerConcurrency:
                description: ContainerConcurrency specifies the maximum allowed in-flight
                  (concurrent) requests per container of the Revision. Defaults to
                  `0` which means unlimited concurrency.
                format: int64
                type: integer
              protocolType:
                description: The application-layer protocol. Matches `ProtocolType`
                  inferred from the revision spec.
                type: string
              reachability:
                description: Reachability specifies whether or not the `ScaleTargetRef`
                  can be reached (ie. has a route). Defaults to `ReachabilityUnknown`
                type: string
              scaleTargetRef:
                description: ScaleTargetRef defines the /scale-able resource that
                  this PodAutoscaler is responsible for quickly right-sizing.
                properties:
                  apiVersion:
                    description: API version of the referent.
                    type: string
                  kind:
                    description: 'Kind of the referent. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds'
                    type: string
                  name:
                    description: 'Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names'
                    type: string
                type: object
                x-kubernetes-map-type: atomic
            required:
            - protocolType
            - scaleTargetRef
            type: object
          status:
            description: Status communicates the observed state of the PodAutoscaler
              (from the controller).
            properties:
              actualScale:
                description: ActualScale shows the actual number of replicas for the
                  revision.
                format: int32
                type: integer
              annotations:
                additionalProperties:
                  type: string
                description: Annotations is additional Status fields for the Resource
                  to save some additional State as well as convey more information
                  to the user. This is roughly akin to Annotations on any k8s resource,
                  just the reconciler conveying richer information outwards.
                type: object
              conditions:
                description: Conditions the latest available observations of a resource's
                  current state.
                items:
                  description: 'Condition defines a readiness condition for a Knative
                    resource. See: https://github.com/kubernetes/community/blob/master/contributors/devel/sig-architecture/api-conventions.md#typical-status-properties'
                  properties:
                    lastTransitionTime:
                      description: LastTransitionTime is the last time the condition
                        transitioned from one status to another. We use VolatileTime
                        in place of metav1.Time to exclude this from creating equality.Semantic
                        differences (all other things held constant).
                      type: string
                    message:
                      description: A human readable message indicating details about
                        the transition.
                      type: string
                    reason:
                      description: The reason for the condition's last transition.
                      type: string
                    severity:
                      description: Severity with which to treat failures of this type
                        of condition. When this is not specified, it defaults to Error.
                      type: string
                    status:
                      description: Status of the condition, one of True, False, Unknown.
                      type: string
                    type:
                      description: Type of condition.
                      type: string
                  required:
                  - status
                  - type
                  type: object
                type: array
              desiredScale:
                description: DesiredScale shows the current desired number of replicas
                  for the revision.
                format: int32
                type: integer
              metricsServiceName:
                description: MetricsServiceName is the K8s Service name that provides
                  revision metrics. The service is managed by the PA object.
                type: string
              observedGeneration:
                description: ObservedGeneration is the 'Generation' of the Service
                  that was last processed by the controller.
                format: int64
                type: integer
              serviceName:
                description: ServiceName is the K8s Service name that serves the revision,
                  scaled by this PA. The service is created and owned by the ServerlessService
                  object owned by this PA.
                type: string
            required:
            - metricsServiceName
            - serviceName
            type: object
        type: object
    served: true
    storage: true
    subresources:
      status: {}
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool]
}

resource "kubectl_manifest" "kubeflow-knative-customresourcedefinition-revisions" {
  yaml_body = <<YAML
apiVersion: apiextensions.k8s.io/v1
kind: CustomResourceDefinition
metadata:
  labels:
    app.kubernetes.io/name: knative-serving
    app.kubernetes.io/version: 1.8.0
    knative.dev/crd-install: "true"
  name: revisions.serving.knative.dev
spec:
  group: serving.knative.dev
  names:
    categories:
    - all
    - knative
    - serving
    kind: Revision
    plural: revisions
    shortNames:
    - rev
    singular: revision
  scope: Namespaced
  versions:
  - additionalPrinterColumns:
    - jsonPath: .metadata.labels['serving\.knative\.dev/configuration']
      name: Config Name
      type: string
    - jsonPath: .status.serviceName
      name: K8s Service Name
      type: string
    - jsonPath: .metadata.labels['serving\.knative\.dev/configurationGeneration']
      name: Generation
      type: string
    - jsonPath: .status.conditions[?(@.type=='Ready')].status
      name: Ready
      type: string
    - jsonPath: .status.conditions[?(@.type=='Ready')].reason
      name: Reason
      type: string
    - jsonPath: .status.actualReplicas
      name: Actual Replicas
      type: integer
    - jsonPath: .status.desiredReplicas
      name: Desired Replicas
      type: integer
    name: v1
    schema:
      openAPIV3Schema:
        description: "Revision is an immutable snapshot of code and configuration.
          \ A revision references a container image. Revisions are created by updates
          to a Configuration. \n See also: https://github.com/knative/serving/blob/main/docs/spec/overview.md#revision"
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
            description: RevisionSpec holds the desired state of the Revision (from
              the client).
            properties:
              affinity:
                description: This is accessible behind a feature flag - kubernetes.podspec-affinity
                type: object
                x-kubernetes-preserve-unknown-fields: true
              automountServiceAccountToken:
                description: AutomountServiceAccountToken indicates whether a service
                  account token should be automatically mounted.
                type: boolean
              containerConcurrency:
                description: ContainerConcurrency specifies the maximum allowed in-flight
                  (concurrent) requests per container of the Revision.  Defaults to
                  `0` which means concurrency to the application is not limited, and
                  the system decides the target concurrency for the autoscaler.
                format: int64
                type: integer
              containers:
                description: List of containers belonging to the pod. Containers cannot
                  currently be added or removed. There must be at least one container
                  in a Pod. Cannot be updated.
                items:
                  description: A single application container that you want to run
                    within a pod.
                  properties:
                    args:
                      description: 'Arguments to the entrypoint. The container image''s
                        CMD is used if this is not provided. Variable references $(VAR_NAME)
                        are expanded using the container''s environment. If a variable
                        cannot be resolved, the reference in the input string will
                        be unchanged. Double $$ are reduced to a single $, which allows
                        for escaping the $(VAR_NAME) syntax: i.e. "$$(VAR_NAME)" will
                        produce the string literal "$(VAR_NAME)". Escaped references
                        will never be expanded, regardless of whether the variable
                        exists or not. Cannot be updated. More info: https://kubernetes.io/docs/tasks/inject-data-application/define-command-argument-container/#running-a-command-in-a-shell'
                      items:
                        type: string
                      type: array
                    command:
                      description: 'Entrypoint array. Not executed within a shell.
                        The container image''s ENTRYPOINT is used if this is not provided.
                        Variable references $(VAR_NAME) are expanded using the container''s
                        environment. If a variable cannot be resolved, the reference
                        in the input string will be unchanged. Double $$ are reduced
                        to a single $, which allows for escaping the $(VAR_NAME) syntax:
                        i.e. "$$(VAR_NAME)" will produce the string literal "$(VAR_NAME)".
                        Escaped references will never be expanded, regardless of whether
                        the variable exists or not. Cannot be updated. More info:
                        https://kubernetes.io/docs/tasks/inject-data-application/define-command-argument-container/#running-a-command-in-a-shell'
                      items:
                        type: string
                      type: array
                    env:
                      description: List of environment variables to set in the container.
                        Cannot be updated.
                      items:
                        description: EnvVar represents an environment variable present
                          in a Container.
                        properties:
                          name:
                            description: Name of the environment variable. Must be
                              a C_IDENTIFIER.
                            type: string
                          value:
                            description: 'Variable references $(VAR_NAME) are expanded
                              using the previously defined environment variables in
                              the container and any service environment variables.
                              If a variable cannot be resolved, the reference in the
                              input string will be unchanged. Double $$ are reduced
                              to a single $, which allows for escaping the $(VAR_NAME)
                              syntax: i.e. "$$(VAR_NAME)" will produce the string
                              literal "$(VAR_NAME)". Escaped references will never
                              be expanded, regardless of whether the variable exists
                              or not. Defaults to "".'
                            type: string
                          valueFrom:
                            description: Source for the environment variable's value.
                              Cannot be used if value is not empty.
                            properties:
                              configMapKeyRef:
                                description: Selects a key of a ConfigMap.
                                properties:
                                  key:
                                    description: The key to select.
                                    type: string
                                  name:
                                    description: 'Name of the referent. More info:
                                      https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
                                      TODO: Add other useful fields. apiVersion, kind,
                                      uid?'
                                    type: string
                                  optional:
                                    description: Specify whether the ConfigMap or
                                      its key must be defined
                                    type: boolean
                                required:
                                - key
                                type: object
                                x-kubernetes-map-type: atomic
                              fieldRef:
                                description: This is accessible behind a feature flag
                                  - kubernetes.podspec-fieldref
                                type: object
                                x-kubernetes-map-type: atomic
                                x-kubernetes-preserve-unknown-fields: true
                              resourceFieldRef:
                                description: This is accessible behind a feature flag
                                  - kubernetes.podspec-fieldref
                                type: object
                                x-kubernetes-map-type: atomic
                                x-kubernetes-preserve-unknown-fields: true
                              secretKeyRef:
                                description: Selects a key of a secret in the pod's
                                  namespace
                                properties:
                                  key:
                                    description: The key of the secret to select from.  Must
                                      be a valid secret key.
                                    type: string
                                  name:
                                    description: 'Name of the referent. More info:
                                      https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
                                      TODO: Add other useful fields. apiVersion, kind,
                                      uid?'
                                    type: string
                                  optional:
                                    description: Specify whether the Secret or its
                                      key must be defined
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
                      description: List of sources to populate environment variables
                        in the container. The keys defined within a source must be
                        a C_IDENTIFIER. All invalid keys will be reported as an event
                        when the container is starting. When a key exists in multiple
                        sources, the value associated with the last source will take
                        precedence. Values defined by an Env with a duplicate key
                        will take precedence. Cannot be updated.
                      items:
                        description: EnvFromSource represents the source of a set
                          of ConfigMaps
                        properties:
                          configMapRef:
                            description: The ConfigMap to select from
                            properties:
                              name:
                                description: 'Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
                                  TODO: Add other useful fields. apiVersion, kind,
                                  uid?'
                                type: string
                              optional:
                                description: Specify whether the ConfigMap must be
                                  defined
                                type: boolean
                            type: object
                            x-kubernetes-map-type: atomic
                          prefix:
                            description: An optional identifier to prepend to each
                              key in the ConfigMap. Must be a C_IDENTIFIER.
                            type: string
                          secretRef:
                            description: The Secret to select from
                            properties:
                              name:
                                description: 'Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
                                  TODO: Add other useful fields. apiVersion, kind,
                                  uid?'
                                type: string
                              optional:
                                description: Specify whether the Secret must be defined
                                type: boolean
                            type: object
                            x-kubernetes-map-type: atomic
                        type: object
                      type: array
                    image:
                      description: 'Container image name. More info: https://kubernetes.io/docs/concepts/containers/images
                        This field is optional to allow higher level config management
                        to default or override container images in workload controllers
                        like Deployments and StatefulSets.'
                      type: string
                    imagePullPolicy:
                      description: 'Image pull policy. One of Always, Never, IfNotPresent.
                        Defaults to Always if :latest tag is specified, or IfNotPresent
                        otherwise. Cannot be updated. More info: https://kubernetes.io/docs/concepts/containers/images#updating-images'
                      type: string
                    livenessProbe:
                      description: 'Periodic probe of container liveness. Container
                        will be restarted if the probe fails. Cannot be updated. More
                        info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes'
                      properties:
                        exec:
                          description: Exec specifies the action to take.
                          properties:
                            command:
                              description: Command is the command line to execute
                                inside the container, the working directory for the
                                command  is root ('/') in the container's filesystem.
                                The command is simply exec'd, it is not run inside
                                a shell, so traditional shell instructions ('|', etc)
                                won't work. To use a shell, you need to explicitly
                                call out to that shell. Exit status of 0 is treated
                                as live/healthy and non-zero is unhealthy.
                              items:
                                type: string
                              type: array
                          type: object
                        failureThreshold:
                          description: Minimum consecutive failures for the probe
                            to be considered failed after having succeeded. Defaults
                            to 3. Minimum value is 1.
                          format: int32
                          type: integer
                        httpGet:
                          description: HTTPGet specifies the http request to perform.
                          properties:
                            host:
                              description: Host name to connect to, defaults to the
                                pod IP. You probably want to set "Host" in httpHeaders
                                instead.
                              type: string
                            httpHeaders:
                              description: Custom headers to set in the request. HTTP
                                allows repeated headers.
                              items:
                                description: HTTPHeader describes a custom header
                                  to be used in HTTP probes
                                properties:
                                  name:
                                    description: The header field name
                                    type: string
                                  value:
                                    description: The header field value
                                    type: string
                                required:
                                - name
                                - value
                                type: object
                              type: array
                            path:
                              description: Path to access on the HTTP server.
                              type: string
                            port:
                              anyOf:
                              - type: integer
                              - type: string
                              description: Name or number of the port to access on
                                the container. Number must be in the range 1 to 65535.
                                Name must be an IANA_SVC_NAME.
                              x-kubernetes-int-or-string: true
                            scheme:
                              description: Scheme to use for connecting to the host.
                                Defaults to HTTP.
                              type: string
                          type: object
                        initialDelaySeconds:
                          description: 'Number of seconds after the container has
                            started before liveness probes are initiated. More info:
                            https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes'
                          format: int32
                          type: integer
                        periodSeconds:
                          description: How often (in seconds) to perform the probe.
                          format: int32
                          type: integer
                        successThreshold:
                          description: Minimum consecutive successes for the probe
                            to be considered successful after having failed. Defaults
                            to 1. Must be 1 for liveness and startup. Minimum value
                            is 1.
                          format: int32
                          type: integer
                        tcpSocket:
                          description: TCPSocket specifies an action involving a TCP
                            port.
                          properties:
                            host:
                              description: 'Optional: Host name to connect to, defaults
                                to the pod IP.'
                              type: string
                            port:
                              anyOf:
                              - type: integer
                              - type: string
                              description: Number or name of the port to access on
                                the container. Number must be in the range 1 to 65535.
                                Name must be an IANA_SVC_NAME.
                              x-kubernetes-int-or-string: true
                          type: object
                        timeoutSeconds:
                          description: 'Number of seconds after which the probe times
                            out. Defaults to 1 second. Minimum value is 1. More info:
                            https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes'
                          format: int32
                          type: integer
                      type: object
                    name:
                      description: Name of the container specified as a DNS_LABEL.
                        Each container in a pod must have a unique name (DNS_LABEL).
                        Cannot be updated.
                      type: string
                    ports:
                      description: List of ports to expose from the container. Not
                        specifying a port here DOES NOT prevent that port from being
                        exposed. Any port which is listening on the default "0.0.0.0"
                        address inside a container will be accessible from the network.
                        Modifying this array with strategic merge patch may corrupt
                        the data. For more information See https://github.com/kubernetes/kubernetes/issues/108255.
                        Cannot be updated.
                      items:
                        description: ContainerPort represents a network port in a
                          single container.
                        properties:
                          containerPort:
                            description: Number of port to expose on the pod's IP
                              address. This must be a valid port number, 0 < x < 65536.
                            format: int32
                            type: integer
                          name:
                            description: If specified, this must be an IANA_SVC_NAME
                              and unique within the pod. Each named port in a pod
                              must have a unique name. Name for the port that can
                              be referred to by services.
                            type: string
                          protocol:
                            default: TCP
                            description: Protocol for port. Must be UDP, TCP, or SCTP.
                              Defaults to "TCP".
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
                      description: 'Periodic probe of container service readiness.
                        Container will be removed from service endpoints if the probe
                        fails. Cannot be updated. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes'
                      properties:
                        exec:
                          description: Exec specifies the action to take.
                          properties:
                            command:
                              description: Command is the command line to execute
                                inside the container, the working directory for the
                                command  is root ('/') in the container's filesystem.
                                The command is simply exec'd, it is not run inside
                                a shell, so traditional shell instructions ('|', etc)
                                won't work. To use a shell, you need to explicitly
                                call out to that shell. Exit status of 0 is treated
                                as live/healthy and non-zero is unhealthy.
                              items:
                                type: string
                              type: array
                          type: object
                        failureThreshold:
                          description: Minimum consecutive failures for the probe
                            to be considered failed after having succeeded. Defaults
                            to 3. Minimum value is 1.
                          format: int32
                          type: integer
                        httpGet:
                          description: HTTPGet specifies the http request to perform.
                          properties:
                            host:
                              description: Host name to connect to, defaults to the
                                pod IP. You probably want to set "Host" in httpHeaders
                                instead.
                              type: string
                            httpHeaders:
                              description: Custom headers to set in the request. HTTP
                                allows repeated headers.
                              items:
                                description: HTTPHeader describes a custom header
                                  to be used in HTTP probes
                                properties:
                                  name:
                                    description: The header field name
                                    type: string
                                  value:
                                    description: The header field value
                                    type: string
                                required:
                                - name
                                - value
                                type: object
                              type: array
                            path:
                              description: Path to access on the HTTP server.
                              type: string
                            port:
                              anyOf:
                              - type: integer
                              - type: string
                              description: Name or number of the port to access on
                                the container. Number must be in the range 1 to 65535.
                                Name must be an IANA_SVC_NAME.
                              x-kubernetes-int-or-string: true
                            scheme:
                              description: Scheme to use for connecting to the host.
                                Defaults to HTTP.
                              type: string
                          type: object
                        initialDelaySeconds:
                          description: 'Number of seconds after the container has
                            started before liveness probes are initiated. More info:
                            https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes'
                          format: int32
                          type: integer
                        periodSeconds:
                          description: How often (in seconds) to perform the probe.
                          format: int32
                          type: integer
                        successThreshold:
                          description: Minimum consecutive successes for the probe
                            to be considered successful after having failed. Defaults
                            to 1. Must be 1 for liveness and startup. Minimum value
                            is 1.
                          format: int32
                          type: integer
                        tcpSocket:
                          description: TCPSocket specifies an action involving a TCP
                            port.
                          properties:
                            host:
                              description: 'Optional: Host name to connect to, defaults
                                to the pod IP.'
                              type: string
                            port:
                              anyOf:
                              - type: integer
                              - type: string
                              description: Number or name of the port to access on
                                the container. Number must be in the range 1 to 65535.
                                Name must be an IANA_SVC_NAME.
                              x-kubernetes-int-or-string: true
                          type: object
                        timeoutSeconds:
                          description: 'Number of seconds after which the probe times
                            out. Defaults to 1 second. Minimum value is 1. More info:
                            https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes'
                          format: int32
                          type: integer
                      type: object
                    resources:
                      description: 'Compute Resources required by this container.
                        Cannot be updated. More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/'
                      properties:
                        limits:
                          additionalProperties:
                            anyOf:
                            - type: integer
                            - type: string
                            pattern: ^(\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))))?$
                            x-kubernetes-int-or-string: true
                          description: 'Limits describes the maximum amount of compute
                            resources allowed. More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/'
                          type: object
                        requests:
                          additionalProperties:
                            anyOf:
                            - type: integer
                            - type: string
                            pattern: ^(\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))))?$
                            x-kubernetes-int-or-string: true
                          description: 'Requests describes the minimum amount of compute
                            resources required. If Requests is omitted for a container,
                            it defaults to Limits if that is explicitly specified,
                            otherwise to an implementation-defined value. More info:
                            https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/'
                          type: object
                      type: object
                    securityContext:
                      description: 'SecurityContext defines the security options the
                        container should be run with. If set, the fields of SecurityContext
                        override the equivalent fields of PodSecurityContext. More
                        info: https://kubernetes.io/docs/tasks/configure-pod-container/security-context/'
                      properties:
                        allowPrivilegeEscalation:
                          description: 'AllowPrivilegeEscalation controls whether
                            a process can gain more privileges than its parent process.
                            This bool directly controls if the no_new_privs flag will
                            be set on the container process. AllowPrivilegeEscalation
                            is true always when the container is: 1) run as Privileged
                            2) has CAP_SYS_ADMIN Note that this field cannot be set
                            when spec.os.name is windows.'
                          type: boolean
                        capabilities:
                          description: The capabilities to add/drop when running containers.
                            Defaults to the default set of capabilities granted by
                            the container runtime. Note that this field cannot be
                            set when spec.os.name is windows.
                          properties:
                            add:
                              description: This is accessible behind a feature flag
                                - kubernetes.containerspec-addcapabilities
                              items:
                                description: Capability represent POSIX capabilities
                                  type
                                type: string
                              type: array
                            drop:
                              description: Removed capabilities
                              items:
                                description: Capability represent POSIX capabilities
                                  type
                                type: string
                              type: array
                          type: object
                        readOnlyRootFilesystem:
                          description: Whether this container has a read-only root
                            filesystem. Default is false. Note that this field cannot
                            be set when spec.os.name is windows.
                          type: boolean
                        runAsGroup:
                          description: The GID to run the entrypoint of the container
                            process. Uses runtime default if unset. May also be set
                            in PodSecurityContext.  If set in both SecurityContext
                            and PodSecurityContext, the value specified in SecurityContext
                            takes precedence. Note that this field cannot be set when
                            spec.os.name is windows.
                          format: int64
                          type: integer
                        runAsNonRoot:
                          description: Indicates that the container must run as a
                            non-root user. If true, the Kubelet will validate the
                            image at runtime to ensure that it does not run as UID
                            0 (root) and fail to start the container if it does. If
                            unset or false, no such validation will be performed.
                            May also be set in PodSecurityContext.  If set in both
                            SecurityContext and PodSecurityContext, the value specified
                            in SecurityContext takes precedence.
                          type: boolean
                        runAsUser:
                          description: The UID to run the entrypoint of the container
                            process. Defaults to user specified in image metadata
                            if unspecified. May also be set in PodSecurityContext.  If
                            set in both SecurityContext and PodSecurityContext, the
                            value specified in SecurityContext takes precedence. Note
                            that this field cannot be set when spec.os.name is windows.
                          format: int64
                          type: integer
                      type: object
                    terminationMessagePath:
                      description: 'Optional: Path at which the file to which the
                        container''s termination message will be written is mounted
                        into the container''s filesystem. Message written is intended
                        to be brief final status, such as an assertion failure message.
                        Will be truncated by the node if greater than 4096 bytes.
                        The total message length across all containers will be limited
                        to 12kb. Defaults to /dev/termination-log. Cannot be updated.'
                      type: string
                    terminationMessagePolicy:
                      description: Indicate how the termination message should be
                        populated. File will use the contents of terminationMessagePath
                        to populate the container status message on both success and
                        failure. FallbackToLogsOnError will use the last chunk of
                        container log output if the termination message file is empty
                        and the container exited with an error. The log output is
                        limited to 2048 bytes or 80 lines, whichever is smaller. Defaults
                        to File. Cannot be updated.
                      type: string
                    volumeMounts:
                      description: Pod volumes to mount into the container's filesystem.
                        Cannot be updated.
                      items:
                        description: VolumeMount describes a mounting of a Volume
                          within a container.
                        properties:
                          mountPath:
                            description: Path within the container at which the volume
                              should be mounted.  Must not contain ':'.
                            type: string
                          name:
                            description: This must match the Name of a Volume.
                            type: string
                          readOnly:
                            description: Mounted read-only if true, read-write otherwise
                              (false or unspecified). Defaults to false.
                            type: boolean
                          subPath:
                            description: Path within the volume from which the container's
                              volume should be mounted. Defaults to "" (volume's root).
                            type: string
                        required:
                        - mountPath
                        - name
                        type: object
                      type: array
                    workingDir:
                      description: Container's working directory. If not specified,
                        the container runtime's default will be used, which might
                        be configured in the container image. Cannot be updated.
                      type: string
                  type: object
                type: array
              dnsConfig:
                description: This is accessible behind a feature flag - kubernetes.podspec-dnsconfig
                type: object
                x-kubernetes-preserve-unknown-fields: true
              dnsPolicy:
                description: This is accessible behind a feature flag - kubernetes.podspec-dnspolicy
                type: string
              enableServiceLinks:
                description: 'EnableServiceLinks indicates whether information about
                  services should be injected into pod''s environment variables, matching
                  the syntax of Docker links. Optional: Knative defaults this to false.'
                type: boolean
              hostAliases:
                description: This is accessible behind a feature flag - kubernetes.podspec-hostaliases
                items:
                  description: This is accessible behind a feature flag - kubernetes.podspec-hostaliases
                  type: object
                  x-kubernetes-preserve-unknown-fields: true
                type: array
              idleTimeoutSeconds:
                description: IdleTimeoutSeconds is the maximum duration in seconds
                  a request will be allowed to stay open while not receiving any bytes
                  from the user's application. If unspecified, a system default will
                  be provided.
                format: int64
                type: integer
              imagePullSecrets:
                description: 'ImagePullSecrets is an optional list of references to
                  secrets in the same namespace to use for pulling any of the images
                  used by this PodSpec. If specified, these secrets will be passed
                  to individual puller implementations for them to use. More info:
                  https://kubernetes.io/docs/concepts/containers/images#specifying-imagepullsecrets-on-a-pod'
                items:
                  description: LocalObjectReference contains enough information to
                    let you locate the referenced object inside the same namespace.
                  properties:
                    name:
                      description: 'Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
                        TODO: Add other useful fields. apiVersion, kind, uid?'
                      type: string
                  type: object
                  x-kubernetes-map-type: atomic
                type: array
              initContainers:
                description: 'List of initialization containers belonging to the pod.
                  Init containers are executed in order prior to containers being
                  started. If any init container fails, the pod is considered to have
                  failed and is handled according to its restartPolicy. The name for
                  an init container or normal container must be unique among all containers.
                  Init containers may not have Lifecycle actions, Readiness probes,
                  Liveness probes, or Startup probes. The resourceRequirements of
                  an init container are taken into account during scheduling by finding
                  the highest request/limit for each resource type, and then using
                  the max of of that value or the sum of the normal containers. Limits
                  are applied to init containers in a similar fashion. Init containers
                  cannot currently be added or removed. Cannot be updated. More info:
                  https://kubernetes.io/docs/concepts/workloads/pods/init-containers/'
                items:
                  description: This is accessible behind a feature flag - kubernetes.podspec-init-containers
                  type: object
                  x-kubernetes-preserve-unknown-fields: true
                type: array
              nodeSelector:
                description: This is accessible behind a feature flag - kubernetes.podspec-nodeselector
                type: object
                x-kubernetes-map-type: atomic
                x-kubernetes-preserve-unknown-fields: true
              priorityClassName:
                description: This is accessible behind a feature flag - kubernetes.podspec-priorityclassname
                type: string
                x-kubernetes-preserve-unknown-fields: true
              responseStartTimeoutSeconds:
                description: ResponseStartTimeoutSeconds is the maximum duration in
                  seconds that the request routing layer will wait for a request delivered
                  to a container to begin sending any network traffic.
                format: int64
                type: integer
              runtimeClassName:
                description: This is accessible behind a feature flag - kubernetes.podspec-runtimeclassname
                type: string
                x-kubernetes-preserve-unknown-fields: true
              schedulerName:
                description: This is accessible behind a feature flag - kubernetes.podspec-schedulername
                type: string
                x-kubernetes-preserve-unknown-fields: true
              securityContext:
                description: This is accessible behind a feature flag - kubernetes.podspec-securitycontext
                type: object
                x-kubernetes-preserve-unknown-fields: true
              serviceAccountName:
                description: 'ServiceAccountName is the name of the ServiceAccount
                  to use to run this pod. More info: https://kubernetes.io/docs/tasks/configure-pod-container/configure-service-account/'
                type: string
              timeoutSeconds:
                description: TimeoutSeconds is the maximum duration in seconds that
                  the request instance is allowed to respond to a request. If unspecified,
                  a system default will be provided.
                format: int64
                type: integer
              tolerations:
                description: This is accessible behind a feature flag - kubernetes.podspec-tolerations
                items:
                  description: This is accessible behind a feature flag - kubernetes.podspec-tolerations
                  type: object
                  x-kubernetes-preserve-unknown-fields: true
                type: array
              topologySpreadConstraints:
                description: This is accessible behind a feature flag - kubernetes.podspec-topologyspreadconstraints
                items:
                  description: This is accessible behind a feature flag - kubernetes.podspec-topologyspreadconstraints
                  type: object
                  x-kubernetes-preserve-unknown-fields: true
                type: array
              volumes:
                description: 'List of volumes that can be mounted by containers belonging
                  to the pod. More info: https://kubernetes.io/docs/concepts/storage/volumes'
                items:
                  description: Volume represents a named volume in a pod that may
                    be accessed by any container in the pod.
                  properties:
                    configMap:
                      description: configMap represents a configMap that should populate
                        this volume
                      properties:
                        defaultMode:
                          description: 'defaultMode is optional: mode bits used to
                            set permissions on created files by default. Must be an
                            octal value between 0000 and 0777 or a decimal value between
                            0 and 511. YAML accepts both octal and decimal values,
                            JSON requires decimal values for mode bits. Defaults to
                            0644. Directories within the path are not affected by
                            this setting. This might be in conflict with other options
                            that affect the file mode, like fsGroup, and the result
                            can be other mode bits set.'
                          format: int32
                          type: integer
                        items:
                          description: items if unspecified, each key-value pair in
                            the Data field of the referenced ConfigMap will be projected
                            into the volume as a file whose name is the key and content
                            is the value. If specified, the listed keys will be projected
                            into the specified paths, and unlisted keys will not be
                            present. If a key is specified which is not present in
                            the ConfigMap, the volume setup will error unless it is
                            marked optional. Paths must be relative and may not contain
                            the '..' path or start with '..'.
                          items:
                            description: Maps a string key to a path within a volume.
                            properties:
                              key:
                                description: key is the key to project.
                                type: string
                              mode:
                                description: 'mode is Optional: mode bits used to
                                  set permissions on this file. Must be an octal value
                                  between 0000 and 0777 or a decimal value between
                                  0 and 511. YAML accepts both octal and decimal values,
                                  JSON requires decimal values for mode bits. If not
                                  specified, the volume defaultMode will be used.
                                  This might be in conflict with other options that
                                  affect the file mode, like fsGroup, and the result
                                  can be other mode bits set.'
                                format: int32
                                type: integer
                              path:
                                description: path is the relative path of the file
                                  to map the key to. May not be an absolute path.
                                  May not contain the path element '..'. May not start
                                  with the string '..'.
                                type: string
                            required:
                            - key
                            - path
                            type: object
                          type: array
                        name:
                          description: 'Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
                            TODO: Add other useful fields. apiVersion, kind, uid?'
                          type: string
                        optional:
                          description: optional specify whether the ConfigMap or its
                            keys must be defined
                          type: boolean
                      type: object
                      x-kubernetes-map-type: atomic
                    emptyDir:
                      description: This is accessible behind a feature flag - kubernetes.podspec-emptydir
                      type: object
                      x-kubernetes-preserve-unknown-fields: true
                    name:
                      description: 'name of the volume. Must be a DNS_LABEL and unique
                        within the pod. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names'
                      type: string
                    persistentVolumeClaim:
                      description: This is accessible behind a feature flag - kubernetes.podspec-persistent-volume-claim
                      type: object
                      x-kubernetes-preserve-unknown-fields: true
                    projected:
                      description: projected items for all in one resources secrets,
                        configmaps, and downward API
                      properties:
                        defaultMode:
                          description: defaultMode are the mode bits used to set permissions
                            on created files by default. Must be an octal value between
                            0000 and 0777 or a decimal value between 0 and 511. YAML
                            accepts both octal and decimal values, JSON requires decimal
                            values for mode bits. Directories within the path are
                            not affected by this setting. This might be in conflict
                            with other options that affect the file mode, like fsGroup,
                            and the result can be other mode bits set.
                          format: int32
                          type: integer
                        sources:
                          description: sources is the list of volume projections
                          items:
                            description: Projection that may be projected along with
                              other supported volume types
                            properties:
                              configMap:
                                description: configMap information about the configMap
                                  data to project
                                properties:
                                  items:
                                    description: items if unspecified, each key-value
                                      pair in the Data field of the referenced ConfigMap
                                      will be projected into the volume as a file
                                      whose name is the key and content is the value.
                                      If specified, the listed keys will be projected
                                      into the specified paths, and unlisted keys
                                      will not be present. If a key is specified which
                                      is not present in the ConfigMap, the volume
                                      setup will error unless it is marked optional.
                                      Paths must be relative and may not contain the
                                      '..' path or start with '..'.
                                    items:
                                      description: Maps a string key to a path within
                                        a volume.
                                      properties:
                                        key:
                                          description: key is the key to project.
                                          type: string
                                        mode:
                                          description: 'mode is Optional: mode bits
                                            used to set permissions on this file.
                                            Must be an octal value between 0000 and
                                            0777 or a decimal value between 0 and
                                            511. YAML accepts both octal and decimal
                                            values, JSON requires decimal values for
                                            mode bits. If not specified, the volume
                                            defaultMode will be used. This might be
                                            in conflict with other options that affect
                                            the file mode, like fsGroup, and the result
                                            can be other mode bits set.'
                                          format: int32
                                          type: integer
                                        path:
                                          description: path is the relative path of
                                            the file to map the key to. May not be
                                            an absolute path. May not contain the
                                            path element '..'. May not start with
                                            the string '..'.
                                          type: string
                                      required:
                                      - key
                                      - path
                                      type: object
                                    type: array
                                  name:
                                    description: 'Name of the referent. More info:
                                      https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
                                      TODO: Add other useful fields. apiVersion, kind,
                                      uid?'
                                    type: string
                                  optional:
                                    description: optional specify whether the ConfigMap
                                      or its keys must be defined
                                    type: boolean
                                type: object
                                x-kubernetes-map-type: atomic
                              secret:
                                description: secret information about the secret data
                                  to project
                                properties:
                                  items:
                                    description: items if unspecified, each key-value
                                      pair in the Data field of the referenced Secret
                                      will be projected into the volume as a file
                                      whose name is the key and content is the value.
                                      If specified, the listed keys will be projected
                                      into the specified paths, and unlisted keys
                                      will not be present. If a key is specified which
                                      is not present in the Secret, the volume setup
                                      will error unless it is marked optional. Paths
                                      must be relative and may not contain the '..'
                                      path or start with '..'.
                                    items:
                                      description: Maps a string key to a path within
                                        a volume.
                                      properties:
                                        key:
                                          description: key is the key to project.
                                          type: string
                                        mode:
                                          description: 'mode is Optional: mode bits
                                            used to set permissions on this file.
                                            Must be an octal value between 0000 and
                                            0777 or a decimal value between 0 and
                                            511. YAML accepts both octal and decimal
                                            values, JSON requires decimal values for
                                            mode bits. If not specified, the volume
                                            defaultMode will be used. This might be
                                            in conflict with other options that affect
                                            the file mode, like fsGroup, and the result
                                            can be other mode bits set.'
                                          format: int32
                                          type: integer
                                        path:
                                          description: path is the relative path of
                                            the file to map the key to. May not be
                                            an absolute path. May not contain the
                                            path element '..'. May not start with
                                            the string '..'.
                                          type: string
                                      required:
                                      - key
                                      - path
                                      type: object
                                    type: array
                                  name:
                                    description: 'Name of the referent. More info:
                                      https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
                                      TODO: Add other useful fields. apiVersion, kind,
                                      uid?'
                                    type: string
                                  optional:
                                    description: optional field specify whether the
                                      Secret or its key must be defined
                                    type: boolean
                                type: object
                                x-kubernetes-map-type: atomic
                              serviceAccountToken:
                                description: serviceAccountToken is information about
                                  the serviceAccountToken data to project
                                properties:
                                  audience:
                                    description: audience is the intended audience
                                      of the token. A recipient of a token must identify
                                      itself with an identifier specified in the audience
                                      of the token, and otherwise should reject the
                                      token. The audience defaults to the identifier
                                      of the apiserver.
                                    type: string
                                  expirationSeconds:
                                    description: expirationSeconds is the requested
                                      duration of validity of the service account
                                      token. As the token approaches expiration, the
                                      kubelet volume plugin will proactively rotate
                                      the service account token. The kubelet will
                                      start trying to rotate the token if the token
                                      is older than 80 percent of its time to live
                                      or if the token is older than 24 hours.Defaults
                                      to 1 hour and must be at least 10 minutes.
                                    format: int64
                                    type: integer
                                  path:
                                    description: path is the path relative to the
                                      mount point of the file to project the token
                                      into.
                                    type: string
                                required:
                                - path
                                type: object
                            type: object
                          type: array
                      type: object
                    secret:
                      description: 'secret represents a secret that should populate
                        this volume. More info: https://kubernetes.io/docs/concepts/storage/volumes#secret'
                      properties:
                        defaultMode:
                          description: 'defaultMode is Optional: mode bits used to
                            set permissions on created files by default. Must be an
                            octal value between 0000 and 0777 or a decimal value between
                            0 and 511. YAML accepts both octal and decimal values,
                            JSON requires decimal values for mode bits. Defaults to
                            0644. Directories within the path are not affected by
                            this setting. This might be in conflict with other options
                            that affect the file mode, like fsGroup, and the result
                            can be other mode bits set.'
                          format: int32
                          type: integer
                        items:
                          description: items If unspecified, each key-value pair in
                            the Data field of the referenced Secret will be projected
                            into the volume as a file whose name is the key and content
                            is the value. If specified, the listed keys will be projected
                            into the specified paths, and unlisted keys will not be
                            present. If a key is specified which is not present in
                            the Secret, the volume setup will error unless it is marked
                            optional. Paths must be relative and may not contain the
                            '..' path or start with '..'.
                          items:
                            description: Maps a string key to a path within a volume.
                            properties:
                              key:
                                description: key is the key to project.
                                type: string
                              mode:
                                description: 'mode is Optional: mode bits used to
                                  set permissions on this file. Must be an octal value
                                  between 0000 and 0777 or a decimal value between
                                  0 and 511. YAML accepts both octal and decimal values,
                                  JSON requires decimal values for mode bits. If not
                                  specified, the volume defaultMode will be used.
                                  This might be in conflict with other options that
                                  affect the file mode, like fsGroup, and the result
                                  can be other mode bits set.'
                                format: int32
                                type: integer
                              path:
                                description: path is the relative path of the file
                                  to map the key to. May not be an absolute path.
                                  May not contain the path element '..'. May not start
                                  with the string '..'.
                                type: string
                            required:
                            - key
                            - path
                            type: object
                          type: array
                        optional:
                          description: optional field specify whether the Secret or
                            its keys must be defined
                          type: boolean
                        secretName:
                          description: 'secretName is the name of the secret in the
                            pod''s namespace to use. More info: https://kubernetes.io/docs/concepts/storage/volumes#secret'
                          type: string
                      type: object
                  required:
                  - name
                  type: object
                type: array
            required:
            - containers
            type: object
          status:
            description: RevisionStatus communicates the observed state of the Revision
              (from the controller).
            properties:
              actualReplicas:
                description: ActualReplicas reflects the amount of ready pods running
                  this revision.
                format: int32
                type: integer
              annotations:
                additionalProperties:
                  type: string
                description: Annotations is additional Status fields for the Resource
                  to save some additional State as well as convey more information
                  to the user. This is roughly akin to Annotations on any k8s resource,
                  just the reconciler conveying richer information outwards.
                type: object
              conditions:
                description: Conditions the latest available observations of a resource's
                  current state.
                items:
                  description: 'Condition defines a readiness condition for a Knative
                    resource. See: https://github.com/kubernetes/community/blob/master/contributors/devel/sig-architecture/api-conventions.md#typical-status-properties'
                  properties:
                    lastTransitionTime:
                      description: LastTransitionTime is the last time the condition
                        transitioned from one status to another. We use VolatileTime
                        in place of metav1.Time to exclude this from creating equality.Semantic
                        differences (all other things held constant).
                      type: string
                    message:
                      description: A human readable message indicating details about
                        the transition.
                      type: string
                    reason:
                      description: The reason for the condition's last transition.
                      type: string
                    severity:
                      description: Severity with which to treat failures of this type
                        of condition. When this is not specified, it defaults to Error.
                      type: string
                    status:
                      description: Status of the condition, one of True, False, Unknown.
                      type: string
                    type:
                      description: Type of condition.
                      type: string
                  required:
                  - status
                  - type
                  type: object
                type: array
              containerStatuses:
                description: 'ContainerStatuses is a slice of images present in .Spec.Container[*].Image
                  to their respective digests and their container name. The digests
                  are resolved during the creation of Revision. ContainerStatuses
                  holds the container name and image digests for both serving and
                  non serving containers. ref: http://bit.ly/image-digests'
                items:
                  description: ContainerStatus holds the information of container
                    name and image digest value
                  properties:
                    imageDigest:
                      type: string
                    name:
                      type: string
                  type: object
                type: array
              desiredReplicas:
                description: DesiredReplicas reflects the desired amount of pods running
                  this revision.
                format: int32
                type: integer
              initContainerStatuses:
                description: 'InitContainerStatuses is a slice of images present in
                  .Spec.InitContainer[*].Image to their respective digests and their
                  container name. The digests are resolved during the creation of
                  Revision. ContainerStatuses holds the container name and image digests
                  for both serving and non serving containers. ref: http://bit.ly/image-digests'
                items:
                  description: ContainerStatus holds the information of container
                    name and image digest value
                  properties:
                    imageDigest:
                      type: string
                    name:
                      type: string
                  type: object
                type: array
              logUrl:
                description: LogURL specifies the generated logging url for this particular
                  revision based on the revision url template specified in the controller's
                  config.
                type: string
              observedGeneration:
                description: ObservedGeneration is the 'Generation' of the Service
                  that was last processed by the controller.
                format: int64
                type: integer
            type: object
        type: object
    served: true
    storage: true
    subresources:
      status: {}
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool]
}

resource "kubectl_manifest" "kubeflow-knative-customresourcedefinition-routes" {
  yaml_body = <<YAML
apiVersion: apiextensions.k8s.io/v1
kind: CustomResourceDefinition
metadata:
  labels:
    app.kubernetes.io/name: knative-serving
    app.kubernetes.io/version: 1.8.0
    duck.knative.dev/addressable: "true"
    knative.dev/crd-install: "true"
  name: routes.serving.knative.dev
spec:
  group: serving.knative.dev
  names:
    categories:
    - all
    - knative
    - serving
    kind: Route
    plural: routes
    shortNames:
    - rt
    singular: route
  scope: Namespaced
  versions:
  - additionalPrinterColumns:
    - jsonPath: .status.url
      name: URL
      type: string
    - jsonPath: .status.conditions[?(@.type=='Ready')].status
      name: Ready
      type: string
    - jsonPath: .status.conditions[?(@.type=='Ready')].reason
      name: Reason
      type: string
    name: v1
    schema:
      openAPIV3Schema:
        description: 'Route is responsible for configuring ingress over a collection
          of Revisions. Some of the Revisions a Route distributes traffic over may
          be specified by referencing the Configuration responsible for creating them;
          in these cases the Route is additionally responsible for monitoring the
          Configuration for "latest ready revision" changes, and smoothly rolling
          out latest revisions. See also: https://github.com/knative/serving/blob/main/docs/spec/overview.md#route'
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
            description: Spec holds the desired state of the Route (from the client).
            properties:
              traffic:
                description: Traffic specifies how to distribute traffic over a collection
                  of revisions and configurations.
                items:
                  description: TrafficTarget holds a single entry of the routing table
                    for a Route.
                  properties:
                    configurationName:
                      description: ConfigurationName of a configuration to whose latest
                        revision we will send this portion of traffic. When the "status.latestReadyRevisionName"
                        of the referenced configuration changes, we will automatically
                        migrate traffic from the prior "latest ready" revision to
                        the new one.  This field is never set in Route's status, only
                        its spec.  This is mutually exclusive with RevisionName.
                      type: string
                    latestRevision:
                      description: LatestRevision may be optionally provided to indicate
                        that the latest ready Revision of the Configuration should
                        be used for this traffic target.  When provided LatestRevision
                        must be true if RevisionName is empty; it must be false when
                        RevisionName is non-empty.
                      type: boolean
                    percent:
                      description: 'Percent indicates that percentage based routing
                        should be used and the value indicates the percent of traffic
                        that is be routed to this Revision or Configuration. `0` (zero)
                        mean no traffic, `100` means all traffic. When percentage
                        based routing is being used the follow rules apply: - the
                        sum of all percent values must equal 100 - when not specified,
                        the implied value for `percent` is zero for that particular
                        Revision or Configuration'
                      format: int64
                      type: integer
                    revisionName:
                      description: RevisionName of a specific revision to which to
                        send this portion of traffic.  This is mutually exclusive
                        with ConfigurationName.
                      type: string
                    tag:
                      description: Tag is optionally used to expose a dedicated url
                        for referencing this target exclusively.
                      type: string
                    url:
                      description: URL displays the URL for accessing named traffic
                        targets. URL is displayed in status, and is disallowed on
                        spec. URL must contain a scheme (e.g. http://) and a hostname,
                        but may not contain anything else (e.g. basic auth, url path,
                        etc.)
                      type: string
                  type: object
                type: array
            type: object
          status:
            description: Status communicates the observed state of the Route (from
              the controller).
            properties:
              address:
                description: Address holds the information needed for a Route to be
                  the target of an event.
                properties:
                  url:
                    type: string
                type: object
              annotations:
                additionalProperties:
                  type: string
                description: Annotations is additional Status fields for the Resource
                  to save some additional State as well as convey more information
                  to the user. This is roughly akin to Annotations on any k8s resource,
                  just the reconciler conveying richer information outwards.
                type: object
              conditions:
                description: Conditions the latest available observations of a resource's
                  current state.
                items:
                  description: 'Condition defines a readiness condition for a Knative
                    resource. See: https://github.com/kubernetes/community/blob/master/contributors/devel/sig-architecture/api-conventions.md#typical-status-properties'
                  properties:
                    lastTransitionTime:
                      description: LastTransitionTime is the last time the condition
                        transitioned from one status to another. We use VolatileTime
                        in place of metav1.Time to exclude this from creating equality.Semantic
                        differences (all other things held constant).
                      type: string
                    message:
                      description: A human readable message indicating details about
                        the transition.
                      type: string
                    reason:
                      description: The reason for the condition's last transition.
                      type: string
                    severity:
                      description: Severity with which to treat failures of this type
                        of condition. When this is not specified, it defaults to Error.
                      type: string
                    status:
                      description: Status of the condition, one of True, False, Unknown.
                      type: string
                    type:
                      description: Type of condition.
                      type: string
                  required:
                  - status
                  - type
                  type: object
                type: array
              observedGeneration:
                description: ObservedGeneration is the 'Generation' of the Service
                  that was last processed by the controller.
                format: int64
                type: integer
              traffic:
                description: Traffic holds the configured traffic distribution. These
                  entries will always contain RevisionName references. When ConfigurationName
                  appears in the spec, this will hold the LatestReadyRevisionName
                  that we last observed.
                items:
                  description: TrafficTarget holds a single entry of the routing table
                    for a Route.
                  properties:
                    configurationName:
                      description: ConfigurationName of a configuration to whose latest
                        revision we will send this portion of traffic. When the "status.latestReadyRevisionName"
                        of the referenced configuration changes, we will automatically
                        migrate traffic from the prior "latest ready" revision to
                        the new one.  This field is never set in Route's status, only
                        its spec.  This is mutually exclusive with RevisionName.
                      type: string
                    latestRevision:
                      description: LatestRevision may be optionally provided to indicate
                        that the latest ready Revision of the Configuration should
                        be used for this traffic target.  When provided LatestRevision
                        must be true if RevisionName is empty; it must be false when
                        RevisionName is non-empty.
                      type: boolean
                    percent:
                      description: 'Percent indicates that percentage based routing
                        should be used and the value indicates the percent of traffic
                        that is be routed to this Revision or Configuration. `0` (zero)
                        mean no traffic, `100` means all traffic. When percentage
                        based routing is being used the follow rules apply: - the
                        sum of all percent values must equal 100 - when not specified,
                        the implied value for `percent` is zero for that particular
                        Revision or Configuration'
                      format: int64
                      type: integer
                    revisionName:
                      description: RevisionName of a specific revision to which to
                        send this portion of traffic.  This is mutually exclusive
                        with ConfigurationName.
                      type: string
                    tag:
                      description: Tag is optionally used to expose a dedicated url
                        for referencing this target exclusively.
                      type: string
                    url:
                      description: URL displays the URL for accessing named traffic
                        targets. URL is displayed in status, and is disallowed on
                        spec. URL must contain a scheme (e.g. http://) and a hostname,
                        but may not contain anything else (e.g. basic auth, url path,
                        etc.)
                      type: string
                  type: object
                type: array
              url:
                description: URL holds the url that will distribute traffic over the
                  provided traffic targets. It generally has the form http[s]://{route-name}.{route-namespace}.{cluster-level-suffix}
                type: string
            type: object
        type: object
    served: true
    storage: true
    subresources:
      status: {}
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool]
}

resource "kubectl_manifest" "kubeflow-knative-customresourcedefinition-serverlessservices" {
  yaml_body = <<YAML
apiVersion: apiextensions.k8s.io/v1
kind: CustomResourceDefinition
metadata:
  labels:
    app.kubernetes.io/component: networking
    app.kubernetes.io/name: knative-serving
    app.kubernetes.io/version: 1.8.0
    knative.dev/crd-install: "true"
  name: serverlessservices.networking.internal.knative.dev
spec:
  group: networking.internal.knative.dev
  names:
    categories:
    - knative-internal
    - networking
    kind: ServerlessService
    plural: serverlessservices
    shortNames:
    - sks
    singular: serverlessservice
  scope: Namespaced
  versions:
  - additionalPrinterColumns:
    - jsonPath: .spec.mode
      name: Mode
      type: string
    - jsonPath: .spec.numActivators
      name: Activators
      type: integer
    - jsonPath: .status.serviceName
      name: ServiceName
      type: string
    - jsonPath: .status.privateServiceName
      name: PrivateServiceName
      type: string
    - jsonPath: .status.conditions[?(@.type=='Ready')].status
      name: Ready
      type: string
    - jsonPath: .status.conditions[?(@.type=='Ready')].reason
      name: Reason
      type: string
    name: v1alpha1
    schema:
      openAPIV3Schema:
        description: 'ServerlessService is a proxy for the K8s service objects containing
          the endpoints for the revision, whether those are endpoints of the activator
          or revision pods. See: https://knative.page.link/naxz for details.'
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
            description: 'Spec is the desired state of the ServerlessService. More
              info: https://github.com/kubernetes/community/blob/master/contributors/devel/sig-architecture/api-conventions.md#spec-and-status'
            properties:
              mode:
                description: Mode describes the mode of operation of the ServerlessService.
                type: string
              numActivators:
                description: NumActivators contains number of Activators that this
                  revision should be assigned. O means — assign all.
                format: int32
                type: integer
              objectRef:
                description: ObjectRef defines the resource that this ServerlessService
                  is responsible for making "serverless".
                properties:
                  apiVersion:
                    description: API version of the referent.
                    type: string
                  fieldPath:
                    description: 'If referring to a piece of an object instead of
                      an entire object, this string should contain a valid JSON/Go
                      field access statement, such as desiredState.manifest.containers[2].
                      For example, if the object reference is to a container within
                      a pod, this would take on a value like: "spec.containers{name}"
                      (where "name" refers to the name of the container that triggered
                      the event) or if no container name is specified "spec.containers[2]"
                      (container with index 2 in this pod). This syntax is chosen
                      only to have some well-defined way of referencing a part of
                      an object. TODO: this design is not final and this field is
                      subject to change in the future.'
                    type: string
                  kind:
                    description: 'Kind of the referent. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds'
                    type: string
                  name:
                    description: 'Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names'
                    type: string
                  namespace:
                    description: 'Namespace of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/'
                    type: string
                  resourceVersion:
                    description: 'Specific resourceVersion to which this reference
                      is made, if any. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#concurrency-control-and-consistency'
                    type: string
                  uid:
                    description: 'UID of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#uids'
                    type: string
                type: object
                x-kubernetes-map-type: atomic
              protocolType:
                description: The application-layer protocol. Matches `RevisionProtocolType`
                  set on the owning pa/revision. serving imports networking, so just
                  use string.
                type: string
            required:
            - objectRef
            - protocolType
            type: object
          status:
            description: 'Status is the current state of the ServerlessService. More
              info: https://github.com/kubernetes/community/blob/master/contributors/devel/sig-architecture/api-conventions.md#spec-and-status'
            properties:
              annotations:
                additionalProperties:
                  type: string
                description: Annotations is additional Status fields for the Resource
                  to save some additional State as well as convey more information
                  to the user. This is roughly akin to Annotations on any k8s resource,
                  just the reconciler conveying richer information outwards.
                type: object
              conditions:
                description: Conditions the latest available observations of a resource's
                  current state.
                items:
                  description: 'Condition defines a readiness condition for a Knative
                    resource. See: https://github.com/kubernetes/community/blob/master/contributors/devel/sig-architecture/api-conventions.md#typical-status-properties'
                  properties:
                    lastTransitionTime:
                      description: LastTransitionTime is the last time the condition
                        transitioned from one status to another. We use VolatileTime
                        in place of metav1.Time to exclude this from creating equality.Semantic
                        differences (all other things held constant).
                      type: string
                    message:
                      description: A human readable message indicating details about
                        the transition.
                      type: string
                    reason:
                      description: The reason for the condition's last transition.
                      type: string
                    severity:
                      description: Severity with which to treat failures of this type
                        of condition. When this is not specified, it defaults to Error.
                      type: string
                    status:
                      description: Status of the condition, one of True, False, Unknown.
                      type: string
                    type:
                      description: Type of condition.
                      type: string
                  required:
                  - status
                  - type
                  type: object
                type: array
              observedGeneration:
                description: ObservedGeneration is the 'Generation' of the Service
                  that was last processed by the controller.
                format: int64
                type: integer
              privateServiceName:
                description: PrivateServiceName holds the name of a core K8s Service
                  resource that load balances over the user service pods backing this
                  Revision.
                type: string
              serviceName:
                description: ServiceName holds the name of a core K8s Service resource
                  that load balances over the pods backing this Revision (activator
                  or revision).
                type: string
            type: object
        type: object
    served: true
    storage: true
    subresources:
      status: {}
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool]
}

resource "kubectl_manifest" "kubeflow-knative-customresourcedefinition-services" {
  yaml_body = <<YAML
apiVersion: apiextensions.k8s.io/v1
kind: CustomResourceDefinition
metadata:
  labels:
    app.kubernetes.io/name: knative-serving
    app.kubernetes.io/version: 1.8.0
    duck.knative.dev/addressable: "true"
    duck.knative.dev/podspecable: "true"
    knative.dev/crd-install: "true"
  name: services.serving.knative.dev
spec:
  group: serving.knative.dev
  names:
    categories:
    - all
    - knative
    - serving
    kind: Service
    plural: services
    shortNames:
    - kservice
    - ksvc
    singular: service
  scope: Namespaced
  versions:
  - additionalPrinterColumns:
    - jsonPath: .status.url
      name: URL
      type: string
    - jsonPath: .status.latestCreatedRevisionName
      name: LatestCreated
      type: string
    - jsonPath: .status.latestReadyRevisionName
      name: LatestReady
      type: string
    - jsonPath: .status.conditions[?(@.type=='Ready')].status
      name: Ready
      type: string
    - jsonPath: .status.conditions[?(@.type=='Ready')].reason
      name: Reason
      type: string
    name: v1
    schema:
      openAPIV3Schema:
        description: "Service acts as a top-level container that manages a Route and
          Configuration which implement a network service. Service exists to provide
          a singular abstraction which can be access controlled, reasoned about, and
          which encapsulates software lifecycle decisions such as rollout policy and
          team resource ownership. Service acts only as an orchestrator of the underlying
          Routes and Configurations (much as a kubernetes Deployment orchestrates
          ReplicaSets), and its usage is optional but recommended. \n The Service's
          controller will track the statuses of its owned Configuration and Route,
          reflecting their statuses and conditions as its own. \n See also: https://github.com/knative/serving/blob/main/docs/spec/overview.md#service"
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
            description: ServiceSpec represents the configuration for the Service
              object. A Service's specification is the union of the specifications
              for a Route and Configuration.  The Service restricts what can be expressed
              in these fields, e.g. the Route must reference the provided Configuration;
              however, these limitations also enable friendlier defaulting, e.g. Route
              never needs a Configuration name, and may be defaulted to the appropriate
              "run latest" spec.
            properties:
              template:
                description: Template holds the latest specification for the Revision
                  to be stamped out.
                properties:
                  metadata:
                    properties:
                      annotations:
                        additionalProperties:
                          type: string
                        type: object
                      finalizers:
                        items:
                          type: string
                        type: array
                      labels:
                        additionalProperties:
                          type: string
                        type: object
                      name:
                        type: string
                      namespace:
                        type: string
                    type: object
                    x-kubernetes-preserve-unknown-fields: true
                  spec:
                    description: RevisionSpec holds the desired state of the Revision
                      (from the client).
                    properties:
                      affinity:
                        description: This is accessible behind a feature flag - kubernetes.podspec-affinity
                        type: object
                        x-kubernetes-preserve-unknown-fields: true
                      automountServiceAccountToken:
                        description: AutomountServiceAccountToken indicates whether
                          a service account token should be automatically mounted.
                        type: boolean
                      containerConcurrency:
                        description: ContainerConcurrency specifies the maximum allowed
                          in-flight (concurrent) requests per container of the Revision.  Defaults
                          to `0` which means concurrency to the application is not
                          limited, and the system decides the target concurrency for
                          the autoscaler.
                        format: int64
                        type: integer
                      containers:
                        description: List of containers belonging to the pod. Containers
                          cannot currently be added or removed. There must be at least
                          one container in a Pod. Cannot be updated.
                        items:
                          description: A single application container that you want
                            to run within a pod.
                          properties:
                            args:
                              description: 'Arguments to the entrypoint. The container
                                image''s CMD is used if this is not provided. Variable
                                references $(VAR_NAME) are expanded using the container''s
                                environment. If a variable cannot be resolved, the
                                reference in the input string will be unchanged. Double
                                $$ are reduced to a single $, which allows for escaping
                                the $(VAR_NAME) syntax: i.e. "$$(VAR_NAME)" will produce
                                the string literal "$(VAR_NAME)". Escaped references
                                will never be expanded, regardless of whether the
                                variable exists or not. Cannot be updated. More info:
                                https://kubernetes.io/docs/tasks/inject-data-application/define-command-argument-container/#running-a-command-in-a-shell'
                              items:
                                type: string
                              type: array
                            command:
                              description: 'Entrypoint array. Not executed within
                                a shell. The container image''s ENTRYPOINT is used
                                if this is not provided. Variable references $(VAR_NAME)
                                are expanded using the container''s environment. If
                                a variable cannot be resolved, the reference in the
                                input string will be unchanged. Double $$ are reduced
                                to a single $, which allows for escaping the $(VAR_NAME)
                                syntax: i.e. "$$(VAR_NAME)" will produce the string
                                literal "$(VAR_NAME)". Escaped references will never
                                be expanded, regardless of whether the variable exists
                                or not. Cannot be updated. More info: https://kubernetes.io/docs/tasks/inject-data-application/define-command-argument-container/#running-a-command-in-a-shell'
                              items:
                                type: string
                              type: array
                            env:
                              description: List of environment variables to set in
                                the container. Cannot be updated.
                              items:
                                description: EnvVar represents an environment variable
                                  present in a Container.
                                properties:
                                  name:
                                    description: Name of the environment variable.
                                      Must be a C_IDENTIFIER.
                                    type: string
                                  value:
                                    description: 'Variable references $(VAR_NAME)
                                      are expanded using the previously defined environment
                                      variables in the container and any service environment
                                      variables. If a variable cannot be resolved,
                                      the reference in the input string will be unchanged.
                                      Double $$ are reduced to a single $, which allows
                                      for escaping the $(VAR_NAME) syntax: i.e. "$$(VAR_NAME)"
                                      will produce the string literal "$(VAR_NAME)".
                                      Escaped references will never be expanded, regardless
                                      of whether the variable exists or not. Defaults
                                      to "".'
                                    type: string
                                  valueFrom:
                                    description: Source for the environment variable's
                                      value. Cannot be used if value is not empty.
                                    properties:
                                      configMapKeyRef:
                                        description: Selects a key of a ConfigMap.
                                        properties:
                                          key:
                                            description: The key to select.
                                            type: string
                                          name:
                                            description: 'Name of the referent. More
                                              info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
                                              TODO: Add other useful fields. apiVersion,
                                              kind, uid?'
                                            type: string
                                          optional:
                                            description: Specify whether the ConfigMap
                                              or its key must be defined
                                            type: boolean
                                        required:
                                        - key
                                        type: object
                                        x-kubernetes-map-type: atomic
                                      fieldRef:
                                        description: This is accessible behind a feature
                                          flag - kubernetes.podspec-fieldref
                                        type: object
                                        x-kubernetes-map-type: atomic
                                        x-kubernetes-preserve-unknown-fields: true
                                      resourceFieldRef:
                                        description: This is accessible behind a feature
                                          flag - kubernetes.podspec-fieldref
                                        type: object
                                        x-kubernetes-map-type: atomic
                                        x-kubernetes-preserve-unknown-fields: true
                                      secretKeyRef:
                                        description: Selects a key of a secret in
                                          the pod's namespace
                                        properties:
                                          key:
                                            description: The key of the secret to
                                              select from.  Must be a valid secret
                                              key.
                                            type: string
                                          name:
                                            description: 'Name of the referent. More
                                              info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
                                              TODO: Add other useful fields. apiVersion,
                                              kind, uid?'
                                            type: string
                                          optional:
                                            description: Specify whether the Secret
                                              or its key must be defined
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
                              description: List of sources to populate environment
                                variables in the container. The keys defined within
                                a source must be a C_IDENTIFIER. All invalid keys
                                will be reported as an event when the container is
                                starting. When a key exists in multiple sources, the
                                value associated with the last source will take precedence.
                                Values defined by an Env with a duplicate key will
                                take precedence. Cannot be updated.
                              items:
                                description: EnvFromSource represents the source of
                                  a set of ConfigMaps
                                properties:
                                  configMapRef:
                                    description: The ConfigMap to select from
                                    properties:
                                      name:
                                        description: 'Name of the referent. More info:
                                          https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
                                          TODO: Add other useful fields. apiVersion,
                                          kind, uid?'
                                        type: string
                                      optional:
                                        description: Specify whether the ConfigMap
                                          must be defined
                                        type: boolean
                                    type: object
                                    x-kubernetes-map-type: atomic
                                  prefix:
                                    description: An optional identifier to prepend
                                      to each key in the ConfigMap. Must be a C_IDENTIFIER.
                                    type: string
                                  secretRef:
                                    description: The Secret to select from
                                    properties:
                                      name:
                                        description: 'Name of the referent. More info:
                                          https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
                                          TODO: Add other useful fields. apiVersion,
                                          kind, uid?'
                                        type: string
                                      optional:
                                        description: Specify whether the Secret must
                                          be defined
                                        type: boolean
                                    type: object
                                    x-kubernetes-map-type: atomic
                                type: object
                              type: array
                            image:
                              description: 'Container image name. More info: https://kubernetes.io/docs/concepts/containers/images
                                This field is optional to allow higher level config
                                management to default or override container images
                                in workload controllers like Deployments and StatefulSets.'
                              type: string
                            imagePullPolicy:
                              description: 'Image pull policy. One of Always, Never,
                                IfNotPresent. Defaults to Always if :latest tag is
                                specified, or IfNotPresent otherwise. Cannot be updated.
                                More info: https://kubernetes.io/docs/concepts/containers/images#updating-images'
                              type: string
                            livenessProbe:
                              description: 'Periodic probe of container liveness.
                                Container will be restarted if the probe fails. Cannot
                                be updated. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes'
                              properties:
                                exec:
                                  description: Exec specifies the action to take.
                                  properties:
                                    command:
                                      description: Command is the command line to
                                        execute inside the container, the working
                                        directory for the command  is root ('/') in
                                        the container's filesystem. The command is
                                        simply exec'd, it is not run inside a shell,
                                        so traditional shell instructions ('|', etc)
                                        won't work. To use a shell, you need to explicitly
                                        call out to that shell. Exit status of 0 is
                                        treated as live/healthy and non-zero is unhealthy.
                                      items:
                                        type: string
                                      type: array
                                  type: object
                                failureThreshold:
                                  description: Minimum consecutive failures for the
                                    probe to be considered failed after having succeeded.
                                    Defaults to 3. Minimum value is 1.
                                  format: int32
                                  type: integer
                                httpGet:
                                  description: HTTPGet specifies the http request
                                    to perform.
                                  properties:
                                    host:
                                      description: Host name to connect to, defaults
                                        to the pod IP. You probably want to set "Host"
                                        in httpHeaders instead.
                                      type: string
                                    httpHeaders:
                                      description: Custom headers to set in the request.
                                        HTTP allows repeated headers.
                                      items:
                                        description: HTTPHeader describes a custom
                                          header to be used in HTTP probes
                                        properties:
                                          name:
                                            description: The header field name
                                            type: string
                                          value:
                                            description: The header field value
                                            type: string
                                        required:
                                        - name
                                        - value
                                        type: object
                                      type: array
                                    path:
                                      description: Path to access on the HTTP server.
                                      type: string
                                    port:
                                      anyOf:
                                      - type: integer
                                      - type: string
                                      description: Name or number of the port to access
                                        on the container. Number must be in the range
                                        1 to 65535. Name must be an IANA_SVC_NAME.
                                      x-kubernetes-int-or-string: true
                                    scheme:
                                      description: Scheme to use for connecting to
                                        the host. Defaults to HTTP.
                                      type: string
                                  type: object
                                initialDelaySeconds:
                                  description: 'Number of seconds after the container
                                    has started before liveness probes are initiated.
                                    More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes'
                                  format: int32
                                  type: integer
                                periodSeconds:
                                  description: How often (in seconds) to perform the
                                    probe.
                                  format: int32
                                  type: integer
                                successThreshold:
                                  description: Minimum consecutive successes for the
                                    probe to be considered successful after having
                                    failed. Defaults to 1. Must be 1 for liveness
                                    and startup. Minimum value is 1.
                                  format: int32
                                  type: integer
                                tcpSocket:
                                  description: TCPSocket specifies an action involving
                                    a TCP port.
                                  properties:
                                    host:
                                      description: 'Optional: Host name to connect
                                        to, defaults to the pod IP.'
                                      type: string
                                    port:
                                      anyOf:
                                      - type: integer
                                      - type: string
                                      description: Number or name of the port to access
                                        on the container. Number must be in the range
                                        1 to 65535. Name must be an IANA_SVC_NAME.
                                      x-kubernetes-int-or-string: true
                                  type: object
                                timeoutSeconds:
                                  description: 'Number of seconds after which the
                                    probe times out. Defaults to 1 second. Minimum
                                    value is 1. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes'
                                  format: int32
                                  type: integer
                              type: object
                            name:
                              description: Name of the container specified as a DNS_LABEL.
                                Each container in a pod must have a unique name (DNS_LABEL).
                                Cannot be updated.
                              type: string
                            ports:
                              description: List of ports to expose from the container.
                                Not specifying a port here DOES NOT prevent that port
                                from being exposed. Any port which is listening on
                                the default "0.0.0.0" address inside a container will
                                be accessible from the network. Modifying this array
                                with strategic merge patch may corrupt the data. For
                                more information See https://github.com/kubernetes/kubernetes/issues/108255.
                                Cannot be updated.
                              items:
                                description: ContainerPort represents a network port
                                  in a single container.
                                properties:
                                  containerPort:
                                    description: Number of port to expose on the pod's
                                      IP address. This must be a valid port number,
                                      0 < x < 65536.
                                    format: int32
                                    type: integer
                                  name:
                                    description: If specified, this must be an IANA_SVC_NAME
                                      and unique within the pod. Each named port in
                                      a pod must have a unique name. Name for the
                                      port that can be referred to by services.
                                    type: string
                                  protocol:
                                    default: TCP
                                    description: Protocol for port. Must be UDP, TCP,
                                      or SCTP. Defaults to "TCP".
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
                              description: 'Periodic probe of container service readiness.
                                Container will be removed from service endpoints if
                                the probe fails. Cannot be updated. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes'
                              properties:
                                exec:
                                  description: Exec specifies the action to take.
                                  properties:
                                    command:
                                      description: Command is the command line to
                                        execute inside the container, the working
                                        directory for the command  is root ('/') in
                                        the container's filesystem. The command is
                                        simply exec'd, it is not run inside a shell,
                                        so traditional shell instructions ('|', etc)
                                        won't work. To use a shell, you need to explicitly
                                        call out to that shell. Exit status of 0 is
                                        treated as live/healthy and non-zero is unhealthy.
                                      items:
                                        type: string
                                      type: array
                                  type: object
                                failureThreshold:
                                  description: Minimum consecutive failures for the
                                    probe to be considered failed after having succeeded.
                                    Defaults to 3. Minimum value is 1.
                                  format: int32
                                  type: integer
                                httpGet:
                                  description: HTTPGet specifies the http request
                                    to perform.
                                  properties:
                                    host:
                                      description: Host name to connect to, defaults
                                        to the pod IP. You probably want to set "Host"
                                        in httpHeaders instead.
                                      type: string
                                    httpHeaders:
                                      description: Custom headers to set in the request.
                                        HTTP allows repeated headers.
                                      items:
                                        description: HTTPHeader describes a custom
                                          header to be used in HTTP probes
                                        properties:
                                          name:
                                            description: The header field name
                                            type: string
                                          value:
                                            description: The header field value
                                            type: string
                                        required:
                                        - name
                                        - value
                                        type: object
                                      type: array
                                    path:
                                      description: Path to access on the HTTP server.
                                      type: string
                                    port:
                                      anyOf:
                                      - type: integer
                                      - type: string
                                      description: Name or number of the port to access
                                        on the container. Number must be in the range
                                        1 to 65535. Name must be an IANA_SVC_NAME.
                                      x-kubernetes-int-or-string: true
                                    scheme:
                                      description: Scheme to use for connecting to
                                        the host. Defaults to HTTP.
                                      type: string
                                  type: object
                                initialDelaySeconds:
                                  description: 'Number of seconds after the container
                                    has started before liveness probes are initiated.
                                    More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes'
                                  format: int32
                                  type: integer
                                periodSeconds:
                                  description: How often (in seconds) to perform the
                                    probe.
                                  format: int32
                                  type: integer
                                successThreshold:
                                  description: Minimum consecutive successes for the
                                    probe to be considered successful after having
                                    failed. Defaults to 1. Must be 1 for liveness
                                    and startup. Minimum value is 1.
                                  format: int32
                                  type: integer
                                tcpSocket:
                                  description: TCPSocket specifies an action involving
                                    a TCP port.
                                  properties:
                                    host:
                                      description: 'Optional: Host name to connect
                                        to, defaults to the pod IP.'
                                      type: string
                                    port:
                                      anyOf:
                                      - type: integer
                                      - type: string
                                      description: Number or name of the port to access
                                        on the container. Number must be in the range
                                        1 to 65535. Name must be an IANA_SVC_NAME.
                                      x-kubernetes-int-or-string: true
                                  type: object
                                timeoutSeconds:
                                  description: 'Number of seconds after which the
                                    probe times out. Defaults to 1 second. Minimum
                                    value is 1. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes'
                                  format: int32
                                  type: integer
                              type: object
                            resources:
                              description: 'Compute Resources required by this container.
                                Cannot be updated. More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/'
                              properties:
                                limits:
                                  additionalProperties:
                                    anyOf:
                                    - type: integer
                                    - type: string
                                    pattern: ^(\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))))?$
                                    x-kubernetes-int-or-string: true
                                  description: 'Limits describes the maximum amount
                                    of compute resources allowed. More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/'
                                  type: object
                                requests:
                                  additionalProperties:
                                    anyOf:
                                    - type: integer
                                    - type: string
                                    pattern: ^(\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))))?$
                                    x-kubernetes-int-or-string: true
                                  description: 'Requests describes the minimum amount
                                    of compute resources required. If Requests is
                                    omitted for a container, it defaults to Limits
                                    if that is explicitly specified, otherwise to
                                    an implementation-defined value. More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/'
                                  type: object
                              type: object
                            securityContext:
                              description: 'SecurityContext defines the security options
                                the container should be run with. If set, the fields
                                of SecurityContext override the equivalent fields
                                of PodSecurityContext. More info: https://kubernetes.io/docs/tasks/configure-pod-container/security-context/'
                              properties:
                                allowPrivilegeEscalation:
                                  description: 'AllowPrivilegeEscalation controls
                                    whether a process can gain more privileges than
                                    its parent process. This bool directly controls
                                    if the no_new_privs flag will be set on the container
                                    process. AllowPrivilegeEscalation is true always
                                    when the container is: 1) run as Privileged 2)
                                    has CAP_SYS_ADMIN Note that this field cannot
                                    be set when spec.os.name is windows.'
                                  type: boolean
                                capabilities:
                                  description: The capabilities to add/drop when running
                                    containers. Defaults to the default set of capabilities
                                    granted by the container runtime. Note that this
                                    field cannot be set when spec.os.name is windows.
                                  properties:
                                    add:
                                      description: This is accessible behind a feature
                                        flag - kubernetes.containerspec-addcapabilities
                                      items:
                                        description: Capability represent POSIX capabilities
                                          type
                                        type: string
                                      type: array
                                    drop:
                                      description: Removed capabilities
                                      items:
                                        description: Capability represent POSIX capabilities
                                          type
                                        type: string
                                      type: array
                                  type: object
                                readOnlyRootFilesystem:
                                  description: Whether this container has a read-only
                                    root filesystem. Default is false. Note that this
                                    field cannot be set when spec.os.name is windows.
                                  type: boolean
                                runAsGroup:
                                  description: The GID to run the entrypoint of the
                                    container process. Uses runtime default if unset.
                                    May also be set in PodSecurityContext.  If set
                                    in both SecurityContext and PodSecurityContext,
                                    the value specified in SecurityContext takes precedence.
                                    Note that this field cannot be set when spec.os.name
                                    is windows.
                                  format: int64
                                  type: integer
                                runAsNonRoot:
                                  description: Indicates that the container must run
                                    as a non-root user. If true, the Kubelet will
                                    validate the image at runtime to ensure that it
                                    does not run as UID 0 (root) and fail to start
                                    the container if it does. If unset or false, no
                                    such validation will be performed. May also be
                                    set in PodSecurityContext.  If set in both SecurityContext
                                    and PodSecurityContext, the value specified in
                                    SecurityContext takes precedence.
                                  type: boolean
                                runAsUser:
                                  description: The UID to run the entrypoint of the
                                    container process. Defaults to user specified
                                    in image metadata if unspecified. May also be
                                    set in PodSecurityContext.  If set in both SecurityContext
                                    and PodSecurityContext, the value specified in
                                    SecurityContext takes precedence. Note that this
                                    field cannot be set when spec.os.name is windows.
                                  format: int64
                                  type: integer
                              type: object
                            terminationMessagePath:
                              description: 'Optional: Path at which the file to which
                                the container''s termination message will be written
                                is mounted into the container''s filesystem. Message
                                written is intended to be brief final status, such
                                as an assertion failure message. Will be truncated
                                by the node if greater than 4096 bytes. The total
                                message length across all containers will be limited
                                to 12kb. Defaults to /dev/termination-log. Cannot
                                be updated.'
                              type: string
                            terminationMessagePolicy:
                              description: Indicate how the termination message should
                                be populated. File will use the contents of terminationMessagePath
                                to populate the container status message on both success
                                and failure. FallbackToLogsOnError will use the last
                                chunk of container log output if the termination message
                                file is empty and the container exited with an error.
                                The log output is limited to 2048 bytes or 80 lines,
                                whichever is smaller. Defaults to File. Cannot be
                                updated.
                              type: string
                            volumeMounts:
                              description: Pod volumes to mount into the container's
                                filesystem. Cannot be updated.
                              items:
                                description: VolumeMount describes a mounting of a
                                  Volume within a container.
                                properties:
                                  mountPath:
                                    description: Path within the container at which
                                      the volume should be mounted.  Must not contain
                                      ':'.
                                    type: string
                                  name:
                                    description: This must match the Name of a Volume.
                                    type: string
                                  readOnly:
                                    description: Mounted read-only if true, read-write
                                      otherwise (false or unspecified). Defaults to
                                      false.
                                    type: boolean
                                  subPath:
                                    description: Path within the volume from which
                                      the container's volume should be mounted. Defaults
                                      to "" (volume's root).
                                    type: string
                                required:
                                - mountPath
                                - name
                                type: object
                              type: array
                            workingDir:
                              description: Container's working directory. If not specified,
                                the container runtime's default will be used, which
                                might be configured in the container image. Cannot
                                be updated.
                              type: string
                          type: object
                        type: array
                      dnsConfig:
                        description: This is accessible behind a feature flag - kubernetes.podspec-dnsconfig
                        type: object
                        x-kubernetes-preserve-unknown-fields: true
                      dnsPolicy:
                        description: This is accessible behind a feature flag - kubernetes.podspec-dnspolicy
                        type: string
                      enableServiceLinks:
                        description: 'EnableServiceLinks indicates whether information
                          about services should be injected into pod''s environment
                          variables, matching the syntax of Docker links. Optional:
                          Knative defaults this to false.'
                        type: boolean
                      hostAliases:
                        description: This is accessible behind a feature flag - kubernetes.podspec-hostaliases
                        items:
                          description: This is accessible behind a feature flag -
                            kubernetes.podspec-hostaliases
                          type: object
                          x-kubernetes-preserve-unknown-fields: true
                        type: array
                      idleTimeoutSeconds:
                        description: IdleTimeoutSeconds is the maximum duration in
                          seconds a request will be allowed to stay open while not
                          receiving any bytes from the user's application. If unspecified,
                          a system default will be provided.
                        format: int64
                        type: integer
                      imagePullSecrets:
                        description: 'ImagePullSecrets is an optional list of references
                          to secrets in the same namespace to use for pulling any
                          of the images used by this PodSpec. If specified, these
                          secrets will be passed to individual puller implementations
                          for them to use. More info: https://kubernetes.io/docs/concepts/containers/images#specifying-imagepullsecrets-on-a-pod'
                        items:
                          description: LocalObjectReference contains enough information
                            to let you locate the referenced object inside the same
                            namespace.
                          properties:
                            name:
                              description: 'Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
                                TODO: Add other useful fields. apiVersion, kind, uid?'
                              type: string
                          type: object
                          x-kubernetes-map-type: atomic
                        type: array
                      initContainers:
                        description: 'List of initialization containers belonging
                          to the pod. Init containers are executed in order prior
                          to containers being started. If any init container fails,
                          the pod is considered to have failed and is handled according
                          to its restartPolicy. The name for an init container or
                          normal container must be unique among all containers. Init
                          containers may not have Lifecycle actions, Readiness probes,
                          Liveness probes, or Startup probes. The resourceRequirements
                          of an init container are taken into account during scheduling
                          by finding the highest request/limit for each resource type,
                          and then using the max of of that value or the sum of the
                          normal containers. Limits are applied to init containers
                          in a similar fashion. Init containers cannot currently be
                          added or removed. Cannot be updated. More info: https://kubernetes.io/docs/concepts/workloads/pods/init-containers/'
                        items:
                          description: This is accessible behind a feature flag -
                            kubernetes.podspec-init-containers
                          type: object
                          x-kubernetes-preserve-unknown-fields: true
                        type: array
                      nodeSelector:
                        description: This is accessible behind a feature flag - kubernetes.podspec-nodeselector
                        type: object
                        x-kubernetes-map-type: atomic
                        x-kubernetes-preserve-unknown-fields: true
                      priorityClassName:
                        description: This is accessible behind a feature flag - kubernetes.podspec-priorityclassname
                        type: string
                        x-kubernetes-preserve-unknown-fields: true
                      responseStartTimeoutSeconds:
                        description: ResponseStartTimeoutSeconds is the maximum duration
                          in seconds that the request routing layer will wait for
                          a request delivered to a container to begin sending any
                          network traffic.
                        format: int64
                        type: integer
                      runtimeClassName:
                        description: This is accessible behind a feature flag - kubernetes.podspec-runtimeclassname
                        type: string
                        x-kubernetes-preserve-unknown-fields: true
                      schedulerName:
                        description: This is accessible behind a feature flag - kubernetes.podspec-schedulername
                        type: string
                        x-kubernetes-preserve-unknown-fields: true
                      securityContext:
                        description: This is accessible behind a feature flag - kubernetes.podspec-securitycontext
                        type: object
                        x-kubernetes-preserve-unknown-fields: true
                      serviceAccountName:
                        description: 'ServiceAccountName is the name of the ServiceAccount
                          to use to run this pod. More info: https://kubernetes.io/docs/tasks/configure-pod-container/configure-service-account/'
                        type: string
                      timeoutSeconds:
                        description: TimeoutSeconds is the maximum duration in seconds
                          that the request instance is allowed to respond to a request.
                          If unspecified, a system default will be provided.
                        format: int64
                        type: integer
                      tolerations:
                        description: This is accessible behind a feature flag - kubernetes.podspec-tolerations
                        items:
                          description: This is accessible behind a feature flag -
                            kubernetes.podspec-tolerations
                          type: object
                          x-kubernetes-preserve-unknown-fields: true
                        type: array
                      topologySpreadConstraints:
                        description: This is accessible behind a feature flag - kubernetes.podspec-topologyspreadconstraints
                        items:
                          description: This is accessible behind a feature flag -
                            kubernetes.podspec-topologyspreadconstraints
                          type: object
                          x-kubernetes-preserve-unknown-fields: true
                        type: array
                      volumes:
                        description: 'List of volumes that can be mounted by containers
                          belonging to the pod. More info: https://kubernetes.io/docs/concepts/storage/volumes'
                        items:
                          description: Volume represents a named volume in a pod that
                            may be accessed by any container in the pod.
                          properties:
                            configMap:
                              description: configMap represents a configMap that should
                                populate this volume
                              properties:
                                defaultMode:
                                  description: 'defaultMode is optional: mode bits
                                    used to set permissions on created files by default.
                                    Must be an octal value between 0000 and 0777 or
                                    a decimal value between 0 and 511. YAML accepts
                                    both octal and decimal values, JSON requires decimal
                                    values for mode bits. Defaults to 0644. Directories
                                    within the path are not affected by this setting.
                                    This might be in conflict with other options that
                                    affect the file mode, like fsGroup, and the result
                                    can be other mode bits set.'
                                  format: int32
                                  type: integer
                                items:
                                  description: items if unspecified, each key-value
                                    pair in the Data field of the referenced ConfigMap
                                    will be projected into the volume as a file whose
                                    name is the key and content is the value. If specified,
                                    the listed keys will be projected into the specified
                                    paths, and unlisted keys will not be present.
                                    If a key is specified which is not present in
                                    the ConfigMap, the volume setup will error unless
                                    it is marked optional. Paths must be relative
                                    and may not contain the '..' path or start with
                                    '..'.
                                  items:
                                    description: Maps a string key to a path within
                                      a volume.
                                    properties:
                                      key:
                                        description: key is the key to project.
                                        type: string
                                      mode:
                                        description: 'mode is Optional: mode bits
                                          used to set permissions on this file. Must
                                          be an octal value between 0000 and 0777
                                          or a decimal value between 0 and 511. YAML
                                          accepts both octal and decimal values, JSON
                                          requires decimal values for mode bits. If
                                          not specified, the volume defaultMode will
                                          be used. This might be in conflict with
                                          other options that affect the file mode,
                                          like fsGroup, and the result can be other
                                          mode bits set.'
                                        format: int32
                                        type: integer
                                      path:
                                        description: path is the relative path of
                                          the file to map the key to. May not be an
                                          absolute path. May not contain the path
                                          element '..'. May not start with the string
                                          '..'.
                                        type: string
                                    required:
                                    - key
                                    - path
                                    type: object
                                  type: array
                                name:
                                  description: 'Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
                                    TODO: Add other useful fields. apiVersion, kind,
                                    uid?'
                                  type: string
                                optional:
                                  description: optional specify whether the ConfigMap
                                    or its keys must be defined
                                  type: boolean
                              type: object
                              x-kubernetes-map-type: atomic
                            emptyDir:
                              description: This is accessible behind a feature flag
                                - kubernetes.podspec-emptydir
                              type: object
                              x-kubernetes-preserve-unknown-fields: true
                            name:
                              description: 'name of the volume. Must be a DNS_LABEL
                                and unique within the pod. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names'
                              type: string
                            persistentVolumeClaim:
                              description: This is accessible behind a feature flag
                                - kubernetes.podspec-persistent-volume-claim
                              type: object
                              x-kubernetes-preserve-unknown-fields: true
                            projected:
                              description: projected items for all in one resources
                                secrets, configmaps, and downward API
                              properties:
                                defaultMode:
                                  description: defaultMode are the mode bits used
                                    to set permissions on created files by default.
                                    Must be an octal value between 0000 and 0777 or
                                    a decimal value between 0 and 511. YAML accepts
                                    both octal and decimal values, JSON requires decimal
                                    values for mode bits. Directories within the path
                                    are not affected by this setting. This might be
                                    in conflict with other options that affect the
                                    file mode, like fsGroup, and the result can be
                                    other mode bits set.
                                  format: int32
                                  type: integer
                                sources:
                                  description: sources is the list of volume projections
                                  items:
                                    description: Projection that may be projected
                                      along with other supported volume types
                                    properties:
                                      configMap:
                                        description: configMap information about the
                                          configMap data to project
                                        properties:
                                          items:
                                            description: items if unspecified, each
                                              key-value pair in the Data field of
                                              the referenced ConfigMap will be projected
                                              into the volume as a file whose name
                                              is the key and content is the value.
                                              If specified, the listed keys will be
                                              projected into the specified paths,
                                              and unlisted keys will not be present.
                                              If a key is specified which is not present
                                              in the ConfigMap, the volume setup will
                                              error unless it is marked optional.
                                              Paths must be relative and may not contain
                                              the '..' path or start with '..'.
                                            items:
                                              description: Maps a string key to a
                                                path within a volume.
                                              properties:
                                                key:
                                                  description: key is the key to project.
                                                  type: string
                                                mode:
                                                  description: 'mode is Optional:
                                                    mode bits used to set permissions
                                                    on this file. Must be an octal
                                                    value between 0000 and 0777 or
                                                    a decimal value between 0 and
                                                    511. YAML accepts both octal and
                                                    decimal values, JSON requires
                                                    decimal values for mode bits.
                                                    If not specified, the volume defaultMode
                                                    will be used. This might be in
                                                    conflict with other options that
                                                    affect the file mode, like fsGroup,
                                                    and the result can be other mode
                                                    bits set.'
                                                  format: int32
                                                  type: integer
                                                path:
                                                  description: path is the relative
                                                    path of the file to map the key
                                                    to. May not be an absolute path.
                                                    May not contain the path element
                                                    '..'. May not start with the string
                                                    '..'.
                                                  type: string
                                              required:
                                              - key
                                              - path
                                              type: object
                                            type: array
                                          name:
                                            description: 'Name of the referent. More
                                              info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
                                              TODO: Add other useful fields. apiVersion,
                                              kind, uid?'
                                            type: string
                                          optional:
                                            description: optional specify whether
                                              the ConfigMap or its keys must be defined
                                            type: boolean
                                        type: object
                                        x-kubernetes-map-type: atomic
                                      secret:
                                        description: secret information about the
                                          secret data to project
                                        properties:
                                          items:
                                            description: items if unspecified, each
                                              key-value pair in the Data field of
                                              the referenced Secret will be projected
                                              into the volume as a file whose name
                                              is the key and content is the value.
                                              If specified, the listed keys will be
                                              projected into the specified paths,
                                              and unlisted keys will not be present.
                                              If a key is specified which is not present
                                              in the Secret, the volume setup will
                                              error unless it is marked optional.
                                              Paths must be relative and may not contain
                                              the '..' path or start with '..'.
                                            items:
                                              description: Maps a string key to a
                                                path within a volume.
                                              properties:
                                                key:
                                                  description: key is the key to project.
                                                  type: string
                                                mode:
                                                  description: 'mode is Optional:
                                                    mode bits used to set permissions
                                                    on this file. Must be an octal
                                                    value between 0000 and 0777 or
                                                    a decimal value between 0 and
                                                    511. YAML accepts both octal and
                                                    decimal values, JSON requires
                                                    decimal values for mode bits.
                                                    If not specified, the volume defaultMode
                                                    will be used. This might be in
                                                    conflict with other options that
                                                    affect the file mode, like fsGroup,
                                                    and the result can be other mode
                                                    bits set.'
                                                  format: int32
                                                  type: integer
                                                path:
                                                  description: path is the relative
                                                    path of the file to map the key
                                                    to. May not be an absolute path.
                                                    May not contain the path element
                                                    '..'. May not start with the string
                                                    '..'.
                                                  type: string
                                              required:
                                              - key
                                              - path
                                              type: object
                                            type: array
                                          name:
                                            description: 'Name of the referent. More
                                              info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
                                              TODO: Add other useful fields. apiVersion,
                                              kind, uid?'
                                            type: string
                                          optional:
                                            description: optional field specify whether
                                              the Secret or its key must be defined
                                            type: boolean
                                        type: object
                                        x-kubernetes-map-type: atomic
                                      serviceAccountToken:
                                        description: serviceAccountToken is information
                                          about the serviceAccountToken data to project
                                        properties:
                                          audience:
                                            description: audience is the intended
                                              audience of the token. A recipient of
                                              a token must identify itself with an
                                              identifier specified in the audience
                                              of the token, and otherwise should reject
                                              the token. The audience defaults to
                                              the identifier of the apiserver.
                                            type: string
                                          expirationSeconds:
                                            description: expirationSeconds is the
                                              requested duration of validity of the
                                              service account token. As the token
                                              approaches expiration, the kubelet volume
                                              plugin will proactively rotate the service
                                              account token. The kubelet will start
                                              trying to rotate the token if the token
                                              is older than 80 percent of its time
                                              to live or if the token is older than
                                              24 hours.Defaults to 1 hour and must
                                              be at least 10 minutes.
                                            format: int64
                                            type: integer
                                          path:
                                            description: path is the path relative
                                              to the mount point of the file to project
                                              the token into.
                                            type: string
                                        required:
                                        - path
                                        type: object
                                    type: object
                                  type: array
                              type: object
                            secret:
                              description: 'secret represents a secret that should
                                populate this volume. More info: https://kubernetes.io/docs/concepts/storage/volumes#secret'
                              properties:
                                defaultMode:
                                  description: 'defaultMode is Optional: mode bits
                                    used to set permissions on created files by default.
                                    Must be an octal value between 0000 and 0777 or
                                    a decimal value between 0 and 511. YAML accepts
                                    both octal and decimal values, JSON requires decimal
                                    values for mode bits. Defaults to 0644. Directories
                                    within the path are not affected by this setting.
                                    This might be in conflict with other options that
                                    affect the file mode, like fsGroup, and the result
                                    can be other mode bits set.'
                                  format: int32
                                  type: integer
                                items:
                                  description: items If unspecified, each key-value
                                    pair in the Data field of the referenced Secret
                                    will be projected into the volume as a file whose
                                    name is the key and content is the value. If specified,
                                    the listed keys will be projected into the specified
                                    paths, and unlisted keys will not be present.
                                    If a key is specified which is not present in
                                    the Secret, the volume setup will error unless
                                    it is marked optional. Paths must be relative
                                    and may not contain the '..' path or start with
                                    '..'.
                                  items:
                                    description: Maps a string key to a path within
                                      a volume.
                                    properties:
                                      key:
                                        description: key is the key to project.
                                        type: string
                                      mode:
                                        description: 'mode is Optional: mode bits
                                          used to set permissions on this file. Must
                                          be an octal value between 0000 and 0777
                                          or a decimal value between 0 and 511. YAML
                                          accepts both octal and decimal values, JSON
                                          requires decimal values for mode bits. If
                                          not specified, the volume defaultMode will
                                          be used. This might be in conflict with
                                          other options that affect the file mode,
                                          like fsGroup, and the result can be other
                                          mode bits set.'
                                        format: int32
                                        type: integer
                                      path:
                                        description: path is the relative path of
                                          the file to map the key to. May not be an
                                          absolute path. May not contain the path
                                          element '..'. May not start with the string
                                          '..'.
                                        type: string
                                    required:
                                    - key
                                    - path
                                    type: object
                                  type: array
                                optional:
                                  description: optional field specify whether the
                                    Secret or its keys must be defined
                                  type: boolean
                                secretName:
                                  description: 'secretName is the name of the secret
                                    in the pod''s namespace to use. More info: https://kubernetes.io/docs/concepts/storage/volumes#secret'
                                  type: string
                              type: object
                          required:
                          - name
                          type: object
                        type: array
                    required:
                    - containers
                    type: object
                type: object
              traffic:
                description: Traffic specifies how to distribute traffic over a collection
                  of revisions and configurations.
                items:
                  description: TrafficTarget holds a single entry of the routing table
                    for a Route.
                  properties:
                    configurationName:
                      description: ConfigurationName of a configuration to whose latest
                        revision we will send this portion of traffic. When the "status.latestReadyRevisionName"
                        of the referenced configuration changes, we will automatically
                        migrate traffic from the prior "latest ready" revision to
                        the new one.  This field is never set in Route's status, only
                        its spec.  This is mutually exclusive with RevisionName.
                      type: string
                    latestRevision:
                      description: LatestRevision may be optionally provided to indicate
                        that the latest ready Revision of the Configuration should
                        be used for this traffic target.  When provided LatestRevision
                        must be true if RevisionName is empty; it must be false when
                        RevisionName is non-empty.
                      type: boolean
                    percent:
                      description: 'Percent indicates that percentage based routing
                        should be used and the value indicates the percent of traffic
                        that is be routed to this Revision or Configuration. `0` (zero)
                        mean no traffic, `100` means all traffic. When percentage
                        based routing is being used the follow rules apply: - the
                        sum of all percent values must equal 100 - when not specified,
                        the implied value for `percent` is zero for that particular
                        Revision or Configuration'
                      format: int64
                      type: integer
                    revisionName:
                      description: RevisionName of a specific revision to which to
                        send this portion of traffic.  This is mutually exclusive
                        with ConfigurationName.
                      type: string
                    tag:
                      description: Tag is optionally used to expose a dedicated url
                        for referencing this target exclusively.
                      type: string
                    url:
                      description: URL displays the URL for accessing named traffic
                        targets. URL is displayed in status, and is disallowed on
                        spec. URL must contain a scheme (e.g. http://) and a hostname,
                        but may not contain anything else (e.g. basic auth, url path,
                        etc.)
                      type: string
                  type: object
                type: array
            type: object
          status:
            description: ServiceStatus represents the Status stanza of the Service
              resource.
            properties:
              address:
                description: Address holds the information needed for a Route to be
                  the target of an event.
                properties:
                  url:
                    type: string
                type: object
              annotations:
                additionalProperties:
                  type: string
                description: Annotations is additional Status fields for the Resource
                  to save some additional State as well as convey more information
                  to the user. This is roughly akin to Annotations on any k8s resource,
                  just the reconciler conveying richer information outwards.
                type: object
              conditions:
                description: Conditions the latest available observations of a resource's
                  current state.
                items:
                  description: 'Condition defines a readiness condition for a Knative
                    resource. See: https://github.com/kubernetes/community/blob/master/contributors/devel/sig-architecture/api-conventions.md#typical-status-properties'
                  properties:
                    lastTransitionTime:
                      description: LastTransitionTime is the last time the condition
                        transitioned from one status to another. We use VolatileTime
                        in place of metav1.Time to exclude this from creating equality.Semantic
                        differences (all other things held constant).
                      type: string
                    message:
                      description: A human readable message indicating details about
                        the transition.
                      type: string
                    reason:
                      description: The reason for the condition's last transition.
                      type: string
                    severity:
                      description: Severity with which to treat failures of this type
                        of condition. When this is not specified, it defaults to Error.
                      type: string
                    status:
                      description: Status of the condition, one of True, False, Unknown.
                      type: string
                    type:
                      description: Type of condition.
                      type: string
                  required:
                  - status
                  - type
                  type: object
                type: array
              latestCreatedRevisionName:
                description: LatestCreatedRevisionName is the last revision that was
                  created from this Configuration. It might not be ready yet, for
                  that use LatestReadyRevisionName.
                type: string
              latestReadyRevisionName:
                description: LatestReadyRevisionName holds the name of the latest
                  Revision stamped out from this Configuration that has had its "Ready"
                  condition become "True".
                type: string
              observedGeneration:
                description: ObservedGeneration is the 'Generation' of the Service
                  that was last processed by the controller.
                format: int64
                type: integer
              traffic:
                description: Traffic holds the configured traffic distribution. These
                  entries will always contain RevisionName references. When ConfigurationName
                  appears in the spec, this will hold the LatestReadyRevisionName
                  that we last observed.
                items:
                  description: TrafficTarget holds a single entry of the routing table
                    for a Route.
                  properties:
                    configurationName:
                      description: ConfigurationName of a configuration to whose latest
                        revision we will send this portion of traffic. When the "status.latestReadyRevisionName"
                        of the referenced configuration changes, we will automatically
                        migrate traffic from the prior "latest ready" revision to
                        the new one.  This field is never set in Route's status, only
                        its spec.  This is mutually exclusive with RevisionName.
                      type: string
                    latestRevision:
                      description: LatestRevision may be optionally provided to indicate
                        that the latest ready Revision of the Configuration should
                        be used for this traffic target.  When provided LatestRevision
                        must be true if RevisionName is empty; it must be false when
                        RevisionName is non-empty.
                      type: boolean
                    percent:
                      description: 'Percent indicates that percentage based routing
                        should be used and the value indicates the percent of traffic
                        that is be routed to this Revision or Configuration. `0` (zero)
                        mean no traffic, `100` means all traffic. When percentage
                        based routing is being used the follow rules apply: - the
                        sum of all percent values must equal 100 - when not specified,
                        the implied value for `percent` is zero for that particular
                        Revision or Configuration'
                      format: int64
                      type: integer
                    revisionName:
                      description: RevisionName of a specific revision to which to
                        send this portion of traffic.  This is mutually exclusive
                        with ConfigurationName.
                      type: string
                    tag:
                      description: Tag is optionally used to expose a dedicated url
                        for referencing this target exclusively.
                      type: string
                    url:
                      description: URL displays the URL for accessing named traffic
                        targets. URL is displayed in status, and is disallowed on
                        spec. URL must contain a scheme (e.g. http://) and a hostname,
                        but may not contain anything else (e.g. basic auth, url path,
                        etc.)
                      type: string
                  type: object
                type: array
              url:
                description: URL holds the url that will distribute traffic over the
                  provided traffic targets. It generally has the form http[s]://{route-name}.{route-namespace}.{cluster-level-suffix}
                type: string
            type: object
        type: object
    served: true
    storage: true
    subresources:
      status: {}
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool]
}

resource "kubectl_manifest" "kubeflow-knative-serviceaccount-controller" {
  yaml_body = <<YAML
apiVersion: v1
kind: ServiceAccount
metadata:
  labels:
    app.kubernetes.io/component: controller
    app.kubernetes.io/name: knative-serving
    app.kubernetes.io/version: 1.8.0
  name: controller
  namespace: knative-serving
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool, kubectl_manifest.kubeflow-knative-namespace]
}

resource "kubectl_manifest" "kubeflow-knative-clusterrole-addressable-resolver" {
  yaml_body = <<YAML
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  labels:
    app.kubernetes.io/name: knative-serving
    app.kubernetes.io/version: 1.8.0
    duck.knative.dev/addressable: "true"
  name: knative-serving-addressable-resolver
rules:
- apiGroups:
  - serving.knative.dev
  resources:
  - routes
  - routes/status
  - services
  - services/status
  verbs:
  - get
  - list
  - watch
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool, kubectl_manifest.kubeflow-knative-namespace]
}

resource "kubectl_manifest" "kubeflow-knative-clusterrole-admin" {
  yaml_body = <<YAML
aggregationRule:
  clusterRoleSelectors:
  - matchLabels:
      serving.knative.dev/controller: "true"
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  labels:
    app.kubernetes.io/name: knative-serving
    app.kubernetes.io/version: 1.8.0
  name: knative-serving-admin
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool, kubectl_manifest.kubeflow-knative-namespace]
}

resource "kubectl_manifest" "kubeflow-knative-clusterrole-aggregated-addressable-resolver" {
  yaml_body = <<YAML
aggregationRule:
  clusterRoleSelectors:
  - matchLabels:
      duck.knative.dev/addressable: "true"
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  labels:
    app.kubernetes.io/name: knative-serving
    app.kubernetes.io/version: 1.8.0
  name: knative-serving-aggregated-addressable-resolver
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool, kubectl_manifest.kubeflow-knative-namespace]
}

resource "kubectl_manifest" "kubeflow-knative-clusterrole-core" {
  yaml_body = <<YAML
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  labels:
    app.kubernetes.io/name: knative-serving
    app.kubernetes.io/version: 1.8.0
    serving.knative.dev/controller: "true"
  name: knative-serving-core
rules:
- apiGroups:
  - ""
  resources:
  - pods
  - namespaces
  - secrets
  - configmaps
  - endpoints
  - services
  - events
  - serviceaccounts
  verbs:
  - get
  - list
  - create
  - update
  - delete
  - patch
  - watch
- apiGroups:
  - ""
  resources:
  - endpoints/restricted
  verbs:
  - create
- apiGroups:
  - ""
  resources:
  - namespaces/finalizers
  verbs:
  - update
- apiGroups:
  - apps
  resources:
  - deployments
  - deployments/finalizers
  verbs:
  - get
  - list
  - create
  - update
  - delete
  - patch
  - watch
- apiGroups:
  - admissionregistration.k8s.io
  resources:
  - mutatingwebhookconfigurations
  - validatingwebhookconfigurations
  verbs:
  - get
  - list
  - create
  - update
  - delete
  - patch
  - watch
- apiGroups:
  - apiextensions.k8s.io
  resources:
  - customresourcedefinitions
  - customresourcedefinitions/status
  verbs:
  - get
  - list
  - create
  - update
  - delete
  - patch
  - watch
- apiGroups:
  - autoscaling
  resources:
  - horizontalpodautoscalers
  verbs:
  - get
  - list
  - create
  - update
  - delete
  - patch
  - watch
- apiGroups:
  - coordination.k8s.io
  resources:
  - leases
  verbs:
  - get
  - list
  - create
  - update
  - delete
  - patch
  - watch
- apiGroups:
  - serving.knative.dev
  - autoscaling.internal.knative.dev
  - networking.internal.knative.dev
  resources:
  - '*'
  - '*/status'
  - '*/finalizers'
  verbs:
  - get
  - list
  - create
  - update
  - delete
  - deletecollection
  - patch
  - watch
- apiGroups:
  - caching.internal.knative.dev
  resources:
  - images
  verbs:
  - get
  - list
  - create
  - update
  - delete
  - patch
  - watch
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool, kubectl_manifest.kubeflow-knative-namespace]
}

resource "kubectl_manifest" "kubeflow-knative-clusterrole-istio" {
  yaml_body = <<YAML
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  labels:
    app.kubernetes.io/component: net-istio
    app.kubernetes.io/name: knative-serving
    app.kubernetes.io/version: 1.8.0
    networking.knative.dev/ingress-provider: istio
    serving.knative.dev/controller: "true"
  name: knative-serving-istio
rules:
- apiGroups:
  - networking.istio.io
  resources:
  - virtualservices
  - gateways
  - destinationrules
  verbs:
  - get
  - list
  - create
  - update
  - delete
  - patch
  - watch
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool, kubectl_manifest.kubeflow-knative-namespace]
}

resource "kubectl_manifest" "kubeflow-knative-clusterrole-namespaced-admin" {
  yaml_body = <<YAML
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  labels:
    app.kubernetes.io/name: knative-serving
    app.kubernetes.io/version: 1.8.0
    rbac.authorization.k8s.io/aggregate-to-admin: "true"
    rbac.authorization.kubeflow.org/aggregate-to-kubeflow-admin: "true"
  name: knative-serving-namespaced-admin
rules:
- apiGroups:
  - serving.knative.dev
  resources:
  - '*'
  verbs:
  - '*'
- apiGroups:
  - networking.internal.knative.dev
  - autoscaling.internal.knative.dev
  - caching.internal.knative.dev
  resources:
  - '*'
  verbs:
  - get
  - list
  - watch
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool, kubectl_manifest.kubeflow-knative-namespace]
}

resource "kubectl_manifest" "kubeflow-knative-clusterrole-namespaced-edit" {
  yaml_body = <<YAML
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  labels:
    app.kubernetes.io/name: knative-serving
    app.kubernetes.io/version: 1.8.0
    rbac.authorization.k8s.io/aggregate-to-edit: "true"
    rbac.authorization.kubeflow.org/aggregate-to-kubeflow-edit: "true"
  name: knative-serving-namespaced-edit
rules:
- apiGroups:
  - serving.knative.dev
  resources:
  - '*'
  verbs:
  - create
  - update
  - patch
  - delete
- apiGroups:
  - networking.internal.knative.dev
  - autoscaling.internal.knative.dev
  - caching.internal.knative.dev
  resources:
  - '*'
  verbs:
  - get
  - list
  - watch
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool, kubectl_manifest.kubeflow-knative-namespace]
}

resource "kubectl_manifest" "kubeflow-knative-clusterrole-namespaced-view" {
  yaml_body = <<YAML
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  labels:
    app.kubernetes.io/name: knative-serving
    app.kubernetes.io/version: 1.8.0
    rbac.authorization.k8s.io/aggregate-to-view: "true"
    rbac.authorization.kubeflow.org/aggregate-to-kubeflow-view: "true"
  name: knative-serving-namespaced-view
rules:
- apiGroups:
  - serving.knative.dev
  - networking.internal.knative.dev
  - autoscaling.internal.knative.dev
  - caching.internal.knative.dev
  resources:
  - '*'
  verbs:
  - get
  - list
  - watch
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool, kubectl_manifest.kubeflow-knative-namespace]
}

resource "kubectl_manifest" "kubeflow-knative-clusterrole-podspecable-binding" {
  yaml_body = <<YAML
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  labels:
    app.kubernetes.io/name: knative-serving
    app.kubernetes.io/version: 1.8.0
    duck.knative.dev/podspecable: "true"
  name: knative-serving-podspecable-binding
rules:
- apiGroups:
  - serving.knative.dev
  resources:
  - configurations
  - services
  verbs:
  - list
  - watch
  - patch
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool, kubectl_manifest.kubeflow-knative-namespace]
}

resource "kubectl_manifest" "kubeflow-knative-clusterrolebinding-controller-addressable-resolver" {
  yaml_body = <<YAML
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  labels:
    app.kubernetes.io/component: controller
    app.kubernetes.io/name: knative-serving
    app.kubernetes.io/version: 1.8.0
  name: knative-serving-controller-addressable-resolver
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: knative-serving-aggregated-addressable-resolver
subjects:
- kind: ServiceAccount
  name: controller
  namespace: knative-serving
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool, kubectl_manifest.kubeflow-knative-namespace]
}

resource "kubectl_manifest" "kubeflow-knative-clusterrolebinding-controller-admin" {
  yaml_body = <<YAML
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  labels:
    app.kubernetes.io/component: controller
    app.kubernetes.io/name: knative-serving
    app.kubernetes.io/version: 1.8.0
  name: knative-serving-controller-admin
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: knative-serving-admin
subjects:
- kind: ServiceAccount
  name: controller
  namespace: knative-serving
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool, kubectl_manifest.kubeflow-knative-namespace]
}

resource "kubectl_manifest" "kubeflow-knative-configmap-config-autoscaler" {
  yaml_body = <<YAML
apiVersion: v1
data:
  _example: |
    ################################
    #                              #
    #    EXAMPLE CONFIGURATION     #
    #                              #
    ################################

    # This block is not actually functional configuration,
    # but serves to illustrate the available configuration
    # options and document them in a way that is accessible
    # to users that `kubectl edit` this config map.
    #
    # These sample configuration options may be copied out of
    # this example block and unindented to be in the data block
    # to actually change the configuration.

    # The Revision ContainerConcurrency field specifies the maximum number
    # of requests the Container can handle at once. Container concurrency
    # target percentage is how much of that maximum to use in a stable
    # state. E.g. if a Revision specifies ContainerConcurrency of 10, then
    # the Autoscaler will try to maintain 7 concurrent connections per pod
    # on average.
    # Note: this limit will be applied to container concurrency set at every
    # level (ConfigMap, Revision Spec or Annotation).
    # For legacy and backwards compatibility reasons, this value also accepts
    # fractional values in (0, 1] interval (i.e. 0.7 ⇒ 70%).
    # Thus minimal percentage value must be greater than 1.0, or it will be
    # treated as a fraction.
    # NOTE: that this value does not affect actual number of concurrent requests
    #       the user container may receive, but only the average number of requests
    #       that the revision pods will receive.
    container-concurrency-target-percentage: "70"

    # The container concurrency target default is what the Autoscaler will
    # try to maintain when concurrency is used as the scaling metric for the
    # Revision and the Revision specifies unlimited concurrency.
    # When revision explicitly specifies container concurrency, that value
    # will be used as a scaling target for autoscaler.
    # When specifying unlimited concurrency, the autoscaler will
    # horizontally scale the application based on this target concurrency.
    # This is what we call "soft limit" in the documentation, i.e. it only
    # affects number of pods and does not affect the number of requests
    # individual pod processes.
    # The value must be a positive number such that the value multiplied
    # by container-concurrency-target-percentage is greater than 0.01.
    # NOTE: that this value will be adjusted by application of
    #       container-concurrency-target-percentage, i.e. by default
    #       the system will target on average 70 concurrent requests
    #       per revision pod.
    # NOTE: Only one metric can be used for autoscaling a Revision.
    container-concurrency-target-default: "100"

    # The requests per second (RPS) target default is what the Autoscaler will
    # try to maintain when RPS is used as the scaling metric for a Revision and
    # the Revision specifies unlimited RPS. Even when specifying unlimited RPS,
    # the autoscaler will horizontally scale the application based on this
    # target RPS.
    # Must be greater than 1.0.
    # NOTE: Only one metric can be used for autoscaling a Revision.
    requests-per-second-target-default: "200"

    # The target burst capacity specifies the size of burst in concurrent
    # requests that the system operator expects the system will receive.
    # Autoscaler will try to protect the system from queueing by introducing
    # Activator in the request path if the current spare capacity of the
    # service is less than this setting.
    # If this setting is 0, then Activator will be in the request path only
    # when the revision is scaled to 0.
    # If this setting is > 0 and container-concurrency-target-percentage is
    # 100% or 1.0, then activator will always be in the request path.
    # -1 denotes unlimited target-burst-capacity and activator will always
    # be in the request path.
    # Other negative values are invalid.
    target-burst-capacity: "211"

    # When operating in a stable mode, the autoscaler operates on the
    # average concurrency over the stable window.
    # Stable window must be in whole seconds.
    stable-window: "60s"

    # When observed average concurrency during the panic window reaches
    # panic-threshold-percentage the target concurrency, the autoscaler
    # enters panic mode. When operating in panic mode, the autoscaler
    # scales on the average concurrency over the panic window which is
    # panic-window-percentage of the stable-window.
    # Must be in the [1, 100] range.
    # When computing the panic window it will be rounded to the closest
    # whole second, at least 1s.
    panic-window-percentage: "10.0"

    # The percentage of the container concurrency target at which to
    # enter panic mode when reached within the panic window.
    panic-threshold-percentage: "200.0"

    # Max scale up rate limits the rate at which the autoscaler will
    # increase pod count. It is the maximum ratio of desired pods versus
    # observed pods.
    # Cannot be less or equal to 1.
    # I.e with value of 2.0 the number of pods can at most go N to 2N
    # over single Autoscaler period (2s), but at least N to
    # N+1, if Autoscaler needs to scale up.
    max-scale-up-rate: "1000.0"

    # Max scale down rate limits the rate at which the autoscaler will
    # decrease pod count. It is the maximum ratio of observed pods versus
    # desired pods.
    # Cannot be less or equal to 1.
    # I.e. with value of 2.0 the number of pods can at most go N to N/2
    # over single Autoscaler evaluation period (2s), but at
    # least N to N-1, if Autoscaler needs to scale down.
    max-scale-down-rate: "2.0"

    # Scale to zero feature flag.
    enable-scale-to-zero: "true"

    # Scale to zero grace period is the time an inactive revision is left
    # running before it is scaled to zero (must be positive, but recommended
    # at least a few seconds if running with mesh networking).
    # This is the upper limit and is provided not to enforce timeout after
    # the revision stopped receiving requests for stable window, but to
    # ensure network reprogramming to put activator in the path has completed.
    # If the system determines that a shorter period is satisfactory,
    # then the system will only wait that amount of time before scaling to 0.
    # NOTE: this period might actually be 0, if activator has been
    # in the request path sufficiently long.
    # If there is necessity for the last pod to linger longer use
    # scale-to-zero-pod-retention-period flag.
    scale-to-zero-grace-period: "30s"

    # Scale to zero pod retention period defines the minimum amount
    # of time the last pod will remain after Autoscaler has decided to
    # scale to zero.
    # This flag is for the situations where the pod startup is very expensive
    # and the traffic is bursty (requiring smaller windows for fast action),
    # but patchy.
    # The larger of this flag and `scale-to-zero-grace-period` will effectively
    # determine how the last pod will hang around.
    scale-to-zero-pod-retention-period: "0s"

    # pod-autoscaler-class specifies the default pod autoscaler class
    # that should be used if none is specified. If omitted,
    # the Knative Pod Autoscaler (KPA) is used by default.
    pod-autoscaler-class: "kpa.autoscaling.knative.dev"

    # The capacity of a single activator task.
    # The `unit` is one concurrent request proxied by the activator.
    # activator-capacity must be at least 1.
    # This value is used for computation of the Activator subset size.
    # See the algorithm here: http://bit.ly/38XiCZ3.
    # TODO(vagababov): tune after actual benchmarking.
    activator-capacity: "100.0"

    # initial-scale is the cluster-wide default value for the initial target
    # scale of a revision after creation, unless overridden by the
    # "autoscaling.knative.dev/initialScale" annotation.
    # This value must be greater than 0 unless allow-zero-initial-scale is true.
    initial-scale: "1"

    # allow-zero-initial-scale controls whether either the cluster-wide initial-scale flag,
    # or the "autoscaling.knative.dev/initialScale" annotation, can be set to 0.
    allow-zero-initial-scale: "false"

    # min-scale is the cluster-wide default value for the min scale of a revision,
    # unless overridden by the "autoscaling.knative.dev/minScale" annotation.
    min-scale: "0"

    # max-scale is the cluster-wide default value for the max scale of a revision,
    # unless overridden by the "autoscaling.knative.dev/maxScale" annotation.
    # If set to 0, the revision has no maximum scale.
    max-scale: "0"

    # scale-down-delay is the amount of time that must pass at reduced
    # concurrency before a scale down decision is applied. This can be useful,
    # for example, to maintain replica count and avoid a cold start penalty if
    # more requests come in within the scale down delay period.
    # The default, 0s, imposes no delay at all.
    scale-down-delay: "0s"

    # max-scale-limit sets the maximum permitted value for the max scale of a revision.
    # When this is set to a positive value, a revision with a maxScale above that value
    # (including a maxScale of "0" = unlimited) is disallowed.
    # A value of zero (the default) allows any limit, including unlimited.
    max-scale-limit: "0"
kind: ConfigMap
metadata:
  annotations:
    knative.dev/example-checksum: 47c2487f
  labels:
    app.kubernetes.io/component: autoscaler
    app.kubernetes.io/name: knative-serving
    app.kubernetes.io/version: 1.8.0
  name: config-autoscaler
  namespace: knative-serving
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool, kubectl_manifest.kubeflow-knative-namespace]
}

resource "kubectl_manifest" "kubeflow-knative-configmap-config-default" {
  yaml_body = <<YAML
apiVersion: v1
data:
  _example: |
    ################################
    #                              #
    #    EXAMPLE CONFIGURATION     #
    #                              #
    ################################

    # This block is not actually functional configuration,
    # but serves to illustrate the available configuration
    # options and document them in a way that is accessible
    # to users that `kubectl edit` this config map.
    #
    # These sample configuration options may be copied out of
    # this example block and unindented to be in the data block
    # to actually change the configuration.

    # revision-timeout-seconds contains the default number of
    # seconds to use for the revision's per-request timeout, if
    # none is specified.
    revision-timeout-seconds: "300"  # 5 minutes

    # max-revision-timeout-seconds contains the maximum number of
    # seconds that can be used for revision-timeout-seconds.
    # This value must be greater than or equal to revision-timeout-seconds.
    # If omitted, the system default is used (600 seconds).
    #
    # If this value is increased, the activator's terminationGraceTimeSeconds
    # should also be increased to prevent in-flight requests being disrupted.
    max-revision-timeout-seconds: "600"  # 10 minutes

    # revision-response-start-timeout-seconds contains the default number of
    # seconds a request will be allowed to stay open while waiting to
    # receive any bytes from the user's application, if none is specified.
    #
    # This defaults to 'revision-timeout-seconds'
    revision-response-start-timeout-seconds: "300"

    # revision-idle-timeout-seconds contains the default number of
    # seconds a request will be allowed to stay open while not receiving any
    # bytes from the user's application, if none is specified.
    revision-idle-timeout-seconds: "0"  # infinite

    # revision-cpu-request contains the cpu allocation to assign
    # to revisions by default.  If omitted, no value is specified
    # and the system default is used.
    # Below is an example of setting revision-cpu-request.
    # By default, it is not set by Knative.
    revision-cpu-request: "400m"  # 0.4 of a CPU (aka 400 milli-CPU)

    # revision-memory-request contains the memory allocation to assign
    # to revisions by default.  If omitted, no value is specified
    # and the system default is used.
    # Below is an example of setting revision-memory-request.
    # By default, it is not set by Knative.
    revision-memory-request: "100M"  # 100 megabytes of memory

    # revision-ephemeral-storage-request contains the ephemeral storage
    # allocation to assign to revisions by default.  If omitted, no value is
    # specified and the system default is used.
    revision-ephemeral-storage-request: "500M"  # 500 megabytes of storage

    # revision-cpu-limit contains the cpu allocation to limit
    # revisions to by default.  If omitted, no value is specified
    # and the system default is used.
    # Below is an example of setting revision-cpu-limit.
    # By default, it is not set by Knative.
    revision-cpu-limit: "1000m"  # 1 CPU (aka 1000 milli-CPU)

    # revision-memory-limit contains the memory allocation to limit
    # revisions to by default.  If omitted, no value is specified
    # and the system default is used.
    # Below is an example of setting revision-memory-limit.
    # By default, it is not set by Knative.
    revision-memory-limit: "200M"  # 200 megabytes of memory

    # revision-ephemeral-storage-limit contains the ephemeral storage
    # allocation to limit revisions to by default.  If omitted, no value is
    # specified and the system default is used.
    revision-ephemeral-storage-limit: "750M"  # 750 megabytes of storage

    # container-name-template contains a template for the default
    # container name, if none is specified.  This field supports
    # Go templating and is supplied with the ObjectMeta of the
    # enclosing Service or Configuration, so values such as
    # {{.Name}} are also valid.
    container-name-template: "user-container"

    # init-container-name-template contains a template for the default
    # init container name, if none is specified.  This field supports
    # Go templating and is supplied with the ObjectMeta of the
    # enclosing Service or Configuration, so values such as
    # {{.Name}} are also valid.
    init-container-name-template: "init-container"

    # container-concurrency specifies the maximum number
    # of requests the Container can handle at once, and requests
    # above this threshold are queued.  Setting a value of zero
    # disables this throttling and lets through as many requests as
    # the pod receives.
    container-concurrency: "0"

    # The container concurrency max limit is an operator setting ensuring that
    # the individual revisions cannot have arbitrary large concurrency
    # values, or autoscaling targets. `container-concurrency` default setting
    # must be at or below this value.
    #
    # Must be greater than 1.
    #
    # Note: even with this set, a user can choose a containerConcurrency
    # of 0 (i.e. unbounded) unless allow-container-concurrency-zero is
    # set to "false".
    container-concurrency-max-limit: "1000"

    # allow-container-concurrency-zero controls whether users can
    # specify 0 (i.e. unbounded) for containerConcurrency.
    allow-container-concurrency-zero: "true"

    # enable-service-links specifies the default value used for the
    # enableServiceLinks field of the PodSpec, when it is omitted by the user.
    # See: https://kubernetes.io/docs/concepts/services-networking/connect-applications-service/#accessing-the-service
    #
    # This is a tri-state flag with possible values of (true|false|default).
    #
    # In environments with large number of services it is suggested
    # to set this value to `false`.
    # See https://github.com/knative/serving/issues/8498.
    enable-service-links: "false"
kind: ConfigMap
metadata:
  annotations:
    knative.dev/example-checksum: e7973912
  labels:
    app.kubernetes.io/component: controller
    app.kubernetes.io/name: knative-serving
    app.kubernetes.io/version: 1.8.0
  name: config-defaults
  namespace: knative-serving
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool, kubectl_manifest.kubeflow-knative-namespace]
}

resource "kubectl_manifest" "kubeflow-knative-configmap-config-deployment" {
  yaml_body = <<YAML
apiVersion: v1
data:
  _example: |-
    ################################
    #                              #
    #    EXAMPLE CONFIGURATION     #
    #                              #
    ################################

    # This block is not actually functional configuration,
    # but serves to illustrate the available configuration
    # options and document them in a way that is accessible
    # to users that `kubectl edit` this config map.
    #
    # These sample configuration options may be copied out of
    # this example block and unindented to be in the data block
    # to actually change the configuration.

    # List of repositories for which tag to digest resolving should be skipped
    registries-skipping-tag-resolving: "kind.local,ko.local,dev.local"

    # Maximum time allowed for an image's digests to be resolved.
    digest-resolution-timeout: "10s"

    # Duration we wait for the deployment to be ready before considering it failed.
    progress-deadline: "600s"

    # Sets the queue proxy's CPU request.
    # If omitted, a default value (currently "25m"), is used.
    queue-sidecar-cpu-request: "25m"

    # Sets the queue proxy's CPU limit.
    # If omitted, no value is specified and the system default is used.
    queue-sidecar-cpu-limit: "1000m"

    # Sets the queue proxy's memory request.
    # If omitted, no value is specified and the system default is used.
    queue-sidecar-memory-request: "400Mi"

    # Sets the queue proxy's memory limit.
    # If omitted, no value is specified and the system default is used.
    queue-sidecar-memory-limit: "800Mi"

    # Sets the queue proxy's ephemeral storage request.
    # If omitted, no value is specified and the system default is used.
    queue-sidecar-ephemeral-storage-request: "512Mi"

    # Sets the queue proxy's ephemeral storage limit.
    # If omitted, no value is specified and the system default is used.
    queue-sidecar-ephemeral-storage-limit: "1024Mi"

    # The freezer service endpoint that queue-proxy calls when its traffic drops to zero or
    # scales up from zero.
    #
    # Freezer service is available at: https://github.com/knative-sandbox/container-freezer
    # or users may write their own service.
    #
    # The value will need to include both the host and the port that will be accessed.
    # For the host, $HOST_IP can be passed, and the appropriate host IP value will be swapped
    # in at runtime, which will enable the freezer daemonset to be reachable via the node IP.
    #
    # As an example:
    #     concurrency-state-endpoint: "http://$HOST_IP:9696"
    #
    # If not set, queue proxy takes no action (this is the default behavior).
    #
    # When enabled, a serviceAccountToken will be mounted to queue-proxy using
    # a projected volume. This requires the Service Account Token Volume Projection feature
    # to be enabled. For details, see this link:
    # https://kubernetes.io/docs/tasks/configure-pod-container/configure-service-account/#service-account-token-volume-projection
    #
    # NOTE THAT THIS IS AN EXPERIMENTAL / ALPHA FEATURE
    concurrency-state-endpoint: ""
  progressDeadline: 600s
  queue-sidecar-image: gcr.io/knative-releases/knative.dev/serving/cmd/queue@sha256:505179c0c4892ea4a70e78bc52ac21b03cd7f1a763d2ecc78e7bbaa1ae59c86c
kind: ConfigMap
metadata:
  annotations:
    knative.dev/example-checksum: dd7ee769
  labels:
    app.kubernetes.io/component: controller
    app.kubernetes.io/name: knative-serving
    app.kubernetes.io/version: 1.8.0
  name: config-deployment
  namespace: knative-serving
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool, kubectl_manifest.kubeflow-knative-namespace,kubectl_manifest.kubeflow-istio-deployment-istiod, kubectl_manifest.kubeflow-istio-mutatingwebhookconfiguration-sidecar-injector]
}

resource "kubectl_manifest" "kubeflow-knative-configmap-config-domain" {
  yaml_body = <<YAML
apiVersion: v1
data:
  _example: |
    ################################
    #                              #
    #    EXAMPLE CONFIGURATION     #
    #                              #
    ################################

    # This block is not actually functional configuration,
    # but serves to illustrate the available configuration
    # options and document them in a way that is accessible
    # to users that `kubectl edit` this config map.
    #
    # These sample configuration options may be copied out of
    # this example block and unindented to be in the data block
    # to actually change the configuration.

    # Default value for domain.
    # Routes having the cluster domain suffix (by default 'svc.cluster.local')
    # will not be exposed through Ingress. You can define your own label
    # selector to assign that domain suffix to your Route here, or you can set
    # the label
    #    "networking.knative.dev/visibility=cluster-local"
    # to achieve the same effect.  This shows how to make routes having
    # the label app=secret only exposed to the local cluster.
    svc.cluster.local: |
      selector:
        app: secret

    # These are example settings of domain.
    # example.com will be used for all routes, but it is the least-specific rule so it
    # will only be used if no other domain matches.
    example.com: |

    # example.org will be used for routes having app=nonprofit.
    example.org: |
      selector:
        app: nonprofit
kind: ConfigMap
metadata:
  annotations:
    knative.dev/example-checksum: 26c09de5
  labels:
    app.kubernetes.io/component: controller
    app.kubernetes.io/name: knative-serving
    app.kubernetes.io/version: 1.8.0
  name: config-domain
  namespace: knative-serving
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool, kubectl_manifest.kubeflow-knative-namespace]
}

resource "kubectl_manifest" "kubeflow-knative-configmap-config-features" {
  yaml_body = <<YAML
apiVersion: v1
data:
  _example: |-
    ################################
    #                              #
    #    EXAMPLE CONFIGURATION     #
    #                              #
    ################################

    # This block is not actually functional configuration,
    # but serves to illustrate the available configuration
    # options and document them in a way that is accessible
    # to users that `kubectl edit` this config map.
    #
    # These sample configuration options may be copied out of
    # this example block and unindented to be in the data block
    # to actually change the configuration.

    # Indicates whether multi container support is enabled
    #
    # WARNING: Cannot safely be disabled once enabled.
    # See: https://knative.dev/docs/serving/feature-flags/#multi-containers
    multi-container: "enabled"

    # Indicates whether Kubernetes affinity support is enabled
    #
    # WARNING: Cannot safely be disabled once enabled.
    # See: https://knative.dev/docs/serving/feature-flags/#kubernetes-node-affinity
    kubernetes.podspec-affinity: "disabled"

    # Indicates whether Kubernetes topologySpreadConstraints support is enabled
    #
    # WARNING: Cannot safely be disabled once enabled.
    # See: https://knative.dev/docs/serving/feature-flags/#kubernetes-topology-spread-constraints
    kubernetes.podspec-topologyspreadconstraints: "disabled"

    # Indicates whether Kubernetes hostAliases support is enabled
    #
    # WARNING: Cannot safely be disabled once enabled.
    # See: https://knative.dev/docs/serving/feature-flags/#kubernetes-host-aliases
    kubernetes.podspec-hostaliases: "disabled"

    # Indicates whether Kubernetes nodeSelector support is enabled
    #
    # WARNING: Cannot safely be disabled once enabled.
    # See: https://knative.dev/docs/serving/feature-flags/#kubernetes-node-selector
    kubernetes.podspec-nodeselector: "disabled"

    # Indicates whether Kubernetes tolerations support is enabled
    #
    # WARNING: Cannot safely be disabled once enabled
    # See: https://knative.dev/docs/serving/feature-flags/#kubernetes-toleration
    kubernetes.podspec-tolerations: "disabled"

    # Indicates whether Kubernetes FieldRef support is enabled
    #
    # WARNING: Cannot safely be disabled once enabled.
    # See: https://knative.dev/docs/serving/feature-flags/#kubernetes-fieldref
    kubernetes.podspec-fieldref: "disabled"

    # Indicates whether Kubernetes RuntimeClassName support is enabled
    #
    # WARNING: Cannot safely be disabled once enabled.
    # See: https://knative.dev/docs/serving/feature-flags/#kubernetes-runtime-class
    kubernetes.podspec-runtimeclassname: "disabled"

    # Indicates whether Kubernetes DNSPolicy support is enabled
    #
    # WARNING: Cannot safely be disabled once enabled.
    # See: https://knative.dev/docs/serving/feature-flags/#kubernetes-dnspolicy
    kubernetes.podspec-dnspolicy: "disabled"

    # Indicates whether Kubernetes DNSConfig support is enabled
    #
    # WARNING: Cannot safely be disabled once enabled.
    # See: https://knative.dev/docs/serving/feature-flags/#kubernetes-dnsconfig
    kubernetes.podspec-dnsconfig: "disabled"

    # This feature allows end-users to set a subset of fields on the Pod's SecurityContext
    #
    # When set to "enabled" or "allowed" it allows the following
    # PodSecurityContext properties:
    # - FSGroup
    # - RunAsGroup
    # - RunAsNonRoot
    # - SupplementalGroups
    # - RunAsUser
    # - SeccompProfile
    #
    # This feature flag should be used with caution as the PodSecurityContext
    # properties may have a side-effect on non-user sidecar containers that come
    # from Knative or your service mesh
    #
    # WARNING: Cannot safely be disabled once enabled.
    # See: https://knative.dev/docs/serving/feature-flags/#kubernetes-security-context
    kubernetes.podspec-securitycontext: "disabled"

    # Indicates whether Kubernetes PriorityClassName support is enabled
    #
    # WARNING: Cannot safely be disabled once enabled.
    # See: https://knative.dev/docs/serving/feature-flags/#kubernetes-priority-class-name
    kubernetes.podspec-priorityclassname: "disabled"

    # Indicates whether Kubernetes SchedulerName support is enabled
    #
    # WARNING: Cannot safely be disabled once enabled.
    # See: https://knative.dev/docs/serving/feature-flags/#kubernetes-scheduler-name
    kubernetes.podspec-schedulername: "disabled"

    # This feature flag allows end-users to add a subset of capabilities on the Pod's SecurityContext.
    #
    # When set to "enabled" or "allowed" it allows capabilities to be added to the container.
    # For a list of possible capabilities, see https://man7.org/linux/man-pages/man7/capabilities.7.html
    kubernetes.containerspec-addcapabilities: "disabled"

    # This feature validates PodSpecs from the validating webhook
    # against the K8s API Server.
    #
    # When "enabled", the server will always run the extra validation.
    # When "allowed", the server will not run the dry-run validation by default.
    #   However, clients may enable the behavior on an individual Service by
    #   attaching the following metadata annotation: "features.knative.dev/podspec-dryrun":"enabled".
    # See: https://knative.dev/docs/serving/feature-flags/#kubernetes-dry-run
    kubernetes.podspec-dryrun: "allowed"

    # Controls whether tag header based routing feature are enabled or not.
    # 1. Enabled: enabling tag header based routing
    # 2. Disabled: disabling tag header based routing
    # See: https://knative.dev/docs/serving/feature-flags/#tag-header-based-routing
    tag-header-based-routing: "disabled"

    # Controls whether http2 auto-detection should be enabled or not.
    # 1. Enabled: http2 connection will be attempted via upgrade.
    # 2. Disabled: http2 connection will only be attempted when port name is set to "h2c".
    autodetect-http2: "disabled"

    # Controls whether volume support for EmptyDir is enabled or not.
    # 1. Enabled: enabling EmptyDir volume support
    # 2. Disabled: disabling EmptyDir volume support
    kubernetes.podspec-volumes-emptydir: "enabled"

    # Controls whether init containers support is enabled or not.
    # 1. Enabled: enabling init containers support
    # 2. Disabled: disabling init containers support
    kubernetes.podspec-init-containers: "disabled"

    # Controls whether persistent volume claim support is enabled or not.
    # 1. Enabled: enabling persistent volume claim support
    # 2. Disabled: disabling persistent volume claim support
    kubernetes.podspec-persistent-volume-claim: "disabled"

    # Controls whether write access for persistent volumes is enabled or not.
    # 1. Enabled: enabling write access for persistent volumes
    # 2. Disabled: disabling write access for persistent volumes
    kubernetes.podspec-persistent-volume-write: "disabled"

    # Controls if the queue proxy podInfo feature is enabled, allowed or disabled
    #
    # This feature should be enabled/allowed when using queue proxy Options (Extensions)
    # Enabling will mount a podInfo volume to the queue proxy container.
    # The volume will contains an 'annotations' file (from the pod's annotation field).
    # The annotations in this file include the Service annotations set by the client creating the service.
    # If mounted, the annotations can be accessed by queue proxy extensions at /etc/podinfo/annnotations
    #
    # 1. "enabled": always mount a podInfo volume
    # 2. "disabled": never mount a podInfo volume
    # 3. "allowed": by default, do not mount a podInfo volume
    #   However, a client may mount the podInfo volume on an individual Service by attaching
    #   the following metadata annotation to the Service: "features.knative.dev/queueproxy-podinfo":"enabled".
    #
    # NOTE THAT THIS IS AN EXPERIMENTAL / ALPHA FEATURE
    queueproxy.mount-podinfo: "disabled"
kind: ConfigMap
metadata:
  annotations:
    knative.dev/example-checksum: 691a192e
  labels:
    app.kubernetes.io/component: controller
    app.kubernetes.io/name: knative-serving
    app.kubernetes.io/version: 1.8.0
  name: config-features
  namespace: knative-serving
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool, kubectl_manifest.kubeflow-knative-namespace]
}

resource "kubectl_manifest" "kubeflow-knative-configmap-config-gc" {
  yaml_body = <<YAML
apiVersion: v1
data:
  _example: |
    ################################
    #                              #
    #    EXAMPLE CONFIGURATION     #
    #                              #
    ################################

    # This block is not actually functional configuration,
    # but serves to illustrate the available configuration
    # options and document them in a way that is accessible
    # to users that `kubectl edit` this config map.
    #
    # These sample configuration options may be copied out of
    # this example block and unindented to be in the data block
    # to actually change the configuration.

    # ---------------------------------------
    # Garbage Collector Settings
    # ---------------------------------------
    #
    # Active
    #   * Revisions which are referenced by a Route are considered active.
    #   * Individual revisions may be marked with the annotation
    #      "serving.knative.dev/no-gc":"true" to be permanently considered active.
    #   * Active revisions are not considered for GC.
    # Retention
    #   * Revisions are retained if they are any of the following:
    #       1. Active
    #       2. Were created within "retain-since-create-time"
    #       3. Were last referenced by a route within
    #           "retain-since-last-active-time"
    #       4. There are fewer than "min-non-active-revisions"
    #     If none of these conditions are met, or if the count of revisions exceed
    #      "max-non-active-revisions", they will be deleted by GC.
    #     The special value "disabled" may be used to turn off these limits.
    #
    # Example config to immediately collect any inactive revision:
    #    min-non-active-revisions: "0"
    #    max-non-active-revisions: "0"
    #    retain-since-create-time: "disabled"
    #    retain-since-last-active-time: "disabled"
    #
    # Example config to always keep around the last ten non-active revisions:
    #     retain-since-create-time: "disabled"
    #     retain-since-last-active-time: "disabled"
    #     max-non-active-revisions: "10"
    #
    # Example config to disable all garbage collection:
    #     retain-since-create-time: "disabled"
    #     retain-since-last-active-time: "disabled"
    #     max-non-active-revisions: "disabled"
    #
    # Example config to keep recently deployed or active revisions,
    # always maintain the last two in case of rollback, and prevent
    # burst activity from exploding the count of old revisions:
    #      retain-since-create-time: "48h"
    #      retain-since-last-active-time: "15h"
    #      min-non-active-revisions: "2"
    #      max-non-active-revisions: "1000"

    # Duration since creation before considering a revision for GC or "disabled".
    retain-since-create-time: "48h"

    # Duration since active before considering a revision for GC or "disabled".
    retain-since-last-active-time: "15h"

    # Minimum number of non-active revisions to retain.
    min-non-active-revisions: "20"

    # Maximum number of non-active revisions to retain
    # or "disabled" to disable any maximum limit.
    max-non-active-revisions: "1000"
kind: ConfigMap
metadata:
  annotations:
    knative.dev/example-checksum: aa3813a8
  labels:
    app.kubernetes.io/component: controller
    app.kubernetes.io/name: knative-serving
    app.kubernetes.io/version: 1.8.0
  name: config-gc
  namespace: knative-serving
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool, kubectl_manifest.kubeflow-knative-namespace]
}

resource "kubectl_manifest" "kubeflow-knative-configmap-config-istio" {
  yaml_body = <<YAML
apiVersion: v1
data:
  _example: |
    ################################
    #                              #
    #    EXAMPLE CONFIGURATION     #
    #                              #
    ################################

    # This block is not actually functional configuration,
    # but serves to illustrate the available configuration
    # options and document them in a way that is accessible
    # to users that `kubectl edit` this config map.
    #
    # These sample configuration options may be copied out of
    # this example block and unindented to be in the data block
    # to actually change the configuration.

    # A gateway and Istio service to serve external traffic.
    # The configuration format should be
    # `gateway.{{gateway_namespace}}.{{gateway_name}}: "{{ingress_name}}.{{ingress_namespace}}.svc.cluster.local"`.
    # The {{gateway_namespace}} is optional; when it is omitted, the system will search for
    # the gateway in the serving system namespace `knative-serving`
    gateway.knative-serving.knative-ingress-gateway: "istio-ingressgateway.istio-system.svc.cluster.local"

    # A cluster local gateway to allow pods outside of the mesh to access
    # Services and Routes not exposing through an ingress.  If the users
    # do have a service mesh setup, this isn't required and can be removed.
    #
    # An example use case is when users want to use Istio without any
    # sidecar injection (like Knative's istio-ci-no-mesh.yaml).  Since every pod
    # is outside of the service mesh in that case, a cluster-local  service
    # will need to be exposed to a cluster-local gateway to be accessible.
    # The configuration format should be `local-gateway.{{local_gateway_namespace}}.
    # {{local_gateway_name}}: "{{cluster_local_gateway_name}}.
    # {{cluster_local_gateway_namespace}}.svc.cluster.local"`. The
    # {{local_gateway_namespace}} is optional; when it is omitted, the system
    # will search for the local gateway in the serving system namespace
    # `knative-serving`
    local-gateway.knative-serving.knative-local-gateway: "knative-local-gateway.istio-system.svc.cluster.local"

    # If true, knative will use the Istio VirtualService's status to determine
    # endpoint readiness. Otherwise, probe as usual.
    # NOTE: This feature is currently experimental and should not be used in production.
    enable-virtualservice-status: "false"
  gateway.kubeflow.kubeflow-gateway: istio-ingressgateway.istio-system.svc.cluster.local
kind: ConfigMap
metadata:
  labels:
    app.kubernetes.io/component: net-istio
    app.kubernetes.io/name: knative-serving
    app.kubernetes.io/version: 1.8.0
    networking.knative.dev/ingress-provider: istio
  name: config-istio
  namespace: knative-serving
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool, kubectl_manifest.kubeflow-knative-namespace]
}

resource "kubectl_manifest" "kubeflow-knative-configmap-config-leader-election" {
  yaml_body = <<YAML
apiVersion: v1
data:
  _example: |
    ################################
    #                              #
    #    EXAMPLE CONFIGURATION     #
    #                              #
    ################################

    # This block is not actually functional configuration,
    # but serves to illustrate the available configuration
    # options and document them in a way that is accessible
    # to users that `kubectl edit` this config map.
    #
    # These sample configuration options may be copied out of
    # this example block and unindented to be in the data block
    # to actually change the configuration.

    # lease-duration is how long non-leaders will wait to try to acquire the
    # lock; 15 seconds is the value used by core kubernetes controllers.
    lease-duration: "60s"

    # renew-deadline is how long a leader will try to renew the lease before
    # giving up; 10 seconds is the value used by core kubernetes controllers.
    renew-deadline: "40s"

    # retry-period is how long the leader election client waits between tries of
    # actions; 2 seconds is the value used by core kubernetes controllers.
    retry-period: "10s"

    # buckets is the number of buckets used to partition key space of each
    # Reconciler. If this number is M and the replica number of the controller
    # is N, the N replicas will compete for the M buckets. The owner of a
    # bucket will take care of the reconciling for the keys partitioned into
    # that bucket.
    buckets: "1"
kind: ConfigMap
metadata:
  annotations:
    knative.dev/example-checksum: f4b71f57
  labels:
    app.kubernetes.io/component: controller
    app.kubernetes.io/name: knative-serving
    app.kubernetes.io/version: 1.8.0
  name: config-leader-election
  namespace: knative-serving
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool, kubectl_manifest.kubeflow-knative-namespace]
}

resource "kubectl_manifest" "kubeflow-knative-configmap-config-logging" {
  yaml_body = <<YAML
apiVersion: v1
data:
  _example: |
    ################################
    #                              #
    #    EXAMPLE CONFIGURATION     #
    #                              #
    ################################

    # This block is not actually functional configuration,
    # but serves to illustrate the available configuration
    # options and document them in a way that is accessible
    # to users that `kubectl edit` this config map.
    #
    # These sample configuration options may be copied out of
    # this example block and unindented to be in the data block
    # to actually change the configuration.

    # Common configuration for all Knative codebase
    zap-logger-config: |
      {
        "level": "info",
        "development": false,
        "outputPaths": ["stdout"],
        "errorOutputPaths": ["stderr"],
        "encoding": "json",
        "encoderConfig": {
          "timeKey": "timestamp",
          "levelKey": "severity",
          "nameKey": "logger",
          "callerKey": "caller",
          "messageKey": "message",
          "stacktraceKey": "stacktrace",
          "lineEnding": "",
          "levelEncoder": "",
          "timeEncoder": "iso8601",
          "durationEncoder": "",
          "callerEncoder": ""
        }
      }

    # Log level overrides
    # For all components except the queue proxy,
    # changes are picked up immediately.
    # For queue proxy, changes require recreation of the pods.
    loglevel.controller: "info"
    loglevel.autoscaler: "info"
    loglevel.queueproxy: "info"
    loglevel.webhook: "info"
    loglevel.activator: "info"
    loglevel.hpaautoscaler: "info"
    loglevel.net-certmanager-controller: "info"
    loglevel.net-istio-controller: "info"
    loglevel.net-contour-controller: "info"
kind: ConfigMap
metadata:
  annotations:
    knative.dev/example-checksum: b0f3c6f2
  labels:
    app.kubernetes.io/component: logging
    app.kubernetes.io/name: knative-serving
    app.kubernetes.io/version: 1.8.0
  name: config-logging
  namespace: knative-serving
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool, kubectl_manifest.kubeflow-knative-namespace]
}

resource "kubectl_manifest" "kubeflow-knative-configmap-config-network" {
  yaml_body = <<YAML
apiVersion: v1
data:
  _example: |
    ################################
    #                              #
    #    EXAMPLE CONFIGURATION     #
    #                              #
    ################################

    # This block is not actually functional configuration,
    # but serves to illustrate the available configuration
    # options and document them in a way that is accessible
    # to users that `kubectl edit` this config map.
    #
    # These sample configuration options may be copied out of
    # this example block and unindented to be in the data block
    # to actually change the configuration.

    # ingress-class specifies the default ingress class
    # to use when not dictated by Route annotation.
    #
    # If not specified, will use the Istio ingress.
    #
    # Note that changing the Ingress class of an existing Route
    # will result in undefined behavior.  Therefore it is best to only
    # update this value during the setup of Knative, to avoid getting
    # undefined behavior.
    ingress-class: "istio.ingress.networking.knative.dev"

    # certificate-class specifies the default Certificate class
    # to use when not dictated by Route annotation.
    #
    # If not specified, will use the Cert-Manager Certificate.
    #
    # Note that changing the Certificate class of an existing Route
    # will result in undefined behavior.  Therefore it is best to only
    # update this value during the setup of Knative, to avoid getting
    # undefined behavior.
    certificate-class: "cert-manager.certificate.networking.knative.dev"

    # namespace-wildcard-cert-selector specifies a LabelSelector which
    # determines which namespaces should have a wildcard certificate
    # provisioned.
    #
    # Use an empty value to disable the feature (this is the default):
    #   namespace-wildcard-cert-selector: ""
    #
    # Use an empty object to enable for all namespaces
    #   namespace-wildcard-cert-selector: {}
    #
    # Useful labels include the "kubernetes.io/metadata.name" label to
    # avoid provisioning a certifcate for the "kube-system" namespaces.
    # Use the following selector to match pre-1.0 behavior of using
    # "networking.knative.dev/disableWildcardCert" to exclude namespaces:
    #
    # matchExpressions:
    # - key: "networking.knative.dev/disableWildcardCert"
    #   operator: "NotIn"
    #   values: ["true"]
    namespace-wildcard-cert-selector: ""

    # domain-template specifies the golang text template string to use
    # when constructing the Knative service's DNS name. The default
    # value is "{{.Name}}.{{.Namespace}}.{{.Domain}}".
    #
    # Valid variables defined in the template include Name, Namespace, Domain,
    # Labels, and Annotations. Name will be the result of the tagTemplate
    # below, if a tag is specified for the route.
    #
    # Changing this value might be necessary when the extra levels in
    # the domain name generated is problematic for wildcard certificates
    # that only support a single level of domain name added to the
    # certificate's domain. In those cases you might consider using a value
    # of "{{.Name}}-{{.Namespace}}.{{.Domain}}", or removing the Namespace
    # entirely from the template. When choosing a new value be thoughtful
    # of the potential for conflicts - for example, when users choose to use
    # characters such as `-` in their service, or namespace, names.
    # {{.Annotations}} or {{.Labels}} can be used for any customization in the
    # go template if needed.
    # We strongly recommend keeping namespace part of the template to avoid
    # domain name clashes:
    # eg. '{{.Name}}-{{.Namespace}}.{{ index .Annotations "sub"}}.{{.Domain}}'
    # and you have an annotation {"sub":"foo"}, then the generated template
    # would be {Name}-{Namespace}.foo.{Domain}
    domain-template: "{{.Name}}.{{.Namespace}}.{{.Domain}}"

    # tagTemplate specifies the golang text template string to use
    # when constructing the DNS name for "tags" within the traffic blocks
    # of Routes and Configuration.  This is used in conjunction with the
    # domainTemplate above to determine the full URL for the tag.
    tag-template: "{{.Tag}}-{{.Name}}"

    # Controls whether TLS certificates are automatically provisioned and
    # installed in the Knative ingress to terminate external TLS connection.
    # 1. Enabled: enabling auto-TLS feature.
    # 2. Disabled: disabling auto-TLS feature.
    auto-tls: "Disabled"

    # Controls the behavior of the HTTP endpoint for the Knative ingress.
    # It requires autoTLS to be enabled.
    # 1. Enabled: The Knative ingress will be able to serve HTTP connection.
    # 2. Redirected: The Knative ingress will send a 301 redirect for all
    # http connections, asking the clients to use HTTPS.
    #
    # "Disabled" option is deprecated.
    http-protocol: "Enabled"

    # rollout-duration contains the minimal duration in seconds over which the
    # Configuration traffic targets are rolled out to the newest revision.
    rollout-duration: "0"

    # autocreate-cluster-domain-claims controls whether ClusterDomainClaims should
    # be automatically created (and deleted) as needed when DomainMappings are
    # reconciled.
    #
    # If this is "false" (the default), the cluster administrator is
    # responsible for creating ClusterDomainClaims and delegating them to
    # namespaces via their spec.Namespace field. This setting should be used in
    # multitenant environments which need to control which namespace can use a
    # particular domain name in a domain mapping.
    #
    # If this is "true", users are able to associate arbitrary names with their
    # services via the DomainMapping feature.
    autocreate-cluster-domain-claims: "false"

    # If true, networking plugins can add additional information to deployed
    # applications to make their pods directly accessible via their IPs even if mesh is
    # enabled and thus direct-addressability is usually not possible.
    # Consumers like Knative Serving can use this setting to adjust their behavior
    # accordingly, i.e. to drop fallback solutions for non-pod-addressable systems.
    #
    # NOTE: This flag is in an alpha state and is mostly here to enable internal testing
    #       for now. Use with caution.
    enable-mesh-pod-addressability: "false"

    # mesh-compatibility-mode indicates whether consumers of network plugins
    # should directly contact Pod IPs (most efficient), or should use the
    # Cluster IP (less efficient, needed when mesh is enabled unless
    # `enable-mesh-pod-addressability`, above, is set).
    # Permitted values are:
    #  - "auto" (default): automatically determine which mesh mode to use by trying Pod IP and falling back to Cluster IP as needed.
    #  - "enabled": always use Cluster IP and do not attempt to use Pod IPs.
    #  - "disabled": always use Pod IPs and do not fall back to Cluster IP on failure.
    mesh-compatibility-mode: "auto"

    # Defines the scheme used for external URLs if autoTLS is not enabled.
    # This can be used for making Knative report all URLs as "HTTPS" for example, if you're
    # fronting Knative with an external loadbalancer that deals with TLS termination and
    # Knative doesn't know about that otherwise.
    default-external-scheme: "http"

    # internal-encryption indicates whether internal traffic is encrypted or not.
    # If this is "true", the following traffic are encrypted:
    #  - ingress to activator
    #  - ingress to queue-proxy
    #  - activator to queue-proxy
    #
    # NOTE: This flag is in an alpha state and is mostly here to enable internal testing
    #       for now. Use with caution.
    internal-encryption: "false"
kind: ConfigMap
metadata:
  annotations:
    knative.dev/example-checksum: 73d96d1b
  labels:
    app.kubernetes.io/component: networking
    app.kubernetes.io/name: knative-serving
    app.kubernetes.io/version: 1.8.0
  name: config-network
  namespace: knative-serving
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool, kubectl_manifest.kubeflow-knative-namespace]
}

resource "kubectl_manifest" "kubeflow-knative-configmap-config-observability" {
  yaml_body = <<YAML
apiVersion: v1
data:
  _example: |
    ################################
    #                              #
    #    EXAMPLE CONFIGURATION     #
    #                              #
    ################################

    # This block is not actually functional configuration,
    # but serves to illustrate the available configuration
    # options and document them in a way that is accessible
    # to users that `kubectl edit` this config map.
    #
    # These sample configuration options may be copied out of
    # this example block and unindented to be in the data block
    # to actually change the configuration.

    # logging.enable-var-log-collection defaults to false.
    # The fluentd daemon set will be set up to collect /var/log if
    # this flag is true.
    logging.enable-var-log-collection: "false"

    # logging.revision-url-template provides a template to use for producing the
    # logging URL that is injected into the status of each Revision.
    logging.revision-url-template: "http://logging.example.com/?revisionUID=$${REVISION_UID}"

    # If non-empty, this enables queue proxy writing user request logs to stdout, excluding probe
    # requests.
    # NB: after 0.18 release logging.enable-request-log must be explicitly set to true
    # in order for request logging to be enabled.
    #
    # The value determines the shape of the request logs and it must be a valid go text/template.
    # It is important to keep this as a single line. Multiple lines are parsed as separate entities
    # by most collection agents and will split the request logs into multiple records.
    #
    # The following fields and functions are available to the template:
    #
    # Request: An http.Request (see https://golang.org/pkg/net/http/#Request)
    # representing an HTTP request received by the server.
    #
    # Response:
    # struct {
    #   Code    int       // HTTP status code (see https://www.iana.org/assignments/http-status-codes/http-status-codes.xhtml)
    #   Size    int       // An int representing the size of the response.
    #   Latency float64   // A float64 representing the latency of the response in seconds.
    # }
    #
    # Revision:
    # struct {
    #   Name          string  // Knative revision name
    #   Namespace     string  // Knative revision namespace
    #   Service       string  // Knative service name
    #   Configuration string  // Knative configuration name
    #   PodName       string  // Name of the pod hosting the revision
    #   PodIP         string  // IP of the pod hosting the revision
    # }
    #
    logging.request-log-template: '{"httpRequest": {"requestMethod": "{{.Request.Method}}", "requestUrl": "{{js .Request.RequestURI}}", "requestSize": "{{.Request.ContentLength}}", "status": {{.Response.Code}}, "responseSize": "{{.Response.Size}}", "userAgent": "{{js .Request.UserAgent}}", "remoteIp": "{{js .Request.RemoteAddr}}", "serverIp": "{{.Revision.PodIP}}", "referer": "{{js .Request.Referer}}", "latency": "{{.Response.Latency}}s", "protocol": "{{.Request.Proto}}"}, "traceId": "{{index .Request.Header "X-B3-Traceid"}}"}'

    # If true, the request logging will be enabled.
    # NB: up to and including Knative version 0.18 if logging.request-log-template is non-empty, this value
    # will be ignored.
    logging.enable-request-log: "false"

    # If true, this enables queue proxy writing request logs for probe requests to stdout.
    # It uses the same template for user requests, i.e. logging.request-log-template.
    logging.enable-probe-request-log: "false"

    # metrics.backend-destination field specifies the system metrics destination.
    # It supports either prometheus (the default) or opencensus.
    metrics.backend-destination: prometheus

    # metrics.request-metrics-backend-destination specifies the request metrics
    # destination. It enables queue proxy to send request metrics.
    # Currently supported values: prometheus (the default), opencensus.
    metrics.request-metrics-backend-destination: prometheus

    # profiling.enable indicates whether it is allowed to retrieve runtime profiling data from
    # the pods via an HTTP server in the format expected by the pprof visualization tool. When
    # enabled, the Knative Serving pods expose the profiling data on an alternate HTTP port 8008.
    # The HTTP context root for profiling is then /debug/pprof/.
    profiling.enable: "false"
kind: ConfigMap
metadata:
  annotations:
    knative.dev/example-checksum: fed4756e
  labels:
    app.kubernetes.io/component: observability
    app.kubernetes.io/name: knative-serving
    app.kubernetes.io/version: 1.8.0
  name: config-observability
  namespace: knative-serving
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool, kubectl_manifest.kubeflow-knative-namespace]
}

resource "kubectl_manifest" "kubeflow-knative-configmap-config-tracing" {
  yaml_body = <<YAML
apiVersion: v1
data:
  _example: |
    ################################
    #                              #
    #    EXAMPLE CONFIGURATION     #
    #                              #
    ################################

    # This block is not actually functional configuration,
    # but serves to illustrate the available configuration
    # options and document them in a way that is accessible
    # to users that `kubectl edit` this config map.
    #
    # These sample configuration options may be copied out of
    # this example block and unindented to be in the data block
    # to actually change the configuration.
    #
    # This may be "zipkin" or "none" (default)
    backend: "none"

    # URL to zipkin collector where traces are sent.
    # This must be specified when backend is "zipkin"
    zipkin-endpoint: "http://zipkin.istio-system.svc.cluster.local:9411/api/v2/spans"

    # Enable zipkin debug mode. This allows all spans to be sent to the server
    # bypassing sampling.
    debug: "false"

    # Percentage (0-1) of requests to trace
    sample-rate: "0.1"
kind: ConfigMap
metadata:
  annotations:
    knative.dev/example-checksum: "26614636"
  labels:
    app.kubernetes.io/component: tracing
    app.kubernetes.io/name: knative-serving
    app.kubernetes.io/version: 1.8.0
  name: config-tracing
  namespace: knative-serving
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool, kubectl_manifest.kubeflow-knative-namespace]
}

resource "kubectl_manifest" "kubeflow-knative-secret-control-serving-certs" {
  yaml_body = <<YAML
apiVersion: v1
kind: Secret
metadata:
  labels:
    networking.internal.knative.dev/certificate-uid: serving-certs
    serving-certs-ctrl: data-plane
  name: knative-serving-certs
  namespace: knative-serving
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool, kubectl_manifest.kubeflow-knative-namespace]
}

resource "kubectl_manifest" "kubeflow-knative-secret-serving-certs" {
  yaml_body = <<YAML
apiVersion: v1
kind: Secret
metadata:
  labels:
    networking.internal.knative.dev/certificate-uid: serving-certs
    serving-certs-ctrl: data-plane
  name: knative-serving-certs
  namespace: knative-serving
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool, kubectl_manifest.kubeflow-knative-namespace]
}

resource "kubectl_manifest" "kubeflow-knative-secret-domainmapping-webhook-certs" {
  yaml_body = <<YAML
apiVersion: v1
kind: Secret
metadata:
  labels:
    app.kubernetes.io/component: domain-mapping
    app.kubernetes.io/name: knative-serving
    app.kubernetes.io/version: 1.8.0
  name: domainmapping-webhook-certs
  namespace: knative-serving
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool, kubectl_manifest.kubeflow-knative-namespace]
}

resource "kubectl_manifest" "kubeflow-knative-secret-net-istio-webhook-certs" {
  yaml_body = <<YAML
apiVersion: v1
kind: Secret
metadata:
  labels:
    app.kubernetes.io/component: net-istio
    app.kubernetes.io/name: knative-serving
    app.kubernetes.io/version: 1.8.0
    networking.knative.dev/ingress-provider: istio
  name: net-istio-webhook-certs
  namespace: knative-serving
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool, kubectl_manifest.kubeflow-knative-namespace]
}

resource "kubectl_manifest" "kubeflow-knative-secret-routing-serving-certs" {
  yaml_body = <<YAML
apiVersion: v1
kind: Secret
metadata:
  labels:
    networking.internal.knative.dev/certificate-uid: serving-certs
    routing-id: "0"
    serving-certs-ctrl: data-plane-routing
  name: routing-serving-certs
  namespace: knative-serving
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool, kubectl_manifest.kubeflow-knative-namespace]
}

resource "kubectl_manifest" "kubeflow-knative-secret-serving-certs-ctrl-ca" {
  yaml_body = <<YAML
apiVersion: v1
kind: Secret
metadata:
  name: serving-certs-ctrl-ca
  namespace: knative-serving
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool, kubectl_manifest.kubeflow-knative-namespace]
}

resource "kubectl_manifest" "kubeflow-knative-secret-webhook-certs" {
  yaml_body = <<YAML
apiVersion: v1
kind: Secret
metadata:
  labels:
    app.kubernetes.io/component: webhook
    app.kubernetes.io/name: knative-serving
    app.kubernetes.io/version: 1.8.0
  name: webhook-certs
  namespace: knative-serving
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool, kubectl_manifest.kubeflow-knative-namespace]
}

resource "kubectl_manifest" "kubeflow-knative-service-local-gateway" {
  yaml_body = <<YAML
apiVersion: v1
kind: Service
metadata:
  labels:
    app.kubernetes.io/component: net-istio
    app.kubernetes.io/name: knative-serving
    app.kubernetes.io/version: 1.8.0
    experimental.istio.io/disable-gateway-port-translation: "true"
    networking.knative.dev/ingress-provider: istio
  name: knative-local-gateway
  namespace: istio-system
spec:
  ports:
  - name: http2
    port: 80
    targetPort: 8081
  selector:
    app: cluster-local-gateway
    istio: cluster-local-gateway
  type: ClusterIP
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool, kubectl_manifest.kubeflow-knative-namespace]
}

resource "kubectl_manifest" "kubeflow-knative-service-activator-service" {
  yaml_body = <<YAML
apiVersion: v1
kind: Service
metadata:
  labels:
    app: activator
    app.kubernetes.io/component: activator
    app.kubernetes.io/name: knative-serving
    app.kubernetes.io/version: 1.8.0
  name: activator-service
  namespace: knative-serving
spec:
  ports:
  - name: http-metrics
    port: 9090
    targetPort: 9090
  - name: http-profiling
    port: 8008
    targetPort: 8008
  - name: http
    port: 80
    targetPort: 8012
  - name: http2
    port: 81
    targetPort: 8013
  - name: https
    port: 443
    targetPort: 8112
  selector:
    app: activator
  type: ClusterIP
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool, kubectl_manifest.kubeflow-knative-namespace]
}

resource "kubectl_manifest" "kubeflow-knative-service-autoscaler" {
  yaml_body = <<YAML
apiVersion: v1
kind: Service
metadata:
  labels:
    app: autoscaler
    app.kubernetes.io/component: autoscaler
    app.kubernetes.io/name: knative-serving
    app.kubernetes.io/version: 1.8.0
  name: autoscaler
  namespace: knative-serving
spec:
  ports:
  - name: http-metrics
    port: 9090
    targetPort: 9090
  - name: http-profiling
    port: 8008
    targetPort: 8008
  - name: http
    port: 8080
    targetPort: 8080
  selector:
    app: autoscaler
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool, kubectl_manifest.kubeflow-knative-namespace]
}

resource "kubectl_manifest" "kubeflow-knative-service-controller" {
  yaml_body = <<YAML
apiVersion: v1
kind: Service
metadata:
  labels:
    app: controller
    app.kubernetes.io/component: controller
    app.kubernetes.io/name: knative-serving
    app.kubernetes.io/version: 1.8.0
  name: controller
  namespace: knative-serving
spec:
  ports:
  - name: http-metrics
    port: 9090
    targetPort: 9090
  - name: http-profiling
    port: 8008
    targetPort: 8008
  selector:
    app: controller
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool, kubectl_manifest.kubeflow-knative-namespace]
}

resource "kubectl_manifest" "kubeflow-knative-service-domainmapping-webhook" {
  yaml_body = <<YAML
apiVersion: v1
kind: Service
metadata:
  labels:
    app.kubernetes.io/component: domain-mapping
    app.kubernetes.io/name: knative-serving
    app.kubernetes.io/version: 1.8.0
    role: domainmapping-webhook
  name: domainmapping-webhook
  namespace: knative-serving
spec:
  ports:
  - name: http-metrics
    port: 9090
    targetPort: 9090
  - name: http-profiling
    port: 8008
    targetPort: 8008
  - name: https-webhook
    port: 443
    targetPort: 8443
  selector:
    role: domainmapping-webhook
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool, kubectl_manifest.kubeflow-knative-namespace]
}

resource "kubectl_manifest" "kubeflow-knative-service-net-istio-webhook" {
  yaml_body = <<YAML
apiVersion: v1
kind: Service
metadata:
  labels:
    app.kubernetes.io/component: net-istio
    app.kubernetes.io/name: knative-serving
    app.kubernetes.io/version: 1.8.0
    networking.knative.dev/ingress-provider: istio
    role: net-istio-webhook
  name: net-istio-webhook
  namespace: knative-serving
spec:
  ports:
  - name: http-metrics
    port: 9090
    targetPort: 9090
  - name: http-profiling
    port: 8008
    targetPort: 8008
  - name: https-webhook
    port: 443
    targetPort: 8443
  selector:
    app: net-istio-webhook
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool, kubectl_manifest.kubeflow-knative-namespace]
}

resource "kubectl_manifest" "kubeflow-knative-service-webhook" {
  yaml_body = <<YAML
apiVersion: v1
kind: Service
metadata:
  labels:
    app.kubernetes.io/component: webhook
    app.kubernetes.io/name: knative-serving
    app.kubernetes.io/version: 1.8.0
    role: webhook
  name: webhook
  namespace: knative-serving
spec:
  ports:
  - name: http-metrics
    port: 9090
    targetPort: 9090
  - name: http-profiling
    port: 8008
    targetPort: 8008
  - name: https-webhook
    port: 443
    targetPort: 8443
  selector:
    role: webhook
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool, kubectl_manifest.kubeflow-knative-namespace]
}

resource "kubectl_manifest" "kubeflow-knative-deployment-activator" {
  yaml_body = <<YAML
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app.kubernetes.io/component: activator
    app.kubernetes.io/name: knative-serving
    app.kubernetes.io/version: 1.8.0
  name: activator
  namespace: knative-serving
spec:
  selector:
    matchLabels:
      app: activator
      role: activator
  template:
    metadata:
      annotations:
        cluster-autoscaler.kubernetes.io/safe-to-evict: "false"
        sidecar.istio.io/inject: "true"
      labels:
        app: activator
        app.kubernetes.io/component: activator
        app.kubernetes.io/name: knative-serving
        app.kubernetes.io/version: 1.8.0
        role: activator
    spec:
      containers:
      - env:
        - name: GOGC
          value: "500"
        - name: POD_NAME
          valueFrom:
            fieldRef:
              fieldPath: metadata.name
        - name: POD_IP
          valueFrom:
            fieldRef:
              fieldPath: status.podIP
        - name: SYSTEM_NAMESPACE
          valueFrom:
            fieldRef:
              fieldPath: metadata.namespace
        - name: CONFIG_LOGGING_NAME
          value: config-logging
        - name: CONFIG_OBSERVABILITY_NAME
          value: config-observability
        - name: METRICS_DOMAIN
          value: knative.dev/internal/serving
        image: gcr.io/knative-releases/knative.dev/serving/cmd/activator@sha256:c3bbf3a96920048869dcab8e133e00f59855670b8a0bbca3d72ced2f512eb5e1
        livenessProbe:
          failureThreshold: 12
          httpGet:
            httpHeaders:
            - name: k-kubelet-probe
              value: activator
            port: 8012
          initialDelaySeconds: 15
          periodSeconds: 10
        name: activator
        ports:
        - containerPort: 9090
          name: metrics
        - containerPort: 8008
          name: profiling
        - containerPort: 8012
          name: http1
        - containerPort: 8013
          name: h2c
        readinessProbe:
          failureThreshold: 5
          httpGet:
            httpHeaders:
            - name: k-kubelet-probe
              value: activator
            port: 8012
          periodSeconds: 5
        resources:
          limits:
            cpu: 1000m
            memory: 600Mi
          requests:
            cpu: 300m
            memory: 60Mi
        securityContext:
          allowPrivilegeEscalation: false
          capabilities:
            drop:
            - ALL
          readOnlyRootFilesystem: true
          runAsNonRoot: true
          seccompProfile:
            type: RuntimeDefault
      serviceAccountName: controller
      terminationGracePeriodSeconds: 600
      tolerations:
      - key: "kubeflow"
        operator: "Equal"
        value: "control-plane"
        effect: "NoSchedule"
      nodeSelector:
        kubeflow: control-plane
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool, kubectl_manifest.kubeflow-knative-namespace, kubectl_manifest.kubeflow-istio-deployment-istiod, kubectl_manifest.kubeflow-istio-mutatingwebhookconfiguration-sidecar-injector]
}

resource "kubectl_manifest" "kubeflow-knative-deployment-autoscaler" {
  yaml_body = <<YAML
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app.kubernetes.io/component: autoscaler
    app.kubernetes.io/name: knative-serving
    app.kubernetes.io/version: 1.8.0
  name: autoscaler
  namespace: knative-serving
spec:
  replicas: 1
  selector:
    matchLabels:
      app: autoscaler
  strategy:
    rollingUpdate:
      maxUnavailable: 0
    type: RollingUpdate
  template:
    metadata:
      annotations:
        cluster-autoscaler.kubernetes.io/safe-to-evict: "false"
        sidecar.istio.io/inject: "true"
      labels:
        app: autoscaler
        app.kubernetes.io/component: autoscaler
        app.kubernetes.io/name: knative-serving
        app.kubernetes.io/version: 1.8.0
    spec:
      affinity:
        podAntiAffinity:
          preferredDuringSchedulingIgnoredDuringExecution:
          - podAffinityTerm:
              labelSelector:
                matchLabels:
                  app: autoscaler
              topologyKey: kubernetes.io/hostname
            weight: 100
      containers:
      - env:
        - name: POD_NAME
          valueFrom:
            fieldRef:
              fieldPath: metadata.name
        - name: POD_IP
          valueFrom:
            fieldRef:
              fieldPath: status.podIP
        - name: SYSTEM_NAMESPACE
          valueFrom:
            fieldRef:
              fieldPath: metadata.namespace
        - name: CONFIG_LOGGING_NAME
          value: config-logging
        - name: CONFIG_OBSERVABILITY_NAME
          value: config-observability
        - name: METRICS_DOMAIN
          value: knative.dev/serving
        image: gcr.io/knative-releases/knative.dev/serving/cmd/autoscaler@sha256:caae5e34b4cb311ed8551f2778cfca566a77a924a59b775bd516fa8b5e3c1d7f
        livenessProbe:
          failureThreshold: 6
          httpGet:
            httpHeaders:
            - name: k-kubelet-probe
              value: autoscaler
            port: 8080
        name: autoscaler
        ports:
        - containerPort: 9090
          name: metrics
        - containerPort: 8008
          name: profiling
        - containerPort: 8080
          name: websocket
        readinessProbe:
          httpGet:
            httpHeaders:
            - name: k-kubelet-probe
              value: autoscaler
            port: 8080
        resources:
          limits:
            cpu: 1000m
            memory: 1000Mi
          requests:
            cpu: 100m
            memory: 100Mi
        securityContext:
          allowPrivilegeEscalation: false
          capabilities:
            drop:
            - ALL
          readOnlyRootFilesystem: true
          runAsNonRoot: true
          seccompProfile:
            type: RuntimeDefault
      serviceAccountName: controller
      tolerations:
      - key: "kubeflow"
        operator: "Equal"
        value: "control-plane"
        effect: "NoSchedule"
      nodeSelector:
        kubeflow: control-plane
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool, kubectl_manifest.kubeflow-knative-namespace, kubectl_manifest.kubeflow-istio-deployment-istiod, kubectl_manifest.kubeflow-istio-mutatingwebhookconfiguration-sidecar-injector]
}

resource "kubectl_manifest" "kubeflow-knative-deployment-controller" {
  yaml_body = <<YAML
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app.kubernetes.io/component: controller
    app.kubernetes.io/name: knative-serving
    app.kubernetes.io/version: 1.8.0
  name: controller
  namespace: knative-serving
spec:
  selector:
    matchLabels:
      app: controller
  template:
    metadata:
      annotations:
        cluster-autoscaler.kubernetes.io/safe-to-evict: "true"
        sidecar.istio.io/inject: "true"
      labels:
        app: controller
        app.kubernetes.io/component: controller
        app.kubernetes.io/name: knative-serving
        app.kubernetes.io/version: 1.8.0
    spec:
      affinity:
        podAntiAffinity:
          preferredDuringSchedulingIgnoredDuringExecution:
          - podAffinityTerm:
              labelSelector:
                matchLabels:
                  app: controller
              topologyKey: kubernetes.io/hostname
            weight: 100
      containers:
      - env:
        - name: POD_NAME
          valueFrom:
            fieldRef:
              fieldPath: metadata.name
        - name: SYSTEM_NAMESPACE
          valueFrom:
            fieldRef:
              fieldPath: metadata.namespace
        - name: CONFIG_LOGGING_NAME
          value: config-logging
        - name: CONFIG_OBSERVABILITY_NAME
          value: config-observability
        - name: METRICS_DOMAIN
          value: knative.dev/internal/serving
        image: gcr.io/knative-releases/knative.dev/serving/cmd/controller@sha256:38f9557f4d61ec79cc2cdbe76da8df6c6ae5f978a50a2847c22cc61aa240da95
        name: controller
        ports:
        - containerPort: 9090
          name: metrics
        - containerPort: 8008
          name: profiling
        resources:
          limits:
            cpu: 1000m
            memory: 1000Mi
          requests:
            cpu: 100m
            memory: 100Mi
        securityContext:
          allowPrivilegeEscalation: false
          capabilities:
            drop:
            - ALL
          readOnlyRootFilesystem: true
          runAsNonRoot: true
          seccompProfile:
            type: RuntimeDefault
      serviceAccountName: controller
      tolerations:
      - key: "kubeflow"
        operator: "Equal"
        value: "control-plane"
        effect: "NoSchedule"
      nodeSelector:
        kubeflow: control-plane
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool, kubectl_manifest.kubeflow-knative-namespace, kubectl_manifest.kubeflow-istio-deployment-istiod, kubectl_manifest.kubeflow-istio-mutatingwebhookconfiguration-sidecar-injector]
}

resource "kubectl_manifest" "kubeflow-knative-deployment-domain-mapping" {
  yaml_body = <<YAML
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app.kubernetes.io/component: domain-mapping
    app.kubernetes.io/name: knative-serving
    app.kubernetes.io/version: 1.8.0
  name: domain-mapping
  namespace: knative-serving
spec:
  selector:
    matchLabels:
      app: domain-mapping
  template:
    metadata:
      annotations:
        cluster-autoscaler.kubernetes.io/safe-to-evict: "true"
        sidecar.istio.io/inject: "true"
      labels:
        app: domain-mapping
        app.kubernetes.io/component: domain-mapping
        app.kubernetes.io/name: knative-serving
        app.kubernetes.io/version: 1.8.0
    spec:
      affinity:
        podAntiAffinity:
          preferredDuringSchedulingIgnoredDuringExecution:
          - podAffinityTerm:
              labelSelector:
                matchLabels:
                  app: domain-mapping
              topologyKey: kubernetes.io/hostname
            weight: 100
      containers:
      - env:
        - name: SYSTEM_NAMESPACE
          valueFrom:
            fieldRef:
              fieldPath: metadata.namespace
        - name: CONFIG_LOGGING_NAME
          value: config-logging
        - name: CONFIG_OBSERVABILITY_NAME
          value: config-observability
        - name: METRICS_DOMAIN
          value: knative.dev/serving
        image: gcr.io/knative-releases/knative.dev/serving/cmd/domain-mapping@sha256:763d648bf1edee2b4471b0e211dbc53ba2d28f92e4dae28ccd39af7185ef2c96
        name: domain-mapping
        ports:
        - containerPort: 9090
          name: metrics
        - containerPort: 8008
          name: profiling
        resources:
          limits:
            cpu: 300m
            memory: 400Mi
          requests:
            cpu: 30m
            memory: 40Mi
        securityContext:
          allowPrivilegeEscalation: false
          capabilities:
            drop:
            - ALL
          readOnlyRootFilesystem: true
          runAsNonRoot: true
          seccompProfile:
            type: RuntimeDefault
      serviceAccountName: controller
      tolerations:
      - key: "kubeflow"
        operator: "Equal"
        value: "control-plane"
        effect: "NoSchedule"
      nodeSelector:
        kubeflow: control-plane
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool, kubectl_manifest.kubeflow-knative-namespace, kubectl_manifest.kubeflow-istio-deployment-istiod, kubectl_manifest.kubeflow-istio-mutatingwebhookconfiguration-sidecar-injector]
}

resource "kubectl_manifest" "kubeflow-knative-deployment-domainmapping-webhook" {
  yaml_body = <<YAML
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app.kubernetes.io/component: domain-mapping
    app.kubernetes.io/name: knative-serving
    app.kubernetes.io/version: 1.8.0
  name: domainmapping-webhook
  namespace: knative-serving
spec:
  selector:
    matchLabels:
      app: domainmapping-webhook
      role: domainmapping-webhook
  template:
    metadata:
      annotations:
        cluster-autoscaler.kubernetes.io/safe-to-evict: "false"
        sidecar.istio.io/inject: "true"
      labels:
        app: domainmapping-webhook
        app.kubernetes.io/component: domain-mapping
        app.kubernetes.io/name: knative-serving
        app.kubernetes.io/version: 1.8.0
        role: domainmapping-webhook
    spec:
      affinity:
        podAntiAffinity:
          preferredDuringSchedulingIgnoredDuringExecution:
          - podAffinityTerm:
              labelSelector:
                matchLabels:
                  app: domainmapping-webhook
              topologyKey: kubernetes.io/hostname
            weight: 100
      containers:
      - env:
        - name: POD_NAME
          valueFrom:
            fieldRef:
              fieldPath: metadata.name
        - name: SYSTEM_NAMESPACE
          valueFrom:
            fieldRef:
              fieldPath: metadata.namespace
        - name: CONFIG_LOGGING_NAME
          value: config-logging
        - name: CONFIG_OBSERVABILITY_NAME
          value: config-observability
        - name: WEBHOOK_PORT
          value: "8443"
        - name: METRICS_DOMAIN
          value: knative.dev/serving
        image: gcr.io/knative-releases/knative.dev/serving/cmd/domain-mapping-webhook@sha256:a4ba0076df2efaca2eed561339e21b3a4ca9d90167befd31de882bff69639470
        livenessProbe:
          failureThreshold: 6
          httpGet:
            httpHeaders:
            - name: k-kubelet-probe
              value: webhook
            port: 8443
            scheme: HTTPS
          initialDelaySeconds: 20
          periodSeconds: 1
        name: domainmapping-webhook
        ports:
        - containerPort: 9090
          name: metrics
        - containerPort: 8008
          name: profiling
        - containerPort: 8443
          name: https-webhook
        readinessProbe:
          httpGet:
            httpHeaders:
            - name: k-kubelet-probe
              value: webhook
            port: 8443
            scheme: HTTPS
          periodSeconds: 1
        resources:
          limits:
            cpu: 500m
            memory: 500Mi
          requests:
            cpu: 100m
            memory: 100Mi
        securityContext:
          allowPrivilegeEscalation: false
          capabilities:
            drop:
            - ALL
          readOnlyRootFilesystem: true
          runAsNonRoot: true
          seccompProfile:
            type: RuntimeDefault
      serviceAccountName: controller
      terminationGracePeriodSeconds: 300
      tolerations:
      - key: "kubeflow"
        operator: "Equal"
        value: "control-plane"
        effect: "NoSchedule"
      nodeSelector:
        kubeflow: control-plane
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool, kubectl_manifest.kubeflow-knative-namespace, kubectl_manifest.kubeflow-istio-deployment-istiod, kubectl_manifest.kubeflow-istio-mutatingwebhookconfiguration-sidecar-injector]
}

resource "kubectl_manifest" "kubeflow-knative-deployment-net-istio-controller" {
  yaml_body = <<YAML
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app.kubernetes.io/component: net-istio
    app.kubernetes.io/name: knative-serving
    app.kubernetes.io/version: 1.8.0
    networking.knative.dev/ingress-provider: istio
  name: net-istio-controller
  namespace: knative-serving
spec:
  selector:
    matchLabels:
      app: net-istio-controller
  template:
    metadata:
      annotations:
        cluster-autoscaler.kubernetes.io/safe-to-evict: "true"
        sidecar.istio.io/inject: "true"
      labels:
        app: net-istio-controller
        app.kubernetes.io/component: net-istio
        app.kubernetes.io/name: knative-serving
        app.kubernetes.io/version: 1.8.0
    spec:
      containers:
      - env:
        - name: SYSTEM_NAMESPACE
          valueFrom:
            fieldRef:
              fieldPath: metadata.namespace
        - name: CONFIG_LOGGING_NAME
          value: config-logging
        - name: CONFIG_OBSERVABILITY_NAME
          value: config-observability
        - name: ENABLE_SECRET_INFORMER_FILTERING_BY_CERT_UID
          value: "false"
        - name: METRICS_DOMAIN
          value: knative.dev/net-istio
        image: gcr.io/knative-releases/knative.dev/net-istio/cmd/controller@sha256:2b484d982ef1a5d6ff93c46d3e45f51c2605c2e3ed766e20247d1727eb5ce918
        name: controller
        ports:
        - containerPort: 9090
          name: metrics
        - containerPort: 8008
          name: profiling
        resources:
          limits:
            cpu: 300m
            memory: 400Mi
          requests:
            cpu: 30m
            memory: 40Mi
        securityContext:
          allowPrivilegeEscalation: false
          capabilities:
            drop:
            - ALL
          readOnlyRootFilesystem: true
          runAsNonRoot: true
          seccompProfile:
            type: RuntimeDefault
      serviceAccountName: controller
      tolerations:
      - key: "kubeflow"
        operator: "Equal"
        value: "control-plane"
        effect: "NoSchedule"
      nodeSelector:
        kubeflow: control-plane
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool, kubectl_manifest.kubeflow-knative-namespace, kubectl_manifest.kubeflow-istio-deployment-istiod, kubectl_manifest.kubeflow-istio-mutatingwebhookconfiguration-sidecar-injector]
}

resource "kubectl_manifest" "kubeflow-knative-deployment-net-istio-webhook" {
  yaml_body = <<YAML
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app.kubernetes.io/component: net-istio
    app.kubernetes.io/name: knative-serving
    app.kubernetes.io/version: 1.8.0
    networking.knative.dev/ingress-provider: istio
  name: net-istio-webhook
  namespace: knative-serving
spec:
  selector:
    matchLabels:
      app: net-istio-webhook
      role: net-istio-webhook
  template:
    metadata:
      annotations:
        cluster-autoscaler.kubernetes.io/safe-to-evict: "false"
        sidecar.istio.io/inject: "true"
      labels:
        app: net-istio-webhook
        app.kubernetes.io/component: net-istio
        app.kubernetes.io/name: knative-serving
        app.kubernetes.io/version: 1.8.0
        role: net-istio-webhook
    spec:
      containers:
      - env:
        - name: SYSTEM_NAMESPACE
          valueFrom:
            fieldRef:
              fieldPath: metadata.namespace
        - name: CONFIG_LOGGING_NAME
          value: config-logging
        - name: CONFIG_OBSERVABILITY_NAME
          value: config-observability
        - name: METRICS_DOMAIN
          value: knative.dev/net-istio
        - name: WEBHOOK_NAME
          value: net-istio-webhook
        image: gcr.io/knative-releases/knative.dev/net-istio/cmd/webhook@sha256:59b6a46d3b55a03507c76a3afe8a4ee5f1a38f1130fd3d65c9fe57fff583fa8d
        name: webhook
        ports:
        - containerPort: 9090
          name: metrics
        - containerPort: 8008
          name: profiling
        - containerPort: 8443
          name: https-webhook
        resources:
          limits:
            cpu: 200m
            memory: 200Mi
          requests:
            cpu: 20m
            memory: 20Mi
        securityContext:
          allowPrivilegeEscalation: false
          capabilities:
            drop:
            - ALL
          runAsNonRoot: true
          seccompProfile:
            type: RuntimeDefault
      serviceAccountName: controller
      tolerations:
      - key: "kubeflow"
        operator: "Equal"
        value: "control-plane"
        effect: "NoSchedule"
      nodeSelector:
        kubeflow: control-plane
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool, kubectl_manifest.kubeflow-knative-namespace, kubectl_manifest.kubeflow-istio-deployment-istiod, kubectl_manifest.kubeflow-istio-mutatingwebhookconfiguration-sidecar-injector]
}

resource "kubectl_manifest" "kubeflow-knative-deployment-webhook" {
  yaml_body = <<YAML
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app.kubernetes.io/component: webhook
    app.kubernetes.io/name: knative-serving
    app.kubernetes.io/version: 1.8.0
  name: webhook
  namespace: knative-serving
spec:
  selector:
    matchLabels:
      app: webhook
      role: webhook
  template:
    metadata:
      annotations:
        cluster-autoscaler.kubernetes.io/safe-to-evict: "false"
        sidecar.istio.io/inject: "true"
      labels:
        app: webhook
        app.kubernetes.io/name: knative-serving
        app.kubernetes.io/version: 1.8.0
        role: webhook
    spec:
      affinity:
        podAntiAffinity:
          preferredDuringSchedulingIgnoredDuringExecution:
          - podAffinityTerm:
              labelSelector:
                matchLabels:
                  app: webhook
              topologyKey: kubernetes.io/hostname
            weight: 100
      containers:
      - env:
        - name: POD_NAME
          valueFrom:
            fieldRef:
              fieldPath: metadata.name
        - name: SYSTEM_NAMESPACE
          valueFrom:
            fieldRef:
              fieldPath: metadata.namespace
        - name: CONFIG_LOGGING_NAME
          value: config-logging
        - name: CONFIG_OBSERVABILITY_NAME
          value: config-observability
        - name: WEBHOOK_NAME
          value: webhook
        - name: WEBHOOK_PORT
          value: "8443"
        - name: METRICS_DOMAIN
          value: knative.dev/internal/serving
        image: gcr.io/knative-releases/knative.dev/serving/cmd/webhook@sha256:bc13765ba4895c0fa318a065392d05d0adc0e20415c739e0aacb3f56140bf9ae
        livenessProbe:
          failureThreshold: 6
          httpGet:
            httpHeaders:
            - name: k-kubelet-probe
              value: webhook
            port: 8443
            scheme: HTTPS
          initialDelaySeconds: 20
          periodSeconds: 1
        name: webhook
        ports:
        - containerPort: 9090
          name: metrics
        - containerPort: 8008
          name: profiling
        - containerPort: 8443
          name: https-webhook
        readinessProbe:
          httpGet:
            httpHeaders:
            - name: k-kubelet-probe
              value: webhook
            port: 8443
            scheme: HTTPS
          periodSeconds: 1
        resources:
          limits:
            cpu: 500m
            memory: 500Mi
          requests:
            cpu: 100m
            memory: 100Mi
        securityContext:
          allowPrivilegeEscalation: false
          capabilities:
            drop:
            - ALL
          readOnlyRootFilesystem: true
          runAsNonRoot: true
          seccompProfile:
            type: RuntimeDefault
      serviceAccountName: controller
      terminationGracePeriodSeconds: 300
      tolerations:
      - key: "kubeflow"
        operator: "Equal"
        value: "control-plane"
        effect: "NoSchedule"
      nodeSelector:
        kubeflow: control-plane
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool, kubectl_manifest.kubeflow-knative-namespace, kubectl_manifest.kubeflow-istio-deployment-istiod, kubectl_manifest.kubeflow-istio-mutatingwebhookconfiguration-sidecar-injector]
}

resource "kubectl_manifest" "kubeflow-knative-poddisruptionbudget-activator-pdb" {
  yaml_body = <<YAML
apiVersion: policy/v1
kind: PodDisruptionBudget
metadata:
  labels:
    app.kubernetes.io/component: activator
    app.kubernetes.io/name: knative-serving
    app.kubernetes.io/version: 1.8.0
  name: activator-pdb
  namespace: knative-serving
spec:
  minAvailable: 80%
  selector:
    matchLabels:
      app: activator
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool, kubectl_manifest.kubeflow-knative-namespace]
}

resource "kubectl_manifest" "kubeflow-knative-poddisruptionbudget-webhook-pdb" {
  yaml_body = <<YAML
apiVersion: policy/v1
kind: PodDisruptionBudget
metadata:
  labels:
    app.kubernetes.io/component: webhook
    app.kubernetes.io/name: knative-serving
    app.kubernetes.io/version: 1.8.0
  name: webhook-pdb
  namespace: knative-serving
spec:
  minAvailable: 80%
  selector:
    matchLabels:
      app: webhook
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool, kubectl_manifest.kubeflow-knative-namespace]
}

resource "kubectl_manifest" "kubeflow-knative-horizontalpodautoscaler-activator" {
  yaml_body = <<YAML
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  labels:
    app.kubernetes.io/component: activator
    app.kubernetes.io/name: knative-serving
    app.kubernetes.io/version: 1.8.0
  name: activator
  namespace: knative-serving
spec:
  maxReplicas: 20
  metrics:
  - resource:
      name: cpu
      target:
        averageUtilization: 100
        type: Utilization
    type: Resource
  minReplicas: 1
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: activator
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool, kubectl_manifest.kubeflow-knative-namespace]
}

resource "kubectl_manifest" "kubeflow-knative-horizontalpodautoscaler-webhook" {
  yaml_body = <<YAML
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  labels:
    app.kubernetes.io/component: webhook
    app.kubernetes.io/name: knative-serving
    app.kubernetes.io/version: 1.8.0
  name: webhook
  namespace: knative-serving
spec:
  maxReplicas: 5
  metrics:
  - resource:
      name: cpu
      target:
        averageUtilization: 100
        type: Utilization
    type: Resource
  minReplicas: 1
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: webhook
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool, kubectl_manifest.kubeflow-knative-namespace]
}

resource "kubectl_manifest" "kubeflow-knative-image-queue-proxy" {
  yaml_body = <<YAML
apiVersion: caching.internal.knative.dev/v1alpha1
kind: Image
metadata:
  labels:
    app.kubernetes.io/component: queue-proxy
    app.kubernetes.io/name: knative-serving
    app.kubernetes.io/version: 1.8.0
  name: queue-proxy
  namespace: knative-serving
spec:
  image: gcr.io/knative-releases/knative.dev/serving/cmd/queue@sha256:505179c0c4892ea4a70e78bc52ac21b03cd7f1a763d2ecc78e7bbaa1ae59c86c
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool, kubectl_manifest.kubeflow-knative-namespace, kubectl_manifest.kubeflow-istio-deployment-istiod, kubectl_manifest.kubeflow-istio-mutatingwebhookconfiguration-sidecar-injector]
}

resource "kubectl_manifest" "kubeflow-knative-destinationrule-knative" {
  yaml_body = <<YAML
apiVersion: networking.istio.io/v1alpha3
kind: DestinationRule
metadata:
  name: knative
  namespace: knative-serving
spec:
  host: '*.knative-serving.svc.cluster.local'
  trafficPolicy:
    tls:
      mode: ISTIO_MUTUAL
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool, kubectl_manifest.kubeflow-knative-namespace, kubectl_manifest.kubeflow-istio-crd-destinationrules]
}

resource "kubectl_manifest" "kubeflow-knative-gateway-local-gateway" {
  yaml_body = <<YAML
apiVersion: networking.istio.io/v1alpha3
kind: Gateway
metadata:
  labels:
    app.kubernetes.io/component: net-istio
    app.kubernetes.io/name: knative-serving
    app.kubernetes.io/version: 1.8.0
    networking.knative.dev/ingress-provider: istio
  name: knative-local-gateway
  namespace: knative-serving
spec:
  selector:
    app: cluster-local-gateway
    istio: cluster-local-gateway
  servers:
  - hosts:
    - '*'
    port:
      name: http
      number: 8081
      protocol: HTTP
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool, kubectl_manifest.kubeflow-knative-namespace, kubectl_manifest.kubeflow-istio-crd-gateways]
}

resource "kubectl_manifest" "kubeflow-knative-authorizationpolicy-activator-service" {
  yaml_body = <<YAML
apiVersion: security.istio.io/v1beta1
kind: AuthorizationPolicy
metadata:
  name: activator-service
  namespace: knative-serving
spec:
  action: ALLOW
  rules:
  - {}
  selector:
    matchLabels:
      app: activator
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool, kubectl_manifest.kubeflow-knative-namespace, kubectl_manifest.kubeflow-istio-crd-authorizationpolicies]
}

resource "kubectl_manifest" "kubeflow-knative-authorizationpolicy-autoscaler" {
  yaml_body = <<YAML
apiVersion: security.istio.io/v1beta1
kind: AuthorizationPolicy
metadata:
  name: autoscaler
  namespace: knative-serving
spec:
  action: ALLOW
  rules:
  - {}
  selector:
    matchLabels:
      app: autoscaler
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool, kubectl_manifest.kubeflow-knative-namespace, kubectl_manifest.kubeflow-istio-crd-authorizationpolicies]
}

resource "kubectl_manifest" "kubeflow-knative-authorizationpolicy-controller" {
  yaml_body = <<YAML
apiVersion: security.istio.io/v1beta1
kind: AuthorizationPolicy
metadata:
  name: controller
  namespace: knative-serving
spec:
  action: ALLOW
  rules:
  - {}
  selector:
    matchLabels:
      app: controller
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool, kubectl_manifest.kubeflow-knative-namespace, kubectl_manifest.kubeflow-istio-crd-authorizationpolicies]
}

resource "kubectl_manifest" "kubeflow-knative-authorizationpolicy-istio-webhook" {
  yaml_body = <<YAML
apiVersion: security.istio.io/v1beta1
kind: AuthorizationPolicy
metadata:
  name: istio-webhook
  namespace: knative-serving
spec:
  action: ALLOW
  rules:
  - {}
  selector:
    matchLabels:
      app: net-istio-webhook
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool, kubectl_manifest.kubeflow-knative-namespace, kubectl_manifest.kubeflow-istio-crd-authorizationpolicies]
}

resource "kubectl_manifest" "kubeflow-knative-authorizationpolicy-webhook" {
  yaml_body = <<YAML
apiVersion: security.istio.io/v1beta1
kind: AuthorizationPolicy
metadata:
  name: webhook
  namespace: knative-serving
spec:
  action: ALLOW
  rules:
  - {}
  selector:
    matchLabels:
      role: webhook
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool, kubectl_manifest.kubeflow-knative-namespace, kubectl_manifest.kubeflow-istio-crd-authorizationpolicies]
}

resource "kubectl_manifest" "kubeflow-knative-peerauthentication-domainmapping-webhook" {
  yaml_body = <<YAML
apiVersion: security.istio.io/v1beta1
kind: PeerAuthentication
metadata:
  labels:
    app.kubernetes.io/component: net-istio
    app.kubernetes.io/name: knative-serving
    app.kubernetes.io/version: 1.8.0
    networking.knative.dev/ingress-provider: istio
  name: domainmapping-webhook
  namespace: knative-serving
spec:
  portLevelMtls:
    "8443":
      mode: PERMISSIVE
  selector:
    matchLabels:
      app: domainmapping-webhook
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool, kubectl_manifest.kubeflow-knative-namespace, kubectl_manifest.kubeflow-istio-crd-peerauthentications]
}

resource "kubectl_manifest" "kubeflow-knative-peerauthentication-net-istio-webhook" {
  yaml_body = <<YAML
apiVersion: security.istio.io/v1beta1
kind: PeerAuthentication
metadata:
  labels:
    app.kubernetes.io/component: net-istio
    app.kubernetes.io/name: knative-serving
    app.kubernetes.io/version: 1.8.0
    networking.knative.dev/ingress-provider: istio
  name: net-istio-webhook
  namespace: knative-serving
spec:
  portLevelMtls:
    "8443":
      mode: PERMISSIVE
  selector:
    matchLabels:
      app: net-istio-webhook
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool, kubectl_manifest.kubeflow-knative-namespace, kubectl_manifest.kubeflow-istio-crd-peerauthentications]
}

resource "kubectl_manifest" "kubeflow-knative-peerauthentication-webhook" {
  yaml_body = <<YAML
apiVersion: security.istio.io/v1beta1
kind: PeerAuthentication
metadata:
  labels:
    app.kubernetes.io/component: net-istio
    app.kubernetes.io/name: knative-serving
    app.kubernetes.io/version: 1.8.0
    networking.knative.dev/ingress-provider: istio
  name: webhook
  namespace: knative-serving
spec:
  portLevelMtls:
    "8443":
      mode: PERMISSIVE
  selector:
    matchLabels:
      app: webhook
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool, kubectl_manifest.kubeflow-knative-namespace, kubectl_manifest.kubeflow-istio-crd-peerauthentications]
}

resource "kubectl_manifest" "kubeflow-knative-mutatingwebhookconfiguration-webhook-domainmapping-serving-knative-dev" {
  yaml_body = <<YAML
apiVersion: admissionregistration.k8s.io/v1
kind: MutatingWebhookConfiguration
metadata:
  labels:
    app.kubernetes.io/component: domain-mapping
    app.kubernetes.io/name: knative-serving
    app.kubernetes.io/version: 1.8.0
  name: webhook.domainmapping.serving.knative.dev
webhooks:
- admissionReviewVersions:
  - v1
  - v1beta1
  clientConfig:
    service:
      name: domainmapping-webhook
      namespace: knative-serving
  failurePolicy: Fail
  name: webhook.domainmapping.serving.knative.dev
  rules:
  - apiGroups:
    - serving.knative.dev
    apiVersions:
    - '*'
    operations:
    - CREATE
    - UPDATE
    resources:
    - domainmappings
    - domainmappings/status
    scope: '*'
  sideEffects: None
  timeoutSeconds: 10
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool, kubectl_manifest.kubeflow-knative-namespace]
}

resource "kubectl_manifest" "kubeflow-knative-mutatingwebhookconfiguration-webhook-istio-networking-internal-knative-dev" {
  yaml_body = <<YAML
apiVersion: admissionregistration.k8s.io/v1
kind: MutatingWebhookConfiguration
metadata:
  labels:
    app.kubernetes.io/component: net-istio
    app.kubernetes.io/name: knative-serving
    app.kubernetes.io/version: 1.8.0
    networking.knative.dev/ingress-provider: istio
  name: webhook.istio.networking.internal.knative.dev
webhooks:
- admissionReviewVersions:
  - v1
  - v1beta1
  clientConfig:
    service:
      name: net-istio-webhook
      namespace: knative-serving
  failurePolicy: Fail
  name: webhook.istio.networking.internal.knative.dev
  objectSelector:
    matchExpressions:
    - key: serving.knative.dev/configuration
      operator: Exists
  sideEffects: None
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool, kubectl_manifest.kubeflow-knative-namespace]
}

resource "kubectl_manifest" "kubeflow-knative-mutatingwebhookconfiguration-webhook-serving-knative-dev" {
  yaml_body = <<YAML
apiVersion: admissionregistration.k8s.io/v1
kind: MutatingWebhookConfiguration
metadata:
  labels:
    app.kubernetes.io/component: webhook
    app.kubernetes.io/name: knative-serving
    app.kubernetes.io/version: 1.8.0
  name: webhook.serving.knative.dev
webhooks:
- admissionReviewVersions:
  - v1
  - v1beta1
  clientConfig:
    service:
      name: webhook
      namespace: knative-serving
  failurePolicy: Fail
  name: webhook.serving.knative.dev
  rules:
  - apiGroups:
    - autoscaling.internal.knative.dev
    - networking.internal.knative.dev
    - serving.knative.dev
    apiVersions:
    - '*'
    operations:
    - CREATE
    - UPDATE
    resources:
    - metrics
    - podautoscalers
    - certificates
    - ingresses
    - serverlessservices
    - configurations
    - revisions
    - routes
    - services
    scope: '*'
  sideEffects: None
  timeoutSeconds: 10
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool, kubectl_manifest.kubeflow-knative-namespace]
}

resource "kubectl_manifest" "kubeflow-knative-validatingwebhookconfiguration-config-webhook-istio-networking-internal-knative-dev" {
  yaml_body = <<YAML
apiVersion: admissionregistration.k8s.io/v1
kind: ValidatingWebhookConfiguration
metadata:
  labels:
    app.kubernetes.io/component: net-istio
    app.kubernetes.io/name: knative-serving
    app.kubernetes.io/version: 1.8.0
    networking.knative.dev/ingress-provider: istio
  name: config.webhook.istio.networking.internal.knative.dev
webhooks:
- admissionReviewVersions:
  - v1
  - v1beta1
  clientConfig:
    service:
      name: net-istio-webhook
      namespace: knative-serving
  failurePolicy: Fail
  name: config.webhook.istio.networking.internal.knative.dev
  objectSelector:
    matchLabels:
      app.kubernetes.io/component: net-istio
      app.kubernetes.io/name: knative-serving
  sideEffects: None
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool, kubectl_manifest.kubeflow-knative-namespace]
}

resource "kubectl_manifest" "kubeflow-knative-validatingwebhookconfiguration-config-webhook-serving-knative-dev" {
  yaml_body = <<YAML
apiVersion: admissionregistration.k8s.io/v1
kind: ValidatingWebhookConfiguration
metadata:
  labels:
    app.kubernetes.io/component: webhook
    app.kubernetes.io/name: knative-serving
    app.kubernetes.io/version: 1.8.0
  name: config.webhook.serving.knative.dev
webhooks:
- admissionReviewVersions:
  - v1
  - v1beta1
  clientConfig:
    service:
      name: webhook
      namespace: knative-serving
  failurePolicy: Fail
  name: config.webhook.serving.knative.dev
  objectSelector:
    matchExpressions:
    - key: app.kubernetes.io/name
      operator: In
      values:
      - knative-serving
    - key: app.kubernetes.io/component
      operator: In
      values:
      - autoscaler
      - controller
      - logging
      - networking
      - observability
      - tracing
  sideEffects: None
  timeoutSeconds: 10
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool, kubectl_manifest.kubeflow-knative-namespace]
}

resource "kubectl_manifest" "kubeflow-knative-validatingwebhookconfiguratrion-validation-webhook-domainmapping-serving-knative-dev" {
  yaml_body = <<YAML
apiVersion: admissionregistration.k8s.io/v1
kind: ValidatingWebhookConfiguration
metadata:
  labels:
    app.kubernetes.io/component: domain-mapping
    app.kubernetes.io/name: knative-serving
    app.kubernetes.io/version: 1.8.0
  name: validation.webhook.domainmapping.serving.knative.dev
webhooks:
- admissionReviewVersions:
  - v1
  - v1beta1
  clientConfig:
    service:
      name: domainmapping-webhook
      namespace: knative-serving
  failurePolicy: Fail
  name: validation.webhook.domainmapping.serving.knative.dev
  rules:
  - apiGroups:
    - serving.knative.dev
    apiVersions:
    - '*'
    operations:
    - CREATE
    - UPDATE
    - DELETE
    resources:
    - domainmappings
    - domainmappings/status
    scope: '*'
  sideEffects: None
  timeoutSeconds: 10
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool, kubectl_manifest.kubeflow-knative-namespace]
}

resource "kubectl_manifest" "kubeflow-knative-validatingwebhookconfiguration-validation-webhook-serving-knative-dev" {
  yaml_body = <<YAML
apiVersion: admissionregistration.k8s.io/v1
kind: ValidatingWebhookConfiguration
metadata:
  labels:
    app.kubernetes.io/component: webhook
    app.kubernetes.io/name: knative-serving
    app.kubernetes.io/version: 1.8.0
  name: validation.webhook.serving.knative.dev
webhooks:
- admissionReviewVersions:
  - v1
  - v1beta1
  clientConfig:
    service:
      name: webhook
      namespace: knative-serving
  failurePolicy: Fail
  name: validation.webhook.serving.knative.dev
  rules:
  - apiGroups:
    - autoscaling.internal.knative.dev
    - networking.internal.knative.dev
    - serving.knative.dev
    apiVersions:
    - '*'
    operations:
    - CREATE
    - UPDATE
    - DELETE
    resources:
    - metrics
    - podautoscalers
    - certificates
    - ingresses
    - serverlessservices
    - configurations
    - revisions
    - routes
    - services
    scope: '*'
  sideEffects: None
  timeoutSeconds: 10
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool, kubectl_manifest.kubeflow-knative-namespace]
}

resource "kubectl_manifest" "kubeflow-knative-serviceaccount-cluster-local-gateway-service-account" {
  yaml_body = <<YAML
apiVersion: v1
kind: ServiceAccount
metadata:
  labels:
    app: cluster-local-gateway
    install.operator.istio.io/owning-resource: unknown
    istio: cluster-local-gateway
    istio.io/rev: default
    operator.istio.io/component: IngressGateways
    release: istio
  name: cluster-local-gateway-service-account
  namespace: istio-system
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool, kubectl_manifest.kubeflow-istio-namespace]
}

resource "kubectl_manifest" "kubeflow-knative-role-cluster-local-gateway-sds" {
  yaml_body = <<YAML
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  labels:
    install.operator.istio.io/owning-resource: unknown
    istio.io/rev: default
    operator.istio.io/component: IngressGateways
    release: istio
  name: cluster-local-gateway-sds
  namespace: istio-system
rules:
- apiGroups:
  - ""
  resources:
  - secrets
  verbs:
  - get
  - watch
  - list
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool, kubectl_manifest.kubeflow-istio-namespace]
}

resource "kubectl_manifest" "kubeflow-knative-rolebinding-cluster-local-gateway-sds" {
  yaml_body = <<YAML
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  labels:
    install.operator.istio.io/owning-resource: unknown
    istio.io/rev: default
    operator.istio.io/component: IngressGateways
    release: istio
  name: cluster-local-gateway-sds
  namespace: istio-system
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: Role
  name: cluster-local-gateway-sds
subjects:
- kind: ServiceAccount
  name: cluster-local-gateway-service-account
  namespace: istio-system
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool, kubectl_manifest.kubeflow-istio-namespace]
}

resource "kubectl_manifest" "kubeflow-knative-service-cluster-local-gateway" {
  yaml_body = <<YAML
apiVersion: v1
kind: Service
metadata:
  labels:
    app: cluster-local-gateway
    install.operator.istio.io/owning-resource: unknown
    istio: cluster-local-gateway
    istio.io/rev: default
    operator.istio.io/component: IngressGateways
    release: istio
  name: cluster-local-gateway
  namespace: istio-system
spec:
  ports:
  - name: status-port
    port: 15020
    protocol: TCP
    targetPort: 15020
  - name: http2
    port: 80
    protocol: TCP
    targetPort: 8080
  selector:
    app: cluster-local-gateway
    istio: cluster-local-gateway
  type: ClusterIP
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool, kubectl_manifest.kubeflow-istio-namespace]
}

resource "kubectl_manifest" "kubeflow-knative-deployment-cluster-local-gateway" {
  yaml_body = <<YAML
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: cluster-local-gateway
    install.operator.istio.io/owning-resource: unknown
    istio: cluster-local-gateway
    istio.io/rev: default
    operator.istio.io/component: IngressGateways
    release: istio
  name: cluster-local-gateway
  namespace: istio-system
spec:
  selector:
    matchLabels:
      app: cluster-local-gateway
      istio: cluster-local-gateway
  strategy:
    rollingUpdate:
      maxSurge: 100%
      maxUnavailable: 25%
  template:
    metadata:
      annotations:
        prometheus.io/path: /stats/prometheus
        prometheus.io/port: "15020"
        prometheus.io/scrape: "true"
        sidecar.istio.io/inject: "false"
      labels:
        app: cluster-local-gateway
        chart: gateways
        heritage: Tiller
        install.operator.istio.io/owning-resource: unknown
        istio: cluster-local-gateway
        istio.io/rev: default
        operator.istio.io/component: IngressGateways
        release: istio
        service.istio.io/canonical-name: cluster-local-gateway
        service.istio.io/canonical-revision: latest
        sidecar.istio.io/inject: "false"
    spec:
      affinity:
        nodeAffinity:
          preferredDuringSchedulingIgnoredDuringExecution: null
          requiredDuringSchedulingIgnoredDuringExecution: null
      containers:
      - args:
        - proxy
        - router
        - --domain
        - $(POD_NAMESPACE).svc.cluster.local
        - --proxyLogLevel=warning
        - --proxyComponentLogLevel=misc:error
        - --log_output_level=default:info
        env:
        - name: ISTIO_META_ROUTER_MODE
          value: sni-dnat
        - name: JWT_POLICY
          value: third-party-jwt
        - name: PILOT_CERT_PROVIDER
          value: istiod
        - name: CA_ADDR
          value: istiod.istio-system.svc:15012
        - name: NODE_NAME
          valueFrom:
            fieldRef:
              apiVersion: v1
              fieldPath: spec.nodeName
        - name: POD_NAME
          valueFrom:
            fieldRef:
              apiVersion: v1
              fieldPath: metadata.name
        - name: POD_NAMESPACE
          valueFrom:
            fieldRef:
              apiVersion: v1
              fieldPath: metadata.namespace
        - name: INSTANCE_IP
          valueFrom:
            fieldRef:
              apiVersion: v1
              fieldPath: status.podIP
        - name: HOST_IP
          valueFrom:
            fieldRef:
              apiVersion: v1
              fieldPath: status.hostIP
        - name: SERVICE_ACCOUNT
          valueFrom:
            fieldRef:
              fieldPath: spec.serviceAccountName
        - name: ISTIO_META_WORKLOAD_NAME
          value: cluster-local-gateway
        - name: ISTIO_META_OWNER
          value: kubernetes://apis/apps/v1/namespaces/istio-system/deployments/cluster-local-gateway
        - name: ISTIO_META_MESH_ID
          value: cluster.local
        - name: TRUST_DOMAIN
          value: cluster.local
        - name: ISTIO_META_UNPRIVILEGED_POD
          value: "true"
        - name: ISTIO_META_CLUSTER_ID
          value: Kubernetes
        image: docker.io/istio/proxyv2:1.16.0
        name: istio-proxy
        ports:
        - containerPort: 15020
          protocol: TCP
        - containerPort: 8080
          protocol: TCP
        - containerPort: 15090
          name: http-envoy-prom
          protocol: TCP
        readinessProbe:
          failureThreshold: 30
          httpGet:
            path: /healthz/ready
            port: 15021
            scheme: HTTP
          initialDelaySeconds: 1
          periodSeconds: 2
          successThreshold: 1
          timeoutSeconds: 1
        resources:
          limits:
            cpu: 2000m
            memory: 1024Mi
          requests:
            cpu: 100m
            memory: 128Mi
        securityContext:
          allowPrivilegeEscalation: false
          capabilities:
            drop:
            - ALL
          privileged: false
          readOnlyRootFilesystem: true
        volumeMounts:
        - mountPath: /var/run/secrets/workload-spiffe-uds
          name: workload-socket
        - mountPath: /var/run/secrets/credential-uds
          name: credential-socket
        - mountPath: /var/run/secrets/workload-spiffe-credentials
          name: workload-certs
        - mountPath: /etc/istio/proxy
          name: istio-envoy
        - mountPath: /etc/istio/config
          name: config-volume
        - mountPath: /var/run/secrets/istio
          name: istiod-ca-cert
        - mountPath: /var/run/secrets/tokens
          name: istio-token
          readOnly: true
        - mountPath: /var/lib/istio/data
          name: istio-data
        - mountPath: /etc/istio/pod
          name: podinfo
        - mountPath: /etc/istio/ingressgateway-certs
          name: ingressgateway-certs
          readOnly: true
        - mountPath: /etc/istio/ingressgateway-ca-certs
          name: ingressgateway-ca-certs
          readOnly: true
      securityContext:
        fsGroup: 1337
        runAsGroup: 1337
        runAsNonRoot: true
        runAsUser: 1337
      serviceAccountName: cluster-local-gateway-service-account
      volumes:
      - emptyDir: {}
        name: workload-socket
      - emptyDir: {}
        name: credential-socket
      - emptyDir: {}
        name: workload-certs
      - configMap:
          name: istio-ca-root-cert
        name: istiod-ca-cert
      - downwardAPI:
          items:
          - fieldRef:
              fieldPath: metadata.labels
            path: labels
          - fieldRef:
              fieldPath: metadata.annotations
            path: annotations
        name: podinfo
      - emptyDir: {}
        name: istio-envoy
      - emptyDir: {}
        name: istio-data
      - name: istio-token
        projected:
          sources:
          - serviceAccountToken:
              audience: istio-ca
              expirationSeconds: 43200
              path: istio-token
      - configMap:
          name: istio
          optional: true
        name: config-volume
      - name: ingressgateway-certs
        secret:
          optional: true
          secretName: istio-ingressgateway-certs
      - name: ingressgateway-ca-certs
        secret:
          optional: true
          secretName: istio-ingressgateway-ca-certs
      tolerations:
      - key: "kubeflow"
        operator: "Equal"
        value: "control-plane"
        effect: "NoSchedule"
      nodeSelector:
        kubeflow: control-plane
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool, kubectl_manifest.kubeflow-istio-namespace, kubectl_manifest.kubeflow-istio-deployment-istiod, kubectl_manifest.kubeflow-istio-mutatingwebhookconfiguration-sidecar-injector]
}

resource "kubectl_manifest" "kubeflow-knative-horizontalpodautoscaler-cluster-local-gateway" {
  yaml_body = <<YAML
apiVersion: policy/v1
kind: PodDisruptionBudget
metadata:
  labels:
    app: cluster-local-gateway
    install.operator.istio.io/owning-resource: unknown
    istio: cluster-local-gateway
    istio.io/rev: default
    operator.istio.io/component: IngressGateways
    release: istio
  name: cluster-local-gateway
  namespace: istio-system
spec:
  minAvailable: 1
  selector:
    matchLabels:
      app: cluster-local-gateway
      istio: cluster-local-gateway
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool, kubectl_manifest.kubeflow-istio-namespace]
}

resource "kubectl_manifest" "kubeflow-knative-gateway-cluster-local-gateway" {
  yaml_body = <<YAML
apiVersion: networking.istio.io/v1alpha3
kind: Gateway
metadata:
  labels:
    release: istio
  name: cluster-local-gateway
  namespace: istio-system
spec:
  selector:
    app: cluster-local-gateway
    istio: cluster-local-gateway
  servers:
  - hosts:
    - '*'
    port:
      name: http
      number: 80
      protocol: HTTP
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool, kubectl_manifest.kubeflow-istio-namespace, kubectl_manifest.kubeflow-istio-crd-gateways]
}

resource "kubectl_manifest" "kubeflow-knative-authorizationpolicy-cluster-local-gateway" {
  yaml_body = <<YAML
apiVersion: security.istio.io/v1beta1
kind: AuthorizationPolicy
metadata:
  name: cluster-local-gateway
  namespace: istio-system
spec:
  action: ALLOW
  rules:
  - {}
  selector:
    matchLabels:
      app: cluster-local-gateway
      istio: cluster-local-gateway
YAML

depends_on = [ovh_cloud_project_kube.ovh_kube_cluster, ovh_cloud_project_kube_nodepool.control_plane_pool, kubectl_manifest.kubeflow-istio-namespace, kubectl_manifest.kubeflow-istio-crd-authorizationpolicies]
}