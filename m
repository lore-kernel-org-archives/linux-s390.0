From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 17/20] KVM: s390: Vector exceptions
Date: Fri,  6 Mar 2015 14:16:49 +0100
Message-ID: <1425647812-61838-18-git-send-email-borntraeger@de.ibm.com>
References: <1425647812-61838-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1425647812-61838-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>, Eric Farman <farman@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Eric Farman <farman@linux.vnet.ibm.com>

A new exception type for vector instructions is introduced with
the new processor, but is handled exactly like a Data Exception
which is already handled by the system.

Signed-off-by: Eric Farman <farman@linux.vnet.ibm.com>
Reviewed-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/kvm_host.h | 1 +
 arch/s390/kvm/intercept.c        | 1 +
 arch/s390/kvm/interrupt.c        | 1 +
 3 files changed, 3 insertions(+)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 3449a38..fb1fd39 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -276,6 +276,7 @@ struct kvm_vcpu_stat {
 #define PGM_SPECIAL_OPERATION		0x13
 #define PGM_OPERAND			0x15
 #define PGM_TRACE_TABEL			0x16
+#define PGM_VECTOR_PROCESSING		0x1b
 #define PGM_SPACE_SWITCH		0x1c
 #define PGM_HFP_SQUARE_ROOT		0x1d
 #define PGM_PC_TRANSLATION_SPEC		0x1f
diff --git a/arch/s390/kvm/intercept.c b/arch/s390/kvm/intercept.c
index bebd215..08ae10a 100644
--- a/arch/s390/kvm/intercept.c
+++ b/arch/s390/kvm/intercept.c
@@ -165,6 +165,7 @@ static void __extract_prog_irq(struct kvm_vcpu *vcpu,
 		pgm_info->mon_class_nr = vcpu->arch.sie_block->mcn;
 		pgm_info->mon_code = vcpu->arch.sie_block->tecmc;
 		break;
+	case PGM_VECTOR_PROCESSING:
 	case PGM_DATA:
 		pgm_info->data_exc_code = vcpu->arch.sie_block->dxc;
 		break;
diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 9561e1d..036d375 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -544,6 +544,7 @@ static int __must_check __deliver_prog(struct kvm_vcpu *vcpu)
 		rc |= put_guest_lc(vcpu, pgm_info.mon_code,
 				   (u64 *)__LC_MON_CODE);
 		break;
+	case PGM_VECTOR_PROCESSING:
 	case PGM_DATA:
 		rc = put_guest_lc(vcpu, pgm_info.data_exc_code,
 				  (u32 *)__LC_DATA_EXC_CODE);
-- 
2.3.0
