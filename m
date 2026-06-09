Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C335D38F620;
	Tue,  9 Jun 2026 07:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780991564; cv=none; b=fnD8x14558EUq6Pvu0Q8qtcEYVIgeLcjpeT8rR0iE4jPCCY4MYVA3pZRKz7uAdk1JUigFJXB4ivr00BX3oROX0zVMGrIjZjNeZoM53OB6uZ8L4WpgB2pbU8IB0O4ci3IWgEtAtc2v4z1QGkc2aWAnc3PHswPmk0ArqJwT3C+tvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780991564; c=relaxed/simple;
	bh=d58Uzo/L4Vb15l9KaH2N5+kjpvaXbtqDc8v8+AXZJ+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k1xbI5m8GcrGdNaear3gkZRIsoCWwaIlpUr7oRymTyzU4T9ueR/1z18qOqIo5J2bwsBMTag15q3LHi3GQ31oKts9d+rZWKZEvwn3dtCcYdCHMByzs3dP1D0PwbI1k4qpETpnYgaxEAnPR14KJZs83jl9xDJ3mfu7nL1DqbIIKIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RiXwxrWm; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RiXwxrWm"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658Ivn4u2323666;
	Tue, 9 Jun 2026 07:52:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Qu7bwW3j2Bwlvuu75
	8BLys4mkVnb7fWj610sU1ls1vE=; b=RiXwxrWmBaS7hrDQqa7Wr/PrBu++/dNa1
	YZrW8BJ+YYF+bX6afIKzWdkehY3HjdwD5Lwv5POe6+SDwx5KWM+1u0mNwHLYihSQ
	pq8kdamhSvQTksufm5HZWZCG1WlTv58Hm15v9mZT7DUY7U/JBweUCKJy8aGKlXQ6
	5AkkJVeGya6W7pUxXasNRL5VSuWKJPrvfWXXkJ1Cf60CtkfDClZ69xWj311K/kPT
	piJTHa6+w3JTJ67TzLTYB3hge8n3Flg/mY6ps6p3T2ogrkb96sa5jubuZQhyt5lA
	5hrFo85mPwmnA3Kdr+LpkLEkraDl8uUV1X9WRFH0D2Yh6QpsyUdFw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4em8yhu3jn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jun 2026 07:52:36 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6597njKs009486;
	Tue, 9 Jun 2026 07:52:35 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4emxvjryp2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jun 2026 07:52:35 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6597qWUo10813854
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Jun 2026 07:52:32 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EAA3320040;
	Tue,  9 Jun 2026 07:52:31 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BA0532004D;
	Tue,  9 Jun 2026 07:52:31 +0000 (GMT)
Received: from lenovo-pc.ehn-de.ibm.com (unknown [9.224.76.67])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  9 Jun 2026 07:52:31 +0000 (GMT)
From: Mete Durlu <meted@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Christian Loehle <christian.loehle@arm.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@kernel.org>
Cc: Mete Durlu <meted@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/5] s390/idle: Introduce cpuidle for s390
Date: Tue,  9 Jun 2026 09:52:12 +0200
Message-ID: <20260609075213.31094-5-meted@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260609075213.31094-1-meted@linux.ibm.com>
References: <20260609075213.31094-1-meted@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDA3MSBTYWx0ZWRfX6VKhaj6K+quo
 pDB6xbmUWs9A+nUheWUfXdrQAicbGwaWyolZvVC0ki1sT0NTvtNthGA2vIyhbT38bOB9K0yA6me
 BnY2Ai9ZSuv6DpN8SqYx9Bfe1jCqkT8NFZJbmYKr8SIOXd3b5aog8HUby2Tn0MJpwY79/8TcCZj
 smYzWw69g6Z7ZVPBCdPhnIfFpL2h2pxTQr1un2/ucDdms34pmSEiq6VI0fccpwH3AKBFfcNVyvJ
 7pjFKVLnraU9IKANdUBPX3hSTDrGZQmrB+8WJtA8ysaqFU63GoXnu8WNPt8ftqh3RYggHqpciIK
 DtAGwUlisKVVVxHJtjVmwtre9fvgczMKTL7Sm2lvUZKKdmKFDneLuDlB59lk78lsVkZmrF1KRUA
 ZJVsCfMwbTivjnm4QVu+B+feX/NoKBy2gwarn6nTOXIHZIiKvD5ywwT58lveNth+76PCAuzMAF7
 1zJV8QvX06ReQ0/KR+w==
X-Authority-Analysis: v=2.4 cv=HvFG3UTS c=1 sm=1 tr=0 ts=6a27c644 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=96sC0f_vMCLJJrx88uQA:9
X-Proofpoint-ORIG-GUID: mXAK0HMw4hjgDm7cv2y2nQhKabNdbMV6
X-Proofpoint-GUID: mXAK0HMw4hjgDm7cv2y2nQhKabNdbMV6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_01,2026-06-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 phishscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090071

Introduce generic cpuidle driver on s390. Use a two stage approach to
handle idle scenarios and use TEO governor for idle stage selection.
Two stages are, from shallow to deep, idle polling and enabled wait.

Suggested-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Suggested-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Mete Durlu <meted@linux.ibm.com>
---
 arch/s390/Kconfig              |   5 ++
 drivers/cpuidle/Kconfig        |   5 ++
 drivers/cpuidle/Kconfig.s390   |  12 ++++
 drivers/cpuidle/Makefile       |   4 ++
 drivers/cpuidle/cpuidle-s390.c | 104 +++++++++++++++++++++++++++++++++
 5 files changed, 130 insertions(+)
 create mode 100644 drivers/cpuidle/Kconfig.s390
 create mode 100644 drivers/cpuidle/cpuidle-s390.c

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
index 000000000000..e51704a9304c
--- /dev/null
+++ b/drivers/cpuidle/Kconfig.s390
@@ -0,0 +1,12 @@
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
+
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

