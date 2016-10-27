From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 0/1] KVM: s390: Fix for 4.9 (via kvm/master)
Date: Thu, 27 Oct 2016 10:07:52 +0200
Message-ID: <1477555673-5876-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

Paolo, Radim,

another fix for 4.9.

The following changes since commit a5efb6b6c99a3a6dc4330f51d8066f638bdea0ac:

  KVM: s390: reject invalid modes for runtime instrumentation (2016-10-20 20:06:12 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-master-4.9-2

for you to fetch changes up to 45c7ee43a5184ddbff652ee0d2e826f86f1b616b:

  KVM: s390: Fix STHYI buffer alignment for diag224 (2016-10-26 13:46:44 +0200)

----------------------------------------------------------------
KVM: s390: Fix wrong memory allocation

With commit d86bd1bece6f ("mm/slub: support left redzone") or
with slab debugging the allocation of our diag224 buffer is not
aligned properly. Let's fix this.

----------------------------------------------------------------
Janosch Frank (1):
      KVM: s390: Fix STHYI buffer alignment for diag224

 arch/s390/kvm/sthyi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
