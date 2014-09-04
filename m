From: frank.blaschka@de.ibm.com
Subject: [RFC][patch 4/6] KVM: s390: Add PCI pass-through support
Date: Thu, 04 Sep 2014 12:52:27 +0200
Message-ID: <20140904105337.202077766@de.ibm.com>
References: <20140904105223.336503578@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline; filename=005-s390_kvm_ppt-3.16.patch
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: qemu-devel@nongnu.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org
Cc: aik@ozlabs.ru, pbonzini@redhat.com, agraf@suse.de
List-ID: <linux-s390.vger.kernel.org>

From: Frank Blaschka <frank.blaschka@de.ibm.com>

This patch implemets PCI pass-through kernel support for s390.
Design approach is very similar to the x86 device assignment.
User space executes the KVM_ASSIGN_PCI_DEVICE ioctl to create
a proxy instance in the kernel KVM and connect this instance to the
host pci device. s390 pci instructions are intercepted in kernel and
operations are passed directly to the assigned pci device.
To take advantage of all system z specific virtualization features
we need to access the SIE control block residing in KVM. Also we have to
enable z pci devices with special configuration information coming
form the SIE block as well.

Signed-off-by: Frank Blaschka <frank.blaschka@de.ibm.com>
---
 arch/s390/include/asm/kvm_host.h |    1 
 arch/s390/kvm/Makefile           |    2 
 arch/s390/kvm/intercept.c        |    1 
 arch/s390/kvm/kvm-s390.c         |   33 
 arch/s390/kvm/kvm-s390.h         |   17 
 arch/s390/kvm/pci.c              | 2130 +++++++++++++++++++++++++++++++++++++++
 arch/s390/kvm/priv.c             |   21 
 7 files changed, 2202 insertions(+), 3 deletions(-)

--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -488,6 +488,7 @@ struct kvm_arch{
 	union kvm_s390_gisa *gisa;
 	unsigned long iam;
 	atomic_t in_sie;
+	struct list_head ppt_dev_list;
 };
 
 #define KVM_HVA_ERR_BAD		(-1UL)
--- a/arch/s390/kvm/Makefile
+++ b/arch/s390/kvm/Makefile
@@ -12,6 +12,6 @@ common-objs = $(KVM)/kvm_main.o $(KVM)/e
 ccflags-y := -Ivirt/kvm -Iarch/s390/kvm
 
 kvm-objs := $(common-objs) kvm-s390.o intercept.o interrupt.o priv.o sigp.o
-kvm-objs += diag.o gaccess.o guestdbg.o
+kvm-objs += diag.o gaccess.o guestdbg.o pci.o
 
 obj-$(CONFIG_KVM) += kvm.o
--- a/arch/s390/kvm/intercept.c
+++ b/arch/s390/kvm/intercept.c
@@ -34,6 +34,7 @@ static const intercept_handler_t instruc
 	[0xb6] = kvm_s390_handle_stctl,
 	[0xb7] = kvm_s390_handle_lctl,
 	[0xb9] = kvm_s390_handle_b9,
+	[0xe3] = kvm_s390_handle_e3,
 	[0xe5] = kvm_s390_handle_e5,
 	[0xeb] = kvm_s390_handle_eb,
 };
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -397,6 +397,24 @@ long kvm_arch_vm_ioctl(struct file *filp
 		r = kvm_s390_vm_has_attr(kvm, &attr);
 		break;
 	}
+	case KVM_ASSIGN_PCI_DEVICE: {
+		struct kvm_assigned_pci_dev assigned_dev;
+
+		r = -EFAULT;
+		if (copy_from_user(&assigned_dev, argp, sizeof(assigned_dev)))
+			break;
+		r = kvm_s390_ioctrl_assign_pci(kvm, &assigned_dev);
+		break;
+	}
+	case KVM_DEASSIGN_PCI_DEVICE: {
+		struct kvm_assigned_pci_dev assigned_dev;
+
+		r = -EFAULT;
+		if (copy_from_user(&assigned_dev, argp, sizeof(assigned_dev)))
+			break;
+		r = kvm_s390_ioctrl_deassign_pci(kvm, &assigned_dev);
+		break;
+	}
 	default:
 		r = -ENOTTY;
 	}
@@ -478,6 +496,7 @@ int kvm_arch_init_vm(struct kvm *kvm, un
 	kvm_s390_gisa_set_next_alert(kvm, (u32)(unsigned long)kvm->arch.gisa);
 	kvm_s390_gisa_set_alert_mask(kvm, 0);
 	atomic_set(&kvm->arch.in_sie, 0);
+	INIT_LIST_HEAD(&kvm->arch.ppt_dev_list);
 
 	spin_lock_init(&kvm->arch.start_stop_lock);
 
@@ -538,6 +557,7 @@ void kvm_arch_sync_events(struct kvm *kv
 
 void kvm_arch_destroy_vm(struct kvm *kvm)
 {
+	s390_pci_cleanup(kvm);
 	free_page((unsigned long)kvm->arch.gisa);
 	kvm_free_vcpus(kvm);
 	free_page((unsigned long)(kvm->arch.sca));
@@ -656,7 +676,10 @@ int kvm_arch_vcpu_setup(struct kvm_vcpu
 		vcpu->arch.sie_block->ecb |= 0x10;
 
 	vcpu->arch.sie_block->ecb2  = 8;
-	vcpu->arch.sie_block->eca   = 0xD1002000U;
+	vcpu->arch.sie_block->eca   = 0xD1202000U;
+	vcpu->arch.sie_block->ecb2 |= 0x02;
+	vcpu->arch.sie_block->ecb3 = 0x20;
+
 	if (sclp_has_siif())
 		vcpu->arch.sie_block->eca |= 1;
 	vcpu->arch.sie_block->fac   = (int) (long) vfacilities;
@@ -1920,6 +1943,12 @@ static int __init kvm_s390_init(void)
 	if (ret)
 		return ret;
 
+	ret = s390_pci_init();
+	if (ret) {
+		kvm_exit();
+		return ret;
+	}
+
 	/*
 	 * guests can ask for up to 255+1 double words, we need a full page
 	 * to hold the maximum amount of facilities. On the other hand, we
@@ -1932,7 +1961,7 @@ static int __init kvm_s390_init(void)
 	}
 	memcpy(vfacilities, S390_lowcore.stfle_fac_list, 16);
 	vfacilities[0] &= 0xff82fff3f4fc2000UL;
-	vfacilities[1] &= 0x005c000000000000UL;
+	vfacilities[1] &= 0x07dc000000000000UL;
 	return 0;
 }
 
--- a/arch/s390/kvm/kvm-s390.h
+++ b/arch/s390/kvm/kvm-s390.h
@@ -167,6 +167,7 @@ int kvm_s390_mask_adapter(struct kvm *kv
 /* implemented in priv.c */
 int is_valid_psw(psw_t *psw);
 int kvm_s390_handle_b2(struct kvm_vcpu *vcpu);
+int kvm_s390_handle_e3(struct kvm_vcpu *vcpu);
 int kvm_s390_handle_e5(struct kvm_vcpu *vcpu);
 int kvm_s390_handle_01(struct kvm_vcpu *vcpu);
 int kvm_s390_handle_b9(struct kvm_vcpu *vcpu);
@@ -267,4 +268,20 @@ void kvm_s390_clear_bp_data(struct kvm_v
 void kvm_s390_prepare_debug_exit(struct kvm_vcpu *vcpu);
 void kvm_s390_handle_per_event(struct kvm_vcpu *vcpu);
 
+/* implemented in pci.c */
+int handle_clp(struct kvm_vcpu *vcpu);
+int handle_rpcit(struct kvm_vcpu *vcpu);
+int handle_sic(struct kvm_vcpu *vcpu);
+int handle_pcistb(struct kvm_vcpu *vcpu);
+int handle_mpcifc(struct kvm_vcpu *vcpu);
+int handle_pcistg(struct kvm_vcpu *vcpu);
+int handle_pcilg(struct kvm_vcpu *vcpu);
+int handle_stpcifc(struct kvm_vcpu *vcpu);
+int kvm_s390_ioctrl_assign_pci(struct kvm *kvm,
+	struct kvm_assigned_pci_dev *assigned_dev);
+int kvm_s390_ioctrl_deassign_pci(struct kvm *kvm,
+	struct kvm_assigned_pci_dev *assigned_dev);
+void s390_pci_cleanup(struct kvm *kvm);
+int s390_pci_init(void);
+void s390_pci_exit(void);
 #endif
--- /dev/null
+++ b/arch/s390/kvm/pci.c
@@ -0,0 +1,2130 @@
+/*
+ * handling pci related instructions
+ *
+ * Copyright IBM Corp. 2014
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License (version 2 only)
+ * as published by the Free Software Foundation.
+ *
+ *    Author(s): Frank Blaschka <frank.blaschka@de.ibm.com>
+ *               Hong Bo Li <lihbbj@cn.ibm.com>
+ *               Yi Min Zhao <zyimin@cn.ibm.com>
+ */
+
+#define KMSG_COMPONENT "kvmpci"
+#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
+
+#include <linux/kvm.h>
+#include <linux/gfp.h>
+#include <linux/errno.h>
+#include <linux/compat.h>
+#include <linux/pci.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/mmu_context.h>
+#include <linux/delay.h>
+#include <linux/seq_file.h>
+#include <linux/debugfs.h>
+#include <asm/asm-offsets.h>
+#include <asm/current.h>
+#include <asm/debug.h>
+#include <asm/ebcdic.h>
+#include <asm/sysinfo.h>
+#include <asm/pgtable.h>
+#include <asm/io.h>
+#include <asm/ptrace.h>
+#include <asm/compat.h>
+#include <asm/facility.h>
+#include <asm/cio.h>
+#include <asm/clp.h>
+#include <asm/pci_clp.h>
+#include <asm/pci_dma.h>
+#include <asm/pci_insn.h>
+#include <asm/isc.h>
+#include <asm/airq.h>
+#include <asm/cio.h>
+#include "gaccess.h"
+#include "kvm-s390.h"
+#include "trace.h"
+
+#define USER_LSPCI
+
+#define FH_ENABLED (1UL << 31)
+#define FH_VIRT 0x00ff0000
+#define PCIPT_ISC 5
+#define IO_INT_WORD_AI 0x80000000
+#define DBF_NAME_LEN 20
+#define ASSIGN_FLAG_HOSTIRQ 0x1
+
+#define PPT_AIRQ_HOST_ERROR   0x2
+#define PPT_AIRQ_HOST_FORWARD 0x1
+
+#define PPT_TRACE_NORMAL 2
+#define PPT_TRACE_DEBUG 3
+
+#define PPT_MESSAGE(level, text...) \
+	debug_sprintf_event(dmsgf, level, text)
+#define PPT_DEVICE_MESSAGE(card, level, text...) \
+	debug_sprintf_event(card->debug, level, text)
+
+static const unsigned long be_to_le = BITS_PER_LONG - 1;
+
+enum ppt_vm_stats {
+	PPT_VM_STAT_ALERT_IRQ,
+	PPT_VM_STAT_ALERT_H,
+	PPT_VM_STAT_GISA,
+	PPT_VM_STATS,
+};
+
+static char *ppt_vm_stats_names[PPT_VM_STATS] = {
+	"alert irq",
+	"alert irq H",
+	"gisa irq",
+};
+
+struct ppt_vm_entry {
+	struct list_head entry;
+	atomic_t refcnt;
+	struct kvm *kvm;
+	struct work_struct irq_work;
+	unsigned int stat_items[PPT_VM_STATS];
+};
+
+struct ppt_dbf_entry {
+	char dbf_name[DBF_NAME_LEN];
+	debug_info_t *dbf_info;
+	struct list_head dbf_list;
+};
+
+enum ppt_dev_stats {
+	PPT_DEV_STAT_HOST_IRQ_INJECT,
+	PPT_DEV_STAT_HOST_IRQ_GISA,
+	PPT_DEV_STAT_PCISTG,
+	PPT_DEV_STAT_PCISTB,
+	PPT_DEV_STAT_PCILG,
+	PPT_DEV_STAT_MPCIFC,
+	PPT_DEV_STAT_RPCIT,
+	PPT_DEV_STATS,
+};
+
+static char *ppt_dev_stats_names[PPT_DEV_STATS] = {
+	"host irqs inject",
+	"host irqs gisa",
+	"pcistg",
+	"pcistb",
+	"pcilg",
+	"mpcifc",
+	"rpcit",
+};
+
+struct ppt_dev {
+	struct list_head entry;
+	int enabled;
+	int configured;
+	atomic_t refcnt;
+	struct kvm *kvm;
+	struct ppt_vm_entry *ppt_vm;
+	struct zpci_dev *zdev;
+	struct pci_dev *pdev;
+	u32 dev_id;
+	int irq_on;
+	u32 hostirq;
+	struct msix_entry *entries;
+	unsigned int faisb;
+	unsigned long *aibv;
+	u32 aibvo;
+	unsigned long *aisb;
+	u32 aisbo;
+	u8 sum;
+	u16 noi;
+	u64 g_iota;
+	u64 g_fmba;
+	struct dentry *debugfs_stats;
+	unsigned int stat_items[PPT_DEV_STATS];
+	struct zpci_fmb *fmb;
+	debug_info_t *debug;
+};
+
+static void ppt_irq_worker(struct work_struct *);
+static void ppt_dereg_irqs(struct ppt_dev *, u8 *, u8 *);
+static void ppt_alert_irq_handler(struct airq_struct *);
+static u8 ppt_refresh_trans(u64 fn, u64 addr, u64 range, u8 *status);
+
+static struct airq_struct ppt_airq = {
+	.handler = ppt_alert_irq_handler,
+	.isc = PCIPT_ISC,
+};
+
+static struct kvm_s390_gait *gait;
+static struct airq_iv *faisb_iv;
+static struct kvm_s390_gib *gib;
+static debug_info_t *dmsgf;
+static struct dentry *ppt_stats_debugfs_root;
+
+static LIST_HEAD(ppt_vm_list);
+static DEFINE_SPINLOCK(ppt_vm_list_lock);
+static LIST_HEAD(ppt_dbf_list);
+static DEFINE_MUTEX(ppt_dbf_list_mutex);
+
+static int ppt_dev_stats_show(struct seq_file *sf, void *v)
+{
+	struct ppt_dev *ppt_dev = sf->private;
+	int i = 0;
+
+	if (!ppt_dev)
+		return 0;
+
+	seq_printf(sf, "PPT Device ID : 0x%x\n", ppt_dev->zdev->fid);
+	seq_puts(sf, "PPT Device Statistics Information:\n");
+
+	for (i = 0; i < PPT_DEV_STATS; ++i) {
+		seq_printf(sf, "%24s\t : %d\n",
+			ppt_dev_stats_names[i], ppt_dev->stat_items[i]);
+	}
+
+	seq_puts(sf, "\nPPT VM Statistics Information:\n");
+	for (i = 0; i < PPT_VM_STATS; ++i) {
+		seq_printf(sf, "%24s\t : %d\n", ppt_vm_stats_names[i],
+			i == PPT_VM_STAT_GISA ?
+			kvm_s390_gisa_get_count(ppt_dev->ppt_vm->kvm) :
+			ppt_dev->ppt_vm->stat_items[i]);
+	}
+
+	return 0;
+}
+
+static int ppt_dev_stats_seq_open(struct inode *inode, struct file *filp)
+{
+	return single_open(filp, ppt_dev_stats_show,
+		file_inode(filp)->i_private);
+}
+
+static const struct file_operations ppt_debugfs_stats_fops = {
+	.open = ppt_dev_stats_seq_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = single_release,
+};
+
+static void ppt_dev_debugfs_stats_init(struct ppt_dev *ppt_dev)
+{
+	char file_name[20];
+
+	if (!ppt_dev)
+		return;
+
+	sprintf(file_name, "ppt_dev_%x", ppt_dev->zdev->fid);
+	ppt_dev->debugfs_stats = debugfs_create_file(file_name,
+		S_IFREG | S_IRUGO,
+		ppt_stats_debugfs_root,
+		ppt_dev,
+		&ppt_debugfs_stats_fops);
+	memset(ppt_dev->stat_items, 0, sizeof(unsigned int) * PPT_DEV_STATS);
+
+	if (IS_ERR(ppt_dev->debugfs_stats))
+		ppt_dev->debugfs_stats = NULL;
+}
+
+static debug_info_t *ppt_get_dbf_entry(char *name)
+{
+	struct ppt_dbf_entry *entry;
+	debug_info_t *rc = NULL;
+
+	mutex_lock(&ppt_dbf_list_mutex);
+	list_for_each_entry(entry, &ppt_dbf_list, dbf_list) {
+		if (strcmp(entry->dbf_name, name) == 0) {
+			rc = entry->dbf_info;
+			break;
+		}
+	}
+	mutex_unlock(&ppt_dbf_list_mutex);
+	return rc;
+}
+
+static int ppt_add_dbf_entry(struct ppt_dev *card, char *name)
+{
+	struct ppt_dbf_entry *new_entry;
+
+	card->debug = debug_register(name, 8, 1, 128);
+	if (!card->debug) {
+		PPT_MESSAGE(PPT_TRACE_NORMAL,
+			"Cannot register ppt device debug");
+		goto err;
+	}
+	if (debug_register_view(card->debug, &debug_sprintf_view))
+		goto err_dbg;
+	debug_set_level(card->debug, PPT_TRACE_NORMAL);
+	new_entry = kzalloc(sizeof(struct ppt_dbf_entry), GFP_KERNEL);
+	if (!new_entry)
+		goto err_dbg;
+	strncpy(new_entry->dbf_name, name, DBF_NAME_LEN);
+	new_entry->dbf_info = card->debug;
+	mutex_lock(&ppt_dbf_list_mutex);
+	list_add(&new_entry->dbf_list, &ppt_dbf_list);
+	mutex_unlock(&ppt_dbf_list_mutex);
+
+	return 0;
+
+err_dbg:
+	debug_unregister(card->debug);
+err:
+	return -ENOMEM;
+}
+
+static void ppt_clear_dbf_list(void)
+{
+	struct ppt_dbf_entry *entry, *tmp;
+
+	mutex_lock(&ppt_dbf_list_mutex);
+	list_for_each_entry_safe(entry, tmp, &ppt_dbf_list, dbf_list) {
+		list_del(&entry->dbf_list);
+		debug_unregister(entry->dbf_info);
+		kfree(entry);
+	}
+	mutex_unlock(&ppt_dbf_list_mutex);
+}
+
+static void ppt_unregister_dbf_views(void)
+{
+	debug_unregister(dmsgf);
+}
+
+static int ppt_register_dbf_views(void)
+{
+	int rc;
+
+	dmsgf = debug_register("ppt_msg", 8, 1, 128);
+
+	if (!dmsgf)
+		return -ENOMEM;
+
+	rc = debug_register_view(dmsgf, &debug_sprintf_view);
+	if (rc) {
+		debug_unregister(dmsgf);
+		return rc;
+	}
+
+	debug_set_level(dmsgf, PPT_TRACE_NORMAL);
+	return 0;
+}
+
+static struct ppt_vm_entry *ppt_register_vm(struct kvm *kvm)
+{
+	unsigned long flags;
+	struct ppt_vm_entry *tmp, *tmp2, *match = NULL;
+
+	tmp2 = kzalloc(sizeof(struct ppt_vm_entry), GFP_KERNEL);
+	if (!tmp2)
+		return ERR_PTR(-ENOMEM);
+
+	atomic_set(&tmp2->refcnt, 0);
+
+	spin_lock_irqsave(&ppt_vm_list_lock, flags);
+	list_for_each_entry(tmp, &ppt_vm_list, entry) {
+		if (tmp->kvm == kvm) {
+			match = tmp;
+			break;
+		}
+	}
+
+	if (match) {
+		kfree(tmp2);
+	} else {
+		match = tmp2;
+		match->kvm = kvm;
+		kvm_s390_gisa_register_alert(kvm, PCI_ISC);
+		INIT_WORK(&match->irq_work, ppt_irq_worker);
+		list_add(&match->entry, &ppt_vm_list);
+		PPT_MESSAGE(PPT_TRACE_NORMAL,
+			"register kvm 0x%lx\n", (unsigned long)kvm);
+	}
+
+	atomic_inc(&match->refcnt);
+	spin_unlock_irqrestore(&ppt_vm_list_lock, flags);
+	return match;
+}
+
+static int ppt_unregister_vm(struct ppt_vm_entry *ppt_vm)
+{
+	unsigned long flags;
+	struct ppt_vm_entry *tmp, *match = NULL;
+	int rc = 0;
+
+	spin_lock_irqsave(&ppt_vm_list_lock, flags);
+	list_for_each_entry(tmp, &ppt_vm_list, entry) {
+		if (tmp == ppt_vm) {
+			match = tmp;
+			break;
+		}
+	}
+
+	if (match) {
+		if (atomic_dec_and_test(&match->refcnt)) {
+			PPT_MESSAGE(PPT_TRACE_NORMAL,
+				"unregister kvm 0x%lx\n",
+				(unsigned long)match->kvm);
+			kvm_s390_gisa_unregister_alert(match->kvm, PCI_ISC);
+			list_del(&match->entry);
+			kfree(match);
+		}
+	} else {
+		rc = -ENODEV;
+	}
+
+	spin_unlock_irqrestore(&ppt_vm_list_lock, flags);
+	return rc;
+}
+
+static int ppt_dma_update_trans(struct zpci_dev *zdev, unsigned long pa,
+				dma_addr_t dma_addr, size_t size, int flags,
+				u8 *cc, u8 *status)
+{
+	unsigned int nr_pages = PAGE_ALIGN(size) >> PAGE_SHIFT;
+	u8 *page_addr = (u8 *) (pa & PAGE_MASK);
+	dma_addr_t start_dma_addr = dma_addr;
+	unsigned long irq_flags;
+	int i, rc = 0;
+
+	if (!nr_pages)
+		return -EINVAL;
+
+	spin_lock_irqsave(&zdev->dma_table_lock, irq_flags);
+	if (!zdev->dma_table) {
+		dev_err(&zdev->pdev->dev, "Missing DMA table\n");
+		goto no_refresh;
+	}
+
+	for (i = 0; i < nr_pages; i++) {
+		dma_update_cpu_trans(zdev, page_addr, dma_addr, flags);
+		page_addr += PAGE_SIZE;
+		dma_addr += PAGE_SIZE;
+	}
+
+	/*
+	 * rpcit is not required to establish new translations when previously
+	 * invalid translation-table entries are validated, however it is
+	 * required when altering previously valid entries.
+	 */
+	if (!zdev->tlb_refresh &&
+	    ((flags & ZPCI_PTE_VALID_MASK) == ZPCI_PTE_VALID))
+		/*
+		 * TODO: also need to check that the old entry is indeed INVALID
+		 * and not only for one page but for the whole range...
+		 * -> now we WARN_ON in that case but with lazy unmap that
+		 * needs to be redone!
+		 */
+		goto no_refresh;
+
+	*cc = ppt_refresh_trans((u64) zdev->fh << 32, start_dma_addr,
+				nr_pages * PAGE_SIZE, status);
+	rc = (*cc) ? -EIO : 0;
+no_refresh:
+	spin_unlock_irqrestore(&zdev->dma_table_lock, irq_flags);
+	return rc;
+}
+
+static int ppt_update_trans_entry(struct ppt_dev *ppt_dev, u64 dma_addr,
+				  struct page *page, int flags, u8 *cc,
+				  u8 *status)
+{
+	int rc;
+	u64 paddr = page_to_phys(page);
+
+	rc = ppt_dma_update_trans(ppt_dev->zdev, paddr, dma_addr, PAGE_SIZE,
+				  flags, cc, status);
+	if (flags & ZPCI_PTE_INVALID)
+		put_page(page);
+	else
+		get_page(page);
+
+	if (rc)
+		PPT_DEVICE_MESSAGE(ppt_dev, PPT_TRACE_NORMAL,
+			"dma_up rc %d paddr 0x%llx addr 0x%llx flags 0x%x\n",
+			rc, paddr, dma_addr, flags);
+
+	return rc;
+}
+
+static struct ppt_dev *ppt_alloc_dev(void)
+{
+	struct ppt_dev *dev;
+
+	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
+	if (!dev)
+		return ERR_PTR(-ENOMEM);
+
+	atomic_set(&dev->refcnt, 1);
+	dev->enabled = 0;
+	dev->configured = 1;
+	return dev;
+}
+
+static void ppt_put_dev(struct ppt_dev *ppt_dev)
+{
+	int rc;
+	u8 cc, status;
+
+	WARN_ON(atomic_read(&ppt_dev->refcnt) <= 0);
+	if (atomic_dec_and_test(&ppt_dev->refcnt)) {
+		if (ppt_dev->irq_on)
+			ppt_dereg_irqs(ppt_dev, &cc, &status);
+
+		if (ppt_dev->fmb)
+			put_page(virt_to_page(ppt_dev->fmb));
+
+		if (ppt_dev->enabled) {
+			ppt_dev->enabled = 0;
+			pci_release_regions(ppt_dev->pdev);
+			pci_disable_device(ppt_dev->pdev);
+			/* disable/enable zpci layer so all dma translations
+			 * are cleared in hw and host table
+			 */
+			rc = zpci_disable_device(ppt_dev->zdev);
+			if (rc)
+				PPT_DEVICE_MESSAGE(ppt_dev, PPT_TRACE_NORMAL,
+					"disable device failed rc %d\n", rc);
+
+		}
+
+		rc = ppt_unregister_vm(ppt_dev->ppt_vm);
+		if (rc)
+			PPT_DEVICE_MESSAGE(ppt_dev, PPT_TRACE_NORMAL,
+				"unregister vm failed rc %d\n", rc);
+
+		rc = zpci_enable_device(ppt_dev->zdev);
+		if (rc)
+			PPT_DEVICE_MESSAGE(ppt_dev, PPT_TRACE_NORMAL,
+				"enable device failed rc %d\n", rc);
+
+		pci_dev_put(ppt_dev->pdev);
+
+		debugfs_remove(ppt_dev->debugfs_stats);
+
+		PPT_DEVICE_MESSAGE(ppt_dev,
+			PPT_TRACE_NORMAL, "free dev\n");
+		PPT_DEVICE_MESSAGE(ppt_dev, PPT_TRACE_NORMAL,
+			"free fh 0x%x\n", ppt_dev->zdev->fh);
+		kfree(ppt_dev);
+	}
+}
+
+static struct ppt_dev *ppt_get_by_devid(struct kvm *kvm, u32 dev_id)
+{
+	struct ppt_dev *tmp, *dev = NULL;
+
+	mutex_lock(&kvm->lock);
+	list_for_each_entry(tmp, &kvm->arch.ppt_dev_list, entry) {
+		if (tmp->dev_id == dev_id) {
+			dev = tmp;
+			WARN_ON(atomic_read(&dev->refcnt) <= 0);
+			atomic_inc(&dev->refcnt);
+			break;
+		}
+	}
+	mutex_unlock(&kvm->lock);
+	return dev;
+}
+
+static struct ppt_dev *ppt_get_by_fh(struct kvm *kvm, u32 fh)
+{
+	struct ppt_dev *tmp, *dev = NULL;
+
+	mutex_lock(&kvm->lock);
+	list_for_each_entry(tmp, &kvm->arch.ppt_dev_list, entry) {
+		if ((tmp->zdev->fh & ~FH_ENABLED) == (fh & ~FH_ENABLED)) {
+			dev = tmp;
+			WARN_ON(atomic_read(&dev->refcnt) <= 0);
+			atomic_inc(&dev->refcnt);
+			break;
+		}
+	}
+	mutex_unlock(&kvm->lock);
+	return dev;
+}
+
+static int ppt_clp_list_pci(struct kvm_vcpu *vcpu,
+			    struct clp_req_rsp_list_pci *rrb, u8 *cc)
+{
+	struct ppt_dev *ppt_dev;
+	struct clp_req_rsp_list_pci *tmprrb;
+	int initial_l2, g_l2, tmp_en, g_en, i, rc;
+
+	tmprrb = (struct clp_req_rsp_list_pci *)get_zeroed_page(GFP_KERNEL);
+	if (!tmprrb)
+		return -ENOMEM;
+	initial_l2 = rrb->response.hdr.len;
+	if ((initial_l2 - LIST_PCI_HDR_LEN) % sizeof(struct clp_fh_list_entry)
+		!= 0)
+		return -EINVAL;
+
+	memcpy(tmprrb, rrb, sizeof(struct clp_req_rsp_list_pci));
+	g_l2 = g_en = rc = 0;
+	do {
+		*cc = clp_instr(tmprrb);
+		if (*cc) {
+			rc = -EIO;
+			break;
+		}
+		if (tmprrb->response.hdr.rsp != CLP_RC_OK) {
+			rc = -EIO;
+			break;
+		}
+
+		tmp_en = (tmprrb->response.hdr.len - LIST_PCI_HDR_LEN) /
+			tmprrb->response.entry_size;
+		for (i = 0; i < tmp_en; i++) {
+			ppt_dev = ppt_get_by_fh(vcpu->kvm,
+				tmprrb->response.fh_list[i].fh);
+			if (ppt_dev) {
+				memcpy(&(rrb->response.fh_list[g_en]),
+				       &(tmprrb->response.fh_list[i]),
+				       tmprrb->response.entry_size);
+				g_en++;
+				ppt_put_dev(ppt_dev);
+			}
+		}
+		g_l2 = LIST_PCI_HDR_LEN + g_en * tmprrb->response.entry_size;
+		if (tmprrb->response.resume_token == 0)
+			break;
+		tmprrb->request.resume_token = tmprrb->response.resume_token;
+		tmprrb->response.hdr.len = LIST_PCI_HDR_LEN +
+			(initial_l2 - g_l2);
+	} while (g_l2 < initial_l2);
+
+	memcpy(&rrb->response, &tmprrb->response, LIST_PCI_HDR_LEN);
+	if (!rc)
+		rrb->response.hdr.len = g_l2;
+	free_page((unsigned long)tmprrb);
+	return rc;
+}
+
+static u8 ppt_clp_instr(struct clp_req_rsp_set_pci *rrb)
+{
+	u8 cc;
+	int l2, retries;
+
+	retries = 100;
+	l2 = rrb->response.hdr.len;
+	do {
+		rrb->response.hdr.len = l2;
+		cc = clp_instr(rrb);
+		if (rrb->response.hdr.rsp == CLP_RC_SETPCIFN_BUSY) {
+			retries--;
+			if (retries < 0)
+				break;
+			msleep(20);
+		}
+	} while (rrb->response.hdr.rsp == CLP_RC_SETPCIFN_BUSY);
+
+	return cc;
+}
+
+static int ppt_clp_set_pci(struct kvm_vcpu *vcpu,
+			   struct clp_req_rsp_set_pci *rrb, u8 *cc)
+{
+	struct ppt_dev *ppt_dev;
+	int rc = 0;
+
+	if ((rrb->request.fh & FH_VIRT) == FH_VIRT)
+		return -EOPNOTSUPP;
+
+	ppt_dev = ppt_get_by_fh(vcpu->kvm, rrb->request.fh);
+	if (!ppt_dev) {
+		*cc = 3;
+		rrb->response.hdr.rsp = CLP_RC_SETPCIFN_FH;
+		return -ENODEV;
+	}
+
+	if (rrb->request.oc == CLP_SET_ENABLE_PCI_FN) {
+		rrb->request.gd = vcpu->arch.sie_block->gd;
+		*cc = ppt_clp_instr(rrb);
+		if (!(*cc) && rrb->response.hdr.rsp == CLP_RC_OK) {
+			/* Success -> store handle in zdev */
+			PPT_DEVICE_MESSAGE(ppt_dev, PPT_TRACE_NORMAL,
+				"enable ppt\n");
+			ppt_dev->zdev->fh = rrb->response.fh;
+		} else {
+			PPT_DEVICE_MESSAGE(ppt_dev, PPT_TRACE_NORMAL,
+				"enable ppt failed cc %d resp 0x%x\n",
+				*cc, rrb->response.hdr.rsp);
+			rc = -EIO;
+			goto out;
+		}
+
+		rc = zpci_dma_init_device(ppt_dev->zdev);
+		if (rc) {
+			PPT_DEVICE_MESSAGE(ppt_dev, PPT_TRACE_NORMAL,
+				"ppt dma init failed rc 0x%x\n", rc);
+			clp_disable_fh(ppt_dev->zdev);
+			goto out;
+		}
+
+		rc = pci_enable_device(ppt_dev->pdev);
+		if (rc) {
+			PPT_DEVICE_MESSAGE(ppt_dev, PPT_TRACE_NORMAL,
+				"pci_enable_device failed rc 0x%x\n", rc);
+			zpci_disable_device(ppt_dev->zdev);
+			goto out;
+		}
+
+		rc = pci_request_regions(ppt_dev->pdev,
+			"s390_assigned_device");
+		if (rc) {
+			PPT_DEVICE_MESSAGE(ppt_dev, PPT_TRACE_NORMAL,
+				"pci_request_regions failed rc 0x%x\n", rc);
+			zpci_disable_device(ppt_dev->zdev);
+			pci_disable_device(ppt_dev->pdev);
+			goto out;
+		}
+		ppt_dev->zdev->state = ZPCI_FN_STATE_ONLINE;
+		ppt_dev->enabled = 1;
+		PPT_DEVICE_MESSAGE(ppt_dev, PPT_TRACE_NORMAL, "enabled\n");
+	} else {
+		pci_release_regions(ppt_dev->pdev);
+		pci_disable_device(ppt_dev->pdev);
+		zpci_dma_exit_device(ppt_dev->zdev);
+		*cc = ppt_clp_instr(rrb);
+		if (!(*cc) && rrb->response.hdr.rsp == CLP_RC_OK) {
+			PPT_DEVICE_MESSAGE(ppt_dev, PPT_TRACE_NORMAL,
+				"disable ppt\n");
+			ppt_dev->zdev->fh = rrb->response.fh;
+		} else {
+			PPT_DEVICE_MESSAGE(ppt_dev, PPT_TRACE_NORMAL,
+				"disable ppt failed cc %d resp %x\n",
+				*cc, rrb->response.hdr.rsp);
+			rc = -EIO;
+			goto out;
+		}
+		ppt_dev->enabled = 0;
+		PPT_DEVICE_MESSAGE(ppt_dev,
+			PPT_TRACE_NORMAL, "disabled\n");
+	}
+out:
+	ppt_put_dev(ppt_dev);
+	return rc;
+}
+
+int handle_clp(struct kvm_vcpu *vcpu)
+{
+	struct clp_req_hdr *reqh;
+	struct clp_rsp_hdr *resh;
+	char *buffer;
+	__u32 req_len, res_len;
+	int cmd, res_code, rc;
+	u8 cc;
+	struct ppt_dev *ppt_dev;
+	int r2 = (vcpu->arch.sie_block->ipb & 0x000f0000) >> 16;
+	int handle_user = 0;
+
+	cmd = rc = cc = res_code = 0;
+
+	buffer = (char *)get_zeroed_page(GFP_KERNEL);
+	if (!buffer) {
+		rc = -ENOMEM;
+		goto out;
+	}
+	rc = read_guest(vcpu, vcpu->run->s.regs.gprs[r2], buffer, sizeof(reqh));
+	if (rc)
+		goto out;
+	reqh = (struct clp_req_hdr *)buffer;
+	req_len = reqh->len;
+
+	rc = read_guest(vcpu, vcpu->run->s.regs.gprs[r2], buffer,
+			req_len + sizeof(resh));
+	if (rc)
+		goto out;
+	resh = (struct clp_rsp_hdr *)(buffer + req_len);
+	res_len = resh->len;
+
+	rc = read_guest(vcpu, vcpu->run->s.regs.gprs[r2], buffer,
+			req_len + res_len);
+	if (rc)
+		goto out;
+
+	cmd = reqh->cmd;
+	switch (cmd) {
+	case CLP_LIST_PCI: {
+		struct clp_req_rsp_list_pci *rrlistpci =
+			(struct clp_req_rsp_list_pci *)buffer;
+#ifdef USER_LSPCI
+		handle_user = 1;
+		goto out_u;
+#endif
+		rc = ppt_clp_list_pci(vcpu, rrlistpci, &cc);
+		res_code = rrlistpci->response.hdr.rsp;
+		break;
+	}
+	case CLP_SET_PCI_FN: {
+		struct clp_req_rsp_set_pci *rrsetpci =
+			(struct clp_req_rsp_set_pci *)buffer;
+		rc = ppt_clp_set_pci(vcpu, rrsetpci, &cc);
+		if (rc == -EOPNOTSUPP)
+			goto out_u;
+		res_code = rrsetpci->response.hdr.rsp;
+#ifdef USER_LSPCI
+		handle_user = 1;
+#endif
+		break;
+	}
+	case CLP_QUERY_PCI_FN: {
+		struct clp_req_rsp_query_pci *rrqpci =
+			(struct clp_req_rsp_query_pci *)buffer;
+
+		if ((rrqpci->request.fh & FH_VIRT) == FH_VIRT)
+			return -EOPNOTSUPP;
+
+		ppt_dev = ppt_get_by_fh(vcpu->kvm, rrqpci->request.fh);
+		if (!ppt_dev) {
+			cc = 3;
+			res_code = rrqpci->response.hdr.rsp =
+				CLP_RC_SETPCIFN_FH;
+			break;
+		}
+
+		cc = clp_instr(rrqpci);
+		res_code = rrqpci->response.hdr.rsp;
+		ppt_put_dev(ppt_dev);
+		break;
+	}
+	case CLP_QUERY_PCI_FNGRP: {
+		struct clp_req_rsp_query_pci_grp *rrqgrp =
+			(struct clp_req_rsp_query_pci_grp *)buffer;
+
+		cc = clp_instr(buffer);
+		/* always turn on tlb refresh so the rpcit intercept can
+		   keep track dma memory */
+		rrqgrp->response.refresh = 1;
+		res_code = rrqgrp->response.hdr.rsp;
+		break;
+	}
+	default:
+		PPT_MESSAGE(PPT_TRACE_NORMAL,
+			"invalid clp command 0x%x\n", reqh->cmd);
+		rc = -EINVAL;
+	}
+
+	if (rc || cc == 3 || res_code != CLP_RC_OK)
+		PPT_MESSAGE(PPT_TRACE_NORMAL,
+			"clp failed cmd %d rc %d cc %d resp 0x%x\n",
+			cmd, rc, cc, res_code);
+
+	rc = write_guest(vcpu, vcpu->run->s.regs.gprs[r2], buffer,
+		req_len + res_len);
+out:
+	if (rc) {
+		PPT_MESSAGE(PPT_TRACE_NORMAL,
+			"handle clp failed cmd %d rc %d\n", cmd, rc);
+		cc = 3;
+		if (rc != -EOPNOTSUPP)
+			rc = 0;
+	}
+	kvm_s390_set_psw_cc(vcpu, cc);
+out_u:
+	free_page((unsigned long)buffer);
+	return handle_user ? -EOPNOTSUPP : rc;
+}
+
+static u64 ppt_guest_io_table_walk(u64 guest_iota, u64 guest_dma_address,
+				   struct kvm_vcpu *vcpu)
+{
+	u64 sto_a, pto_a, px_a;
+	u64 sto, pto, pte;
+	u32 rtx, sx, px;
+	int rc;
+
+	rtx = calc_rtx(guest_dma_address);
+	sx = calc_sx(guest_dma_address);
+	px = calc_px(guest_dma_address);
+
+	sto_a = guest_iota + rtx * sizeof(u64);
+	rc = read_guest(vcpu, sto_a, &sto, sizeof(u64));
+	if (rc)
+		return rc;
+
+	sto = (u64)get_rt_sto(sto);
+	if (!sto)
+		return -EINVAL;
+
+	pto_a = sto + sx * sizeof(u64);
+	rc = read_guest(vcpu, pto_a, &pto, sizeof(u64));
+	if (rc)
+		return rc;
+
+	pto = (u64)get_st_pto(pto);
+	if (!pto)
+		return -EINVAL;
+
+	px_a = pto + px * sizeof(u64);
+	rc = read_guest(vcpu, px_a, &pte, sizeof(u64));
+	if (rc)
+		return rc;
+
+	return pte;
+}
+
+static void ppt_set_status(struct kvm_vcpu *vcpu, int rx, u8 status)
+{
+	if (vcpu) {
+		vcpu->run->s.regs.gprs[rx] &= ~(0xFF << 24);
+		vcpu->run->s.regs.gprs[rx] |= ((unsigned long)status << 24);
+	}
+}
+
+static u8 ppt_mod_fc(u64 req, struct zpci_fib *fib, u8 *status)
+{
+	u8 cc;
+
+	do {
+		cc = __mpcifc(req, fib, status);
+		if (cc == 2)
+			msleep(20);
+	} while (cc == 2);
+
+	if (cc)
+		PPT_MESSAGE(PPT_TRACE_NORMAL,
+			"%s: error cc: %d  status: %d\n",
+			__func__, cc, *status);
+
+	return cc;
+}
+
+static u8 ppt_refresh_trans(u64 fn, u64 addr, u64 range, u8 *status)
+{
+	u8 cc;
+
+	do {
+		cc = __rpcit(fn, addr, range, status);
+		if (cc == 2)
+			udelay(1);
+	} while (cc == 2);
+
+	if (cc)
+		PPT_MESSAGE(PPT_TRACE_NORMAL,
+		"%s: error cc: %d  status: %d  dma_addr: %Lx  size: %Lx\n",
+			__func__, cc, *status, addr, range);
+	return cc;
+}
+
+static u8 ppt_load(u64 *data, u64 req, u64 offset, u8 *status)
+{
+	int cc;
+
+	do {
+		cc = (u8)__pcilg(data, req, offset, status);
+		if (cc == 2)
+			udelay(1);
+	} while (cc == 2);
+
+	return cc;
+}
+
+static u8 ppt_store(u64 data, u64 req, u64 offset, u8 *status)
+{
+	u8 cc;
+
+	do {
+		cc = (u8)__pcistg(data, req, offset, status);
+		if (cc == 2)
+			udelay(1);
+	} while (cc == 2);
+
+	return cc;
+}
+
+static u8 ppt_store_block(const u64 *data, u64 req, u64 offset, u8 *status)
+{
+	u8 cc;
+
+	do {
+		cc = (u8)__pcistb(data, req, offset, status);
+		if (cc == 2)
+			udelay(1);
+	} while (cc == 2);
+
+	return cc;
+}
+
+int handle_rpcit(struct kvm_vcpu *vcpu)
+{
+	u8 cc = ZPCI_PCI_LS_OK, status = 0;
+	int rc = 0;
+	int r1 = (vcpu->arch.sie_block->ipb & 0x00f00000) >> 20;
+	int r2 = (vcpu->arch.sie_block->ipb & 0x000f0000) >> 16;
+	u64 pte;
+	u64 uaddr;
+	int flags;
+	u32 fh = vcpu->run->s.regs.gprs[r1] >> 32;
+	struct page **page_list;
+	int i;
+	u64 dma_addr;
+	u32 nr_pages;
+	u32 nr_upages;
+	struct ppt_dev *ppt_dev;
+
+	if ((fh & FH_VIRT) == FH_VIRT)
+		return -EOPNOTSUPP;
+
+	ppt_dev = ppt_get_by_fh(vcpu->kvm, fh);
+	if (!ppt_dev) {
+		cc = ZPCI_PCI_LS_INVAL_HANDLE;
+		status = 0;
+		rc = -ENODEV;
+		goto out_nodev;
+	}
+
+	pte = ppt_guest_io_table_walk(ppt_dev->g_iota,
+		vcpu->run->s.regs.gprs[r2], vcpu);
+	if (IS_ERR_VALUE(pte)) {
+		PPT_DEVICE_MESSAGE(ppt_dev, PPT_TRACE_NORMAL,
+			"rpcit bad pte\n");
+		rc = pte;
+		cc = 1;
+		status = 16;
+		goto out;
+	}
+
+	uaddr = gmap_translate((pte & ZPCI_PTE_ADDR_MASK), vcpu->arch.gmap);
+	if (uaddr < 0) {
+		PPT_DEVICE_MESSAGE(ppt_dev, PPT_TRACE_NORMAL,
+			"rpcit bad mapping\n");
+		rc = uaddr;
+		cc = 1;
+		status = 16;
+		goto out;
+	}
+
+	page_list = (struct page **) __get_free_page(GFP_KERNEL);
+	if (!page_list) {
+		rc = -ENOMEM;
+		cc = 1;
+		status = 16;
+		goto out;
+	}
+	flags = pte & ZPCI_PTE_FLAG_MASK;
+	nr_pages = vcpu->run->s.regs.gprs[r2 + 1] / PAGE_SIZE;
+
+	nr_upages = get_user_pages_fast(uaddr, nr_pages, 1, page_list);
+
+	if (!nr_upages) {
+		PPT_DEVICE_MESSAGE(ppt_dev,
+			PPT_TRACE_NORMAL, "rpcit no user pages\n");
+		rc = -ENOMEM;
+		cc = 1;
+		status = 16;
+		goto no_pages;
+	}
+
+	dma_addr = vcpu->run->s.regs.gprs[r2];
+	for (i = 0; i < nr_upages; i++) {
+		rc = ppt_update_trans_entry(ppt_dev, dma_addr, page_list[i],
+			flags, &cc, &status);
+		if (rc) {
+			dma_purge_rto_entries(ppt_dev->zdev);
+			break;
+		}
+		dma_addr += PAGE_SIZE;
+	}
+
+	for (i = 0; i < nr_upages; i++)
+		put_page(page_list[i]);
+
+	ppt_dev->stat_items[PPT_DEV_STAT_RPCIT]++;
+no_pages:
+	free_page((unsigned long)page_list);
+out:
+	ppt_put_dev(ppt_dev);
+out_nodev:
+	kvm_s390_set_psw_cc(vcpu, (unsigned long)cc);
+	ppt_set_status(vcpu, r1, status);
+	if (rc)
+		PPT_DEVICE_MESSAGE(ppt_dev, PPT_TRACE_NORMAL,
+			"rpcit failed rc %d\n", rc);
+
+	return 0;
+}
+
+int handle_sic(struct kvm_vcpu *vcpu)
+{
+	int r1 = (vcpu->arch.sie_block->ipa & 0x00f0) >> 4;
+	int r3 = vcpu->arch.sie_block->ipa & 0x000f;
+
+	/* since we have ecb bit 18 we should only get
+	intercept for operation 2 so log this */
+	PPT_MESSAGE(PPT_TRACE_NORMAL, "Warnig: sic r1 0x%llx r3 0x%llx\n",
+		vcpu->run->s.regs.gprs[r1], vcpu->run->s.regs.gprs[r3]);
+	return 0;
+}
+
+int handle_pcistb(struct kvm_vcpu *vcpu)
+{
+	u8 cc, status;
+	int r1 = (vcpu->arch.sie_block->ipa & 0x00f0) >> 4;
+	int r3 = vcpu->arch.sie_block->ipa & 0x000f;
+	u64 gaddr = kvm_s390_get_base_disp_rsy(vcpu);
+	u32 fh = vcpu->run->s.regs.gprs[r1] >> 32;
+	struct ppt_dev *ppt_dev;
+	int rc = 0;
+	u8 len = vcpu->run->s.regs.gprs[r1] & 0xff;
+	char *buffer;
+
+	if ((fh & FH_VIRT) == FH_VIRT)
+		return -EOPNOTSUPP;
+
+	ppt_dev = ppt_get_by_fh(vcpu->kvm, fh);
+	if (!ppt_dev) {
+		cc = ZPCI_PCI_LS_INVAL_HANDLE;
+		status = 0;
+		goto out_nodev;
+	}
+
+	buffer = (char *)get_zeroed_page(GFP_KERNEL);
+	if (!buffer) {
+		PPT_DEVICE_MESSAGE(ppt_dev, PPT_TRACE_NORMAL,
+			"pcistb get page failed\n");
+		cc = ZPCI_PCI_LS_ERR;
+		status = 40;
+		goto out_nomem;
+	}
+
+	rc = read_guest(vcpu, gaddr, buffer, len);
+	if (rc) {
+		PPT_DEVICE_MESSAGE(ppt_dev, PPT_TRACE_NORMAL,
+			"pcistb read guest failed rc %d\n", rc);
+		cc = ZPCI_PCI_LS_ERR;
+		status = 40;
+		goto out;
+	}
+
+	cc = ppt_store_block((const u64 *)buffer,
+		vcpu->run->s.regs.gprs[r1],
+		vcpu->run->s.regs.gprs[r3],
+		&status);
+	ppt_dev->stat_items[PPT_DEV_STAT_PCISTB]++;
+	if (cc)
+		PPT_DEVICE_MESSAGE(ppt_dev, PPT_TRACE_NORMAL,
+			"pcistb offset 0x%llx gaddr 0x%llx len %d cc %d\n",
+			vcpu->run->s.regs.gprs[r3], gaddr, len, cc);
+out:
+	free_page((unsigned long)buffer);
+out_nomem:
+	ppt_put_dev(ppt_dev);
+out_nodev:
+	kvm_s390_set_psw_cc(vcpu, (unsigned long)cc);
+	ppt_set_status(vcpu, r1, status);
+	return 0;
+}
+
+static void ppt_irq_worker(struct work_struct *work)
+{
+	int rc;
+	struct kvm_s390_interrupt s390int;
+	struct ppt_vm_entry *ppt_vm = container_of(work, struct ppt_vm_entry,
+						   irq_work);
+
+	u32 io_int_word = (PCI_ISC << 27) | IO_INT_WORD_AI;
+
+	s390int.type = KVM_S390_INT_IO(1, 0, 0, 0);
+	s390int.parm = 0;
+	s390int.parm64 = io_int_word;
+
+	rc = kvm_s390_inject_vm(ppt_vm->kvm, &s390int);
+	if (rc)
+		PPT_MESSAGE(PPT_TRACE_NORMAL, "inject vm failed\n");
+}
+
+static irqreturn_t ppt_handle_host_irq(int irq, void *ptr)
+{
+	struct ppt_dev *ppt_dev = (struct ppt_dev *)ptr;
+	int summary_set, i;
+
+	for (i = 0; i < ppt_dev->noi; ++i) {
+		if (ppt_dev->entries[i].vector == irq) {
+			set_bit(ppt_dev->entries[i].entry ^ be_to_le,
+				ppt_dev->aibv);
+			break;
+		}
+	}
+
+	summary_set = test_and_set_bit(ppt_dev->aisbo ^ be_to_le,
+		ppt_dev->aisb);
+
+	if (!summary_set) {
+		if (kvm_s390_gisa_test_iam_gisc(ppt_dev->kvm, PCI_ISC)) {
+			schedule_work(&ppt_dev->ppt_vm->irq_work);
+			ppt_dev->stat_items[PPT_DEV_STAT_HOST_IRQ_INJECT]++;
+		} else {
+			kvm_s390_gisa_set_ipm_gisc(ppt_dev->kvm, PCI_ISC);
+			ppt_dev->stat_items[PPT_DEV_STAT_HOST_IRQ_GISA]++;
+		}
+	}
+	return IRQ_HANDLED;
+}
+
+static unsigned long *ppt_getandmap_gaddr(u64 gaddr, struct kvm_vcpu *vcpu)
+{
+	unsigned long uaddr = gmap_translate(gaddr, vcpu->arch.gmap);
+	u32 offset = gaddr % PAGE_SIZE;
+	int nr_upages;
+	struct page *page;
+	unsigned long *kpp;
+
+	if (uaddr < 0) {
+		PPT_MESSAGE(PPT_TRACE_NORMAL, "bad gaddr\n");
+		return ERR_PTR(uaddr);
+	}
+
+	nr_upages = get_user_pages(current, current->mm,
+		uaddr, 1, 1, 0, &page, NULL);
+	if (!nr_upages) {
+		PPT_MESSAGE(PPT_TRACE_NORMAL, "gaddr no user pages\n");
+		return ERR_PTR(-ENOMEM);
+	}
+
+	kpp = page_address(page);
+
+	kpp = (unsigned long *)((char *)kpp + offset);
+	return kpp;
+}
+
+static u32 ppt_gib_get_alo(void)
+{
+	return ACCESS_ONCE(gib->alo);
+}
+
+static void ppt_gib_set_alo(u32 alo)
+{
+	xchg(&gib->alo, alo);
+}
+
+static int ppt_reg_irqs_host(struct ppt_dev *ppt_dev, u8 *cc, u8 *status)
+{
+	int i, n, err;
+
+	PPT_DEVICE_MESSAGE(ppt_dev, PPT_TRACE_NORMAL, "use host irqs\n");
+	ppt_dev->entries = kcalloc(ppt_dev->noi, sizeof(struct msix_entry),
+				   GFP_KERNEL);
+	if (!ppt_dev->entries) {
+		*cc = ZPCI_PCI_LS_ERR;
+		*status = 16;
+		return -ENOMEM;
+	}
+
+	for (i = 0; i < ppt_dev->noi; ++i)
+		ppt_dev->entries[i].entry = i;
+
+	err = pci_enable_msix(ppt_dev->pdev, ppt_dev->entries, ppt_dev->noi);
+	if (err) {
+		PPT_DEVICE_MESSAGE(ppt_dev, PPT_TRACE_NORMAL,
+			"mpcifc pci_enable_msix %d\n", err);
+		*cc = ZPCI_PCI_LS_ERR;
+		*status = 16;
+		kfree(ppt_dev->entries);
+		return err;
+	}
+
+	for (i = 0; i < ppt_dev->noi; ++i) {
+		PPT_DEVICE_MESSAGE(ppt_dev, PPT_TRACE_NORMAL,
+			"mpcifc request irq entry %d vector %d\n",
+			ppt_dev->entries[i].entry,
+			ppt_dev->entries[i].vector);
+		err = request_irq(ppt_dev->entries[i].vector,
+			ppt_handle_host_irq, 0, "pci proxy", ppt_dev);
+		if (err) {
+			PPT_DEVICE_MESSAGE(ppt_dev, PPT_TRACE_NORMAL,
+				"mpcifc request_irq %d\n", err);
+			for (n = 0; n < i; ++n)
+				free_irq(ppt_dev->entries[i].vector, ppt_dev);
+
+			pci_disable_msix(ppt_dev->pdev);
+			kfree(ppt_dev->entries);
+			*cc = ZPCI_PCI_LS_ERR;
+			*status = 16;
+			return err;
+		}
+	}
+
+	*cc = ZPCI_PCI_LS_OK;
+	*status = 0;
+	ppt_dev->irq_on = 1;
+	return 0;
+}
+
+static int ppt_reg_irqs(struct ppt_dev *ppt_dev, struct zpci_fib *fib,
+			struct kvm_vcpu *vcpu, u8 *cc, u8 *status)
+{
+	int rc = 0;
+	u64 req;
+
+	ppt_dev->noi = fib->noi;
+	ppt_dev->sum = fib->sum;
+	ppt_dev->aibv = ppt_getandmap_gaddr(fib->aibv, vcpu);
+	if (IS_ERR(ppt_dev->aibv)) {
+		*cc = ZPCI_PCI_LS_ERR;
+		*status = 16;
+		return PTR_ERR(ppt_dev->aibv);
+	}
+	ppt_dev->aibvo = fib->aibvo;
+	ppt_dev->aisb = ppt_getandmap_gaddr(fib->aisb, vcpu);
+	if (IS_ERR(ppt_dev->aisb)) {
+		*cc = ZPCI_PCI_LS_ERR;
+		*status = 16;
+		put_page(virt_to_page(ppt_dev->aibv));
+		return PTR_ERR(ppt_dev->aisb);
+	}
+	ppt_dev->aisbo = fib->aisbo;
+
+	PPT_DEVICE_MESSAGE(ppt_dev, PPT_TRACE_NORMAL,
+		"mpcifc reg int noi %d aibv %p aibvo 0x%x aisb %p aisbo 0x%x\n",
+		ppt_dev->noi, ppt_dev->aibv, ppt_dev->aibvo, ppt_dev->aisb,
+		ppt_dev->aisbo);
+
+	ppt_dev->faisb = airq_iv_alloc_bit(faisb_iv);
+	if (ppt_dev->faisb == -1UL) {
+		*cc = ZPCI_PCI_LS_ERR;
+		*status = 16;
+		put_page(virt_to_page(ppt_dev->aibv));
+		put_page(virt_to_page(ppt_dev->aisb));
+		return -EINVAL;
+	}
+
+	PPT_DEVICE_MESSAGE(ppt_dev, PPT_TRACE_NORMAL,
+		"faisb nr %d\n", ppt_dev->faisb);
+
+	if (ppt_dev->hostirq)
+		rc = ppt_reg_irqs_host(ppt_dev, cc, status);
+	else {
+		PPT_DEVICE_MESSAGE(ppt_dev, PPT_TRACE_NORMAL,
+			"use aen irqs\n");
+		gait[ppt_dev->faisb].gd = vcpu->arch.sie_block->gd;
+		gait[ppt_dev->faisb].gisc = PCI_ISC;
+		gait[ppt_dev->faisb].gaisbo = ppt_dev->aisbo;
+		gait[ppt_dev->faisb].gaisba = (u64)ppt_dev->aisb;
+
+		PPT_DEVICE_MESSAGE(ppt_dev, PPT_TRACE_NORMAL,
+			"setup gait gd 0x%x gait[%d] 0x%lx\n",
+			gait[ppt_dev->faisb].gd, ppt_dev->faisb,
+			(unsigned long)&gait[ppt_dev->faisb]);
+		PPT_DEVICE_MESSAGE(ppt_dev, PPT_TRACE_NORMAL,
+			"gaisbo 0x%x gaisba 0x%llx\n",
+			gait[ppt_dev->faisb].gaisbo,
+			gait[ppt_dev->faisb].gaisba);
+
+		fib->aibv = (u64)ppt_dev->aibv;
+		fib->aisb = (unsigned long)faisb_iv->vector +
+				(ppt_dev->faisb/64)*8;
+		fib->aisbo = ppt_dev->faisb & 63;
+		fib->gd = vcpu->arch.sie_block->gd;
+		fib->isc = PCIPT_ISC;
+		req = ZPCI_CREATE_REQ(ppt_dev->zdev->fh, 0,
+			ZPCI_MOD_FC_REG_INT);
+		*cc = ppt_mod_fc(req, fib, status);
+		if (!*cc)
+			ppt_dev->irq_on = 1;
+		else
+			rc = -EIO;
+	}
+
+	if (rc) {
+		airq_iv_free_bit(faisb_iv, ppt_dev->faisb);
+		put_page(virt_to_page(ppt_dev->aibv));
+		put_page(virt_to_page(ppt_dev->aisb));
+	}
+
+	return rc;
+}
+
+static void ppt_dereg_irqs(struct ppt_dev *ppt_dev, u8 *cc, u8 *status)
+{
+	int i;
+	u64 req;
+	struct zpci_fib *fib;
+
+	PPT_DEVICE_MESSAGE(ppt_dev, PPT_TRACE_NORMAL, "dereg_irqs\n");
+	if (ppt_dev->hostirq) {
+		for (i = 0; i < ppt_dev->noi; ++i)
+			free_irq(ppt_dev->entries[i].vector, ppt_dev);
+
+		pci_disable_msix(ppt_dev->pdev);
+		kfree(ppt_dev->entries);
+		PPT_DEVICE_MESSAGE(ppt_dev, PPT_TRACE_NORMAL,
+			"host_irqs_inject: %d host_irqs_gisa: %d\n",
+			ppt_dev->stat_items[PPT_DEV_STAT_HOST_IRQ_INJECT],
+			ppt_dev->stat_items[PPT_DEV_STAT_HOST_IRQ_GISA]);
+		*cc = ZPCI_PCI_LS_OK;
+	} else {
+		fib = (void *) get_zeroed_page(GFP_KERNEL);
+		req = ZPCI_CREATE_REQ(ppt_dev->zdev->fh, 0,
+			ZPCI_MOD_FC_DEREG_INT);
+		*cc = ppt_mod_fc(req, fib, status);
+		if (*cc)
+			PPT_DEVICE_MESSAGE(ppt_dev, PPT_TRACE_NORMAL,
+				"dereg irq failed cc %d\n", *cc);
+		free_page((unsigned long)fib);
+		memset(&gait[ppt_dev->faisb], 0, sizeof(struct kvm_s390_gait));
+	}
+
+	PPT_DEVICE_MESSAGE(ppt_dev, PPT_TRACE_NORMAL,
+		"faisb 0x%lx aisb 0x%lx aibv 0x%lx\n",
+		*faisb_iv->vector, *ppt_dev->aisb, *ppt_dev->aibv);
+
+	PPT_DEVICE_MESSAGE(ppt_dev, PPT_TRACE_NORMAL,
+		"gib 0x%x gisa ipm 0x%x iam 0x%x G %d C %d\n",
+		ppt_gib_get_alo(),
+		kvm_s390_gisa_get_ipm(ppt_dev->kvm),
+		kvm_s390_gisa_get_iam(ppt_dev->kvm),
+		kvm_s390_gisa_get_g(ppt_dev->kvm),
+		kvm_s390_gisa_get_c(ppt_dev->kvm));
+
+	airq_iv_free_bit(faisb_iv, ppt_dev->faisb);
+	put_page(virt_to_page(ppt_dev->aibv));
+	put_page(virt_to_page(ppt_dev->aisb));
+	ppt_dev->irq_on = 0;
+}
+
+static int ppt_fmb_enable_device(struct ppt_dev *ppt_dev, struct zpci_fib *fib,
+				 struct kvm_vcpu *vcpu, u8 *cc, u8 *status)
+{
+	u64 req;
+	unsigned long *haddr;
+
+	haddr = ppt_getandmap_gaddr(fib->fmb_addr, vcpu);
+	if (IS_ERR(haddr)) {
+		PPT_DEVICE_MESSAGE(ppt_dev, PPT_TRACE_NORMAL,
+			"get and map guest addr failed\n");
+		*cc = ZPCI_PCI_LS_ERR;
+		*status = 16;
+		return PTR_ERR(haddr);
+	}
+
+	fib->fmb_addr = (u64)haddr;
+	req = ZPCI_CREATE_REQ(ppt_dev->zdev->fh, 0, ZPCI_MOD_FC_SET_MEASURE);
+	*cc = ppt_mod_fc(req, fib, status);
+	if (*cc) {
+		put_page(virt_to_page(haddr));
+		return -EIO;
+	}
+
+	if (ppt_dev->fmb) {
+		PPT_DEVICE_MESSAGE(ppt_dev, PPT_TRACE_NORMAL,
+			"release old fmb: 0x%p\n", ppt_dev->fmb);
+		put_page(virt_to_page(ppt_dev->fmb));
+		ppt_dev->fmb = NULL;
+	}
+	ppt_dev->fmb = (struct zpci_fmb *)haddr;
+
+	return 0;
+}
+
+static int ppt_fmb_disable_device(struct ppt_dev *ppt_dev, struct zpci_fib *fib,
+				  u8 *cc, u8 *status)
+{
+	u64 req;
+
+	if (!ppt_dev->fmb || fib->fmb_addr)
+		return -EINVAL;
+
+	req = ZPCI_CREATE_REQ(ppt_dev->zdev->fh, 0, ZPCI_MOD_FC_SET_MEASURE);
+	*cc = ppt_mod_fc(req, fib, status);
+	if (*cc)
+		return -EIO;
+	put_page(virt_to_page(ppt_dev->fmb));
+	ppt_dev->fmb = NULL;
+	return 0;
+}
+
+static int ppt_set_measure(struct ppt_dev *ppt_dev, struct zpci_fib *fib,
+			   struct kvm_vcpu *vcpu, u8 *cc, u8 *status)
+{
+	int rc = 0;
+
+	if (fib->fmb_addr == 0)
+		rc = ppt_fmb_disable_device(ppt_dev, fib, cc, status);
+	else
+		rc = ppt_fmb_enable_device(ppt_dev, fib, vcpu, cc, status);
+	return rc;
+}
+
+static int ppt_rereg_ioat(struct ppt_dev *ppt_dev, struct zpci_fib *fib,
+			  u8 *cc, u8 *status)
+{
+	u64 req = ZPCI_CREATE_REQ(ppt_dev->zdev->fh, 0, ZPCI_MOD_FC_REREG_IOAT);
+	struct zpci_fib *nfib;
+
+	if (!fib) {
+		*cc = ZPCI_PCI_LS_ERR;
+		*status = 16;
+		return -EINVAL;
+	}
+
+	nfib = (void *) get_zeroed_page(GFP_KERNEL);
+	if (!nfib) {
+		*cc = ZPCI_PCI_LS_ERR;
+		*status = 16;
+		return -ENOMEM;
+	}
+
+	nfib->pal = fib->pal;
+	nfib->iota = (u64)ppt_dev->zdev->dma_table;
+
+	*cc = ppt_mod_fc(req, nfib, status);
+	if (!*cc) {
+		dma_purge_rto_entries(ppt_dev->zdev);
+		ppt_dev->g_iota = fib->iota & ~ZPCI_IOTA_RTTO_FLAG;
+	}
+
+	free_page((unsigned long) nfib);
+	return (*cc) ? -EIO : 0;
+}
+
+static int ppt_reset_error(struct ppt_dev *ppt_dev, struct zpci_fib *fib,
+			   u8 *cc, u8 *status)
+{
+	u64 req  = ZPCI_CREATE_REQ(ppt_dev->zdev->fh,
+		0, ZPCI_MOD_FC_RESET_ERROR);
+
+	if (!fib) {
+		*cc = 1;
+		*status = 16;
+		return -EINVAL;
+	}
+
+	*cc = ppt_mod_fc(req, fib, status);
+	return (*cc) ? -EIO : 0;
+}
+
+static int ppt_reset_block(struct ppt_dev *ppt_dev, struct zpci_fib *fib,
+			   u8 *cc, u8 *status)
+{
+	u64 req  = ZPCI_CREATE_REQ(ppt_dev->zdev->fh,
+		0, ZPCI_MOD_FC_RESET_BLOCK);
+
+	if (!fib) {
+		*cc = 1;
+		*status = 16;
+		return -EINVAL;
+	}
+
+	*cc = ppt_mod_fc(req, fib, status);
+	return (*cc) ? -EIO : 0;
+}
+
+int handle_mpcifc(struct kvm_vcpu *vcpu)
+{
+	u8 cc = ZPCI_PCI_LS_OK, status;
+	int rc = 0;
+	int r1 = (vcpu->arch.sie_block->ipa & 0x00f0) >> 4;
+	u64 fiba = kvm_s390_get_base_disp_rxy(vcpu);
+	struct zpci_fib *fib;
+	u8 oc = vcpu->run->s.regs.gprs[r1] & 0xff;
+	u32 fh = vcpu->run->s.regs.gprs[r1] >> 32;
+	struct ppt_dev *ppt_dev;
+
+	if ((fh & FH_VIRT) == FH_VIRT)
+		return -EOPNOTSUPP;
+
+	ppt_dev = ppt_get_by_fh(vcpu->kvm, fh);
+	if (!ppt_dev) {
+		cc = ZPCI_PCI_LS_INVAL_HANDLE;
+		status = 0;
+		rc = -ENODEV;
+		goto out_nodev;
+	}
+
+	fib = (void *)get_zeroed_page(GFP_KERNEL);
+	if (!fib) {
+		PPT_MESSAGE(PPT_TRACE_NORMAL,
+			"mpcifc: cannot get memory for fib\n");
+		cc = ZPCI_PCI_LS_ERR;
+		status = 16;
+		rc = -ENOMEM;
+		goto out_nomem;
+	}
+
+	rc = read_guest(vcpu, fiba, fib, sizeof(struct zpci_fib));
+	if (rc) {
+		PPT_MESSAGE(PPT_TRACE_NORMAL,
+			"mpcifc: read guest failed. fiba: 0x%llx\n", fiba);
+		cc = ZPCI_PCI_LS_ERR;
+		status = 16;
+		goto out_rguest;
+	}
+
+	switch (oc) {
+	case ZPCI_MOD_FC_REG_INT:
+		rc = ppt_reg_irqs(ppt_dev, fib, vcpu, &cc, &status);
+		break;
+	case ZPCI_MOD_FC_DEREG_INT:
+		ppt_dereg_irqs(ppt_dev, &cc, &status);
+		if (cc) {
+			PPT_DEVICE_MESSAGE(ppt_dev, PPT_TRACE_NORMAL,
+				"mpcifc: dereg interrupt cc=%d\n", cc);
+			rc = -EIO;
+		}
+		break;
+	case ZPCI_MOD_FC_REG_IOAT:
+		if (((fib->iota >> 2) & ZPCI_IOTA_IOPTO) != ZPCI_IOTA_RTTO) {
+			rc = -EINVAL;
+			cc = ZPCI_PCI_LS_ERR;
+			status = 28;
+			PPT_DEVICE_MESSAGE(ppt_dev, PPT_TRACE_NORMAL,
+				"mpcifc: register ioat memory format error.\n");
+			break;
+		}
+		ppt_dev->g_iota = fib->iota & ~ZPCI_IOTA_RTTO_FLAG;
+		PPT_DEVICE_MESSAGE(ppt_dev, PPT_TRACE_NORMAL,
+			"mpcifc set iota 0x%llx\n", ppt_dev->g_iota);
+		cc = ZPCI_PCI_LS_OK;
+		break;
+	case ZPCI_MOD_FC_DEREG_IOAT:
+		zpci_stop_device(ppt_dev->zdev);
+		ppt_dev->g_iota = 0;
+		break;
+	case ZPCI_MOD_FC_REREG_IOAT:
+		if (((fib->iota >> 2) & ZPCI_IOTA_IOPTO) != ZPCI_IOTA_RTTO) {
+			rc = -EINVAL;
+			cc = ZPCI_PCI_LS_ERR;
+			status = 28;
+			PPT_DEVICE_MESSAGE(ppt_dev, PPT_TRACE_NORMAL,
+				"mpcifc: rereg ioat memory format error.\n");
+			break;
+		}
+		rc = ppt_rereg_ioat(ppt_dev, fib, &cc, &status);
+		break;
+	case ZPCI_MOD_FC_RESET_ERROR:
+		rc = ppt_reset_error(ppt_dev, fib, &cc, &status);
+		break;
+	case ZPCI_MOD_FC_RESET_BLOCK:
+		rc = ppt_reset_block(ppt_dev, fib, &cc, &status);
+		break;
+	case ZPCI_MOD_FC_SET_MEASURE:
+		rc = ppt_set_measure(ppt_dev, fib, vcpu, &cc, &status);
+		break;
+	default:
+		PPT_DEVICE_MESSAGE(ppt_dev, PPT_TRACE_NORMAL,
+			"invalid mpcifc oc 0x%x\n", oc);
+		rc = -EINVAL;
+		cc = ZPCI_PCI_LS_ERR;
+		status = 16;
+	}
+	ppt_dev->stat_items[PPT_DEV_STAT_MPCIFC]++;
+out_rguest:
+	free_page((unsigned long)fib);
+out_nomem:
+	ppt_put_dev(ppt_dev);
+out_nodev:
+	kvm_s390_set_psw_cc(vcpu, (unsigned long)cc);
+	ppt_set_status(vcpu, r1, status);
+	PPT_DEVICE_MESSAGE(ppt_dev, PPT_TRACE_NORMAL,
+		"mpcifc oc %d rc %d cc %d status %d\n",
+		oc, rc, cc, status);
+	return 0;
+}
+
+int handle_pcistg(struct kvm_vcpu *vcpu)
+{
+	u8 cc, status;
+	int r1 = (vcpu->arch.sie_block->ipb & 0x00f00000) >> 20;
+	int r2 = (vcpu->arch.sie_block->ipb & 0x000f0000) >> 16;
+	u32 fh = vcpu->run->s.regs.gprs[r2] >> 32;
+	struct ppt_dev *ppt_dev;
+
+	if ((fh & FH_VIRT) == FH_VIRT)
+		return -EOPNOTSUPP;
+
+	ppt_dev = ppt_get_by_fh(vcpu->kvm, fh);
+	if (!ppt_dev) {
+		cc = ZPCI_PCI_LS_INVAL_HANDLE;
+		status = 0;
+		goto out;
+	}
+
+	cc = ppt_store(vcpu->run->s.regs.gprs[r1],
+			   vcpu->run->s.regs.gprs[r2],
+			   vcpu->run->s.regs.gprs[r2 + 1],
+			   &status);
+	ppt_dev->stat_items[PPT_DEV_STAT_PCISTG]++;
+
+	if (cc)
+		PPT_DEVICE_MESSAGE(ppt_dev, PPT_TRACE_NORMAL,
+			"pcistg req: 0x%llx off: 0x%llx data: 0x%llx cc: %d\n",
+			vcpu->run->s.regs.gprs[r2],
+			vcpu->run->s.regs.gprs[r2 + 1],
+			vcpu->run->s.regs.gprs[r1], cc);
+
+	ppt_put_dev(ppt_dev);
+out:
+	kvm_s390_set_psw_cc(vcpu, (unsigned long)cc);
+	ppt_set_status(vcpu, r2, status);
+	return 0;
+}
+
+int handle_pcilg(struct kvm_vcpu *vcpu)
+{
+	u8 cc, status;
+	int r1 = (vcpu->arch.sie_block->ipb & 0x00f00000) >> 20;
+	int r2 = (vcpu->arch.sie_block->ipb & 0x000f0000) >> 16;
+	u32 fh = vcpu->run->s.regs.gprs[r2] >> 32;
+	struct ppt_dev *ppt_dev;
+
+	if ((fh & FH_VIRT) == FH_VIRT)
+		return -EOPNOTSUPP;
+
+	ppt_dev = ppt_get_by_fh(vcpu->kvm, fh);
+	if (!ppt_dev) {
+		cc = ZPCI_PCI_LS_INVAL_HANDLE;
+		status = 0;
+		goto out;
+	}
+
+	cc = ppt_load(&vcpu->run->s.regs.gprs[r1],
+			  vcpu->run->s.regs.gprs[r2],
+			  vcpu->run->s.regs.gprs[r2 + 1],
+			  &status);
+	ppt_dev->stat_items[PPT_DEV_STAT_PCILG]++;
+
+	if (cc)
+		PPT_DEVICE_MESSAGE(ppt_dev, PPT_TRACE_NORMAL,
+			"pcilg req: 0x%llx off: 0x%llx data: 0x%llx cc: %d\n",
+			vcpu->run->s.regs.gprs[r2],
+			vcpu->run->s.regs.gprs[r2 + 1],
+			vcpu->run->s.regs.gprs[r1], cc);
+
+	ppt_put_dev(ppt_dev);
+out:
+	kvm_s390_set_psw_cc(vcpu, (unsigned long)cc);
+	ppt_set_status(vcpu, r2, status);
+	return 0;
+}
+
+int handle_stpcifc(struct kvm_vcpu *vcpu)
+{
+	PPT_MESSAGE(PPT_TRACE_NORMAL, "stpcifc\n");
+	kvm_s390_set_psw_cc(vcpu, 1);
+	return 0;
+}
+
+static void ppt_process_gisa(struct kvm_s390_gisa_f1 *gisa)
+{
+	struct ppt_vm_entry *tmp;
+
+	spin_lock(&ppt_vm_list_lock);
+
+	list_for_each_entry(tmp, &ppt_vm_list, entry) {
+		if (&tmp->kvm->arch.gisa->f1 == gisa) {
+			schedule_work(&tmp->irq_work);
+			tmp->stat_items[PPT_VM_STAT_ALERT_IRQ]++;
+			break;
+		}
+	}
+
+	spin_unlock(&ppt_vm_list_lock);
+}
+
+static void ppt_process_faisb(void)
+{
+	struct ppt_dev *ppt_dev, *tmp_ppt_dev;
+	struct ppt_vm_entry *tmp;
+	int summary_set;
+	unsigned long si;
+
+	for (si = 0;;) {
+		si = airq_iv_scan(faisb_iv, si, airq_iv_end(faisb_iv));
+		if (si == -1UL)
+			break;
+
+		ppt_dev = NULL;
+
+		spin_lock(&ppt_vm_list_lock);
+
+		list_for_each_entry(tmp, &ppt_vm_list, entry) {
+			list_for_each_entry(tmp_ppt_dev,
+				&tmp->kvm->arch.ppt_dev_list, entry) {
+				if (tmp_ppt_dev->faisb == si) {
+					ppt_dev = tmp_ppt_dev;
+					break;
+				}
+			}
+			if (ppt_dev) {
+				tmp->stat_items[PPT_VM_STAT_ALERT_IRQ]++;
+				tmp->stat_items[PPT_VM_STAT_ALERT_H]++;
+				break;
+			}
+		}
+
+		if (ppt_dev) {
+			summary_set = test_and_set_bit(
+				ppt_dev->aisbo ^ be_to_le, ppt_dev->aisb);
+
+			if (!summary_set) {
+				if (kvm_s390_gisa_test_iam_gisc(ppt_dev->kvm,
+					PCI_ISC)) {
+					schedule_work(
+						&ppt_dev->ppt_vm->irq_work);
+				} else {
+					kvm_s390_gisa_set_ipm_gisc(
+						ppt_dev->kvm, PCI_ISC);
+				}
+			}
+
+		}
+		spin_unlock(&ppt_vm_list_lock);
+	}
+}
+
+static void ppt_walk_gib(void)
+{
+	struct kvm_s390_gisa_f1 *gisa, *next_gisa, *prev_gisa;
+
+	gisa = (struct kvm_s390_gisa_f1 *)(unsigned long)ppt_gib_get_alo();
+	prev_gisa = NULL;
+
+	while (gisa) {
+		next_gisa = (struct kvm_s390_gisa_f1 *)
+			    (unsigned long)__kvm_s390_gisa_get_next_alert(
+			    (union kvm_s390_gisa *)gisa);
+		while (next_gisa) {
+			prev_gisa = gisa;
+			gisa = (struct kvm_s390_gisa_f1 *)(unsigned long)
+				__kvm_s390_gisa_get_next_alert(
+				(union kvm_s390_gisa *)prev_gisa);
+			next_gisa = (struct kvm_s390_gisa_f1 *)(unsigned long)
+				__kvm_s390_gisa_get_next_alert(
+				(union kvm_s390_gisa *)gisa);
+		}
+
+		ppt_process_gisa(gisa);
+		__kvm_s390_gisa_set_next_alert((union kvm_s390_gisa *)gisa,
+					       (u32)(unsigned long)gisa);
+
+		if (prev_gisa)
+			__kvm_s390_gisa_set_next_alert(
+				(union kvm_s390_gisa *)prev_gisa, 0);
+		else {
+			ppt_gib_set_alo(0);
+			break;
+		}
+	}
+}
+
+static void ppt_alert_irq_handler(struct airq_struct *airq)
+{
+	if (S390_lowcore.subchannel_nr & PPT_AIRQ_HOST_ERROR) {
+		PPT_MESSAGE(PPT_TRACE_NORMAL,
+			"error irq id 0x%x nr 0x%x parm 0x%x word 0x%x\n",
+			S390_lowcore.subchannel_id, S390_lowcore.subchannel_nr,
+			S390_lowcore.io_int_parm, S390_lowcore.io_int_word);
+		PPT_MESSAGE(PPT_TRACE_NORMAL,
+			"gib alo 0x%x faisb 0x%lx\n",
+			ppt_gib_get_alo(),
+			*faisb_iv->vector);
+		/* we do not turn on irq again so the forwarding is dead
+		 * from now on*/
+		return;
+	}
+
+	if (S390_lowcore.subchannel_nr & PPT_AIRQ_HOST_FORWARD) {
+		ppt_process_faisb();
+		zpci_set_irq_ctrl(1, NULL, PCIPT_ISC);
+		return;
+	}
+
+	/* handle the alert list */
+	ppt_walk_gib();
+	zpci_set_irq_ctrl(1, NULL, PCIPT_ISC);
+	ppt_walk_gib();
+}
+
+static struct ppt_dev *kvm_find_assigned_ppt(struct list_head *head,
+					     int assigned_dev_id)
+{
+	struct ppt_dev *tmp;
+
+	list_for_each_entry(tmp, head, entry) {
+		if (tmp->dev_id == assigned_dev_id)
+			return tmp;
+	}
+
+	return NULL;
+}
+
+static const char *const ppt_driver_whitelist[] = { "pci-stub" };
+
+static bool ppt_whitelisted_driver(struct device_driver *drv)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(ppt_driver_whitelist); i++) {
+		if (!strcmp(drv->name, ppt_driver_whitelist[i]))
+			return true;
+	}
+
+	return false;
+}
+
+int kvm_s390_ioctrl_assign_pci(struct kvm *kvm,
+			       struct kvm_assigned_pci_dev *assigned_dev)
+{
+	struct ppt_dev *ppt_dev = NULL;
+	struct pci_dev *dev;
+	struct ppt_vm_entry *tmp;
+	struct device_driver *drv;
+	int rc = 0;
+	char ppt_dev_name[DBF_NAME_LEN];
+	unsigned long flags;
+
+	if (kvm_s390_gisa_get_fmt() != KVM_S390_GISA_FORMAT_1) {
+		PPT_MESSAGE(PPT_TRACE_NORMAL, "GISA format not support\n");
+		rc = -EINVAL;
+		goto out;
+	}
+
+	spin_lock_irqsave(&ppt_vm_list_lock, flags);
+	list_for_each_entry(tmp, &ppt_vm_list, entry) {
+		ppt_dev = kvm_find_assigned_ppt(&tmp->kvm->arch.ppt_dev_list,
+			assigned_dev->assigned_dev_id);
+		if (ppt_dev)
+			break;
+	}
+	spin_unlock_irqrestore(&ppt_vm_list_lock, flags);
+	if (ppt_dev) {
+		rc = -EEXIST;
+		goto out;
+	}
+
+	dev = pci_get_domain_bus_and_slot(assigned_dev->segnr,
+		assigned_dev->busnr, assigned_dev->devfn);
+	if (!dev) {
+		PPT_MESSAGE(PPT_TRACE_NORMAL, "assign no pci dev\n");
+		rc = -EINVAL;
+		goto out;
+	}
+
+	if (dev->hdr_type != PCI_HEADER_TYPE_NORMAL) {
+		PPT_MESSAGE(PPT_TRACE_NORMAL, "device type not support\n");
+		rc = -EINVAL;
+		goto out;
+	}
+
+	drv = ACCESS_ONCE(dev->dev.driver);
+	if (drv && !ppt_whitelisted_driver(drv)) {
+		PPT_MESSAGE(PPT_TRACE_NORMAL,
+			"device has been bound to a driver not allowed\n");
+		rc = -EBUSY;
+		goto out;
+	}
+
+	ppt_dev = ppt_alloc_dev();
+	if (IS_ERR(ppt_dev)) {
+		PPT_MESSAGE(PPT_TRACE_NORMAL, "could not allocate memory\n");
+		rc = PTR_ERR(ppt_dev);
+		goto out_put;
+	}
+	ppt_dev->zdev = (struct zpci_dev *)dev->sysdata;
+	ppt_dev->pdev = dev;
+	ppt_dev->kvm = kvm;
+	ppt_dev->dev_id = assigned_dev->assigned_dev_id;
+
+	sprintf(ppt_dev_name, "ppt_dev_%x", ppt_dev->zdev->fid);
+	ppt_dev->debug = ppt_get_dbf_entry(ppt_dev_name);
+	if (!ppt_dev->debug) {
+		rc = ppt_add_dbf_entry(ppt_dev, ppt_dev_name);
+		if (rc) {
+			PPT_MESSAGE(PPT_TRACE_NORMAL, "add dbf failed\n");
+			goto out_free;
+		}
+	}
+
+	ppt_dev_debugfs_stats_init(ppt_dev);
+
+	PPT_DEVICE_MESSAGE(ppt_dev, PPT_TRACE_NORMAL, "assigned\n");
+
+	rc = zpci_disable_device(ppt_dev->zdev);
+	if (rc) {
+		PPT_MESSAGE(PPT_TRACE_NORMAL, "could not disable device\n");
+		goto out_free;
+	}
+
+	ppt_dev->ppt_vm = ppt_register_vm(ppt_dev->kvm);
+	if (IS_ERR(ppt_dev->ppt_vm)) {
+		PPT_MESSAGE(PPT_TRACE_NORMAL, "register vm failed\n");
+		rc = PTR_ERR(ppt_dev->ppt_vm);
+		goto out_free;
+	}
+
+	if (assigned_dev->flags & ASSIGN_FLAG_HOSTIRQ) {
+		PPT_DEVICE_MESSAGE(ppt_dev, PPT_TRACE_NORMAL,
+			"config hostirq\n");
+		ppt_dev->hostirq = 1;
+	}
+
+	mutex_lock(&kvm->lock);
+	list_add_tail(&ppt_dev->entry, &kvm->arch.ppt_dev_list);
+	mutex_unlock(&kvm->lock);
+
+	PPT_DEVICE_MESSAGE(ppt_dev, PPT_TRACE_NORMAL,
+		"assign fh 0x%x\n", ppt_dev->zdev->fh);
+	return rc;
+out_free:
+	kfree(ppt_dev);
+out_put:
+	pci_dev_put(dev);
+out:
+	return rc;
+}
+
+int kvm_s390_ioctrl_deassign_pci(struct kvm *kvm,
+				 struct kvm_assigned_pci_dev *assigned_dev)
+{
+	int rc = 0;
+	struct ppt_dev *ppt_dev = ppt_get_by_devid(kvm,
+		assigned_dev->assigned_dev_id);
+
+	if (ppt_dev) {
+		PPT_DEVICE_MESSAGE(ppt_dev, PPT_TRACE_NORMAL,
+			"deassign fh 0x%x\n", ppt_dev->zdev->fh);
+		mutex_lock(&kvm->lock);
+		list_del(&ppt_dev->entry);
+		mutex_unlock(&kvm->lock);
+		/* for the ppt_get_by_devid */
+		ppt_put_dev(ppt_dev);
+		/* to free the device */
+		ppt_put_dev(ppt_dev);
+	} else {
+		PPT_MESSAGE(PPT_TRACE_NORMAL,
+			"deassign no dev with id 0x%x\n",
+			assigned_dev->assigned_dev_id);
+		rc = -ENODEV;
+	}
+	return rc;
+}
+
+void s390_pci_cleanup(struct kvm *kvm)
+{
+	struct list_head *ptr, *ptr2;
+	struct ppt_dev *ppt_dev;
+
+	list_for_each_safe(ptr, ptr2, &kvm->arch.ppt_dev_list) {
+		ppt_dev = list_entry(ptr, struct ppt_dev, entry);
+		list_del(&ppt_dev->entry);
+		ppt_put_dev(ppt_dev);
+	}
+}
+
+int s390_pci_init(void)
+{
+	int rc = 0;
+	struct kvm_s390_aifte *aifte;
+
+	if (!test_facility(2) || !test_facility(69)
+	    || !test_facility(71) || !test_facility(72))
+		return 0;
+
+	rc = ppt_register_dbf_views();
+	if (rc) {
+		pr_err("failed to register dbf views rc %d\n", rc);
+		goto out;
+	}
+
+	rc = register_adapter_interrupt(&ppt_airq);
+	if (rc) {
+		pr_err("failed to register airq isc %d rc %d\n", PCIPT_ISC, rc);
+		goto out_airq;
+	}
+
+	*ppt_airq.lsi_ptr = 1;
+
+	faisb_iv = airq_iv_create(CONFIG_PCI_NR_FUNCTIONS, AIRQ_IV_ALLOC);
+	if (!faisb_iv) {
+		rc = -ENOMEM;
+		goto out_iv;
+	}
+
+	gait = (struct kvm_s390_gait *)get_zeroed_page(
+		GFP_KERNEL | GFP_DMA);
+
+	aifte = (struct kvm_s390_aifte *)get_zeroed_page(
+		GFP_KERNEL | GFP_DMA);
+
+	gib = (struct kvm_s390_gib *)get_zeroed_page(
+		GFP_KERNEL | GFP_DMA);
+
+	if (!gait || !aifte || !gib) {
+		rc = -ENOMEM;
+		goto out_nomem;
+	}
+
+	aifte->faisba = (unsigned long)faisb_iv->vector;
+	aifte->gaita = (u64)gait;
+	aifte->afi = PCIPT_ISC;
+	aifte->faal = CONFIG_PCI_NR_FUNCTIONS;
+
+	rc = chsc_sgib((u32)(unsigned long)gib);
+	if (rc) {
+		pr_err("set gib failed rc %d\n", rc);
+		goto out_gib;
+	}
+
+	zpci_set_irq_ctrl(2, (char *)aifte, PCIPT_ISC);
+
+	zpci_set_irq_ctrl(1, NULL, PCIPT_ISC);
+	free_page((unsigned long)aifte);
+
+	PPT_MESSAGE(PPT_TRACE_NORMAL,
+		"faisba 0x%lx gait 0x%lx gib 0x%lx isc: %d\n",
+		(unsigned long)faisb_iv->vector, (unsigned long)gait,
+		(unsigned long)gib, PCIPT_ISC);
+
+	ppt_stats_debugfs_root = debugfs_create_dir("ppt", NULL);
+	if (IS_ERR(ppt_stats_debugfs_root))
+		ppt_stats_debugfs_root = NULL;
+
+	return 0;
+out_gib:
+out_nomem:
+	airq_iv_release(faisb_iv);
+	free_page((unsigned long)gait);
+	free_page((unsigned long)aifte);
+	free_page((unsigned long)gib);
+out_iv:
+	unregister_adapter_interrupt(&ppt_airq);
+out_airq:
+	ppt_unregister_dbf_views();
+out:
+	return rc;
+}
+
+void s390_pci_exit(void)
+{
+	int rc;
+	struct kvm_s390_aifte *aifte;
+
+	if (!test_facility(2) || !test_facility(69)
+	    || !test_facility(71) || !test_facility(72))
+		return;
+
+	if (faisb_iv)
+		airq_iv_release(faisb_iv);
+
+	unregister_adapter_interrupt(&ppt_airq);
+
+	aifte = (struct kvm_s390_aifte *)get_zeroed_page(
+		GFP_KERNEL | GFP_DMA);
+	if (!aifte)
+		pr_err("failed to get page for aifte\n");
+	else
+		zpci_set_irq_ctrl(2, (char *)aifte, PCIPT_ISC);
+
+	rc = chsc_sgib(0);
+	if (rc)
+		pr_err("reset gib failed rc %d\n", rc);
+
+	free_page((unsigned long)aifte);
+	free_page((unsigned long)gait);
+	free_page((unsigned long)gib);
+
+	ppt_unregister_dbf_views();
+	ppt_clear_dbf_list();
+
+	debugfs_remove(ppt_stats_debugfs_root);
+}
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -753,6 +753,10 @@ static const intercept_handler_t b9_hand
 	[0x8f] = handle_ipte_interlock,
 	[0xab] = handle_essa,
 	[0xaf] = handle_pfmf,
+	[0xa0] = handle_clp,
+	[0xd0] = handle_pcistg,
+	[0xd2] = handle_pcilg,
+	[0xd3] = handle_rpcit,
 };
 
 int kvm_s390_handle_b9(struct kvm_vcpu *vcpu)
@@ -912,9 +916,26 @@ static int handle_stctg(struct kvm_vcpu
 	return 0;
 }
 
+static const intercept_handler_t e3_handlers[256] = {
+	[0xd0] = handle_mpcifc,
+	[0xd4] = handle_stpcifc,
+};
+
+int kvm_s390_handle_e3(struct kvm_vcpu *vcpu)
+{
+	intercept_handler_t handler;
+
+	handler = e3_handlers[vcpu->arch.sie_block->ipb & 0xff];
+	if (handler)
+		return handler(vcpu);
+	return -EOPNOTSUPP;
+}
+
 static const intercept_handler_t eb_handlers[256] = {
 	[0x2f] = handle_lctlg,
 	[0x25] = handle_stctg,
+	[0xd0] = handle_pcistb,
+	[0xd1] = handle_sic,
 };
 
 int kvm_s390_handle_eb(struct kvm_vcpu *vcpu)
