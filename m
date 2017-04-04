From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 0/1] KVM: s390: fix for 4.11 (kvm/master)
Date: Tue,  4 Apr 2017 10:51:09 +0200
Message-ID: <1491295870-7152-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

Paolo, Radim,

a fix for the new iep feature that was added in 4.11-rc1.

The following changes since commit 97da3854c526d3a6ee05c849c96e48d21527606c:

  Linux 4.11-rc3 (2017-03-19 19:09:39 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-master-4.11-1

for you to fetch changes up to 232b8e3b1d4946a45e3b9dd4c282b12a085dd39d:

  KVM: s390: remove change-recording override support (2017-04-03 12:45:08 +0200)

----------------------------------------------------------------
KVM: s390: Fix instruction-execution-protection/change-recording override

This is a fix that prevents translation exception errors
on valid page tables for the instruction-exection-protection
support. This feature was added during the 4.11 merge window.
We have to remove an old check that would trigger if the
change-recording override is not available (e.g. edat1 disabled
via cpu model).

----------------------------------------------------------------
Heiko Carstens (1):
      KVM: s390: remove change-recording override support

 arch/s390/kvm/gaccess.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)
