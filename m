From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 0/5] KVM: s390: Fixes for 4.4
Date: Thu, 19 Nov 2015 15:09:21 +0100
Message-ID: <1447942166-66514-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

Paolo,

The following changes since commit 8005c49d9aea74d382f474ce11afbbc7d7130bec:

  Linux 4.4-rc1 (2015-11-15 17:00:27 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-master-4.4-1

for you to fetch changes up to 152e9f65d66f0a3891efc3869440becc0e7ff53f:

  KVM: s390: fix wrong lookup of VCPUs by array index (2015-11-19 14:47:43 +0100)

----------------------------------------------------------------
KVM: s390: Fixes for 4.4

1. disallow changing the SIMD mode when CPUs have been created.
   it allowed userspace to corrupt kernel memory
2. Fix vCPU lookup. Until now the vCPU number equals the vCPU id. Some
   kernel code places relied on that. This might
   a: cause guest failures
   b: allow userspace to corrupt kernel memory
3. Fencing of the PFMF instruction should use the guest facilities
   and not the host facilities.

----------------------------------------------------------------
David Hildenbrand (4):
      KVM: s390: enable SIMD only when no VCPUs were created
      KVM: Provide function for VCPU lookup by id
      KVM: s390: avoid memory overwrites on emergency signal injection
      KVM: s390: fix wrong lookup of VCPUs by array index

Heiko Carstens (1):
      KVM: s390: fix pfmf intercept handler

 arch/s390/kvm/interrupt.c |  7 +++++--
 arch/s390/kvm/kvm-s390.c  |  6 +++++-
 arch/s390/kvm/priv.c      |  2 +-
 arch/s390/kvm/sigp.c      |  8 ++------
 include/linux/kvm_host.h  | 11 +++++++++++
 5 files changed, 24 insertions(+), 10 deletions(-)
