From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 0/2] KVM: s390/mm: Two fixes for master (3.17)
Date: Tue,  2 Sep 2014 10:58:43 +0200
Message-ID: <1409648325-2926-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Gleb Natapov <gleb@kernel.org>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Paolo,

this request is against kvm/master and contains two fixes for guests
that use storage keys. 


The following changes since commit ab3f285f227fec62868037e9b1b1fd18294a83b8:

  KVM: s390/mm: try a cow on read only pages for key ops (2014-08-25 14:35:28 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-master-20140902

for you to fetch changes up to 1951497d90d6754201af3e65241a06f9ef6755cd:

  KVM: s390/mm: Fix guest storage key corruption in ptep_set_access_flags (2014-09-02 10:30:43 +0200)

----------------------------------------------------------------
KVM: s390/mm: Fix two guest storage key corruptions on paging

Here are two patches that fix issues that were introduced with
commit 0944fe3f4a32 ("s390/mm: implement software referenced bits").
This commit introduced additional invalid<->valid transitions that
we need to handle to transfer the storage key from/to pgste.

----------------------------------------------------------------
Christian Borntraeger (2):
      KVM: s390/mm: Fix storage key corruption during swapping
      KVM: s390/mm: Fix guest storage key corruption in ptep_set_access_flags

 arch/s390/include/asm/pgtable.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)
