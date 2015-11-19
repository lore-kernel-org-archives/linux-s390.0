From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 0/4] Preview: vcpu lookup by id changes
Date: Thu, 19 Nov 2015 09:37:27 +0100
Message-ID: <1447922251-54261-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@suse.de>, Paul Mackerras <paulus@samba.org>, David Hildenbrand <dahi@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, kvm-ppc@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Paolo,

some more patches for review before I add them in my next pull request.
Can you review the common code changes and Ack/Nack?

Alex, Paul,
can you review the power changes and Ack/Nack? 

As I want to have patch 2 in 4.4, I splitted up Davids patch into smaller
chunks. David, can you double check that I did not mess up?
So I want to send patch 1 and patch 2 for 4.4. Patch 3 and Patch 4
are for kvm/next (4.5), but need patch 1 as well. 
So I will probably also add all patches into kvm/next by setting up
the git branches in a way that during 4.5 merge window kvm/next will
have my branch that will go via kvm/master as common ancestor.

Ok?

Christian

David Hildenbrand (4):
  KVM: Provide function for VCPU lookup by id
  KVM: s390: fix wrong lookup of VCPUs by array index
  KVM: use heuristic for fast VCPU lookup by id
  KVM: Use common function for VCPU lookup by id

 arch/powerpc/kvm/book3s_hv.c | 10 ++--------
 arch/s390/kvm/diag.c         | 11 +++--------
 arch/s390/kvm/sigp.c         |  8 ++------
 include/linux/kvm_host.h     | 16 ++++++++++++++++
 virt/kvm/kvm_main.c          | 12 +++++-------
 5 files changed, 28 insertions(+), 29 deletions(-)

-- 
2.3.0
