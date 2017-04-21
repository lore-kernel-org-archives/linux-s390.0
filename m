From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 0/4] KVM: s390: Guarded storage fixup and keyless subset mode (kvm/next)
Date: Fri, 21 Apr 2017 12:09:41 +0200
Message-ID: <1492769385-237420-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

Paolo, Radim,

here are 4 patches for s390 for 4.12 via kvm/next.
2 things
- 2 fixups for guarded storage
- detect and implement the keyless subset mode
- there is one s390 sclp patch as a pre-req. It does not cause any
  conflict with todays linux-next and is acked by Martin

please pull into kvm/next

The following changes since commit f7b1a77d3bfbdc7e91a1e48e0a3dc10e7d890e04:

  Merge tag 'kvm-s390-next-4.12-1' of git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux (2017-04-11 20:54:40 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-next-4.12-2

for you to fetch changes up to 730cd632c4e485b90f97fe998e300045da094938:

  KVM: s390: Support keyless subset guest mode (2017-04-21 11:08:11 +0200)

----------------------------------------------------------------
KVM: s390: Guarded storage fixup and keyless subset mode

- detect and use the keyless subset mode (guests without
  storage keys)
- fix vSIE support for sdnxc
- fix machine check data for guarded storage

----------------------------------------------------------------
Christian Borntraeger (2):
      KVM: s390: Fix sdnxo setting for nested guests
      KVM: s390: fix stale machine check data for guarded storage

Farhan Ali (2):
      s390/sclp: Detect KSS facility
      KVM: s390: Support keyless subset guest mode

 arch/s390/include/asm/kvm_host.h |  2 ++
 arch/s390/include/asm/sclp.h     |  1 +
 arch/s390/include/uapi/asm/kvm.h |  1 +
 arch/s390/kvm/intercept.c        |  3 +++
 arch/s390/kvm/interrupt.c        |  2 ++
 arch/s390/kvm/kvm-s390.c         |  8 +++++++-
 arch/s390/kvm/kvm-s390.h         |  1 +
 arch/s390/kvm/priv.c             | 19 +++++++++++++------
 arch/s390/kvm/vsie.c             |  8 ++++++--
 drivers/s390/char/sclp_early.c   |  4 +++-
 10 files changed, 39 insertions(+), 10 deletions(-)
