From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Subject: [PATCH RFC 7/8] vfio: ccw: introduce ccw chain interfaces
Date: Fri, 29 Apr 2016 14:11:54 +0200
Message-ID: <1461931915-22397-8-git-send-email-bjsdjshi@linux.vnet.ibm.com>
References: <1461931915-22397-1-git-send-email-bjsdjshi@linux.vnet.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1461931915-22397-1-git-send-email-bjsdjshi@linux.vnet.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org
Cc: bjsdjshi@linux.vnet.ibm.com, renxiaof@linux.vnet.ibm.com, cornelia.huck@de.ibm.com, borntraeger@de.ibm.com, agraf@suse.com, alex.williamson@redhat.com
List-ID: <linux-s390.vger.kernel.org>

Introduce ccwchain structure and helper functions that can be used to
handle special ccw programs issued from user-space.

The following limitations apply:
1. Supports only prefetch enabled mode.
2. Supports direct ccw chaining by translating them to idal ccws.
3. Supports idal(c64) ccw chaining.

These interfaces are designed to support translation only for special
ccw programs, which are generated and formatted by a user-space
program. Thus this will make it possible for VFIO to leverage the
interfaces to realize channel I/O device drivers in user-space.

User-space programs should prepare the ccws according to the rules
below:
1. Allocate a 4K memory buffer in user-space to store all of the ccw
   program information.
2. Lower 2k of the buffer are used to store a maximum of 256 ccws.
3. Upper 2k of the buffer are used to store a maximum of 256
   corresponding cda data sets, each having a length of 8 bytes.
4. All of the ccws should be placed one after another.
5. For direct and idal ccw:
   - Find a free cda data entry, and find its offset to the address
     of the cda buffer.
   - Store the offset as the CDA value in the ccw.
   - Store the user virtual address of the data (idaw) as the data of
     the cda entry.
6. For tic ccw:
   - Find the target ccw, and find its offset to the address of the
     ccw buffer.
   - Store the offset as the CDA value in the ccw.

Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Reviewed-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
---
 drivers/vfio/ccw/ccwchain.c | 441 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/vfio/ccw/ccwchain.h |  49 +++++
 2 files changed, 490 insertions(+)
 create mode 100644 drivers/vfio/ccw/ccwchain.h

diff --git a/drivers/vfio/ccw/ccwchain.c b/drivers/vfio/ccw/ccwchain.c
index 03b4e82..964b6479 100644
--- a/drivers/vfio/ccw/ccwchain.c
+++ b/drivers/vfio/ccw/ccwchain.c
@@ -11,8 +11,19 @@
  *            Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>
  */
 
+#include <asm/ccwdev.h>
+#include <asm/idals.h>
+#include <linux/io.h>
 #include <linux/mm.h>
 #include <linux/slab.h>
+#include "ccwchain.h"
+
+/*
+ * Max length for ccw chain.
+ * XXX: Limit to 256, need to check more?
+ */
+#define CCWCHAIN_LEN_MAX	256
+#define CDA_ITEM_SIZE		3 /* sizeof(u64) == (1 << 3) */
 
 struct page_array {
 	u64			hva;
@@ -25,6 +36,20 @@ struct page_arrays {
 	int			nr;
 };
 
+struct ccwchain_buf {
+	struct ccw1		ccw[CCWCHAIN_LEN_MAX];
+	u64			cda[CCWCHAIN_LEN_MAX];
+};
+
+struct ccwchain {
+	struct ccwchain_buf	buf;
+
+	/* Valid ccw number in chain */
+	int			nr;
+	/* Pinned PAGEs for the original data. */
+	struct page_arrays	*pss;
+};
+
 /*
  * Helpers to operate page_array.
  */
@@ -126,3 +151,419 @@ static void page_arrays_unpin_free(struct page_arrays *ps)
 	ps->parray = NULL;
 	ps->nr = 0;
 }
+
+/*
+ * Helpers to operate ccwchain.
+ */
+/* Return the number of idal words needed for an address/length pair. */
+static inline unsigned int ccwchain_idal_nr_words(u64 addr, unsigned int length)
+{
+	/*
+	 * User virtual address and its corresponding kernel physical address
+	 * are aligned by pages. Thus their offsets to the page boundary will be
+	 * the same.
+	 * Althought idal_nr_words expects a virtual address as its first param,
+	 * it is the offset that matters. It's fine to use either hva or hpa as
+	 * the input, since they have the same offset inside a page.
+	 */
+	return idal_nr_words((void *)(addr), length);
+}
+
+/* Create the list idal words for a page_arrays. */
+static inline void ccwchain_idal_create_words(unsigned long *idaws,
+					      struct page_arrays *ps)
+{
+	int i, j, k;
+
+	/*
+	 * Idal words (execept the first one) rely on the memory being 4k
+	 * aligned. If a user virtual address is 4K aligned, then it's
+	 * corresponding kernel physical address will also be 4K aligned. Thus
+	 * there will be no problem here to simply use the hpa to create an
+	 * idaw.
+	 */
+	k = 0;
+	for (i = 0; i < ps->nr; i++)
+		for (j = 0; j < ps->parray[i].nr; j++) {
+			idaws[k] = page_to_phys(ps->parray[i].items[j]);
+			if (k == 0)
+				idaws[k] += ps->parray[i].hva & ~PAGE_MASK;
+			k++;
+		}
+}
+
+#define ccw_is_test(_ccw) (((_ccw)->cmd_code & 0x0F) == 0)
+
+#define ccw_is_noop(_ccw) ((_ccw)->cmd_code == CCW_CMD_NOOP)
+
+#define ccw_is_tic(_ccw) ((_ccw)->cmd_code == CCW_CMD_TIC)
+
+#define ccw_is_idal(_ccw) ((_ccw)->flags & CCW_FLAG_IDA)
+
+/* Free resource for a ccw that allocated memory for its cda. */
+static void ccw_chain_cda_free(struct ccwchain *chain, int idx)
+{
+	struct ccw1 *ccw = chain->buf.ccw + idx;
+
+	if (!ccw->count)
+		return;
+
+	kfree((void *)(u64)ccw->cda);
+}
+
+/* Unpin the pages then free the memory resources. */
+static void ccw_chain_unpin_free(struct ccwchain *chain)
+{
+	int i;
+
+	if (!chain)
+		return;
+
+	for (i = 0; i < chain->nr; i++) {
+		page_arrays_unpin_free(chain->pss + i);
+		ccw_chain_cda_free(chain, i);
+	}
+
+	kfree(chain->pss);
+	kfree(chain);
+}
+
+static int ccw_chain_fetch_tic(struct ccwchain *chain, int idx)
+{
+	struct ccw1 *ccw = chain->buf.ccw + idx;
+
+	if (ccw->cda >= sizeof(chain->buf.ccw))
+		return -EINVAL;
+
+	/*
+	 * tic_ccw.cda stores the offset to the address of the first ccw
+	 * of the chain. Here we update its value with the the real address.
+	 */
+	ccw->cda += virt_to_phys(chain->buf.ccw);
+
+	return 0;
+}
+
+static int ccw_chain_fetch_direct(struct ccwchain *chain, int idx)
+{
+	struct ccw1 *ccw;
+	struct page_arrays *ps;
+	unsigned long *idaws;
+	u64 cda_hva;
+	int i, cidaw;
+
+	ccw = chain->buf.ccw + idx;
+
+	/*
+	 * direct_ccw.cda stores the offset of its cda data in the cda buffer.
+	 */
+	i = ccw->cda >> CDA_ITEM_SIZE;
+	if (i < 0)
+		return -EINVAL;
+	cda_hva = chain->buf.cda[i];
+	if (IS_ERR_VALUE(cda_hva))
+		return -EFAULT;
+
+	/*
+	 * Pin data page(s) in memory.
+	 * The number of pages actually is the count of the idaws which will be
+	 * needed when translating a direct ccw to a idal ccw.
+	 */
+	ps = chain->pss + idx;
+	if (page_arrays_init(ps, 1))
+		return -ENOMEM;
+	cidaw = page_array_items_alloc_pin(cda_hva, ccw->count, ps->parray);
+	if (cidaw <= 0)
+		return cidaw;
+
+	/* Translate this direct ccw to a idal ccw. */
+	idaws = kcalloc(cidaw, sizeof(*idaws), GFP_DMA | GFP_KERNEL);
+	if (!idaws) {
+		page_arrays_unpin_free(ps);
+		return -ENOMEM;
+	}
+	ccw->cda = (__u32) virt_to_phys(idaws);
+	ccw->flags |= CCW_FLAG_IDA;
+
+	ccwchain_idal_create_words(idaws, ps);
+
+	return 0;
+}
+
+static int ccw_chain_fetch_idal(struct ccwchain *chain, int idx)
+{
+	struct ccw1 *ccw;
+	struct page_arrays *ps;
+	unsigned long *idaws;
+	unsigned int cidaw, idaw_len;
+	int i, ret;
+	u64 cda_hva, idaw_hva;
+
+	ccw = chain->buf.ccw + idx;
+
+	/* idal_ccw.cda stores the offset of its cda data in the cda buffer. */
+	i = ccw->cda >> CDA_ITEM_SIZE;
+	if (i < 0)
+		return -EINVAL;
+	cda_hva = chain->buf.cda[i];
+	if (IS_ERR_VALUE(cda_hva))
+		return -EFAULT;
+
+	/* Calculate size of idaws. */
+	ret = copy_from_user(&idaw_hva, (void __user *)cda_hva, sizeof(*idaws));
+	if (ret)
+		return ret;
+
+	cidaw = ccwchain_idal_nr_words(idaw_hva, ccw->count);
+	idaw_len = cidaw * sizeof(*idaws);
+
+	/* Pin data page(s) in memory. */
+	ps = chain->pss + idx;
+	ret = page_arrays_init(ps, cidaw);
+	if (ret)
+		return ret;
+
+	/* Translate idal ccw to use new allocated idaws. */
+	idaws = kzalloc(idaw_len, GFP_DMA | GFP_KERNEL);
+	if (!idaws) {
+		ret = -ENOMEM;
+		goto out_unpin;
+	}
+
+	ret = copy_from_user(idaws, (void __user *)cda_hva, idaw_len);
+	if (ret)
+		goto out_free_idaws;
+
+	ccw->cda = virt_to_phys(idaws);
+
+	for (i = 0; i < cidaw; i++) {
+		idaw_hva = *(idaws + i);
+		if (IS_ERR_VALUE(idaw_hva)) {
+			ret = -EFAULT;
+			goto out_free_idaws;
+		}
+
+		ret = page_array_items_alloc_pin(idaw_hva, 1, ps->parray + i);
+		if (ret <= 0)
+			goto out_free_idaws;
+	}
+
+	ccwchain_idal_create_words(idaws, ps);
+
+	return 0;
+
+out_free_idaws:
+	kfree(idaws);
+out_unpin:
+	page_arrays_unpin_free(ps);
+	return ret;
+}
+
+/*
+ * Fetch one ccw.
+ * To reduce memory copy, we'll pin the cda page in memory,
+ * and to get rid of the cda 2G limitiaion of ccw1, we'll translate
+ * direct ccws to idal ccws.
+ */
+static int ccw_chain_fetch_one(struct ccwchain *chain, int idx)
+{
+	struct ccw1 *ccw = chain->buf.ccw + idx;
+
+	if (ccw_is_test(ccw) || ccw_is_noop(ccw))
+		return 0;
+
+	if (ccw_is_tic(ccw))
+		return ccw_chain_fetch_tic(chain, idx);
+
+	if (ccw_is_idal(ccw))
+		return ccw_chain_fetch_idal(chain, idx);
+
+	return ccw_chain_fetch_direct(chain, idx);
+}
+
+static int ccw_chain_copy_from_user(struct ccwchain_cmd *cmd)
+{
+	struct ccwchain *chain;
+	int ret;
+
+	if (!cmd->nr || cmd->nr > CCWCHAIN_LEN_MAX) {
+		ret = -EINVAL;
+		goto out_error;
+	}
+
+	chain = kzalloc(sizeof(*chain), GFP_DMA | GFP_KERNEL);
+	if (!chain) {
+		ret = -ENOMEM;
+		goto out_error;
+	}
+
+	chain->nr = cmd->nr;
+
+	/* Copy current chain from user. */
+	ret = copy_from_user(&chain->buf,
+			     (void __user *)cmd->u_ccwchain,
+			     sizeof(chain->buf));
+	if (ret)
+		goto out_free_chain;
+
+	/* Alloc memory for page_arrays. */
+	chain->pss = kcalloc(chain->nr, sizeof(*chain->pss), GFP_KERNEL);
+	if (!chain->pss) {
+		ret = -ENOMEM;
+		goto out_free_chain;
+	}
+
+	cmd->k_ccwchain = chain;
+
+	return 0;
+
+out_free_chain:
+	kfree(chain);
+out_error:
+	cmd->k_ccwchain = NULL;
+	return ret;
+}
+
+/**
+ * ccwchain_alloc() - allocate resources for a ccw chain.
+ * @cmd: ccwchain command on which to perform the operation
+ *
+ * This function is a wrapper around ccw_chain_copy_from_user().
+ *
+ * This creates a ccwchain and allocates a memory buffer, that could at most
+ * contain @cmd->nr ccws, for the ccwchain. Then it copies user-space ccw
+ * program from @cmd->u_ccwchain to the buffer, and stores the address of the
+ * ccwchain to @cmd->k_ccwchain as the output.
+ *
+ * Returns:
+ *   %0 on success and a negative error value on failure.
+ */
+int ccwchain_alloc(struct ccwchain_cmd *cmd)
+{
+	return ccw_chain_copy_from_user(cmd);
+}
+
+/**
+ * ccwchain_free() - free resources for a ccw chain.
+ * @cmd: ccwchain command on which to perform the operation
+ *
+ * This function is a wrapper around ccw_chain_unpin_free().
+ *
+ * This unpins the memory pages and frees the memory space occupied by @cmd,
+ * which must have been returned by a previous call to ccwchain_alloc().
+ * Otherwise, undefined behavior occurs.
+ */
+void ccwchain_free(struct ccwchain_cmd *cmd)
+{
+	ccw_chain_unpin_free(cmd->k_ccwchain);
+}
+
+/**
+ * ccwchain_prefetch() - translate a user-space ccw program to a real-device
+ *                       runnable ccw program.
+ * @cmd: ccwchain command on which to perform the operation
+ *
+ * This function translates the user-space ccw program (@cmd->u_ccwchain) and
+ * stores the result to @cmd->k_ccwchain. @cmd must have been returned by a
+ * previous call to ccwchain_alloc(). Otherwise, undefined behavior occurs.
+ *
+ * The S/390 CCW Translation APIS (prefixed by 'ccwchain_') are introduced as
+ * helpers to do ccw chain translation inside the kernel. Basically they accept
+ * a special ccw program issued by a user-space process, and translate the ccw
+ * program to a real-device runnable ccw program.
+ *
+ * The ccws passed in should be well organized in a user-space buffer, using
+ * virtual memory addresses and offsets inside the buffer. These APIs will copy
+ * the ccws into a kernel-space buffer, and update the virtual addresses and the
+ * offsets with their corresponding physical addresses. Then channel I/O device
+ * drivers could issue the translated ccw program to real devices to perform an
+ * I/O operation.
+ *
+ * User-space ccw program format:
+ * These interfaces are designed to support translation only for special ccw
+ * programs, which are generated and formatted by a user-space program. Thus
+ * this will make it possible for things like VFIO to leverage the interfaces to
+ * realize channel I/O device drivers in user-space.
+ *
+ * User-space programs should prepare the ccws according to the rules below
+ * 1. Alloc a 4K bytes memory buffer in user-space to store all of the ccw
+ *    program information.
+ * 2. Lower 2K of the buffer are used to store a maximum of 256 ccws.
+ * 3. Upper 2K of the buffer are used to store a maximum of 256 corresponding
+ *    cda data sets, each having a length of 8 bytes.
+ * 4. All of the ccws should be placed one after another.
+ * 5. For direct and idal ccw
+ *    - Find a free cda data entry, and find its offset to the address of the
+ *      cda buffer.
+ *    - Store the offset as the CDA value in the ccw.
+ *    - Store the virtual address of the data(idaw) as the data of the cda
+ *      entry.
+ * 6. For tic ccw
+ *    - Find the target ccw, and find its offset to the address of the ccw
+ *      buffer.
+ *    - Store the offset as the CDA value in the ccw.
+ *
+ * Limitations:
+ * 1. Supports only prefetch enabled mode.
+ * 2. Supports direct ccw chaining by translating them to idal ccws.
+ * 3. Supports idal(c64) ccw chaining.
+ *
+ * Returns:
+ *   %0 on success and a negative error value on failure.
+ */
+int ccwchain_prefetch(struct ccwchain_cmd *cmd)
+{
+	int ret, i;
+	struct ccwchain *chain = cmd->k_ccwchain;
+
+	for (i = 0; i < chain->nr; i++) {
+		ret = ccw_chain_fetch_one(chain, i);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+/**
+ * ccwchain_get_cpa() - get the ccw program address of a ccwchain
+ * @cmd: ccwchain command on which to perform the operation
+ *
+ * This function returns the address of the translated kernel ccw program.
+ * Channel I/O device drivers could issue this address to real devices to
+ * perform an I/O operation.
+ */
+struct ccw1 *ccwchain_get_cpa(struct ccwchain_cmd *cmd)
+{
+	return ((struct ccwchain *)cmd->k_ccwchain)->buf.ccw;
+}
+
+/**
+ * ccwchain_update_scsw() - update scsw for a ccw chain.
+ * @cmd: ccwchain command on which to perform the operation
+ * @scsw: I/O result of the ccw program and also the target to be updated
+ *
+ * @scsw contains the I/O results of the ccw program that pointed to by @cmd.
+ * However what @scsw->cpa stores is a kernel physical address, which is
+ * meaningless for a user-space program, which is waiting for the I/O results.
+ *
+ * This function updates @scsw->cpa to its coressponding user-space ccw address
+ * (an offset inside the user-space ccw buffer).
+ */
+void ccwchain_update_scsw(struct ccwchain_cmd *cmd, union scsw *scsw)
+{
+	u32 cpa = scsw->cmd.cpa;
+	struct ccwchain *chain = cmd->k_ccwchain;
+
+	/*
+	 * LATER:
+	 * For now, only update the cmd.cpa part. We may need to deal with
+	 * other portions of the schib as well, even if we don't return them
+	 * in the ioctl directly. Path status changes etc.
+	 */
+	cpa = cpa - (u32)(u64)(chain->buf.ccw);
+	if (cpa & (1 << 31))
+		cpa &= (1 << 31) - 1U;
+
+	scsw->cmd.cpa = cpa;
+}
diff --git a/drivers/vfio/ccw/ccwchain.h b/drivers/vfio/ccw/ccwchain.h
new file mode 100644
index 0000000..b72ac2a
--- /dev/null
+++ b/drivers/vfio/ccw/ccwchain.h
@@ -0,0 +1,49 @@
+/*
+ * ccwchain interfaces
+ *
+ * Copyright IBM Corp. 2016
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License (version 2 only)
+ * as published by the Free Software Foundation.
+ *
+ * Author(s): Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
+ *            Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>
+ */
+
+#ifndef _CCW_CHAIN_H_
+#define _CCW_CHAIN_H_
+
+#include <asm/cio.h>
+#include <asm/scsw.h>
+
+/**
+ * struct ccwchain_cmd - manage information for ccw program
+ * @u_ccwchain: handle of a user-space ccw program
+ * @k_ccwchain: handle of a kernel-space ccw program
+ * @nr: number of ccws in the ccw program
+ *
+ * @u_ccwchain is an user-space virtual address of a buffer where a user-space
+ * ccw program is stored. Size of this buffer is 4K bytes, of which the low 2K
+ * is for the ccws and the upper 2K for cda data.
+ *
+ * @k_ccwchain is a kernel-space physical address of a ccwchain struct, that
+ * points to the translated result of @u_ccwchain. This is opaque to user-space
+ * programs.
+ *
+ * @nr is the number of ccws in both user-space ccw program and kernel-space ccw
+ * program.
+ */
+struct ccwchain_cmd {
+	void *u_ccwchain;
+	void *k_ccwchain;
+	int nr;
+};
+
+extern int ccwchain_alloc(struct ccwchain_cmd *cmd);
+extern void ccwchain_free(struct ccwchain_cmd *cmd);
+extern int ccwchain_prefetch(struct ccwchain_cmd *cmd);
+extern struct ccw1 *ccwchain_get_cpa(struct ccwchain_cmd *cmd);
+extern void ccwchain_update_scsw(struct ccwchain_cmd *cmd, union scsw *scsw);
+
+#endif
-- 
2.6.6
