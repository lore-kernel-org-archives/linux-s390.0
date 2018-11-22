From: Pierre Morel <pmorel@linux.ibm.com>
Subject: [PATCH v2 0/3] s390: vfio: ap: Using GISA for AP Interrupt
Date: Thu, 22 Nov 2018 18:11:12 +0100
Message-ID: <1542906675-7949-1-git-send-email-pmorel@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: borntraeger@de.ibm.com
Cc: alex.williamson@redhat.com, cohuck@redhat.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com, pasic@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

This patch series handles AP Interrupt using the GISA facility.
The patch series is based above the GISA+GIB patch series
sent by Michael Mueller.

- We define a new VFIO ioctl to ask the vfio_ap driver to register
  a interruption for the guest.
- We define the assembler code to register a GISA based interruption
  for the guest.
- We register to the GIB Alert mechanism and suppress the GISA
  (firmware) based interrupts from the list of software handled
  interrupts.

This patch series has been tested with success on z13 and z14
with adjunct processors CEX5[ACP] and CEX6C.

To use, you, of course, need the QEMU patches, which will be sent
separately.
Take care of the incompatbility in the ioctl parameters.

Pierre Morel (3):
  vfio: ap: Add AP Queue Interruption Control facility
  vfio: ap: ioctl definitions for AP Queue Interrupt Control
  vfio: ap: AP Queue Interrupt Control VFIO ioctl calls

 arch/s390/tools/gen_facilities.c  |   1 +
 drivers/s390/crypto/vfio_ap_ops.c | 110 +++++++++++++++++++++++++++++++++++++-
 include/uapi/linux/vfio.h         |  25 +++++++++
 3 files changed, 135 insertions(+), 1 deletion(-)

-- 
2.7.4

The goal of the first serie was merely to provide the possibility
to test GISA, and was quite a mess.
This serie is reworked with a simplier interface and almost
the half of LOCs.

Changelog:
(Thanks to Tony:)
- Use explicitely ISC as ioctl parameters
- Use ISC parameter in IRQ disable
- No more changes to the ap_matrix_mdev structure (was isc and map)
- suppress redondant functions
- use standard vfio_ap prefix for functions
- in ioctl use one line to call dedicated ioctl function
(Thanks to Conny:)
- no more complicated structure to int conversions
- Use explicitely apqn as ioctl parameters
 
