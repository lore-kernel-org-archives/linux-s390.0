From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 0/2] kvm: provide kvm stat per process
Date: Wed, 18 Nov 2015 14:11:45 +0100
Message-ID: <1447852307-106478-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Paolo,

I plan to submit these patches via my next s390 pull request.
Basic idea is: we already have all kvm_stats per cpu and per
vm, lets provide some additional debugfs folders to get
kvm_stats also per VM to detect cases where only one guest
goes wild. (no per vCPU stats yet. Do we want those as well?)

Can you review and ack/nack? (Or as an alternative take the
patches yourself)


Janosch Frank (2):
  KVM: Remove unnecessary debugfs dentry references
  KVM: Create debugfs dir and stat files for each VM

 include/linux/kvm_host.h |   8 +-
 virt/kvm/kvm_main.c      | 206 ++++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 191 insertions(+), 23 deletions(-)

-- 
2.3.0
