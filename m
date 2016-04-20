From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PULL 0/4] KVM: s390 patches for kvm/next
Date: Wed, 20 Apr 2016 14:54:52 +0200
Message-ID: <1461156896-27006-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: pbonzini@redhat.com, rkrcmar@redhat.com
Cc: borntraeger@de.ibm.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org, jfrei@linux.vnet.ibm.com, agraf@suse.de, Cornelia Huck <cornelia.huck@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Paolo, Radim,

here are some s390 patches for 4.7. Christian had them in the -next
branch for a while; I'm sending them out in his place today.

The following changes since commit 5e1b59abef69e405eabfbe0ad09ad6b6e5303c7d:

  Merge tag 'for-linus' of git://git.kernel.org/pub/scm/virt/kvm/kvm (2016-04-13 08:53:26 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git tags/kvms390-20160420

for you to fetch changes up to 6d28f789bf81540d4069342b1a28bfd41dab38a3:

  KVM: s390: add clear I/O irq operation for FLIC (2016-04-20 14:27:32 +0200)

----------------------------------------------------------------
KVM/s390 patches for 4.7:
- improve perf output
- cleanup and a new feature in the floating interrupt controller (FLIC)

----------------------------------------------------------------

Christian Borntraeger (1):
  KVM: s390/perf: provide additional sigp events

Halil Pasic (3):
  KVM: s390: implement has_attr for FLIC
  KVM: s390: document FLIC behavior on unsupported
  KVM: s390: add clear I/O irq operation for FLIC

 Documentation/virtual/kvm/devices/s390_flic.txt | 12 +++++++
 arch/s390/include/uapi/asm/kvm.h                |  1 +
 arch/s390/include/uapi/asm/sie.h                |  7 ++++-
 arch/s390/kvm/interrupt.c                       | 42 +++++++++++++++++++++++++
 4 files changed, 61 insertions(+), 1 deletion(-)

-- 
2.8.1
