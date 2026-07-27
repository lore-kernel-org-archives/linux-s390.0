Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39403E95B2;
	Mon, 27 Jul 2026 09:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785142854; cv=none; b=JW4u4FSrawf12fD2xBmgJhMvr08Vx4lmn9A29cGCGLWDd5pgppnyFj7Gzz7H7mhBGtZBjkddVQF8UpCHikPApaxT6el7/h9l0dP/Y7js5wVVe3nR3LrQ9PhHtVwmQaUiK6J1MtNZCIx9XJfo0Hl90HuYbTesGVoCceIubIN+fR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785142854; c=relaxed/simple;
	bh=Obl85o2aLIPRik7Pz95g6pr4AfIzCOB7kG6mGSuT4MI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=slAXwUuwHEwKjh29saeCVWgAdY1EzUSk/+c0yBEvxDU97R19tA3eOx55Fni7fdRo/5++uCAkmDRFHvGExrGAC81z4yn2VE9esqMzdr9FSIaB4JVV0DpZhFchY9Qe+B8TrVs7hcSWeoZsAxA6eBfTk/kAgK02yVFOGq2LtxKCOz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nKlHWATj; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nKlHWATj"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66R7lgGU1513486;
	Mon, 27 Jul 2026 09:00:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=UwZgNr
	+CBTbjkAWTgQoeV1tUQCIg0uqA8PbU0gHAOvE=; b=nKlHWATjMDkyIG78MM9OCb
	0JrkaYa/jntxEdOjc5NLa+RKOcnqPxrVne4tF+t1bk/UyKvby51h41dKWnT9KIZZ
	/6AopnNfdLmJfKmuyjQCRn4W0aBBn+1+rfy7IWfp4vnjcQAs3Lzyt2txDd289Azs
	bvVDR/96PQjknHeevWN8Ht2VdzOP12dBb93WeQF9k6LRAmDOmw+9vyQxJ6pZh9i6
	dRLIzcgVGaX8Q2YAKuaTE7gKyOifltTZFJv47OuCqA1ADmBs/17ohqHhQ+vs/k06
	0AU9rA93goYz7oLclb9PJCeHyZ51Pgnt87F9xX8hJ5sZ4pRgpmqvtKFQjcZ05i2g
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0ner7t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 09:00:46 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66R8uEVm025968;
	Mon, 27 Jul 2026 09:00:46 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8fjvn4m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 09:00:46 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66R90fSD31064798
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jul 2026 09:00:41 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EF8FF200E9;
	Mon, 27 Jul 2026 09:00:40 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 87B67200E6;
	Mon, 27 Jul 2026 09:00:40 +0000 (GMT)
Received: from [192.168.2.127] (unknown [9.111.31.34])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Jul 2026 09:00:40 +0000 (GMT)
From: Mete Durlu <meted@linux.ibm.com>
Date: Mon, 27 Jul 2026 10:58:50 +0200
Subject: [PATCH 3/3] sparc: Implement arch_do_panic
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-arch_do_panic-v1-3-ca1777547c38@linux.ibm.com>
References: <20260727-arch_do_panic-v1-0-ca1777547c38@linux.ibm.com>
In-Reply-To: <20260727-arch_do_panic-v1-0-ca1777547c38@linux.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Michael Holzheu <holzheu@de.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, Mete Durlu <meted@linux.ibm.com>
X-Mailer: b4 0.14.3
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDA4NiBTYWx0ZWRfX3lhMc3tvuMYa
 SFmudhl0Pk9aNTalrgkhu5Hk70FUb94IuzAIAZWR0hj/atz9R8VHp4SQ/hhEm6zgE9RC1ByPFXx
 7cUOVMl/VfRz7AYVxETnpIeUMas7J/g=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDA4NiBTYWx0ZWRfXwELmMP5W9w1P
 qYBb4J2UmBq7H/szT9f6LaESulGa1SJfslZxeyVTg1YJSe28g1fT8GuBi8MjJqhjckTtgpRKsGF
 QLGEjMspi5lzIr962qbz8iKZkgkm0mshR0OwKIvNDy6wIwyMa9zZgnJhE4Tuxh1CuJdHulPAPyT
 UU86JnxG5/fE27jFLZHvvjsxUn4x2cZRWSUbMb56ZUF85mZWc3zjCnGe9gXJCcZfHkzOt7f2yKF
 aN1UtzTK4jbccwc/3+mpkGrzfoxgOz0CiQvwIPRqz3merwX9et4rhvX0/nXz8Kzk4Dm1VEwFwqz
 ga0q5Ej2hf1Xx257e1KD+xAU/EeXgZ3qCnVDaRBoKXBtpBJW2WEojcghv4tqZElPbb59nBbav3j
 au73c0di0WEmUEDb+YyzSA/z8q90TBWsWjsuBUSu4X6JiaUB2kEKgssHvrzNw91obznE31uJ49Y
 XDahZyGPsFYKX74q2HA==
X-Authority-Analysis: v=2.4 cv=b5WCJNGx c=1 sm=1 tr=0 ts=6a671e3e cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=4bjyRBIvKejuELZ2iG4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Zq1VYekuKNZYY9SpkgDfVt1ncWgEtY-q
X-Proofpoint-ORIG-GUID: Zq1VYekuKNZYY9SpkgDfVt1ncWgEtY-q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_02,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1011 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270086

Implement sparc specific arch_do_panic() instead of using sparc specific
ifdef sections in vpanic() code.

Signed-off-by: Mete Durlu <meted@linux.ibm.com>
---
 arch/sparc/include/asm/setup.h | 4 +++-
 arch/sparc/kernel/setup.c      | 8 ++++++++
 kernel/panic.c                 | 9 ---------
 3 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/arch/sparc/include/asm/setup.h b/arch/sparc/include/asm/setup.h
index 21bed5514028..557e8277a640 100644
--- a/arch/sparc/include/asm/setup.h
+++ b/arch/sparc/include/asm/setup.h
@@ -43,7 +43,6 @@ void __init device_scan(void);
 
 /* unaligned_32.c */
 unsigned long safe_compute_effective_address(struct pt_regs *, unsigned int);
-
 #endif
 
 #ifdef CONFIG_SPARC64
@@ -67,4 +66,7 @@ void sun_do_break(void);
 extern int stop_a_enabled;
 extern int scons_pwroff;
 
+void arch_do_panic(void);
+#define arch_do_panic arch_do_panic
+
 #endif /* _SPARC_SETUP_H */
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

