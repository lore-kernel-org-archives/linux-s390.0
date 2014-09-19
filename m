From: frank.blaschka@de.ibm.com
Subject: [RFC patch 5/6] s390: implement pci instruction
Date: Fri, 19 Sep 2014 13:54:34 +0200
Message-ID: <20140919115940.481875559@de.ibm.com>
References: <20140919115429.557279920@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline; filename=102-qemu_pci_ic.patch
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: qemu-devel@nongnu.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org
Cc: alex.williamson@redhat.com, pbonzini@redhat.com, agraf@suse.de
List-ID: <linux-s390.vger.kernel.org>

From: Frank Blaschka <frank.blaschka@de.ibm.com>

This patch implements the s390 pci instructions in qemu. This allows
to attach qemu pci devices including vfio. This does not mean the
devices are functional but at least detection and config/memory space
access is working.
    
Signed-off-by: Frank Blaschka <frank.blaschka@de.ibm.com>
---
 target-s390x/Makefile.objs |    2 
 target-s390x/kvm.c         |   52 +++
 target-s390x/pci_ic.c      |  621 +++++++++++++++++++++++++++++++++++++++++++++
 target-s390x/pci_ic.h      |  425 ++++++++++++++++++++++++++++++
 4 files changed, 1099 insertions(+), 1 deletion(-)

--- a/target-s390x/Makefile.objs
+++ b/target-s390x/Makefile.objs
@@ -2,4 +2,4 @@ obj-y += translate.o helper.o cpu.o inte
 obj-y += int_helper.o fpu_helper.o cc_helper.o mem_helper.o misc_helper.o
 obj-y += gdbstub.o
 obj-$(CONFIG_SOFTMMU) += ioinst.o arch_dump.o
-obj-$(CONFIG_KVM) += kvm.o
+obj-$(CONFIG_KVM) += kvm.o pci_ic.o
--- a/target-s390x/kvm.c
+++ b/target-s390x/kvm.c
@@ -40,6 +40,7 @@
 #include "exec/gdbstub.h"
 #include "trace.h"
 #include "qapi-event.h"
+#include "pci_ic.h"
 
 /* #define DEBUG_KVM */
 
@@ -56,6 +57,7 @@
 #define IPA0_B2                         0xb200
 #define IPA0_B9                         0xb900
 #define IPA0_EB                         0xeb00
+#define IPA0_E3                         0xe300
 
 #define PRIV_B2_SCLP_CALL               0x20
 #define PRIV_B2_CSCH                    0x30
@@ -76,8 +78,17 @@
 #define PRIV_B2_XSCH                    0x76
 
 #define PRIV_EB_SQBS                    0x8a
+#define PRIV_EB_PCISTB                  0xd0
+#define PRIV_EB_SIC                     0xd1
 
 #define PRIV_B9_EQBS                    0x9c
+#define PRIV_B9_CLP                     0xa0
+#define PRIV_B9_PCISTG                  0xd0
+#define PRIV_B9_PCILG                   0xd2
+#define PRIV_B9_RPCIT                   0xd3
+
+#define PRIV_E3_MPCIFC                  0xd0
+#define PRIV_E3_STPCIFC                 0xd4
 
 #define DIAG_IPL                        0x308
 #define DIAG_KVM_HYPERCALL              0x500
@@ -813,6 +824,18 @@ static int handle_b9(S390CPU *cpu, struc
     int r = 0;
 
     switch (ipa1) {
+    case PRIV_B9_CLP:
+        r = kvm_clp_service_call(cpu, run);
+        break;
+    case PRIV_B9_PCISTG:
+        r = kvm_pcistg_service_call(cpu, run);
+        break;
+    case PRIV_B9_PCILG:
+        r = kvm_pcilg_service_call(cpu, run);
+        break;
+    case PRIV_B9_RPCIT:
+        r = kvm_rpcit_service_call(cpu, run);
+        break;
     case PRIV_B9_EQBS:
         /* just inject exception */
         r = -1;
@@ -831,6 +854,12 @@ static int handle_eb(S390CPU *cpu, struc
     int r = 0;
 
     switch (ipa1) {
+    case PRIV_EB_PCISTB:
+        r = kvm_pcistb_service_call(cpu, run);
+        break;
+    case PRIV_EB_SIC:
+        r = kvm_sic_service_call(cpu, run);
+        break;
     case PRIV_EB_SQBS:
         /* just inject exception */
         r = -1;
@@ -844,6 +873,26 @@ static int handle_eb(S390CPU *cpu, struc
     return r;
 }
 
+static int handle_e3(S390CPU *cpu, struct kvm_run *run, uint8_t ipa1)
+{
+    int r = 0;
+
+    switch (ipa1) {
+    case PRIV_E3_MPCIFC:
+        r = kvm_mpcifc_service_call(cpu, run);
+        break;
+    case PRIV_E3_STPCIFC:
+        r = kvm_stpcifc_service_call(cpu, run);
+        break;
+    default:
+        r = -1;
+        DPRINTF("KVM: unhandled PRIV: 0xe3%x\n", ipa1);
+        break;
+    }
+
+    return r;
+}
+
 static int handle_hypercall(S390CPU *cpu, struct kvm_run *run)
 {
     CPUS390XState *env = &cpu->env;
@@ -1038,6 +1087,9 @@ static int handle_instruction(S390CPU *c
     case IPA0_EB:
         r = handle_eb(cpu, run, ipa1);
         break;
+    case IPA0_E3:
+        r = handle_e3(cpu, run, run->s390_sieic.ipb & 0xff);
+        break;
     case IPA0_DIAG:
         r = handle_diag(cpu, run, run->s390_sieic.ipb);
         break;
--- /dev/null
+++ b/target-s390x/pci_ic.c
@@ -0,0 +1,621 @@
+/*
+ * s390 PCI intercepts
+ *
+ * Copyright 2014 IBM Corp.
+ * Author(s): Frank Blaschka <frank.blaschka@de.ibm.com>
+ *            Hong Bo Li <lihbbj@cn.ibm.com>
+ *            Yi Min Zhao <zyimin@cn.ibm.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or (at
+ * your option) any later version. See the COPYING file in the top-level
+ * directory.
+ */
+
+#include <sys/types.h>
+#include <sys/ioctl.h>
+#include <sys/mman.h>
+
+#include <linux/kvm.h>
+#include <asm/ptrace.h>
+#include <hw/pci/pci.h>
+#include <hw/pci/pci_host.h>
+#include <net/net.h>
+
+#include "qemu-common.h"
+#include "qemu/timer.h"
+#include "migration/qemu-file.h"
+#include "sysemu/sysemu.h"
+#include "sysemu/kvm.h"
+#include "cpu.h"
+#include "sysemu/device_tree.h"
+#include "monitor/monitor.h"
+#include "pci_ic.h"
+
+#include "hw/hw.h"
+#include "hw/pci/pci.h"
+#include "hw/pci/pci_bridge.h"
+#include "hw/pci/pci_bus.h"
+#include "hw/pci/pci_host.h"
+#include "hw/s390x/s390-pci-bus.h"
+#include "exec/exec-all.h"
+
+/* #define DEBUG_S390PCI_IC */
+#ifdef DEBUG_S390PCI_IC
+#define DPRINTF(fmt, ...) \
+    do { fprintf(stderr, "s390pci_ic: " fmt, ## __VA_ARGS__); } while (0)
+#else
+#define DPRINTF(fmt, ...) \
+    do { } while (0)
+#endif
+
+static uint64_t resume_token;
+
+static uint8_t barsize(uint64_t size)
+{
+    uint64_t mask = 1;
+    int i;
+
+    if (!size) {
+        return 0;
+    }
+
+    for (i = 0; i < 64; i++) {
+        if (size & mask) {
+            break;
+        }
+        mask = (mask << 1);
+    }
+
+    return i;
+}
+
+static int list_pci(ClpReqRspListPci *rrb, uint8_t *cc)
+{
+    S390PCIBusDevice *pbdev;
+    uint32_t res_code, initial_l2, g_l2, finish;
+    int rc, idx;
+
+    rc = 0;
+    if (be16_to_cpu(rrb->request.hdr.len) != 32) {
+        res_code = CLP_RC_LEN;
+        rc = -EINVAL;
+        goto out;
+    }
+
+    if ((be32_to_cpu(rrb->request.fmt) & CLP_MASK_FMT) != 0) {
+        res_code = CLP_RC_FMT;
+        rc = -EINVAL;
+        goto out;
+    }
+
+    if ((be32_to_cpu(rrb->request.fmt) & ~CLP_MASK_FMT) != 0 ||
+        rrb->request.reserved1 != 0 ||
+        rrb->request.reserved2 != 0) {
+        res_code = CLP_RC_RESNOT0;
+        rc = -EINVAL;
+        goto out;
+    }
+
+    if (be64_to_cpu(rrb->request.resume_token) == 0) {
+        resume_token = 0;
+    } else if (be64_to_cpu(rrb->request.resume_token) != resume_token) {
+        res_code = CLP_RC_LISTPCI_BADRT;
+        rc = -EINVAL;
+        goto out;
+    }
+
+    if (be16_to_cpu(rrb->response.hdr.len) < 48) {
+        res_code = CLP_RC_8K;
+        rc = -EINVAL;
+        goto out;
+    }
+
+    initial_l2 = be16_to_cpu(rrb->response.hdr.len);
+    if ((initial_l2 - LIST_PCI_HDR_LEN) % sizeof(ClpFhListEntry)
+        != 0) {
+        rc = -EINVAL;
+        goto out;
+    }
+
+    rrb->response.fmt = 0;
+    rrb->response.reserved1 = rrb->response.reserved2 = 0;
+    rrb->response.mdd = cpu_to_be32(FH_VIRT);
+    rrb->response.max_fn = cpu_to_be16(PCI_MAX_FUNCTIONS);
+    rrb->response.entry_size = sizeof(ClpFhListEntry);
+    finish = 0;
+    idx = resume_token;
+    g_l2 = LIST_PCI_HDR_LEN;
+    do {
+        pbdev = s390_pci_find_dev_by_idx(idx);
+        if (!pbdev) {
+            finish = 1;
+            break;
+        }
+        rrb->response.fh_list[idx - resume_token].device_id =
+            pci_get_word(pbdev->pdev->config + PCI_DEVICE_ID);
+        rrb->response.fh_list[idx - resume_token].vendor_id =
+            pci_get_word(pbdev->pdev->config + PCI_VENDOR_ID);
+        rrb->response.fh_list[idx - resume_token].config =
+            cpu_to_be32(0x80000000);
+        rrb->response.fh_list[idx - resume_token].fid = cpu_to_be32(pbdev->fid);
+        rrb->response.fh_list[idx - resume_token].fh = cpu_to_be32(pbdev->fh);
+
+        g_l2 += sizeof(ClpFhListEntry);
+        DPRINTF("g_l2 %d vendor id 0x%x device id 0x%x fid 0x%x fh 0x%x\n",
+            g_l2,
+            rrb->response.fh_list[idx - resume_token].vendor_id,
+            rrb->response.fh_list[idx - resume_token].device_id,
+            rrb->response.fh_list[idx - resume_token].fid,
+            rrb->response.fh_list[idx - resume_token].fh);
+        idx++;
+    } while (g_l2 < initial_l2);
+
+    if (finish == 1) {
+        resume_token = 0;
+    } else {
+        resume_token = idx;
+    }
+    rrb->response.resume_token = cpu_to_be64(resume_token);
+    rrb->response.hdr.len = cpu_to_be16(g_l2);
+    rrb->response.hdr.rsp = cpu_to_be16(CLP_RC_OK);
+out:
+    if (rc) {
+        DPRINTF("list pci failed rc 0x%x\n", rc);
+        rrb->response.hdr.rsp = cpu_to_be16(res_code);
+        *cc = 3;
+    }
+    return rc;
+}
+
+int kvm_clp_service_call(S390CPU *cpu, struct kvm_run *run)
+{
+    ClpReqHdr *reqh;
+    ClpRspHdr *resh;
+    S390PCIBusDevice *pbdev;
+    uint32_t req_len;
+    uint32_t res_len;
+    uint8_t *buffer;
+    uint8_t cc;
+    CPUS390XState *env = &cpu->env;
+    uint8_t r2 = (run->s390_sieic.ipb & 0x000f0000) >> 16;
+    int rc = 0;
+    int i;
+
+    buffer = g_malloc0(4096 * 2);
+    cpu_synchronize_state(CPU(cpu));
+
+    cpu_physical_memory_rw(env->regs[r2], buffer, sizeof(reqh), 0);
+    reqh = (ClpReqHdr *)buffer;
+    req_len = be16_to_cpu(reqh->len);
+
+    cpu_physical_memory_rw(env->regs[r2], buffer, req_len + sizeof(resh), 0);
+    resh = (ClpRspHdr *)(buffer + req_len);
+    res_len = be16_to_cpu(resh->len);
+
+    cpu_physical_memory_rw(env->regs[r2], buffer, req_len + res_len, 0);
+
+    switch (reqh->cmd) {
+    case CLP_LIST_PCI: {
+        ClpReqRspListPci *rrb = (ClpReqRspListPci *)buffer;
+        rc = list_pci(rrb, &cc);
+        break;
+    }
+    case CLP_SET_PCI_FN: {
+        ClpReqSetPci *reqsetpci = (ClpReqSetPci *)reqh;
+        ClpRspSetPci *ressetpci = (ClpRspSetPci *)resh;
+
+        pbdev = s390_pci_find_dev_by_fh(be32_to_cpu(reqsetpci->fh));
+        if (!pbdev) {
+                ressetpci->hdr.rsp = cpu_to_be16(CLP_RC_SETPCIFN_FH);
+                goto out;
+        }
+
+        switch (reqsetpci->oc) {
+        case CLP_SET_ENABLE_PCI_FN:
+            if (pbdev->is_virt) {
+                pbdev->fh = pbdev->fh | 1 << ENABLE_BIT_OFFSET;
+                ressetpci->fh = cpu_to_be32(pbdev->fh);
+                ressetpci->hdr.rsp = cpu_to_be16(CLP_RC_OK);
+            } else {
+                pbdev->fh = be32_to_cpu(ressetpci->fh);
+            }
+            break;
+        case CLP_SET_DISABLE_PCI_FN:
+            if (pbdev->is_virt) {
+                pbdev->fh = pbdev->fh & ~(1 << ENABLE_BIT_OFFSET);
+                ressetpci->fh = cpu_to_be32(pbdev->fh);
+                ressetpci->hdr.rsp = cpu_to_be16(CLP_RC_OK);
+            } else {
+                pbdev->fh = be32_to_cpu(ressetpci->fh);
+            }
+            break;
+        default:
+            DPRINTF("unknown set pci command\n");
+            ressetpci->hdr.rsp = cpu_to_be16(CLP_RC_SETPCIFN_FHOP);
+            break;
+        }
+        break;
+    }
+    case CLP_QUERY_PCI_FN: {
+        ClpReqQueryPci *reqquery = (ClpReqQueryPci *)reqh;
+        ClpRspQueryPci *resquery = (ClpRspQueryPci *)resh;
+
+        pbdev = s390_pci_find_dev_by_fh(reqquery->fh);
+        if (!pbdev) {
+            DPRINTF("query pci no pci dev\n");
+            return -EIO;
+        }
+
+        for (i = 0; i < PCI_BAR_COUNT; i++) {
+            uint64_t data = pci_host_config_read_common(pbdev->pdev,
+                0x10 + (i * 4), pci_config_size(pbdev->pdev), 4);
+
+            resquery->bar[i] = bswap32(data);
+            resquery->bar_size[i] = barsize(pbdev->pdev->io_regions[i].size);
+            DPRINTF("bar %d addr 0x%x size 0x%lx barsize 0x%x\n", i,
+                    resquery->bar[i], pbdev->pdev->io_regions[i].size,
+                    resquery->bar_size[i]);
+        }
+
+        /* traced find out how to optain !!! */
+        resquery->sdma = 0x100000000;
+        resquery->edma = 0x1ffffffffffffff;
+        resquery->pchid = 0;
+        resquery->ug = 1;
+
+        resquery->hdr.rsp = CLP_RC_OK;
+        break;
+    }
+    case CLP_QUERY_PCI_FNGRP: {
+        ClpRspQueryPciGrp *resgrp = (ClpRspQueryPciGrp *)resh;
+        /* find function group for now we go with fixed values */
+        resgrp->fr = 1;
+        resgrp->dasm = 0;
+        /* traced but we may not need this since msix table is maintained
+         * by host */
+        resgrp->msia = 0xfe00000000000000;
+        resgrp->mui = 0;
+        resgrp->i = 128;
+        resgrp->version = 0;
+
+        resgrp->hdr.rsp = CLP_RC_OK;
+        break;
+    }
+    default:
+        DPRINTF("unknown clp command\n");
+        resh->rsp = cpu_to_be16(CLP_RC_CMD);
+        break;
+    }
+
+out:
+    cpu_physical_memory_rw(env->regs[r2], buffer, req_len + res_len, 1);
+    g_free(buffer);
+    setcc(cpu, 0);
+    return rc;
+}
+
+int kvm_pcilg_service_call(S390CPU *cpu, struct kvm_run *run)
+{
+    CPUS390XState *env = &cpu->env;
+    S390PCIBusDevice *pbdev;
+    uint8_t r1 = (run->s390_sieic.ipb & 0x00f00000) >> 20;
+    uint8_t r2 = (run->s390_sieic.ipb & 0x000f0000) >> 16;
+    PciLgStg *rp;
+    uint64_t offset;
+    uint64_t data;
+
+    cpu_synchronize_state(CPU(cpu));
+    rp = (PciLgStg *)&env->regs[r2];
+    offset = env->regs[r2 + 1];
+
+    pbdev = s390_pci_find_dev_by_fh(rp->fh);
+    if (!pbdev) {
+        DPRINTF("pcilg no pci dev\n");
+        return -EIO;
+    }
+
+    if (rp->pcias < 6) {
+        MemoryRegion *mr = pbdev->pdev->io_regions[rp->pcias].memory;
+        io_mem_read(mr, offset, &data, rp->len);
+    } else if (rp->pcias == 15) {
+        data =  pci_host_config_read_common(
+                   pbdev->pdev, offset, pci_config_size(pbdev->pdev), rp->len);
+
+        switch (rp->len) {
+        case 1:
+            break;
+        case 2:
+            data = cpu_to_le16(data);
+            break;
+        case 4:
+            data = cpu_to_le32(data);
+            break;
+        case 8:
+            data = cpu_to_le64(data);
+            break;
+        default:
+            abort();
+        }
+    } else {
+        DPRINTF("invalid space\n");
+    }
+
+    env->regs[r1] = data;
+    setcc(cpu, 0);
+    return 0;
+}
+
+int kvm_pcistg_service_call(S390CPU *cpu, struct kvm_run *run)
+{
+    CPUS390XState *env = &cpu->env;
+    uint8_t r1 = (run->s390_sieic.ipb & 0x00f00000) >> 20;
+    uint8_t r2 = (run->s390_sieic.ipb & 0x000f0000) >> 16;
+    PciLgStg *rp;
+    uint64_t offset, data;
+    S390PCIBusDevice *pbdev;
+
+    cpu_synchronize_state(CPU(cpu));
+    rp = (PciLgStg *)&env->regs[r2];
+    offset = env->regs[r2 + 1];
+
+    pbdev = s390_pci_find_dev_by_fh(rp->fh);
+    if (!pbdev) {
+        DPRINTF("pcistg no pci dev\n");
+        return -EIO;
+    }
+
+    data = env->regs[r1];
+
+    if (rp->pcias < 6) {
+        MemoryRegion *mr;
+        if (pbdev->msix_table_bar == rp->pcias &&
+            offset >= pbdev->msix_table_offset &&
+            offset <= pbdev->msix_table_offset +
+                      (pbdev->msix_entries - 1) * PCI_MSIX_ENTRY_SIZE) {
+            offset = offset - pbdev->msix_table_offset;
+            mr = &pbdev->pdev->msix_table_mmio;
+        } else {
+            mr = pbdev->pdev->io_regions[rp->pcias].memory;
+        }
+
+        io_mem_write(mr, offset, data, rp->len);
+    } else if (rp->pcias == 15) {
+        switch (rp->len) {
+        case 1:
+            break;
+        case 2:
+            data = le16_to_cpu(data);
+            break;
+        case 4:
+            data = le32_to_cpu(data);
+            break;
+        case 8:
+            data = le64_to_cpu(data);
+            break;
+        default:
+            abort();
+        }
+
+        pci_host_config_write_common(pbdev->pdev, offset,
+                                     pci_config_size(pbdev->pdev),
+                                     data, rp->len);
+    } else {
+        DPRINTF("pcistg invalid space\n");
+    }
+
+    setcc(cpu, 0);
+    return 0;
+}
+
+static uint64_t guest_io_table_walk(uint64_t guest_iota,
+                                    uint64_t guest_dma_address)
+{
+    uint64_t sto_a, pto_a, px_a;
+    uint64_t sto, pto, pte;
+    uint32_t rtx, sx, px;
+
+    rtx = calc_rtx(guest_dma_address);
+    sx = calc_sx(guest_dma_address);
+    px = calc_px(guest_dma_address);
+
+    sto_a = guest_iota + rtx * sizeof(uint64_t);
+    cpu_physical_memory_rw(sto_a, (uint8_t *)&sto, sizeof(uint64_t), 0);
+    sto = (uint64_t)get_rt_sto(sto);
+
+    pto_a = sto + sx * sizeof(uint64_t);
+    cpu_physical_memory_rw(pto_a, (uint8_t *)&pto, sizeof(uint64_t), 0);
+    pto = (uint64_t)get_st_pto(pto);
+
+    px_a = pto + px * sizeof(uint64_t);
+    cpu_physical_memory_rw(px_a, (uint8_t *)&pte, sizeof(uint64_t), 0);
+
+    return pte;
+}
+
+int kvm_rpcit_service_call(S390CPU *cpu, struct kvm_run *run)
+{
+    CPUS390XState *env = &cpu->env;
+    uint8_t r1 = (run->s390_sieic.ipb & 0x00f00000) >> 20;
+    uint8_t r2 = (run->s390_sieic.ipb & 0x000f0000) >> 16;
+    uint32_t fh;
+    uint64_t pte;
+    S390PCIBusDevice *pbdev;
+    ram_addr_t size;
+    int flags;
+    IOMMUTLBEntry entry;
+
+    cpu_synchronize_state(CPU(cpu));
+
+    fh = env->regs[r1] >> 32;
+    size = env->regs[r2 + 1];
+
+    pbdev = s390_pci_find_dev_by_fh(fh);
+
+    if (!pbdev) {
+        DPRINTF("rpcit no pci dev\n");
+        return -EIO;
+    }
+
+    pte = guest_io_table_walk(pbdev->g_iota, env->regs[r2]);
+    flags = pte & ZPCI_PTE_FLAG_MASK;
+    entry.target_as = &address_space_memory;
+    entry.iova = env->regs[r2];
+    entry.translated_addr = pte & ZPCI_PTE_ADDR_MASK;
+    entry.addr_mask = size - 1;
+
+    if (flags & ZPCI_PTE_INVALID) {
+        entry.perm = IOMMU_NONE;
+    } else {
+        entry.perm = IOMMU_RW;
+    }
+
+    memory_region_notify_iommu(pci_device_iommu_address_space(
+                               pbdev->pdev)->root, entry);
+
+    setcc(cpu, 0);
+    return 0;
+}
+
+int kvm_sic_service_call(S390CPU *cpu, struct kvm_run *run)
+{
+    DPRINTF("sic\n");
+    return 0;
+}
+
+int kvm_pcistb_service_call(S390CPU *cpu, struct kvm_run *run)
+{
+    CPUS390XState *env = &cpu->env;
+    uint8_t r1 = (run->s390_sieic.ipa & 0x00f0) >> 4;
+    uint8_t r3 = run->s390_sieic.ipa & 0x000f;
+    PciStb *rp;
+    uint64_t gaddr;
+    uint64_t *uaddr, *pu;
+    hwaddr len;
+    S390PCIBusDevice *pbdev;
+    MemoryRegion *mr;
+    int i;
+
+    cpu_synchronize_state(CPU(cpu));
+
+    rp = (PciStb *)&env->regs[r1];
+    gaddr = get_base_disp_rsy(cpu, run);
+    len = rp->len;
+
+    pbdev = s390_pci_find_dev_by_fh(rp->fh);
+    if (!pbdev) {
+        DPRINTF("pcistb no pci dev fh 0x%x\n", rp->fh);
+        return -EIO;
+    }
+
+    uaddr = cpu_physical_memory_map(gaddr, &len, 0);
+    mr = pbdev->pdev->io_regions[rp->pcias].memory;
+
+    pu = uaddr;
+    for (i = 0; i < rp->len / 8; i++) {
+        io_mem_write(mr, env->regs[r3] + i * 8, *pu, 8);
+        pu++;
+    }
+
+    cpu_physical_memory_unmap(uaddr, len, 0, len);
+    setcc(cpu, 0);
+    return 0;
+}
+
+static int reg_irqs(CPUS390XState *env, S390PCIBusDevice *pbdev, ZpciFib fib)
+{
+    int ret;
+    S390FLICState *fs = s390_get_flic();
+    S390FLICStateClass *fsc = S390_FLIC_COMMON_GET_CLASS(fs);
+
+    ret = css_register_io_adapter(S390_PCIPT_ADAPTER,
+                                  FIB_DATA_ISC(fib.data), true, false,
+                                  &pbdev->routes.adapter.adapter_id);
+    assert(ret == 0);
+
+    fsc->io_adapter_map(fs, pbdev->routes.adapter.adapter_id, fib.aisb, true);
+    fsc->io_adapter_map(fs, pbdev->routes.adapter.adapter_id, fib.aibv, true);
+
+    pbdev->routes.adapter.summary_addr = fib.aisb;
+    pbdev->routes.adapter.summary_offset = FIB_DATA_AISBO(fib.data);
+    pbdev->routes.adapter.ind_addr = fib.aibv;
+    pbdev->routes.adapter.ind_offset = FIB_DATA_AIBVO(fib.data);
+
+    DPRINTF("reg_irqs adapter id %d\n", pbdev->routes.adapter.adapter_id);
+    return 0;
+}
+
+static int dereg_irqs(S390PCIBusDevice *pbdev)
+{
+    S390FLICState *fs = s390_get_flic();
+    S390FLICStateClass *fsc = S390_FLIC_COMMON_GET_CLASS(fs);
+
+    fsc->io_adapter_map(fs, pbdev->routes.adapter.adapter_id,
+                        pbdev->routes.adapter.ind_addr, false);
+
+    pbdev->routes.adapter.summary_addr = 0;
+    pbdev->routes.adapter.summary_offset = 0;
+    pbdev->routes.adapter.ind_addr = 0;
+    pbdev->routes.adapter.ind_offset = 0;
+
+    DPRINTF("dereg_irqs adapter id %d\n", pbdev->routes.adapter.adapter_id);
+    return 0;
+}
+
+int kvm_mpcifc_service_call(S390CPU *cpu, struct kvm_run *run)
+{
+    CPUS390XState *env = &cpu->env;
+    uint8_t r1 = (run->s390_sieic.ipa & 0x00f0) >> 4;
+    uint8_t oc;
+    uint32_t fh;
+    uint64_t fiba;
+    ZpciFib fib;
+    S390PCIBusDevice *pbdev;
+
+    cpu_synchronize_state(CPU(cpu));
+
+    oc = env->regs[r1] & 0xff;
+    fh = env->regs[r1] >> 32;
+    fiba = get_base_disp_rxy(cpu, run);
+
+    pbdev = s390_pci_find_dev_by_fh(fh);
+    if (!pbdev) {
+        DPRINTF("mpcifc no pci dev fh 0x%x\n", fh);
+    }
+
+    cpu_physical_memory_rw(fiba, (uint8_t *)&fib, sizeof(fib), 0);
+
+    switch (oc) {
+    case ZPCI_MOD_FC_REG_INT: {
+        pbdev->isc = FIB_DATA_ISC(fib.data);
+        reg_irqs(env, pbdev, fib);
+        break;
+    }
+    case ZPCI_MOD_FC_DEREG_INT:
+        dereg_irqs(pbdev);
+        break;
+    case ZPCI_MOD_FC_REG_IOAT:
+        pbdev->g_iota = fib.iota & ~ZPCI_IOTA_RTTO_FLAG;
+        break;
+    case ZPCI_MOD_FC_DEREG_IOAT:
+        break;
+    case ZPCI_MOD_FC_REREG_IOAT:
+        break;
+    case ZPCI_MOD_FC_RESET_ERROR:
+        break;
+    case ZPCI_MOD_FC_RESET_BLOCK:
+        break;
+    case ZPCI_MOD_FC_SET_MEASURE:
+        break;
+    default:
+        break;
+    }
+
+    setcc(cpu, 0);
+    return 0;
+}
+
+int kvm_stpcifc_service_call(S390CPU *cpu, struct kvm_run *run)
+{
+    DPRINTF("stpcifc\n");
+    return -EINVAL;
+}
--- /dev/null
+++ b/target-s390x/pci_ic.h
@@ -0,0 +1,425 @@
+/*
+ * s390 PCI intercept definitions
+ *
+ * Copyright 2014 IBM Corp.
+ * Author(s): Frank Blaschka <frank.blaschka@de.ibm.com>
+ *            Hong Bo Li <lihbbj@cn.ibm.com>
+ *            Yi Min Zhao <zyimin@cn.ibm.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or (at
+ * your option) any later version. See the COPYING file in the top-level
+ * directory.
+ */
+
+#ifndef PCI_IC_S390X_H
+#define PCI_IC_S390X_H
+
+#include <sysemu/dma.h>
+
+/* CLP common request & response block size */
+#define CLP_BLK_SIZE 4096
+#define PCI_BAR_COUNT 6
+#define PCI_MAX_FUNCTIONS 4096
+
+typedef struct ClpReqHdr {
+    __uint16_t len;
+    __uint16_t cmd;
+} QEMU_PACKED ClpReqHdr;
+
+typedef struct ClpRspHdr {
+    __uint16_t len;
+    __uint16_t rsp;
+} QEMU_PACKED ClpRspHdr;
+
+/* CLP Response Codes */
+#define CLP_RC_OK         0x0010  /* Command request successfully */
+#define CLP_RC_CMD        0x0020  /* Command code not recognized */
+#define CLP_RC_PERM       0x0030  /* Command not authorized */
+#define CLP_RC_FMT        0x0040  /* Invalid command request format */
+#define CLP_RC_LEN        0x0050  /* Invalid command request length */
+#define CLP_RC_8K         0x0060  /* Command requires 8K LPCB */
+#define CLP_RC_RESNOT0    0x0070  /* Reserved field not zero */
+#define CLP_RC_NODATA     0x0080  /* No data available */
+#define CLP_RC_FC_UNKNOWN 0x0100  /* Function code not recognized */
+
+/*
+ * Call Logical Processor - Command Codes
+ */
+#define CLP_LIST_PCI            0x0002
+#define CLP_QUERY_PCI_FN        0x0003
+#define CLP_QUERY_PCI_FNGRP     0x0004
+#define CLP_SET_PCI_FN          0x0005
+
+/* PCI function handle list entry */
+typedef struct ClpFhListEntry {
+    __uint16_t device_id;
+    __uint16_t vendor_id;
+#define CLP_FHLIST_MASK_CONFIG 0x80000000
+    __uint32_t config;
+    __uint32_t fid;
+    __uint32_t fh;
+} QEMU_PACKED ClpFhListEntry;
+
+#define CLP_RC_SETPCIFN_FH      0x0101 /* Invalid PCI fn handle */
+#define CLP_RC_SETPCIFN_FHOP    0x0102 /* Fn handle not valid for op */
+#define CLP_RC_SETPCIFN_DMAAS   0x0103 /* Invalid DMA addr space */
+#define CLP_RC_SETPCIFN_RES     0x0104 /* Insufficient resources */
+#define CLP_RC_SETPCIFN_ALRDY   0x0105 /* Fn already in requested state */
+#define CLP_RC_SETPCIFN_ERR     0x0106 /* Fn in permanent error state */
+#define CLP_RC_SETPCIFN_RECPND  0x0107 /* Error recovery pending */
+#define CLP_RC_SETPCIFN_BUSY    0x0108 /* Fn busy */
+#define CLP_RC_LISTPCI_BADRT    0x010a /* Resume token not recognized */
+#define CLP_RC_QUERYPCIFG_PFGID 0x010b /* Unrecognized PFGID */
+
+/* request or response block header length */
+#define LIST_PCI_HDR_LEN 32
+
+/* Number of function handles fitting in response block */
+#define CLP_FH_LIST_NR_ENTRIES \
+    ((CLP_BLK_SIZE - 2 * LIST_PCI_HDR_LEN) \
+        / sizeof(ClpFhListEntry))
+
+#define CLP_SET_ENABLE_PCI_FN  0 /* Yes, 0 enables it */
+#define CLP_SET_DISABLE_PCI_FN 1 /* Yes, 1 disables it */
+
+#define CLP_UTIL_STR_LEN 64
+
+#define CLP_MASK_FMT 0xf0000000
+
+/* List PCI functions request */
+typedef struct ClpReqListPci {
+    ClpReqHdr hdr;
+    __uint32_t fmt;
+    __uint64_t reserved1;
+    __uint64_t resume_token;
+    __uint64_t reserved2;
+} QEMU_PACKED ClpReqListPci;
+
+/* List PCI functions response */
+typedef struct ClpRspListPci {
+    ClpRspHdr hdr;
+    __uint32_t fmt;
+    __uint64_t reserved1;
+    __uint64_t resume_token;
+    __uint32_t mdd;
+    __uint16_t max_fn;
+    __uint8_t reserved2;
+    __uint8_t entry_size;
+    ClpFhListEntry fh_list[CLP_FH_LIST_NR_ENTRIES];
+} QEMU_PACKED ClpRspListPci;
+
+/* Query PCI function request */
+typedef struct ClpReqQueryPci {
+    ClpReqHdr hdr;
+    __uint32_t fmt;
+    __uint64_t reserved1;
+    __uint32_t fh; /* function handle */
+    __uint32_t reserved2;
+    __uint64_t reserved3;
+} QEMU_PACKED ClpReqQueryPci;
+
+/* Query PCI function response */
+typedef struct ClpRspQueryPci {
+    ClpRspHdr hdr;
+    __uint32_t fmt;
+    __uint64_t reserved1;
+    __uint16_t vfn; /* virtual fn number */
+#define CLP_RSP_QPCI_MASK_UTIL  0x100
+#define CLP_RSP_QPCI_MASK_PFGID 0xff
+    __uint16_t ug;
+    __uint32_t fid; /* pci function id */
+    __uint8_t bar_size[PCI_BAR_COUNT];
+    __uint16_t pchid;
+    __uint32_t bar[PCI_BAR_COUNT];
+    __uint64_t reserved2;
+    __uint64_t sdma; /* start dma as */
+    __uint64_t edma; /* end dma as */
+    __uint64_t reserved3[6];
+    __uint8_t util_str[CLP_UTIL_STR_LEN]; /* utility string */
+} QEMU_PACKED ClpRspQueryPci;
+
+/* Query PCI function group request */
+typedef struct ClpReqQueryPciGrp {
+    ClpReqHdr hdr;
+    __uint32_t fmt;
+    __uint64_t reserved1;
+#define CLP_REQ_QPCIG_MASK_PFGID 0xff
+    __uint32_t g;
+    __uint32_t reserved2;
+    __uint64_t reserved3;
+} QEMU_PACKED ClpReqQueryPciGrp;
+
+/* Query PCI function group response */
+typedef struct ClpRspQueryPciGrp {
+    ClpRspHdr hdr;
+    __uint32_t fmt;
+    __uint64_t reserved1;
+#define CLP_RSP_QPCIG_MASK_NOI 0xfff
+    __uint16_t i;
+    __uint8_t version;
+#define CLP_RSP_QPCIG_MASK_FRAME   0x2
+#define CLP_RSP_QPCIG_MASK_REFRESH 0x1
+    __uint8_t fr;
+    __uint16_t reserved2;
+    __uint16_t mui;
+    __uint64_t reserved3;
+    __uint64_t dasm; /* dma address space mask */
+    __uint64_t msia; /* MSI address */
+    __uint64_t reserved4;
+    __uint64_t reserved5;
+} QEMU_PACKED ClpRspQueryPciGrp;
+
+/* Set PCI function request */
+typedef struct ClpReqSetPci {
+    ClpReqHdr hdr;
+    __uint32_t fmt;
+    __uint64_t reserved1;
+    __uint32_t fh; /* function handle */
+    __uint16_t reserved2;
+    __uint8_t oc; /* operation controls */
+    __uint8_t ndas; /* number of dma spaces */
+    __uint64_t reserved3;
+} QEMU_PACKED ClpReqSetPci;
+
+/* Set PCI function response */
+typedef struct ClpRspSetPci {
+    ClpRspHdr hdr;
+    __uint32_t fmt;
+    __uint64_t reserved1;
+    __uint32_t fh; /* function handle */
+    __uint32_t reserved3;
+    __uint64_t reserved4;
+} QEMU_PACKED ClpRspSetPci;
+
+typedef struct ClpReqRspListPci {
+    ClpReqListPci request;
+    ClpRspListPci response;
+} QEMU_PACKED ClpReqRspListPci;
+
+typedef struct ClpReqRspSetPci {
+    ClpReqSetPci request;
+    ClpRspSetPci response;
+} QEMU_PACKED ClpReqRspSetPci;
+
+typedef struct ClpReqRspQueryPci {
+    ClpReqQueryPci request;
+    ClpRspQueryPci response;
+} QEMU_PACKED ClpReqRspQueryPci;
+
+typedef struct ClpReqRspQueryPciGrp {
+    ClpReqQueryPciGrp request;
+    ClpRspQueryPciGrp response;
+} QEMU_PACKED ClpReqRspQueryPciGrp;
+
+typedef struct PciLgStg {
+    uint32_t fh;
+    uint8_t status;
+    uint8_t pcias;
+    uint8_t reserved;
+    uint8_t len;
+} QEMU_PACKED PciLgStg;
+
+typedef struct PciStb {
+    uint32_t fh;
+    uint8_t status;
+    uint8_t pcias;
+    uint8_t reserved;
+    uint8_t len;
+} QEMU_PACKED PciStb;
+
+/* Modify PCI Function Controls */
+#define ZPCI_MOD_FC_REG_INT     2
+#define ZPCI_MOD_FC_DEREG_INT   3
+#define ZPCI_MOD_FC_REG_IOAT    4
+#define ZPCI_MOD_FC_DEREG_IOAT  5
+#define ZPCI_MOD_FC_REREG_IOAT  6
+#define ZPCI_MOD_FC_RESET_ERROR 7
+#define ZPCI_MOD_FC_RESET_BLOCK 9
+#define ZPCI_MOD_FC_SET_MEASURE 10
+
+/* FIB function controls */
+#define ZPCI_FIB_FC_ENABLED     0x80
+#define ZPCI_FIB_FC_ERROR       0x40
+#define ZPCI_FIB_FC_LS_BLOCKED  0x20
+#define ZPCI_FIB_FC_DMAAS_REG   0x10
+
+/* FIB function controls */
+#define ZPCI_FIB_FC_ENABLED     0x80
+#define ZPCI_FIB_FC_ERROR       0x40
+#define ZPCI_FIB_FC_LS_BLOCKED  0x20
+#define ZPCI_FIB_FC_DMAAS_REG   0x10
+
+/* Function Information Block */
+typedef struct ZpciFib {
+    __uint8_t fmt;   /* format */
+    __uint8_t reserved1[7];
+    __uint8_t fc;                  /* function controls */
+    __uint8_t reserved2;
+    __uint16_t reserved3;
+    __uint32_t reserved4;
+    __uint64_t pba;                /* PCI base address */
+    __uint64_t pal;                /* PCI address limit */
+    __uint64_t iota;               /* I/O Translation Anchor */
+#define FIB_DATA_ISC(x)    (((x) >> 28) & 0x7)
+#define FIB_DATA_NOI(x)    (((x) >> 16) & 0xfff)
+#define FIB_DATA_AIBVO(x) (((x) >> 8) & 0x3f)
+#define FIB_DATA_SUM(x)    (((x) >> 7) & 0x1)
+#define FIB_DATA_AISBO(x)  ((x) & 0x3f)
+    __uint32_t data;
+    __uint32_t reserved5;
+    __uint64_t aibv;               /* Adapter int bit vector address */
+    __uint64_t aisb;               /* Adapter int summary bit address */
+    __uint64_t fmb_addr;           /* Function measurement address and key */
+    __uint32_t reserved6;
+    __uint32_t gd;
+} QEMU_PACKED ZpciFib;
+
+#define PAGE_SHIFT      12
+#define PAGE_MASK       (~(PAGE_SIZE-1))
+#define PAGE_DEFAULT_ACC        0
+#define PAGE_DEFAULT_KEY        (PAGE_DEFAULT_ACC << 4)
+
+/* I/O Translation Anchor (IOTA) */
+enum ZpciIoatDtype {
+    ZPCI_IOTA_STO = 0,
+    ZPCI_IOTA_RTTO = 1,
+    ZPCI_IOTA_RSTO = 2,
+    ZPCI_IOTA_RFTO = 3,
+    ZPCI_IOTA_PFAA = 4,
+    ZPCI_IOTA_IOPFAA = 5,
+    ZPCI_IOTA_IOPTO = 7
+};
+
+#define ZPCI_IOTA_IOT_ENABLED           0x800UL
+#define ZPCI_IOTA_DT_ST                 (ZPCI_IOTA_STO  << 2)
+#define ZPCI_IOTA_DT_RT                 (ZPCI_IOTA_RTTO << 2)
+#define ZPCI_IOTA_DT_RS                 (ZPCI_IOTA_RSTO << 2)
+#define ZPCI_IOTA_DT_RF                 (ZPCI_IOTA_RFTO << 2)
+#define ZPCI_IOTA_DT_PF                 (ZPCI_IOTA_PFAA << 2)
+#define ZPCI_IOTA_FS_4K                 0
+#define ZPCI_IOTA_FS_1M                 1
+#define ZPCI_IOTA_FS_2G                 2
+#define ZPCI_KEY                        (PAGE_DEFAULT_KEY << 5)
+
+#define ZPCI_IOTA_STO_FLAG  (ZPCI_IOTA_IOT_ENABLED | ZPCI_KEY | ZPCI_IOTA_DT_ST)
+#define ZPCI_IOTA_RTTO_FLAG (ZPCI_IOTA_IOT_ENABLED | ZPCI_KEY | ZPCI_IOTA_DT_RT)
+#define ZPCI_IOTA_RSTO_FLAG (ZPCI_IOTA_IOT_ENABLED | ZPCI_KEY | ZPCI_IOTA_DT_RS)
+#define ZPCI_IOTA_RFTO_FLAG (ZPCI_IOTA_IOT_ENABLED | ZPCI_KEY | ZPCI_IOTA_DT_RF)
+#define ZPCI_IOTA_RFAA_FLAG (ZPCI_IOTA_IOT_ENABLED | ZPCI_KEY |\
+                             ZPCI_IOTA_DT_PF | ZPCI_IOTA_FS_2G)
+
+/* I/O Region and segment tables */
+#define ZPCI_INDEX_MASK         0x7ffUL
+
+#define ZPCI_TABLE_TYPE_MASK    0xc
+#define ZPCI_TABLE_TYPE_RFX     0xc
+#define ZPCI_TABLE_TYPE_RSX     0x8
+#define ZPCI_TABLE_TYPE_RTX     0x4
+#define ZPCI_TABLE_TYPE_SX      0x0
+
+#define ZPCI_TABLE_LEN_RFX      0x3
+#define ZPCI_TABLE_LEN_RSX      0x3
+#define ZPCI_TABLE_LEN_RTX      0x3
+
+#define ZPCI_TABLE_OFFSET_MASK  0xc0
+#define ZPCI_TABLE_SIZE         0x4000
+#define ZPCI_TABLE_ALIGN        ZPCI_TABLE_SIZE
+#define ZPCI_TABLE_ENTRY_SIZE   (sizeof(unsigned long))
+#define ZPCI_TABLE_ENTRIES      (ZPCI_TABLE_SIZE / ZPCI_TABLE_ENTRY_SIZE)
+
+#define ZPCI_TABLE_BITS         11
+#define ZPCI_PT_BITS            8
+#define ZPCI_ST_SHIFT           (ZPCI_PT_BITS + PAGE_SHIFT)
+#define ZPCI_RT_SHIFT           (ZPCI_ST_SHIFT + ZPCI_TABLE_BITS)
+
+#define ZPCI_RTE_FLAG_MASK      0x3fffUL
+#define ZPCI_RTE_ADDR_MASK      (~ZPCI_RTE_FLAG_MASK)
+#define ZPCI_STE_FLAG_MASK      0x7ffUL
+#define ZPCI_STE_ADDR_MASK      (~ZPCI_STE_FLAG_MASK)
+
+/* I/O Page tables */
+#define ZPCI_PTE_VALID_MASK             0x400
+#define ZPCI_PTE_INVALID                0x400
+#define ZPCI_PTE_VALID                  0x000
+#define ZPCI_PT_SIZE                    0x800
+#define ZPCI_PT_ALIGN                   ZPCI_PT_SIZE
+#define ZPCI_PT_ENTRIES                 (ZPCI_PT_SIZE / ZPCI_TABLE_ENTRY_SIZE)
+#define ZPCI_PT_MASK                    (ZPCI_PT_ENTRIES - 1)
+
+#define ZPCI_PTE_FLAG_MASK              0xfffUL
+#define ZPCI_PTE_ADDR_MASK              (~ZPCI_PTE_FLAG_MASK)
+
+/* Shared bits */
+#define ZPCI_TABLE_VALID                0x00
+#define ZPCI_TABLE_INVALID              0x20
+#define ZPCI_TABLE_PROTECTED            0x200
+#define ZPCI_TABLE_UNPROTECTED          0x000
+
+#define ZPCI_TABLE_VALID_MASK           0x20
+#define ZPCI_TABLE_PROT_MASK            0x200
+
+static inline unsigned int calc_rtx(dma_addr_t ptr)
+{
+    return ((unsigned long) ptr >> ZPCI_RT_SHIFT) & ZPCI_INDEX_MASK;
+}
+
+static inline unsigned int calc_sx(dma_addr_t ptr)
+{
+    return ((unsigned long) ptr >> ZPCI_ST_SHIFT) & ZPCI_INDEX_MASK;
+}
+
+static inline unsigned int calc_px(dma_addr_t ptr)
+{
+    return ((unsigned long) ptr >> PAGE_SHIFT) & ZPCI_PT_MASK;
+}
+
+static inline unsigned long *get_rt_sto(unsigned long entry)
+{
+    return ((entry & ZPCI_TABLE_TYPE_MASK) == ZPCI_TABLE_TYPE_RTX)
+                ? (unsigned long *) (entry & ZPCI_RTE_ADDR_MASK)
+                : NULL;
+}
+
+static inline unsigned long *get_st_pto(unsigned long entry)
+{
+    return ((entry & ZPCI_TABLE_TYPE_MASK) == ZPCI_TABLE_TYPE_SX)
+            ? (unsigned long *) (entry & ZPCI_STE_ADDR_MASK)
+            : NULL;
+}
+
+static inline uint64_t get_base_disp_rxy(S390CPU *cpu, struct kvm_run *run)
+{
+    CPUS390XState *env = &cpu->env;
+    uint32_t x2 = (run->s390_sieic.ipa & 0x000f);
+    uint32_t base2 = run->s390_sieic.ipb >> 28;
+    uint32_t disp2 = ((run->s390_sieic.ipb & 0x0fff0000) >> 16) +
+                     ((run->s390_sieic.ipb & 0xff00) << 4);
+
+    return (base2 ? env->regs[base2] : 0) +
+           (x2 ? env->regs[x2] : 0) + (__uint64_t)disp2;
+}
+
+static inline uint64_t get_base_disp_rsy(S390CPU *cpu, struct kvm_run *run)
+{
+    CPUS390XState *env = &cpu->env;
+    uint32_t base2 = run->s390_sieic.ipb >> 28;
+    uint32_t disp2 = ((run->s390_sieic.ipb & 0x0fff0000) >> 16) +
+                     ((run->s390_sieic.ipb & 0xff00) << 4);
+
+    if (disp2 & 0x80000) {
+        disp2 += 0xfff00000;
+    }
+
+    return (base2 ? env->regs[base2] : 0) + (long)(int)disp2;
+}
+
+int kvm_clp_service_call(S390CPU *cpu, struct kvm_run *run);
+int kvm_rpcit_service_call(S390CPU *cpu, struct kvm_run *run);
+int kvm_sic_service_call(S390CPU *cpu, struct kvm_run *run);
+int kvm_pcistb_service_call(S390CPU *cpu, struct kvm_run *run);
+int kvm_mpcifc_service_call(S390CPU *cpu, struct kvm_run *run);
+int kvm_pcistg_service_call(S390CPU *cpu, struct kvm_run *run);
+int kvm_pcilg_service_call(S390CPU *cpu, struct kvm_run *run);
+int kvm_stpcifc_service_call(S390CPU *cpu, struct kvm_run *run);
+
+#endif
