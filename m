From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 0/3] KVM: s390: feature for 4.12 (kvm/next)
Date: Wed, 26 Apr 2017 14:38:12 +0200
Message-ID: <1493210295-58687-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Paolo, Radim,

one last feature for 4.12. This pull request contains 2 patches for the
s390 base maintainers. These patches are necessary for the 3rd one.
I handled it via a a merge of a topic branch that will also be merged
by Martins s390 tree.

The following changes since commit 730cd632c4e485b90f97fe998e300045da094938:

  KVM: s390: Support keyless subset guest mode (2017-04-21 11:08:11 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-next-4.12-3

for you to fetch changes up to e000b8e0968dd7bfa09c444607ce1e48e57aafd3:

  s390: kvm: Cpu model support for msa6, msa7 and msa8 (2017-04-26 14:19:01 +0200)

----------------------------------------------------------------
KVM: s390: MSA8 feature for guests

- Detect all function codes for KMA and export the features
  for use in the cpu model

----------------------------------------------------------------
Christian Borntraeger (1):
      Merge branch 's390forkvm' of git://git.kernel.org/.../kvms390/linux

Jason J. Herne (3):
      s390/cpacf: query instructions use unique parameters for compatibility with KMA
      s390/cpacf: Introduce kma instruction
      s390: kvm: Cpu model support for msa6, msa7 and msa8

 Documentation/virtual/kvm/devices/vm.txt | 3 ++-
 arch/s390/include/asm/cpacf.h            | 5 +++--
 arch/s390/include/uapi/asm/kvm.h         | 3 ++-
 arch/s390/kvm/kvm-s390.c                 | 4 ++++
 arch/s390/tools/gen_facilities.c         | 1 +
 tools/arch/s390/include/uapi/asm/kvm.h   | 3 ++-
 6 files changed, 14 insertions(+), 5 deletions(-)
