Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D34C433DB
	for <linux-s390@archiver.kernel.org>; Wed, 10 Mar 2021 19:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBEF464FB5
	for <linux-s390@archiver.kernel.org>; Wed, 10 Mar 2021 19:42:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232417AbhCJTl6 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 10 Mar 2021 14:41:58 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:10644 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232983AbhCJTlf (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 10 Mar 2021 14:41:35 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12AJc0rL171038;
        Wed, 10 Mar 2021 14:41:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : content-type : mime-version; s=pp1;
 bh=T3OtQt9wZxUCla/Ezo5+7q8KRpB7rCaeTPrhiQ4GYg8=;
 b=pMaKNxoCxbK7/F3N3jaTrnOLBRpCMmQ5Ad558tnBYAqAfJ98ih/5Aul3f/NS699maVke
 JfYktnalqxpJNgX7p1pSvcUd3LmIsNl8XvDnc+XXG1R4kzY/Ipz8RWm3/zmsm7+GuS+i
 nOxNRkfmORnevJn1t6e+ZajU4prkb14SEcG4Wq/XPZY0Ld7hfA2QK/lrazgv87GrRkc4
 A8Bz4c/T/pxhKGFdvDCePjJvsmZrp0QDBBqP6qYqFM7pRcq5NDxO2w2TQCkJH/OuUzOl
 EDyXRi60xYEAQu+X4Ccicd0s1L9R0GvOjA9JZK6uvQ1mgstWZLAE9SpBQxgYr0ubgAwn Bw== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3774ek03hh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Mar 2021 14:41:30 -0500
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12AJWJmU031490;
        Wed, 10 Mar 2021 19:40:50 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06ams.nl.ibm.com with ESMTP id 3768urs8kw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Mar 2021 19:40:49 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 12AJekR256820058
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Mar 2021 19:40:46 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8B171AE058;
        Wed, 10 Mar 2021 19:40:46 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 24994AE045;
        Wed, 10 Mar 2021 19:40:46 +0000 (GMT)
Received: from osiris (unknown [9.171.75.29])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 10 Mar 2021 19:40:46 +0000 (GMT)
Date:   Wed, 10 Mar 2021 20:40:44 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] s390 updates for 5.12-rc3
Message-ID: <YEkgvDUmkCkbTe5O@osiris>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-10_10:2021-03-10,2021-03-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 priorityscore=1501 malwarescore=0 adultscore=0 bulkscore=0
 clxscore=1015 spamscore=0 phishscore=0 mlxscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103100092
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi Linus,

please pull some s390 updates for 5.12-rc3. All of this was actually
already beginning of last week in linux-next, however I rebased this
from rc1 to rc2.

Thanks,
Heiko

The following changes since commit a38fd8748464831584a19438cbb3082b5a2dab15:

  Linux 5.12-rc2 (2021-03-05 17:33:41 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.12-3

for you to fetch changes up to 78c7cccaab9d5f9ead44579d79dd7d13a05aec7e:

  s390: remove IBM_PARTITION and CONFIGFS_FS from zfcpdump defconfig (2021-03-08 10:46:30 +0100)

----------------------------------------------------------------
s390 updates for 5.12-rc3

- fix various user space visible copy_to_user() instances which return the
  number of bytes left to copy instead of -EFAULT

- make TMPFS_INODE64 available again for s390 and alpha, now that both
  architectures have been switched to 64-bit ino_t
  see commit 96c0a6a72d18 ("s390,alpha: switch to 64-bit ino_t")

- make sure to release a shared hypervisor resource within the zcore device
  driver also on restart and power down; also remove unneeded surrounding
  debugfs_create return value checks

- for the new hardware counter set device driver rename the uapi header file to
  be a bit more generic; also remove 60 second read limit which is not really
  necessary and without the limit the interface can be easier tested

- some small cleanups, the largest being to convert all long long in our time
  and idle code to longs

- update defconfigs

----------------------------------------------------------------
Alexander Egorenkov (3):
      s390/zcore: no need to check return value of debugfs_create functions
      s390/zcore: release dump save area on restart or power down
      s390: remove IBM_PARTITION and CONFIGFS_FS from zfcpdump defconfig

Eric Farman (1):
      s390/cio: return -EFAULT if copy_to_user() fails

Heiko Carstens (4):
      s390/time,idle: get rid of unsigned long long
      s390/topology: remove always false if check
      s390,alpha: make TMPFS_INODE64 available again
      s390: update defconfigs

Jiapeng Chong (1):
      s390/cpumf: remove unneeded semicolon

Joe Perches (1):
      s390/tty3270: avoid comma separated statements

Thomas Richter (2):
      s390/cpumf: remove 60 seconds read limit
      s390/cpumf: rename header file to hwctrset.h

Wang Qing (2):
      s390/cio: return -EFAULT if copy_to_user() fails
      s390/crypto: return -EFAULT if copy_to_user() fails

 arch/s390/configs/debug_defconfig                  | 16 ++------
 arch/s390/configs/defconfig                        | 11 +-----
 arch/s390/configs/zfcpdump_defconfig               |  3 --
 arch/s390/include/asm/idle.h                       | 12 +++---
 arch/s390/include/asm/timex.h                      | 36 +++++++++---------
 .../uapi/asm/{perf_cpum_cf_diag.h => hwctrset.h}   |  0
 arch/s390/kernel/idle.c                            | 12 +++---
 arch/s390/kernel/perf_cpum_cf.c                    |  2 +-
 arch/s390/kernel/perf_cpum_cf_diag.c               | 20 ++--------
 arch/s390/kernel/time.c                            | 28 +++++++-------
 arch/s390/kernel/topology.c                        |  2 -
 arch/s390/kvm/interrupt.c                          |  2 +-
 drivers/s390/char/tty3270.c                        |  6 ++-
 drivers/s390/char/zcore.c                          | 44 +++++++++++++---------
 drivers/s390/cio/device_fsm.c                      |  2 +-
 drivers/s390/cio/vfio_ccw_ops.c                    |  6 +--
 drivers/s390/crypto/vfio_ap_ops.c                  |  2 +-
 fs/Kconfig                                         |  2 +-
 18 files changed, 91 insertions(+), 115 deletions(-)
 rename arch/s390/include/uapi/asm/{perf_cpum_cf_diag.h => hwctrset.h} (100%)

diff --git a/arch/s390/configs/debug_defconfig b/arch/s390/configs/debug_defconfig
index 02056b024091..dc0b69058ac4 100644
--- a/arch/s390/configs/debug_defconfig
+++ b/arch/s390/configs/debug_defconfig
@@ -275,9 +275,9 @@ CONFIG_IP_VS_DH=m
 CONFIG_IP_VS_SH=m
 CONFIG_IP_VS_SED=m
 CONFIG_IP_VS_NQ=m
+CONFIG_IP_VS_TWOS=m
 CONFIG_IP_VS_FTP=m
 CONFIG_IP_VS_PE_SIP=m
-CONFIG_NF_TABLES_IPV4=y
 CONFIG_NFT_FIB_IPV4=m
 CONFIG_NF_TABLES_ARP=y
 CONFIG_IP_NF_IPTABLES=m
@@ -298,7 +298,6 @@ CONFIG_IP_NF_SECURITY=m
 CONFIG_IP_NF_ARPTABLES=m
 CONFIG_IP_NF_ARPFILTER=m
 CONFIG_IP_NF_ARP_MANGLE=m
-CONFIG_NF_TABLES_IPV6=y
 CONFIG_NFT_FIB_IPV6=m
 CONFIG_IP6_NF_IPTABLES=m
 CONFIG_IP6_NF_MATCH_AH=m
@@ -481,7 +480,6 @@ CONFIG_NLMON=m
 # CONFIG_NET_VENDOR_AQUANTIA is not set
 # CONFIG_NET_VENDOR_ARC is not set
 # CONFIG_NET_VENDOR_ATHEROS is not set
-# CONFIG_NET_VENDOR_AURORA is not set
 # CONFIG_NET_VENDOR_BROADCOM is not set
 # CONFIG_NET_VENDOR_BROCADE is not set
 # CONFIG_NET_VENDOR_CADENCE is not set
@@ -581,7 +579,6 @@ CONFIG_VIRTIO_BALLOON=m
 CONFIG_VIRTIO_INPUT=y
 CONFIG_VHOST_NET=m
 CONFIG_VHOST_VSOCK=m
-# CONFIG_SURFACE_PLATFORMS is not set
 CONFIG_S390_CCW_IOMMU=y
 CONFIG_S390_AP_IOMMU=y
 CONFIG_EXT4_FS=y
@@ -635,6 +632,7 @@ CONFIG_NTFS_RW=y
 CONFIG_PROC_KCORE=y
 CONFIG_TMPFS=y
 CONFIG_TMPFS_POSIX_ACL=y
+CONFIG_TMPFS_INODE64=y
 CONFIG_HUGETLBFS=y
 CONFIG_CONFIGFS_FS=m
 CONFIG_ECRYPT_FS=m
@@ -714,12 +712,8 @@ CONFIG_CRYPTO_VMAC=m
 CONFIG_CRYPTO_CRC32=m
 CONFIG_CRYPTO_BLAKE2S=m
 CONFIG_CRYPTO_MICHAEL_MIC=m
-CONFIG_CRYPTO_RMD128=m
 CONFIG_CRYPTO_RMD160=m
-CONFIG_CRYPTO_RMD256=m
-CONFIG_CRYPTO_RMD320=m
 CONFIG_CRYPTO_SHA3=m
-CONFIG_CRYPTO_TGR192=m
 CONFIG_CRYPTO_WP512=m
 CONFIG_CRYPTO_AES_TI=m
 CONFIG_CRYPTO_ANUBIS=m
@@ -731,7 +725,6 @@ CONFIG_CRYPTO_CAST6=m
 CONFIG_CRYPTO_DES=m
 CONFIG_CRYPTO_FCRYPT=m
 CONFIG_CRYPTO_KHAZAD=m
-CONFIG_CRYPTO_SALSA20=m
 CONFIG_CRYPTO_SEED=m
 CONFIG_CRYPTO_SERPENT=m
 CONFIG_CRYPTO_SM4=m
@@ -796,12 +789,9 @@ CONFIG_DEBUG_OBJECTS_RCU_HEAD=y
 CONFIG_DEBUG_OBJECTS_PERCPU_COUNTER=y
 CONFIG_SLUB_DEBUG_ON=y
 CONFIG_SLUB_STATS=y
-CONFIG_DEBUG_KMEMLEAK=y
-CONFIG_DEBUG_KMEMLEAK_DEFAULT_OFF=y
 CONFIG_DEBUG_STACK_USAGE=y
 CONFIG_DEBUG_VM=y
 CONFIG_DEBUG_VM_VMACACHE=y
-CONFIG_DEBUG_VM_RB=y
 CONFIG_DEBUG_VM_PGFLAGS=y
 CONFIG_DEBUG_MEMORY_INIT=y
 CONFIG_MEMORY_NOTIFIER_ERROR_INJECT=m
@@ -838,6 +828,7 @@ CONFIG_BPF_KPROBE_OVERRIDE=y
 CONFIG_HIST_TRIGGERS=y
 CONFIG_FTRACE_STARTUP_TEST=y
 # CONFIG_EVENT_TRACE_STARTUP_TEST is not set
+CONFIG_DEBUG_ENTRY=y
 CONFIG_NOTIFIER_ERROR_INJECTION=m
 CONFIG_NETDEV_NOTIFIER_ERROR_INJECT=m
 CONFIG_FAULT_INJECTION=y
@@ -861,4 +852,3 @@ CONFIG_PERCPU_TEST=m
 CONFIG_ATOMIC64_SELFTEST=y
 CONFIG_TEST_BITOPS=m
 CONFIG_TEST_BPF=m
-CONFIG_DEBUG_ENTRY=y
diff --git a/arch/s390/configs/defconfig b/arch/s390/configs/defconfig
index bac721a501da..320379da96d9 100644
--- a/arch/s390/configs/defconfig
+++ b/arch/s390/configs/defconfig
@@ -266,9 +266,9 @@ CONFIG_IP_VS_DH=m
 CONFIG_IP_VS_SH=m
 CONFIG_IP_VS_SED=m
 CONFIG_IP_VS_NQ=m
+CONFIG_IP_VS_TWOS=m
 CONFIG_IP_VS_FTP=m
 CONFIG_IP_VS_PE_SIP=m
-CONFIG_NF_TABLES_IPV4=y
 CONFIG_NFT_FIB_IPV4=m
 CONFIG_NF_TABLES_ARP=y
 CONFIG_IP_NF_IPTABLES=m
@@ -289,7 +289,6 @@ CONFIG_IP_NF_SECURITY=m
 CONFIG_IP_NF_ARPTABLES=m
 CONFIG_IP_NF_ARPFILTER=m
 CONFIG_IP_NF_ARP_MANGLE=m
-CONFIG_NF_TABLES_IPV6=y
 CONFIG_NFT_FIB_IPV6=m
 CONFIG_IP6_NF_IPTABLES=m
 CONFIG_IP6_NF_MATCH_AH=m
@@ -473,7 +472,6 @@ CONFIG_NLMON=m
 # CONFIG_NET_VENDOR_AQUANTIA is not set
 # CONFIG_NET_VENDOR_ARC is not set
 # CONFIG_NET_VENDOR_ATHEROS is not set
-# CONFIG_NET_VENDOR_AURORA is not set
 # CONFIG_NET_VENDOR_BROADCOM is not set
 # CONFIG_NET_VENDOR_BROCADE is not set
 # CONFIG_NET_VENDOR_CADENCE is not set
@@ -573,7 +571,6 @@ CONFIG_VIRTIO_BALLOON=m
 CONFIG_VIRTIO_INPUT=y
 CONFIG_VHOST_NET=m
 CONFIG_VHOST_VSOCK=m
-# CONFIG_SURFACE_PLATFORMS is not set
 CONFIG_S390_CCW_IOMMU=y
 CONFIG_S390_AP_IOMMU=y
 CONFIG_EXT4_FS=y
@@ -623,6 +620,7 @@ CONFIG_NTFS_RW=y
 CONFIG_PROC_KCORE=y
 CONFIG_TMPFS=y
 CONFIG_TMPFS_POSIX_ACL=y
+CONFIG_TMPFS_INODE64=y
 CONFIG_HUGETLBFS=y
 CONFIG_CONFIGFS_FS=m
 CONFIG_ECRYPT_FS=m
@@ -703,12 +701,8 @@ CONFIG_CRYPTO_VMAC=m
 CONFIG_CRYPTO_CRC32=m
 CONFIG_CRYPTO_BLAKE2S=m
 CONFIG_CRYPTO_MICHAEL_MIC=m
-CONFIG_CRYPTO_RMD128=m
 CONFIG_CRYPTO_RMD160=m
-CONFIG_CRYPTO_RMD256=m
-CONFIG_CRYPTO_RMD320=m
 CONFIG_CRYPTO_SHA3=m
-CONFIG_CRYPTO_TGR192=m
 CONFIG_CRYPTO_WP512=m
 CONFIG_CRYPTO_AES_TI=m
 CONFIG_CRYPTO_ANUBIS=m
@@ -720,7 +714,6 @@ CONFIG_CRYPTO_CAST6=m
 CONFIG_CRYPTO_DES=m
 CONFIG_CRYPTO_FCRYPT=m
 CONFIG_CRYPTO_KHAZAD=m
-CONFIG_CRYPTO_SALSA20=m
 CONFIG_CRYPTO_SEED=m
 CONFIG_CRYPTO_SERPENT=m
 CONFIG_CRYPTO_SM4=m
diff --git a/arch/s390/configs/zfcpdump_defconfig b/arch/s390/configs/zfcpdump_defconfig
index acf982a2ae4c..76123a4b26ab 100644
--- a/arch/s390/configs/zfcpdump_defconfig
+++ b/arch/s390/configs/zfcpdump_defconfig
@@ -26,7 +26,6 @@ CONFIG_CRASH_DUMP=y
 # CONFIG_SECCOMP is not set
 # CONFIG_GCC_PLUGINS is not set
 CONFIG_PARTITION_ADVANCED=y
-CONFIG_IBM_PARTITION=y
 # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
 # CONFIG_COMPACTION is not set
 # CONFIG_MIGRATION is not set
@@ -61,11 +60,9 @@ CONFIG_RAW_DRIVER=y
 # CONFIG_HID is not set
 # CONFIG_VIRTIO_MENU is not set
 # CONFIG_VHOST_MENU is not set
-# CONFIG_SURFACE_PLATFORMS is not set
 # CONFIG_IOMMU_SUPPORT is not set
 # CONFIG_DNOTIFY is not set
 # CONFIG_INOTIFY_USER is not set
-CONFIG_CONFIGFS_FS=y
 # CONFIG_MISC_FILESYSTEMS is not set
 # CONFIG_NETWORK_FILESYSTEMS is not set
 CONFIG_LSM="yama,loadpin,safesetid,integrity"
diff --git a/arch/s390/include/asm/idle.h b/arch/s390/include/asm/idle.h
index b04f6a794cdf..5cea629c548e 100644
--- a/arch/s390/include/asm/idle.h
+++ b/arch/s390/include/asm/idle.h
@@ -14,12 +14,12 @@
 
 struct s390_idle_data {
 	seqcount_t seqcount;
-	unsigned long long idle_count;
-	unsigned long long idle_time;
-	unsigned long long clock_idle_enter;
-	unsigned long long clock_idle_exit;
-	unsigned long long timer_idle_enter;
-	unsigned long long timer_idle_exit;
+	unsigned long idle_count;
+	unsigned long idle_time;
+	unsigned long clock_idle_enter;
+	unsigned long clock_idle_exit;
+	unsigned long timer_idle_enter;
+	unsigned long timer_idle_exit;
 	unsigned long mt_cycles_enter[8];
 };
 
diff --git a/arch/s390/include/asm/timex.h b/arch/s390/include/asm/timex.h
index c4e23e925665..f6326c6d2abe 100644
--- a/arch/s390/include/asm/timex.h
+++ b/arch/s390/include/asm/timex.h
@@ -98,10 +98,10 @@ extern unsigned char ptff_function_mask[16];
 
 /* Query TOD offset result */
 struct ptff_qto {
-	unsigned long long physical_clock;
-	unsigned long long tod_offset;
-	unsigned long long logical_tod_offset;
-	unsigned long long tod_epoch_difference;
+	unsigned long physical_clock;
+	unsigned long tod_offset;
+	unsigned long logical_tod_offset;
+	unsigned long tod_epoch_difference;
 } __packed;
 
 static inline int ptff_query(unsigned int nr)
@@ -151,9 +151,9 @@ struct ptff_qui {
 	rc;								\
 })
 
-static inline unsigned long long local_tick_disable(void)
+static inline unsigned long local_tick_disable(void)
 {
-	unsigned long long old;
+	unsigned long old;
 
 	old = S390_lowcore.clock_comparator;
 	S390_lowcore.clock_comparator = clock_comparator_max;
@@ -161,7 +161,7 @@ static inline unsigned long long local_tick_disable(void)
 	return old;
 }
 
-static inline void local_tick_enable(unsigned long long comp)
+static inline void local_tick_enable(unsigned long comp)
 {
 	S390_lowcore.clock_comparator = comp;
 	set_clock_comparator(S390_lowcore.clock_comparator);
@@ -169,9 +169,9 @@ static inline void local_tick_enable(unsigned long long comp)
 
 #define CLOCK_TICK_RATE		1193180 /* Underlying HZ */
 
-typedef unsigned long long cycles_t;
+typedef unsigned long cycles_t;
 
-static inline unsigned long long get_tod_clock(void)
+static inline unsigned long get_tod_clock(void)
 {
 	union tod_clock clk;
 
@@ -179,10 +179,10 @@ static inline unsigned long long get_tod_clock(void)
 	return clk.tod;
 }
 
-static inline unsigned long long get_tod_clock_fast(void)
+static inline unsigned long get_tod_clock_fast(void)
 {
 #ifdef CONFIG_HAVE_MARCH_Z9_109_FEATURES
-	unsigned long long clk;
+	unsigned long clk;
 
 	asm volatile("stckf %0" : "=Q" (clk) : : "cc");
 	return clk;
@@ -208,9 +208,9 @@ extern union tod_clock tod_clock_base;
  * Therefore preemption must be disabled, otherwise the returned
  * value is not guaranteed to be monotonic.
  */
-static inline unsigned long long get_tod_clock_monotonic(void)
+static inline unsigned long get_tod_clock_monotonic(void)
 {
-	unsigned long long tod;
+	unsigned long tod;
 
 	preempt_disable_notrace();
 	tod = get_tod_clock() - tod_clock_base.tod;
@@ -237,7 +237,7 @@ static inline unsigned long long get_tod_clock_monotonic(void)
  * -> ns = (th * 125) + ((tl * 125) >> 9);
  *
  */
-static inline unsigned long long tod_to_ns(unsigned long long todval)
+static inline unsigned long tod_to_ns(unsigned long todval)
 {
 	return ((todval >> 9) * 125) + (((todval & 0x1ff) * 125) >> 9);
 }
@@ -249,10 +249,10 @@ static inline unsigned long long tod_to_ns(unsigned long long todval)
  *
  * Returns: true if a is later than b
  */
-static inline int tod_after(unsigned long long a, unsigned long long b)
+static inline int tod_after(unsigned long a, unsigned long b)
 {
 	if (MACHINE_HAS_SCC)
-		return (long long) a > (long long) b;
+		return (long) a > (long) b;
 	return a > b;
 }
 
@@ -263,10 +263,10 @@ static inline int tod_after(unsigned long long a, unsigned long long b)
  *
  * Returns: true if a is later than b
  */
-static inline int tod_after_eq(unsigned long long a, unsigned long long b)
+static inline int tod_after_eq(unsigned long a, unsigned long b)
 {
 	if (MACHINE_HAS_SCC)
-		return (long long) a >= (long long) b;
+		return (long) a >= (long) b;
 	return a >= b;
 }
 
diff --git a/arch/s390/include/uapi/asm/perf_cpum_cf_diag.h b/arch/s390/include/uapi/asm/hwctrset.h
similarity index 100%
rename from arch/s390/include/uapi/asm/perf_cpum_cf_diag.h
rename to arch/s390/include/uapi/asm/hwctrset.h
diff --git a/arch/s390/kernel/idle.c b/arch/s390/kernel/idle.c
index 812073ea073e..4bf1ee293f2b 100644
--- a/arch/s390/kernel/idle.c
+++ b/arch/s390/kernel/idle.c
@@ -47,7 +47,7 @@ void account_idle_time_irq(void)
 void arch_cpu_idle(void)
 {
 	struct s390_idle_data *idle = this_cpu_ptr(&s390_idle);
-	unsigned long long idle_time;
+	unsigned long idle_time;
 	unsigned long psw_mask;
 
 	/* Wait for external, I/O or machine check interrupt. */
@@ -73,7 +73,7 @@ static ssize_t show_idle_count(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
 	struct s390_idle_data *idle = &per_cpu(s390_idle, dev->id);
-	unsigned long long idle_count;
+	unsigned long idle_count;
 	unsigned int seq;
 
 	do {
@@ -82,14 +82,14 @@ static ssize_t show_idle_count(struct device *dev,
 		if (READ_ONCE(idle->clock_idle_enter))
 			idle_count++;
 	} while (read_seqcount_retry(&idle->seqcount, seq));
-	return sprintf(buf, "%llu\n", idle_count);
+	return sprintf(buf, "%lu\n", idle_count);
 }
 DEVICE_ATTR(idle_count, 0444, show_idle_count, NULL);
 
 static ssize_t show_idle_time(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
-	unsigned long long now, idle_time, idle_enter, idle_exit, in_idle;
+	unsigned long now, idle_time, idle_enter, idle_exit, in_idle;
 	struct s390_idle_data *idle = &per_cpu(s390_idle, dev->id);
 	unsigned int seq;
 
@@ -109,14 +109,14 @@ static ssize_t show_idle_time(struct device *dev,
 		}
 	}
 	idle_time += in_idle;
-	return sprintf(buf, "%llu\n", idle_time >> 12);
+	return sprintf(buf, "%lu\n", idle_time >> 12);
 }
 DEVICE_ATTR(idle_time_us, 0444, show_idle_time, NULL);
 
 u64 arch_cpu_idle_time(int cpu)
 {
 	struct s390_idle_data *idle = &per_cpu(s390_idle, cpu);
-	unsigned long long now, idle_enter, idle_exit, in_idle;
+	unsigned long now, idle_enter, idle_exit, in_idle;
 	unsigned int seq;
 
 	do {
diff --git a/arch/s390/kernel/perf_cpum_cf.c b/arch/s390/kernel/perf_cpum_cf.c
index 0eb1d1cc53a8..b3beef64d3d4 100644
--- a/arch/s390/kernel/perf_cpum_cf.c
+++ b/arch/s390/kernel/perf_cpum_cf.c
@@ -269,7 +269,7 @@ static int __hw_perf_event_init(struct perf_event *event, unsigned int type)
 	case CPUMF_CTR_SET_MAX:
 		/* The counter could not be associated to a counter set */
 		return -EINVAL;
-	};
+	}
 
 	/* Initialize for using the CPU-measurement counter facility */
 	if (!atomic_inc_not_zero(&num_events)) {
diff --git a/arch/s390/kernel/perf_cpum_cf_diag.c b/arch/s390/kernel/perf_cpum_cf_diag.c
index db4877bbb9aa..bc302b86ce28 100644
--- a/arch/s390/kernel/perf_cpum_cf_diag.c
+++ b/arch/s390/kernel/perf_cpum_cf_diag.c
@@ -26,12 +26,10 @@
 #include <asm/timex.h>
 #include <asm/debug.h>
 
-#include <asm/perf_cpum_cf_diag.h>
+#include <asm/hwctrset.h>
 
 #define	CF_DIAG_CTRSET_DEF		0xfeef	/* Counter set header mark */
-#define CF_DIAG_MIN_INTERVAL		60	/* Minimum counter set read */
 						/* interval in seconds */
-static unsigned long cf_diag_interval = CF_DIAG_MIN_INTERVAL;
 static unsigned int cf_diag_cpu_speed;
 static debug_info_t *cf_diag_dbg;
 
@@ -729,7 +727,6 @@ static DEFINE_MUTEX(cf_diag_ctrset_mutex);
 static struct cf_diag_ctrset {
 	unsigned long ctrset;		/* Bit mask of counter set to read */
 	cpumask_t mask;			/* CPU mask to read from */
-	time64_t lastread;		/* Epoch counter set last read */
 } cf_diag_ctrset;
 
 static void cf_diag_ctrset_clear(void)
@@ -866,27 +863,16 @@ static int cf_diag_all_read(unsigned long arg)
 {
 	struct cf_diag_call_on_cpu_parm p;
 	cpumask_var_t mask;
-	time64_t now;
-	int rc = 0;
+	int rc;
 
 	debug_sprintf_event(cf_diag_dbg, 5, "%s\n", __func__);
 	if (!alloc_cpumask_var(&mask, GFP_KERNEL))
 		return -ENOMEM;
-	now = ktime_get_seconds();
-	if (cf_diag_ctrset.lastread + cf_diag_interval > now) {
-		debug_sprintf_event(cf_diag_dbg, 5, "%s now %lld "
-				    " lastread %lld\n", __func__, now,
-				    cf_diag_ctrset.lastread);
-		rc = -EAGAIN;
-		goto out;
-	} else {
-		cf_diag_ctrset.lastread = now;
-	}
+
 	p.sets = cf_diag_ctrset.ctrset;
 	cpumask_and(mask, &cf_diag_ctrset.mask, cpu_online_mask);
 	on_each_cpu_mask(mask, cf_diag_cpu_read, &p, 1);
 	rc = cf_diag_all_copy(arg, mask);
-out:
 	free_cpumask_var(mask);
 	debug_sprintf_event(cf_diag_dbg, 5, "%s rc %d\n", __func__, rc);
 	return rc;
diff --git a/arch/s390/kernel/time.c b/arch/s390/kernel/time.c
index 06bcfa636638..165da961f901 100644
--- a/arch/s390/kernel/time.c
+++ b/arch/s390/kernel/time.c
@@ -68,10 +68,10 @@ EXPORT_SYMBOL(s390_epoch_delta_notifier);
 
 unsigned char ptff_function_mask[16];
 
-static unsigned long long lpar_offset;
-static unsigned long long initial_leap_seconds;
-static unsigned long long tod_steering_end;
-static long long tod_steering_delta;
+static unsigned long lpar_offset;
+static unsigned long initial_leap_seconds;
+static unsigned long tod_steering_end;
+static long tod_steering_delta;
 
 /*
  * Get time offsets with PTFF
@@ -96,7 +96,7 @@ void __init time_early_init(void)
 
 	/* get initial leap seconds */
 	if (ptff_query(PTFF_QUI) && ptff(&qui, sizeof(qui), PTFF_QUI) == 0)
-		initial_leap_seconds = (unsigned long long)
+		initial_leap_seconds = (unsigned long)
 			((long) qui.old_leap * 4096000000L);
 }
 
@@ -222,7 +222,7 @@ void __init read_persistent_wall_and_boot_offset(struct timespec64 *wall_time,
 
 static u64 read_tod_clock(struct clocksource *cs)
 {
-	unsigned long long now, adj;
+	unsigned long now, adj;
 
 	preempt_disable(); /* protect from changes to steering parameters */
 	now = get_tod_clock();
@@ -362,7 +362,7 @@ static inline int check_sync_clock(void)
  * Apply clock delta to the global data structures.
  * This is called once on the CPU that performed the clock sync.
  */
-static void clock_sync_global(unsigned long long delta)
+static void clock_sync_global(unsigned long delta)
 {
 	unsigned long now, adj;
 	struct ptff_qto qto;
@@ -378,7 +378,7 @@ static void clock_sync_global(unsigned long long delta)
 			-(adj >> 15) : (adj >> 15);
 	tod_steering_delta += delta;
 	if ((abs(tod_steering_delta) >> 48) != 0)
-		panic("TOD clock sync offset %lli is too large to drift\n",
+		panic("TOD clock sync offset %li is too large to drift\n",
 		      tod_steering_delta);
 	tod_steering_end = now + (abs(tod_steering_delta) << 15);
 	vdso_data->arch_data.tod_steering_end = tod_steering_end;
@@ -394,7 +394,7 @@ static void clock_sync_global(unsigned long long delta)
  * Apply clock delta to the per-CPU data structures of this CPU.
  * This is called for each online CPU after the call to clock_sync_global.
  */
-static void clock_sync_local(unsigned long long delta)
+static void clock_sync_local(unsigned long delta)
 {
 	/* Add the delta to the clock comparator. */
 	if (S390_lowcore.clock_comparator != clock_comparator_max) {
@@ -418,7 +418,7 @@ static void __init time_init_wq(void)
 struct clock_sync_data {
 	atomic_t cpus;
 	int in_sync;
-	unsigned long long clock_delta;
+	unsigned long clock_delta;
 };
 
 /*
@@ -538,7 +538,7 @@ static int stpinfo_valid(void)
 static int stp_sync_clock(void *data)
 {
 	struct clock_sync_data *sync = data;
-	unsigned long long clock_delta, flags;
+	u64 clock_delta, flags;
 	static int first;
 	int rc;
 
@@ -720,8 +720,8 @@ static ssize_t ctn_id_show(struct device *dev,
 
 	mutex_lock(&stp_mutex);
 	if (stpinfo_valid())
-		ret = sprintf(buf, "%016llx\n",
-			      *(unsigned long long *) stp_info.ctnid);
+		ret = sprintf(buf, "%016lx\n",
+			      *(unsigned long *) stp_info.ctnid);
 	mutex_unlock(&stp_mutex);
 	return ret;
 }
@@ -794,7 +794,7 @@ static ssize_t leap_seconds_scheduled_show(struct device *dev,
 	if (!stzi.lsoib.p)
 		return sprintf(buf, "0,0\n");
 
-	return sprintf(buf, "%llu,%d\n",
+	return sprintf(buf, "%lu,%d\n",
 		       tod_to_ns(stzi.lsoib.nlsout - TOD_UNIX_EPOCH) / NSEC_PER_SEC,
 		       stzi.lsoib.nlso - stzi.lsoib.also);
 }
diff --git a/arch/s390/kernel/topology.c b/arch/s390/kernel/topology.c
index e7ce447651b9..bfcc327acc6b 100644
--- a/arch/s390/kernel/topology.c
+++ b/arch/s390/kernel/topology.c
@@ -76,8 +76,6 @@ static void cpu_group_map(cpumask_t *dst, struct mask_info *info, unsigned int c
 			}
 			info = info->next;
 		}
-		if (cpumask_empty(&mask))
-			cpumask_copy(&mask, cpumask_of(cpu));
 		break;
 	case TOPOLOGY_MODE_PACKAGE:
 		cpumask_copy(&mask, cpu_present_mask);
diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index e3183bd05910..d548d60caed2 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -1287,7 +1287,7 @@ static u64 __calculate_sltime(struct kvm_vcpu *vcpu)
 			/* already expired? */
 			if (cputm >> 63)
 				return 0;
-			return min(sltime, tod_to_ns(cputm));
+			return min_t(u64, sltime, tod_to_ns(cputm));
 		}
 	} else if (cpu_timer_interrupts_enabled(vcpu)) {
 		sltime = kvm_s390_get_cpu_timer(vcpu);
diff --git a/drivers/s390/char/tty3270.c b/drivers/s390/char/tty3270.c
index 15692449a1c3..307a80f85c07 100644
--- a/drivers/s390/char/tty3270.c
+++ b/drivers/s390/char/tty3270.c
@@ -424,8 +424,10 @@ tty3270_update(struct timer_list *t)
 			 * last output position matches the start address
 			 * of this line.
 			 */
-			if (s->string[1] == sba[0] && s->string[2] == sba[1])
-				str += 3, len -= 3;
+			if (s->string[1] == sba[0] && s->string[2] == sba[1]) {
+				str += 3;
+				len -= 3;
+			}
 			if (raw3270_request_add_data(wrq, str, len) != 0)
 				break;
 			list_del_init(&s->update);
diff --git a/drivers/s390/char/zcore.c b/drivers/s390/char/zcore.c
index 1515fdc3c1ab..bd3c724bf695 100644
--- a/drivers/s390/char/zcore.c
+++ b/drivers/s390/char/zcore.c
@@ -15,6 +15,7 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/debugfs.h>
+#include <linux/reboot.h>
 
 #include <asm/asm-offsets.h>
 #include <asm/ipl.h>
@@ -238,6 +239,28 @@ static int __init zcore_reipl_init(void)
 	return 0;
 }
 
+static int zcore_reboot_and_on_panic_handler(struct notifier_block *self,
+					     unsigned long	   event,
+					     void		   *data)
+{
+	if (hsa_available)
+		release_hsa();
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block zcore_reboot_notifier = {
+	.notifier_call	= zcore_reboot_and_on_panic_handler,
+	/* we need to be notified before reipl and kdump */
+	.priority	= INT_MAX,
+};
+
+static struct notifier_block zcore_on_panic_notifier = {
+	.notifier_call	= zcore_reboot_and_on_panic_handler,
+	/* we need to be notified before reipl and kdump */
+	.priority	= INT_MAX,
+};
+
 static int __init zcore_init(void)
 {
 	unsigned char arch;
@@ -293,28 +316,15 @@ static int __init zcore_init(void)
 		goto fail;
 
 	zcore_dir = debugfs_create_dir("zcore" , NULL);
-	if (!zcore_dir) {
-		rc = -ENOMEM;
-		goto fail;
-	}
 	zcore_reipl_file = debugfs_create_file("reipl", S_IRUSR, zcore_dir,
 						NULL, &zcore_reipl_fops);
-	if (!zcore_reipl_file) {
-		rc = -ENOMEM;
-		goto fail_dir;
-	}
 	zcore_hsa_file = debugfs_create_file("hsa", S_IRUSR|S_IWUSR, zcore_dir,
 					     NULL, &zcore_hsa_fops);
-	if (!zcore_hsa_file) {
-		rc = -ENOMEM;
-		goto fail_reipl_file;
-	}
-	return 0;
 
-fail_reipl_file:
-	debugfs_remove(zcore_reipl_file);
-fail_dir:
-	debugfs_remove(zcore_dir);
+	register_reboot_notifier(&zcore_reboot_notifier);
+	atomic_notifier_chain_register(&panic_notifier_list, &zcore_on_panic_notifier);
+
+	return 0;
 fail:
 	diag308(DIAG308_REL_HSA, NULL);
 	return rc;
diff --git a/drivers/s390/cio/device_fsm.c b/drivers/s390/cio/device_fsm.c
index 6420b197bb05..05e136cfb8be 100644
--- a/drivers/s390/cio/device_fsm.c
+++ b/drivers/s390/cio/device_fsm.c
@@ -47,7 +47,7 @@ static void ccw_timeout_log(struct ccw_device *cdev)
 	orb = &private->orb;
 	cc = stsch(sch->schid, &schib);
 
-	printk(KERN_WARNING "cio: ccw device timeout occurred at %llx, "
+	printk(KERN_WARNING "cio: ccw device timeout occurred at %lx, "
 	       "device information:\n", get_tod_clock());
 	printk(KERN_WARNING "cio: orb:\n");
 	print_hex_dump(KERN_WARNING, "cio:  ", DUMP_PREFIX_NONE, 16, 1,
diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_ops.c
index 68106be4ba7a..767ac41686fe 100644
--- a/drivers/s390/cio/vfio_ccw_ops.c
+++ b/drivers/s390/cio/vfio_ccw_ops.c
@@ -543,7 +543,7 @@ static ssize_t vfio_ccw_mdev_ioctl(struct mdev_device *mdev,
 		if (ret)
 			return ret;
 
-		return copy_to_user((void __user *)arg, &info, minsz);
+		return copy_to_user((void __user *)arg, &info, minsz) ? -EFAULT : 0;
 	}
 	case VFIO_DEVICE_GET_REGION_INFO:
 	{
@@ -561,7 +561,7 @@ static ssize_t vfio_ccw_mdev_ioctl(struct mdev_device *mdev,
 		if (ret)
 			return ret;
 
-		return copy_to_user((void __user *)arg, &info, minsz);
+		return copy_to_user((void __user *)arg, &info, minsz) ? -EFAULT : 0;
 	}
 	case VFIO_DEVICE_GET_IRQ_INFO:
 	{
@@ -582,7 +582,7 @@ static ssize_t vfio_ccw_mdev_ioctl(struct mdev_device *mdev,
 		if (info.count == -1)
 			return -EINVAL;
 
-		return copy_to_user((void __user *)arg, &info, minsz);
+		return copy_to_user((void __user *)arg, &info, minsz) ? -EFAULT : 0;
 	}
 	case VFIO_DEVICE_SET_IRQS:
 	{
diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 41fc2e4135fe..1ffdd411201c 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -1286,7 +1286,7 @@ static int vfio_ap_mdev_get_device_info(unsigned long arg)
 	info.num_regions = 0;
 	info.num_irqs = 0;
 
-	return copy_to_user((void __user *)arg, &info, minsz);
+	return copy_to_user((void __user *)arg, &info, minsz) ? -EFAULT : 0;
 }
 
 static ssize_t vfio_ap_mdev_ioctl(struct mdev_device *mdev,
diff --git a/fs/Kconfig b/fs/Kconfig
index 462253ae483a..a55bda4233bb 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -203,7 +203,7 @@ config TMPFS_XATTR
 
 config TMPFS_INODE64
 	bool "Use 64-bit ino_t by default in tmpfs"
-	depends on TMPFS && 64BIT && !(S390 || ALPHA)
+	depends on TMPFS && 64BIT
 	default n
 	help
 	  tmpfs has historically used only inode numbers as wide as an unsigned
