From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 0/1] KVM: s390: Fix for 4.8 (via kvm/master)
Date: Thu, 25 Aug 2016 17:53:56 +0200
Message-ID: <1472140437-66482-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Paolo, Radim,

The following changes since commit ba913e4f72fc9cfd03dad968dfb110eb49211d80:

  MIPS: KVM: Check for pfn noslot case (2016-08-19 17:22:26 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-master-4.8-2

for you to fetch changes up to a7d4b8f2565ad0dfdff9a222d1d87990c73b36e8:

  KVM: s390: don't use current->thread.fpu.* when accessing registers (2016-08-25 17:33:24 +0200)

----------------------------------------------------------------
KVM: s390: Fix for fpu register errors since 4.7

This fixes a regression that was introduced by a semantic
change in commit 3f6813b9a5e0 ("s390/fpu: allocate 'struct
fpu' with the task_struct"). Symptoms are broken host userspace
fpu registers if the old FPU set/get ioctls are used.

----------------------------------------------------------------
David Hildenbrand (1):
      KVM: s390: don't use current->thread.fpu.* when accessing registers

 arch/s390/kvm/kvm-s390.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)
