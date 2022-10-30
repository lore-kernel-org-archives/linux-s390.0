Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFFEFECAAA1
	for <linux-s390@archiver.kernel.org>; Sun, 30 Oct 2022 18:22:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbiJ3SWU (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Sun, 30 Oct 2022 14:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbiJ3SWT (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sun, 30 Oct 2022 14:22:19 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB6A5B854
        for <linux-s390@vger.kernel.org>; Sun, 30 Oct 2022 11:22:18 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29UDkg35004578;
        Sun, 30 Oct 2022 18:22:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=zIoTWuen4ZrZqY3T64H1KYNmxzw5GiUs2dPpkzdesP8=;
 b=kUAfCh/DGCm4gs3qW97kAfaFoKvr5oK2mgEvkA9BQ0aJwaJKw+qaK9bGPnd/59OJMMIx
 yGsaH9YSsEgkkamBu8/DE/z1EsBTHtB67evvsRhq6HxoaNBB0N9YVSn10DXV9oY0JSeL
 Hhp4czwoc7u+ooh1dJF4QNux7HQc3lmwjTwVke/u3CAwQMaHih+EDH4l5s21H+OACZTZ
 5DmqIexGLpX0CnWPo1m43AhsGbdxF3KbMRPFTnFoPZRPv++gHvNr1vJhSIhk0fX6Avs7
 LY9AHNSQ7h31H1NVrutzvpGI42qk6W42HCX0HXX/fhPTDNiHfP/KXCzICHKum9IoeObT lA== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3khe6ug925-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 30 Oct 2022 18:22:09 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29UIM1dh031753;
        Sun, 30 Oct 2022 18:22:07 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03ams.nl.ibm.com with ESMTP id 3kgut8su3y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 30 Oct 2022 18:22:07 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29UIM2jH31588964
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 30 Oct 2022 18:22:02 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7E888AE051;
        Sun, 30 Oct 2022 18:22:02 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 34A4AAE045;
        Sun, 30 Oct 2022 18:22:02 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun, 30 Oct 2022 18:22:02 +0000 (GMT)
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Nathan Chancellor <nathan@kernel.org>
Cc:     Sven Schnelle <svens@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        linux-s390@vger.kernel.org
Subject: [PATCH] s390: always build relocatable kernel
Date:   Sun, 30 Oct 2022 19:22:02 +0100
Message-Id: <20221030182202.2062705-1-hca@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Guc8KgieGb6L9boNQKfHfaoF-5nuT6np
X-Proofpoint-GUID: Guc8KgieGb6L9boNQKfHfaoF-5nuT6np
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-30_11,2022-10-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 adultscore=0 spamscore=0 mlxlogscore=999 clxscore=1011
 phishscore=0 mlxscore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2210300116
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Nathan Chancellor reported several link errors on s390 with
CONFIG_RELOCATABLE disabled, after binutils commit 906f69cf65da ("IBM
zSystems: Issue error for *DBL relocs on misaligned symbols"). The binutils
commit reveals potential miscompiles that might have happened already
before with linker script defined symbols at odd addresses.

A similar bug was recently fixed in the kernel with commit c9305b6c1f52
("s390: fix nospec table alignments").

See https://github.com/ClangBuiltLinux/linux/issues/1747 for an analysis
from Ulich Weigand.

Therefore always build a relocatable kernel to avoid this problem. There is
hardly any use-case for non-relocatable kernels, so this shouldn't be
controversial.

Link: https://github.com/ClangBuiltLinux/linux/issues/1747
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/Kconfig        | 6 +++---
 arch/s390/Makefile       | 2 --
 arch/s390/boot/Makefile  | 3 +--
 arch/s390/boot/startup.c | 3 +--
 4 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 318fce77601d..de575af02ffe 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -568,8 +568,7 @@ config EXPOLINE_FULL
 endchoice
 
 config RELOCATABLE
-	bool "Build a relocatable kernel"
-	default y
+	def_bool y
 	help
 	  This builds a kernel image that retains relocation information
 	  so it can be loaded at an arbitrary address.
@@ -578,10 +577,11 @@ config RELOCATABLE
 	  bootup process.
 	  The relocations make the kernel image about 15% larger (compressed
 	  10%), but are discarded at runtime.
+	  Note: this option exists only for documentation purposes, please do
+	  not remove it.
 
 config RANDOMIZE_BASE
 	bool "Randomize the address of the kernel image (KASLR)"
-	depends on RELOCATABLE
 	default y
 	help
 	  In support of Kernel Address Space Layout Randomization (KASLR),
diff --git a/arch/s390/Makefile b/arch/s390/Makefile
index de6d8b2ea4d8..b3235ab0ace8 100644
--- a/arch/s390/Makefile
+++ b/arch/s390/Makefile
@@ -14,10 +14,8 @@ KBUILD_AFLAGS_MODULE += -fPIC
 KBUILD_CFLAGS_MODULE += -fPIC
 KBUILD_AFLAGS	+= -m64
 KBUILD_CFLAGS	+= -m64
-ifeq ($(CONFIG_RELOCATABLE),y)
 KBUILD_CFLAGS	+= -fPIE
 LDFLAGS_vmlinux	:= -pie
-endif
 aflags_dwarf	:= -Wa,-gdwarf-2
 KBUILD_AFLAGS_DECOMPRESSOR := $(CLANG_FLAGS) -m64 -D__ASSEMBLY__
 ifndef CONFIG_AS_IS_LLVM
diff --git a/arch/s390/boot/Makefile b/arch/s390/boot/Makefile
index 883357a211a3..d52c3e2e16bc 100644
--- a/arch/s390/boot/Makefile
+++ b/arch/s390/boot/Makefile
@@ -37,9 +37,8 @@ CFLAGS_sclp_early_core.o += -I$(srctree)/drivers/s390/char
 
 obj-y	:= head.o als.o startup.o mem_detect.o ipl_parm.o ipl_report.o
 obj-y	+= string.o ebcdic.o sclp_early_core.o mem.o ipl_vmparm.o cmdline.o
-obj-y	+= version.o pgm_check_info.o ctype.o ipl_data.o
+obj-y	+= version.o pgm_check_info.o ctype.o ipl_data.o machine_kexec_reloc.o
 obj-$(findstring y, $(CONFIG_PROTECTED_VIRTUALIZATION_GUEST) $(CONFIG_PGSTE))	+= uv.o
-obj-$(CONFIG_RELOCATABLE)	+= machine_kexec_reloc.o
 obj-$(CONFIG_RANDOMIZE_BASE)	+= kaslr.o
 obj-y	+= $(if $(CONFIG_KERNEL_UNCOMPRESSED),,decompressor.o) info.o
 obj-$(CONFIG_KERNEL_ZSTD) += clz_ctz.o
diff --git a/arch/s390/boot/startup.c b/arch/s390/boot/startup.c
index 6e7f01ca53e6..47ca3264c023 100644
--- a/arch/s390/boot/startup.c
+++ b/arch/s390/boot/startup.c
@@ -291,8 +291,7 @@ void startup_kernel(void)
 
 	clear_bss_section();
 	copy_bootdata();
-	if (IS_ENABLED(CONFIG_RELOCATABLE))
-		handle_relocs(__kaslr_offset);
+	handle_relocs(__kaslr_offset);
 
 	if (__kaslr_offset) {
 		/*
-- 
2.34.1

