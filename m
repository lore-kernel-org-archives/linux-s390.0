From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 24/24] KVM: s390: remove redundant setting of interrupt type
Date: Fri, 23 Jan 2015 13:37:22 +0100
Message-ID: <1422016642-52513-6-git-send-email-borntraeger@de.ibm.com>
References: <1422016642-52513-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1422016642-52513-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Jens Freimann <jfrei@linux.vnet.ibm.com>

Setting inti->type again is unnecessary here, so let's
remove this.

Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Jens Freimann <jfrei@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/interrupt.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 60d9edd0..c34e1d9 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -1296,7 +1296,6 @@ int kvm_s390_inject_vm(struct kvm *kvm,
 		inti->ext.ext_params = s390int->parm;
 		break;
 	case KVM_S390_INT_PFAULT_DONE:
-		inti->type = s390int->type;
 		inti->ext.ext_params2 = s390int->parm64;
 		break;
 	case KVM_S390_MCHK:
-- 
1.9.3
