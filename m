Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C714C4338F
	for <linux-s390@archiver.kernel.org>; Thu,  5 Aug 2021 13:21:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D321E60F70
	for <linux-s390@archiver.kernel.org>; Thu,  5 Aug 2021 13:21:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240105AbhHENVi (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 5 Aug 2021 09:21:38 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42982 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240012AbhHENVh (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 5 Aug 2021 09:21:37 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 175D4bpO103370;
        Thu, 5 Aug 2021 09:21:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : content-type : mime-version; s=pp1;
 bh=czGNwzAmBBPQrAr+wTcny3WfotWQW1tMs+/n39L1onM=;
 b=bu7zCj27WIMku9rJAEMjcmkTQpOHq4/2fVS8BHYB6zAb5BvhKldWZTOjow10gA4pjQpU
 gfPzeB7xk8uVUml+WRTYUldEBj2Wqpp+nNxLre7vXKbJKqAtHMEDjUQiL+cbRxJFeXXX
 bRsvr9CbO4Go/thV/JkB3/pdwSmF8XDMYGPZQEW6MBnc5dF3rliv+yTVP0Rum690Zmpz
 P2Ok22PA31uYrUgKdB0UWKA1kXbWUI7EGjoBnDebjyBkPaafVlGbsHMaL0q5aeJPM81T
 00uAwHzQIxX/LZyLW4YU09VI6oxeuiHD/YyXQ1DuuuDj65uZ/C6GZeKW9p1P5f5pVhMg jQ== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3a89fmm37k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Aug 2021 09:21:22 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 175DDc5Q027008;
        Thu, 5 Aug 2021 13:21:20 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06ams.nl.ibm.com with ESMTP id 3a4wshu9nm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Aug 2021 13:21:20 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 175DLG8n52756946
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 5 Aug 2021 13:21:17 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C16BD42075;
        Thu,  5 Aug 2021 13:21:16 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7F9BD4205E;
        Thu,  5 Aug 2021 13:21:16 +0000 (GMT)
Received: from osiris (unknown [9.145.187.100])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu,  5 Aug 2021 13:21:16 +0000 (GMT)
Date:   Thu, 5 Aug 2021 15:21:15 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] s390 updates for 5.14-rc5
Message-ID: <YQvly2QgTY+KVfRH@osiris>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: iYW-yJa4AHJncRXjQMLAjQyrkgoth_DV
X-Proofpoint-GUID: iYW-yJa4AHJncRXjQMLAjQyrkgoth_DV
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-05_04:2021-08-05,2021-08-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 adultscore=0 malwarescore=0
 impostorscore=0 mlxscore=0 mlxlogscore=999 lowpriorityscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108050080
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi Linus,

please pull some small updates for s390.

Thanks,
Heiko

The following changes since commit ff1176468d368232b684f75e82563369208bc371:

  Linux 5.14-rc3 (2021-07-25 15:35:14 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.14-4

for you to fetch changes up to ecd92e2167c30faa18df21e3ec3dbec510ddebaa:

  s390: update defconfigs (2021-08-03 14:31:24 +0200)

----------------------------------------------------------------
s390 updates for 5.14-rc5

- fix zstd build for -march=z900 (undefined reference to __clzdi2)

- add missing .got.plts to vdso linker scripts to fix kpatch build errors

- update defconfigs

----------------------------------------------------------------
Heiko Carstens (1):
      s390: update defconfigs

Sumanth Korikkar (1):
      s390/vdso: add .got.plt in vdso linker script

Vasily Gorbik (1):
      s390/boot: fix zstd build for -march=z900

 arch/s390/boot/compressed/Makefile   | 1 +
 arch/s390/boot/compressed/clz_ctz.c  | 2 ++
 arch/s390/configs/debug_defconfig    | 2 +-
 arch/s390/configs/defconfig          | 2 +-
 arch/s390/kernel/vdso32/vdso32.lds.S | 1 +
 arch/s390/kernel/vdso64/vdso64.lds.S | 1 +
 6 files changed, 7 insertions(+), 2 deletions(-)
 create mode 100644 arch/s390/boot/compressed/clz_ctz.c

diff --git a/arch/s390/boot/compressed/Makefile b/arch/s390/boot/compressed/Makefile
index 660c799d875d..e30d3fdbbc78 100644
--- a/arch/s390/boot/compressed/Makefile
+++ b/arch/s390/boot/compressed/Makefile
@@ -11,6 +11,7 @@ UBSAN_SANITIZE := n
 KASAN_SANITIZE := n
 
 obj-y	:= $(if $(CONFIG_KERNEL_UNCOMPRESSED),,decompressor.o) info.o
+obj-$(CONFIG_KERNEL_ZSTD) += clz_ctz.o
 obj-all := $(obj-y) piggy.o syms.o
 targets	:= vmlinux.lds vmlinux vmlinux.bin vmlinux.bin.gz vmlinux.bin.bz2
 targets += vmlinux.bin.xz vmlinux.bin.lzma vmlinux.bin.lzo vmlinux.bin.lz4
diff --git a/arch/s390/boot/compressed/clz_ctz.c b/arch/s390/boot/compressed/clz_ctz.c
new file mode 100644
index 000000000000..c3ebf248596b
--- /dev/null
+++ b/arch/s390/boot/compressed/clz_ctz.c
@@ -0,0 +1,2 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "../../../../lib/clz_ctz.c"
diff --git a/arch/s390/configs/debug_defconfig b/arch/s390/configs/debug_defconfig
index 7de253f766e8..b88184019af9 100644
--- a/arch/s390/configs/debug_defconfig
+++ b/arch/s390/configs/debug_defconfig
@@ -335,7 +335,7 @@ CONFIG_L2TP_DEBUGFS=m
 CONFIG_L2TP_V3=y
 CONFIG_L2TP_IP=m
 CONFIG_L2TP_ETH=m
-CONFIG_BRIDGE=m
+CONFIG_BRIDGE=y
 CONFIG_BRIDGE_MRP=y
 CONFIG_VLAN_8021Q=m
 CONFIG_VLAN_8021Q_GVRP=y
diff --git a/arch/s390/configs/defconfig b/arch/s390/configs/defconfig
index b671642967ba..1667a3cdcf0a 100644
--- a/arch/s390/configs/defconfig
+++ b/arch/s390/configs/defconfig
@@ -325,7 +325,7 @@ CONFIG_L2TP_DEBUGFS=m
 CONFIG_L2TP_V3=y
 CONFIG_L2TP_IP=m
 CONFIG_L2TP_ETH=m
-CONFIG_BRIDGE=m
+CONFIG_BRIDGE=y
 CONFIG_BRIDGE_MRP=y
 CONFIG_VLAN_8021Q=m
 CONFIG_VLAN_8021Q_GVRP=y
diff --git a/arch/s390/kernel/vdso32/vdso32.lds.S b/arch/s390/kernel/vdso32/vdso32.lds.S
index bff50b6acd6d..edf5ff1debe1 100644
--- a/arch/s390/kernel/vdso32/vdso32.lds.S
+++ b/arch/s390/kernel/vdso32/vdso32.lds.S
@@ -51,6 +51,7 @@ SECTIONS
 
 	.rela.dyn ALIGN(8) : { *(.rela.dyn) }
 	.got ALIGN(8)	: { *(.got .toc) }
+	.got.plt ALIGN(8) : { *(.got.plt) }
 
 	_end = .;
 	PROVIDE(end = .);
diff --git a/arch/s390/kernel/vdso64/vdso64.lds.S b/arch/s390/kernel/vdso64/vdso64.lds.S
index d4fb336d747b..4461ea151e49 100644
--- a/arch/s390/kernel/vdso64/vdso64.lds.S
+++ b/arch/s390/kernel/vdso64/vdso64.lds.S
@@ -51,6 +51,7 @@ SECTIONS
 
 	.rela.dyn ALIGN(8) : { *(.rela.dyn) }
 	.got ALIGN(8)	: { *(.got .toc) }
+	.got.plt ALIGN(8) : { *(.got.plt) }
 
 	_end = .;
 	PROVIDE(end = .);
