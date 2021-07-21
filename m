Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	UPPERCASE_50_75 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85F7BC12002
	for <linux-s390@archiver.kernel.org>; Wed, 21 Jul 2021 18:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6072A60FF1
	for <linux-s390@archiver.kernel.org>; Wed, 21 Jul 2021 18:47:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237499AbhGUSHA (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 21 Jul 2021 14:07:00 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60366 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231535AbhGUSG7 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 21 Jul 2021 14:06:59 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16LIihnR163366;
        Wed, 21 Jul 2021 14:47:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : content-type : mime-version; s=pp1;
 bh=eTKkZ66XjPrp5y7gE20MF4Ce4liTDLMF0T6x6wuhK5Y=;
 b=B/pGv/4Am4vBuDnb5/iE0w7IfeFXpqe9n78OGZck4PU41uN4diRFW9ziZMKGV5+xhJXt
 S61XQPkkNOl8nMEgaWI/m+LY+OWhDZqEVz3dLJ6qk/hVHbpHq6DzKV3czb8zqcW6jnLZ
 Zy+fZKrWTSMW0Vhv8Kp7UG5KG3z6vlfyEdeJxrsPZ9x8DPzW/8NCnqzkPgMs7tU18Kvi
 uCYCGM3Z+Xr5Ty6U/oH/ym+yjJm7urWxdGbCfYLJKkeOZaZrtu0bGEYASTDcZTfoPSh5
 Z4KIJ7hIWHPbzSWbKMtvR9XQiNIVEKbfaQN0e0wGNwiIZn3NZiNwLiGLJMlhiVk8RRcF aA== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0b-001b2d01.pphosted.com with ESMTP id 39xs4j81yh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Jul 2021 14:47:34 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16LIhYwM001228;
        Wed, 21 Jul 2021 18:47:33 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma01fra.de.ibm.com with ESMTP id 39upu897q5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Jul 2021 18:47:32 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16LIlTaJ18874680
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Jul 2021 18:47:29 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B3281A4062;
        Wed, 21 Jul 2021 18:47:29 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 64D8BA405C;
        Wed, 21 Jul 2021 18:47:29 +0000 (GMT)
Received: from osiris (unknown [9.145.67.186])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 21 Jul 2021 18:47:29 +0000 (GMT)
Date:   Wed, 21 Jul 2021 20:47:27 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] s390 updates for 5.14-rc3
Message-ID: <YPhrv8YEX7pVo73Y@osiris>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: SDKOP-zjzupggpah_YiPXYgXTqXTDDtR
X-Proofpoint-ORIG-GUID: SDKOP-zjzupggpah_YiPXYgXTqXTDDtR
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-21_10:2021-07-21,2021-07-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 clxscore=1011 malwarescore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 mlxlogscore=999 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107210109
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi Linus,

please pull some s390 updates for 5.14-rc3.

Thanks,
Heiko

The following changes since commit e73f0f0ee7541171d89f2e2491130c7771ba58d3:

  Linux 5.14-rc1 (2021-07-11 15:07:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.14-3

for you to fetch changes up to 0cde560a8bfc3cb790715f39d4535129cca9e6ae:

  s390: update defconfigs (2021-07-20 17:59:40 +0200)

----------------------------------------------------------------
s390 updates for 5.14-rc3

- fix / add expoline usage in "DMA" code

- fix compat vdso Makefile to avoid permanent rebuild

- fix ftrace_update_ftrace_func to avoid NULL pointer dereference

- update defconfigs

- trivial coding style fix

----------------------------------------------------------------
Alexander Egorenkov (1):
      s390/boot: fix use of expolines in the DMA code

Christian Borntraeger (1):
      s390/defconfig: allow early device mapper disks

Heiko Carstens (1):
      s390: update defconfigs

Sven Schnelle (1):
      s390/vdso32: add vdso32.lds to targets

Vasily Gorbik (1):
      s390/ftrace: fix ftrace_update_ftrace_func implementation

kernel test robot (1):
      s390/cpumf: fix semicolon.cocci warnings

 arch/s390/boot/text_dma.S            | 19 ++++---------------
 arch/s390/configs/debug_defconfig    | 27 ++++++++++++++++++---------
 arch/s390/configs/defconfig          | 27 +++++++++++++++++++--------
 arch/s390/configs/zfcpdump_defconfig |  3 +--
 arch/s390/include/asm/ftrace.h       |  1 +
 arch/s390/kernel/ftrace.c            |  2 ++
 arch/s390/kernel/mcount.S            |  4 ++--
 arch/s390/kernel/perf_cpum_cf.c      |  2 +-
 arch/s390/kernel/vdso32/Makefile     |  1 +
 9 files changed, 49 insertions(+), 37 deletions(-)

diff --git a/arch/s390/boot/text_dma.S b/arch/s390/boot/text_dma.S
index f7c77cd518f2..5ff5fee02801 100644
--- a/arch/s390/boot/text_dma.S
+++ b/arch/s390/boot/text_dma.S
@@ -9,16 +9,6 @@
 #include <asm/errno.h>
 #include <asm/sigp.h>
 
-#ifdef CC_USING_EXPOLINE
-	.pushsection .dma.text.__s390_indirect_jump_r14,"axG"
-__dma__s390_indirect_jump_r14:
-	larl	%r1,0f
-	ex	0,0(%r1)
-	j	.
-0:	br	%r14
-	.popsection
-#endif
-
 	.section .dma.text,"ax"
 /*
  * Simplified version of expoline thunk. The normal thunks can not be used here,
@@ -27,11 +17,10 @@ __dma__s390_indirect_jump_r14:
  * affects a few functions that are not performance-relevant.
  */
 	.macro BR_EX_DMA_r14
-#ifdef CC_USING_EXPOLINE
-	jg	__dma__s390_indirect_jump_r14
-#else
-	br	%r14
-#endif
+	larl	%r1,0f
+	ex	0,0(%r1)
+	j	.
+0:	br	%r14
 	.endm
 
 /*
diff --git a/arch/s390/configs/debug_defconfig b/arch/s390/configs/debug_defconfig
index 86afcc6b56bf..7de253f766e8 100644
--- a/arch/s390/configs/debug_defconfig
+++ b/arch/s390/configs/debug_defconfig
@@ -5,7 +5,12 @@ CONFIG_WATCH_QUEUE=y
 CONFIG_AUDIT=y
 CONFIG_NO_HZ_IDLE=y
 CONFIG_HIGH_RES_TIMERS=y
+CONFIG_BPF_SYSCALL=y
+CONFIG_BPF_JIT=y
+CONFIG_BPF_JIT_ALWAYS_ON=y
+CONFIG_BPF_LSM=y
 CONFIG_PREEMPT=y
+CONFIG_SCHED_CORE=y
 CONFIG_BSD_PROCESS_ACCT=y
 CONFIG_BSD_PROCESS_ACCT_V3=y
 CONFIG_TASKSTATS=y
@@ -28,14 +33,13 @@ CONFIG_CGROUP_DEVICE=y
 CONFIG_CGROUP_CPUACCT=y
 CONFIG_CGROUP_PERF=y
 CONFIG_CGROUP_BPF=y
+CONFIG_CGROUP_MISC=y
 CONFIG_NAMESPACES=y
 CONFIG_USER_NS=y
 CONFIG_CHECKPOINT_RESTORE=y
 CONFIG_SCHED_AUTOGROUP=y
 CONFIG_EXPERT=y
 # CONFIG_SYSFS_SYSCALL is not set
-CONFIG_BPF_LSM=y
-CONFIG_BPF_SYSCALL=y
 CONFIG_USERFAULTFD=y
 # CONFIG_COMPAT_BRK is not set
 CONFIG_PROFILING=y
@@ -76,6 +80,7 @@ CONFIG_BLK_DEV_THROTTLING=y
 CONFIG_BLK_WBT=y
 CONFIG_BLK_CGROUP_IOLATENCY=y
 CONFIG_BLK_CGROUP_IOCOST=y
+CONFIG_BLK_CGROUP_IOPRIO=y
 CONFIG_BLK_INLINE_ENCRYPTION=y
 CONFIG_BLK_INLINE_ENCRYPTION_FALLBACK=y
 CONFIG_PARTITION_ADVANCED=y
@@ -95,6 +100,7 @@ CONFIG_CLEANCACHE=y
 CONFIG_FRONTSWAP=y
 CONFIG_CMA_DEBUG=y
 CONFIG_CMA_DEBUGFS=y
+CONFIG_CMA_SYSFS=y
 CONFIG_CMA_AREAS=7
 CONFIG_MEM_SOFT_DIRTY=y
 CONFIG_ZSWAP=y
@@ -158,6 +164,7 @@ CONFIG_IPV6_RPL_LWTUNNEL=y
 CONFIG_MPTCP=y
 CONFIG_NETFILTER=y
 CONFIG_BRIDGE_NETFILTER=m
+CONFIG_NETFILTER_NETLINK_HOOK=m
 CONFIG_NF_CONNTRACK=m
 CONFIG_NF_CONNTRACK_SECMARK=y
 CONFIG_NF_CONNTRACK_EVENTS=y
@@ -280,6 +287,7 @@ CONFIG_IP_VS_FTP=m
 CONFIG_IP_VS_PE_SIP=m
 CONFIG_NFT_FIB_IPV4=m
 CONFIG_NF_TABLES_ARP=y
+CONFIG_NF_LOG_IPV4=m
 CONFIG_IP_NF_IPTABLES=m
 CONFIG_IP_NF_MATCH_AH=m
 CONFIG_IP_NF_MATCH_ECN=m
@@ -384,12 +392,11 @@ CONFIG_VSOCKETS=m
 CONFIG_VIRTIO_VSOCKETS=m
 CONFIG_NETLINK_DIAG=m
 CONFIG_CGROUP_NET_PRIO=y
-CONFIG_BPF_JIT=y
 CONFIG_NET_PKTGEN=m
 CONFIG_PCI=y
-CONFIG_PCI_IOV=y
 # CONFIG_PCIEASPM is not set
 CONFIG_PCI_DEBUG=y
+CONFIG_PCI_IOV=y
 CONFIG_HOTPLUG_PCI=y
 CONFIG_HOTPLUG_PCI_S390=y
 CONFIG_DEVTMPFS=y
@@ -436,7 +443,7 @@ CONFIG_MD_MULTIPATH=m
 CONFIG_MD_FAULTY=m
 CONFIG_MD_CLUSTER=m
 CONFIG_BCACHE=m
-CONFIG_BLK_DEV_DM=m
+CONFIG_BLK_DEV_DM=y
 CONFIG_DM_UNSTRIPED=m
 CONFIG_DM_CRYPT=m
 CONFIG_DM_SNAPSHOT=m
@@ -453,6 +460,7 @@ CONFIG_DM_MULTIPATH_ST=m
 CONFIG_DM_MULTIPATH_HST=m
 CONFIG_DM_MULTIPATH_IOA=m
 CONFIG_DM_DELAY=m
+CONFIG_DM_INIT=y
 CONFIG_DM_UEVENT=y
 CONFIG_DM_FLAKEY=m
 CONFIG_DM_VERITY=m
@@ -495,6 +503,7 @@ CONFIG_NLMON=m
 # CONFIG_NET_VENDOR_GOOGLE is not set
 # CONFIG_NET_VENDOR_HUAWEI is not set
 # CONFIG_NET_VENDOR_INTEL is not set
+# CONFIG_NET_VENDOR_MICROSOFT is not set
 # CONFIG_NET_VENDOR_MARVELL is not set
 CONFIG_MLX4_EN=m
 CONFIG_MLX5_CORE=m
@@ -551,7 +560,6 @@ CONFIG_INPUT_EVDEV=y
 CONFIG_LEGACY_PTY_COUNT=0
 CONFIG_VIRTIO_CONSOLE=m
 CONFIG_HW_RANDOM_VIRTIO=m
-CONFIG_RAW_DRIVER=m
 CONFIG_HANGCHECK_TIMER=m
 CONFIG_TN3270_FS=y
 CONFIG_PPS=m
@@ -574,7 +582,6 @@ CONFIG_SYNC_FILE=y
 CONFIG_VFIO=m
 CONFIG_VFIO_PCI=m
 CONFIG_VFIO_MDEV=m
-CONFIG_VFIO_MDEV_DEVICE=m
 CONFIG_VIRTIO_PCI=m
 CONFIG_VIRTIO_BALLOON=m
 CONFIG_VIRTIO_INPUT=y
@@ -619,6 +626,7 @@ CONFIG_FUSE_FS=y
 CONFIG_CUSE=m
 CONFIG_VIRTIO_FS=m
 CONFIG_OVERLAY_FS=m
+CONFIG_NETFS_STATS=y
 CONFIG_FSCACHE=m
 CONFIG_CACHEFILES=m
 CONFIG_ISO9660_FS=y
@@ -654,7 +662,6 @@ CONFIG_NFSD_V3_ACL=y
 CONFIG_NFSD_V4=y
 CONFIG_NFSD_V4_SECURITY_LABEL=y
 CONFIG_CIFS=m
-CONFIG_CIFS_STATS2=y
 CONFIG_CIFS_WEAK_PW_HASH=y
 CONFIG_CIFS_UPCALL=y
 CONFIG_CIFS_XATTR=y
@@ -682,6 +689,7 @@ CONFIG_SECURITY_SELINUX_BOOTPARAM=y
 CONFIG_SECURITY_SELINUX_DISABLE=y
 CONFIG_SECURITY_LOCKDOWN_LSM=y
 CONFIG_SECURITY_LOCKDOWN_LSM_EARLY=y
+CONFIG_SECURITY_LANDLOCK=y
 CONFIG_INTEGRITY_SIGNATURE=y
 CONFIG_INTEGRITY_ASYMMETRIC_KEYS=y
 CONFIG_IMA=y
@@ -696,6 +704,7 @@ CONFIG_CRYPTO_CRYPTD=m
 CONFIG_CRYPTO_TEST=m
 CONFIG_CRYPTO_DH=m
 CONFIG_CRYPTO_ECDH=m
+CONFIG_CRYPTO_ECDSA=m
 CONFIG_CRYPTO_ECRDSA=m
 CONFIG_CRYPTO_SM2=m
 CONFIG_CRYPTO_CURVE25519=m
@@ -843,7 +852,6 @@ CONFIG_FAULT_INJECTION_DEBUG_FS=y
 CONFIG_FAIL_FUNCTION=y
 CONFIG_FAULT_INJECTION_STACKTRACE_FILTER=y
 CONFIG_LKDTM=m
-CONFIG_TEST_LIST_SORT=y
 CONFIG_TEST_MIN_HEAP=y
 CONFIG_TEST_SORT=y
 CONFIG_KPROBES_SANITY_TEST=y
@@ -853,3 +861,4 @@ CONFIG_PERCPU_TEST=m
 CONFIG_ATOMIC64_SELFTEST=y
 CONFIG_TEST_BITOPS=m
 CONFIG_TEST_BPF=m
+CONFIG_TEST_LIVEPATCH=m
diff --git a/arch/s390/configs/defconfig b/arch/s390/configs/defconfig
index 71b49ea5b058..b671642967ba 100644
--- a/arch/s390/configs/defconfig
+++ b/arch/s390/configs/defconfig
@@ -4,6 +4,11 @@ CONFIG_WATCH_QUEUE=y
 CONFIG_AUDIT=y
 CONFIG_NO_HZ_IDLE=y
 CONFIG_HIGH_RES_TIMERS=y
+CONFIG_BPF_SYSCALL=y
+CONFIG_BPF_JIT=y
+CONFIG_BPF_JIT_ALWAYS_ON=y
+CONFIG_BPF_LSM=y
+CONFIG_SCHED_CORE=y
 CONFIG_BSD_PROCESS_ACCT=y
 CONFIG_BSD_PROCESS_ACCT_V3=y
 CONFIG_TASKSTATS=y
@@ -26,14 +31,13 @@ CONFIG_CGROUP_DEVICE=y
 CONFIG_CGROUP_CPUACCT=y
 CONFIG_CGROUP_PERF=y
 CONFIG_CGROUP_BPF=y
+CONFIG_CGROUP_MISC=y
 CONFIG_NAMESPACES=y
 CONFIG_USER_NS=y
 CONFIG_CHECKPOINT_RESTORE=y
 CONFIG_SCHED_AUTOGROUP=y
 CONFIG_EXPERT=y
 # CONFIG_SYSFS_SYSCALL is not set
-CONFIG_BPF_LSM=y
-CONFIG_BPF_SYSCALL=y
 CONFIG_USERFAULTFD=y
 # CONFIG_COMPAT_BRK is not set
 CONFIG_PROFILING=y
@@ -70,6 +74,7 @@ CONFIG_BLK_DEV_THROTTLING=y
 CONFIG_BLK_WBT=y
 CONFIG_BLK_CGROUP_IOLATENCY=y
 CONFIG_BLK_CGROUP_IOCOST=y
+CONFIG_BLK_CGROUP_IOPRIO=y
 CONFIG_BLK_INLINE_ENCRYPTION=y
 CONFIG_BLK_INLINE_ENCRYPTION_FALLBACK=y
 CONFIG_PARTITION_ADVANCED=y
@@ -87,6 +92,7 @@ CONFIG_KSM=y
 CONFIG_TRANSPARENT_HUGEPAGE=y
 CONFIG_CLEANCACHE=y
 CONFIG_FRONTSWAP=y
+CONFIG_CMA_SYSFS=y
 CONFIG_CMA_AREAS=7
 CONFIG_MEM_SOFT_DIRTY=y
 CONFIG_ZSWAP=y
@@ -149,6 +155,7 @@ CONFIG_IPV6_RPL_LWTUNNEL=y
 CONFIG_MPTCP=y
 CONFIG_NETFILTER=y
 CONFIG_BRIDGE_NETFILTER=m
+CONFIG_NETFILTER_NETLINK_HOOK=m
 CONFIG_NF_CONNTRACK=m
 CONFIG_NF_CONNTRACK_SECMARK=y
 CONFIG_NF_CONNTRACK_EVENTS=y
@@ -271,6 +278,7 @@ CONFIG_IP_VS_FTP=m
 CONFIG_IP_VS_PE_SIP=m
 CONFIG_NFT_FIB_IPV4=m
 CONFIG_NF_TABLES_ARP=y
+CONFIG_NF_LOG_IPV4=m
 CONFIG_IP_NF_IPTABLES=m
 CONFIG_IP_NF_MATCH_AH=m
 CONFIG_IP_NF_MATCH_ECN=m
@@ -374,11 +382,10 @@ CONFIG_VSOCKETS=m
 CONFIG_VIRTIO_VSOCKETS=m
 CONFIG_NETLINK_DIAG=m
 CONFIG_CGROUP_NET_PRIO=y
-CONFIG_BPF_JIT=y
 CONFIG_NET_PKTGEN=m
 CONFIG_PCI=y
-CONFIG_PCI_IOV=y
 # CONFIG_PCIEASPM is not set
+CONFIG_PCI_IOV=y
 CONFIG_HOTPLUG_PCI=y
 CONFIG_HOTPLUG_PCI_S390=y
 CONFIG_UEVENT_HELPER=y
@@ -427,7 +434,7 @@ CONFIG_MD_MULTIPATH=m
 CONFIG_MD_FAULTY=m
 CONFIG_MD_CLUSTER=m
 CONFIG_BCACHE=m
-CONFIG_BLK_DEV_DM=m
+CONFIG_BLK_DEV_DM=y
 CONFIG_DM_UNSTRIPED=m
 CONFIG_DM_CRYPT=m
 CONFIG_DM_SNAPSHOT=m
@@ -444,6 +451,7 @@ CONFIG_DM_MULTIPATH_ST=m
 CONFIG_DM_MULTIPATH_HST=m
 CONFIG_DM_MULTIPATH_IOA=m
 CONFIG_DM_DELAY=m
+CONFIG_DM_INIT=y
 CONFIG_DM_UEVENT=y
 CONFIG_DM_FLAKEY=m
 CONFIG_DM_VERITY=m
@@ -487,6 +495,7 @@ CONFIG_NLMON=m
 # CONFIG_NET_VENDOR_GOOGLE is not set
 # CONFIG_NET_VENDOR_HUAWEI is not set
 # CONFIG_NET_VENDOR_INTEL is not set
+# CONFIG_NET_VENDOR_MICROSOFT is not set
 # CONFIG_NET_VENDOR_MARVELL is not set
 CONFIG_MLX4_EN=m
 CONFIG_MLX5_CORE=m
@@ -543,7 +552,6 @@ CONFIG_INPUT_EVDEV=y
 CONFIG_LEGACY_PTY_COUNT=0
 CONFIG_VIRTIO_CONSOLE=m
 CONFIG_HW_RANDOM_VIRTIO=m
-CONFIG_RAW_DRIVER=m
 CONFIG_HANGCHECK_TIMER=m
 CONFIG_TN3270_FS=y
 # CONFIG_PTP_1588_CLOCK is not set
@@ -566,7 +574,6 @@ CONFIG_SYNC_FILE=y
 CONFIG_VFIO=m
 CONFIG_VFIO_PCI=m
 CONFIG_VFIO_MDEV=m
-CONFIG_VFIO_MDEV_DEVICE=m
 CONFIG_VIRTIO_PCI=m
 CONFIG_VIRTIO_BALLOON=m
 CONFIG_VIRTIO_INPUT=y
@@ -607,6 +614,7 @@ CONFIG_FUSE_FS=y
 CONFIG_CUSE=m
 CONFIG_VIRTIO_FS=m
 CONFIG_OVERLAY_FS=m
+CONFIG_NETFS_STATS=y
 CONFIG_FSCACHE=m
 CONFIG_CACHEFILES=m
 CONFIG_ISO9660_FS=y
@@ -642,7 +650,6 @@ CONFIG_NFSD_V3_ACL=y
 CONFIG_NFSD_V4=y
 CONFIG_NFSD_V4_SECURITY_LABEL=y
 CONFIG_CIFS=m
-CONFIG_CIFS_STATS2=y
 CONFIG_CIFS_WEAK_PW_HASH=y
 CONFIG_CIFS_UPCALL=y
 CONFIG_CIFS_XATTR=y
@@ -669,6 +676,7 @@ CONFIG_SECURITY_SELINUX_BOOTPARAM=y
 CONFIG_SECURITY_SELINUX_DISABLE=y
 CONFIG_SECURITY_LOCKDOWN_LSM=y
 CONFIG_SECURITY_LOCKDOWN_LSM_EARLY=y
+CONFIG_SECURITY_LANDLOCK=y
 CONFIG_INTEGRITY_SIGNATURE=y
 CONFIG_INTEGRITY_ASYMMETRIC_KEYS=y
 CONFIG_IMA=y
@@ -684,6 +692,7 @@ CONFIG_CRYPTO_CRYPTD=m
 CONFIG_CRYPTO_TEST=m
 CONFIG_CRYPTO_DH=m
 CONFIG_CRYPTO_ECDH=m
+CONFIG_CRYPTO_ECDSA=m
 CONFIG_CRYPTO_ECRDSA=m
 CONFIG_CRYPTO_SM2=m
 CONFIG_CRYPTO_CURVE25519=m
@@ -754,6 +763,7 @@ CONFIG_CRC8=m
 CONFIG_DMA_CMA=y
 CONFIG_CMA_SIZE_MBYTES=0
 CONFIG_PRINTK_TIME=y
+CONFIG_DYNAMIC_DEBUG=y
 CONFIG_DEBUG_INFO=y
 CONFIG_DEBUG_INFO_DWARF4=y
 CONFIG_GDB_SCRIPTS=y
@@ -781,3 +791,4 @@ CONFIG_LKDTM=m
 CONFIG_PERCPU_TEST=m
 CONFIG_ATOMIC64_SELFTEST=y
 CONFIG_TEST_BPF=m
+CONFIG_TEST_LIVEPATCH=m
diff --git a/arch/s390/configs/zfcpdump_defconfig b/arch/s390/configs/zfcpdump_defconfig
index 76123a4b26ab..d576aaab27c9 100644
--- a/arch/s390/configs/zfcpdump_defconfig
+++ b/arch/s390/configs/zfcpdump_defconfig
@@ -29,9 +29,9 @@ CONFIG_PARTITION_ADVANCED=y
 # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
 # CONFIG_COMPACTION is not set
 # CONFIG_MIGRATION is not set
-# CONFIG_BOUNCE is not set
 CONFIG_NET=y
 # CONFIG_IUCV is not set
+# CONFIG_PCPU_DEV_REFCNT is not set
 # CONFIG_ETHTOOL_NETLINK is not set
 CONFIG_DEVTMPFS=y
 CONFIG_BLK_DEV_RAM=y
@@ -51,7 +51,6 @@ CONFIG_ZFCP=y
 # CONFIG_SERIO is not set
 # CONFIG_HVC_IUCV is not set
 # CONFIG_HW_RANDOM_S390 is not set
-CONFIG_RAW_DRIVER=y
 # CONFIG_HMC_DRV is not set
 # CONFIG_S390_TAPE is not set
 # CONFIG_VMCP is not set
diff --git a/arch/s390/include/asm/ftrace.h b/arch/s390/include/asm/ftrace.h
index 695c61989f97..345cbe982a8b 100644
--- a/arch/s390/include/asm/ftrace.h
+++ b/arch/s390/include/asm/ftrace.h
@@ -19,6 +19,7 @@ void ftrace_caller(void);
 
 extern char ftrace_graph_caller_end;
 extern unsigned long ftrace_plt;
+extern void *ftrace_func;
 
 struct dyn_arch_ftrace { };
 
diff --git a/arch/s390/kernel/ftrace.c b/arch/s390/kernel/ftrace.c
index c6ddeb5029b4..2d8f595d9196 100644
--- a/arch/s390/kernel/ftrace.c
+++ b/arch/s390/kernel/ftrace.c
@@ -40,6 +40,7 @@
  * trampoline (ftrace_plt), which clobbers also r1.
  */
 
+void *ftrace_func __read_mostly = ftrace_stub;
 unsigned long ftrace_plt;
 
 int ftrace_modify_call(struct dyn_ftrace *rec, unsigned long old_addr,
@@ -85,6 +86,7 @@ int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
 
 int ftrace_update_ftrace_func(ftrace_func_t func)
 {
+	ftrace_func = func;
 	return 0;
 }
 
diff --git a/arch/s390/kernel/mcount.S b/arch/s390/kernel/mcount.S
index faf64c2f90f5..6b13797143a7 100644
--- a/arch/s390/kernel/mcount.S
+++ b/arch/s390/kernel/mcount.S
@@ -59,13 +59,13 @@ ENTRY(ftrace_caller)
 #ifdef CONFIG_HAVE_MARCH_Z196_FEATURES
 	aghik	%r2,%r0,-MCOUNT_INSN_SIZE
 	lgrl	%r4,function_trace_op
-	lgrl	%r1,ftrace_trace_function
+	lgrl	%r1,ftrace_func
 #else
 	lgr	%r2,%r0
 	aghi	%r2,-MCOUNT_INSN_SIZE
 	larl	%r4,function_trace_op
 	lg	%r4,0(%r4)
-	larl	%r1,ftrace_trace_function
+	larl	%r1,ftrace_func
 	lg	%r1,0(%r1)
 #endif
 	lgr	%r3,%r14
diff --git a/arch/s390/kernel/perf_cpum_cf.c b/arch/s390/kernel/perf_cpum_cf.c
index 975a00c8c564..d7dc36ec0a60 100644
--- a/arch/s390/kernel/perf_cpum_cf.c
+++ b/arch/s390/kernel/perf_cpum_cf.c
@@ -745,7 +745,7 @@ static int __init cpumf_pmu_init(void)
 	if (!cf_dbg) {
 		pr_err("Registration of s390dbf(cpum_cf) failed\n");
 		return -ENOMEM;
-	};
+	}
 	debug_register_view(cf_dbg, &debug_sprintf_view);
 
 	cpumf_pmu.attr_groups = cpumf_cf_event_group();
diff --git a/arch/s390/kernel/vdso32/Makefile b/arch/s390/kernel/vdso32/Makefile
index b2349a3f4fa3..3457dcf10396 100644
--- a/arch/s390/kernel/vdso32/Makefile
+++ b/arch/s390/kernel/vdso32/Makefile
@@ -29,6 +29,7 @@ $(targets:%=$(obj)/%.dbg): KBUILD_CFLAGS = $(KBUILD_CFLAGS_32)
 $(targets:%=$(obj)/%.dbg): KBUILD_AFLAGS = $(KBUILD_AFLAGS_32)
 
 obj-y += vdso32_wrapper.o
+targets += vdso32.lds
 CPPFLAGS_vdso32.lds += -P -C -U$(ARCH)
 
 # Disable gcov profiling, ubsan and kasan for VDSO code
