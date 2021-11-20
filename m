Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36827C433EF
	for <linux-s390@archiver.kernel.org>; Sat, 20 Nov 2021 14:48:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236753AbhKTOvR (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Sat, 20 Nov 2021 09:51:17 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33802 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231861AbhKTOvQ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Sat, 20 Nov 2021 09:51:16 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AKEkvIF027601;
        Sat, 20 Nov 2021 14:47:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : content-type : mime-version; s=pp1;
 bh=bn/Fs1zGkezAXf0sPnNsKM9s9UMpbfCpgJ3gHVWia0M=;
 b=esOoQ3/KauQf3Dl9BAdUpgblywouo3lX0mfA3QZU0VgWbGeIwGzIRYBezMs6mtNH7b3V
 BgzOMycVrRF6JSrWA14fQ1ig0gc9/Zgu7MijHjZvTBmYOl0eqrJqRkOYu+bt+PxKDyvs
 F/YoGsY37EiEL6ElyruAjomK1IwU1zNlPkK8TKq9kjti1H3fOsAXsSyeiLtxFVl32LUB
 UVuXs4wQVDbifT5do7xxH9+epaZ2IdiwKCW8nrU3R30zvk7QfHG7J7fnPVMx52ePtfpO
 OBRLjLwP92gmQjOJz4y2TA77qEptlI8YyTMRNAweLPU4IbO4/WZud5dUChv9736JaSyZ cw== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cf337r0f4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 20 Nov 2021 14:47:54 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AKEgbZZ003570;
        Sat, 20 Nov 2021 14:47:52 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06fra.de.ibm.com with ESMTP id 3cer9j2f87-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 20 Nov 2021 14:47:52 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1AKElmqB2491090
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 20 Nov 2021 14:47:48 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8C10C42042;
        Sat, 20 Nov 2021 14:47:48 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3034E4203F;
        Sat, 20 Nov 2021 14:47:48 +0000 (GMT)
Received: from osiris (unknown [9.145.36.246])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sat, 20 Nov 2021 14:47:48 +0000 (GMT)
Date:   Sat, 20 Nov 2021 15:47:46 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] s390 updates for 5.16-rc2
Message-ID: <YZkKklfvwaRkxwqz@osiris>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 6KpOGV1M5m8vduUpMaxF1Lhxp_SVWwpg
X-Proofpoint-ORIG-GUID: 6KpOGV1M5m8vduUpMaxF1Lhxp_SVWwpg
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-20_04,2021-11-17_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 phishscore=0 adultscore=0
 malwarescore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2111200094
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi Linus,

please pull s390 updates for 5.16-rc2. Besides the usual bunch of
fixes and trivial cleanups this also touches x86 and samples
code. This is required to add and rename a Kconfig option and fixes an
incorrect merge resolution proposed by me when you merged the first
round of s390 patches during the merge window.

This has been acked by Steven Rostedt:
https://lore.kernel.org/all/20211116174320.034c8901@gandalf.local.home/

Thanks,
Heiko

The following changes since commit fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf:

  Linux 5.16-rc1 (2021-11-14 13:56:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.16-3

for you to fetch changes up to 890e3dc8bb6ee630870560c34054692f7a45da42:

  ftrace/samples: add s390 support for ftrace direct multi sample (2021-11-18 17:50:54 +0100)

----------------------------------------------------------------
s390 updates for 5.16-rc2

- Add missing Kconfig option for ftrace direct multi sample, so it can
  be compiled again, and also add s390 support for this sample.

- Update Christian Borntraeger's email address.

- Various fixes for memory layout setup. Besides other this makes it
  possible to load shared DCSS segments again.

- Fix copy to user space of swapped kdump oldmem.

- Remove -mstack-guard and -mstack-size compile options when building
  vdso binaries. This can happen when CONFIG_VMAP_STACK is disabled
  and results in broken vdso code which causes more or less random
  exceptions. Also remove the not needed -nostdlib option.

- Fix memory leak on cpu hotplug and return code handling in kexec
  code.

- Wire up futex_waitv system call.

- Replace snprintf with sysfs_emit where appropriate.

----------------------------------------------------------------
Alexander Egorenkov (1):
      s390/dump: fix copying to user-space of swapped kdump oldmem

Baoquan He (1):
      s390/kexec: fix memory leak of ipl report buffer

Christian Borntraeger (1):
      MAINTAINERS: update email address of Christian Borntraeger

Heiko Carstens (3):
      s390/kexec: fix return code handling
      ftrace/samples: add missing Kconfig option for ftrace direct multi sample
      ftrace/samples: add s390 support for ftrace direct multi sample

Masahiro Yamada (1):
      s390/vdso: remove -nostdlib compiler flag

Qing Wang (1):
      s390: replace snprintf in show functions with sysfs_emit

Sven Schnelle (1):
      s390/vdso: filter out -mstack-guard and -mstack-size

Vasily Gorbik (5):
      s390/setup: avoid reserving memory above identity mapping
      s390/setup: avoid using memblock_enforce_memory_limit
      s390/setup: re-arrange memblock setup
      s390/boot: simplify and fix kernel memory layout setup
      s390: wire up sys_futex_waitv system call

 .mailmap                              |  3 ++
 MAINTAINERS                           |  4 +-
 arch/s390/Kconfig                     |  3 +-
 arch/s390/Makefile                    | 10 ++--
 arch/s390/boot/startup.c              | 88 ++++++++++++-----------------------
 arch/s390/include/asm/kexec.h         |  6 +++
 arch/s390/kernel/crash_dump.c         |  4 +-
 arch/s390/kernel/ipl.c                |  3 +-
 arch/s390/kernel/machine_kexec_file.c | 18 ++++++-
 arch/s390/kernel/setup.c              | 22 ++-------
 arch/s390/kernel/syscalls/syscall.tbl |  1 +
 arch/s390/kernel/vdso32/Makefile      |  2 +-
 arch/s390/kernel/vdso64/Makefile      |  7 +--
 arch/x86/Kconfig                      |  2 +-
 drivers/s390/block/dasd_devmap.c      | 76 +++++++++++++++---------------
 drivers/s390/char/raw3270.c           | 12 ++---
 drivers/s390/cio/chp.c                |  2 +-
 samples/Kconfig                       | 11 ++++-
 samples/Makefile                      |  2 +-
 samples/ftrace/Makefile               |  2 +-
 samples/ftrace/ftrace-direct-multi.c  | 30 ++++++++++++
 21 files changed, 170 insertions(+), 138 deletions(-)

diff --git a/.mailmap b/.mailmap
index 14314e3c5d5e..6277bb27b4bf 100644
--- a/.mailmap
+++ b/.mailmap
@@ -71,6 +71,9 @@ Chao Yu <chao@kernel.org> <chao2.yu@samsung.com>
 Chao Yu <chao@kernel.org> <yuchao0@huawei.com>
 Chris Chiu <chris.chiu@canonical.com> <chiu@endlessm.com>
 Chris Chiu <chris.chiu@canonical.com> <chiu@endlessos.org>
+Christian Borntraeger <borntraeger@linux.ibm.com> <borntraeger@de.ibm.com>
+Christian Borntraeger <borntraeger@linux.ibm.com> <cborntra@de.ibm.com>
+Christian Borntraeger <borntraeger@linux.ibm.com> <borntrae@de.ibm.com>
 Christophe Ricard <christophe.ricard@gmail.com>
 Christoph Hellwig <hch@lst.de>
 Colin Ian King <colin.king@intel.com> <colin.king@canonical.com>
diff --git a/MAINTAINERS b/MAINTAINERS
index 7a2345ce8521..b9a09edb3efb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10445,7 +10445,7 @@ F:	arch/riscv/include/uapi/asm/kvm*
 F:	arch/riscv/kvm/
 
 KERNEL VIRTUAL MACHINE for s390 (KVM/s390)
-M:	Christian Borntraeger <borntraeger@de.ibm.com>
+M:	Christian Borntraeger <borntraeger@linux.ibm.com>
 M:	Janosch Frank <frankja@linux.ibm.com>
 R:	David Hildenbrand <david@redhat.com>
 R:	Claudio Imbrenda <imbrenda@linux.ibm.com>
@@ -16573,7 +16573,7 @@ F:	drivers/video/fbdev/savage/
 S390
 M:	Heiko Carstens <hca@linux.ibm.com>
 M:	Vasily Gorbik <gor@linux.ibm.com>
-M:	Christian Borntraeger <borntraeger@de.ibm.com>
+M:	Christian Borntraeger <borntraeger@linux.ibm.com>
 R:	Alexander Gordeev <agordeev@linux.ibm.com>
 L:	linux-s390@vger.kernel.org
 S:	Supported
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 8857ec3b97eb..2a5bb4f29cfe 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -47,7 +47,7 @@ config ARCH_SUPPORTS_UPROBES
 config KASAN_SHADOW_OFFSET
 	hex
 	depends on KASAN
-	default 0x18000000000000
+	default 0x1C000000000000
 
 config S390
 	def_bool y
@@ -194,6 +194,7 @@ config S390
 	select HAVE_RELIABLE_STACKTRACE
 	select HAVE_RSEQ
 	select HAVE_SAMPLE_FTRACE_DIRECT
+	select HAVE_SAMPLE_FTRACE_DIRECT_MULTI
 	select HAVE_SOFTIRQ_ON_OWN_STACK
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_VIRT_CPU_ACCOUNTING
diff --git a/arch/s390/Makefile b/arch/s390/Makefile
index 69c45f600273..609e3697324b 100644
--- a/arch/s390/Makefile
+++ b/arch/s390/Makefile
@@ -77,10 +77,12 @@ KBUILD_AFLAGS_DECOMPRESSOR += $(aflags-y)
 KBUILD_CFLAGS_DECOMPRESSOR += $(cflags-y)
 
 ifneq ($(call cc-option,-mstack-size=8192 -mstack-guard=128),)
-cflags-$(CONFIG_CHECK_STACK) += -mstack-size=$(STACK_SIZE)
-ifeq ($(call cc-option,-mstack-size=8192),)
-cflags-$(CONFIG_CHECK_STACK) += -mstack-guard=$(CONFIG_STACK_GUARD)
-endif
+  CC_FLAGS_CHECK_STACK := -mstack-size=$(STACK_SIZE)
+  ifeq ($(call cc-option,-mstack-size=8192),)
+    CC_FLAGS_CHECK_STACK += -mstack-guard=$(CONFIG_STACK_GUARD)
+  endif
+  export CC_FLAGS_CHECK_STACK
+  cflags-$(CONFIG_CHECK_STACK) += $(CC_FLAGS_CHECK_STACK)
 endif
 
 ifdef CONFIG_EXPOLINE
diff --git a/arch/s390/boot/startup.c b/arch/s390/boot/startup.c
index 7571dee72a0c..1aa11a8f57dd 100644
--- a/arch/s390/boot/startup.c
+++ b/arch/s390/boot/startup.c
@@ -149,82 +149,56 @@ static void setup_ident_map_size(unsigned long max_physmem_end)
 
 static void setup_kernel_memory_layout(void)
 {
-	bool vmalloc_size_verified = false;
-	unsigned long vmemmap_off;
-	unsigned long vspace_left;
+	unsigned long vmemmap_start;
 	unsigned long rte_size;
 	unsigned long pages;
-	unsigned long vmax;
 
 	pages = ident_map_size / PAGE_SIZE;
 	/* vmemmap contains a multiple of PAGES_PER_SECTION struct pages */
 	vmemmap_size = SECTION_ALIGN_UP(pages) * sizeof(struct page);
 
 	/* choose kernel address space layout: 4 or 3 levels. */
-	vmemmap_off = round_up(ident_map_size, _REGION3_SIZE);
+	vmemmap_start = round_up(ident_map_size, _REGION3_SIZE);
 	if (IS_ENABLED(CONFIG_KASAN) ||
 	    vmalloc_size > _REGION2_SIZE ||
-	    vmemmap_off + vmemmap_size + vmalloc_size + MODULES_LEN > _REGION2_SIZE)
-		vmax = _REGION1_SIZE;
-	else
-		vmax = _REGION2_SIZE;
-
-	/* keep vmemmap_off aligned to a top level region table entry */
-	rte_size = vmax == _REGION1_SIZE ? _REGION2_SIZE : _REGION3_SIZE;
-	MODULES_END = vmax;
-	if (is_prot_virt_host()) {
-		/*
-		 * forcing modules and vmalloc area under the ultravisor
-		 * secure storage limit, so that any vmalloc allocation
-		 * we do could be used to back secure guest storage.
-		 */
-		adjust_to_uv_max(&MODULES_END);
-	}
-
-#ifdef CONFIG_KASAN
-	if (MODULES_END < vmax) {
-		/* force vmalloc and modules below kasan shadow */
-		MODULES_END = min(MODULES_END, KASAN_SHADOW_START);
+	    vmemmap_start + vmemmap_size + vmalloc_size + MODULES_LEN >
+		    _REGION2_SIZE) {
+		MODULES_END = _REGION1_SIZE;
+		rte_size = _REGION2_SIZE;
 	} else {
-		/*
-		 * leave vmalloc and modules above kasan shadow but make
-		 * sure they don't overlap with it
-		 */
-		vmalloc_size = min(vmalloc_size, vmax - KASAN_SHADOW_END - MODULES_LEN);
-		vmalloc_size_verified = true;
-		vspace_left = KASAN_SHADOW_START;
+		MODULES_END = _REGION2_SIZE;
+		rte_size = _REGION3_SIZE;
 	}
+	/*
+	 * forcing modules and vmalloc area under the ultravisor
+	 * secure storage limit, so that any vmalloc allocation
+	 * we do could be used to back secure guest storage.
+	 */
+	adjust_to_uv_max(&MODULES_END);
+#ifdef CONFIG_KASAN
+	/* force vmalloc and modules below kasan shadow */
+	MODULES_END = min(MODULES_END, KASAN_SHADOW_START);
 #endif
 	MODULES_VADDR = MODULES_END - MODULES_LEN;
 	VMALLOC_END = MODULES_VADDR;
 
-	if (vmalloc_size_verified) {
-		VMALLOC_START = VMALLOC_END - vmalloc_size;
-	} else {
-		vmemmap_off = round_up(ident_map_size, rte_size);
-
-		if (vmemmap_off + vmemmap_size > VMALLOC_END ||
-		    vmalloc_size > VMALLOC_END - vmemmap_off - vmemmap_size) {
-			/*
-			 * allow vmalloc area to occupy up to 1/2 of
-			 * the rest virtual space left.
-			 */
-			vmalloc_size = min(vmalloc_size, VMALLOC_END / 2);
-		}
-		VMALLOC_START = VMALLOC_END - vmalloc_size;
-		vspace_left = VMALLOC_START;
-	}
+	/* allow vmalloc area to occupy up to about 1/2 of the rest virtual space left */
+	vmalloc_size = min(vmalloc_size, round_down(VMALLOC_END / 2, _REGION3_SIZE));
+	VMALLOC_START = VMALLOC_END - vmalloc_size;
 
-	pages = vspace_left / (PAGE_SIZE + sizeof(struct page));
+	/* split remaining virtual space between 1:1 mapping & vmemmap array */
+	pages = VMALLOC_START / (PAGE_SIZE + sizeof(struct page));
 	pages = SECTION_ALIGN_UP(pages);
-	vmemmap_off = round_up(vspace_left - pages * sizeof(struct page), rte_size);
-	/* keep vmemmap left most starting from a fresh region table entry */
-	vmemmap_off = min(vmemmap_off, round_up(ident_map_size, rte_size));
-	/* take care that identity map is lower then vmemmap */
-	ident_map_size = min(ident_map_size, vmemmap_off);
+	/* keep vmemmap_start aligned to a top level region table entry */
+	vmemmap_start = round_down(VMALLOC_START - pages * sizeof(struct page), rte_size);
+	/* vmemmap_start is the future VMEM_MAX_PHYS, make sure it is within MAX_PHYSMEM */
+	vmemmap_start = min(vmemmap_start, 1UL << MAX_PHYSMEM_BITS);
+	/* make sure identity map doesn't overlay with vmemmap */
+	ident_map_size = min(ident_map_size, vmemmap_start);
 	vmemmap_size = SECTION_ALIGN_UP(ident_map_size / PAGE_SIZE) * sizeof(struct page);
-	VMALLOC_START = max(vmemmap_off + vmemmap_size, VMALLOC_START);
-	vmemmap = (struct page *)vmemmap_off;
+	/* make sure vmemmap doesn't overlay with vmalloc area */
+	VMALLOC_START = max(vmemmap_start + vmemmap_size, VMALLOC_START);
+	vmemmap = (struct page *)vmemmap_start;
 }
 
 /*
diff --git a/arch/s390/include/asm/kexec.h b/arch/s390/include/asm/kexec.h
index ea398a05f643..7f3c9ac34bd8 100644
--- a/arch/s390/include/asm/kexec.h
+++ b/arch/s390/include/asm/kexec.h
@@ -74,6 +74,12 @@ void *kexec_file_add_components(struct kimage *image,
 int arch_kexec_do_relocs(int r_type, void *loc, unsigned long val,
 			 unsigned long addr);
 
+#define ARCH_HAS_KIMAGE_ARCH
+
+struct kimage_arch {
+	void *ipl_buf;
+};
+
 extern const struct kexec_file_ops s390_kexec_image_ops;
 extern const struct kexec_file_ops s390_kexec_elf_ops;
 
diff --git a/arch/s390/kernel/crash_dump.c b/arch/s390/kernel/crash_dump.c
index d72a6df058d7..785d54c9350c 100644
--- a/arch/s390/kernel/crash_dump.c
+++ b/arch/s390/kernel/crash_dump.c
@@ -191,8 +191,8 @@ static int copy_oldmem_user(void __user *dst, void *src, size_t count)
 				return rc;
 		} else {
 			/* Check for swapped kdump oldmem areas */
-			if (oldmem_data.start && from - oldmem_data.size < oldmem_data.size) {
-				from -= oldmem_data.size;
+			if (oldmem_data.start && from - oldmem_data.start < oldmem_data.size) {
+				from -= oldmem_data.start;
 				len = min(count, oldmem_data.size - from);
 			} else if (oldmem_data.start && from < oldmem_data.size) {
 				len = min(count, oldmem_data.size - from);
diff --git a/arch/s390/kernel/ipl.c b/arch/s390/kernel/ipl.c
index e2cc35775b99..5ad1dde23dc5 100644
--- a/arch/s390/kernel/ipl.c
+++ b/arch/s390/kernel/ipl.c
@@ -2156,7 +2156,7 @@ void *ipl_report_finish(struct ipl_report *report)
 
 	buf = vzalloc(report->size);
 	if (!buf)
-		return ERR_PTR(-ENOMEM);
+		goto out;
 	ptr = buf;
 
 	memcpy(ptr, report->ipib, report->ipib->hdr.len);
@@ -2195,6 +2195,7 @@ void *ipl_report_finish(struct ipl_report *report)
 	}
 
 	BUG_ON(ptr > buf + report->size);
+out:
 	return buf;
 }
 
diff --git a/arch/s390/kernel/machine_kexec_file.c b/arch/s390/kernel/machine_kexec_file.c
index 528edff085d9..9975ad200d74 100644
--- a/arch/s390/kernel/machine_kexec_file.c
+++ b/arch/s390/kernel/machine_kexec_file.c
@@ -12,6 +12,7 @@
 #include <linux/kexec.h>
 #include <linux/module_signature.h>
 #include <linux/verification.h>
+#include <linux/vmalloc.h>
 #include <asm/boot_data.h>
 #include <asm/ipl.h>
 #include <asm/setup.h>
@@ -170,6 +171,7 @@ static int kexec_file_add_ipl_report(struct kimage *image,
 	struct kexec_buf buf;
 	unsigned long addr;
 	void *ptr, *end;
+	int ret;
 
 	buf.image = image;
 
@@ -199,9 +201,13 @@ static int kexec_file_add_ipl_report(struct kimage *image,
 		ptr += len;
 	}
 
+	ret = -ENOMEM;
 	buf.buffer = ipl_report_finish(data->report);
+	if (!buf.buffer)
+		goto out;
 	buf.bufsz = data->report->size;
 	buf.memsz = buf.bufsz;
+	image->arch.ipl_buf = buf.buffer;
 
 	data->memsz += buf.memsz;
 
@@ -209,7 +215,9 @@ static int kexec_file_add_ipl_report(struct kimage *image,
 		data->kernel_buf + offsetof(struct lowcore, ipl_parmblock_ptr);
 	*lc_ipl_parmblock_ptr = (__u32)buf.mem;
 
-	return kexec_add_buffer(&buf);
+	ret = kexec_add_buffer(&buf);
+out:
+	return ret;
 }
 
 void *kexec_file_add_components(struct kimage *image,
@@ -322,3 +330,11 @@ int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
 	}
 	return 0;
 }
+
+int arch_kimage_file_post_load_cleanup(struct kimage *image)
+{
+	vfree(image->arch.ipl_buf);
+	image->arch.ipl_buf = NULL;
+
+	return kexec_image_post_load_cleanup_default(image);
+}
diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
index 40405f2304f1..225ab2d0a4c6 100644
--- a/arch/s390/kernel/setup.c
+++ b/arch/s390/kernel/setup.c
@@ -606,7 +606,7 @@ static void __init setup_resources(void)
 
 static void __init setup_memory_end(void)
 {
-	memblock_remove(ident_map_size, ULONG_MAX);
+	memblock_remove(ident_map_size, PHYS_ADDR_MAX - ident_map_size);
 	max_pfn = max_low_pfn = PFN_DOWN(ident_map_size);
 	pr_notice("The maximum memory size is %luMB\n", ident_map_size >> 20);
 }
@@ -637,14 +637,6 @@ static struct notifier_block kdump_mem_nb = {
 
 #endif
 
-/*
- * Make sure that the area above identity mapping is protected
- */
-static void __init reserve_above_ident_map(void)
-{
-	memblock_reserve(ident_map_size, ULONG_MAX);
-}
-
 /*
  * Reserve memory for kdump kernel to be loaded with kexec
  */
@@ -785,7 +777,6 @@ static void __init memblock_add_mem_detect_info(void)
 	}
 	memblock_set_bottom_up(false);
 	memblock_set_node(0, ULONG_MAX, &memblock.memory, 0);
-	memblock_dump_all();
 }
 
 /*
@@ -826,9 +817,6 @@ static void __init setup_memory(void)
 		storage_key_init_range(start, end);
 
 	psw_set_key(PAGE_DEFAULT_KEY);
-
-	/* Only cosmetics */
-	memblock_enforce_memory_limit(memblock_end_of_DRAM());
 }
 
 static void __init relocate_amode31_section(void)
@@ -999,24 +987,24 @@ void __init setup_arch(char **cmdline_p)
 	setup_control_program_code();
 
 	/* Do some memory reservations *before* memory is added to memblock */
-	reserve_above_ident_map();
 	reserve_kernel();
 	reserve_initrd();
 	reserve_certificate_list();
 	reserve_mem_detect_info();
+	memblock_set_current_limit(ident_map_size);
 	memblock_allow_resize();
 
 	/* Get information about *all* installed memory */
 	memblock_add_mem_detect_info();
 
 	free_mem_detect_info();
+	setup_memory_end();
+	memblock_dump_all();
+	setup_memory();
 
 	relocate_amode31_section();
 	setup_cr();
-
 	setup_uv();
-	setup_memory_end();
-	setup_memory();
 	dma_contiguous_reserve(ident_map_size);
 	vmcp_cma_reserve();
 	if (MACHINE_HAS_EDAT2)
diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
index df5261e5cfe1..ed9c5c2eafad 100644
--- a/arch/s390/kernel/syscalls/syscall.tbl
+++ b/arch/s390/kernel/syscalls/syscall.tbl
@@ -451,3 +451,4 @@
 446  common	landlock_restrict_self	sys_landlock_restrict_self	sys_landlock_restrict_self
 # 447 reserved for memfd_secret
 448  common	process_mrelease	sys_process_mrelease		sys_process_mrelease
+449  common	futex_waitv		sys_futex_waitv			sys_futex_waitv
diff --git a/arch/s390/kernel/vdso32/Makefile b/arch/s390/kernel/vdso32/Makefile
index e3e6ac5686df..245bddfe9bc0 100644
--- a/arch/s390/kernel/vdso32/Makefile
+++ b/arch/s390/kernel/vdso32/Makefile
@@ -22,7 +22,7 @@ KBUILD_AFLAGS_32 += -m31 -s
 KBUILD_CFLAGS_32 := $(filter-out -m64,$(KBUILD_CFLAGS))
 KBUILD_CFLAGS_32 += -m31 -fPIC -shared -fno-common -fno-builtin
 
-LDFLAGS_vdso32.so.dbg += -fPIC -shared -nostdlib -soname=linux-vdso32.so.1 \
+LDFLAGS_vdso32.so.dbg += -fPIC -shared -soname=linux-vdso32.so.1 \
 	--hash-style=both --build-id=sha1 -melf_s390 -T
 
 $(targets:%=$(obj)/%.dbg): KBUILD_CFLAGS = $(KBUILD_CFLAGS_32)
diff --git a/arch/s390/kernel/vdso64/Makefile b/arch/s390/kernel/vdso64/Makefile
index 6568de236701..9e2b95a222a9 100644
--- a/arch/s390/kernel/vdso64/Makefile
+++ b/arch/s390/kernel/vdso64/Makefile
@@ -8,8 +8,9 @@ ARCH_REL_TYPE_ABS += R_390_GOT|R_390_PLT
 include $(srctree)/lib/vdso/Makefile
 obj-vdso64 = vdso_user_wrapper.o note.o
 obj-cvdso64 = vdso64_generic.o getcpu.o
-CFLAGS_REMOVE_getcpu.o = -pg $(CC_FLAGS_FTRACE) $(CC_FLAGS_EXPOLINE)
-CFLAGS_REMOVE_vdso64_generic.o = -pg $(CC_FLAGS_FTRACE) $(CC_FLAGS_EXPOLINE)
+VDSO_CFLAGS_REMOVE := -pg $(CC_FLAGS_FTRACE) $(CC_FLAGS_EXPOLINE) $(CC_FLAGS_CHECK_STACK)
+CFLAGS_REMOVE_getcpu.o = $(VDSO_CFLAGS_REMOVE)
+CFLAGS_REMOVE_vdso64_generic.o = $(VDSO_CFLAGS_REMOVE)
 
 # Build rules
 
@@ -25,7 +26,7 @@ KBUILD_AFLAGS_64 += -m64 -s
 
 KBUILD_CFLAGS_64 := $(filter-out -m64,$(KBUILD_CFLAGS))
 KBUILD_CFLAGS_64 += -m64 -fPIC -shared -fno-common -fno-builtin
-ldflags-y := -fPIC -shared -nostdlib -soname=linux-vdso64.so.1 \
+ldflags-y := -fPIC -shared -soname=linux-vdso64.so.1 \
 	     --hash-style=both --build-id=sha1 -T
 
 $(targets:%=$(obj)/%.dbg): KBUILD_CFLAGS = $(KBUILD_CFLAGS_64)
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 95dd1ee01546..7399327d1eff 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -193,7 +193,7 @@ config X86
 	select HAVE_DYNAMIC_FTRACE_WITH_ARGS	if X86_64
 	select HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 	select HAVE_SAMPLE_FTRACE_DIRECT	if X86_64
-	select HAVE_SAMPLE_FTRACE_MULTI_DIRECT	if X86_64
+	select HAVE_SAMPLE_FTRACE_DIRECT_MULTI	if X86_64
 	select HAVE_EBPF_JIT
 	select HAVE_EFFICIENT_UNALIGNED_ACCESS
 	select HAVE_EISA
diff --git a/drivers/s390/block/dasd_devmap.c b/drivers/s390/block/dasd_devmap.c
index 2c40fe15da55..6043c832d09e 100644
--- a/drivers/s390/block/dasd_devmap.c
+++ b/drivers/s390/block/dasd_devmap.c
@@ -731,7 +731,7 @@ static ssize_t dasd_ff_show(struct device *dev, struct device_attribute *attr,
 		ff_flag = (devmap->features & DASD_FEATURE_FAILFAST) != 0;
 	else
 		ff_flag = (DASD_FEATURE_DEFAULT & DASD_FEATURE_FAILFAST) != 0;
-	return snprintf(buf, PAGE_SIZE, ff_flag ? "1\n" : "0\n");
+	return sysfs_emit(buf, ff_flag ? "1\n" : "0\n");
 }
 
 static ssize_t dasd_ff_store(struct device *dev, struct device_attribute *attr,
@@ -773,7 +773,7 @@ dasd_ro_show(struct device *dev, struct device_attribute *attr, char *buf)
 	spin_unlock(&dasd_devmap_lock);
 
 out:
-	return snprintf(buf, PAGE_SIZE, ro_flag ? "1\n" : "0\n");
+	return sysfs_emit(buf, ro_flag ? "1\n" : "0\n");
 }
 
 static ssize_t
@@ -834,7 +834,7 @@ dasd_erplog_show(struct device *dev, struct device_attribute *attr, char *buf)
 		erplog = (devmap->features & DASD_FEATURE_ERPLOG) != 0;
 	else
 		erplog = (DASD_FEATURE_DEFAULT & DASD_FEATURE_ERPLOG) != 0;
-	return snprintf(buf, PAGE_SIZE, erplog ? "1\n" : "0\n");
+	return sysfs_emit(buf, erplog ? "1\n" : "0\n");
 }
 
 static ssize_t
@@ -1033,13 +1033,13 @@ dasd_discipline_show(struct device *dev, struct device_attribute *attr,
 		dasd_put_device(device);
 		goto out;
 	} else {
-		len = snprintf(buf, PAGE_SIZE, "%s\n",
-			       device->discipline->name);
+		len = sysfs_emit(buf, "%s\n",
+				 device->discipline->name);
 		dasd_put_device(device);
 		return len;
 	}
 out:
-	len = snprintf(buf, PAGE_SIZE, "none\n");
+	len = sysfs_emit(buf, "none\n");
 	return len;
 }
 
@@ -1056,30 +1056,30 @@ dasd_device_status_show(struct device *dev, struct device_attribute *attr,
 	if (!IS_ERR(device)) {
 		switch (device->state) {
 		case DASD_STATE_NEW:
-			len = snprintf(buf, PAGE_SIZE, "new\n");
+			len = sysfs_emit(buf, "new\n");
 			break;
 		case DASD_STATE_KNOWN:
-			len = snprintf(buf, PAGE_SIZE, "detected\n");
+			len = sysfs_emit(buf, "detected\n");
 			break;
 		case DASD_STATE_BASIC:
-			len = snprintf(buf, PAGE_SIZE, "basic\n");
+			len = sysfs_emit(buf, "basic\n");
 			break;
 		case DASD_STATE_UNFMT:
-			len = snprintf(buf, PAGE_SIZE, "unformatted\n");
+			len = sysfs_emit(buf, "unformatted\n");
 			break;
 		case DASD_STATE_READY:
-			len = snprintf(buf, PAGE_SIZE, "ready\n");
+			len = sysfs_emit(buf, "ready\n");
 			break;
 		case DASD_STATE_ONLINE:
-			len = snprintf(buf, PAGE_SIZE, "online\n");
+			len = sysfs_emit(buf, "online\n");
 			break;
 		default:
-			len = snprintf(buf, PAGE_SIZE, "no stat\n");
+			len = sysfs_emit(buf, "no stat\n");
 			break;
 		}
 		dasd_put_device(device);
 	} else
-		len = snprintf(buf, PAGE_SIZE, "unknown\n");
+		len = sysfs_emit(buf, "unknown\n");
 	return len;
 }
 
@@ -1120,7 +1120,7 @@ static ssize_t dasd_vendor_show(struct device *dev,
 	device = dasd_device_from_cdev(to_ccwdev(dev));
 	vendor = "";
 	if (IS_ERR(device))
-		return snprintf(buf, PAGE_SIZE, "%s\n", vendor);
+		return sysfs_emit(buf, "%s\n", vendor);
 
 	if (device->discipline && device->discipline->get_uid &&
 	    !device->discipline->get_uid(device, &uid))
@@ -1128,7 +1128,7 @@ static ssize_t dasd_vendor_show(struct device *dev,
 
 	dasd_put_device(device);
 
-	return snprintf(buf, PAGE_SIZE, "%s\n", vendor);
+	return sysfs_emit(buf, "%s\n", vendor);
 }
 
 static DEVICE_ATTR(vendor, 0444, dasd_vendor_show, NULL);
@@ -1148,7 +1148,7 @@ dasd_uid_show(struct device *dev, struct device_attribute *attr, char *buf)
 	device = dasd_device_from_cdev(to_ccwdev(dev));
 	uid_string[0] = 0;
 	if (IS_ERR(device))
-		return snprintf(buf, PAGE_SIZE, "%s\n", uid_string);
+		return sysfs_emit(buf, "%s\n", uid_string);
 
 	if (device->discipline && device->discipline->get_uid &&
 	    !device->discipline->get_uid(device, &uid)) {
@@ -1183,7 +1183,7 @@ dasd_uid_show(struct device *dev, struct device_attribute *attr, char *buf)
 	}
 	dasd_put_device(device);
 
-	return snprintf(buf, PAGE_SIZE, "%s\n", uid_string);
+	return sysfs_emit(buf, "%s\n", uid_string);
 }
 static DEVICE_ATTR(uid, 0444, dasd_uid_show, NULL);
 
@@ -1201,7 +1201,7 @@ dasd_eer_show(struct device *dev, struct device_attribute *attr, char *buf)
 		eer_flag = dasd_eer_enabled(devmap->device);
 	else
 		eer_flag = 0;
-	return snprintf(buf, PAGE_SIZE, eer_flag ? "1\n" : "0\n");
+	return sysfs_emit(buf, eer_flag ? "1\n" : "0\n");
 }
 
 static ssize_t
@@ -1243,7 +1243,7 @@ dasd_expires_show(struct device *dev, struct device_attribute *attr, char *buf)
 	device = dasd_device_from_cdev(to_ccwdev(dev));
 	if (IS_ERR(device))
 		return -ENODEV;
-	len = snprintf(buf, PAGE_SIZE, "%lu\n", device->default_expires);
+	len = sysfs_emit(buf, "%lu\n", device->default_expires);
 	dasd_put_device(device);
 	return len;
 }
@@ -1283,7 +1283,7 @@ dasd_retries_show(struct device *dev, struct device_attribute *attr, char *buf)
 	device = dasd_device_from_cdev(to_ccwdev(dev));
 	if (IS_ERR(device))
 		return -ENODEV;
-	len = snprintf(buf, PAGE_SIZE, "%lu\n", device->default_retries);
+	len = sysfs_emit(buf, "%lu\n", device->default_retries);
 	dasd_put_device(device);
 	return len;
 }
@@ -1324,7 +1324,7 @@ dasd_timeout_show(struct device *dev, struct device_attribute *attr,
 	device = dasd_device_from_cdev(to_ccwdev(dev));
 	if (IS_ERR(device))
 		return -ENODEV;
-	len = snprintf(buf, PAGE_SIZE, "%lu\n", device->blk_timeout);
+	len = sysfs_emit(buf, "%lu\n", device->blk_timeout);
 	dasd_put_device(device);
 	return len;
 }
@@ -1398,11 +1398,11 @@ static ssize_t dasd_hpf_show(struct device *dev, struct device_attribute *attr,
 		return -ENODEV;
 	if (!device->discipline || !device->discipline->hpf_enabled) {
 		dasd_put_device(device);
-		return snprintf(buf, PAGE_SIZE, "%d\n", dasd_nofcx);
+		return sysfs_emit(buf, "%d\n", dasd_nofcx);
 	}
 	hpf = device->discipline->hpf_enabled(device);
 	dasd_put_device(device);
-	return snprintf(buf, PAGE_SIZE, "%d\n", hpf);
+	return sysfs_emit(buf, "%d\n", hpf);
 }
 
 static DEVICE_ATTR(hpf, 0444, dasd_hpf_show, NULL);
@@ -1416,13 +1416,13 @@ static ssize_t dasd_reservation_policy_show(struct device *dev,
 
 	devmap = dasd_find_busid(dev_name(dev));
 	if (IS_ERR(devmap)) {
-		rc = snprintf(buf, PAGE_SIZE, "ignore\n");
+		rc = sysfs_emit(buf, "ignore\n");
 	} else {
 		spin_lock(&dasd_devmap_lock);
 		if (devmap->features & DASD_FEATURE_FAILONSLCK)
-			rc = snprintf(buf, PAGE_SIZE, "fail\n");
+			rc = sysfs_emit(buf, "fail\n");
 		else
-			rc = snprintf(buf, PAGE_SIZE, "ignore\n");
+			rc = sysfs_emit(buf, "ignore\n");
 		spin_unlock(&dasd_devmap_lock);
 	}
 	return rc;
@@ -1457,14 +1457,14 @@ static ssize_t dasd_reservation_state_show(struct device *dev,
 
 	device = dasd_device_from_cdev(to_ccwdev(dev));
 	if (IS_ERR(device))
-		return snprintf(buf, PAGE_SIZE, "none\n");
+		return sysfs_emit(buf, "none\n");
 
 	if (test_bit(DASD_FLAG_IS_RESERVED, &device->flags))
-		rc = snprintf(buf, PAGE_SIZE, "reserved\n");
+		rc = sysfs_emit(buf, "reserved\n");
 	else if (test_bit(DASD_FLAG_LOCK_STOLEN, &device->flags))
-		rc = snprintf(buf, PAGE_SIZE, "lost\n");
+		rc = sysfs_emit(buf, "lost\n");
 	else
-		rc = snprintf(buf, PAGE_SIZE, "none\n");
+		rc = sysfs_emit(buf, "none\n");
 	dasd_put_device(device);
 	return rc;
 }
@@ -1531,7 +1531,7 @@ dasd_path_threshold_show(struct device *dev,
 	device = dasd_device_from_cdev(to_ccwdev(dev));
 	if (IS_ERR(device))
 		return -ENODEV;
-	len = snprintf(buf, PAGE_SIZE, "%lu\n", device->path_thrhld);
+	len = sysfs_emit(buf, "%lu\n", device->path_thrhld);
 	dasd_put_device(device);
 	return len;
 }
@@ -1578,7 +1578,7 @@ dasd_path_autodisable_show(struct device *dev,
 	else
 		flag = (DASD_FEATURE_DEFAULT &
 			DASD_FEATURE_PATH_AUTODISABLE) != 0;
-	return snprintf(buf, PAGE_SIZE, flag ? "1\n" : "0\n");
+	return sysfs_emit(buf, flag ? "1\n" : "0\n");
 }
 
 static ssize_t
@@ -1616,7 +1616,7 @@ dasd_path_interval_show(struct device *dev,
 	device = dasd_device_from_cdev(to_ccwdev(dev));
 	if (IS_ERR(device))
 		return -ENODEV;
-	len = snprintf(buf, PAGE_SIZE, "%lu\n", device->path_interval);
+	len = sysfs_emit(buf, "%lu\n", device->path_interval);
 	dasd_put_device(device);
 	return len;
 }
@@ -1662,9 +1662,9 @@ dasd_device_fcs_show(struct device *dev, struct device_attribute *attr,
 		return -ENODEV;
 	fc_sec = dasd_path_get_fcs_device(device);
 	if (fc_sec == -EINVAL)
-		rc = snprintf(buf, PAGE_SIZE, "Inconsistent\n");
+		rc = sysfs_emit(buf, "Inconsistent\n");
 	else
-		rc = snprintf(buf, PAGE_SIZE, "%s\n", dasd_path_get_fcs_str(fc_sec));
+		rc = sysfs_emit(buf, "%s\n", dasd_path_get_fcs_str(fc_sec));
 	dasd_put_device(device);
 
 	return rc;
@@ -1677,7 +1677,7 @@ dasd_path_fcs_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
 	struct dasd_path *path = to_dasd_path(kobj);
 	unsigned int fc_sec = path->fc_security;
 
-	return snprintf(buf, PAGE_SIZE, "%s\n", dasd_path_get_fcs_str(fc_sec));
+	return sysfs_emit(buf, "%s\n", dasd_path_get_fcs_str(fc_sec));
 }
 
 static struct kobj_attribute path_fcs_attribute =
@@ -1698,7 +1698,7 @@ static ssize_t dasd_##_name##_show(struct device *dev,			\
 		val = _func(device);					\
 	dasd_put_device(device);					\
 									\
-	return snprintf(buf, PAGE_SIZE, "%d\n", val);			\
+	return sysfs_emit(buf, "%d\n", val);			\
 }									\
 static DEVICE_ATTR(_name, 0444, dasd_##_name##_show, NULL);		\
 
diff --git a/drivers/s390/char/raw3270.c b/drivers/s390/char/raw3270.c
index 646ec796bb83..dfde0d941c3c 100644
--- a/drivers/s390/char/raw3270.c
+++ b/drivers/s390/char/raw3270.c
@@ -1047,24 +1047,24 @@ raw3270_probe (struct ccw_device *cdev)
 static ssize_t
 raw3270_model_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%i\n",
-			((struct raw3270 *) dev_get_drvdata(dev))->model);
+	return sysfs_emit(buf, "%i\n",
+			  ((struct raw3270 *)dev_get_drvdata(dev))->model);
 }
 static DEVICE_ATTR(model, 0444, raw3270_model_show, NULL);
 
 static ssize_t
 raw3270_rows_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%i\n",
-			((struct raw3270 *) dev_get_drvdata(dev))->rows);
+	return sysfs_emit(buf, "%i\n",
+			  ((struct raw3270 *)dev_get_drvdata(dev))->rows);
 }
 static DEVICE_ATTR(rows, 0444, raw3270_rows_show, NULL);
 
 static ssize_t
 raw3270_columns_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%i\n",
-			((struct raw3270 *) dev_get_drvdata(dev))->cols);
+	return sysfs_emit(buf, "%i\n",
+			  ((struct raw3270 *)dev_get_drvdata(dev))->cols);
 }
 static DEVICE_ATTR(columns, 0444, raw3270_columns_show, NULL);
 
diff --git a/drivers/s390/cio/chp.c b/drivers/s390/cio/chp.c
index 1097e76982a5..5440f285f349 100644
--- a/drivers/s390/cio/chp.c
+++ b/drivers/s390/cio/chp.c
@@ -285,7 +285,7 @@ static ssize_t chp_configure_show(struct device *dev,
 	if (status < 0)
 		return status;
 
-	return snprintf(buf, PAGE_SIZE, "%d\n", status);
+	return sysfs_emit(buf, "%d\n", status);
 }
 
 static int cfg_wait_idle(void);
diff --git a/samples/Kconfig b/samples/Kconfig
index bec3528aa2de..43d2e9aa557f 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -31,6 +31,15 @@ config SAMPLE_FTRACE_DIRECT
 	  This builds an ftrace direct function example
 	  that hooks to wake_up_process and prints the parameters.
 
+config SAMPLE_FTRACE_DIRECT_MULTI
+	tristate "Build register_ftrace_direct_multi() example"
+	depends on DYNAMIC_FTRACE_WITH_DIRECT_CALLS && m
+	depends on HAVE_SAMPLE_FTRACE_DIRECT_MULTI
+	help
+	  This builds an ftrace direct function example
+	  that hooks to wake_up_process and schedule, and prints
+	  the function addresses.
+
 config SAMPLE_TRACE_ARRAY
         tristate "Build sample module for kernel access to Ftrace instancess"
 	depends on EVENT_TRACING && m
@@ -237,5 +246,5 @@ endif # SAMPLES
 config HAVE_SAMPLE_FTRACE_DIRECT
 	bool
 
-config HAVE_SAMPLE_FTRACE_MULTI_DIRECT
+config HAVE_SAMPLE_FTRACE_DIRECT_MULTI
 	bool
diff --git a/samples/Makefile b/samples/Makefile
index b7b98307c2b4..4bcd6b93bffa 100644
--- a/samples/Makefile
+++ b/samples/Makefile
@@ -22,7 +22,7 @@ subdir-$(CONFIG_SAMPLE_TIMER)		+= timers
 obj-$(CONFIG_SAMPLE_TRACE_EVENTS)	+= trace_events/
 obj-$(CONFIG_SAMPLE_TRACE_PRINTK)	+= trace_printk/
 obj-$(CONFIG_SAMPLE_FTRACE_DIRECT)	+= ftrace/
-obj-$(CONFIG_SAMPLE_FTRACE_MULTI_DIRECT) += ftrace/
+obj-$(CONFIG_SAMPLE_FTRACE_DIRECT_MULTI) += ftrace/
 obj-$(CONFIG_SAMPLE_TRACE_ARRAY)	+= ftrace/
 subdir-$(CONFIG_SAMPLE_UHID)		+= uhid
 obj-$(CONFIG_VIDEO_PCI_SKELETON)	+= v4l/
diff --git a/samples/ftrace/Makefile b/samples/ftrace/Makefile
index e8a3f8520a44..b9198e2eef28 100644
--- a/samples/ftrace/Makefile
+++ b/samples/ftrace/Makefile
@@ -3,7 +3,7 @@
 obj-$(CONFIG_SAMPLE_FTRACE_DIRECT) += ftrace-direct.o
 obj-$(CONFIG_SAMPLE_FTRACE_DIRECT) += ftrace-direct-too.o
 obj-$(CONFIG_SAMPLE_FTRACE_DIRECT) += ftrace-direct-modify.o
-obj-$(CONFIG_SAMPLE_FTRACE_MULTI_DIRECT) += ftrace-direct-multi.o
+obj-$(CONFIG_SAMPLE_FTRACE_DIRECT_MULTI) += ftrace-direct-multi.o
 
 CFLAGS_sample-trace-array.o := -I$(src)
 obj-$(CONFIG_SAMPLE_TRACE_ARRAY) += sample-trace-array.o
diff --git a/samples/ftrace/ftrace-direct-multi.c b/samples/ftrace/ftrace-direct-multi.c
index b6d7806b400e..2fafc9afcbf0 100644
--- a/samples/ftrace/ftrace-direct-multi.c
+++ b/samples/ftrace/ftrace-direct-multi.c
@@ -4,6 +4,7 @@
 #include <linux/mm.h> /* for handle_mm_fault() */
 #include <linux/ftrace.h>
 #include <linux/sched/stat.h>
+#include <asm/asm-offsets.h>
 
 extern void my_direct_func(unsigned long ip);
 
@@ -14,6 +15,8 @@ void my_direct_func(unsigned long ip)
 
 extern void my_tramp(void *);
 
+#ifdef CONFIG_X86_64
+
 asm (
 "	.pushsection    .text, \"ax\", @progbits\n"
 "	.type		my_tramp, @function\n"
@@ -31,6 +34,33 @@ asm (
 "	.popsection\n"
 );
 
+#endif /* CONFIG_X86_64 */
+
+#ifdef CONFIG_S390
+
+asm (
+"	.pushsection	.text, \"ax\", @progbits\n"
+"	.type		my_tramp, @function\n"
+"	.globl		my_tramp\n"
+"   my_tramp:"
+"	lgr		%r1,%r15\n"
+"	stmg		%r0,%r5,"__stringify(__SF_GPRS)"(%r15)\n"
+"	stg		%r14,"__stringify(__SF_GPRS+8*8)"(%r15)\n"
+"	aghi		%r15,"__stringify(-STACK_FRAME_OVERHEAD)"\n"
+"	stg		%r1,"__stringify(__SF_BACKCHAIN)"(%r15)\n"
+"	lgr		%r2,%r0\n"
+"	brasl		%r14,my_direct_func\n"
+"	aghi		%r15,"__stringify(STACK_FRAME_OVERHEAD)"\n"
+"	lmg		%r0,%r5,"__stringify(__SF_GPRS)"(%r15)\n"
+"	lg		%r14,"__stringify(__SF_GPRS+8*8)"(%r15)\n"
+"	lgr		%r1,%r0\n"
+"	br		%r1\n"
+"	.size		my_tramp, .-my_tramp\n"
+"	.popsection\n"
+);
+
+#endif /* CONFIG_S390 */
+
 static struct ftrace_ops direct;
 
 static int __init ftrace_direct_multi_init(void)
