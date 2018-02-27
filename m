From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Subject: [PATCH v2 15/15] s390: doc: detailed specifications for AP virtualization
Date: Tue, 27 Feb 2018 09:28:13 -0500
Message-ID: <1519741693-17440-16-git-send-email-akrowiak@linux.vnet.ibm.com>
References: <1519741693-17440-1-git-send-email-akrowiak@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1519741693-17440-1-git-send-email-akrowiak@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com, Tony Krowiak <akrowiak@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

This patch provides documentation describing the AP architecture and
design concepts behind the virtualization of AP devices. It also
includes an example of how to configure AP devices for exclusive
use of KVM guests.

Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
---
 Documentation/s390/vfio-ap.txt |  514 ++++++++++++++++++++++++++++++++++++++++
 MAINTAINERS                    |    1 +
 2 files changed, 515 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/s390/vfio-ap.txt

diff --git a/Documentation/s390/vfio-ap.txt b/Documentation/s390/vfio-ap.txt
new file mode 100644
index 0000000..c599f30
--- /dev/null
+++ b/Documentation/s390/vfio-ap.txt
@@ -0,0 +1,514 @@
+Introduction:
+============
+The Adjunct Processor (AP) facility is an IBM Z cryptographic facility comprised
+of three AP instructions and from 1 up to 256 PCIe cryptographic adapter cards.
+The AP devices provide cryptographic functions to all CPUs assigned to a
+linux system running in an IBM Z system LPAR.
+
+The AP adapter cards are exposed via the AP bus. The motivation for vfio-ap
+is to make AP cards available to KVM guests using the VFIO mediated device
+framework.
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
+* AP domain
+
+  An adapter is partitioned into domains. Each domain can be thought of as
+  a set of hardware registers for processing AP instructions. An adapter can
+  hold up to 256 domains. Each domain is identified by a number from 0 to 255.
+  Domains can be further classified into two types:
+
+    * Usage domains are domains that can be accessed directly to process AP
+      commands
+
+    * Control domains are domains that are accessed indirectly by AP
+      commands sent to a usage domain to control or change the domain, for
+      example; to set a secure private key for the domain.
+
+* AP Queue
+
+  An AP queue is the means by which an AP command-request message is sent to an
+  AP usage domain inside a specific AP. An AP queue is identified by a tuple
+  comprised of an AP adapter ID (APID) and an AP queue index (APQI). The
+  APQI corresponds to a given usage domain number within the adapter. This tuple
+  forms an AP Queue Number (APQN) uniquely identifying an AP queue. AP
+  instructions include a field containing the APQN to identify the AP queue to
+  which the AP command-request message is to be sent for processing.
+
+* AP Instructions:
+
+  There are three AP instructions:
+
+  * NQAP: to enqueue an AP command-request message to a queue
+  * DQAP: to dequeue an AP command-reply message from a queue
+  * PQAP: to administer the queues
+
+Start Interpretive Execution (SIE) Instruction:
+==============================================
+Let's now see how AP instructions are interpreted by the hardware.
+
+A KVM guest is started by executing the Start Interpretive Execution (SIE)
+instruction. The SIE state description is a control block that contains the
+state information for a KVM guest and is supplied as input to the SIE
+instruction. The SIE state description contains a field that references
+a Crypto Control Block (CRYCB). The CRYCB contains three fields to identify the
+adapters, usage domains and control domains assigned to the KVM guest:
+
+* The AP Mask (APM) field is a bit mask that identifies the AP adapters assigned
+  to the KVM guest. Each bit in the mask, from most significant to least
+  significant bit, corresponds to an APID from 0-255. If a bit is set, the
+  corresponding adapter is valid for use by the KVM guest.
+
+* The AP Queue Mask (AQM) field is a bit mask identifying the AP queues assigned
+  to the KVM guest. Each bit in the mask, from most significant to least
+  significant bit, corresponds to an AP queue index (APQI) from 0-255. If a bit
+  is set, the corresponding queue is valid for use by the KVM guest.
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
+intersection of all assigned adapter numbers (APM) with all assigned queue
+indexes (AQM). For example, if adapters 1 and 2 and usage domains 5 and 6 are
+assigned to a guest, the APQNs (1,5), (1,6), (2,5) and (2,6) will be valid for
+the guest.
+
+The APQNs provide secure key functionality - i.e., a private key is stored on
+the adapter card for each of its domains - so each APQN must be assigned to at
+most one guest or the linux host.
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
+   --------------------------------is assigned by writing the adapter's number into the
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
+1. Provides the interfaces to reserve APQNs for exclusive use of KVM guests.
+
+2. Sets up the VFIO mediated device interfaces to manage the mediated matrix
+   device and create the sysfs interfaces for assigning adapters, usage domains,
+   and control domains comprising the matrix for a KVM guest.
+
+3. Configure the APM, AQM and ADM in the CRYCB referenced by a KVM guest's
+   SIE state description to grant the guest access to AP devices
+
+4. Initialize the CPU model feature indicating that a KVM guest may use
+   AP facilities installed on the linux host.
+
+5. Enable interpretive execution mode for the KVM guest.
+
+Reserve APQNs for exclusive use of KVM guests
+---------------------------------------------
+The following block diagram illustrates the mechanism by which APQNs are
+reserved:
+
+                              +------------------+
+                 remove       |                  |   unbind
+         +------------------->+ cex4queue driver +<-----------+
+         |                    |                  |            |
+         |                    +------------------+            |
+         |                                                    |
+         |                                                    |
+         |                                                    |
++--------+---------+ register +------------------+      +-----+------+
+|                  +<---------+                  | bind |            |
+|      ap_bus      |          |  vfio_ap driver  +<-----+    admin   |
+|                  +--------->+                  |      |            |
++------------------+  probe   +---+--------+-----+      +------------+
+                                  |        |
+                           create |        | store APQN
+                                  |        |
+                                  v        v
+                              +---+--------+-----+
+                              |                  |
+                              |  matrix device   |
+                              |                  |
+                              +------------------+
+
+The process for reserving an AP queue for use by a KVM guest is:
+
+* The vfio-ap driver during its initialization will perform the following:
+  * Create the 'vfio_ap' root device - /sys/devices/vfio_ap
+  * Create the 'matrix' device in the 'vfio_ap' root
+  * Register the matrix device with the device core
+* Register with the ap_bus for AP queue devices of type CEX4, CEX5 and
+  CEX6 and to provide the vfio_ap driver's probe and remove callback interfaces.
+* The admin unbinds queue cc.qqqq from the cex4queue device driver. This results
+  in the ap_bus calling the the device driver's remove interface which
+  unbinds the cc.qqqq queue device from the driver.
+* The admin binds the cc.qqqq queue to the vfio_ap device driver. This results
+  in the ap_bus calling the device vfio_ap driver's probe interface to bind
+  queue cc.qqqq to the driver. The vfio_ap device driver will store the APQN for
+  the queue in the matrix device
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
+        /sys/devices/vfio_ap/mdev_supported_types/vfio_ap-passthrough
+    Only the three read-only attributes required by the VFIO mdev framework will
+    be provided:
+        /sys/devices/vfio_ap/mdev_supported_types
+        ... name
+        ... device_api
+        ... available_instances
+        Where:
+        * name: specifies the name of the mediated device type
+        * device_api: the mediated device type's API
+        * available_instances: the number of mediated matrix passthrough devices
+                               that can be created
+  * mdev_attr_groups
+    This attribute group identifies the user-defined sysfs attributes of the
+    mediated device. When a device is registered with the VFIO mediated device
+    framework, the sysfs attributes files identified in the 'mdev_attr_groups'
+    structure will be created in the mediated matrix device's directory. The
+    sysfs attributes for a mediated matrix device are:
+    * assign_adapter:
+      A write-only file for assigning an AP adapter to the mediated matrix
+      device. To assign an adapter, the APID of the adapter is written to the
+      file.
+    * assign_domain:
+      A write-only file for assigning an AP usage domain to the mediated matrix
+      device. To assign a domain, the APQI of the AP queue corresponding to a
+      usage domain is written to the file.
+    * assign_control_domain:
+      A write-only file for assigning an AP control domain to the mediated
+      matrix device. To assign a control domain, the ID of a domain to be
+      controlled is written to the file. By architectural convention, the set of
+      control domains will always include the set of usage domains, so it is
+      only necessary to assign control domains that are not also assigned as
+      usage domains.
+
+* functions:
+  * create:
+    allocates the ap_matrix_mdev structure used by the vfio_ap driver to:
+    * Keep track of the available instances
+    * Store the reference to the struct kvm for the KVM guest
+    * Provide the notifier callback that will get invoked to handle the
+      VFIO_GROUP_NOTIFY_SET_KVM event. When received, the vfio_ap driver will
+      store the reference in the mediated matrix device's ap_matrix_mdev
+      structure and enable the interpretive execution mode for the KVM guest.
+  * remove:
+    deallocates the mediated matrix device's ap_matrix_mdev structure.
+
+* callback interfaces
+  * open:
+    The vfio_ap driver uses this callback to register a
+    VFIO_GROUP_NOTIFY_SET_KVM notifier callback function for the mdev matrix
+    device. The notifier is invoked when QEMU connects the VFIO iommu group
+    for the mdev matrix device to the MDEV bus. Access to the KVM structure used
+    to set up the KVM guest is provided via this callback.
+  * release:
+    unregisters the VFIO_GROUP_NOTIFY_SET_KVM notifier callback function for the
+    mdev matrix device.
+
+Configure the APM, AQM and ADM in the CRYCB:
+-------------------------------------------
+Configuring the AP matrix for a KVM guest will be performed when the
+VFIO_GROUP_NOTIFY_SET_KVM notifier callback is invoked. The notifier is callback
+function is called when QEMU connects the VFIO iommu group for the mdev matrix
+device to the MDEV bus. The CRYCB is configured by:
+* Setting the bits in the APM corresponding to the APIDs assigned to the
+  mediated matrix device via its 'assign_adapter' interface.
+* Setting the bits in the AQM corresponding to the APQIs assigned to the
+  mediated matrix device via its 'assign_domain' interface.
+* Setting the bits in the ADM corresponding to the domain dIDs assigned to the
+  mediated matrix device via its 'assign_control_domains' interface.
+
+Initialize the CPU model feature for AP
+---------------------------------------
+This design exploits a feature of the SIE architecture called interpretive
+execution (IE). When IE is enabled for a KVM guest, the AP instructions
+executed in the guest will be interpreted by the firmware and the commands
+contained therein will be passed directly through to an AP device assigned to
+the linux host. In order to enable interpretive execution for a KVM guest, SIE
+must have access to the AP facilities installed on the linux host. A new CPU
+model feature is introduced by this design to indicate that the guest will
+directly access the host AP facilities. This feature will be enabled by the
+kernel only if the AP facilities are installed on the linux host. This feature
+is turned on for the guest via the qemu command line:
+
+    /usr/bin/qemu-system-s390x ... -cpu xxx,ap=on
+
+    Where xxx is the CPU model being used.
+
+If the CPU model feature is not enabled by the kernel, QEMU
+will fail and report that the feature is not supported.
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
+   * vfio_ap
+
+2. Secure the AP queues to be used by the two guests so that the host can not
+   access them. This is done by unbinding each AP Queue device from its
+   respective AP driver. In our example, these queues are bound to the cex4queue
+   driver. The sysfs location of these devices is:
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
+   To unbind AP queue 05.0004 from the cex4queue device driver:
+
+	echo 05.0004 > unbind
+
+   This must also be done for AP queues 05.00ab, 05.0047, 05.00ff, 06.0004,
+   and 06.00ab.
+
+3. Reserve the queues for use by the two KVM guests. This is accomplished by
+   binding them to the vfio_ap device driver. The sysfs location of the
+   device driver is:
+
+   /sys/bus/ap
+   ---[drivers]
+   ------ [vfio_ap]
+   ---------- bind
+
+   To bind queue 05.0004 to the vfio_ap driver:
+
+	echo 05.0004 > bind
+
+   This must also be done for AP queues 05.00ab, 05.0047, 05.00ff, 06.0004,
+   and 06.00ab.
+
+   Take note that the AP queues bound to the vfio_ap driver will be available
+   for guest usage until they are unbound from the driver, the vfio_ap module
+   is unloaded, or the host system is shut down.
+
+4. Create the mediated devices needed to configure the AP matrixes for the
+   two guests and to provide an interface to the vfio_ap driver for
+   use by the guests:
+
+   /sys/devices/
+   --- [vfio_ap]
+   ------ [matrix] (this is the matrix device)
+   --------- [mdev_supported_types]
+   ------------ [vfio_ap-passthrough] (passthrough mediated matrix device type)
+   --------------- create
+   --------------- [devices]
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
+   /sys/devices/
+   --- [vfio_ap]
+   ------ [matrix]
+   --------- [mdev_supported_types]
+   ------------ [vfio_ap-passthrough]
+   --------------- [devices]
+   ------------------ [$uuid1]
+   --------------------- assign_adapter
+   --------------------- assign_control_domain
+   --------------------- assign_domain
+   --------------------- matrix
+   --------------------- unassign_adapter
+   --------------------- unassign_control_domain
+   --------------------- unassign_domain
+
+   ------------------ [$uuid2]
+   --------------------- assign_adapter
+   --------------------- assign_cTo assign an adapter, the APID of the adapter is written to the
+      file. ontrol_domain
+   --------------------- assign_domain
+   --------------------- matrix
+   --------------------- unassign_adapter
+   --------------------- unassign_control_domain
+   --------------------- unassign_domain
+
+5. The administrator now needs to configure the matrixes for mediated
+   devices $uuid1 (for Guest1) and $uuid2 (for Guest2).
+
+   This is how the matrix is configured for Guest1:
+
+   echo 5 > assign_adapter
+   echo 6 > assign_adapter
+   echo 4 > assign_domain
+   echo 0xab > assign_domain
+
+   By architectural convention, all usage domains - i.e., domains assigned
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
+6. Start Guest1:
+
+   /usr/bin/qemu-system-s390x ... -cpu xxx,ap=on \
+      -device vfio-ap,sysfsdev=/sys/devices/vfio_ap/matrix/$uuid1 ...
+
+7. Start Guest2:
+
+   /usr/bin/qemu-system-s390x ... -cpu xxx,ap=on \
+      -device vfio-ap,sysfsdev=/sys/devices/vfio_ap/matrix/$uuid2 ...
+
+When the guest is shut down, the mediated matrix device may be removed.
+
+Using our example again, to remove the mediated matrix device $uuid1:
+
+   /sys/devices/
+      --- [vfio_ap]
+      ------ [matrix]
+      --------- [mdev_supported_types]
+      ------------ [vfio_ap-passthrough]
+      --------------- [devices]
+      ------------------ [$uuid1]
+      --------------------- remove
+
+   echo 1 > remove
+
+   This will remove all of the mdev matrix device's sysfs structures. To
+   recreate and reconfigure the mdev matrix device, all of the steps starting
+   with step 4 will have to be performed again.
+
+   It is not necessary to remove an mdev matrix device, but one may want to
+   remove it if no guest will use it during the lifetime of the linux host. If
+   the mdev matrix device is removed, one may want to unbind the AP queues the
+   guest was using from the vfio_ap device driver and bind them back to the
+   default driver. Alternatively, the AP queues can be configured for another
+   mdev matrix (i.e., guest). In either case, one must take care to change the
+   secure key configured for the domain to which the queue is connected.
\ No newline at end of file
diff --git a/MAINTAINERS b/MAINTAINERS
index fb9e0d4..bfa94c8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11887,6 +11887,7 @@ F:	arch/s390/kvm/kvm-ap.c
 F:	drivers/s390/crypto/vfio_ap_drv.c
 F:	drivers/s390/crypto/vfio_ap_private.h
 F:	drivers/s390/crypto/vfio_ap_ops.c
+F:	Documentation/s390/vfio-ap.txt
 
 S390 ZFCP DRIVER
 M:	Steffen Maier <maier@linux.vnet.ibm.com>
-- 
1.7.1
