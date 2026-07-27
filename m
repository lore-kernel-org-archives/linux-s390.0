Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E083DD862;
	Mon, 27 Jul 2026 10:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785148602; cv=none; b=m4MDVL6G2P3R0UXV2vBjEfYylbGNl+WFxmiZ8CkDZ5wtVxTDxbGEWOks04TP+zzDTNNqBibHAzjQfOyxQ2dE2lysr1XUK/FGZQLiYiwVUkS7/+D+5eEDLkF5cQ5o2Y767g6T1Tlc8ajUPlOPyMv5WFmYGhIU/81U/9WoKwidg5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785148602; c=relaxed/simple;
	bh=Zq1hYXP5tnnias5y7gLi8f1LzvpWihipBuhYGo2iAeA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TraMHyrewVVfNWAM5rPkWDkVjh3/oTQIS1FMxHv1/OgiJrlMJc3Zp4XtH2jlNEh0EOPQS+K9yotJHNUA41eNzTiVjFl9iFI2zFKiKd8dwKp6ygPD7DlDNQg8+aAsF52EL33/PuBh/BtvrddvxOvx81xBnrr+NGtfbCB4Dl/w9bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VY291v4W; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VY291v4W"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RAIRFA1921895;
	Mon, 27 Jul 2026 10:36:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ETakwJ
	HwJsaqgXWgdw5grTgG0a5i7y7H+ovctiAEjmM=; b=VY291v4WaRPh7ovZxKTlkt
	Bsf+zbbt8bbAad0FbXUGSGDqIZCiU4jYpDufF8VLOPUXMtDxGbKOpDiXjHTuDMXJ
	JU2A8zAe31gJZ83zmRrxjhOe7T/Y36uBRqmzRwBaa20nq7MV10ICkqIwh0XFJiUR
	86QLMWabi2JRXo3/CDbUDx8EAKSINoQuMiV1Ev3OQvdTjkwlmAyup6ZDa1fNgQtA
	4fZGFtcG/g5+Q19COIch9FRTxt9F7pNRk9YHRe452+UYvQ8tl327PxuDEgYgYgo9
	MSFc5HJSqt7rfG5f0Ak9U0mpMPzvaOF6eUYvBPAWVuyqUtN2n+uhJdKWnMkJ2QRA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuw77h30-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 10:36:31 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66RAQeia014383;
	Mon, 27 Jul 2026 10:36:30 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn7uvw3qh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 10:36:30 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66RAaQPx32440732
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jul 2026 10:36:26 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 466302004D;
	Mon, 27 Jul 2026 10:36:26 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DCA7D2005A;
	Mon, 27 Jul 2026 10:36:25 +0000 (GMT)
Received: from [192.168.2.127] (unknown [9.111.31.34])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Jul 2026 10:36:25 +0000 (GMT)
From: Mete Durlu <meted@linux.ibm.com>
Date: Mon, 27 Jul 2026 12:36:22 +0200
Subject: [PATCH v2 3/3] sparc: Implement arch_do_panic
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-arch_do_panic-v2-3-4e25ceb05075@linux.ibm.com>
References: <20260727-arch_do_panic-v2-0-4e25ceb05075@linux.ibm.com>
In-Reply-To: <20260727-arch_do_panic-v2-0-4e25ceb05075@linux.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, Mete Durlu <meted@linux.ibm.com>
X-Mailer: b4 0.14.3
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: tcta5TGCiiUUhxQPmkZ6f3Q7O22wTtX7
X-Proofpoint-ORIG-GUID: tcta5TGCiiUUhxQPmkZ6f3Q7O22wTtX7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDEwMCBTYWx0ZWRfX3Lb2OGaUl9LX
 m6WYcCLG4IqLLdobHsTw4ypFcmmwLVjO0T03RB+3awsS2PiHeJLuAA/t2DdXkBEyNTHRsMe9aJX
 MNlJ2qF/A+8dPz4QTpoMY5GMkSA0OAT18XYWmMZWRkxnI+bDMpyuwZ3k+vcEdSmMvAOXUSKz7bf
 7tFQ78Wz96Zq2G7SlcDetBJ0LrCIwKexEXUvxqLfP260J/cko0AZadawE2UvuX7apkn4YxJ12uJ
 KgEd/DWmECUaTW/PgdyiQsgWarTTL8OiCuC9hocG6/tp2YaEUnjk5NEcjg+wuLgFnPESt95RNov
 vj41y1zca6abgk4varVgwoM68vCf6ELOGVTQLVIULJjk5qyzBtWNyajQO4UPiwlvRs1X/JDrv5Y
 7nGpssbPSOwMAQc6lqwW9IkAixuU5F8rml0YZbERBWfHuwm7ZA7rD1wRMWSyfW9udZF4GYZbc/d
 yENUUQ/a4rkfeEOnC9Q==
X-Authority-Analysis: v=2.4 cv=SKFykuvH c=1 sm=1 tr=0 ts=6a6734af cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=BaPjQbttxjZmbL8ypSEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDEwMCBTYWx0ZWRfX7cVEuuZr36aA
 cKBo6moryP0wTCsjLDpXzTfN4qRqFsY1kz1Wp7Ez2ISaH9BgdWNnvIajD9m2PaM1vnpGo5n6oQq
 pv7wKJJfMbjFMUhk+b1F5ni9GlR34aY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_03,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607270100

Implement sparc specific arch_do_panic() instead of using sparc specific
ifdef sections in vpanic() code.

Signed-off-by: Mete Durlu <meted@linux.ibm.com>
---
 arch/sparc/include/asm/bug.h   | 3 +++
 arch/sparc/include/asm/setup.h | 1 -
 arch/sparc/kernel/setup.c      | 8 ++++++++
 kernel/panic.c                 | 9 ---------
 4 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/arch/sparc/include/asm/bug.h b/arch/sparc/include/asm/bug.h
index ea53e418f6c0..70dc3358430c 100644
--- a/arch/sparc/include/asm/bug.h
+++ b/arch/sparc/include/asm/bug.h
@@ -27,4 +27,7 @@ void do_BUG(const char *file, int line);
 struct pt_regs;
 void __noreturn die_if_kernel(char *str, struct pt_regs *regs);
 
+void arch_do_panic(void);
+#define arch_do_panic arch_do_panic
+
 #endif
diff --git a/arch/sparc/include/asm/setup.h b/arch/sparc/include/asm/setup.h
index 21bed5514028..fed37c85ed00 100644
--- a/arch/sparc/include/asm/setup.h
+++ b/arch/sparc/include/asm/setup.h
@@ -43,7 +43,6 @@ void __init device_scan(void);
 
 /* unaligned_32.c */
 unsigned long safe_compute_effective_address(struct pt_regs *, unsigned int);
-
 #endif
 
 #ifdef CONFIG_SPARC64
diff --git a/arch/sparc/kernel/setup.c b/arch/sparc/kernel/setup.c
index 4975867d9001..87d3569c520f 100644
--- a/arch/sparc/kernel/setup.c
+++ b/arch/sparc/kernel/setup.c
@@ -36,6 +36,14 @@ static const struct ctl_table sparc_sysctl_table[] = {
 #endif
 };
 
+void arch_do_panic(void)
+{
+	extern int stop_a_enabled;
+	/* Make sure the user can actually press Stop-A (L1-A) */
+	stop_a_enabled = 1;
+	pr_emerg("Press Stop-A (L1-A) from sun keyboard or send break\n"
+		 "twice on console to return to the boot prom\n");
+}
 
 static int __init init_sparc_sysctls(void)
 {
diff --git a/kernel/panic.c b/kernel/panic.c
index de0bda946cab..593aa2c24d93 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -747,15 +747,6 @@ void vpanic(const char *fmt, va_list args)
 			reboot_mode = panic_reboot_mode;
 		emergency_restart();
 	}
-#ifdef __sparc__
-	{
-		extern int stop_a_enabled;
-		/* Make sure the user can actually press Stop-A (L1-A) */
-		stop_a_enabled = 1;
-		pr_emerg("Press Stop-A (L1-A) from sun keyboard or send break\n"
-			 "twice on console to return to the boot prom\n");
-	}
-#endif
 	pr_emerg("---[ end Kernel panic - not syncing: %s ]---\n", buf);
 
 	arch_do_panic();

-- 
2.55.0

