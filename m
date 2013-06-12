From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH 2/6] KVM: s390: guest large pages
Date: Wed, 12 Jun 2013 13:54:53 +0200
Message-ID: <1371038097-28577-3-git-send-email-cornelia.huck@de.ibm.com>
References: <1371038097-28577-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1371038097-28577-1-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Gleb Natapov <gleb@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

From: Christian Borntraeger <borntraeger@de.ibm.com>

This patch enables kvm to give large pages to the guest. The heavy
lifting is done by the hardware, the host only has to take care
of the PFMF instruction, which is also part of EDAT-1.

We also support the non-quiescing key setting facility if the host
supports it, to behave similar to the interpretation of sske.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 arch/s390/include/asm/kvm_host.h |  5 ++-
 arch/s390/kvm/kvm-s390.c         |  7 +++-
 arch/s390/kvm/kvm-s390.h         |  6 +++
 arch/s390/kvm/priv.c             | 86 +++++++++++++++++++++++++++++++++++++++-
 4 files changed, 99 insertions(+), 5 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 9a809f9..43207dd 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -62,6 +62,7 @@ struct sca_block {
 #define CPUSTAT_MCDS       0x00000100
 #define CPUSTAT_SM         0x00000080
 #define CPUSTAT_G          0x00000008
+#define CPUSTAT_GED        0x00000004
 #define CPUSTAT_J          0x00000002
 #define CPUSTAT_P          0x00000001
 
@@ -96,7 +97,8 @@ struct kvm_s390_sie_block {
 	__u32	scaoh;			/* 0x005c */
 	__u8	reserved60;		/* 0x0060 */
 	__u8	ecb;			/* 0x0061 */
-	__u8	reserved62[2];		/* 0x0062 */
+	__u8    ecb2;                   /* 0x0062 */
+	__u8    reserved63[1];          /* 0x0063 */
 	__u32	scaol;			/* 0x0064 */
 	__u8	reserved68[4];		/* 0x0068 */
 	__u32	todpr;			/* 0x006c */
@@ -136,6 +138,7 @@ struct kvm_vcpu_stat {
 	u32 deliver_program_int;
 	u32 deliver_io_int;
 	u32 exit_wait_state;
+	u32 instruction_pfmf;
 	u32 instruction_stidp;
 	u32 instruction_spx;
 	u32 instruction_stpx;
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 93444c4..e56caec 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -59,6 +59,7 @@ struct kvm_stats_debugfs_item debugfs_entries[] = {
 	{ "deliver_restart_signal", VCPU_STAT(deliver_restart_signal) },
 	{ "deliver_program_interruption", VCPU_STAT(deliver_program_int) },
 	{ "exit_wait_state", VCPU_STAT(exit_wait_state) },
+	{ "instruction_pfmf", VCPU_STAT(instruction_pfmf) },
 	{ "instruction_stidp", VCPU_STAT(instruction_stidp) },
 	{ "instruction_spx", VCPU_STAT(instruction_spx) },
 	{ "instruction_stpx", VCPU_STAT(instruction_stpx) },
@@ -381,8 +382,10 @@ int kvm_arch_vcpu_setup(struct kvm_vcpu *vcpu)
 {
 	atomic_set(&vcpu->arch.sie_block->cpuflags, CPUSTAT_ZARCH |
 						    CPUSTAT_SM |
-						    CPUSTAT_STOPPED);
+						    CPUSTAT_STOPPED |
+						    CPUSTAT_GED);
 	vcpu->arch.sie_block->ecb   = 6;
+	vcpu->arch.sie_block->ecb2  = 8;
 	vcpu->arch.sie_block->eca   = 0xC1002001U;
 	vcpu->arch.sie_block->fac   = (int) (long) facilities;
 	hrtimer_init(&vcpu->arch.ckc_timer, CLOCK_REALTIME, HRTIMER_MODE_ABS);
@@ -1125,7 +1128,7 @@ static int __init kvm_s390_init(void)
 		return -ENOMEM;
 	}
 	memcpy(facilities, S390_lowcore.stfle_fac_list, 16);
-	facilities[0] &= 0xff00fff3f47c0000ULL;
+	facilities[0] &= 0xff82fff3f47c0000ULL;
 	facilities[1] &= 0x001c000000000000ULL;
 	return 0;
 }
diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
index 269b523..15795b8 100644
--- a/arch/s390/kvm/kvm-s390.h
+++ b/arch/s390/kvm/kvm-s390.h
@@ -86,6 +86,12 @@ static inline void kvm_s390_get_base_disp_sse(struct kvm_vcpu *vcpu,
 	*address2 = (base2 ? vcpu->run->s.regs.gprs[base2] : 0) + disp2;
 }
 
+static inline void kvm_s390_get_regs_rre(struct kvm_vcpu *vcpu, int *r1, int *r2)
+{
+	*r1 = (vcpu->arch.sie_block->ipb & 0x00f00000) >> 20;
+	*r2 = (vcpu->arch.sie_block->ipb & 0x000f0000) >> 16;
+}
+
 static inline u64 kvm_s390_get_base_disp_rsy(struct kvm_vcpu *vcpu)
 {
 	u32 base2 = vcpu->arch.sie_block->ipb >> 28;
diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index ecc58a6..bda9c9b 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -1,7 +1,7 @@
 /*
  * handling privileged instructions
  *
- * Copyright IBM Corp. 2008
+ * Copyright IBM Corp. 2008, 2013
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License (version 2 only)
@@ -20,6 +20,9 @@
 #include <asm/debug.h>
 #include <asm/ebcdic.h>
 #include <asm/sysinfo.h>
+#include <asm/pgtable.h>
+#include <asm/pgalloc.h>
+#include <asm/io.h>
 #include <asm/ptrace.h>
 #include <asm/compat.h>
 #include "gaccess.h"
@@ -212,7 +215,7 @@ static int handle_stfl(struct kvm_vcpu *vcpu)
 
 	vcpu->stat.instruction_stfl++;
 	/* only pass the facility bits, which we can handle */
-	facility_list = S390_lowcore.stfl_fac_list & 0xff00fff3;
+	facility_list = S390_lowcore.stfl_fac_list & 0xff82fff3;
 
 	rc = copy_to_guest(vcpu, offsetof(struct _lowcore, stfl_fac_list),
 			   &facility_list, sizeof(facility_list));
@@ -468,9 +471,88 @@ static int handle_epsw(struct kvm_vcpu *vcpu)
 	return 0;
 }
 
+#define PFMF_RESERVED   0xfffc0101UL
+#define PFMF_SK         0x00020000UL
+#define PFMF_CF         0x00010000UL
+#define PFMF_UI         0x00008000UL
+#define PFMF_FSC        0x00007000UL
+#define PFMF_NQ         0x00000800UL
+#define PFMF_MR         0x00000400UL
+#define PFMF_MC         0x00000200UL
+#define PFMF_KEY        0x000000feUL
+
+static int handle_pfmf(struct kvm_vcpu *vcpu)
+{
+	int reg1, reg2;
+	unsigned long start, end;
+
+	vcpu->stat.instruction_pfmf++;
+
+	kvm_s390_get_regs_rre(vcpu, &reg1, &reg2);
+
+	if (!MACHINE_HAS_PFMF)
+		return kvm_s390_inject_program_int(vcpu, PGM_OPERATION);
+
+	if (vcpu->arch.sie_block->gpsw.mask & PSW_MASK_PSTATE)
+		return kvm_s390_inject_program_int(vcpu, PGM_PRIVILEGED_OPERATION);
+
+	if (vcpu->run->s.regs.gprs[reg1] & PFMF_RESERVED)
+		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
+
+	/* Only provide non-quiescing support if the host supports it */
+	if (vcpu->run->s.regs.gprs[reg1] & PFMF_NQ &&
+	    S390_lowcore.stfl_fac_list & 0x00020000)
+		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
+
+	/* No support for conditional-SSKE */
+	if (vcpu->run->s.regs.gprs[reg1] & (PFMF_MR | PFMF_MC))
+		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
+
+	start = vcpu->run->s.regs.gprs[reg2] & PAGE_MASK;
+	switch (vcpu->run->s.regs.gprs[reg1] & PFMF_FSC) {
+	case 0x00000000:
+		end = (start + (1UL << 12)) & ~((1UL << 12) - 1);
+		break;
+	case 0x00001000:
+		end = (start + (1UL << 20)) & ~((1UL << 20) - 1);
+		break;
+	/* We dont support EDAT2
+	case 0x00002000:
+		end = (start + (1UL << 31)) & ~((1UL << 31) - 1);
+		break;*/
+	default:
+		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
+	}
+	while (start < end) {
+		unsigned long useraddr;
+
+		useraddr = gmap_translate(start, vcpu->arch.gmap);
+		if (IS_ERR((void *)useraddr))
+			return kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
+
+		if (vcpu->run->s.regs.gprs[reg1] & PFMF_CF) {
+			if (clear_user((void __user *)useraddr, PAGE_SIZE))
+				return kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
+		}
+
+		if (vcpu->run->s.regs.gprs[reg1] & PFMF_SK) {
+			if (set_guest_storage_key(current->mm, useraddr,
+					vcpu->run->s.regs.gprs[reg1] & PFMF_KEY,
+					vcpu->run->s.regs.gprs[reg1] & PFMF_NQ))
+				return kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
+		}
+
+		start += PAGE_SIZE;
+	}
+	if (vcpu->run->s.regs.gprs[reg1] & PFMF_FSC)
+		vcpu->run->s.regs.gprs[reg2] = end;
+	return 0;
+}
+
 static const intercept_handler_t b9_handlers[256] = {
 	[0x8d] = handle_epsw,
 	[0x9c] = handle_io_inst,
+	[0xaf] = handle_pfmf,
 };
 
 int kvm_s390_handle_b9(struct kvm_vcpu *vcpu)
-- 
1.8.1.6
