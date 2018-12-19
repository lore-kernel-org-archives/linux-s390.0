From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 19 Dec 2018 09:24:49 +0000
Subject: [GIT PULL 0/2] KVM: s390: Fixes for 4.21
Message-Id: <20181219092451.37052-1-borntraeger@de.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Paolo, Radim,

just two small fixes for the next merge window. nested+hugepages in 
combination as well as interrupt support for crypto cards will slip
to the next round.

The following changes since commit ccda4af0f4b92f7b4c308d3acc262f4a7e3affad:

  Linux 4.20-rc2 (2018-11-11 17:12:31 -0600)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-next-4.21-1

for you to fetch changes up to 7aedd9d48f2a8332c2c51a40d2dca8c097f0dcdb:

  KVM: s390: fix kmsg component kvm-s390 (2018-12-18 10:18:27 +0100)

----------------------------------------------------------------
KVM: s390: Fixes for 4.21

Just two small fixes.

----------------------------------------------------------------
Michael Mueller (2):
      KVM: s390: unregister debug feature on failing arch init
      KVM: s390: fix kmsg component kvm-s390

 arch/s390/kvm/kvm-s390.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)
