From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 3/9] KVM: s390: Fix size of monitor-class number field
Date: Tue, 28 Oct 2014 20:39:53 +0100
Message-ID: <1414525199-53989-4-git-send-email-borntraeger@de.ibm.com>
References: <1414525199-53989-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1414525199-53989-1-git-send-email-borntraeger@de.ibm.com>
Sender: stable-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Gleb Natapov <gleb@kernel.org>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Thomas Huth <thuth@linux.vnet.ibm.com>, stable@vger.kernel.org, #@tuxmaker.boeblingen.de.ibm.com, v3.16+@tuxmaker.boeblingen.de.ibm.com, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Thomas Huth <thuth@linux.vnet.ibm.com>

The monitor-class number field is only 16 bits, so we have to use
a u16 pointer to access it.

Signed-off-by: Thomas Huth <thuth@linux.vnet.ibm.com>
Reviewed-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
CC: stable@vger.kernel.org # v3.16+
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/interrupt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index a398384..4fc3fed 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -270,7 +270,7 @@ static int __must_check __deliver_prog_irq(struct kvm_vcpu *vcpu,
 		break;
 	case PGM_MONITOR:
 		rc = put_guest_lc(vcpu, pgm_info->mon_class_nr,
-				  (u64 *)__LC_MON_CLASS_NR);
+				  (u16 *)__LC_MON_CLASS_NR);
 		rc |= put_guest_lc(vcpu, pgm_info->mon_code,
 				   (u64 *)__LC_MON_CODE);
 		break;
-- 
1.9.3
