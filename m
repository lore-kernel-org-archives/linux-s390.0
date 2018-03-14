From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Subject: [PATCH v3 00/14] s390: vfio-ap: guest dedicated crypto adapters
Date: Wed, 14 Mar 2018 14:25:40 -0400
Message-ID: <1521051954-25715-1-git-send-email-akrowiak@linux.vnet.ibm.com>
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
* Misc. formatting etc.

Tony Krowiak (14):
  KVM: s390: refactor crypto initialization
  s390: zcrypt: externalize AP instructions available function
  KVM: s390: CPU model support for AP virtualization
  KVM: s390: device attribute to set AP interpretive execution
  s390: vfio-ap: base implementation of VFIO AP device driver
  s390: vfio-ap: register matrix device with VFIO mdev framework
  KVM: s390: interfaces to configure/deconfigure guest's AP matrix
  s390: vfio-ap: sysfs interfaces to configure adapters
  s390: vfio-ap: sysfs interfaces to configure domains
  s390: vfio-ap: sysfs interfaces to configure control domains
  s390: vfio-ap: sysfs interface to view matrix mdev matrix
  KVM: s390: configure the guest's AP devices
  s390: vfio-ap: implement VFIO_DEVICE_GET_INFO ioctl
  s390: doc: detailed specifications for AP virtualization

 Documentation/s390/vfio-ap.txt        |  560 +++++++++++++++++++++
 MAINTAINERS                           |   14 +
 arch/s390/Kconfig                     |   11 +
 arch/s390/include/asm/ap.h            |    7 +
 arch/s390/include/asm/kvm-ap.h        |   57 +++
 arch/s390/include/asm/kvm_host.h      |    3 +
 arch/s390/include/uapi/asm/kvm.h      |    2 +
 arch/s390/kvm/Kconfig                 |    1 +
 arch/s390/kvm/Makefile                |    2 +-
 arch/s390/kvm/kvm-ap.c                |  330 +++++++++++++
 arch/s390/kvm/kvm-s390.c              |   84 ++--
 arch/s390/tools/gen_facilities.c      |    2 +
 drivers/s390/crypto/Makefile          |    4 +
 drivers/s390/crypto/ap_bus.c          |    6 +
 drivers/s390/crypto/vfio_ap_drv.c     |  144 ++++++
 drivers/s390/crypto/vfio_ap_ops.c     |  872 +++++++++++++++++++++++++++++++++
 drivers/s390/crypto/vfio_ap_private.h |   47 ++
 include/uapi/linux/vfio.h             |    2 +
 18 files changed, 2093 insertions(+), 55 deletions(-)
 create mode 100644 Documentation/s390/vfio-ap.txt
 create mode 100644 arch/s390/include/asm/kvm-ap.h
 create mode 100644 arch/s390/kvm/kvm-ap.c
 create mode 100644 drivers/s390/crypto/vfio_ap_drv.c
 create mode 100644 drivers/s390/crypto/vfio_ap_ops.c
 create mode 100644 drivers/s390/crypto/vfio_ap_private.h
