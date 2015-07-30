From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 0/1] KVM: s390: bugfix for kvm/master (4.2)
Date: Thu, 30 Jul 2015 13:22:45 +0200
Message-ID: <1438255366-25805-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Alexander Graf <agraf@suse.de>, KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Paolo,

The following changes since commit 0da029ed7ee5fdf49a2a0e14160c3e9999be9292:

  KVM: x86: rename quirk constants to KVM_X86_QUIRK_* (2015-07-23 08:24:42 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-master-20150730

for you to fetch changes up to 586b7ccdb7143b6a9b975d2c6ad52b6ca5c162b9:

  KVM: s390: Fix hang VCPU hang/loop regression (2015-07-30 13:11:13 +0200)

----------------------------------------------------------------
KVM: s390: bugfix for kvm/master (4.2)

Here is a bugfix for a regression that was introduced after 4.1
with the commit commit 785dbef407d8 ("KVM: s390: optimize round
trip time in request handling"). After lots of cpu hotplugs in the
guest (online/offline) sometimes a guest CPU did loop within host
KVM code. Reason was that PROG_REQUEST was set in the sie control
block, but no request was pending. This made commit 785dbef407d8
the suspect and changing that area to always reset PROG_REQUEST
did indeed fix the problem.

Special thanks to David Hildenbrand, who helped understanding the
exact sequence that led to the problem.

----------------------------------------------------------------
Christian Borntraeger (1):
      KVM: s390: Fix hang VCPU hang/loop regression

 arch/s390/kvm/kvm-s390.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
