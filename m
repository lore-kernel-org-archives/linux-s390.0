From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 28 Jun 2017 10:41:06 +0000
Subject: [GIT PULL 2/2] KVM: s390: Backup the guest's machine check info
Message-Id: <1498646466-117843-3-git-send-email-borntraeger@de.ibm.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: QingFeng Hao <haoqf@linux.vnet.ibm.com>

When a machine check happens in the guest, related mcck info (mcic,
external damage code, ...) is stored in the vcpu's lowcore on the host.
Then the machine check handler's low-level part is executed, followed
by the high-level part.

If the high-level part's execution is interrupted by a new machine check
happening on the same vcpu on the host, the mcck info in the lowcore is
overwritten with the new machine check's data.

If the high-level part's execution is scheduled to a different cpu,
the mcck info in the lowcore is uncertain.

Therefore, for both cases, the further reinjection to the guest will use
the wrong data.
Let's backup the mcck info in the lowcore to the sie page
for further reinjection, so that the right data will be used.

Add new member into struct sie_page to store related machine check's
info of mcic, failing storage address and external damage code.

Signed-off-by: QingFeng Hao <haoqf@linux.vnet.ibm.com>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/kvm_host.h | 17 ++++++++++++++++-
 arch/s390/kernel/nmi.c           | 34 ++++++++++++++++++++++++++++++++++
 arch/s390/kvm/kvm-s390.c         |  1 +
 3 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 426614a..c6e1d5f 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -107,6 +107,20 @@ struct esca_block {
 	struct esca_entry cpu[KVM_S390_ESCA_CPU_SLOTS];
 } __packed;
 
+/*
+ * This struct is used to store some machine check info from lowcore
+ * for machine checks that happen while the guest is running.
+ * This info in host's lowcore might be overwritten by a second machine
+ * check from host when host is in the machine check's high-level handling.
+ * The size is 24 bytes.
+ */
+struct mcck_volatile_info {
+	__u64 mcic;
+	__u64 failing_storage_address;
+	__u32 ext_damage_code;
+	__u32 reserved;
+};
+
 #define CPUSTAT_STOPPED    0x80000000
 #define CPUSTAT_WAIT       0x10000000
 #define CPUSTAT_ECALL_PEND 0x08000000
@@ -264,7 +278,8 @@ struct kvm_s390_itdb {
 
 struct sie_page {
 	struct kvm_s390_sie_block sie_block;
-	__u8 reserved200[1024];		/* 0x0200 */
+	struct mcck_volatile_info mcck_info;	/* 0x0200 */
+	__u8 reserved218[1000];		/* 0x0218 */
 	struct kvm_s390_itdb itdb;	/* 0x0600 */
 	__u8 reserved700[2304];		/* 0x0700 */
 } __packed;
diff --git a/arch/s390/kernel/nmi.c b/arch/s390/kernel/nmi.c
index 958cc33..31d03a8 100644
--- a/arch/s390/kernel/nmi.c
+++ b/arch/s390/kernel/nmi.c
@@ -26,6 +26,7 @@
 #include <asm/switch_to.h>
 #include <asm/ctl_reg.h>
 #include <asm/asm-offsets.h>
+#include <linux/kvm_host.h>
 
 struct mcck_struct {
 	unsigned int kill_task : 1;
@@ -275,6 +276,31 @@ static int notrace s390_validate_registers(union mci mci, int umode)
 	return kill_task;
 }
 
+/*
+ * Backup the guest's machine check info to its description block
+ */
+static void notrace s390_backup_mcck_info(struct pt_regs *regs)
+{
+	struct mcck_volatile_info *mcck_backup;
+	struct sie_page *sie_page;
+
+	/* r14 contains the sie block, which was set in sie64a */
+	struct kvm_s390_sie_block *sie_block =
+			(struct kvm_s390_sie_block *) regs->gprs[14];
+
+	if (sie_block == NULL)
+		/* Something's seriously wrong, stop system. */
+		s390_handle_damage();
+
+	sie_page = container_of(sie_block, struct sie_page, sie_block);
+	mcck_backup = &sie_page->mcck_info;
+	mcck_backup->mcic = S390_lowcore.mcck_interruption_code &
+				~(MCCK_CODE_CP | MCCK_CODE_EXT_DAMAGE);
+	mcck_backup->ext_damage_code = S390_lowcore.external_damage_code;
+	mcck_backup->failing_storage_address
+			= S390_lowcore.failing_storage_address;
+}
+
 #define MAX_IPD_COUNT	29
 #define MAX_IPD_TIME	(5 * 60 * USEC_PER_SEC) /* 5 minutes */
 
@@ -355,6 +381,14 @@ void notrace s390_do_machine_check(struct pt_regs *regs)
 		mcck->mcck_code = mci.val;
 		set_cpu_flag(CIF_MCCK_PENDING);
 	}
+
+	/*
+	 * Backup the machine check's info if it happens when the guest
+	 * is running.
+	 */
+	if (test_cpu_flag(CIF_MCCK_GUEST))
+		s390_backup_mcck_info(regs);
+
 	if (mci.cd) {
 		/* Timing facility damage */
 		s390_handle_damage();
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 689ac48..0457e03 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -2069,6 +2069,7 @@ struct kvm_vcpu *kvm_arch_vcpu_create(struct kvm *kvm,
 	if (!vcpu)
 		goto out;
 
+	BUILD_BUG_ON(sizeof(struct sie_page) != 4096);
 	sie_page = (struct sie_page *) get_zeroed_page(GFP_KERNEL);
 	if (!sie_page)
 		goto out_free_cpu;
-- 
2.7.4
