Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57356 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726442AbgCIIvf (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 9 Mar 2020 04:51:35 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0298oRuT056814
        for <linux-s390@vger.kernel.org>; Mon, 9 Mar 2020 04:51:34 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ym8k7cx49-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 09 Mar 2020 04:51:34 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Mon, 9 Mar 2020 08:51:32 -0000
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 02/36] s390/protvirt: add ultravisor initialization
Date: Mon,  9 Mar 2020 09:50:52 +0100
In-Reply-To: <20200309085126.3334302-1-borntraeger@de.ibm.com>
References: <20200309085126.3334302-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20200309085126.3334302-3-borntraeger@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Ulrich Weigand <uweigand@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>

From: Vasily Gorbik <gor@linux.ibm.com>

Before being able to host protected virtual machines, donate some of
the memory to the ultravisor. Besides that the ultravisor might impose
addressing limitations for memory used to back protected VM storage. Treat
that limit as protected virtualization host's virtual memory limit.

Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
[borntraeger@de.ibm.com: patch merging, splitting, fixing]
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/uv.h | 15 ++++++++++++
 arch/s390/kernel/setup.c   |  5 ++++
 arch/s390/kernel/uv.c      | 48 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 68 insertions(+)

diff --git a/arch/s390/include/asm/uv.h b/arch/s390/include/asm/uv.h
index c6a330740e5d..1af6ce8023cc 100644
--- a/arch/s390/include/asm/uv.h
+++ b/arch/s390/include/asm/uv.h
@@ -23,12 +23,14 @@
 #define UVC_RC_NO_RESUME	0x0007
 
 #define UVC_CMD_QUI			0x0001
+#define UVC_CMD_INIT_UV			0x000f
 #define UVC_CMD_SET_SHARED_ACCESS	0x1000
 #define UVC_CMD_REMOVE_SHARED_ACCESS	0x1001
 
 /* Bits in installed uv calls */
 enum uv_cmds_inst {
 	BIT_UVC_CMD_QUI = 0,
+	BIT_UVC_CMD_INIT_UV = 1,
 	BIT_UVC_CMD_SET_SHARED_ACCESS = 8,
 	BIT_UVC_CMD_REMOVE_SHARED_ACCESS = 9,
 };
@@ -59,6 +61,14 @@ struct uv_cb_qui {
 	u8  reserveda0[200 - 160];
 } __packed __aligned(8);
 
+struct uv_cb_init {
+	struct uv_cb_header header;
+	u64 reserved08[2];
+	u64 stor_origin;
+	u64 stor_len;
+	u64 reserved28[4];
+} __packed __aligned(8);
+
 struct uv_cb_share {
 	struct uv_cb_header header;
 	u64 reserved08[3];
@@ -160,8 +170,13 @@ static inline int is_prot_virt_host(void)
 {
 	return prot_virt_host;
 }
+
+void setup_uv(void);
+void adjust_to_uv_max(unsigned long *vmax);
 #else
 #define is_prot_virt_host() 0
+static inline void setup_uv(void) {}
+static inline void adjust_to_uv_max(unsigned long *vmax) {}
 #endif
 
 #if defined(CONFIG_PROTECTED_VIRTUALIZATION_GUEST) || IS_ENABLED(CONFIG_KVM)
diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
index a2496382175e..1423090a2259 100644
--- a/arch/s390/kernel/setup.c
+++ b/arch/s390/kernel/setup.c
@@ -560,6 +560,9 @@ static void __init setup_memory_end(void)
 			vmax = _REGION1_SIZE; /* 4-level kernel page table */
 	}
 
+	if (is_prot_virt_host())
+		adjust_to_uv_max(&vmax);
+
 	/* module area is at the end of the kernel address space. */
 	MODULES_END = vmax;
 	MODULES_VADDR = MODULES_END - MODULES_LEN;
@@ -1134,6 +1137,8 @@ void __init setup_arch(char **cmdline_p)
 	 */
 	memblock_trim_memory(1UL << (MAX_ORDER - 1 + PAGE_SHIFT));
 
+	if (is_prot_virt_host())
+		setup_uv();
 	setup_memory_end();
 	setup_memory();
 	dma_contiguous_reserve(memory_end);
diff --git a/arch/s390/kernel/uv.c b/arch/s390/kernel/uv.c
index b1f936710360..1ddc42154ef6 100644
--- a/arch/s390/kernel/uv.c
+++ b/arch/s390/kernel/uv.c
@@ -49,4 +49,52 @@ static int __init prot_virt_setup(char *val)
 	return rc;
 }
 early_param("prot_virt", prot_virt_setup);
+
+static int __init uv_init(unsigned long stor_base, unsigned long stor_len)
+{
+	struct uv_cb_init uvcb = {
+		.header.cmd = UVC_CMD_INIT_UV,
+		.header.len = sizeof(uvcb),
+		.stor_origin = stor_base,
+		.stor_len = stor_len,
+	};
+
+	if (uv_call(0, (uint64_t)&uvcb)) {
+		pr_err("Ultravisor init failed with rc: 0x%x rrc: 0%x\n",
+		       uvcb.header.rc, uvcb.header.rrc);
+		return -1;
+	}
+	return 0;
+}
+
+void __init setup_uv(void)
+{
+	unsigned long uv_stor_base;
+
+	uv_stor_base = (unsigned long)memblock_alloc_try_nid(
+		uv_info.uv_base_stor_len, SZ_1M, SZ_2G,
+		MEMBLOCK_ALLOC_ACCESSIBLE, NUMA_NO_NODE);
+	if (!uv_stor_base) {
+		pr_warn("Failed to reserve %lu bytes for ultravisor base storage\n",
+			uv_info.uv_base_stor_len);
+		goto fail;
+	}
+
+	if (uv_init(uv_stor_base, uv_info.uv_base_stor_len)) {
+		memblock_free(uv_stor_base, uv_info.uv_base_stor_len);
+		goto fail;
+	}
+
+	pr_info("Reserving %luMB as ultravisor base storage\n",
+		uv_info.uv_base_stor_len >> 20);
+	return;
+fail:
+	pr_info("Disabling support for protected virtualization");
+	prot_virt_host = 0;
+}
+
+void adjust_to_uv_max(unsigned long *vmax)
+{
+	*vmax = min_t(unsigned long, *vmax, uv_info.max_sec_stor_addr);
+}
 #endif
-- 
2.24.1
