Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6EA73F822B;
	Thu, 30 Jul 2026 09:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785403444; cv=none; b=VouSzZzBWGGuddSPmCrQ/IJ5EkcGGCh+GG40XUQOTd4jNnNLk5JvIwTSnXq8Sxd2lHpzV5vNXycAkINsrCiTUd2S/OnsKYeE41WpziEwOt/thg83fcSNxZyEjue2htzP+HsN7outv7UW2KDM6KdJiVp63GgvUVan9zKvPaUR9Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785403444; c=relaxed/simple;
	bh=wDZwNXGl5Zrg4BSL2HoA4nvLsEc3Y709IiE7UMAriJg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UBd8iyZAu7NJEN99Nf3+/z65ESg1VmQYOJSL7qcvU7lCSQuJI4t82RP6s1fk6bcLcy/oBze4DKhXUvQ9CvUAu/VX60saw55cJZPup7MuDof+6x3izXNVmjTSDwVp8coEQzoilChLaxx8+/GF7dYTZ6Ff+lF9cKMuSRsmPpmjBfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fSV+ywxV; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fSV+ywxV"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66U6lbPx2300340;
	Thu, 30 Jul 2026 09:23:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=aLRJ8L
	uc/DNUk7Pr7QXztqsYGIImL7TTPDDZBObdVJs=; b=fSV+ywxVbVdOK1+k3u5ONX
	5f3w9rQJ+Xi7FVoo8E6WxWc6ZFSHq6uermsGgiK7sq1Qrscdz4QSkeYHnf6Al76z
	7D/XOO8z/JAmrthhYgfbSZp5JSTZ3aUYIRfMLSFOplpBmIxIx9ZEbmD1MgxZqRJ1
	uSSorEfGWunTLB/DRgqEg+GHt8Ebw4xKapduAVMrncTfPEgvCEMk4dtQfvF0ne6E
	marpIkLlOMbAd0/N53N3lcnngwJYCDgZKIWBvPFgJLWWR3KLHNh8VCwMtoYyKhFK
	mXudMiPb6msqyhtIV1gCiwDUSCrhvi/RyX2j9dMH+0y+6xj/2ItEciXXsVORBpRA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0xy12p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 09:23:43 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66U9BJa4009682;
	Thu, 30 Jul 2026 09:23:42 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fna5yad28-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 09:23:42 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66U9NcZ035586368
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jul 2026 09:23:38 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 486F720040;
	Thu, 30 Jul 2026 09:23:38 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1846120043;
	Thu, 30 Jul 2026 09:23:38 +0000 (GMT)
Received: from [127.0.1.1] (unknown [9.87.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 Jul 2026 09:23:38 +0000 (GMT)
From: Mete Durlu <meted@linux.ibm.com>
Date: Thu, 30 Jul 2026 11:23:29 +0200
Subject: [PATCH v3 3/3] sparc: Implement arch_do_panic
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260730-arch_do_panic-v3-3-d5401e683cdb@linux.ibm.com>
References: <20260730-arch_do_panic-v3-0-d5401e683cdb@linux.ibm.com>
In-Reply-To: <20260730-arch_do_panic-v3-0-d5401e683cdb@linux.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>,
        Bradley Morgan <include@grrlz.net>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, Mete Durlu <meted@linux.ibm.com>
X-Mailer: b4 0.14.3
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: L9wk4nsQY3YXEtK366fkpHlIX7ZwzV0y
X-Proofpoint-ORIG-GUID: L9wk4nsQY3YXEtK366fkpHlIX7ZwzV0y
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDA2OCBTYWx0ZWRfXzYuMcmUcAGcO
 bz8uAPbWBnu7039sstuxHceX0AY+Gyr8jK7emLeQcZaLzkNFnl5d72N6Nv/mZJdXoF9nMZAEKHt
 qLCW94X1Pj6boqX21iGRNBsyCP1T4YM=
X-Authority-Analysis: v=2.4 cv=dYuwG3Xe c=1 sm=1 tr=0 ts=6a6b181f cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=Iwkn-W_Q9BMZrAFg0pEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDA2OCBTYWx0ZWRfX9vONVvgMVsFg
 yGbHaoDHgfB5PLbdal58zIH/1EI35d5NVMq+MqLlQdMnI7MxVNd2sS6NND6eQna2W2FyNyf/80F
 5Wgyfw96mrFtpw0+BBX30BeGOUUcZ2xHxXrljsHC0+sCEy9fTZQqlJPnx0aolbQKDCyFdGvPEXt
 XZ1Ql32hetxNByjtPEyOFuTPuDY28aqtolLq6vHJ1nPRzIFn8KPkm9z35dehq7ZUry0aPm5Pp/I
 U0Y2mf0yV5nI+J+doqyC0D3V2FU0VkiMh1cl8heRV7UBC97D8mqKlAYG/8IbDxZ0z3udP46w4bj
 Ku4xiyNvkyPey7iSSojyLl6aOkWblXK4ozkIA43b3hb/7YtJ4d5ZTgiD6GvRT1wQHAUNPhhzhJQ
 p/Rb/HVBKMqGRMT73seTlSRw9JHGS+JY+kMg5LdfcyVhCLXmgsUqAWahfJavg5NJpcYJFWgqJpD
 85tSCjqAD2mphzXjN1g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_02,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 phishscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300068

Implement sparc specific arch_do_panic() instead of using sparc specific
ifdef sections in vpanic() code.
Reorder arch specific panic handling, sparc's Stop-A messages are now
printed after "end Kernel panic" marker.

Signed-off-by: Mete Durlu <meted@linux.ibm.com>
---
 arch/sparc/kernel/setup.c | 8 ++++++++
 kernel/panic.c            | 9 ---------
 2 files changed, 8 insertions(+), 9 deletions(-)

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
index ee6e3f9e3900..7dda841c16f9 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -744,15 +744,6 @@ void vpanic(const char *fmt, va_list args)
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
2.53.0

