From: Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>
Subject: [PATCH RFC 3/9] s390x/css: introduce ccw chain interfaces
Date: Fri, 29 Apr 2016 14:13:17 +0200
Message-ID: <1461932003-23830-4-git-send-email-renxiaof@linux.vnet.ibm.com>
References: <1461932003-23830-1-git-send-email-renxiaof@linux.vnet.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1461932003-23830-1-git-send-email-renxiaof@linux.vnet.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org
Cc: bjsdjshi@linux.vnet.ibm.com, renxiaof@linux.vnet.ibm.com, cornelia.huck@de.ibm.com, borntraeger@de.ibm.com, agraf@suse.com, alex.williamson@redhat.com
List-ID: <linux-s390.vger.kernel.org>

Introduce CcwChain structures and helper functions that can be used
to translate a guest ccw program to a user-space ccw program.
The following limitations apply:
1. Support only prefetch enable mode.
2. Support chain for idal(c64) ccws.
3. Detect chain end only by CC and DC flags.

This work prepares a user-space ccw program according to the rules
below:
1. Alloc a 4K memory buffer to store all of the ccw program information.
   * Lower 2k of the buffer are used to store a maximum of 256 ccws, these
     ccws are copied from 'guest ccw program' and placed one after another.
   * Upper 2k of the buffer are used to store a maximum of 256 corresponding
     cda data sets, each having a length of 8 bytes.
2. For TIC ccw.
   * Locate the TIC target ccw inside the ccw area, and calculate its offset.
   * Store the offset to ccw.cda.
3. For Direct ccw.
   * Find the cda entry with the same index as the ccw.
   * Store the user virtual address of the original ccw.cda to the cda entry.
   * Store the offset of the cda entry to ccw.cda.
4. For IDAL ccw.
   * Find the cda entry with the same index as the ccw.
   * Prepare the user-space idaws. Store the virtual address of the idaws to
     the cda entry.
   * Store the offset of the cda entry to ccw.cda.
5. Append a NOOP to the chain end.
6. Expectations for the user-space ccw program I/O result:
   CPA of SCSW should be set to the offset of the ccw area of the current ccw.

Signed-off-by: Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>
---
 hw/s390x/Makefile.objs   |   1 +
 hw/s390x/s390-ccwchain.c | 441 +++++++++++++++++++++++++++++++++++++++++++++++
 hw/s390x/s390-ccwchain.h |  28 +++
 3 files changed, 470 insertions(+)
 create mode 100644 hw/s390x/s390-ccwchain.c
 create mode 100644 hw/s390x/s390-ccwchain.h

diff --git a/hw/s390x/Makefile.objs b/hw/s390x/Makefile.objs
index 2203617..35b5d27 100644
--- a/hw/s390x/Makefile.objs
+++ b/hw/s390x/Makefile.objs
@@ -11,3 +11,4 @@ obj-y += virtio-ccw.o
 obj-y += s390-pci-bus.o s390-pci-inst.o
 obj-y += s390-skeys.o
 obj-$(CONFIG_KVM) += s390-skeys-kvm.o
+obj-y += s390-ccwchain.o
diff --git a/hw/s390x/s390-ccwchain.c b/hw/s390x/s390-ccwchain.c
new file mode 100644
index 0000000..e62869d
--- /dev/null
+++ b/hw/s390x/s390-ccwchain.c
@@ -0,0 +1,441 @@
+ /*
+  * s390 ccwchain interface
+  *
+  * Copyright 2016 IBM Corp.
+  * Author(s): Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
+  *            Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>
+  *
+  * This work is licensed under the terms of the GNU GPL, version
+  * 2 or (at your option) any later version. See the COPYING file
+  * in the top-level directory.
+  */
+
+#include "qemu/osdep.h"
+#include "cpu.h"
+#include "s390-ccwchain.h"
+
+#define IDA_SIZE_LOG 12 /* 12 for 4k */
+#define IDA_BLOCK_SIZE (1L << IDA_SIZE_LOG)
+#define CCWCHAIN_LEN_MAX 256
+#define CCW1_SIZE 3 /* sizeof(CCW1) == (1 << 3) */
+#define CDA_ITEM_SIZE 3 /* sizeof(uint64_t) == (1 << 3) */
+
+#define ccw_is_test(_ccw) (((_ccw)->cmd_code & 0x0F) == 0)
+
+#define ccw_is_noop(_ccw) ((_ccw)->cmd_code == CCW_CMD_NOOP)
+
+#define ccw_is_tic(_ccw) ((_ccw)->cmd_code == CCW_CMD_TIC)
+
+#define ccw_is_idal(_ccw) ((_ccw)->flags & CCW_FLAG_IDA)
+
+#define ccw_is_chain(_ccw) ((_ccw)->flags & (CCW_FLAG_CC | CCW_FLAG_DC))
+
+typedef struct IdaWords {
+    uint32_t nr;
+    uint64_t *ida_word;
+} IdaWords;
+
+typedef struct CcwChainBuffer {
+    CCW1 ccw[CCWCHAIN_LEN_MAX];
+    uint64_t cda[CCWCHAIN_LEN_MAX];
+} CcwChainBuffer;
+
+typedef struct CcwChain {
+    QTAILQ_ENTRY(CcwChain) entry;
+    uint32_t nr;
+    hwaddr gpa;
+    CCW1 *ccw;
+    IdaWords *ida_words;
+} CcwChain;
+
+typedef struct CcwChainList {
+    QTAILQ_HEAD(, CcwChain) list;
+    CcwChainBuffer buf;
+    uint32_t nr; /* Number of the CCWs in the whole list. */
+} CcwChainList;
+
+static int ccwchain_translate(CcwChain *chain, CcwChainList *ccwchain_list);
+
+static inline void *ccwchain_hva_get(hwaddr gpa)
+{
+    hwaddr len = 1;
+    return cpu_physical_memory_map(gpa, &len, 1);
+}
+
+static inline void ccwchain_hva_put(void *hva)
+{
+    cpu_physical_memory_unmap(hva, 1, 1, 1);
+}
+
+static inline void ccwchain_idaword_put(IdaWords *ida_words)
+{
+    uint64_t *ida_word;
+    uint32_t cnt;
+
+    ida_word = ida_words->ida_word;
+    cnt = ida_words->nr;
+    while (cnt--) {
+        ccwchain_hva_put((void *)*ida_word);
+        ida_word++;
+    }
+}
+
+static inline void ccwchain_direct_put(CCW1 *ccw, CcwChainList *ccwchain_list)
+{
+    void *cda_hva;
+
+    cda_hva = (void *)ccwchain_list->buf.cda[ccw->cda >> CDA_ITEM_SIZE];
+    ccwchain_hva_put(cda_hva);
+}
+
+static inline uint32_t ccwchain_ccw_offset(CcwChain *chain,
+                                           CcwChainList *ccwchain_list)
+{
+    return (void *)chain->ccw - (void *)(&ccwchain_list->buf.ccw);
+}
+
+static void ccwchain_free(CcwChain *chain, CcwChainList *ccwchain_list)
+{
+    struct IdaWords *ida_words;
+    CCW1 *ccw;
+    uint32_t idx;
+
+    for (idx = 0; idx < chain->nr; idx++) {
+        ccw = chain->ccw + idx;
+        ida_words = chain->ida_words + idx;
+        if (ccw_is_idal(ccw)) {
+            ccwchain_idaword_put(ida_words);
+        } else if (!ccw_is_test(ccw) && !ccw_is_noop(ccw) &&
+                   !ccw_is_tic(ccw)) {
+            ccwchain_direct_put(ccw, ccwchain_list);
+        }
+        g_free(ida_words->ida_word);
+    }
+
+    QTAILQ_REMOVE(&ccwchain_list->list, chain, entry);
+    g_free(chain);
+}
+
+/*
+ * ccwchain_calc_length - calculate the length of the ccwchain.
+ *
+ * This is the chain length not considering any TICs.
+ * You need to do a new round for each TIC target.
+ *
+ * Returns: the length of the ccwchain.
+ */
+static int ccwchain_calc_length(hwaddr gpa)
+{
+    CCW1 *ccw;
+    int cnt;
+
+    cnt = 0;
+    do {
+        ccw = (CCW1 *)ccwchain_hva_get(gpa);
+        if (!ccw) {
+            return -EFAULT;
+        }
+        cnt++;
+
+        if (!ccw_is_chain(ccw)) {
+            /*
+             * An extra count is needed to reserve a space for
+             * appending an extra NOOP to the chain tail.
+             */
+            cnt++;
+            break;
+        }
+
+        gpa = gpa + sizeof(*ccw);
+        ccwchain_hva_put(ccw);
+    } while (cnt < CCWCHAIN_LEN_MAX + 1);
+
+    if (cnt > CCWCHAIN_LEN_MAX) {
+        cnt = 0;
+    }
+    return cnt;
+}
+
+static CcwChain *ccwchain_alloc(int nr)
+{
+    CcwChain *chain;
+    void *data;
+    size_t size;
+
+    size = sizeof(*chain) + sizeof(*chain->ida_words) * nr;
+    chain = g_malloc0(size);
+    data = (uint8_t *)chain + sizeof(*chain);
+    chain->ida_words = (IdaWords *)data;
+    chain->nr = nr;
+
+    return chain;
+}
+
+static CcwChain *ccwchain_copy_from_guest(hwaddr gpa,
+                                          CcwChainList *ccwchain_list)
+{
+    CcwChain *chain;
+    int nr;
+
+    nr = ccwchain_calc_length(gpa);
+    if (nr <= 0) {
+        return NULL;
+    }
+    if ((ccwchain_list->nr + nr) > CCWCHAIN_LEN_MAX) {
+        return NULL;
+    }
+
+    chain = ccwchain_alloc(nr);
+    if (!chain) {
+        return NULL;
+    }
+
+    chain->gpa = gpa;
+    chain->ccw = (void *)(&ccwchain_list->buf) +
+                 ccwchain_list->nr * sizeof(*chain->ccw);
+    cpu_physical_memory_read(chain->gpa,
+                             chain->ccw,
+                             sizeof(*chain->ccw) * chain->nr);
+    ccwchain_list->nr += chain->nr;
+    QTAILQ_INSERT_TAIL(&ccwchain_list->list, chain, entry);
+
+    return chain;
+}
+
+static bool tic_target_chain_exists(CCW1 *tic, CcwChainList *ccwchain_list)
+{
+    CcwChain *chain;
+    uint32_t ccw_head, ccw_tail;
+
+    QTAILQ_FOREACH(chain, &ccwchain_list->list, entry) {
+        ccw_head = chain->gpa;
+        ccw_tail = ccw_head + sizeof(*chain->ccw) * chain->nr;
+
+        if ((ccw_head <= tic->cda) && (tic->cda <= ccw_tail)) {
+            tic->cda = ccwchain_ccw_offset(chain, ccwchain_list);
+            return true;
+        }
+    }
+    return false;
+}
+
+static int ccwchain_translate_loop_tic(CCW1 *tic,
+                                       CcwChainList *ccwchain_list)
+{
+    CcwChain *chain;
+    int ret;
+
+    /* May transfer to an existing chain. */
+    if (tic_target_chain_exists(tic, ccwchain_list)) {
+        return 0;
+    }
+
+    /* It's a new chain then. */
+    chain = ccwchain_copy_from_guest((uint64_t)tic->cda, ccwchain_list);
+    if (!chain) {
+        return -EFAULT;
+    }
+
+    tic->cda = ccwchain_ccw_offset(chain, ccwchain_list);
+    /* Translate the new ccwchain now. */
+    ret = ccwchain_translate(chain, ccwchain_list);
+    if (ret) {
+        ccwchain_free(chain, ccwchain_list);
+    }
+
+    return ret;
+}
+
+static inline uint32_t idal_nr_words(uint64_t gaddr, uint32_t length)
+{
+    return ((gaddr & (IDA_BLOCK_SIZE - 1)) + length + (IDA_BLOCK_SIZE - 1))
+            >> IDA_SIZE_LOG;
+}
+
+static int copy_idaws_from_guest(CCW1 *ccw, IdaWords *ida_words)
+{
+    uint32_t idaws_len;
+    uint64_t data_addr;
+
+    cpu_physical_memory_read(ccw->cda, &data_addr, 8);
+    ida_words->nr = idal_nr_words(data_addr, ccw->count);
+    idaws_len = ida_words->nr * sizeof(*ida_words->ida_word);
+    ida_words->ida_word = g_malloc0(idaws_len);
+    cpu_physical_memory_read(ccw->cda, ida_words->ida_word, idaws_len);
+
+    return 0;
+}
+
+/*
+ * Translate the guest address in the idaws to user-space virtual address.
+ */
+static int translate_idaws(IdaWords *ida_words)
+{
+    uint64_t *ida_word;
+    uint32_t cnt;
+
+    cnt = ida_words->nr;
+    ida_word = ida_words->ida_word;
+    while (cnt--) {
+        *ida_word = (uint64_t)ccwchain_hva_get(be64_to_cpu(*ida_word));
+        if (!(void *)*ida_word) {
+            return -EFAULT;
+        }
+        ida_word++;
+    }
+
+    return 0;
+}
+
+static void ccwchain_update_cda(CCW1 *ccw,
+                               uint64_t cda_data,
+                               CcwChainList *ccwchain_list)
+{
+    uint32_t index;
+
+    index = ((void *)ccw - (void *)&ccwchain_list->buf.ccw) >> CCW1_SIZE;
+    ccwchain_list->buf.cda[index] = cda_data;
+    ccw->cda = index << CDA_ITEM_SIZE;
+}
+
+static int ccwchain_translate_idal(CCW1 *ccw,
+                                   IdaWords *ida_words,
+                                   CcwChainList *ccwchain_list)
+{
+    int ret;
+
+    ret = copy_idaws_from_guest(ccw, ida_words);
+    if (ret) {
+        return ret;
+    }
+
+    ccwchain_update_cda(ccw, (uint64_t)ida_words->ida_word, ccwchain_list);
+
+    return translate_idaws(ida_words);
+}
+
+static int ccwchain_translate_direct(CCW1 *ccw, CcwChainList *ccwchain_list)
+{
+    void *cda;
+
+    cda = ccwchain_hva_get(ccw->cda);
+    if (!cda) {
+        return -EFAULT;
+    }
+
+    ccwchain_update_cda(ccw, (uint64_t)cda, ccwchain_list);
+
+    return 0;
+}
+
+static int ccwchain_translate(CcwChain *chain, CcwChainList *ccwchain_list)
+{
+    CCW1 *ccw;
+    IdaWords *ida_words;
+    int i, ret;
+
+    for (i = 0; i < chain->nr - 1; i++) {
+        ccw = chain->ccw + i;
+        ccw->count = be16_to_cpu(ccw->count);
+        ccw->cda = be32_to_cpu(ccw->cda);
+        if (ccw_is_test(ccw)) {
+            continue;
+        } else if (ccw_is_noop(ccw)) {
+            continue;
+        } else if (ccw_is_tic(ccw)) {
+            ret = ccwchain_translate_loop_tic(ccw, ccwchain_list);
+        } else if (ccw_is_idal(ccw)) {
+            ida_words = chain->ida_words + i;
+            ret = ccwchain_translate_idal(ccw, ida_words, ccwchain_list);
+        } else {
+            ret = ccwchain_translate_direct(ccw, ccwchain_list);
+        }
+        if (ret) {
+            return ret;
+        }
+    }
+
+    /*
+     * CSS may bypass the last ccw via status-modifier and lead to an
+     * unpredictable behavior. To avoid this, we put a NOOP after the
+     * last ccw.
+     */
+    ccw = chain->ccw + i;
+    ccw->cmd_code = CCW_CMD_NOOP;
+    ccw->flags = 0;
+    ccw->count = 0;
+    ccw->cda = 0;
+
+    return 0;
+}
+
+int ccwchain_translate_to_userspace(TransChainData *chain_data)
+{
+    CcwChain *chain = NULL;
+    CcwChainList *ccwchain_list;
+    int ret;
+
+    ccwchain_list = g_malloc0(sizeof(*ccwchain_list));
+    QTAILQ_INIT(&ccwchain_list->list);
+    chain_data->ccwchain_list = (uint64_t)ccwchain_list;
+    chain_data->ccwchain_buf = (uint64_t)&ccwchain_list->buf;
+
+    chain = ccwchain_copy_from_guest(chain_data->cpa_gpa, ccwchain_list);
+    if (!chain) {
+        ccwchain_list_free(chain_data);
+        return -EFAULT;
+    }
+
+    ret = ccwchain_translate(chain, ccwchain_list);
+    if (ret) {
+        ccwchain_list_free(chain_data);
+        return ret;
+    }
+    chain_data->ccwchain_nr = ccwchain_list->nr;
+
+    return ret;
+}
+
+void ccwchain_update_scsw(SCSW *scsw, TransChainData *chain_data)
+{
+    CcwChainList *ccwchain_list;
+    CcwChain *chain;
+    uint32_t ccw_cnt, ccw_idx;
+    hwaddr cpa;
+
+    cpa = 0;
+    ccw_cnt = 0;
+    ccwchain_list = (void *)chain_data->ccwchain_list;
+    ccw_idx = scsw->cpa >> CCW1_SIZE;
+    QTAILQ_FOREACH(chain, &ccwchain_list->list, entry) {
+        if (ccw_cnt + chain->nr > ccw_idx) {
+            /*
+             * TODO:
+             * When the NOOP introduced by us was hit, we should propagate
+             * this information to the guest.
+             */
+            cpa = chain->gpa + (ccw_idx - ccw_cnt) * sizeof(*chain->ccw);
+            break;
+        }
+
+        ccw_cnt += chain->nr;
+    }
+    scsw->cpa = (uint32_t)cpa;
+}
+
+void ccwchain_list_free(TransChainData *chain_data)
+{
+    CcwChainList *ccwchain_list;
+    CcwChain *chain;
+
+    ccwchain_list = (void *)chain_data->ccwchain_list;
+    if (!ccwchain_list) {
+        return;
+    }
+
+    while ((chain = QTAILQ_FIRST(&ccwchain_list->list)) != NULL) {
+        ccwchain_free(chain, ccwchain_list);
+    }
+
+    g_free(ccwchain_list);
+}
diff --git a/hw/s390x/s390-ccwchain.h b/hw/s390x/s390-ccwchain.h
new file mode 100644
index 0000000..b2352de
--- /dev/null
+++ b/hw/s390x/s390-ccwchain.h
@@ -0,0 +1,28 @@
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
+#ifndef S390_CCWCHAIN_H
+#define S390_CCWCHAIN_H
+
+typedef struct TransChainData {
+    hwaddr cpa_gpa;
+    uint64_t ccwchain_list;
+    uint64_t ccwchain_buf;
+    uint32_t ccwchain_nr;
+} TransChainData;
+
+int ccwchain_translate_to_userspace(TransChainData *chain_data);
+void ccwchain_update_scsw(SCSW *scsw, TransChainData *chain_data);
+void ccwchain_list_free(TransChainData *chain_data);
+
+#endif
-- 
2.6.6
