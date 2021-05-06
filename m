Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E565DC433ED
	for <linux-s390@archiver.kernel.org>; Thu,  6 May 2021 20:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACD836102A
	for <linux-s390@archiver.kernel.org>; Thu,  6 May 2021 20:13:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233322AbhEFUOF (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 6 May 2021 16:14:05 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:18532 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231270AbhEFUOE (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 6 May 2021 16:14:04 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 146K3I86015164;
        Thu, 6 May 2021 16:13:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : content-type : mime-version; s=pp1;
 bh=wgKAYDNzuTakpVjWTtFZXJG8jldau4bwkug52L6efw4=;
 b=ZRGfbT50rpvJJqLOIXOKX1FjuqVI/mHUxa3x6Dhpje+sSH28rhPHxvXiXnJ1iN2x0X39
 NYWsoCJ8ZVNLuc4/mN+SWLGcWF6oJayM0QsA3fZDkB1jMfItJ0gYcja9y8PhK6g8mmVJ
 Pb5wr/OYwEoOfcb0SeO1TD0WBdnYlnFMSxtDUu8VXDR/7CLTpkbWJu2zfBYt2J5hn1ya
 AuRAGrtEEzAvr0xAHiE1Br0SoL4Q3U/hpdoqLbITPhMz5hvFoppbA/6r5Q1AI9zv66Vv
 gibwRjcgJFkkQpAGdwcH6ygKuHE7U9B/44tFwbpywOcQmQOGewLHsJFhHwGzP3y+43u7 sw== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38cmc5522e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 May 2021 16:13:04 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 146KBA8F027641;
        Thu, 6 May 2021 20:13:03 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma02fra.de.ibm.com with ESMTP id 38bee2gncj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 May 2021 20:13:03 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 146KD0K636503856
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 6 May 2021 20:13:00 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 12F8EAE045;
        Thu,  6 May 2021 20:13:00 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AD4C9AE053;
        Thu,  6 May 2021 20:12:59 +0000 (GMT)
Received: from osiris (unknown [9.171.54.194])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu,  6 May 2021 20:12:59 +0000 (GMT)
Date:   Thu, 6 May 2021 22:12:58 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] more s390 updates for 5.13-rc1
Message-ID: <YJRNygc8ryOitlmO@osiris>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: x0269I5nWpN0WiytRNV5uJGhNn86HCUt
X-Proofpoint-GUID: x0269I5nWpN0WiytRNV5uJGhNn86HCUt
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-06_10:2021-05-06,2021-05-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 bulkscore=0 adultscore=0 clxscore=1015 mlxlogscore=999 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105060138
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi Linus,

please pull some more s390 updates for 5.13-rc1.

Thanks,
Heiko

The following changes since commit 6daa755f813e6aa0bcc97e352666e072b1baac25:

  Merge tag 's390-5.13-1' of git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux (2021-04-27 17:54:15 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.13-2

for you to fetch changes up to b208108638c4bd3215792415944467c36f5dfd97:

  s390: fix detection of vector enhancements facility 1 vs. vector packed decimal facility (2021-05-04 19:10:56 +0200)

----------------------------------------------------------------
more s390 updates for 5.13 merge window

- add support for system call stack randomization.

- handle stale PCI deconfiguration events.

- couple of defconfig updates.

- some fixes and cleanups.

----------------------------------------------------------------
David Hildenbrand (1):
      s390: fix detection of vector enhancements facility 1 vs. vector packed decimal facility

Niklas Schnelle (3):
      s390/pci: rename zpci_configure_device()
      s390/pci: handle stale deconfiguration events
      s390/configs: enable CONFIG_PCI_IOV

Sven Schnelle (1):
      s390/entry: add support for syscall stack randomization

Thomas Huth (1):
      s390/configs: change CONFIG_VIRTIO_CONSOLE to "m"

Thomas Richter (3):
      s390/cpumf: beautify if-then-else indentation
      s390/cpumf: move counter set size calculation to common place
      s390/cpumf: remove call to perf_event_update_userpage

Vineeth Vijayan (1):
      s390/cio: remove invalid condition on IO_SCH_UNREG

 arch/s390/Kconfig                      |  1 +
 arch/s390/configs/debug_defconfig      |  3 +-
 arch/s390/configs/defconfig            |  3 +-
 arch/s390/include/asm/cpu_mcf.h        |  2 ++
 arch/s390/include/asm/entry-common.h   | 10 +++++++
 arch/s390/include/asm/pci.h            |  2 +-
 arch/s390/kernel/perf_cpum_cf.c        | 12 ++------
 arch/s390/kernel/perf_cpum_cf_common.c | 46 +++++++++++++++++++++++++++++
 arch/s390/kernel/perf_cpum_cf_diag.c   | 54 +++-------------------------------
 arch/s390/kernel/setup.c               |  4 +--
 arch/s390/kernel/syscall.c             |  1 +
 arch/s390/kernel/traps.c               |  2 ++
 arch/s390/pci/pci.c                    | 10 ++++---
 arch/s390/pci/pci_event.c              | 28 ++++++++++++------
 drivers/pci/hotplug/s390_pci_hpc.c     |  2 +-
 drivers/s390/cio/device.c              |  3 +-
 16 files changed, 103 insertions(+), 80 deletions(-)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index c1ff874e6c2e..1900428ce557 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -137,6 +137,7 @@ config S390
 	select HAVE_ARCH_JUMP_LABEL_RELATIVE
 	select HAVE_ARCH_KASAN
 	select HAVE_ARCH_KASAN_VMALLOC
+	select HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET
 	select HAVE_ARCH_SECCOMP_FILTER
 	select HAVE_ARCH_SOFT_DIRTY
 	select HAVE_ARCH_TRACEHOOK
diff --git a/arch/s390/configs/debug_defconfig b/arch/s390/configs/debug_defconfig
index 6422618a4f75..86afcc6b56bf 100644
--- a/arch/s390/configs/debug_defconfig
+++ b/arch/s390/configs/debug_defconfig
@@ -387,6 +387,7 @@ CONFIG_CGROUP_NET_PRIO=y
 CONFIG_BPF_JIT=y
 CONFIG_NET_PKTGEN=m
 CONFIG_PCI=y
+CONFIG_PCI_IOV=y
 # CONFIG_PCIEASPM is not set
 CONFIG_PCI_DEBUG=y
 CONFIG_HOTPLUG_PCI=y
@@ -548,7 +549,7 @@ CONFIG_INPUT_EVDEV=y
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_SERIO is not set
 CONFIG_LEGACY_PTY_COUNT=0
-CONFIG_VIRTIO_CONSOLE=y
+CONFIG_VIRTIO_CONSOLE=m
 CONFIG_HW_RANDOM_VIRTIO=m
 CONFIG_RAW_DRIVER=m
 CONFIG_HANGCHECK_TIMER=m
diff --git a/arch/s390/configs/defconfig b/arch/s390/configs/defconfig
index 371a529546aa..71b49ea5b058 100644
--- a/arch/s390/configs/defconfig
+++ b/arch/s390/configs/defconfig
@@ -377,6 +377,7 @@ CONFIG_CGROUP_NET_PRIO=y
 CONFIG_BPF_JIT=y
 CONFIG_NET_PKTGEN=m
 CONFIG_PCI=y
+CONFIG_PCI_IOV=y
 # CONFIG_PCIEASPM is not set
 CONFIG_HOTPLUG_PCI=y
 CONFIG_HOTPLUG_PCI_S390=y
@@ -540,7 +541,7 @@ CONFIG_INPUT_EVDEV=y
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_SERIO is not set
 CONFIG_LEGACY_PTY_COUNT=0
-CONFIG_VIRTIO_CONSOLE=y
+CONFIG_VIRTIO_CONSOLE=m
 CONFIG_HW_RANDOM_VIRTIO=m
 CONFIG_RAW_DRIVER=m
 CONFIG_HANGCHECK_TIMER=m
diff --git a/arch/s390/include/asm/cpu_mcf.h b/arch/s390/include/asm/cpu_mcf.h
index 649b9fc60685..3e4cbcb7c4cc 100644
--- a/arch/s390/include/asm/cpu_mcf.h
+++ b/arch/s390/include/asm/cpu_mcf.h
@@ -123,4 +123,6 @@ static inline int stccm_avail(void)
 	return test_facility(142);
 }
 
+size_t cpum_cf_ctrset_size(enum cpumf_ctr_set ctrset,
+			   struct cpumf_ctr_info *info);
 #endif /* _ASM_S390_CPU_MCF_H */
diff --git a/arch/s390/include/asm/entry-common.h b/arch/s390/include/asm/entry-common.h
index 9cceb26ed63f..baa8005090c3 100644
--- a/arch/s390/include/asm/entry-common.h
+++ b/arch/s390/include/asm/entry-common.h
@@ -4,9 +4,11 @@
 
 #include <linux/sched.h>
 #include <linux/audit.h>
+#include <linux/randomize_kstack.h>
 #include <linux/tracehook.h>
 #include <linux/processor.h>
 #include <linux/uaccess.h>
+#include <asm/timex.h>
 #include <asm/fpu/api.h>
 
 #define ARCH_EXIT_TO_USER_MODE_WORK (_TIF_GUARDED_STORAGE | _TIF_PER_TRAP)
@@ -48,6 +50,14 @@ static __always_inline void arch_exit_to_user_mode(void)
 
 #define arch_exit_to_user_mode arch_exit_to_user_mode
 
+static inline void arch_exit_to_user_mode_prepare(struct pt_regs *regs,
+						  unsigned long ti_work)
+{
+	choose_random_kstack_offset(get_tod_clock_fast() & 0xff);
+}
+
+#define arch_exit_to_user_mode_prepare arch_exit_to_user_mode_prepare
+
 static inline bool on_thread_stack(void)
 {
 	return !(((unsigned long)(current->stack) ^ current_stack_pointer()) & ~(THREAD_SIZE - 1));
diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
index 35c2af9371a9..10b67f8aab99 100644
--- a/arch/s390/include/asm/pci.h
+++ b/arch/s390/include/asm/pci.h
@@ -204,7 +204,7 @@ extern unsigned int s390_pci_no_rid;
 struct zpci_dev *zpci_create_device(u32 fid, u32 fh, enum zpci_state state);
 int zpci_enable_device(struct zpci_dev *);
 int zpci_disable_device(struct zpci_dev *);
-int zpci_configure_device(struct zpci_dev *zdev, u32 fh);
+int zpci_scan_configured_device(struct zpci_dev *zdev, u32 fh);
 int zpci_deconfigure_device(struct zpci_dev *zdev);
 
 int zpci_register_ioat(struct zpci_dev *, u8, u64, u64, u64);
diff --git a/arch/s390/kernel/perf_cpum_cf.c b/arch/s390/kernel/perf_cpum_cf.c
index b3beef64d3d4..31a605bcbc6e 100644
--- a/arch/s390/kernel/perf_cpum_cf.c
+++ b/arch/s390/kernel/perf_cpum_cf.c
@@ -230,9 +230,7 @@ static int __hw_perf_event_init(struct perf_event *event, unsigned int type)
 		/* No support for kernel space counters only */
 		} else if (!attr->exclude_kernel && attr->exclude_user) {
 			return -EOPNOTSUPP;
-
-		/* Count user and kernel space */
-		} else {
+		} else {	/* Count user and kernel space */
 			if (ev >= ARRAY_SIZE(cpumf_generic_events_basic))
 				return -EOPNOTSUPP;
 			ev = cpumf_generic_events_basic[ev];
@@ -402,12 +400,12 @@ static void cpumf_pmu_stop(struct perf_event *event, int flags)
 		 */
 		if (!atomic_dec_return(&cpuhw->ctr_set[hwc->config_base]))
 			ctr_set_stop(&cpuhw->state, hwc->config_base);
-		event->hw.state |= PERF_HES_STOPPED;
+		hwc->state |= PERF_HES_STOPPED;
 	}
 
 	if ((flags & PERF_EF_UPDATE) && !(hwc->state & PERF_HES_UPTODATE)) {
 		hw_perf_event_update(event);
-		event->hw.state |= PERF_HES_UPTODATE;
+		hwc->state |= PERF_HES_UPTODATE;
 	}
 }
 
@@ -430,8 +428,6 @@ static int cpumf_pmu_add(struct perf_event *event, int flags)
 	if (flags & PERF_EF_START)
 		cpumf_pmu_start(event, PERF_EF_RELOAD);
 
-	perf_event_update_userpage(event);
-
 	return 0;
 }
 
@@ -451,8 +447,6 @@ static void cpumf_pmu_del(struct perf_event *event, int flags)
 	 */
 	if (!atomic_read(&cpuhw->ctr_set[event->hw.config_base]))
 		ctr_set_disable(&cpuhw->state, event->hw.config_base);
-
-	perf_event_update_userpage(event);
 }
 
 /*
diff --git a/arch/s390/kernel/perf_cpum_cf_common.c b/arch/s390/kernel/perf_cpum_cf_common.c
index 3bced89caffb..6d53215c8484 100644
--- a/arch/s390/kernel/perf_cpum_cf_common.c
+++ b/arch/s390/kernel/perf_cpum_cf_common.c
@@ -170,6 +170,52 @@ static int cpum_cf_offline_cpu(unsigned int cpu)
 	return cpum_cf_setup(cpu, PMC_RELEASE);
 }
 
+/* Return the maximum possible counter set size (in number of 8 byte counters)
+ * depending on type and model number.
+ */
+size_t cpum_cf_ctrset_size(enum cpumf_ctr_set ctrset,
+			   struct cpumf_ctr_info *info)
+{
+	size_t ctrset_size = 0;
+
+	switch (ctrset) {
+	case CPUMF_CTR_SET_BASIC:
+		if (info->cfvn >= 1)
+			ctrset_size = 6;
+		break;
+	case CPUMF_CTR_SET_USER:
+		if (info->cfvn == 1)
+			ctrset_size = 6;
+		else if (info->cfvn >= 3)
+			ctrset_size = 2;
+		break;
+	case CPUMF_CTR_SET_CRYPTO:
+		if (info->csvn >= 1 && info->csvn <= 5)
+			ctrset_size = 16;
+		else if (info->csvn == 6)
+			ctrset_size = 20;
+		break;
+	case CPUMF_CTR_SET_EXT:
+		if (info->csvn == 1)
+			ctrset_size = 32;
+		else if (info->csvn == 2)
+			ctrset_size = 48;
+		else if (info->csvn >= 3 && info->csvn <= 5)
+			ctrset_size = 128;
+		else if (info->csvn == 6)
+			ctrset_size = 160;
+		break;
+	case CPUMF_CTR_SET_MT_DIAG:
+		if (info->csvn > 3)
+			ctrset_size = 48;
+		break;
+	case CPUMF_CTR_SET_MAX:
+		break;
+	}
+
+	return ctrset_size;
+}
+
 static int __init cpum_cf_init(void)
 {
 	int rc;
diff --git a/arch/s390/kernel/perf_cpum_cf_diag.c b/arch/s390/kernel/perf_cpum_cf_diag.c
index 2e3e7edbe3a0..08c985c1097c 100644
--- a/arch/s390/kernel/perf_cpum_cf_diag.c
+++ b/arch/s390/kernel/perf_cpum_cf_diag.c
@@ -316,52 +316,6 @@ static void cf_diag_read(struct perf_event *event)
 	debug_sprintf_event(cf_diag_dbg, 5, "%s event %p\n", __func__, event);
 }
 
-/* Return the maximum possible counter set size (in number of 8 byte counters)
- * depending on type and model number.
- */
-static size_t cf_diag_ctrset_size(enum cpumf_ctr_set ctrset,
-				 struct cpumf_ctr_info *info)
-{
-	size_t ctrset_size = 0;
-
-	switch (ctrset) {
-	case CPUMF_CTR_SET_BASIC:
-		if (info->cfvn >= 1)
-			ctrset_size = 6;
-		break;
-	case CPUMF_CTR_SET_USER:
-		if (info->cfvn == 1)
-			ctrset_size = 6;
-		else if (info->cfvn >= 3)
-			ctrset_size = 2;
-		break;
-	case CPUMF_CTR_SET_CRYPTO:
-		if (info->csvn >= 1 && info->csvn <= 5)
-			ctrset_size = 16;
-		else if (info->csvn == 6)
-			ctrset_size = 20;
-		break;
-	case CPUMF_CTR_SET_EXT:
-		if (info->csvn == 1)
-			ctrset_size = 32;
-		else if (info->csvn == 2)
-			ctrset_size = 48;
-		else if (info->csvn >= 3 && info->csvn <= 5)
-			ctrset_size = 128;
-		else if (info->csvn == 6)
-			ctrset_size = 160;
-		break;
-	case CPUMF_CTR_SET_MT_DIAG:
-		if (info->csvn > 3)
-			ctrset_size = 48;
-		break;
-	case CPUMF_CTR_SET_MAX:
-		break;
-	}
-
-	return ctrset_size;
-}
-
 /* Calculate memory needed to store all counter sets together with header and
  * trailer data. This is independend of the counter set authorization which
  * can vary depending on the configuration.
@@ -372,7 +326,7 @@ static size_t cf_diag_ctrset_maxsize(struct cpumf_ctr_info *info)
 	enum cpumf_ctr_set i;
 
 	for (i = CPUMF_CTR_SET_BASIC; i < CPUMF_CTR_SET_MAX; ++i) {
-		size_t size = cf_diag_ctrset_size(i, info);
+		size_t size = cpum_cf_ctrset_size(i, info);
 
 		if (size)
 			max_size += size * sizeof(u64) +
@@ -405,7 +359,7 @@ static size_t cf_diag_getctrset(struct cf_ctrset_entry *ctrdata, int ctrset,
 	ctrdata->def = CF_DIAG_CTRSET_DEF;
 	ctrdata->set = ctrset;
 	ctrdata->res1 = 0;
-	ctrset_size = cf_diag_ctrset_size(ctrset, &cpuhw->info);
+	ctrset_size = cpum_cf_ctrset_size(ctrset, &cpuhw->info);
 
 	if (ctrset_size) {			/* Save data */
 		need = ctrset_size * sizeof(u64) + sizeof(*ctrdata);
@@ -845,7 +799,7 @@ static void cf_diag_cpu_read(void *parm)
 
 		if (!(p->sets & cpumf_ctr_ctl[set]))
 			continue;	/* Counter set not in list */
-		set_size = cf_diag_ctrset_size(set, &cpuhw->info);
+		set_size = cpum_cf_ctrset_size(set, &cpuhw->info);
 		space = sizeof(csd->data) - csd->used;
 		space = cf_diag_cpuset_read(sp, set, set_size, space);
 		if (space) {
@@ -975,7 +929,7 @@ static size_t cf_diag_needspace(unsigned int sets)
 	for (i = CPUMF_CTR_SET_BASIC; i < CPUMF_CTR_SET_MAX; ++i) {
 		if (!(sets & cpumf_ctr_ctl[i]))
 			continue;
-		bytes += cf_diag_ctrset_size(i, &cpuhw->info) * sizeof(u64) +
+		bytes += cpum_cf_ctrset_size(i, &cpuhw->info) * sizeof(u64) +
 			 sizeof(((struct s390_ctrset_setdata *)0)->set) +
 			 sizeof(((struct s390_ctrset_setdata *)0)->no_cnts);
 	}
diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
index 72134f9f6ff5..5aab59ad5688 100644
--- a/arch/s390/kernel/setup.c
+++ b/arch/s390/kernel/setup.c
@@ -937,9 +937,9 @@ static int __init setup_hwcaps(void)
 	if (MACHINE_HAS_VX) {
 		elf_hwcap |= HWCAP_S390_VXRS;
 		if (test_facility(134))
-			elf_hwcap |= HWCAP_S390_VXRS_EXT;
-		if (test_facility(135))
 			elf_hwcap |= HWCAP_S390_VXRS_BCD;
+		if (test_facility(135))
+			elf_hwcap |= HWCAP_S390_VXRS_EXT;
 		if (test_facility(148))
 			elf_hwcap |= HWCAP_S390_VXRS_EXT2;
 		if (test_facility(152))
diff --git a/arch/s390/kernel/syscall.c b/arch/s390/kernel/syscall.c
index bc8e650e377d..4e5cc7d2364e 100644
--- a/arch/s390/kernel/syscall.c
+++ b/arch/s390/kernel/syscall.c
@@ -142,6 +142,7 @@ void do_syscall(struct pt_regs *regs)
 
 void noinstr __do_syscall(struct pt_regs *regs, int per_trap)
 {
+	add_random_kstack_offset();
 	enter_from_user_mode(regs);
 
 	memcpy(&regs->gprs[8], S390_lowcore.save_area_sync, 8 * sizeof(unsigned long));
diff --git a/arch/s390/kernel/traps.c b/arch/s390/kernel/traps.c
index 63021d484626..8dd23c703718 100644
--- a/arch/s390/kernel/traps.c
+++ b/arch/s390/kernel/traps.c
@@ -17,6 +17,7 @@
 #include "asm/ptrace.h"
 #include <linux/kprobes.h>
 #include <linux/kdebug.h>
+#include <linux/randomize_kstack.h>
 #include <linux/extable.h>
 #include <linux/ptrace.h>
 #include <linux/sched.h>
@@ -301,6 +302,7 @@ void noinstr __do_pgm_check(struct pt_regs *regs)
 	unsigned int trapnr, syscall_redirect = 0;
 	irqentry_state_t state;
 
+	add_random_kstack_offset();
 	regs->int_code = *(u32 *)&S390_lowcore.pgm_ilc;
 	regs->int_parm_long = S390_lowcore.trans_exc_code;
 
diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
index c01b6dbac7cf..b0993e05affe 100644
--- a/arch/s390/pci/pci.c
+++ b/arch/s390/pci/pci.c
@@ -738,17 +738,19 @@ struct zpci_dev *zpci_create_device(u32 fid, u32 fh, enum zpci_state state)
 }
 
 /**
- * zpci_configure_device() - Configure a zpci_dev
+ * zpci_scan_configured_device() - Scan a freshly configured zpci_dev
  * @zdev: The zpci_dev to be configured
  * @fh: The general function handle supplied by the platform
  *
  * Given a device in the configuration state Configured, enables, scans and
- * adds it to the common code PCI subsystem. If any failure occurs, the
- * zpci_dev is left disabled.
+ * adds it to the common code PCI subsystem if possible. If the PCI device is
+ * parked because we can not yet create a PCI bus because we have not seen
+ * function 0, it is ignored but will be scanned once function 0 appears.
+ * If any failure occurs, the zpci_dev is left disabled.
  *
  * Return: 0 on success, or an error code otherwise
  */
-int zpci_configure_device(struct zpci_dev *zdev, u32 fh)
+int zpci_scan_configured_device(struct zpci_dev *zdev, u32 fh)
 {
 	int rc;
 
diff --git a/arch/s390/pci/pci_event.c b/arch/s390/pci/pci_event.c
index 1178b48a66df..cd447b96b4b1 100644
--- a/arch/s390/pci/pci_event.c
+++ b/arch/s390/pci/pci_event.c
@@ -76,8 +76,6 @@ void zpci_event_error(void *data)
 
 static void zpci_event_hard_deconfigured(struct zpci_dev *zdev, u32 fh)
 {
-	enum zpci_state state;
-
 	zdev->fh = fh;
 	/* Give the driver a hint that the function is
 	 * already unusable.
@@ -88,15 +86,12 @@ static void zpci_event_hard_deconfigured(struct zpci_dev *zdev, u32 fh)
 	 */
 	zpci_disable_device(zdev);
 	zdev->state = ZPCI_FN_STATE_STANDBY;
-	if (!clp_get_state(zdev->fid, &state) &&
-	    state == ZPCI_FN_STATE_RESERVED) {
-		zpci_zdev_put(zdev);
-	}
 }
 
 static void __zpci_event_availability(struct zpci_ccdf_avail *ccdf)
 {
 	struct zpci_dev *zdev = get_zdev_by_fid(ccdf->fid);
+	enum zpci_state state;
 
 	zpci_err("avail CCDF:\n");
 	zpci_err_hex(ccdf, sizeof(*ccdf));
@@ -113,7 +108,7 @@ static void __zpci_event_availability(struct zpci_ccdf_avail *ccdf)
 				break;
 			zdev->state = ZPCI_FN_STATE_CONFIGURED;
 		}
-		zpci_configure_device(zdev, ccdf->fh);
+		zpci_scan_configured_device(zdev, ccdf->fh);
 		break;
 	case 0x0302: /* Reserved -> Standby */
 		if (!zdev)
@@ -123,13 +118,28 @@ static void __zpci_event_availability(struct zpci_ccdf_avail *ccdf)
 		break;
 	case 0x0303: /* Deconfiguration requested */
 		if (zdev) {
+			/* The event may have been queued before we confirgured
+			 * the device.
+			 */
+			if (zdev->state != ZPCI_FN_STATE_CONFIGURED)
+				break;
 			zdev->fh = ccdf->fh;
 			zpci_deconfigure_device(zdev);
 		}
 		break;
 	case 0x0304: /* Configured -> Standby|Reserved */
-		if (zdev)
-			zpci_event_hard_deconfigured(zdev, ccdf->fh);
+		if (zdev) {
+			/* The event may have been queued before we confirgured
+			 * the device.:
+			 */
+			if (zdev->state == ZPCI_FN_STATE_CONFIGURED)
+				zpci_event_hard_deconfigured(zdev, ccdf->fh);
+			/* The 0x0304 event may immediately reserve the device */
+			if (!clp_get_state(zdev->fid, &state) &&
+			    state == ZPCI_FN_STATE_RESERVED) {
+				zpci_zdev_put(zdev);
+			}
+		}
 		break;
 	case 0x0306: /* 0x308 or 0x302 for multiple devices */
 		zpci_remove_reserved_devices();
diff --git a/drivers/pci/hotplug/s390_pci_hpc.c b/drivers/pci/hotplug/s390_pci_hpc.c
index f8f056be71b7..014868752cd4 100644
--- a/drivers/pci/hotplug/s390_pci_hpc.c
+++ b/drivers/pci/hotplug/s390_pci_hpc.c
@@ -35,7 +35,7 @@ static int enable_slot(struct hotplug_slot *hotplug_slot)
 		return rc;
 	zdev->state = ZPCI_FN_STATE_CONFIGURED;
 
-	return zpci_configure_device(zdev, zdev->fh);
+	return zpci_scan_configured_device(zdev, zdev->fh);
 }
 
 static int disable_slot(struct hotplug_slot *hotplug_slot)
diff --git a/drivers/s390/cio/device.c b/drivers/s390/cio/device.c
index 3f026021e95e..84f659cafe76 100644
--- a/drivers/s390/cio/device.c
+++ b/drivers/s390/cio/device.c
@@ -1532,8 +1532,7 @@ static int io_subchannel_sch_event(struct subchannel *sch, int process)
 	switch (action) {
 	case IO_SCH_ORPH_UNREG:
 	case IO_SCH_UNREG:
-		if (!cdev)
-			css_sch_device_unregister(sch);
+		css_sch_device_unregister(sch);
 		break;
 	case IO_SCH_ORPH_ATTACH:
 	case IO_SCH_UNREG_ATTACH:
