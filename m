From: frank.blaschka@de.ibm.com
Subject: [RFC][patch 2/6] s390: pci: export pci functions for pass-through usage
Date: Thu, 04 Sep 2014 12:52:25 +0200
Message-ID: <20140904105336.972650600@de.ibm.com>
References: <20140904105223.336503578@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline; filename=003-s390_pci_ppt-3.16.patch
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: qemu-devel@nongnu.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org
Cc: aik@ozlabs.ru, pbonzini@redhat.com, agraf@suse.de
List-ID: <linux-s390.vger.kernel.org>

From: Frank Blaschka <frank.blaschka@de.ibm.com>

This patch exports a couple of zPCI functions. The new pci
pass-through driver for KVM will use this functions to enable the
device with virtualization information and update the device dma
translation table on the host. We add a new interface to purge
the translation table of a device. Also we moved some zPCI functions
to the pci_insn header file.

Signed-off-by: Frank Blaschka <frank.blaschka@de.ibm.com>
---
 arch/s390/include/asm/pci.h      |    6 ++
 arch/s390/include/asm/pci_clp.h  |    3 -
 arch/s390/include/asm/pci_insn.h |   92 ++++++++++++++++++++++++++++++++++++
 arch/s390/pci/pci_clp.c          |    4 +
 arch/s390/pci/pci_dma.c          |   24 ++++++++-
 arch/s390/pci/pci_insn.c         |   97 ---------------------------------------
 6 files changed, 126 insertions(+), 100 deletions(-)

--- a/arch/s390/include/asm/pci.h
+++ b/arch/s390/include/asm/pci.h
@@ -140,6 +140,7 @@ int zpci_register_ioat(struct zpci_dev *
 int zpci_unregister_ioat(struct zpci_dev *, u8);
 
 /* CLP */
+u8 clp_instr(void *data);
 int clp_scan_pci_devices(void);
 int clp_rescan_pci_devices(void);
 int clp_rescan_pci_devices_simple(void);
@@ -177,6 +178,11 @@ struct zpci_dev *get_zdev_by_fid(u32);
 /* DMA */
 int zpci_dma_init(void);
 void zpci_dma_exit(void);
+int dma_update_trans(struct zpci_dev *zdev, unsigned long pa,
+		     dma_addr_t dma_addr, size_t size, int flags);
+void dma_update_cpu_trans(struct zpci_dev *zdev, void *page_addr,
+			  dma_addr_t dma_addr, int flags);
+void dma_purge_rto_entries(struct zpci_dev *zdev);
 
 /* FMB */
 int zpci_fmb_enable_device(struct zpci_dev *);
--- a/arch/s390/include/asm/pci_clp.h
+++ b/arch/s390/include/asm/pci_clp.h
@@ -148,7 +148,8 @@ struct clp_req_set_pci {
 	u16 reserved2;
 	u8 oc;				/* operation controls */
 	u8 ndas;			/* number of dma spaces */
-	u64 reserved3;
+	u32 reserved3;
+	u32 gd;				/* GISA Designation */
 } __packed;
 
 /* Set PCI function response */
--- a/arch/s390/include/asm/pci_insn.h
+++ b/arch/s390/include/asm/pci_insn.h
@@ -1,6 +1,8 @@
 #ifndef _ASM_S390_PCI_INSN_H
 #define _ASM_S390_PCI_INSN_H
 
+#include <asm/processor.h>
+
 /* Load/Store status codes */
 #define ZPCI_PCI_ST_FUNC_NOT_ENABLED		4
 #define ZPCI_PCI_ST_FUNC_IN_ERR			8
@@ -83,4 +85,94 @@ int zpci_store(u64 data, u64 req, u64 of
 int zpci_store_block(const u64 *data, u64 req, u64 offset);
 void zpci_set_irq_ctrl(u16 ctl, char *unused, u8 isc);
 
+static inline u8 __mpcifc(u64 req, struct zpci_fib *fib, u8 *status)
+{
+	u8 cc;
+
+	asm volatile (
+		"	.insn	rxy,0xe300000000d0,%[req],%[fib]\n"
+		"	ipm	%[cc]\n"
+		"	srl	%[cc],28\n"
+		: [cc] "=d" (cc), [req] "+d" (req), [fib] "+Q" (*fib)
+		: : "cc");
+	*status = req >> 24 & 0xff;
+	return cc;
+}
+
+static inline u8 __rpcit(u64 fn, u64 addr, u64 range, u8 *status)
+{
+	register u64 __addr asm("2") = addr;
+	register u64 __range asm("3") = range;
+	u8 cc;
+
+	asm volatile (
+		"	.insn	rre,0xb9d30000,%[fn],%[addr]\n"
+		"	ipm	%[cc]\n"
+		"	srl	%[cc],28\n"
+		: [cc] "=d" (cc), [fn] "+d" (fn)
+		: [addr] "d" (__addr), "d" (__range)
+		: "cc");
+	*status = fn >> 24 & 0xff;
+	return cc;
+}
+
+static inline int __pcilg(u64 *data, u64 req, u64 offset, u8 *status)
+{
+	register u64 __req asm("2") = req;
+	register u64 __offset asm("3") = offset;
+	int cc = -ENXIO;
+	u64 __data;
+
+	asm volatile (
+		"	.insn	rre,0xb9d20000,%[data],%[req]\n"
+		"0:	ipm	%[cc]\n"
+		"	srl	%[cc],28\n"
+		"1:\n"
+		EX_TABLE(0b, 1b)
+		: [cc] "+d" (cc), [data] "=d" (__data), [req] "+d" (__req)
+		:  "d" (__offset)
+		: "cc");
+	*status = __req >> 24 & 0xff;
+	if (!cc)
+		*data = __data;
+
+	return cc;
+}
+
+static inline int __pcistg(u64 data, u64 req, u64 offset, u8 *status)
+{
+	register u64 __req asm("2") = req;
+	register u64 __offset asm("3") = offset;
+	int cc = -ENXIO;
+
+	asm volatile (
+		"	.insn	rre,0xb9d00000,%[data],%[req]\n"
+		"0:	ipm	%[cc]\n"
+		"	srl	%[cc],28\n"
+		"1:\n"
+		EX_TABLE(0b, 1b)
+		: [cc] "+d" (cc), [req] "+d" (__req)
+		: "d" (__offset), [data] "d" (data)
+		: "cc");
+	*status = __req >> 24 & 0xff;
+	return cc;
+}
+
+static inline int __pcistb(const u64 *data, u64 req, u64 offset, u8 *status)
+{
+	int cc = -ENXIO;
+
+	asm volatile (
+		"	.insn	rsy,0xeb00000000d0,%[req],%[offset],%[data]\n"
+		"0:	ipm	%[cc]\n"
+		"	srl	%[cc],28\n"
+		"1:\n"
+		EX_TABLE(0b, 1b)
+		: [cc] "+d" (cc), [req] "+d" (req)
+		: [offset] "d" (offset), [data] "Q" (*data)
+		: "cc");
+	*status = req >> 24 & 0xff;
+	return cc;
+}
+
 #endif
--- a/arch/s390/pci/pci_clp.c
+++ b/arch/s390/pci/pci_clp.c
@@ -30,7 +30,7 @@ static inline void zpci_err_clp(unsigned
  * Call Logical Processor
  * Retry logic is handled by the caller.
  */
-static inline u8 clp_instr(void *data)
+u8 clp_instr(void *data)
 {
 	struct { u8 _[CLP_BLK_SIZE]; } *req = data;
 	u64 ignored;
@@ -45,6 +45,7 @@ static inline u8 clp_instr(void *data)
 		: "cc");
 	return cc;
 }
+EXPORT_SYMBOL_GPL(clp_instr);
 
 static void *clp_alloc_block(gfp_t gfp_mask)
 {
@@ -263,6 +264,7 @@ int clp_disable_fh(struct zpci_dev *zdev
 	zpci_dbg(3, "dis fid:%x, fh:%x, rc:%d\n", zdev->fid, zdev->fh, rc);
 	return rc;
 }
+EXPORT_SYMBOL_GPL(clp_disable_fh);
 
 static int clp_list_pci(struct clp_req_rsp_list_pci *rrb,
 			void (*cb)(struct clp_fh_list_entry *entry))
--- a/arch/s390/pci/pci_dma.c
+++ b/arch/s390/pci/pci_dma.c
@@ -114,7 +114,7 @@ static unsigned long *dma_walk_cpu_trans
 	return &pto[px];
 }
 
-static void dma_update_cpu_trans(struct zpci_dev *zdev, void *page_addr,
+void dma_update_cpu_trans(struct zpci_dev *zdev, void *page_addr,
 				 dma_addr_t dma_addr, int flags)
 {
 	unsigned long *entry;
@@ -138,8 +138,9 @@ static void dma_update_cpu_trans(struct
 	else
 		entry_clr_protected(entry);
 }
+EXPORT_SYMBOL_GPL(dma_update_cpu_trans);
 
-static int dma_update_trans(struct zpci_dev *zdev, unsigned long pa,
+int dma_update_trans(struct zpci_dev *zdev, unsigned long pa,
 			    dma_addr_t dma_addr, size_t size, int flags)
 {
 	unsigned int nr_pages = PAGE_ALIGN(size) >> PAGE_SHIFT;
@@ -180,6 +181,7 @@ no_refresh:
 	spin_unlock_irqrestore(&zdev->dma_table_lock, irq_flags);
 	return rc;
 }
+EXPORT_SYMBOL_GPL(dma_update_trans);
 
 static void dma_free_seg_table(unsigned long entry)
 {
@@ -457,6 +459,7 @@ out_reg:
 out_clean:
 	return rc;
 }
+EXPORT_SYMBOL_GPL(zpci_dma_init_device);
 
 void zpci_dma_exit_device(struct zpci_dev *zdev)
 {
@@ -466,6 +469,7 @@ void zpci_dma_exit_device(struct zpci_de
 	zdev->iommu_bitmap = NULL;
 	zdev->next_bit = 0;
 }
+EXPORT_SYMBOL_GPL(zpci_dma_exit_device);
 
 static int __init dma_alloc_cpu_table_caches(void)
 {
@@ -518,6 +522,22 @@ struct dma_map_ops s390_dma_ops = {
 };
 EXPORT_SYMBOL_GPL(s390_dma_ops);
 
+void dma_purge_rto_entries(struct zpci_dev *zdev)
+{
+	unsigned long *table;
+	int rtx;
+
+	if (!zdev || !zdev->dma_table)
+		return;
+	table = zdev->dma_table;
+	for (rtx = 0; rtx < ZPCI_TABLE_ENTRIES; rtx++)
+		if (reg_entry_isvalid(table[rtx])) {
+			dma_free_seg_table(table[rtx]);
+			invalidate_table_entry(&table[rtx]);
+		}
+}
+EXPORT_SYMBOL_GPL(dma_purge_rto_entries);
+
 static int __init s390_iommu_setup(char *str)
 {
 	if (!strncmp(str, "strict", 6))
--- a/arch/s390/pci/pci_insn.c
+++ b/arch/s390/pci/pci_insn.c
@@ -8,25 +8,9 @@
 #include <linux/errno.h>
 #include <linux/delay.h>
 #include <asm/pci_insn.h>
-#include <asm/processor.h>
 
 #define ZPCI_INSN_BUSY_DELAY	1	/* 1 microsecond */
 
-/* Modify PCI Function Controls */
-static inline u8 __mpcifc(u64 req, struct zpci_fib *fib, u8 *status)
-{
-	u8 cc;
-
-	asm volatile (
-		"	.insn	rxy,0xe300000000d0,%[req],%[fib]\n"
-		"	ipm	%[cc]\n"
-		"	srl	%[cc],28\n"
-		: [cc] "=d" (cc), [req] "+d" (req), [fib] "+Q" (*fib)
-		: : "cc");
-	*status = req >> 24 & 0xff;
-	return cc;
-}
-
 int zpci_mod_fc(u64 req, struct zpci_fib *fib)
 {
 	u8 cc, status;
@@ -43,24 +27,6 @@ int zpci_mod_fc(u64 req, struct zpci_fib
 	return (cc) ? -EIO : 0;
 }
 
-/* Refresh PCI Translations */
-static inline u8 __rpcit(u64 fn, u64 addr, u64 range, u8 *status)
-{
-	register u64 __addr asm("2") = addr;
-	register u64 __range asm("3") = range;
-	u8 cc;
-
-	asm volatile (
-		"	.insn	rre,0xb9d30000,%[fn],%[addr]\n"
-		"	ipm	%[cc]\n"
-		"	srl	%[cc],28\n"
-		: [cc] "=d" (cc), [fn] "+d" (fn)
-		: [addr] "d" (__addr), "d" (__range)
-		: "cc");
-	*status = fn >> 24 & 0xff;
-	return cc;
-}
-
 int zpci_refresh_trans(u64 fn, u64 addr, u64 range)
 {
 	u8 cc, status;
@@ -84,30 +50,7 @@ void zpci_set_irq_ctrl(u16 ctl, char *un
 		"	.insn	rsy,0xeb00000000d1,%[ctl],%[isc],%[u]\n"
 		: : [ctl] "d" (ctl), [isc] "d" (isc << 27), [u] "Q" (*unused));
 }
-
-/* PCI Load */
-static inline int __pcilg(u64 *data, u64 req, u64 offset, u8 *status)
-{
-	register u64 __req asm("2") = req;
-	register u64 __offset asm("3") = offset;
-	int cc = -ENXIO;
-	u64 __data;
-
-	asm volatile (
-		"	.insn	rre,0xb9d20000,%[data],%[req]\n"
-		"0:	ipm	%[cc]\n"
-		"	srl	%[cc],28\n"
-		"1:\n"
-		EX_TABLE(0b, 1b)
-		: [cc] "+d" (cc), [data] "=d" (__data), [req] "+d" (__req)
-		:  "d" (__offset)
-		: "cc");
-	*status = __req >> 24 & 0xff;
-	if (!cc)
-		*data = __data;
-
-	return cc;
-}
+EXPORT_SYMBOL_GPL(zpci_set_irq_ctrl);
 
 int zpci_load(u64 *data, u64 req, u64 offset)
 {
@@ -127,26 +70,6 @@ int zpci_load(u64 *data, u64 req, u64 of
 }
 EXPORT_SYMBOL_GPL(zpci_load);
 
-/* PCI Store */
-static inline int __pcistg(u64 data, u64 req, u64 offset, u8 *status)
-{
-	register u64 __req asm("2") = req;
-	register u64 __offset asm("3") = offset;
-	int cc = -ENXIO;
-
-	asm volatile (
-		"	.insn	rre,0xb9d00000,%[data],%[req]\n"
-		"0:	ipm	%[cc]\n"
-		"	srl	%[cc],28\n"
-		"1:\n"
-		EX_TABLE(0b, 1b)
-		: [cc] "+d" (cc), [req] "+d" (__req)
-		: "d" (__offset), [data] "d" (data)
-		: "cc");
-	*status = __req >> 24 & 0xff;
-	return cc;
-}
-
 int zpci_store(u64 data, u64 req, u64 offset)
 {
 	u8 status;
@@ -165,24 +88,6 @@ int zpci_store(u64 data, u64 req, u64 of
 }
 EXPORT_SYMBOL_GPL(zpci_store);
 
-/* PCI Store Block */
-static inline int __pcistb(const u64 *data, u64 req, u64 offset, u8 *status)
-{
-	int cc = -ENXIO;
-
-	asm volatile (
-		"	.insn	rsy,0xeb00000000d0,%[req],%[offset],%[data]\n"
-		"0:	ipm	%[cc]\n"
-		"	srl	%[cc],28\n"
-		"1:\n"
-		EX_TABLE(0b, 1b)
-		: [cc] "+d" (cc), [req] "+d" (req)
-		: [offset] "d" (offset), [data] "Q" (*data)
-		: "cc");
-	*status = req >> 24 & 0xff;
-	return cc;
-}
-
 int zpci_store_block(const u64 *data, u64 req, u64 offset)
 {
 	u8 status;
