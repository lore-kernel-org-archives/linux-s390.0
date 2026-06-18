Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4683F482F;
	Thu, 18 Jun 2026 12:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781784071; cv=none; b=js3EcqBKqibVO6+dfWD3QG9ffS8LyJ68hFJy6u9lxn7IXsvBnsPvPCVb7Gw9HQfPbgEH46iuX2uaMGyQLEwskPQxLCqwKwyCnMwUIXudbxHKAX6aQfd+lX5qAJmoz4GSn1XDU8lLKUV+2sWibmoXf2E+dtZkcoV5cwL4oCUL14s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781784071; c=relaxed/simple;
	bh=7h9XsBFKO8untNkvu7CInJE9W6fpnjiBBBrEMJ5/8W0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WFPTqo8IohL9eQGf1jFFzlMVkwM2eIK90qGNYZ0u/q/KW6ETh30+9QpxB7UGHU9d2Jp2vlpOVw62RraksLL/TkONElcmJc28wlDYv8numd3f8I5p5mt2FfIjzG8r8h3ss1sojCvBd5X0ZqfXC881Yyt6gPLXSJKdVrv1Irf3xAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lQ/mXd8H; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lQ/mXd8H"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65IBIEpv3430676;
	Thu, 18 Jun 2026 12:00:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=VAkr7m
	6Aj9Dwqdkp5GdKWDesNwWjDX0XAtVryFjF+9E=; b=lQ/mXd8HzeOkx2bYM8ZRz5
	WVh0TYgGp+FLg98viju547jSxS8XseGw9Ch3ul0+6383cxRzQmflSbOiF5Gv6sT1
	8+eb2v5nXOwmhp2P7RRFYQwwez/rYVe6y96jlSlDQCbHKMouEzOH9KAmxufR5Tmp
	fSA99HYjVLTiUd0hRl6RNz5uQAHMj5K7BSQ/YhUT2lDjQgSm/Z9+t9rMRdnl7WBH
	yBt0lQTU6kqgyDkl/54L6v6GRhiUcjSoHDHeHVMlTFyFSEy+Xj2urYAsc5OtvGOv
	OB9rS6XfZW4VEZiRZPBgmzc99F9WP4ApW+AJBmeuT6c5crTpTjbKvNgJEJke9wrg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4euequ7w3s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2026 12:00:53 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65IBnr6L024878;
	Thu, 18 Jun 2026 12:00:52 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ev1723je6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2026 12:00:52 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65IC0mIB46399786
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Jun 2026 12:00:48 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A479C2004B;
	Thu, 18 Jun 2026 12:00:48 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DA03E20043;
	Thu, 18 Jun 2026 12:00:47 +0000 (GMT)
Received: from [192.168.2.127] (unknown [9.111.73.152])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 18 Jun 2026 12:00:47 +0000 (GMT)
From: Mete Durlu <meted@linux.ibm.com>
Date: Thu, 18 Jun 2026 14:00:18 +0200
Subject: [PATCH v3 4/5] s390/idle: Introduce cpuidle for s390
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260618-idledriver-v3-4-684061eecbcb@linux.ibm.com>
References: <20260618-idledriver-v3-0-684061eecbcb@linux.ibm.com>
In-Reply-To: <20260618-idledriver-v3-0-684061eecbcb@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDExMCBTYWx0ZWRfX3nZU2z6UHwsB
 unRKwxItL1YTqv3JiNEV9VLIqOP/VMca+RoCVPcyH2mBWYdn1EEMbb9KZ/Rcg4S48xpiSEzjHsc
 ilgMs6vsMjHKYvjTK9Ucx1ZObykVnX0=
X-Proofpoint-ORIG-GUID: 6y3tB4WJoAdXdYkXpkZOH6QKE2_w4to9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDExMCBTYWx0ZWRfXye4qL/perv2Z
 18TJPRiLQtYMdDBh4lOLtSbSxFeaCPJttQHP1NjaedXVJKlw5PkaJ3T06pwgRfAfr3Yob51Ke2I
 ASMyH6n8Qp188GkHa/FIlwkh9rAKdMwEdnvDfPKZh4/T0XwIrAxxlRCKHc1/KNMDk+LqexAr9wH
 hYhk5bp59JTXreWYByQXgf6U1gqfDgOoUN3O7Kc6uAkMbMiCipP864dFYZkcLo5ht9A+kBCJGuu
 0YgUXaDBVJgDlUfS4o6eFgLqXSxNIUyNNXXBKm2fBmEWaRpvqWKpbX4bMw7xtnEimyyxmZbQyVn
 470msa4d/BsU3t+Gyn4Tmn8EgvSIiZIviI7k7CDO2cQHdC7p6MfviU42eupwqCpCG6O6iFJ78F8
 qqer375ZERrxGjs5GzygcTW33EP00JSybAGk5gHL6REYmeKe3bMNLvsPKfk4k2GHrgRcdWS/nAQ
 qt5Ndh5u+wtH2zbL6wA==
X-Proofpoint-GUID: 6y3tB4WJoAdXdYkXpkZOH6QKE2_w4to9
X-Authority-Analysis: v=2.4 cv=L9gtheT8 c=1 sm=1 tr=0 ts=6a33ddf5 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=JfrnYn6hAAAA:8 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=pGLkceISAAAA:8
 a=ju7MIqAqtdGQbkcOs90A:9 a=QEXdDO2ut3YA:10 a=1CNFftbPRP8L7MoqJWF3:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_01,2026-06-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 malwarescore=0 clxscore=1015 adultscore=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180110

Introduce generic cpuidle driver on s390. Use a two stage approach to
handle idle scenarios and use idle governor for idle stage selection.
Two stages are, from shallow to deep, idle polling and enabled wait.

Suggested-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Suggested-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Mete Durlu <meted@linux.ibm.com>
---
 MAINTAINERS                    |   8 +++
 arch/s390/Kconfig              |   5 ++
 drivers/cpuidle/Kconfig        |   5 ++
 drivers/cpuidle/Kconfig.s390   |  11 ++++
 drivers/cpuidle/Makefile       |   4 ++
 drivers/cpuidle/cpuidle-s390.c | 115 +++++++++++++++++++++++++++++++++++++++++
 6 files changed, 148 insertions(+)

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
index 000000000000..1d02a77ebce0
--- /dev/null
+++ b/drivers/cpuidle/cpuidle-s390.c
@@ -0,0 +1,115 @@
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
+/*
+ * The target_residency and exit_latency values are benchmark-derived estimates
+ * that remain non-deterministic due to s390's virtualized architecture.
+ *
+ * Configuration strategy:
+ * - Poll idle state: Values derived from the next enabled idle state (EW)
+ * - Enabled Wait state: Values selected based on idle behavior and empirical
+ *   measurement data
+ *
+ * Goal is to improve responsiveness for workloads with frequent sleep/wakeup
+ * cycles while minimizing any side effects.
+ */
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

