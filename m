From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Subject: [PATCH v9 22/22] s390: doc: detailed specifications for AP virtualization
Date: Mon, 13 Aug 2018 17:48:19 -0400
Message-ID: <1534196899-16987-23-git-send-email-akrowiak@linux.vnet.ibm.com>
References: <1534196899-16987-1-git-send-email-akrowiak@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1534196899-16987-1-git-send-email-akrowiak@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com, akrowiak@linux.vnet.ibm.com, frankja@linux.ibm.com, Tony Krowiak <akrowiak@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Tony Krowiak <akrowiak@linux.ibm.com>

This patch provides documentation describing the AP architecture and
design concepts behind the virtualization of AP devices. It also
includes an example of how to configure AP devices for exclusive
use of KVM guests.

Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 Documentation/s390/vfio-ap.txt |  615 ++++++++++++++++++++++++++++++++++++++++
 MAINTAINERS                    |    1 +
 2 files changed, 616 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/s390/vfio-ap.txt

diff --git a/Documentation/s390/vfio-ap.txt b/Documentation/s390/vfio-ap.txt
new file mode 100644
index 0000000..524951a
--- /dev/null
+++ b/Documentation/s390/vfio-ap.txt
@@ -0,0 +1,615 @@
+Introduction:
+============
+The Adjunct Processor (AP) facility is an IBM Z cryptographic facility comprised
+of three AP instructions and from 1 up to 256 PCIe cryptographic adapter cards.
+The AP devices provide cryptographic functions to all CPUs assigned to a
+linux system running in an IBM Z system LPAR.
+
+The AP adapter cards are exposed via the AP bus. The motivation for vfio-ap
+is to make AP cards available to KVM guests using the VFIO mediated device
+framework. This implementation relies considerably on the s390 virtualization
+facilities which do most of the hard work of providing direct access to AP
+devices.
+
+AP Architectural Overview:
+=========================
+To facilitate the comprehension of the design, let's start with some
+definitions:
+
+* AP adapter
+
+  An AP adapter is an IBM Z adapter card that can perform cryptographic
+  functions. There can be from 0 to 256 adapters assigned to an LPAR. Adapters
+  assigned to the LPAR in which a linux host is running will be available to
+  the linux host. Each adapter is identified by a number from 0 to 255. When
+  installed, an AP adapter is accessed by AP instructions executed by any CPU.
+
+  The AP adapter cards are assigned to a given LPAR via the system's Activation
+  Profile which can be edited via the HMC. When the system is IPL'd, the AP bus
+  module is loaded and detects the AP adapter cards assigned to the LPAR. The AP
+  bus creates a sysfs device for each adapter as they are detected. For example,
+  if AP adapters 4 and 10 (0x0a) are assigned to the LPAR, the AP bus will
+  create the following sysfs entries:
+
+    /sys/devices/ap/card04
+    /sys/devices/ap/card0a
+
+  Symbolic links to these devices will also be created in the AP bus devices
+  sub-directory:
+
+    /sys/bus/ap/devices/[card04]
+    /sys/bus/ap/devices/[card04]
+
+* AP domain
+
+  An adapter is partitioned into domains. Each domain can be thought of as
+  a set of hardware registers for processing AP instructions. An adapter can
+  hold up to 256 domains. Each domain is identified by a number from 0 to 255.
+  Domains can be further classified into two types:
+
+    * Usage domains are domains that can be accessed directly to process AP
+      commands.
+
+    * Control domains are domains that are accessed indirectly by AP
+      commands sent to a usage domain to control or change the domain; for
+      example, to set a secure private key for the domain.
+
+  The AP usage and control domains are assigned to a given LPAR via the system's
+  Activation Profile which can be edited via the HMC. When the system is IPL'd,
+  the AP bus module is loaded and detects the AP usage and control domains
+  assigned to the LPAR. The domain number of each usage domain will be coupled
+  with the adapter number of each AP adapter assigned to the LPAR to identify
+  the AP queues (see AP Queue section below). The domain number of each control
+  domain will be represented in a bitmask and stored in a sysfs file
+  /sys/bus/ap/ap_control_domain_mask created by the bus. The bits in the mask,
+  from most to least significant bit, correspond to domains 0-255.
+
+  A domain may be assigned to a system as both a usage and control domain, or
+  as a control domain only. Consequently, all domains assigned as both a usage
+  and control domain can both process AP commands as well as be changed by an AP
+  command sent to any usage domain assigned to the same system. Domains assigned
+  only as control domains can not process AP commands but can be changed by AP
+  commands sent to any usage domain assigned to the system.
+
+* AP Queue
+
+  An AP queue is the means by which an AP command-request message is sent to a
+  usage domain inside a specific adapter. An AP queue is identified by a tuple
+  comprised of an AP adapter ID (APID) and an AP queue index (APQI). The
+  APQI corresponds to a given usage domain number within the adapter. This tuple
+  forms an AP Queue Number (APQN) uniquely identifying an AP queue. AP
+  instructions include a field containing the APQN to identify the AP queue to
+  which the AP command-request message is to be sent for processing.
+
+  The AP bus will create a sysfs device for each APQN that can be derived from
+  the cross product of the AP adapter and usage domain numbers detected when the
+  AP bus module is loaded. For example, if adapters 4 and 10 (0x0a) and usage
+  domains 6 and 71 (0x47) are assigned to the LPAR, the AP bus will create the
+  following sysfs entries:
+
+    /sys/devices/ap/card04/04.0006
+    /sys/devices/ap/card04/04.0047
+    /sys/devices/ap/card0a/0a.0006
+    /sys/devices/ap/card0a/0a.0047
+
+  The following symbolic links to these devices will be created in the AP bus
+  devices subdirectory:
+
+    /sys/bus/ap/devices/[04.0006]
+    /sys/bus/ap/devices/[04.0047]
+    /sys/bus/ap/devices/[0a.0006]
+    /sys/bus/ap/devices/[0a.0047]
+
+* AP Instructions:
+
+  There are three AP instructions:
+
+  * NQAP: to enqueue an AP command-request message to a queue
+  * DQAP: to dequeue an AP command-reply message from a queue
+  * PQAP: to administer the queues
+
+AP and SIE:
+==========
+Let's now take a look at how AP instructions executed on a guest are interpreted
+by the hardware.
+
+A satellite control block called the Crypto Control Block (CRYCB) is attached to
+our main hardware virtualization control block. The CRYCB contains three fields
+to identify the adapters, usage domains and control domains assigned to the KVM
+guest:
+
+* The AP Mask (APM) field is a bit mask that identifies the AP adapters assigned
+  to the KVM guest. Each bit in the mask, from most significant to least
+  significant bit, corresponds to an APID from 0-255. If a bit is set, the
+  corresponding adapter is valid for use by the KVM guest.
+
+* The AP Queue Mask (AQM) field is a bit mask identifying the AP usage domains
+  assigned to the KVM guest. Each bit in the mask, from most significant to
+  least significant bit, corresponds to an AP queue index (APQI) from 0-255. If
+  a bit is set, the corresponding queue is valid for use by the KVM guest.
+
+* The AP Domain Mask field is a bit mask that identifies the AP control domains
+  assigned to the KVM guest. The ADM bit mask controls which domains can be
+  changed by an AP command-request message sent to a usage domain from the
+  guest. Each bit in the mask, from least significant to most significant bit,
+  corresponds to a domain from 0-255. If a bit is set, the corresponding domain
+  can be modified by an AP command-request message sent to a usage domain
+  configured for the KVM guest.
+
+If you recall from the description of an AP Queue, AP instructions include
+an APQN to identify the AP adapter and AP queue to which an AP command-request
+message is to be sent (NQAP and PQAP instructions), or from which a
+command-reply message is to be received (DQAP instruction). The validity of an
+APQN is defined by the matrix calculated from the APM and AQM; it is the
+cross product of all assigned adapter numbers (APM) with all assigned queue
+indexes (AQM). For example, if adapters 1 and 2 and usage domains 5 and 6 are
+assigned to a guest, the APQNs (1,5), (1,6), (2,5) and (2,6) will be valid for
+the guest.
+
+The APQNs can provide secure key functionality - i.e., a private key is stored
+on the adapter card for each of its domains - so each APQN must be assigned to
+at most one guest or to the linux host.
+
+   Example 1: Valid configuration:
+   ------------------------------
+   Guest1: adapters 1,2  domains 5,6
+   Guest2: adapter  1,2  domain 7
+
+   This is valid because both guests have a unique set of APQNs: Guest1 has
+   APQNs (1,5), (1,6), (2,5) and (2,6); Guest2 has APQNs (1,7) and (2,7).
+
+   Example 2: Invalid configuration:
+   Guest1: adapters 1,2  domains 5,6
+   Guest2: adapter  1    domains 6,7
+
+   This is an invalid configuration because both guests have access to
+   APQN (1,6).
+
+The Design:
+===========
+The design introduces three new objects:
+
+1. AP matrix device
+2. VFIO AP device driver (vfio_ap.ko)
+3. AP mediated matrix passthrough device
+
+The VFIO AP device driver
+-------------------------
+The VFIO AP (vfio_ap) device driver serves the following purposes:
+
+1. Provides the interfaces to bind APQNs for exclusive use of KVM guests.
+
+2. Sets up the VFIO mediated device interfaces to manage a mediated matrix
+   device and creates the sysfs interfaces for assigning adapters, usage
+   domains, and control domains comprising the matrix for a KVM guest.
+
+3. Configures the APM, AQM and ADM in the CRYCB referenced by a KVM guest's
+   SIE state description to grant the guest access to a matrix of AP devices
+
+Reserve APQNs for exclusive use of KVM guests
+---------------------------------------------
+The following block diagram illustrates the mechanism by which APQNs are
+reserved:
+
+                              +------------------+
+                       remove |                  |
+         +------------------->+ cex4queue driver +
+         |                    |                  |
+         |                    +------------------+
+         |
+         |
+         |             remove +------------------+
+         |  +-----------------+                  |<---------------+
+         |  |          probe  |   Device core    |                |
+         |  |  +--------------+                  +<-----------+   |
+         |  |  |              +--------+---------+            |   |
+         |  |  |                       ^                      |   |
+         |  |  |        register       |                      |   |
+         |  |  |        vfio_ap device |                 bind |   | unbind
+         |  v  v                       |              vfio_ap |   | cex4queue
++--------+-----+---+          +--------+---------+      +-+---+---+--+
+|                  | register |                  |      |            |
+|      ap_bus      +<---------+  vfio_ap driver  +      +    admin   |
+|                  +--------->+                  |      |            |
++------------------+  probe   +---+--------+-----+      +------------+
+                                  |        |
+                           create |        | assign
+                                  |        | adapters/domains/control domains
+                                  v        v
+                              +---+--------+-----+
+                              |                  |
+                              |  mediated device |
+                              |                  |
+                              +------------------+
+
+The process for reserving an AP queue for use by a KVM guest is:
+
+* The vfio-ap driver during its initialization will perform the following:
+  * Create a single 'matrix' device, /sys/devices/vfio_ap/matrix. This will
+    serve as the parent device for all mediated matrix devices used to configure
+    an AP matrix which is the cross product of all AP adapter IDs (APID) and
+    queue indexes (APQI) assigned to a guest.
+  * Register the matrix device with the device core
+* Register with the ap_bus for AP queue devices of type 10 (CEX4 and
+  newer) and to provide the vfio_ap driver's probe and remove callback
+  interfaces. Devices older than CEX4 queues are not supported to simplify the
+  implementation and because older devices will be going out of service in the
+  relatively near future.
+* The admin needs to unbind AP Queues to be reserved for use by guests from
+  the cex4queue device driver and bind them to the vfio_ap device driver.
+
+
+Set up the VFIO mediated device interfaces
+------------------------------------------
+The VFIO AP device driver utilizes the common interface of the VFIO mediated
+device core driver to:
+* Register an AP mediated bus driver to add a mediated matrix device to and
+  remove it from a VFIO group.
+* Create and destroy a mediated matrix device
+* Add a mediated matrix device to and remove it from the AP mediated bus driver
+* Add a mediated matrix device to and remove it from an IOMMU group
+
+The following high-level block diagram shows the main components and interfaces
+of the VFIO AP mediated matrix device driver:
+
+ +-------------+
+ |             |
+ | +---------+ | mdev_register_driver() +--------------+
+ | |  Mdev   | +<-----------------------+              |
+ | |  bus    | |                        | vfio_mdev.ko |
+ | | driver  | +----------------------->+              |<-> VFIO user
+ | +---------+ |    probe()/remove()    +--------------+    APIs
+ |             |
+ |  MDEV CORE  |
+ |   MODULE    |
+ |   mdev.ko   |
+ | +---------+ | mdev_register_device() +--------------+
+ | |Physical | +<-----------------------+              |
+ | | device  | |                        |  vfio_ap.ko  |<-> matrix
+ | |interface| +----------------------->+              |    device
+ | +---------+ |       callback         +--------------+
+ +-------------+
+
+During initialization of the vfio_ap module, the matrix device is registered
+with an 'mdev_parent_ops' structure that provides the sysfs attribute
+structures, mdev functions and callback interfaces for managing the mediated
+matrix device.
+
+* sysfs attribute structures:
+  * supported_type_groups
+    The VFIO mediated device framework supports creation of user-defined
+    mediated device types. These mediated device types are specified
+    via the 'supported_type_groups' structure when a device is registered
+    with the mediated device framework. The registration process creates the
+    sysfs structures for each mediated device type specified in the
+    'mdev_supported_types' sub-directory of the device being registered. Along
+    with the device type, the sysfs attributes of the mediated device type are
+    provided.
+
+    The VFIO AP device driver will register one mediated device type for
+    passthrough devices:
+      /sys/devices/vfio_ap/matrix/mdev_supported_types/vfio_ap-passthrough
+    Only the read-only attributes required by the VFIO mdev framework will
+    be provided:
+        ... name
+        ... device_api
+        ... available_instances
+        ... device_api
+        Where:
+        * name: specifies the name of the mediated device type
+        * device_api: the mediated device type's API
+        * available_instances: the number of mediated matrix passthrough devices
+                               that can be created
+        * device_api: specifies the VFIO API
+  * mdev_attr_groups
+    This attribute group identifies the user-defined sysfs attributes of the
+    mediated device. When a device is registered with the VFIO mediated device
+    framework, the sysfs attributes files identified in the 'mdev_attr_groups'
+    structure will be created in the mediated matrix device's directory. The
+    sysfs attributes for a mediated matrix device are:
+    * assign_adapter:
+    * unassign_adapter:
+      Write-only attributes for assigning/unassigning an AP adapter to/from the
+      mediated matrix device. To assign/unassign an adapter, the APID of the
+      adapter is written to the respective attribute file.
+    * assign_domain:
+    * unassign_domain:
+      Write-only attributes for assigning/unassigning an AP usage domain to/from
+      the mediated matrix device. To assign/unassign a domain, the APQI of the
+      AP queue corresponding to a usage domain is written to the respective
+      attribute file.
+    * matrix:
+      A read-only file for displaying the APQNs derived from the cross product
+      of the adapters and domains assigned to the mediated matrix device.
+    * assign_control_domain:
+    * unassign_control_domain:
+      Write-only attributes for assigning/unassigning an AP control domain
+      to/from the mediated matrix device. To assign/unassign a control domain,
+      the ID of a domain to be assigned/unassigned is written to the respective
+      attribute file.
+    * control_domains:
+      A read-only file for displaying the control domain numbers assigned to the
+      mediated matrix device.
+
+* functions:
+  * create:
+    allocates the ap_matrix_mdev structure used by the vfio_ap driver to:
+    * Store the reference to the KVM structure for the guest using the mdev
+    * Store the AP matrix configuration for the adapters, domains, and control
+      domains assigned via the corresponding sysfs attributes files
+  * remove:
+    deallocates the mediated matrix device's ap_matrix_mdev structure. This will
+    be allowed only if a running guest is not using the mdev.
+
+* callback interfaces
+  * open:
+    The vfio_ap driver uses this callback to register a
+    VFIO_GROUP_NOTIFY_SET_KVM notifier callback function for the mdev matrix
+    device. The open is invoked when QEMU connects the VFIO iommu group
+    for the mdev matrix device to the MDEV bus. Access to the KVM structure used
+    to configure the KVM guest is provided via this callback. The KVM structure,
+    is used to configure the guest's access to the AP matrix defined via the
+    mediated matrix device's sysfs attribute files.
+  * release:
+    unregisters the VFIO_GROUP_NOTIFY_SET_KVM notifier callback function for the
+    mdev matrix device and deconfigures the guest's AP matrix.
+
+Configure the APM, AQM and ADM in the CRYCB:
+-------------------------------------------
+Configuring the AP matrix for a KVM guest will be performed when the
+VFIO_GROUP_NOTIFY_SET_KVM notifier callback is invoked. The notifier
+function is called when QEMU connects to KVM. The CRYCB is configured by:
+* Setting the bits in the APM corresponding to the APIDs assigned to the
+  mediated matrix device via its 'assign_adapter' interface.
+* Setting the bits in the AQM corresponding to the APQIs assigned to the
+  mediated matrix device via its 'assign_domain' interface.
+* Setting the bits in the ADM corresponding to the domain dIDs assigned to the
+  mediated matrix device via its 'assign_control_domains' interface.
+
+The CPU model features for AP
+-----------------------------
+The AP stack relies on the presence of the AP instructions as well as two
+facilities: The AP Facilities Test (APFT) facility; and the AP Query
+Configuration Information (QCI) facility. These features/facilities are made
+available to a KVM guest via the following CPU model features:
+
+1. ap: Indicates whether the AP instructions are installed on the guest. This
+   feature will be enabled by KVM only if the AP instructions are installed
+   on the host.
+
+2. apft: Indicates the APFT facility is available on the guest. This facility
+   can be made available to the guest only if it is available on the host.
+
+3. apft: Indicates the AP QCI facility is available on the guest. This facility
+   can be made available to the guest only if it is available on the host.
+
+Note that if the user chooses to specify a CPU model different than the 'host'
+model to QEMU, the CPU model features and facilities need to be turned on
+explicitly; for example:
+
+     /usr/bin/qemu-system-s390x ... -cpu z13,ap=on,apqci=on,apft=on
+
+A guest can be precluded from using AP features/facilities by turning them off
+explicitly; for example:
+
+     /usr/bin/qemu-system-s390x ... -cpu host,ap=off,apqci=off,apft=off
+
+Example:
+=======
+Let's now provide an example to illustrate how KVM guests may be given
+access to AP facilities. For this example, we will show how to configure
+two guests such that executing the lszcrypt command on the guests would
+look like this:
+
+Guest1
+------
+CARD.DOMAIN TYPE  MODE
+------------------------------
+05          CEX5C CCA-Coproc
+05.0004     CEX5C CCA-Coproc
+05.00ab     CEX5C CCA-Coproc
+06          CEX5A Accelerator
+06.0004     CEX5A Accelerator
+06.00ab     CEX5C CCA-Coproc
+
+Guest2
+------
+CARD.DOMAIN TYPE  MODE
+------------------------------
+05          CEX5A Accelerator
+05.0047     CEX5A Accelerator
+05.00ff     CEX5A Accelerator
+
+These are the steps:
+
+1. Install the vfio_ap module on the linux host. The dependency chain for the
+   vfio_ap module is:
+   * vfio
+   * mdev
+   * vfio_mdev
+   * KVM
+   * vfio_ap
+
+2. Secure the AP queues to be used by the two guests so that the host can not
+   access them. Only type 10 adapters (i.e., CEX4 and later) are supported
+   for the following reasons: To simplify the implementation; a lack of older
+   systems on which to test; and because the older hardware will go out of
+   service in a relatively short time.
+
+   To secure the AP queues each, each AP Queue device must first be unbound from
+   the cex4queue device driver. The sysfs location of the driver is:
+
+   /sys/bus/ap
+   --- [drivers]
+   ------ [cex4queue]
+   --------- [05.0004]
+   --------- [05.0047]
+   --------- [05.00ab]
+   --------- [05.00ff]
+   --------- [06.0004]
+   --------- [06.00ab]
+   --------- unbind
+
+   To unbind AP queue 05.0004 for example;
+
+	echo 05.0004 > unbind
+
+   The AP queue devices must then be bound to the vfio_ap driver. The sysfs
+   location of the driver is:
+
+   /sys/bus/ap
+   --- [drivers]
+   ------ [cex4queue]
+   ---------- bind
+
+   To bind AP queue 05.0004 to the vfio_ap driver:
+
+	echo 05.0004 > bind
+
+   Take note that the AP queues bound to the vfio_ap driver will be available
+   for guest usage until the vfio_ap module is unloaded, or the host system is
+   shut down.
+
+3. Create the mediated devices needed to configure the AP matrixes for the
+   two guests and to provide an interface to the vfio_ap driver for
+   use by the guests:
+
+   /sys/devices/vfio_ap/matrix/
+   --- [mdev_supported_types]
+   ------ [vfio_ap-passthrough] (passthrough mediated matrix device type)
+   --------- create
+   --------- [devices]
+
+   To create the mediated devices for the two guests:
+
+	uuidgen > create
+	uuidgen > create
+
+   This will create two mediated devices in the [devices] subdirectory named
+   with the UUID written to the create attribute file. We call them $uuid1
+   and $uuid2:
+
+   /sys/devices/vfio_ap/matrix/
+   --- [mdev_supported_types]
+   ------ [vfio_ap-passthrough]
+   --------- [devices]
+   ------------ [$uuid1]
+   --------------- assign_adapter
+   --------------- assign_control_domain
+   --------------- assign_domain
+   --------------- matrix
+   --------------- unassign_adapter
+   --------------- unassign_control_domain
+   --------------- unassign_domain
+
+   ------------ [$uuid2]
+   --------------- assign_adapter
+   --------------- assign_control_domain
+   --------------- assign_domain
+   --------------- matrix
+   --------------- unassign_adapter
+   --------------------- unassign_control_domain
+   --------------------- unassign_domain
+
+4. The administrator now needs to configure the matrixes for mediated
+   devices $uuid1 (for Guest1) and $uuid2 (for Guest2).
+
+   This is how the matrix is configured for Guest1:
+
+   echo 5 > assign_adapter
+   echo 6 > assign_adapter
+   echo 4 > assign_domain
+   echo 0xab > assign_domain
+
+   For this implementation, all usage domains - i.e., domains assigned
+   via the assign_domain attribute file - will also be configured in the ADM
+   field of the KVM guest's CRYCB, so there is no need to assign control
+   domains here unless you want to assign control domains that are not
+   assigned as usage domains.
+
+   If a mistake is made configuring an adapter, domain or control domain,
+   you can use the unassign_xxx files to unassign the adapter, domain or
+   control domain.
+
+   To display the matrix configuration for Guest1:
+
+   cat matrix
+
+   This is how the matrix is configured for Guest2:
+
+   echo 5 > assign_adapter
+   echo 0x47 > assign_domain
+   echo 0xff > assign_domain
+
+   In order to successfully assign an adapter:
+
+   * All APQNs that can be derived from the adapter ID and the IDs of
+     the previously assigned domains must be bound to the vfio_ap device
+     driver. If no domains have yet been assigned, then there must be at least
+     one APQN with the specified APID bound to the vfio_ap driver.
+
+     No APQN that can be derived from the adapter ID and the IDs of the
+     previously assigned domains can be assigned to another mediated matrix
+     device.
+
+   In order to successfully assign a domain:
+
+   * All APQNs that can be derived from the domain ID and the IDs of
+     the previously assigned adapters must be bound to the vfio_ap device
+     driver. If no domains have yet been assigned, then there must be at least
+     one APQN with the specified APQI bound to the vfio_ap driver.
+
+     No APQN that can be derived from the domain ID and the IDs of the
+     previously assigned adapters can be assigned to another mediated matrix
+     device.
+
+5. Start Guest1:
+
+   /usr/bin/qemu-system-s390x ... -cpu xxx,ap=on,apqci=on,apft=on \
+      -device vfio-ap,sysfsdev=/sys/devices/vfio_ap/matrix/$uuid1 ...
+
+7. Start Guest2:
+
+   /usr/bin/qemu-system-s390x ... -cpu xxx,ap=on,apqci=on,apft=on \
+      -device vfio-ap,sysfsdev=/sys/devices/vfio_ap/matrix/$uuid2 ...
+
+When the guest is shut down, the mediated matrix device may be removed.
+
+Using our example again, to remove the mediated matrix device $uuid1:
+
+   /sys/devices/vfio_ap/matrix/
+      --- [mdev_supported_types]
+      ------ [vfio_ap-passthrough]
+      --------- [devices]
+      ------------ [$uuid1]
+      --------------- remove
+
+
+   echo 1 > remove
+
+   This will release all the AP queues configured for the mediated device and
+   remove all of the mdev matrix device's sysfs structures including the mdev
+   device itself. To recreate and reconfigure the mdev matrix device, all of the
+   steps starting with step 3 will have to be performed again. Note that the
+   remove will fail if a guest using the mdev is still running.
+
+   It is not necessary to remove an mdev matrix device, but one may want to
+   remove it if no guest will use it during the lifetime of the linux host. If
+   the mdev matrix device is removed, one may want to unbind the AP queues the
+   guest was using from the vfio_ap device driver and bind them back to the
+   default driver. Alternatively, the AP queues can be configured for another
+   mdev matrix (i.e., guest).
+
+
+Limitations
+===========
+* The KVM/kernel interfaces do not provide a way to prevent unbinding an AP
+  queue that is still assigned to a mediated device. Even if the device
+  'remove' callback returns an error, the device core detaches the AP
+  queue from the VFIO AP driver. It is therefore incumbent upon the
+  administrator to make sure there is no mediated device to which the
+  APQN - for the AP queue being unbound - is assigned.
+
+* Hot plug/unplug of AP devices is not supported for guests.
+
+* Live guest migration is not supported for guests using AP devices.
\ No newline at end of file
diff --git a/MAINTAINERS b/MAINTAINERS
index f60dd56..beeff24 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12428,6 +12428,7 @@ S:	Supported
 F:	drivers/s390/crypto/vfio_ap_drv.c
 F:	drivers/s390/crypto/vfio_ap_private.h
 F:	drivers/s390/crypto/vfio_ap_ops.c
+F:	Documentation/s390/vfio-ap.txt
 
 S390 ZFCP DRIVER
 M:	Steffen Maier <maier@linux.ibm.com>
-- 
1.7.1
