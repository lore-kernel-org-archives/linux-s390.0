Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA41283FE6;
	Tue,  9 Jun 2026 13:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781011486; cv=none; b=OFFw6V7WFDo8Ixy7dYv+xFP4KI3qzD3D4b0WncyViegiNXDrG0bnw1RgsNSPeDaRzHtL7d/a8Vo72thdNErEYKDnvaT4H1HEXzD7nadci8CKrXoHQVJR5oK5mIVVXCM6xk7sMII5CWD8HbzJ70KkVfFAr6dAFDCe1+grK2YF5uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781011486; c=relaxed/simple;
	bh=oSjLBvgXWjwGE+3o0zBUxqM5xPWwnMsQcf4CRMgPX5k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aujFZZE5G0v9BU3yXB8PUhtADfmgfmyJgOBPYPs8jwX049wsozpdnTAu2l5gP39mn2D4Hd3AAJEACdySA+o4MWVBHp5E7OepGCXNw/RcU6Z5ZkAqc0fdgzs2Jca74GvU9r/X4u2BVn5Cl6BAmPMH9bfcv+phpXuy/DBx16IARBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Ch+J6oDZ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ch+J6oDZ"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65930qx13417938;
	Tue, 9 Jun 2026 13:24:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=MCldwu
	TGObF+LIdHetzJOa9dtOwDpZSbkBQ04Ipa35c=; b=Ch+J6oDZsv+XAIZ+NFsJsk
	AIpGVbnxU2ZiSLLIz0O5frcDUxP6PW4pwuoaAfcngZ746jMv9bhx9leDTZK1bf55
	c2UtvKWLvwbK+4DnK1E4Ynznj754Xwy5qsHj0VrsgKRfSZCGveL1yk+m8xG3vrjg
	qz5eIOZJUgd9mEcR2v6lCK8TF1lrAzrQxamW/llpJDIK7BLeyKWo9PpuKfcE3fAk
	k+sDaTFcTr0tEoXdAkmdCtUe+OnXYwdNSB/7pQpw9OCfqcU2X5mwpsCuCmULnOs5
	dTaG4McSW881Tqbk4IMwi7aNpcSEI6ZDv0UEzV5M/9lOCrv3nKyrzzGxM32rUvAQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb6sv15a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jun 2026 13:24:33 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 659DJcKV030717;
	Tue, 9 Jun 2026 13:24:32 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4en03g1xnq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jun 2026 13:24:32 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 659DOThg18219366
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Jun 2026 13:24:29 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0999620043;
	Tue,  9 Jun 2026 13:24:29 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CD6CA2004E;
	Tue,  9 Jun 2026 13:24:28 +0000 (GMT)
Received: from [9.224.76.67] (unknown [9.224.76.67])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  9 Jun 2026 13:24:28 +0000 (GMT)
From: Mete Durlu <meted@linux.ibm.com>
Date: Tue, 09 Jun 2026 15:24:24 +0200
Subject: [PATCH v2 4/5] s390/idle: Introduce cpuidle for s390
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-idledriver-v2-4-21c2f581d11f@linux.ibm.com>
References: <20260609-idledriver-v2-0-21c2f581d11f@linux.ibm.com>
In-Reply-To: <20260609-idledriver-v2-0-21c2f581d11f@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Christian Loehle <christian.loehle@arm.com>
Cc: Mete Durlu <meted@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
X-Mailer: b4 0.14.3
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 99K811SRGH5axqv6wNg7GO4gpSj7Xt6R
X-Proofpoint-GUID: 99K811SRGH5axqv6wNg7GO4gpSj7Xt6R
X-Authority-Analysis: v=2.4 cv=ZbEt8MVA c=1 sm=1 tr=0 ts=6a281411 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=JfrnYn6hAAAA:8 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=pGLkceISAAAA:8
 a=96sC0f_vMCLJJrx88uQA:9 a=QEXdDO2ut3YA:10 a=1CNFftbPRP8L7MoqJWF3:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDEyNCBTYWx0ZWRfX9VBIDF6YkBY4
 u8EmMUUwCiltux6COpQdYdtObB9vPbvD4W5+5rLTRvnLUKFILk7Y4app8SWfgCcX9Ykm58sFQrV
 ZlH+h56V8EUUppH/ttjPzJD2RG+Ulof5MB/Ox3M3QeFrI6w4AvZdbfdIFf7tDV7ai546avSCMSe
 DEUamMqN+OD5YHibtMciSmxubzpUrI+pq2FHZaNh9YtdptA0v6nO8FAo0R5Y2nScng2OEMPJMX9
 VsVaNzcG59RDJ7h1XRlfNLUq8/IDAc/pexfCsVJsDuktvmjIBaQcrEw6sFqcNxW+2HCB3zWFI2P
 XzHU18AO8Pe+MbpVl3ltc20/eh/7l/DgzHkwAu9EBb+Kg+KM8VvvweqDN5iegvdp+lmdyUswZRF
 +PyhuqsdEkIPBgYP9AdjHaxjui4e33A/kqc5VuqVObF3tPC4vNrQ91x3Sw5IZVsZxAb7Left0po
 Mnx1ieMDedqMfz1SI4Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_03,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606090124

Introduce generic cpuidle driver on s390. Use a two stage approach to
handle idle scenarios and use TEO governor for idle stage selection.
Two stages are, from shallow to deep, idle polling and enabled wait.

Suggested-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Suggested-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Mete Durlu <meted@linux.ibm.com>
---
 MAINTAINERS                    |   8 ++++
 arch/s390/Kconfig              |   5 ++
 drivers/cpuidle/Kconfig        |   5 ++
 drivers/cpuidle/Kconfig.s390   |  11 +++++
 drivers/cpuidle/Makefile       |   4 ++
 drivers/cpuidle/cpuidle-s390.c | 104 +++++++++++++++++++++++++++++++++++++++++
 6 files changed, 137 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e035a3be797c..127e32c5fb4e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6766,6 +6766,13 @@ L:	linux-riscv@lists.infradead.org
 S:	Maintained
 F:	drivers/cpuidle/cpuidle-riscv-sbi.c
 
+CPUIDLE DRIVER - S390
+M:	Mete Durlu <meted@linux.ibm.com>
+L:	linux-pm@vger.kernel.org
+L:	linux-s390@vger.kernel.org
+S:	Maintained
+F:	drivers/cpuidle/cpuidle-s390.c
+
 CPUMASK API [RUST]
 M:	Viresh Kumar <viresh.kumar@linaro.org>
 R:	Yury Norov <yury.norov@gmail.com>
@@ -23497,6 +23504,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git
 F:	Documentation/driver-api/s390-drivers.rst
 F:	Documentation/arch/s390/
 F:	arch/s390/
+F:	drivers/cpuidle/cpuidle-s390.c
 F:	drivers/s390/
 F:	drivers/watchdog/diag288_wdt.c
 
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index ecbcbb781e40..8548f5b6b247 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -20,6 +20,9 @@ config ARCH_HAS_ILOG2_U64
 config ARCH_PROC_KCORE_TEXT
 	def_bool y
 
+config ARCH_HAS_CPU_RELAX
+	def_bool y
+
 config GENERIC_HWEIGHT
 	def_bool !HAVE_MARCH_Z196_FEATURES
 
@@ -708,6 +711,8 @@ config KERNEL_IMAGE_BASE
 
 endmenu
 
+source "drivers/cpuidle/Kconfig"
+
 menu "Memory setup"
 
 config ARCH_SPARSEMEM_ENABLE
diff --git a/drivers/cpuidle/Kconfig b/drivers/cpuidle/Kconfig
index d6d8386d3f02..00e2562041fd 100644
--- a/drivers/cpuidle/Kconfig
+++ b/drivers/cpuidle/Kconfig
@@ -71,6 +71,11 @@ depends on RISCV
 source "drivers/cpuidle/Kconfig.riscv"
 endmenu
 
+menu "S390 CPU Idle Drivers"
+depends on S390
+source "drivers/cpuidle/Kconfig.s390"
+endmenu
+
 config HALTPOLL_CPUIDLE
 	tristate "Halt poll cpuidle driver"
 	depends on X86 && KVM_GUEST
diff --git a/drivers/cpuidle/Kconfig.s390 b/drivers/cpuidle/Kconfig.s390
new file mode 100644
index 000000000000..0b170d9a190b
--- /dev/null
+++ b/drivers/cpuidle/Kconfig.s390
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# S390 CPU Idle drivers
+#
+
+config S390_CPUIDLE
+	bool "S390 CPU idle driver"
+	default y
+	help
+          Select this option to enable processor idle state management
+          through cpuidle subsystem.
diff --git a/drivers/cpuidle/Makefile b/drivers/cpuidle/Makefile
index 1de9e92c5b0f..88cbc2a7aea8 100644
--- a/drivers/cpuidle/Makefile
+++ b/drivers/cpuidle/Makefile
@@ -42,3 +42,7 @@ obj-$(CONFIG_POWERNV_CPUIDLE)		+= cpuidle-powernv.o
 ###############################################################################
 # RISC-V drivers
 obj-$(CONFIG_RISCV_SBI_CPUIDLE)		+= cpuidle-riscv-sbi.o
+
+###############################################################################
+# S390 drivers
+obj-$(CONFIG_S390_CPUIDLE)		+= cpuidle-s390.o
diff --git a/drivers/cpuidle/cpuidle-s390.c b/drivers/cpuidle/cpuidle-s390.c
new file mode 100644
index 000000000000..58b738ea0150
--- /dev/null
+++ b/drivers/cpuidle/cpuidle-s390.c
@@ -0,0 +1,104 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * s390 generic CPU idle driver.
+ *
+ * Copyright IBM Corp. 2026
+ */
+
+#define pr_fmt(fmt) "CPUidle s390: " fmt
+
+#include <linux/init.h>
+#include <linux/cpuidle.h>
+#include <linux/cpu.h>
+#include <linux/sched/clock.h>
+
+static __cpuidle int s390_enter_idle(struct cpuidle_device *dev,
+				     struct cpuidle_driver *drv,
+				     int index)
+{
+	arch_cpu_idle();
+	return index;
+}
+
+static struct cpuidle_driver s390_cpuidle_driver = {
+	.cpumask = (struct cpumask *)cpu_present_mask,
+	.name = "s390-idle",
+	.governor = "teo",
+	.states = {
+		{ /* entry 0 is for polling */},
+		{
+			.enter			= s390_enter_idle,
+			.name			= "IDLE",
+			.desc			= "ENABLED WAIT",
+		},
+	},
+	.safe_state_index = 0,
+	.state_count = 2,
+};
+
+static int s390_cpuidle_cpu_online(unsigned int cpu)
+{
+	struct cpuidle_device *dev = &per_cpu(cpuidle_dev, cpu);
+	int rc;
+
+	if (dev->registered) {
+		cpuidle_pause_and_lock();
+		rc = cpuidle_enable_device(dev);
+		cpuidle_resume_and_unlock();
+		if (rc)
+			pr_err("Failed to enable cpuidle device on cpu %u\n", cpu);
+	} else {
+		dev->cpu = cpu;
+		rc = cpuidle_register_device(dev);
+		if (rc)
+			pr_err("Failed to register cpuidle driver on cpu %u\n", cpu);
+	}
+	return rc;
+}
+
+static int s390_cpuidle_cpu_dead(unsigned int cpu)
+{
+	struct cpuidle_device *dev = &per_cpu(cpuidle_dev, cpu);
+
+	if (!dev->registered)
+		return 0;
+	cpuidle_pause_and_lock();
+	cpuidle_disable_device(dev);
+	cpuidle_resume_and_unlock();
+	return 0;
+}
+
+static void __init s390_cpuidle_ew_tune(void)
+{
+	struct cpuidle_state *state = &s390_cpuidle_driver.states[1];
+
+	if (machine_is_lpar()) {
+		state->target_residency = 5;
+		state->exit_latency = 5;
+	} else {
+		state->target_residency = 1;
+		state->exit_latency = 1;
+	}
+}
+
+static int __init s390_cpuidle_init(void)
+{
+	int rc;
+
+	s390_cpuidle_ew_tune();
+	cpuidle_poll_state_init(&s390_cpuidle_driver);
+	rc = cpuidle_register(&s390_cpuidle_driver, NULL);
+	if (rc)
+		return rc;
+	rc = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
+				       "cpuidle/s390:online",
+				       s390_cpuidle_cpu_online,
+				       s390_cpuidle_cpu_dead);
+	if (rc < 0) {
+		cpuidle_unregister(&s390_cpuidle_driver);
+		pr_err("Failed to allocate hotplug state: cpuidle/s390:online\n");
+		return rc;
+	}
+	return 0;
+}
+device_initcall(s390_cpuidle_init);

-- 
2.54.0

