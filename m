From: Pierre Morel <pmorel@linux.ibm.com>
Subject: [PATCH v1 0/7] s390: vfio: ap: Using GISA for AP Interrupt
Date: Wed, 31 Oct 2018 19:12:50 +0100
Message-ID: <1541009577-29656-1-git-send-email-pmorel@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: borntraeger@de.ibm.com
Cc: alex.williamson@redhat.com, cohuck@redhat.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com, pasic@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

This is the first version to handle AP Interrupt
using the GISA facility.
The patch series is based on the GISA+GIB patch series
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


Pierre Morel (7):
  vfio: ap: Add AP Queue Interruption Control facility
  vfio: ap: VFIO AP Queue Interrupt Control
  vfio: ap: AP Queue Interrupt structures definitions
  vfio: ap: AP Queue Interrupt Control VFIO ioctl calls
  s390: kvm: export GIB registration
  vfio: ap: register guest ISC with GISA and GIB
  s390: kvm: Handle all GISA IPM bits through GISA

 arch/s390/include/asm/kvm_host.h      |   3 +
 arch/s390/kvm/interrupt.c             |   3 +-
 arch/s390/tools/gen_facilities.c      |   1 +
 drivers/s390/crypto/vfio_ap_ops.c     | 105 ++++++++++++++++++++++++++
 drivers/s390/crypto/vfio_ap_private.h |  77 +++++++++++++++++++
 include/uapi/linux/vfio.h             |  22 ++++++
 6 files changed, 209 insertions(+), 2 deletions(-)

-- 
2.17.0
