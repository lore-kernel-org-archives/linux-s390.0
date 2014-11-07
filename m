From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 2/4] KVM: s390: flush CPU on load control
Date: Fri,  7 Nov 2014 12:45:14 +0100
Message-ID: <1415360716-9670-3-git-send-email-borntraeger@de.ibm.com>
References: <1415360716-9670-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1415360716-9670-1-git-send-email-borntraeger@de.ibm.com>
Sender: stable-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Gleb Natapov <gleb@kernel.org>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, stable@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

some control register changes will flush some aspects of the CPU, e.g.
POP explicitely mentions that for CR9-CR11 "TLBs may be cleared".
Instead of trying to be clever and only flush on specific CRs, let
play safe and flush on all lctl(g) as future machines might define
new bits in CRs. Load control intercept should not happen that often.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Reviewed-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Cc: stable@vger.kernel.org
---
 arch/s390/kvm/priv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index 72bb2dd..9c565b6 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -791,7 +791,7 @@ int kvm_s390_handle_lctl(struct kvm_vcpu *vcpu)
 			break;
 		reg = (reg + 1) % 16;
 	} while (1);
-
+	kvm_make_request(KVM_REQ_TLB_FLUSH, vcpu);
 	return 0;
 }
 
@@ -863,7 +863,7 @@ static int handle_lctlg(struct kvm_vcpu *vcpu)
 			break;
 		reg = (reg + 1) % 16;
 	} while (1);
-
+	kvm_make_request(KVM_REQ_TLB_FLUSH, vcpu);
 	return 0;
 }
 
-- 
1.9.3
