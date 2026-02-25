Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3518227FB2A;
	Wed, 25 Feb 2026 14:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772031115; cv=none; b=PSlOBol45ZuNhPNiLZ+CXaoTVMveqiRbkiIBRrwyx5QXPuWFStB7t9lAsrsaXkFiUJlADiDVFTVJx/FYhlqB3Zt8j+leQBtuTFBAyTSQyAvWvLvZ/jW8wJ6ZK2sy6+ln+wOGmd2AM/nbXFK/8WGYhrlDULuGYaNoq0FNp+h3n2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772031115; c=relaxed/simple;
	bh=tTiGaGcKL2NBf7SO2NxCvdEUirKmBEAMFtTMiJ8zSgk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G7wtGls7tXODitoCmicZSvkae+20aoJQUEC9eAJKaq7hiK/NXfe8oXu9qNaPVawRIDQaZchdCMCFLTXPf5RVYA5PsFMaCLu0x6vOrhcsKL2/ATebPhgiuB1jzhubJ199kM9ZS8sXi18kliOQp9nMIJJL1TF/PxcMmYx3VVcvl4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DzjsEqb7; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DzjsEqb7"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61PALXgR2089891;
	Wed, 25 Feb 2026 14:51:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=YttGa9Ih1whCoEoXZ
	hHdpQ4ZwTewJU13BQhRcMulEp8=; b=DzjsEqb7o4IuJrj97B36qeq5xjsqa26u8
	MWmMf5vlwsD1V5ExPHsvwtUbp35vyTGZNhz8S14heX9agepXltbFNVfvxV/QWDa6
	Z3nOftBl07bQzesxeNbqi3YnMwckHyStayz3iLDKrd0sLv7ftKSnIVjVSNbHUcG4
	nH90gfXApV8vJYLok5OQ0/hJv3WDJeWB4DjFLyPc2xqy8PeK31XzsgAd/ppLwfC8
	8pZFTwdSTZq4PDa5qo0Gz/iQk99nRLfz2v+Zgwy/M0dmL1NeEffWjejwj3J2MMfw
	w6jzyr2qcROxycWHQVKCuTc7G8auTYZ++PWrjSFhS13RiIB3RkWmw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cf4cr0p2j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Feb 2026 14:51:51 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61PEB6Bo027797;
	Wed, 25 Feb 2026 14:51:50 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cfsr1wf4e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Feb 2026 14:51:50 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61PEplEp52429168
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Feb 2026 14:51:47 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E78602004B;
	Wed, 25 Feb 2026 14:51:46 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CB48220049;
	Wed, 25 Feb 2026 14:51:46 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 25 Feb 2026 14:51:46 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Frederic Weisbecker <frederic@kernel.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [RFC PATCH 3/3] s390/idle: Remove idle time and count sysfs files
Date: Wed, 25 Feb 2026 15:51:46 +0100
Message-ID: <20260225145146.1031705-4-hca@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260225145146.1031705-1-hca@linux.ibm.com>
References: <20260225145146.1031705-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: uEjnrjeAnGecBSGZOQTw1P2IACkkq5mB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI1MDE0MCBTYWx0ZWRfX6B1Sb2o/6se8
 lPXgdUAnGWCjbbFWvE9AO32ZR5+ySiXlddzjd5bnN3WlOlNzAY3Dbe6Y3y24H3aTWaH1X0Ze2qn
 55e4Fb+NK3qayq7DU9MN8glwvs/yMRh24t8xNg9lZjbFhkV+v9cLY3ebrzFl3mSKejv0MBY1ybh
 YEtLqbmJ1MmSqGoG46FDhwt/+PUpm7Rt2x5s72W/E8ZZHtkd60luPF3usvXPQ4u6C0nCjGHi3WS
 KeiBqrMjowNnqPipBz6WfpjGEnU0diaS9w9NREkR0y1SO2DRnahVZouZo5ItWu7oEftu+NJTrhd
 QJbZEEGW/EFLUr0/pZ7xU1vKJitUJriGSKukhB2u0ViTvnupXxO6VpH7ajDGDEuzpyqZoR0hjoS
 zKVn9aXuvAcQb/MbRKAB7LAg+oTf18MPsE3sk5LX5wh1HlrUQb/GO3V/vhm/o+6D0CB9g2Byhi8
 2A/nhpvnoJyIzCLNqgA==
X-Proofpoint-GUID: uEjnrjeAnGecBSGZOQTw1P2IACkkq5mB
X-Authority-Analysis: v=2.4 cv=bbBmkePB c=1 sm=1 tr=0 ts=699f0c87 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8 a=c6aYbUc6zOLT7oC9ZwYA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_01,2026-02-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602250140

Remove the s390 specific idle_time_us and idle_count per-cpu sysfs
files. They do not provide an additional value. The risk that there are
existing applications which rely on these architecture specific files
should be very low.

However if it turns out such applications exist, this can be easily
reverted.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/include/asm/idle.h |  4 ----
 arch/s390/kernel/idle.c      | 20 +-------------------
 arch/s390/kernel/smp.c       | 32 +-------------------------------
 3 files changed, 2 insertions(+), 54 deletions(-)

diff --git a/arch/s390/include/asm/idle.h b/arch/s390/include/asm/idle.h
index dc04d63b6187..f0f3d38ef648 100644
--- a/arch/s390/include/asm/idle.h
+++ b/arch/s390/include/asm/idle.h
@@ -10,7 +10,6 @@
 
 #include <linux/percpu-defs.h>
 #include <linux/types.h>
-#include <linux/device.h>
 #include <asm/tod_types.h>
 
 struct s390_idle_data {
@@ -26,9 +25,6 @@ struct s390_idle_data {
 
 DECLARE_PER_CPU(struct s390_idle_data, s390_idle);
 
-extern struct device_attribute dev_attr_idle_count;
-extern struct device_attribute dev_attr_idle_time_us;
-
 void psw_idle(struct s390_idle_data *data, unsigned long psw_mask);
 
 #endif /* _S390_IDLE_H */
diff --git a/arch/s390/kernel/idle.c b/arch/s390/kernel/idle.c
index ceb95c0d22eb..db120ef810ac 100644
--- a/arch/s390/kernel/idle.c
+++ b/arch/s390/kernel/idle.c
@@ -81,7 +81,7 @@ static u64 arch_cpu_in_idle_time(int cpu)
 			idle_time = now.tod - idle->clock_idle_enter.tod;
 		smp_mb();
 	} while (__atomic_read(&idle->sequence) != seq);
-	return tod_to_ns(idle_time);
+	return cputime_to_nsecs(idle_time);
 }
 
 static u64 arch_cpu_idle_time(int cpu, enum cpu_usage_stat idx, bool compute_delta)
@@ -133,24 +133,6 @@ void noinstr arch_cpu_idle(void)
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
index 439eab2fb67a..64f0a5617e86 100644
--- a/arch/s390/kernel/smp.c
+++ b/arch/s390/kernel/smp.c
@@ -1086,31 +1086,6 @@ static struct attribute_group cpu_common_attr_group = {
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
@@ -1176,18 +1151,13 @@ static DEVICE_ATTR_WO(rescan);
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

