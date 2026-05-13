Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBF92D3725;
	Wed, 13 May 2026 14:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778680909; cv=none; b=mZVX6bH/i7wBOg9qGWHJYx5yy+aMVnFIUTKX/ItE1Jgjq1NF/gG9OamFLiFcOrSuUDOBDOIKyqUpH7d8LYloEzQ/PobDZXiMKXSfv7TcEq2s4D1rspRgA290+QqnG63RSMHpXirFl9jcok7UIfXVnGFKcrdVf9RuU6WmuKFI/cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778680909; c=relaxed/simple;
	bh=7nFBbQFIqpYNykh33mUCiklvJVeePsb34oeZfq8IMZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ax6O9UuosrIZDIFd8YVbbj0sZgziiz2EQf1WrKg8Q3Fz90XUK1ebU+7oTb6PembjScSQeDmKET0WLx9qAMUoAJM4HfvKSbJ1bdy9qL1fCGCxrwcGAobWjWsif31fuUzvKPIMvD+cH3y4B5TasEJePw0XPHj8DKq0kS+A4EjDcqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QHIuyipa; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QHIuyipa"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64D4G0773187043;
	Wed, 13 May 2026 14:01:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=9lyTIEqAyJ9u/VSnx
	2mvB+lCS+Z877gkZr0cmMVlkr4=; b=QHIuyipaLGZ9ubiMLPPgV9wOBTRoqhrGX
	gzUIK8tIKy2rM0w5UNueOmPZ92lzC/lYjxO14Ysy9xiAKjtuWcBTi4sTQ3jJj27n
	8SvcWPg3lU2pA+VRwPBhBsnV8hw5hRh3OzGUeyy7yhNjo8sEdhOB7g2Ydqpnf9iq
	15magnBMGfFI/OA9VOGKTcjzRhXHheFjtFWAM/GHtyB5868oRwPDYrHd1c5QUHS+
	d8kebsnQmIu+r+/IWqV0lzOFHmnj0GmC3vHpoP3x2FMGmMHl1BP3RWa9KHr5Kx4c
	EbLD4aZREKMVoGKGL4efMHAyJezSZW4/IM6QqfHPAa3I+146PImZg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e3nv5g29t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 May 2026 14:01:35 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64DDsSob013000;
	Wed, 13 May 2026 14:01:34 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e3nfgg1pg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 May 2026 14:01:34 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64DE1VLI44892448
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 May 2026 14:01:31 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E34A620043;
	Wed, 13 May 2026 14:01:30 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BAE802004B;
	Wed, 13 May 2026 14:01:30 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 13 May 2026 14:01:30 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@kernel.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 4/4] s390/idle: Remove idle time and count sysfs files
Date: Wed, 13 May 2026 16:01:29 +0200
Message-ID: <20260513140129.4100822-5-hca@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260513140129.4100822-1-hca@linux.ibm.com>
References: <20260513140129.4100822-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=cPHQdFeN c=1 sm=1 tr=0 ts=6a04843f cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=48jhfdEArON3SpgkVDQA:9
X-Proofpoint-ORIG-GUID: -kYD_aIQ6cZ9RZgAKl1B-zdVbERVJW3a
X-Proofpoint-GUID: -kYD_aIQ6cZ9RZgAKl1B-zdVbERVJW3a
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDE0MCBTYWx0ZWRfX0GA1eVG1+dDN
 MXeML3FTjpo9xkGRj0D2mW5R+th8YtXn8e3/yzsYiXSgFOFGf1PBI0RE2cgUoSni9KMrLoq3ctW
 +88s2CLiKrzOiJwu+/6OVusTH1v2cUkaUoqoMoU5sHLf8MIU/IzHfqSiGqg2bbm0yP9X5IFFRgu
 cyzRDE5X+WKRgpElgl6VpHTWvnCLi4esejdeWA13V4KysxayuatmIZAuIeY4pk1kX7QctlUBC5h
 KmWzXm8puM6Nksl9NsT95tdziAZxqTAh86YL8+yY/SXQzOzQghaKsrjOULcZzQ0feKO+/A1g/24
 AboSYIJvZvaeaLfDSDdxGCal1ddtQ28hTCVm750RYTu/hRvEU+EnCd7dXjJQYPqvDTrX0H9LQXm
 jnBgw4mX9Xw6PYE7D9EqcqNV8Tx+FeIkU9TqbhbFDhoF2UszZ1HhsHF5+lIvh20SVeL+CdqTMCr
 u5yWw7eNwG/SC0lODkw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_01,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 phishscore=0 clxscore=1015 spamscore=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605130140

Remove the s390 specific idle_time_us and idle_count per cpu sysfs
files. They do not provide any additional value. The risk that there
are existing applications which rely on these architecture specific
files should be very low.

However if it turns out such applications exist, this can be easily
reverted.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/include/asm/idle.h |  6 ------
 arch/s390/kernel/idle.c      | 20 --------------------
 arch/s390/kernel/smp.c       | 33 +--------------------------------
 3 files changed, 1 insertion(+), 58 deletions(-)

diff --git a/arch/s390/include/asm/idle.h b/arch/s390/include/asm/idle.h
index f3502d5621c0..07819f11987c 100644
--- a/arch/s390/include/asm/idle.h
+++ b/arch/s390/include/asm/idle.h
@@ -10,15 +10,12 @@
 
 #include <linux/percpu-defs.h>
 #include <linux/types.h>
-#include <linux/device.h>
 #include <asm/tod_types.h>
 
 struct s390_idle_data {
 #ifdef CONFIG_NO_HZ_COMMON
 	bool	      in_idle;
 #endif
-	unsigned long idle_count;
-	unsigned long idle_time;
 	unsigned long timer_idle_enter;
 	unsigned long mt_cycles_enter[8];
 	union tod_clock clock_idle_enter;
@@ -27,7 +24,4 @@ struct s390_idle_data {
 
 DECLARE_PER_CPU(struct s390_idle_data, s390_idle);
 
-extern struct device_attribute dev_attr_idle_count;
-extern struct device_attribute dev_attr_idle_time_us;
-
 #endif /* _S390_IDLE_H */
diff --git a/arch/s390/kernel/idle.c b/arch/s390/kernel/idle.c
index b5fae512fc9c..7f7851c001e0 100644
--- a/arch/s390/kernel/idle.c
+++ b/arch/s390/kernel/idle.c
@@ -28,8 +28,6 @@ static __always_inline void __account_idle_time_irq(void)
 	unsigned long idle_time;
 
 	idle_time = idle->clock_idle_exit.tod - idle->clock_idle_enter.tod;
-	__atomic64_add(idle_time, &idle->idle_time);
-	__atomic64_add_const(1, &idle->idle_count);
 	account_idle_time(cputime_to_nsecs(idle_time));
 }
 
@@ -144,24 +142,6 @@ void noinstr arch_cpu_idle(void)
 	__load_psw_mask(psw_mask);
 }
 
-static ssize_t show_idle_count(struct device *dev,
-			       struct device_attribute *attr, char *buf)
-{
-	struct s390_idle_data *idle = &per_cpu(s390_idle, dev->id);
-
-	return sysfs_emit(buf, "%lu\n", READ_ONCE(idle->idle_count));
-}
-DEVICE_ATTR(idle_count, 0444, show_idle_count, NULL);
-
-static ssize_t show_idle_time(struct device *dev,
-			      struct device_attribute *attr, char *buf)
-{
-	struct s390_idle_data *idle = &per_cpu(s390_idle, dev->id);
-
-	return sysfs_emit(buf, "%lu\n", READ_ONCE(idle->idle_time) >> 12);
-}
-DEVICE_ATTR(idle_time_us, 0444, show_idle_time, NULL);
-
 void arch_cpu_idle_enter(void)
 {
 }
diff --git a/arch/s390/kernel/smp.c b/arch/s390/kernel/smp.c
index 50bb499cf3e5..0ba7f89b8161 100644
--- a/arch/s390/kernel/smp.c
+++ b/arch/s390/kernel/smp.c
@@ -54,7 +54,6 @@
 #include <asm/debug.h>
 #include <asm/os_info.h>
 #include <asm/sigp.h>
-#include <asm/idle.h>
 #include <asm/nmi.h>
 #include <asm/stacktrace.h>
 #include <asm/topology.h>
@@ -1085,31 +1084,6 @@ static struct attribute_group cpu_common_attr_group = {
 	.attrs = cpu_common_attrs,
 };
 
-static struct attribute *cpu_online_attrs[] = {
-	&dev_attr_idle_count.attr,
-	&dev_attr_idle_time_us.attr,
-	NULL,
-};
-
-static struct attribute_group cpu_online_attr_group = {
-	.attrs = cpu_online_attrs,
-};
-
-static int smp_cpu_online(unsigned int cpu)
-{
-	struct cpu *c = per_cpu_ptr(&cpu_devices, cpu);
-
-	return sysfs_create_group(&c->dev.kobj, &cpu_online_attr_group);
-}
-
-static int smp_cpu_pre_down(unsigned int cpu)
-{
-	struct cpu *c = per_cpu_ptr(&cpu_devices, cpu);
-
-	sysfs_remove_group(&c->dev.kobj, &cpu_online_attr_group);
-	return 0;
-}
-
 bool arch_cpu_is_hotpluggable(int cpu)
 {
 	return !!cpu;
@@ -1175,18 +1149,13 @@ static DEVICE_ATTR_WO(rescan);
 static int __init s390_smp_init(void)
 {
 	struct device *dev_root;
-	int rc;
+	int rc = 0;
 
 	dev_root = bus_get_dev_root(&cpu_subsys);
 	if (dev_root) {
 		rc = device_create_file(dev_root, &dev_attr_rescan);
 		put_device(dev_root);
-		if (rc)
-			return rc;
 	}
-	rc = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "s390/smp:online",
-			       smp_cpu_online, smp_cpu_pre_down);
-	rc = rc <= 0 ? rc : 0;
 	return rc;
 }
 subsys_initcall(s390_smp_init);
-- 
2.51.0

