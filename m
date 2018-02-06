From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 2/2] KVM: s390: use switch vs jump table in intercept.c
Date: Tue,  6 Feb 2018 11:21:27 +0000
Message-ID: <20180206112127.19014-3-borntraeger@de.ibm.com>
References: <20180206112127.19014-1-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20180206112127.19014-1-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, David Hildenbrand <david@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

instead of having huge jump tables for function selection,
lets use normal switch/case statements for the instruction
handlers in intercept.c We can now also get rid of
intercept_handler_t.

bloat-o-meter output:
add/remove: 0/1 grow/shrink: 1/0 up/down: 280/-2048 (-1768)
Function                                     old     new   delta
kvm_handle_sie_intercept                    1530    1810    +280
instruction_handlers                        2048       -   -2048
Total: Before=5227, After=3459, chg -33.82%

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/intercept.c | 54 ++++++++++++++++++++++++-----------------------
 arch/s390/kvm/kvm-s390.h  |  2 --
 2 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/arch/s390/kvm/intercept.c b/arch/s390/kvm/intercept.c
index 9c7d70715862..047e711d1fd1 100644
--- a/arch/s390/kvm/intercept.c
+++ b/arch/s390/kvm/intercept.c
@@ -22,22 +22,6 @@
 #include "trace.h"
 #include "trace-s390.h"
 
-
-static const intercept_handler_t instruction_handlers[256] = {
-	[0x01] = kvm_s390_handle_01,
-	[0x82] = kvm_s390_handle_lpsw,
-	[0x83] = kvm_s390_handle_diag,
-	[0xaa] = kvm_s390_handle_aa,
-	[0xae] = kvm_s390_handle_sigp,
-	[0xb2] = kvm_s390_handle_b2,
-	[0xb6] = kvm_s390_handle_stctl,
-	[0xb7] = kvm_s390_handle_lctl,
-	[0xb9] = kvm_s390_handle_b9,
-	[0xe3] = kvm_s390_handle_e3,
-	[0xe5] = kvm_s390_handle_e5,
-	[0xeb] = kvm_s390_handle_eb,
-};
-
 u8 kvm_s390_get_ilen(struct kvm_vcpu *vcpu)
 {
 	struct kvm_s390_sie_block *sie_block = vcpu->arch.sie_block;
@@ -129,16 +113,34 @@ static int handle_validity(struct kvm_vcpu *vcpu)
 
 static int handle_instruction(struct kvm_vcpu *vcpu)
 {
-	intercept_handler_t handler;
-
-	vcpu->stat.exit_instruction++;
-	trace_kvm_s390_intercept_instruction(vcpu,
-					     vcpu->arch.sie_block->ipa,
-					     vcpu->arch.sie_block->ipb);
-	handler = instruction_handlers[vcpu->arch.sie_block->ipa >> 8];
-	if (handler)
-		return handler(vcpu);
-	return -EOPNOTSUPP;
+	switch (vcpu->arch.sie_block->ipa >> 8) {
+	case 0x01:
+		return kvm_s390_handle_01(vcpu);
+	case 0x82:
+		return kvm_s390_handle_lpsw(vcpu);
+	case 0x83:
+		return kvm_s390_handle_diag(vcpu);
+	case 0xaa:
+		return kvm_s390_handle_aa(vcpu);
+	case 0xae:
+		return kvm_s390_handle_sigp(vcpu);
+	case 0xb2:
+		return kvm_s390_handle_b2(vcpu);
+	case 0xb6:
+		return kvm_s390_handle_stctl(vcpu);
+	case 0xb7:
+		return kvm_s390_handle_lctl(vcpu);
+	case 0xb9:
+		return kvm_s390_handle_b9(vcpu);
+	case 0xe3:
+		return kvm_s390_handle_e3(vcpu);
+	case 0xe5:
+		return kvm_s390_handle_e5(vcpu);
+	case 0xeb:
+		return kvm_s390_handle_eb(vcpu);
+	default:
+		return -EOPNOTSUPP;
+	}
 }
 
 static int inject_prog_on_prog_intercept(struct kvm_vcpu *vcpu)
diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
index bd31b37b0e6f..3c0a975c2477 100644
--- a/arch/s390/kvm/kvm-s390.h
+++ b/arch/s390/kvm/kvm-s390.h
@@ -19,8 +19,6 @@
 #include <asm/processor.h>
 #include <asm/sclp.h>
 
-typedef int (*intercept_handler_t)(struct kvm_vcpu *vcpu);
-
 /* Transactional Memory Execution related macros */
 #define IS_TE_ENABLED(vcpu)	((vcpu->arch.sie_block->ecb & ECB_TE))
 #define TDB_FORMAT1		1
-- 
2.14.3
