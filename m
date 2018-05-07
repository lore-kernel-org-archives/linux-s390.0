From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Subject: [PATCH v5 00/13] s390: vfio-ap: guest dedicated crypto adapters
Date: Mon,  7 May 2018 11:11:39 -0400
Message-ID: <1525705912-12815-1-git-send-email-akrowiak@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com, akrowiak@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

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

v4 => v5 Change log:
===================
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
* AP bus interfaces needed by KVM that are unavailable if CONFIG_ZCRYPT=n
  are temporarily embedded in KVM until available statically via future 
  patch.


Tony Krowiak (13):
  KVM: s390: Interface to test whether APXA installed
  KVM: s390: refactor crypto initialization
  KVM: s390: CPU model support for AP virtualization
  s390: vfio-ap: base implementation of VFIO AP device driver
  s390: vfio-ap: register matrix device with VFIO mdev framework
  KVM: s390: interfaces to manage guest's AP matrix
  s390: vfio-ap: sysfs interfaces to configure adapters
  s390: vfio-ap: sysfs interfaces to configure domains
  s390: vfio-ap: sysfs interfaces to configure control domains
  s390: vfio-ap: sysfs interface to view matrix mdev matrix
  KVM: s390: implement mediated device open callback
  s390: vfio-ap: implement VFIO_DEVICE_GET_INFO ioctl
  s390: doc: detailed specifications for AP virtualization

 Documentation/s390/vfio-ap.txt        |  575 +++++++++++++++++++++
 MAINTAINERS                           |   13 +
 arch/s390/Kconfig                     |   11 +
 arch/s390/include/asm/kvm-ap.h        |  133 +++++
 arch/s390/include/asm/kvm_host.h      |    5 +
 arch/s390/include/uapi/asm/kvm.h      |    1 +
 arch/s390/kvm/Makefile                |    2 +-
 arch/s390/kvm/kvm-ap.c                |  263 ++++++++++
 arch/s390/kvm/kvm-s390.c              |  116 +++---
 arch/s390/tools/gen_facilities.c      |    3 +
 drivers/s390/crypto/Makefile          |    4 +
 drivers/s390/crypto/vfio_ap_drv.c     |  143 ++++++
 drivers/s390/crypto/vfio_ap_ops.c     |  906 +++++++++++++++++++++++++++++++++
 drivers/s390/crypto/vfio_ap_private.h |   76 +++
 include/uapi/linux/vfio.h             |    2 +
 15 files changed, 2194 insertions(+), 59 deletions(-)
 create mode 100644 Documentation/s390/vfio-ap.txt
 create mode 100644 arch/s390/include/asm/kvm-ap.h
 create mode 100644 arch/s390/kvm/kvm-ap.c
 create mode 100644 drivers/s390/crypto/vfio_ap_drv.c
 create mode 100644 drivers/s390/crypto/vfio_ap_ops.c
 create mode 100644 drivers/s390/crypto/vfio_ap_private.h
