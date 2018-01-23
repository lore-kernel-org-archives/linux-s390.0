From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH 2/5] s390/alternative: use a copy of the facility bit mask
Date: Tue, 23 Jan 2018 14:07:02 +0100
Message-ID: <1516712825-2917-3-git-send-email-schwidefsky@de.ibm.com>
References: <1516712825-2917-1-git-send-email-schwidefsky@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1516712825-2917-1-git-send-email-schwidefsky@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jon Masters <jcm@redhat.com>, Marcus Meissner <meissner@suse.de>, Jiri Kosina <jkosina@suse.cz>
List-ID: <linux-s390.vger.kernel.org>

To be able to switch off specific CPU alternatives with kernel parameters
make a copy of the facility bit mask provided by STFLE and use the copy
for the decision to apply an alternative.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---
 arch/s390/include/asm/facility.h | 18 ++++++++++++++++++
 arch/s390/include/asm/lowcore.h  |  3 ++-
 arch/s390/kernel/alternative.c   |  3 ++-
 arch/s390/kernel/early.c         |  3 +++
 arch/s390/kernel/setup.c         |  4 +++-
 arch/s390/kernel/smp.c           |  4 +++-
 6 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/arch/s390/include/asm/facility.h b/arch/s390/include/asm/facility.h
index f040644..2d58478 100644
--- a/arch/s390/include/asm/facility.h
+++ b/arch/s390/include/asm/facility.h
@@ -15,6 +15,24 @@
 
 #define MAX_FACILITY_BIT (sizeof(((struct lowcore *)0)->stfle_fac_list) * 8)
 
+static inline void __set_facility(unsigned long nr, void *facilities)
+{
+	unsigned char *ptr = (unsigned char *) facilities;
+
+	if (nr >= MAX_FACILITY_BIT)
+		return;
+	ptr[nr >> 3] |= 0x80 >> (nr & 7);
+}
+
+static inline void __clear_facility(unsigned long nr, void *facilities)
+{
+	unsigned char *ptr = (unsigned char *) facilities;
+
+	if (nr >= MAX_FACILITY_BIT)
+		return;
+	ptr[nr >> 3] &= ~(0x80 >> (nr & 7));
+}
+
 static inline int __test_facility(unsigned long nr, void *facilities)
 {
 	unsigned char *ptr;
diff --git a/arch/s390/include/asm/lowcore.h b/arch/s390/include/asm/lowcore.h
index ec6592e..c63986a 100644
--- a/arch/s390/include/asm/lowcore.h
+++ b/arch/s390/include/asm/lowcore.h
@@ -151,7 +151,8 @@ struct lowcore {
 	__u8	pad_0x0e20[0x0f00-0x0e20];	/* 0x0e20 */
 
 	/* Extended facility list */
-	__u64	stfle_fac_list[32];		/* 0x0f00 */
+	__u64	stfle_fac_list[16];		/* 0x0f00 */
+	__u64	alt_stfle_fac_list[16];		/* 0x0f80 */
 	__u8	pad_0x1000[0x11b0-0x1000];	/* 0x1000 */
 
 	/* Pointer to the machine check extended save area */
diff --git a/arch/s390/kernel/alternative.c b/arch/s390/kernel/alternative.c
index 574e776..1abf4f3 100644
--- a/arch/s390/kernel/alternative.c
+++ b/arch/s390/kernel/alternative.c
@@ -75,7 +75,8 @@ static void __init_or_module __apply_alternatives(struct alt_instr *start,
 		instr = (u8 *)&a->instr_offset + a->instr_offset;
 		replacement = (u8 *)&a->repl_offset + a->repl_offset;
 
-		if (!test_facility(a->facility))
+		if (!__test_facility(a->facility,
+				     S390_lowcore.alt_stfle_fac_list))
 			continue;
 
 		if (unlikely(a->instrlen % 2 || a->replacementlen % 2)) {
diff --git a/arch/s390/kernel/early.c b/arch/s390/kernel/early.c
index 497a920..510f218 100644
--- a/arch/s390/kernel/early.c
+++ b/arch/s390/kernel/early.c
@@ -193,6 +193,9 @@ static noinline __init void setup_facility_list(void)
 {
 	stfle(S390_lowcore.stfle_fac_list,
 	      ARRAY_SIZE(S390_lowcore.stfle_fac_list));
+	memcpy(S390_lowcore.alt_stfle_fac_list,
+	       S390_lowcore.stfle_fac_list,
+	       sizeof(S390_lowcore.alt_stfle_fac_list));
 }
 
 static __init void detect_diag9c(void)
diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
index 793da97..bcd2a4a 100644
--- a/arch/s390/kernel/setup.c
+++ b/arch/s390/kernel/setup.c
@@ -340,7 +340,9 @@ static void __init setup_lowcore(void)
 	lc->preempt_count = S390_lowcore.preempt_count;
 	lc->stfl_fac_list = S390_lowcore.stfl_fac_list;
 	memcpy(lc->stfle_fac_list, S390_lowcore.stfle_fac_list,
-	       MAX_FACILITY_BIT/8);
+	       sizeof(lc->stfle_fac_list));
+	memcpy(lc->alt_stfle_fac_list, S390_lowcore.alt_stfle_fac_list,
+	       sizeof(lc->alt_stfle_fac_list));
 	nmi_alloc_boot_cpu(lc);
 	vdso_alloc_boot_cpu(lc);
 	lc->sync_enter_timer = S390_lowcore.sync_enter_timer;
diff --git a/arch/s390/kernel/smp.c b/arch/s390/kernel/smp.c
index b8c1a85..4ce68ca 100644
--- a/arch/s390/kernel/smp.c
+++ b/arch/s390/kernel/smp.c
@@ -266,7 +266,9 @@ static void pcpu_prepare_secondary(struct pcpu *pcpu, int cpu)
 	__ctl_store(lc->cregs_save_area, 0, 15);
 	save_access_regs((unsigned int *) lc->access_regs_save_area);
 	memcpy(lc->stfle_fac_list, S390_lowcore.stfle_fac_list,
-	       MAX_FACILITY_BIT/8);
+	       sizeof(lc->stfle_fac_list));
+	memcpy(lc->alt_stfle_fac_list, S390_lowcore.alt_stfle_fac_list,
+	       sizeof(lc->alt_stfle_fac_list));
 	arch_spin_lock_setup(cpu);
 }
 
-- 
2.7.4
