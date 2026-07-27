Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF053E5A2C;
	Mon, 27 Jul 2026 09:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785142853; cv=none; b=Xgryjrsj/0Be5sudaO+I4JZ6wECXrtbBGXb4ftoKH+CoS8YSqc5b9Ri/ZXX20nVdjJ7gIvcb4H5PpStbZkILfZaWIdVq7YwWdbzalS9vLLe5GU9XdBYz6sw03OUtF7NSltTCKOxANpDsyM4IdqTcTAKsgfnEF3xw9+mMRVc1j8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785142853; c=relaxed/simple;
	bh=Nr9pqwCaBaqgBE4vf7n0/MiVoxGGnyKbS7S3Zqf20tE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MGNB+WOI1QdB06AHcbyJ5QOQ0Mmmt6XlmzYa5BP0PNH16BjSRFe+uiDT64BfxUgxNfPBBbwUr36kfLDDSy7eoaW2AtqJ7I9TCgVRGiSV0oMa8u540aSLs7+E2jEK+n/qoRshwubdo1eRrisChNURpEof51sbl0BUv7nNV/QWbZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=exnXtxmS; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="exnXtxmS"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66R7m91I1514679;
	Mon, 27 Jul 2026 09:00:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=p/UBmX
	PsshYILClnY/0b+PS55rq+L2jxS0XsUIEbf08=; b=exnXtxmSRphXfPFKpYQYVz
	DhUGbLuk8ORvujlMkZx0uG/kK7R3MG/7aYNCE2kpn52AN6NFayUcFYVC72/jz0Gn
	6RLX22dxaiE6jzycU5Fa9dUlO/UnwkWmFn15rcbDthfPGX8oqlz2hRXZYA3CG7Iq
	ymRedgXo5wm9D5FOzrNOEgR0j9DK980gm0hEAPtZuUJK8nAz2DfjFMPQR4Xit0Na
	/tqFO+Qyzw7dj3MjWBMgTIQc+CZV2PR1dqnw3CNnUVWns/jJ180xPF8xsvZMJZM0
	SpYoql5c+bkTXi/LPZ9bn7GdOqfpU206n6Hqo1POblmmI7L0DjEsCao2xGS1FGWQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0ner7n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 09:00:45 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66R8uDXC006509;
	Mon, 27 Jul 2026 09:00:44 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fna5xvcds-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 09:00:44 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66R90eRD42008888
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jul 2026 09:00:40 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F170A200E9;
	Mon, 27 Jul 2026 09:00:39 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 94FEF200E1;
	Mon, 27 Jul 2026 09:00:39 +0000 (GMT)
Received: from [192.168.2.127] (unknown [9.111.31.34])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Jul 2026 09:00:39 +0000 (GMT)
From: Mete Durlu <meted@linux.ibm.com>
Date: Mon, 27 Jul 2026 10:58:48 +0200
Subject: [PATCH 1/3] panic: Introduce arch_do_panic
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-arch_do_panic-v1-1-ca1777547c38@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDA4NiBTYWx0ZWRfX49ZsMOpObhOy
 hBgog5uwTOfT9mAAXU2muhoZ7HyzUCyB32GxmYycHKL64I2VAdQImM3Yi8BW4y/Db1tJM36OLQ9
 HwkUdJT/CWMOWgxbUf+NM7cZ5KUwnS8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDA4NiBTYWx0ZWRfX1lWc1XDpZsLJ
 8/jzyjwKjdhIDQaJlCvd5iIyTpssy/SUso+xCQL64VPppgJPVjqvdJc599S1PQOQbcP0go9Squt
 fla/ZZu2X2tmG+Zxk+EC2nBfZ23A8i8wyKfFeGLfVLNHG+nkmx/woEDhcnNL2FZjrekOUYAYwYW
 jzzNVOEd99AxqW1bZXxes9d/OHgreZRbWKcWnyOSIKwGPK3+XWzk4jQXG8OTCA77h1sfp/rJjQN
 6uOQRFDOoTBjppC+Xho94OG0eELO0txlHwKJFj9MiYuh+9e5eE+RLTtUKN3LofkXEeVIXF1htbe
 lrzdGA2HRxfZZ0wjJYWDjPZmexsJHg5zq8oe5p8fDJpgvRsOHooGhhxohibT5OLkCjccdXYk4SI
 QeQux40165s++1dLDtEhwlTfXxgCn+WQYFYx75Vn69gMP+T+6dDD8ZuDjT6N2ra7jt+6Jh2xfqZ
 U0BOmQQSjc4DMRP+YIQ==
X-Authority-Analysis: v=2.4 cv=b5WCJNGx c=1 sm=1 tr=0 ts=6a671e3d cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=vDqFKWyYXM9dIk6-_9sA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: mW4wXc1r60OfzakZobkA-DiwPNaZpfbP
X-Proofpoint-ORIG-GUID: mW4wXc1r60OfzakZobkA-DiwPNaZpfbP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_02,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1011 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270086

Introduce a hook for architectures to put their specific panic handlers.
s390 and sparc already has ifdef preprocessor checks to execute
architecture specific code. Pave the way for vpanic() cleanup.

Suggested-by: Sven Schnelle <svens@linux.ibm.com>
Signed-off-by: Mete Durlu <meted@linux.ibm.com>
---
 kernel/panic.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/panic.c b/kernel/panic.c
index 213725b612aa..1eb0cdc159d9 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -567,6 +567,11 @@ static void panic_other_cpus_shutdown(bool crash_kexec)
 		crash_smp_send_stop();
 }
 
+#ifndef arch_do_panic
+#define arch_do_panic arch_do_panic
+static inline void arch_do_panic(void) {}
+#endif
+
 /**
  * vpanic - halt the system
  * @fmt: The text string to print
@@ -756,6 +761,7 @@ void vpanic(const char *fmt, va_list args)
 #endif
 	pr_emerg("---[ end Kernel panic - not syncing: %s ]---\n", buf);
 
+	arch_do_panic();
 	/* Do not scroll important messages printed above */
 	suppress_printk = 1;
 

-- 
2.55.0

