Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18AB1278E71;
	Fri, 11 Apr 2025 10:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744365792; cv=none; b=Sy9nxPN7fuYiSN+WT4ZjVA8GSR3U4KvLtQvOgQdLZpdCt3PyyZJwaYr31yujd3Ng0cv7PB9tekKpcOlP95teAt7/2Vf+J9bUnx0NBRSXA3edxeusSpFOEQGiUAXGjefgO/TlgHQEP4WVJ6p5+pMKP9msjoRZLyhA2yQOh1NAnm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744365792; c=relaxed/simple;
	bh=ZFZvK1hQ6Il1o8GwmHkXm3+QjoYsQQLa+vs7iHlKSBE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=TU1Jzo4OuLkOzzvV5+DIsHxmUuSHM6ZPEpU/EU4RoErlRXvwbbQA7zFfX82QorspxAzCZICYSh9v0vgqGwk5RBifaPnPge8+oGYTrxWCF7ipPeVWe95cJFrobC7ajtZh2kQonopvdd3nWsA9+64MWQj/FujRH8nnFncX0icxqcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mir0FzYy; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mir0FzYy"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53B9A4EM012535;
	Fri, 11 Apr 2025 10:03:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:message-id:mime-version:subject:to; s=
	pp1; bh=WCG0DORcHuBEgcpXmBrn26UO/5KiAcZxldoLDXQJ5Wo=; b=mir0FzYy
	9wVqB4JzeHZs+wAvl1y/NiYne2m1EJG8Am/SEFn7hV+UBQh3JAcF3dpCx0Z8KUoG
	QDSdtAXX9gv+hinDzpdMzmtE8xAuBKnNI4H9bzDJ04EzBtWkfXR4SL7KWlXDIVWP
	IO5exyGS+cvlbORyREH47ELLbavcGCjH1+Rn8X/gEPBd/gDFlba9xvaotZWQAIfi
	uG+bShTWOsxtBEejV/ksrW3JEPdXGeM+VIUX1sZZHO1p0s+IH70sQjNMMOR7BZPO
	GRiZ8WSHjX4fG9OA9m8nfyq+FSjREoM5ZsoJg0stiM4YC74+mrfPLdXqJ2ZgDejt
	/zN8EqlQJ7HuFQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45xn71at1s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Apr 2025 10:03:08 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53B6KWA5018432;
	Fri, 11 Apr 2025 10:03:07 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 45uh2m28qk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Apr 2025 10:03:07 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53BA336425690646
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Apr 2025 10:03:03 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 63196204B9;
	Fri, 11 Apr 2025 10:03:03 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0108C204B7;
	Fri, 11 Apr 2025 10:03:03 +0000 (GMT)
Received: from osiris (unknown [9.171.65.230])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 11 Apr 2025 10:03:02 +0000 (GMT)
Date: Fri, 11 Apr 2025 12:03:01 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [GIT PULL] s390 updates for 6.15-rc2
Message-ID: <20250411100301.123863C11-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: zwBrCKbiMYGCYSk4GiZIspo29G7UNdPL
X-Proofpoint-GUID: zwBrCKbiMYGCYSk4GiZIspo29G7UNdPL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_03,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 impostorscore=0 mlxscore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 phishscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504110062

Hi Linus,

please pull s390 updates for 6.15-rc2. Please note that besides two bug
fixes this includes three commits for IBM z17, which was announced this
week. Those commits are simple and shouldn't cause any problems.

Thanks,
Heiko

The following changes since commit 0af2f6be1b4281385b618cb86ad946eded089ac8:

  Linux 6.15-rc1 (2025-04-06 13:11:33 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.15-3

for you to fetch changes up to aa1ac98268cd1f380c713f07e39b1fa1d5c7650c:

  s390/cpumf: Fix double free on error in cpumf_pmu_event_init() (2025-04-09 12:12:42 +0200)

----------------------------------------------------------------
s390 updates for 6.15-rc2

- Add IBM z17 bits:
  - Setup elf_platform for new machine types
  - Allow to compile the kernel with z17 optimizations
  - Add new performance counters

- Fix mismatch between indicator bits and queue indexes in virtio CCW code

- Fix double free in pmu setup error path

----------------------------------------------------------------
David Hildenbrand (1):
      s390/virtio_ccw: Don't allocate/assign airqs for non-existing queues

Thomas Richter (2):
      s390/cpumf: Update CPU Measurement facility extended counter set support
      s390/cpumf: Fix double free on error in cpumf_pmu_event_init()

Vasily Gorbik (2):
      s390: Add z17 elf platform
      s390: Allow to compile with z17 optimizations

 arch/s390/Kconfig                      |  19 ++++
 arch/s390/Makefile                     |   2 +
 arch/s390/include/asm/march.h          |   4 +
 arch/s390/kernel/perf_cpum_cf.c        |  11 +--
 arch/s390/kernel/perf_cpum_cf_events.c | 167 ++++++++++++++++++++++++++++++++-
 arch/s390/kernel/perf_cpum_sf.c        |   3 -
 arch/s390/kernel/processor.c           |   4 +
 arch/s390/tools/gen_facilities.c       |   3 +
 drivers/s390/virtio/virtio_ccw.c       |  16 +++-
 9 files changed, 210 insertions(+), 19 deletions(-)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index db8161ebb43c..99fb986fca6e 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -332,6 +332,10 @@ config HAVE_MARCH_Z16_FEATURES
 	def_bool n
 	select HAVE_MARCH_Z15_FEATURES
 
+config HAVE_MARCH_Z17_FEATURES
+	def_bool n
+	select HAVE_MARCH_Z16_FEATURES
+
 choice
 	prompt "Processor type"
 	default MARCH_Z196
@@ -397,6 +401,14 @@ config MARCH_Z16
 	  Select this to enable optimizations for IBM z16 (3931 and
 	  3932 series).
 
+config MARCH_Z17
+	bool "IBM z17"
+	select HAVE_MARCH_Z17_FEATURES
+	depends on $(cc-option,-march=z17)
+	help
+	  Select this to enable optimizations for IBM z17 (9175 and
+	  9176 series).
+
 endchoice
 
 config MARCH_Z10_TUNE
@@ -420,6 +432,9 @@ config MARCH_Z15_TUNE
 config MARCH_Z16_TUNE
 	def_bool TUNE_Z16 || MARCH_Z16 && TUNE_DEFAULT
 
+config MARCH_Z17_TUNE
+	def_bool TUNE_Z17 || MARCH_Z17 && TUNE_DEFAULT
+
 choice
 	prompt "Tune code generation"
 	default TUNE_DEFAULT
@@ -464,6 +479,10 @@ config TUNE_Z16
 	bool "IBM z16"
 	depends on $(cc-option,-mtune=z16)
 
+config TUNE_Z17
+	bool "IBM z17"
+	depends on $(cc-option,-mtune=z17)
+
 endchoice
 
 config 64BIT
diff --git a/arch/s390/Makefile b/arch/s390/Makefile
index b06dc53bfed5..7679bc16b692 100644
--- a/arch/s390/Makefile
+++ b/arch/s390/Makefile
@@ -48,6 +48,7 @@ mflags-$(CONFIG_MARCH_Z13)    := -march=z13
 mflags-$(CONFIG_MARCH_Z14)    := -march=z14
 mflags-$(CONFIG_MARCH_Z15)    := -march=z15
 mflags-$(CONFIG_MARCH_Z16)    := -march=z16
+mflags-$(CONFIG_MARCH_Z17)    := -march=z17
 
 export CC_FLAGS_MARCH := $(mflags-y)
 
@@ -61,6 +62,7 @@ cflags-$(CONFIG_MARCH_Z13_TUNE)		+= -mtune=z13
 cflags-$(CONFIG_MARCH_Z14_TUNE)		+= -mtune=z14
 cflags-$(CONFIG_MARCH_Z15_TUNE)		+= -mtune=z15
 cflags-$(CONFIG_MARCH_Z16_TUNE)		+= -mtune=z16
+cflags-$(CONFIG_MARCH_Z17_TUNE)		+= -mtune=z17
 
 cflags-y += -Wa,-I$(srctree)/arch/$(ARCH)/include
 
diff --git a/arch/s390/include/asm/march.h b/arch/s390/include/asm/march.h
index fd9eef3be44c..11a71bd14954 100644
--- a/arch/s390/include/asm/march.h
+++ b/arch/s390/include/asm/march.h
@@ -33,6 +33,10 @@
 #define MARCH_HAS_Z16_FEATURES 1
 #endif
 
+#ifdef CONFIG_HAVE_MARCH_Z17_FEATURES
+#define MARCH_HAS_Z17_FEATURES 1
+#endif
+
 #endif /* __DECOMPRESSOR */
 
 #endif /* __ASM_S390_MARCH_H */
diff --git a/arch/s390/kernel/perf_cpum_cf.c b/arch/s390/kernel/perf_cpum_cf.c
index 33205dd410e4..e657fad7e376 100644
--- a/arch/s390/kernel/perf_cpum_cf.c
+++ b/arch/s390/kernel/perf_cpum_cf.c
@@ -442,7 +442,7 @@ static void cpum_cf_make_setsize(enum cpumf_ctr_set ctrset)
 			ctrset_size = 48;
 		else if (cpumf_ctr_info.csvn >= 3 && cpumf_ctr_info.csvn <= 5)
 			ctrset_size = 128;
-		else if (cpumf_ctr_info.csvn == 6 || cpumf_ctr_info.csvn == 7)
+		else if (cpumf_ctr_info.csvn >= 6 && cpumf_ctr_info.csvn <= 8)
 			ctrset_size = 160;
 		break;
 	case CPUMF_CTR_SET_MT_DIAG:
@@ -858,18 +858,13 @@ static int cpumf_pmu_event_type(struct perf_event *event)
 static int cpumf_pmu_event_init(struct perf_event *event)
 {
 	unsigned int type = event->attr.type;
-	int err;
+	int err = -ENOENT;
 
 	if (type == PERF_TYPE_HARDWARE || type == PERF_TYPE_RAW)
 		err = __hw_perf_event_init(event, type);
 	else if (event->pmu->type == type)
 		/* Registered as unknown PMU */
 		err = __hw_perf_event_init(event, cpumf_pmu_event_type(event));
-	else
-		return -ENOENT;
-
-	if (unlikely(err) && event->destroy)
-		event->destroy(event);
 
 	return err;
 }
@@ -1819,8 +1814,6 @@ static int cfdiag_event_init(struct perf_event *event)
 	event->destroy = hw_perf_event_destroy;
 
 	err = cfdiag_event_init2(event);
-	if (unlikely(err))
-		event->destroy(event);
 out:
 	return err;
 }
diff --git a/arch/s390/kernel/perf_cpum_cf_events.c b/arch/s390/kernel/perf_cpum_cf_events.c
index e4a6bfc91080..690a293eb10d 100644
--- a/arch/s390/kernel/perf_cpum_cf_events.c
+++ b/arch/s390/kernel/perf_cpum_cf_events.c
@@ -237,7 +237,6 @@ CPUMF_EVENT_ATTR(cf_z14, TX_C_TABORT_NO_SPECIAL, 0x00f4);
 CPUMF_EVENT_ATTR(cf_z14, TX_C_TABORT_SPECIAL, 0x00f5);
 CPUMF_EVENT_ATTR(cf_z14, MT_DIAG_CYCLES_ONE_THR_ACTIVE, 0x01c0);
 CPUMF_EVENT_ATTR(cf_z14, MT_DIAG_CYCLES_TWO_THR_ACTIVE, 0x01c1);
-
 CPUMF_EVENT_ATTR(cf_z15, L1D_RO_EXCL_WRITES, 0x0080);
 CPUMF_EVENT_ATTR(cf_z15, DTLB2_WRITES, 0x0081);
 CPUMF_EVENT_ATTR(cf_z15, DTLB2_MISSES, 0x0082);
@@ -365,6 +364,83 @@ CPUMF_EVENT_ATTR(cf_z16, NNPA_WAIT_LOCK, 0x010d);
 CPUMF_EVENT_ATTR(cf_z16, NNPA_HOLD_LOCK, 0x010e);
 CPUMF_EVENT_ATTR(cf_z16, MT_DIAG_CYCLES_ONE_THR_ACTIVE, 0x01c0);
 CPUMF_EVENT_ATTR(cf_z16, MT_DIAG_CYCLES_TWO_THR_ACTIVE, 0x01c1);
+CPUMF_EVENT_ATTR(cf_z17, L1D_RO_EXCL_WRITES, 0x0080);
+CPUMF_EVENT_ATTR(cf_z17, DTLB2_WRITES, 0x0081);
+CPUMF_EVENT_ATTR(cf_z17, DTLB2_MISSES, 0x0082);
+CPUMF_EVENT_ATTR(cf_z17, CRSTE_1MB_WRITES, 0x0083);
+CPUMF_EVENT_ATTR(cf_z17, DTLB2_GPAGE_WRITES, 0x0084);
+CPUMF_EVENT_ATTR(cf_z17, ITLB2_WRITES, 0x0086);
+CPUMF_EVENT_ATTR(cf_z17, ITLB2_MISSES, 0x0087);
+CPUMF_EVENT_ATTR(cf_z17, TLB2_PTE_WRITES, 0x0089);
+CPUMF_EVENT_ATTR(cf_z17, TLB2_CRSTE_WRITES, 0x008a);
+CPUMF_EVENT_ATTR(cf_z17, TLB2_ENGINES_BUSY, 0x008b);
+CPUMF_EVENT_ATTR(cf_z17, TX_C_TEND, 0x008c);
+CPUMF_EVENT_ATTR(cf_z17, TX_NC_TEND, 0x008d);
+CPUMF_EVENT_ATTR(cf_z17, L1C_TLB2_MISSES, 0x008f);
+CPUMF_EVENT_ATTR(cf_z17, DCW_REQ, 0x0091);
+CPUMF_EVENT_ATTR(cf_z17, DCW_REQ_IV, 0x0092);
+CPUMF_EVENT_ATTR(cf_z17, DCW_REQ_CHIP_HIT, 0x0093);
+CPUMF_EVENT_ATTR(cf_z17, DCW_REQ_DRAWER_HIT, 0x0094);
+CPUMF_EVENT_ATTR(cf_z17, DCW_ON_CHIP, 0x0095);
+CPUMF_EVENT_ATTR(cf_z17, DCW_ON_CHIP_IV, 0x0096);
+CPUMF_EVENT_ATTR(cf_z17, DCW_ON_CHIP_CHIP_HIT, 0x0097);
+CPUMF_EVENT_ATTR(cf_z17, DCW_ON_CHIP_DRAWER_HIT, 0x0098);
+CPUMF_EVENT_ATTR(cf_z17, DCW_ON_MODULE, 0x0099);
+CPUMF_EVENT_ATTR(cf_z17, DCW_ON_DRAWER, 0x009a);
+CPUMF_EVENT_ATTR(cf_z17, DCW_OFF_DRAWER, 0x009b);
+CPUMF_EVENT_ATTR(cf_z17, DCW_ON_CHIP_MEMORY, 0x009c);
+CPUMF_EVENT_ATTR(cf_z17, DCW_ON_MODULE_MEMORY, 0x009d);
+CPUMF_EVENT_ATTR(cf_z17, DCW_ON_DRAWER_MEMORY, 0x009e);
+CPUMF_EVENT_ATTR(cf_z17, DCW_OFF_DRAWER_MEMORY, 0x009f);
+CPUMF_EVENT_ATTR(cf_z17, IDCW_ON_MODULE_IV, 0x00a0);
+CPUMF_EVENT_ATTR(cf_z17, IDCW_ON_MODULE_CHIP_HIT, 0x00a1);
+CPUMF_EVENT_ATTR(cf_z17, IDCW_ON_MODULE_DRAWER_HIT, 0x00a2);
+CPUMF_EVENT_ATTR(cf_z17, IDCW_ON_DRAWER_IV, 0x00a3);
+CPUMF_EVENT_ATTR(cf_z17, IDCW_ON_DRAWER_CHIP_HIT, 0x00a4);
+CPUMF_EVENT_ATTR(cf_z17, IDCW_ON_DRAWER_DRAWER_HIT, 0x00a5);
+CPUMF_EVENT_ATTR(cf_z17, IDCW_OFF_DRAWER_IV, 0x00a6);
+CPUMF_EVENT_ATTR(cf_z17, IDCW_OFF_DRAWER_CHIP_HIT, 0x00a7);
+CPUMF_EVENT_ATTR(cf_z17, IDCW_OFF_DRAWER_DRAWER_HIT, 0x00a8);
+CPUMF_EVENT_ATTR(cf_z17, ICW_REQ, 0x00a9);
+CPUMF_EVENT_ATTR(cf_z17, ICW_REQ_IV, 0x00aa);
+CPUMF_EVENT_ATTR(cf_z17, ICW_REQ_CHIP_HIT, 0x00ab);
+CPUMF_EVENT_ATTR(cf_z17, ICW_REQ_DRAWER_HIT, 0x00ac);
+CPUMF_EVENT_ATTR(cf_z17, ICW_ON_CHIP, 0x00ad);
+CPUMF_EVENT_ATTR(cf_z17, ICW_ON_CHIP_IV, 0x00ae);
+CPUMF_EVENT_ATTR(cf_z17, ICW_ON_CHIP_CHIP_HIT, 0x00af);
+CPUMF_EVENT_ATTR(cf_z17, ICW_ON_CHIP_DRAWER_HIT, 0x00b0);
+CPUMF_EVENT_ATTR(cf_z17, ICW_ON_MODULE, 0x00b1);
+CPUMF_EVENT_ATTR(cf_z17, ICW_ON_DRAWER, 0x00b2);
+CPUMF_EVENT_ATTR(cf_z17, ICW_OFF_DRAWER, 0x00b3);
+CPUMF_EVENT_ATTR(cf_z17, CYCLES_SAMETHRD, 0x00ca);
+CPUMF_EVENT_ATTR(cf_z17, CYCLES_DIFFTHRD, 0x00cb);
+CPUMF_EVENT_ATTR(cf_z17, INST_SAMETHRD, 0x00cc);
+CPUMF_EVENT_ATTR(cf_z17, INST_DIFFTHRD, 0x00cd);
+CPUMF_EVENT_ATTR(cf_z17, WRONG_BRANCH_PREDICTION, 0x00ce);
+CPUMF_EVENT_ATTR(cf_z17, VX_BCD_EXECUTION_SLOTS, 0x00e1);
+CPUMF_EVENT_ATTR(cf_z17, DECIMAL_INSTRUCTIONS, 0x00e2);
+CPUMF_EVENT_ATTR(cf_z17, LAST_HOST_TRANSLATIONS, 0x00e8);
+CPUMF_EVENT_ATTR(cf_z17, TX_NC_TABORT, 0x00f4);
+CPUMF_EVENT_ATTR(cf_z17, TX_C_TABORT_NO_SPECIAL, 0x00f5);
+CPUMF_EVENT_ATTR(cf_z17, TX_C_TABORT_SPECIAL, 0x00f6);
+CPUMF_EVENT_ATTR(cf_z17, DFLT_ACCESS, 0x00f8);
+CPUMF_EVENT_ATTR(cf_z17, DFLT_CYCLES, 0x00fd);
+CPUMF_EVENT_ATTR(cf_z17, SORTL, 0x0100);
+CPUMF_EVENT_ATTR(cf_z17, DFLT_CC, 0x0109);
+CPUMF_EVENT_ATTR(cf_z17, DFLT_CCFINISH, 0x010a);
+CPUMF_EVENT_ATTR(cf_z17, NNPA_INVOCATIONS, 0x010b);
+CPUMF_EVENT_ATTR(cf_z17, NNPA_COMPLETIONS, 0x010c);
+CPUMF_EVENT_ATTR(cf_z17, NNPA_WAIT_LOCK, 0x010d);
+CPUMF_EVENT_ATTR(cf_z17, NNPA_HOLD_LOCK, 0x010e);
+CPUMF_EVENT_ATTR(cf_z17, NNPA_INST_ONCHIP, 0x0110);
+CPUMF_EVENT_ATTR(cf_z17, NNPA_INST_OFFCHIP, 0x0111);
+CPUMF_EVENT_ATTR(cf_z17, NNPA_INST_DIFF, 0x0112);
+CPUMF_EVENT_ATTR(cf_z17, NNPA_4K_PREFETCH, 0x0114);
+CPUMF_EVENT_ATTR(cf_z17, NNPA_COMPL_LOCK, 0x0115);
+CPUMF_EVENT_ATTR(cf_z17, NNPA_RETRY_LOCK, 0x0116);
+CPUMF_EVENT_ATTR(cf_z17, NNPA_RETRY_LOCK_WITH_PLO, 0x0117);
+CPUMF_EVENT_ATTR(cf_z17, MT_DIAG_CYCLES_ONE_THR_ACTIVE, 0x01c0);
+CPUMF_EVENT_ATTR(cf_z17, MT_DIAG_CYCLES_TWO_THR_ACTIVE, 0x01c1);
 
 static struct attribute *cpumcf_fvn1_pmu_event_attr[] __initdata = {
 	CPUMF_EVENT_PTR(cf_fvn1, CPU_CYCLES),
@@ -414,7 +490,7 @@ static struct attribute *cpumcf_svn_12345_pmu_event_attr[] __initdata = {
 	NULL,
 };
 
-static struct attribute *cpumcf_svn_67_pmu_event_attr[] __initdata = {
+static struct attribute *cpumcf_svn_678_pmu_event_attr[] __initdata = {
 	CPUMF_EVENT_PTR(cf_svn_12345, PRNG_FUNCTIONS),
 	CPUMF_EVENT_PTR(cf_svn_12345, PRNG_CYCLES),
 	CPUMF_EVENT_PTR(cf_svn_12345, PRNG_BLOCKED_FUNCTIONS),
@@ -779,6 +855,87 @@ static struct attribute *cpumcf_z16_pmu_event_attr[] __initdata = {
 	NULL,
 };
 
+static struct attribute *cpumcf_z17_pmu_event_attr[] __initdata = {
+	CPUMF_EVENT_PTR(cf_z17, L1D_RO_EXCL_WRITES),
+	CPUMF_EVENT_PTR(cf_z17, DTLB2_WRITES),
+	CPUMF_EVENT_PTR(cf_z17, DTLB2_MISSES),
+	CPUMF_EVENT_PTR(cf_z17, CRSTE_1MB_WRITES),
+	CPUMF_EVENT_PTR(cf_z17, DTLB2_GPAGE_WRITES),
+	CPUMF_EVENT_PTR(cf_z17, ITLB2_WRITES),
+	CPUMF_EVENT_PTR(cf_z17, ITLB2_MISSES),
+	CPUMF_EVENT_PTR(cf_z17, TLB2_PTE_WRITES),
+	CPUMF_EVENT_PTR(cf_z17, TLB2_CRSTE_WRITES),
+	CPUMF_EVENT_PTR(cf_z17, TLB2_ENGINES_BUSY),
+	CPUMF_EVENT_PTR(cf_z17, TX_C_TEND),
+	CPUMF_EVENT_PTR(cf_z17, TX_NC_TEND),
+	CPUMF_EVENT_PTR(cf_z17, L1C_TLB2_MISSES),
+	CPUMF_EVENT_PTR(cf_z17, DCW_REQ),
+	CPUMF_EVENT_PTR(cf_z17, DCW_REQ_IV),
+	CPUMF_EVENT_PTR(cf_z17, DCW_REQ_CHIP_HIT),
+	CPUMF_EVENT_PTR(cf_z17, DCW_REQ_DRAWER_HIT),
+	CPUMF_EVENT_PTR(cf_z17, DCW_ON_CHIP),
+	CPUMF_EVENT_PTR(cf_z17, DCW_ON_CHIP_IV),
+	CPUMF_EVENT_PTR(cf_z17, DCW_ON_CHIP_CHIP_HIT),
+	CPUMF_EVENT_PTR(cf_z17, DCW_ON_CHIP_DRAWER_HIT),
+	CPUMF_EVENT_PTR(cf_z17, DCW_ON_MODULE),
+	CPUMF_EVENT_PTR(cf_z17, DCW_ON_DRAWER),
+	CPUMF_EVENT_PTR(cf_z17, DCW_OFF_DRAWER),
+	CPUMF_EVENT_PTR(cf_z17, DCW_ON_CHIP_MEMORY),
+	CPUMF_EVENT_PTR(cf_z17, DCW_ON_MODULE_MEMORY),
+	CPUMF_EVENT_PTR(cf_z17, DCW_ON_DRAWER_MEMORY),
+	CPUMF_EVENT_PTR(cf_z17, DCW_OFF_DRAWER_MEMORY),
+	CPUMF_EVENT_PTR(cf_z17, IDCW_ON_MODULE_IV),
+	CPUMF_EVENT_PTR(cf_z17, IDCW_ON_MODULE_CHIP_HIT),
+	CPUMF_EVENT_PTR(cf_z17, IDCW_ON_MODULE_DRAWER_HIT),
+	CPUMF_EVENT_PTR(cf_z17, IDCW_ON_DRAWER_IV),
+	CPUMF_EVENT_PTR(cf_z17, IDCW_ON_DRAWER_CHIP_HIT),
+	CPUMF_EVENT_PTR(cf_z17, IDCW_ON_DRAWER_DRAWER_HIT),
+	CPUMF_EVENT_PTR(cf_z17, IDCW_OFF_DRAWER_IV),
+	CPUMF_EVENT_PTR(cf_z17, IDCW_OFF_DRAWER_CHIP_HIT),
+	CPUMF_EVENT_PTR(cf_z17, IDCW_OFF_DRAWER_DRAWER_HIT),
+	CPUMF_EVENT_PTR(cf_z17, ICW_REQ),
+	CPUMF_EVENT_PTR(cf_z17, ICW_REQ_IV),
+	CPUMF_EVENT_PTR(cf_z17, ICW_REQ_CHIP_HIT),
+	CPUMF_EVENT_PTR(cf_z17, ICW_REQ_DRAWER_HIT),
+	CPUMF_EVENT_PTR(cf_z17, ICW_ON_CHIP),
+	CPUMF_EVENT_PTR(cf_z17, ICW_ON_CHIP_IV),
+	CPUMF_EVENT_PTR(cf_z17, ICW_ON_CHIP_CHIP_HIT),
+	CPUMF_EVENT_PTR(cf_z17, ICW_ON_CHIP_DRAWER_HIT),
+	CPUMF_EVENT_PTR(cf_z17, ICW_ON_MODULE),
+	CPUMF_EVENT_PTR(cf_z17, ICW_ON_DRAWER),
+	CPUMF_EVENT_PTR(cf_z17, ICW_OFF_DRAWER),
+	CPUMF_EVENT_PTR(cf_z17, CYCLES_SAMETHRD),
+	CPUMF_EVENT_PTR(cf_z17, CYCLES_DIFFTHRD),
+	CPUMF_EVENT_PTR(cf_z17, INST_SAMETHRD),
+	CPUMF_EVENT_PTR(cf_z17, INST_DIFFTHRD),
+	CPUMF_EVENT_PTR(cf_z17, WRONG_BRANCH_PREDICTION),
+	CPUMF_EVENT_PTR(cf_z17, VX_BCD_EXECUTION_SLOTS),
+	CPUMF_EVENT_PTR(cf_z17, DECIMAL_INSTRUCTIONS),
+	CPUMF_EVENT_PTR(cf_z17, LAST_HOST_TRANSLATIONS),
+	CPUMF_EVENT_PTR(cf_z17, TX_NC_TABORT),
+	CPUMF_EVENT_PTR(cf_z17, TX_C_TABORT_NO_SPECIAL),
+	CPUMF_EVENT_PTR(cf_z17, TX_C_TABORT_SPECIAL),
+	CPUMF_EVENT_PTR(cf_z17, DFLT_ACCESS),
+	CPUMF_EVENT_PTR(cf_z17, DFLT_CYCLES),
+	CPUMF_EVENT_PTR(cf_z17, SORTL),
+	CPUMF_EVENT_PTR(cf_z17, DFLT_CC),
+	CPUMF_EVENT_PTR(cf_z17, DFLT_CCFINISH),
+	CPUMF_EVENT_PTR(cf_z17, NNPA_INVOCATIONS),
+	CPUMF_EVENT_PTR(cf_z17, NNPA_COMPLETIONS),
+	CPUMF_EVENT_PTR(cf_z17, NNPA_WAIT_LOCK),
+	CPUMF_EVENT_PTR(cf_z17, NNPA_HOLD_LOCK),
+	CPUMF_EVENT_PTR(cf_z17, NNPA_INST_ONCHIP),
+	CPUMF_EVENT_PTR(cf_z17, NNPA_INST_OFFCHIP),
+	CPUMF_EVENT_PTR(cf_z17, NNPA_INST_DIFF),
+	CPUMF_EVENT_PTR(cf_z17, NNPA_4K_PREFETCH),
+	CPUMF_EVENT_PTR(cf_z17, NNPA_COMPL_LOCK),
+	CPUMF_EVENT_PTR(cf_z17, NNPA_RETRY_LOCK),
+	CPUMF_EVENT_PTR(cf_z17, NNPA_RETRY_LOCK_WITH_PLO),
+	CPUMF_EVENT_PTR(cf_z17, MT_DIAG_CYCLES_ONE_THR_ACTIVE),
+	CPUMF_EVENT_PTR(cf_z17, MT_DIAG_CYCLES_TWO_THR_ACTIVE),
+	NULL,
+};
+
 /* END: CPUM_CF COUNTER DEFINITIONS ===================================== */
 
 static struct attribute_group cpumcf_pmu_events_group = {
@@ -859,7 +1016,7 @@ __init const struct attribute_group **cpumf_cf_event_group(void)
 	if (ci.csvn >= 1 && ci.csvn <= 5)
 		csvn = cpumcf_svn_12345_pmu_event_attr;
 	else if (ci.csvn >= 6)
-		csvn = cpumcf_svn_67_pmu_event_attr;
+		csvn = cpumcf_svn_678_pmu_event_attr;
 
 	/* Determine model-specific counter set(s) */
 	get_cpu_id(&cpu_id);
@@ -892,6 +1049,10 @@ __init const struct attribute_group **cpumf_cf_event_group(void)
 	case 0x3932:
 		model = cpumcf_z16_pmu_event_attr;
 		break;
+	case 0x9175:
+	case 0x9176:
+		model = cpumcf_z17_pmu_event_attr;
+		break;
 	default:
 		model = none;
 		break;
diff --git a/arch/s390/kernel/perf_cpum_sf.c b/arch/s390/kernel/perf_cpum_sf.c
index 5f60248cb468..ad22799d8a7d 100644
--- a/arch/s390/kernel/perf_cpum_sf.c
+++ b/arch/s390/kernel/perf_cpum_sf.c
@@ -885,9 +885,6 @@ static int cpumsf_pmu_event_init(struct perf_event *event)
 		event->attr.exclude_idle = 0;
 
 	err = __hw_perf_event_init(event);
-	if (unlikely(err))
-		if (event->destroy)
-			event->destroy(event);
 	return err;
 }
 
diff --git a/arch/s390/kernel/processor.c b/arch/s390/kernel/processor.c
index 54e281436a28..80b1f7a29f11 100644
--- a/arch/s390/kernel/processor.c
+++ b/arch/s390/kernel/processor.c
@@ -294,6 +294,10 @@ static int __init setup_elf_platform(void)
 	case 0x3932:
 		strcpy(elf_platform, "z16");
 		break;
+	case 0x9175:
+	case 0x9176:
+		strcpy(elf_platform, "z17");
+		break;
 	}
 	return 0;
 }
diff --git a/arch/s390/tools/gen_facilities.c b/arch/s390/tools/gen_facilities.c
index 855f818deb98..d5c68ade71ab 100644
--- a/arch/s390/tools/gen_facilities.c
+++ b/arch/s390/tools/gen_facilities.c
@@ -53,6 +53,9 @@ static struct facility_def facility_defs[] = {
 #endif
 #ifdef CONFIG_HAVE_MARCH_Z15_FEATURES
 			61, /* miscellaneous-instruction-extension 3 */
+#endif
+#ifdef CONFIG_HAVE_MARCH_Z17_FEATURES
+			84, /* miscellaneous-instruction-extension 4 */
 #endif
 			-1 /* END */
 		}
diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
index 21fa7ac849e5..4904b831c0a7 100644
--- a/drivers/s390/virtio/virtio_ccw.c
+++ b/drivers/s390/virtio/virtio_ccw.c
@@ -302,11 +302,17 @@ static struct airq_info *new_airq_info(int index)
 static unsigned long *get_airq_indicator(struct virtqueue *vqs[], int nvqs,
 					 u64 *first, void **airq_info)
 {
-	int i, j;
+	int i, j, queue_idx, highest_queue_idx = -1;
 	struct airq_info *info;
 	unsigned long *indicator_addr = NULL;
 	unsigned long bit, flags;
 
+	/* Array entries without an actual queue pointer must be ignored. */
+	for (i = 0; i < nvqs; i++) {
+		if (vqs[i])
+			highest_queue_idx++;
+	}
+
 	for (i = 0; i < MAX_AIRQ_AREAS && !indicator_addr; i++) {
 		mutex_lock(&airq_areas_lock);
 		if (!airq_areas[i])
@@ -316,7 +322,7 @@ static unsigned long *get_airq_indicator(struct virtqueue *vqs[], int nvqs,
 		if (!info)
 			return NULL;
 		write_lock_irqsave(&info->lock, flags);
-		bit = airq_iv_alloc(info->aiv, nvqs);
+		bit = airq_iv_alloc(info->aiv, highest_queue_idx + 1);
 		if (bit == -1UL) {
 			/* Not enough vacancies. */
 			write_unlock_irqrestore(&info->lock, flags);
@@ -325,8 +331,10 @@ static unsigned long *get_airq_indicator(struct virtqueue *vqs[], int nvqs,
 		*first = bit;
 		*airq_info = info;
 		indicator_addr = info->aiv->vector;
-		for (j = 0; j < nvqs; j++) {
-			airq_iv_set_ptr(info->aiv, bit + j,
+		for (j = 0, queue_idx = 0; j < nvqs; j++) {
+			if (!vqs[j])
+				continue;
+			airq_iv_set_ptr(info->aiv, bit + queue_idx++,
 					(unsigned long)vqs[j]);
 		}
 		write_unlock_irqrestore(&info->lock, flags);
