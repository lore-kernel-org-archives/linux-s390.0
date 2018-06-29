From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Subject: [PATCH v6 00/21] s390: vfio-ap: guest dedicated crypto adapters
Date: Fri, 29 Jun 2018 17:11:02 -0400
Message-ID: <1530306683-7270-1-git-send-email-akrowiak@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com, akrowiak@linux.vnet.ibm.com, Tony Krowiak <akrowiak@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Tony Krowiak <akrowiak@linux.ibm.com>

Notes:
=====
* Patches 1-4 posted with this series are forthcoming via another patch
  series and should not be reviewed with this series. They have been
  included here because some of the functions in this patch series are
  dependent upon them.

* In the previous review, Pierre Morel suggested that the remove callback
  for the VFIO AP device driver check to see if a guest is using the 
  device being removed and if so, remove it from the guest. This would 
  require a hot unplug implementation. Due to the design complexity, 
  implementation of hot plug/unplug of AP devices is being deferred until 
  the next patch series.
===== 

On s390, we have cryptographic coprocessor cards, which are modeled on
Linux as devices on the AP bus. Each card can be partitioned into domains
which can be thought of as a set of hardware registers for processing 
crypto commands. Crypto commands are sent to a specific domain within a
card is via a queue which is identified as a (card,domain) tuple. We model 
this something like the following (assuming we have access to cards 3 and 
4 and domains 1 and 2):

AP -> card3 -> queue (3,1)
            -> queue (3,2)
   -> card4 -> queue (4,1)
            -> queue (4,2)

If we want to virtualize this, we can use a feature provided by the
hardware. We basically attach a satellite control block to our main
hardware virtualization control block and the hardware takes care of
most of the rest.

For this control block, we don't specify explicit tuples, but a list of
cards and a list of domains. The guest will get access to the cross
product.

Because of this, we need to take care that the lists provided to
different guests don't overlap; i.e., we need to enforce sane
configurations. Otherwise, one guest may get access to things like
secret keys for another guest.

The idea of this patch set is to introduce a new device, the matrix
device. This matrix device hangs off a different root and acts as the
parent node for mdev devices.

If you now want to give the tuples (4,1) and (4,2), you need to do the
following:

- Unbind the (4,1) and (4,2) tuples from their ap bus driver.
- Bind the (4,1) and (4,2) tuples to the vfio_ap driver.
- Create the mediated device.
- Assign card 4 and domains 1 and 2 to the mediated device

QEMU will now simply consume the mediated device and things should work.

For a complete description of the architecture and concepts underlying the 
design, see the Documentation/s390/vfio-ap.txt file included with this
patch set.

--

v5 => v6 Change log:
===================
* Added VSIE support - thanks to Pierre Morel
* Added VFIO_DEVICE_RESET ioctl
* Zeroizing AP queues when mediated device released and when 
  VFIO_DEVICE_RESET ioctl is invoked
* Removed /arch/s390/kvm/kvm-ap.c and arch/s390/include/asm/kvm-ap.h and
  moved guest matrix configuration into vfio driver
* Removed temporary interfaces to be supplied by AP bus
* Made the variable that keeps track of mdev instance count an atomic_t
  type
* Removed code iterating through vm_list to determine if another guest has
  a queue .... not keep a list of matrix_mdev devices and verify against
  that list. Removes the need for the kvm_lock.
* Added a sysfs attribute for the mediated matrix device to display the
  matrix contained in the guest's CRYCB if a guest is using the mdev.


v4 => v5 Change log:
===================
* Verify AP queues bound to driver in mediated device open callback, prior
  to configuring the matrix in the CRYCB
* Implement VFIO_DEVICE_RESET ioctl
* Zeroize queues on guest entry and exit
* Removed vnet from all email IBM email addresses referenced
* Add synchronization in mdev create/remove and open/release.
* Added code to mdev open callback to ensure not more than one vfio-ap
  device can be opened by a guest.
* Interpret AP instructions by default
* Removed patch implementing interface to enable/disable AP interpretation,
  since that will now be done by default
* Removed patch to reset crypto attributes for ALL vcpus. That will be 
  submitted as a single patch since it will not be needed in this series - 
  i.e., it was called from the interface to enable/disable AP instructions
* All code for initializing crypto for a guest has been moved back to 
  kvm-s390.c, kvm_s390_crypto_init(kvm) function
* Maintaining a module reference count for the vfio_ap module so it is not
  removed while a guest with AP devices is running.
  


v3 => v4 Change log:
===================
* Resolved issue with enabling ZCRYPT when KVM is enabled by using
  #ifdef ZCRYPT in relevant functions
* Added patch with a new function for resetting the crypto attributes
  for all vcpus to resolve the issue raised with running vcpus getting out 
  of sync.
* Removed KVM_S390_VM_CRYPTO_INTERPRET_AP: Setting interpretive exec mode
  from vfio_ap driver when mdev device is opened.


v2 => v3 Change log:
===================
* Set APIE in VCPU setup function
* Renamed patch 13/15:
    KVM: s390: Configure the guest's CRYCB
    KVM: s390: Configure the guest's AP devices
* Fixed problem with building arch/s390/kvm/kvm-ap.c when CONFIG_ZCRYPT
  not selected 
* Removed patch introducing VSIE support for AP pending further 
  investigation
* Initialized AP maximum mask sizes - i.e., APM, AQM and ADM - from info
  returned from PQAP(QCI) function
* Introduced a new device attribute to the KVM_S390_VM_CRYPTO attribute
  group for setting a flag via the KVM_SET_DEVICE_ATTR ioctl to indicate
  whether ECA_APIE should be set or not. The flag is used in the 
  kvm_s390_vcpu_crypto_setup() function to set ECA_APIE in the SIE block. 
  

v1 => v2 Change log:
===================
* Added documentation vfio-ap.txt
* Renamed vfio_ap_matrix module and device driver to vfio_ap
* Use device core device list instead of maintaining list of matrix
  devices in driver
* Added VSIE support for AP
* Create matrix device before registering VFIO AP device driver with the
  AP bus
* Renamed the following files in drivers/s390/crypto:
  * vfio_ap_matrix.drv -> vfio_ap_drv
  * vfio_ap_matrix_private.h -> vfio_ap_private.h
  * vfio_ap_matrix_ops.c -> vfio_ap_ops.c
* arch/s390/include/asm/kvm/ap-matrix-config.h
  * Renamed to kvm-ap.h
  * Changed the data type of the bit mask fields for the matrix structure
    to unsigned long and create them with DECLARE_BITMAP 
  * Changed #define prefixes from AP_MATRIX to KVM_AP
  * Changed function and structure prefixes from ap_matrix to kvm_ap
  * Added function interface to check if AP Extended Addressing (APXA)
    facility is installedCRYCB_FORMAT_MASK
  * Added function interface to get the maximum ID for AP mask type
  * Added function interface to set the AP execution mode
* arch/s390/kvm/ap-matrix-config.c
  * Renamed to kvm-ap.c
  * Changed function prefixes from ap_matrix to kvm_ap
  * Added function to check if AP Extended Addressing (APXA) facility is
    installed
  * Added function to get the maximum ID for AP mask type
  * Added function to set the AP execution mode
  * Added a boolean parameter to the functions that retrieve the APM, AQM
    and ADM bit mask fields from the CRYCB. If true, then the function
    will clear the bits in the mask before returning a reference to it
  * Added validation to verify that APM, AQM and ADM bits that are set do
    not exceed the maximum ID value allowed
  * 
* arch/s390/include/asm/kvm_host.h
  * Changed defined for ECA_AP to ECA_APIE - interpretive execution mode
  * Added a flag to struct kvm_s390_crypto to indicate whether the 
    KVM_S390_VM_CPU_FEAT_AP CPU model feature for AP facilities is set
  * Added two CPU facilities features to set STFLE.12 and STFLE.15
* arch/s390/kvm/kvm-s390.c
  * Added initialization for new KVM_S390_VM_CPU_FEAT_AP CPU model feature
  * Removed kvm_s390_apxa_installed() function
  * Changed call to kvm_s390_apxa_installed() which has been removed to a
    call to new kvm_ap_apxa_installed() function.
  * Added code to kvm_s390_vcpu_crypto_setup() to set the new CPU model 
    feature flag in the kvm_s390_crypto structure 
  * Added CRYCB_FORMAT_MASK to mask CRYCBD
* arch/s390/tools/gen_facilities.c
  * Added STFLE.12 and STFLE.15 to struct facility _def
* drivers/s390/crypto/vfio_ap_matrix_private.h
  * Changed name of file to vfio_ap.private.h
  * Changed #define prefixes from VFIO_AP_MATRIX to VFIO_AP
  * struct ap_matrix: removed list fields and locks
  * struct vfio_ap_queue: removed list field
  * Renamed functions ap_matrix_mdev_register and ap_matrix_mdev_unregister
    to vfio_ap_mdev_register and vfio_ap_mdev_unregister respectively
* drivers/s390/crypto/vfio_ap_matrix_drv.c
  * Renamed file to drivers/s390/crypto/vfio_ap_drv.c
  * Changed all #define, structure and function prefixes to vfio_ap
  * probe function
    * Changed root device name for the matrix device to vfio_ap:
      i.e., /sys/devices/vfio_ap/matrix
    * No longer storing the AP queue device in a list, it is retrievablegit
      via the device core
    * Removed unnecessary check whether matrix device exists
    * Store the vfio_ap_queue structure in the private field of the 
      ap_queue structure rather than using list interface
  * remove function
    * Retrieve vfio_ap_queue structure from the struct ap_queue private 
      data rather than from a list
  * Removed unnecessary check 
* drivers/s390/crypto/vfio_ap_matrix_ops.c
  * Renamed file to vfio_ap_ops.c
  * Changed #define prefixes from AP_MATRIX to VFIO_AP
  * Changed function name prefixes from ap_matrix to vfio_ap
  * Removed ioctl to configure the CRYCB
  * create function
    * Removed ap_matrix_mdev_find_by_uuid() function - function is provided
      by mdev core
    * Removed available_instances verification, provided by mdev core
    * Removed check to see if mediated device exists, handled by mdev core
  * notifier function
    * Configuring matrix here instead of via ioctl
    * Set interpretive execution mode for all VCPUs
   * Removed R/O attributes to display adapters and domains
   * Added an R/O attribute to display the matrix
  * assign_control_domain mdev attribute:
    * Removed check to see if the domain is installed on the linux host
    * Added check to verify the control domain ID does not exceed the max 
      value
  * assign_adapter mdev attribute:
    * Added check to verify the adapter ID does not exceed the max 
      value
    * If any APQNs configured for the mediated matrix device that
      have an APID matching the adapter ID being assigned are not
      bound to the vfio_ap device driver then it is assumed that the APQN
      is bound to another driver and assignment will fail
  * assign_domain mdev attribute:
    * Added check to verify the domain ID does not exceed the max 
      value
    * If any APQNs configured for the mediated matrix device that
      have an APQI matching the domain ID being assigned are not
      bound to the vfio_ap device driver then it is assumed that the APQN
      is bound to another driver and assignment will fail
* tools/arch/s390/include/uapi/asm/kvm.h
  * removed  KVM_S390_VM_CPU_FEAT_AP feature definition

Harald Freudenberger (4):
  s390/zcrypt: Add ZAPQ inline function.
  s390/zcrypt: Review inline assembler constraints.
  s390/zcrypt: Show load of cards and queues in sysfs
  s390/zcrypt: Integrate ap_asm.h into include/asm/ap.h.

Pierre Morel (1):
  KVM: s390: Handling of Cypto control block in VSIE

Tony Krowiak (16):
  KVM: s390: CPU model support for AP virtualization
  KVM: s390: refactor crypto initialization
  s390: vfio-ap: base implementation of VFIO AP device driver
  s390: vfio-ap: register matrix device with VFIO mdev framework
  s390: vfio-ap: structure for storing mdev matrix
  s390: vfio-ap: sysfs interfaces to configure adapters
  s390: vfio-ap: sysfs interfaces to configure domains
  s390: vfio-ap: sysfs interfaces to configure control domains
  s390: vfio-ap: sysfs interface to view matrix mdev matrix
  s390: vfio-ap: implement mediated device open callback
  s390: vfio-ap: configure the guest's AP matrix
  s390: vfio-ap: sysfs interface to view guest matrix
  s390: vfio-ap: implement VFIO_DEVICE_GET_INFO ioctl
  s390: vfio-ap: zeroize the AP queues.
  s390: vfio-ap: implement VFIO_DEVICE_RESET ioctl
  s390: doc: detailed specifications for AP virtualization

 Documentation/s390/vfio-ap.txt        |  575 ++++++++++++++++
 MAINTAINERS                           |   12 +
 arch/s390/Kconfig                     |   11 +
 arch/s390/include/asm/ap.h            |  284 +++++++-
 arch/s390/include/asm/kvm_host.h      |    4 +
 arch/s390/include/uapi/asm/kvm.h      |    1 +
 arch/s390/kvm/kvm-s390.c              |   93 ++--
 arch/s390/kvm/vsie.c                  |  224 ++++++-
 arch/s390/tools/gen_facilities.c      |    3 +
 drivers/s390/crypto/Makefile          |    4 +
 drivers/s390/crypto/ap_asm.h          |  236 -------
 drivers/s390/crypto/ap_bus.c          |   21 +-
 drivers/s390/crypto/ap_bus.h          |    1 +
 drivers/s390/crypto/ap_card.c         |    1 -
 drivers/s390/crypto/ap_queue.c        |    1 -
 drivers/s390/crypto/vfio_ap_drv.c     |  159 +++++
 drivers/s390/crypto/vfio_ap_ops.c     | 1221 +++++++++++++++++++++++++++++++++
 drivers/s390/crypto/vfio_ap_private.h |   97 +++
 drivers/s390/crypto/zcrypt_card.c     |   12 +
 drivers/s390/crypto/zcrypt_queue.c    |   12 +
 include/uapi/linux/vfio.h             |    2 +
 samples/bpf/bpf_load.c                |   62 ++
 22 files changed, 2686 insertions(+), 350 deletions(-)
 create mode 100644 Documentation/s390/vfio-ap.txt
 delete mode 100644 drivers/s390/crypto/ap_asm.h
 create mode 100644 drivers/s390/crypto/vfio_ap_drv.c
 create mode 100644 drivers/s390/crypto/vfio_ap_ops.c
 create mode 100644 drivers/s390/crypto/vfio_ap_private.h
