From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 0/3] KVM: s390: Bugfix and cleanups for kvm/next (4.4)
Date: Thu, 29 Oct 2015 16:08:26 +0100
Message-ID: <1446131309-176770-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Alexander Graf <agraf@suse.de>, KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

The following changes since commit 60417fcc2b0235dfe3dcd589c56dbe3ea1a64c54:

  KVM: s390: factor out reading of the guest TOD clock (2015-10-13 15:50:35 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-next-20151028

for you to fetch changes up to 46b708ea875f14f5496109df053624199f3aae87:

  KVM: s390: use simple switch statement as multiplexer (2015-10-29 15:59:11 +0100)

----------------------------------------------------------------
KVM: s390: Bugfix and cleanups

There is one important bug fix for a potential memory corruption
and/or guest errors for guests with 63 or 64 vCPUs. This fix would
qualify for 4.3 but is some days too late giving that we are
about to release 4.3.
Given that this patch is cc stable >= 3.15 anyway, we can handle
it via 4.4. merge window.

This pull reuqest also contains two cleanups.

----------------------------------------------------------------
Christian Borntraeger (2):
      KVM: s390: drop useless newline in debugging data
      KVM: s390: use simple switch statement as multiplexer

David Hildenbrand (1):
      KVM: s390: SCA must not cross page boundaries

 arch/s390/kvm/intercept.c | 42 +++++++++++++++++++++---------------------
 arch/s390/kvm/kvm-s390.c  | 12 +++++++-----
 2 files changed, 28 insertions(+), 26 deletions(-)
