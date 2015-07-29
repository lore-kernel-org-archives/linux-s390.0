From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 14/16] KVM: s390: adapt debug entries for instruction handling
Date: Wed, 29 Jul 2015 11:06:04 +0200
Message-ID: <1438160766-108179-15-git-send-email-borntraeger@de.ibm.com>
References: <1438160766-108179-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1438160766-108179-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Alexander Graf <agraf@suse.de>, KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Use the default log level 3 for state changing and/or seldom events,
use 4 for others. Also change some numbers from %x to %d and vice versa
to match documentation. If hex, let's prepend the numbers with 0x.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 arch/s390/kvm/priv.c | 22 ++++++++++++----------
 arch/s390/kvm/sigp.c | 10 +++++-----
 2 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index 2658a791..afefa3b 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -53,6 +53,7 @@ static int handle_set_clock(struct kvm_vcpu *vcpu)
 		kvm_s390_set_psw_cc(vcpu, 3);
 		return 0;
 	}
+	VCPU_EVENT(vcpu, 3, "SCK: setting guest TOD to 0x%llx", val);
 	val = (val - hostclk) & ~0x3fUL;
 
 	mutex_lock(&vcpu->kvm->lock);
@@ -127,7 +128,7 @@ static int handle_store_prefix(struct kvm_vcpu *vcpu)
 	if (rc)
 		return kvm_s390_inject_prog_cond(vcpu, rc);
 
-	VCPU_EVENT(vcpu, 5, "storing prefix to %x", address);
+	VCPU_EVENT(vcpu, 3, "STPX: storing prefix 0x%x into 0x%llx", address, operand2);
 	trace_kvm_s390_handle_prefix(vcpu, 0, address);
 	return 0;
 }
@@ -153,7 +154,7 @@ static int handle_store_cpu_address(struct kvm_vcpu *vcpu)
 	if (rc)
 		return kvm_s390_inject_prog_cond(vcpu, rc);
 
-	VCPU_EVENT(vcpu, 5, "storing cpu address to %llx", ga);
+	VCPU_EVENT(vcpu, 3, "STAP: storing cpu address (%u) to 0x%llx", vcpu_id, ga);
 	trace_kvm_s390_handle_stap(vcpu, ga);
 	return 0;
 }
@@ -165,6 +166,7 @@ static int __skey_check_enable(struct kvm_vcpu *vcpu)
 		return rc;
 
 	rc = s390_enable_skey();
+	VCPU_EVENT(vcpu, 3, "%s", "enabling storage keys for guest");
 	trace_kvm_s390_skey_related_inst(vcpu);
 	vcpu->arch.sie_block->ictl &= ~(ICTL_ISKE | ICTL_SSKE | ICTL_RRBE);
 	return rc;
@@ -368,7 +370,7 @@ static int handle_stfl(struct kvm_vcpu *vcpu)
 			    &fac, sizeof(fac));
 	if (rc)
 		return rc;
-	VCPU_EVENT(vcpu, 5, "store facility list value %x", fac);
+	VCPU_EVENT(vcpu, 3, "STFL: store facility list 0x%x", fac);
 	trace_kvm_s390_handle_stfl(vcpu, fac);
 	return 0;
 }
@@ -466,7 +468,7 @@ static int handle_stidp(struct kvm_vcpu *vcpu)
 	if (rc)
 		return kvm_s390_inject_prog_cond(vcpu, rc);
 
-	VCPU_EVENT(vcpu, 5, "%s", "store cpu id");
+	VCPU_EVENT(vcpu, 3, "STIDP: store cpu id 0x%llx", stidp_data);
 	return 0;
 }
 
@@ -519,7 +521,7 @@ static int handle_stsi(struct kvm_vcpu *vcpu)
 	ar_t ar;
 
 	vcpu->stat.instruction_stsi++;
-	VCPU_EVENT(vcpu, 4, "stsi: fc: %x sel1: %x sel2: %x", fc, sel1, sel2);
+	VCPU_EVENT(vcpu, 3, "STSI: fc: %u sel1: %u sel2: %u", fc, sel1, sel2);
 
 	if (vcpu->arch.sie_block->gpsw.mask & PSW_MASK_PSTATE)
 		return kvm_s390_inject_program_int(vcpu, PGM_PRIVILEGED_OP);
@@ -756,7 +758,7 @@ static int handle_essa(struct kvm_vcpu *vcpu)
 	struct gmap *gmap;
 	int i;
 
-	VCPU_EVENT(vcpu, 5, "cmma release %d pages", entries);
+	VCPU_EVENT(vcpu, 4, "ESSA: release %d pages", entries);
 	gmap = vcpu->arch.gmap;
 	vcpu->stat.instruction_essa++;
 	if (!vcpu->kvm->arch.use_cmma)
@@ -827,7 +829,7 @@ int kvm_s390_handle_lctl(struct kvm_vcpu *vcpu)
 	if (ga & 3)
 		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
 
-	VCPU_EVENT(vcpu, 5, "lctl r1:%x, r3:%x, addr:%llx", reg1, reg3, ga);
+	VCPU_EVENT(vcpu, 4, "LCTL: r1:%d, r3:%d, addr: 0x%llx", reg1, reg3, ga);
 	trace_kvm_s390_handle_lctl(vcpu, 0, reg1, reg3, ga);
 
 	nr_regs = ((reg3 - reg1) & 0xf) + 1;
@@ -866,7 +868,7 @@ int kvm_s390_handle_stctl(struct kvm_vcpu *vcpu)
 	if (ga & 3)
 		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
 
-	VCPU_EVENT(vcpu, 5, "stctl r1:%x, r3:%x, addr:%llx", reg1, reg3, ga);
+	VCPU_EVENT(vcpu, 4, "STCTL r1:%d, r3:%d, addr: 0x%llx", reg1, reg3, ga);
 	trace_kvm_s390_handle_stctl(vcpu, 0, reg1, reg3, ga);
 
 	reg = reg1;
@@ -900,7 +902,7 @@ static int handle_lctlg(struct kvm_vcpu *vcpu)
 	if (ga & 7)
 		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
 
-	VCPU_EVENT(vcpu, 5, "lctlg r1:%x, r3:%x, addr:%llx", reg1, reg3, ga);
+	VCPU_EVENT(vcpu, 4, "LCTLG: r1:%d, r3:%d, addr: 0x%llx", reg1, reg3, ga);
 	trace_kvm_s390_handle_lctl(vcpu, 1, reg1, reg3, ga);
 
 	nr_regs = ((reg3 - reg1) & 0xf) + 1;
@@ -938,7 +940,7 @@ static int handle_stctg(struct kvm_vcpu *vcpu)
 	if (ga & 7)
 		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
 
-	VCPU_EVENT(vcpu, 5, "stctg r1:%x, r3:%x, addr:%llx", reg1, reg3, ga);
+	VCPU_EVENT(vcpu, 4, "STCTG r1:%d, r3:%d, addr: 0x%llx", reg1, reg3, ga);
 	trace_kvm_s390_handle_stctl(vcpu, 1, reg1, reg3, ga);
 
 	reg = reg1;
diff --git a/arch/s390/kvm/sigp.c b/arch/s390/kvm/sigp.c
index 5318ea3..da690b6 100644
--- a/arch/s390/kvm/sigp.c
+++ b/arch/s390/kvm/sigp.c
@@ -368,7 +368,8 @@ static int handle_sigp_dst(struct kvm_vcpu *vcpu, u8 order_code,
 	return rc;
 }
 
-static int handle_sigp_order_in_user_space(struct kvm_vcpu *vcpu, u8 order_code)
+static int handle_sigp_order_in_user_space(struct kvm_vcpu *vcpu, u8 order_code,
+					   u16 cpu_addr)
 {
 	if (!vcpu->kvm->arch.user_sigp)
 		return 0;
@@ -411,9 +412,8 @@ static int handle_sigp_order_in_user_space(struct kvm_vcpu *vcpu, u8 order_code)
 	default:
 		vcpu->stat.instruction_sigp_unknown++;
 	}
-
-	VCPU_EVENT(vcpu, 4, "sigp order %u: completely handled in user space",
-		   order_code);
+	VCPU_EVENT(vcpu, 3, "SIGP: order %u for CPU %d handled in userspace",
+		   order_code, cpu_addr);
 
 	return 1;
 }
@@ -432,7 +432,7 @@ int kvm_s390_handle_sigp(struct kvm_vcpu *vcpu)
 		return kvm_s390_inject_program_int(vcpu, PGM_PRIVILEGED_OP);
 
 	order_code = kvm_s390_get_base_disp_rs(vcpu, NULL);
-	if (handle_sigp_order_in_user_space(vcpu, order_code))
+	if (handle_sigp_order_in_user_space(vcpu, order_code, cpu_addr))
 		return -EOPNOTSUPP;
 
 	if (r1 % 2)
-- 
2.3.0
