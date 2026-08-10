Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CA73A59A3;
	Mon, 10 Aug 2026 11:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786361863; cv=none; b=TitBxQGfEeEKi9sSB+zKnuUwqgfCHEB2esFwf0hG98Hf1td5/9JEbfnf1Qo4EAzrtKZXeaDN9HJO7WRzWGeAxx+ddAO6ylrRrhH6cVsW6XXa/olQsJNDsJ8QPt6xCh7NApb/NTDVVR8C7+UvuItluaBjXEStht7uhPpfPTNpivs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786361863; c=relaxed/simple;
	bh=PYF3iNeENBdSaiAGyN6wQYwEL8sItA6lmOBg8rYNCMk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hGQ47TMVN2CewX/TGEz51E4fcAKBAp6x2j11UOC3Oxxby7AErXH2cbFfyFUp+fe9oG2u1B9PBUyUbQa7Ve4u5xgZ1seD6cdVmlbWjler3AEYFkKx7o6n2xhhuyhZnM5VcCBHhdpZiGxpZ/TAl3JvNjXZ3ZPXa/2xAo2A4z+1+yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YM86ADVY; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YM86ADVY"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67A9Wi741291990;
	Mon, 10 Aug 2026 11:37:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=YgwZSW
	C2bLmMyDbaQo4SVNBWV5SCX4gDWVO4DIJgLiM=; b=YM86ADVYOoinEp595lpJf9
	ksnXcNJhIgKM/R/on2nOilmVucy9im2M94ZR4mnrna0Ixhv8wiDJ2Mh5o7tJYrnI
	E9H2RixFyJLeNnFFD6AAGFLrpezm5rvstVoNNIEtzIfM9HArNte6qECOV34ZgRVE
	06Jd+SdvOTqKhfb0dvLc7nb91YLeZkRU5F9PAG6fivxYV/FimtGBNjEbdVYXm01T
	nXtbCiaIv67v9p0IjLJ7WJDP5Vw3vrJZWSTcZMcArFMNrDo0bNMkjPv/WWyGnsKr
	AjjzhkDJxNs1cALesQeXi86KYc3nUGiyI45Ezxh8C+KQIIem+Kx9vE2pKxSSt5Mw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvnvyauw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 11:37:28 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67ABQQFn003959;
	Mon, 10 Aug 2026 11:37:27 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxf5vvpcm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 11:37:27 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67ABbNA739453118
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Aug 2026 11:37:23 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6F0612004B;
	Mon, 10 Aug 2026 11:37:23 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0D83C2004D;
	Mon, 10 Aug 2026 11:37:23 +0000 (GMT)
Received: from [192.168.2.127] (unknown [9.111.54.108])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 10 Aug 2026 11:37:22 +0000 (GMT)
From: Mete Durlu <meted@linux.ibm.com>
Date: Mon, 10 Aug 2026 13:35:56 +0200
Subject: [PATCH v5 1/3] panic: Introduce arch_do_panic
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260810-arch_do_panic-v5-1-e86ae992c253@linux.ibm.com>
References: <20260810-arch_do_panic-v5-0-e86ae992c253@linux.ibm.com>
In-Reply-To: <20260810-arch_do_panic-v5-0-e86ae992c253@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=RsP16imK c=1 sm=1 tr=0 ts=6a79b7f8 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=jcFIXsoQAAAA:8
 a=VnNF1IyMAAAA:8 a=vDqFKWyYXM9dIk6-_9sA:9 a=QEXdDO2ut3YA:10
 a=M1-Q_cRM6PFdmZSamPpU:22
X-Proofpoint-GUID: pK8he-Y9Xoc55G8J4br4mRXB2xt8Jxxo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDEwMSBTYWx0ZWRfX8V62+7N20foW
 VGtdqzwtTIF8udq6PU8uTkGZJTyDgJBC56HO1Za6euQMCTAPkUUSARy0aiY1TCPjMc5ZBqtEMr+
 bMokWZssnRGMVU5fPapWxRIN4xS5Io/9uZjfS3fk3glCAucR0uks+2wPYHy8EkMd2WpW/GS2HAC
 V7+9VvhpWknjJ0meVmEYkMGqqVFVqDqqctGIGHcOfcF/vu8BacBSrdsJpfmAcvsh0lV0mwgR2gU
 Au1Dug7BhGmzf/S+8gQ0gpFwH2jn3IKuA/iSnB4Usodm3Qk8XlzU8QLEA+cXKhj0Y9mN/lKnNyW
 kNWitLjCxncpXmfo2HzmGLKKgE8CbiJ25Lm0FlgIACVQxVyJhBifclIlw943PYg/wrWssb6bagW
 +ZvG933L5JG/N7dzTj38WYwml4ufmsP014Pe3FaVerie3leZT2fuePUX+iYnpCVCCHaKBbu/K+p
 UL+o701LLUWgHqZPBJA==
X-Proofpoint-ORIG-GUID: pK8he-Y9Xoc55G8J4br4mRXB2xt8Jxxo
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDEwMSBTYWx0ZWRfXy+I0snivhMgj
 4d1i76PQbSxdaTstaMDHHYVxQzIZMXk4pm3YeZoQQ6eeBZlcVFTaRZ/ujd1Rr49YvuTHYD1mZsX
 5eT6l17UUv7RCXwYeiDloYniaCuCFow=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_02,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608100101

Introduce a hook for architectures to put their specific panic handlers.
s390 and sparc already has ifdef preprocessor checks to execute
architecture specific code. Pave the way for vpanic() cleanup.

Reviewed-by: Bradley Morgan <include@grrlz.net>
Suggested-by: Sven Schnelle <svens@linux.ibm.com>
Signed-off-by: Mete Durlu <meted@linux.ibm.com>
---
 include/linux/panic.h | 2 ++
 kernel/panic.c        | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/include/linux/panic.h b/include/linux/panic.h
index f1dd417e54b2..98dd7dfd27de 100644
--- a/include/linux/panic.h
+++ b/include/linux/panic.h
@@ -110,4 +110,6 @@ extern void add_taint(unsigned flag, enum lockdep_ok);
 extern int test_taint(unsigned flag);
 extern unsigned long get_taint(void);
 
+void arch_do_panic(void);
+
 #endif	/* _LINUX_PANIC_H */
diff --git a/kernel/panic.c b/kernel/panic.c
index 213725b612aa..726a97842232 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -567,6 +567,8 @@ static void panic_other_cpus_shutdown(bool crash_kexec)
 		crash_smp_send_stop();
 }
 
+void __weak arch_do_panic(void) {}
+
 /**
  * vpanic - halt the system
  * @fmt: The text string to print
@@ -756,6 +758,7 @@ void vpanic(const char *fmt, va_list args)
 #endif
 	pr_emerg("---[ end Kernel panic - not syncing: %s ]---\n", buf);
 
+	arch_do_panic();
 	/* Do not scroll important messages printed above */
 	suppress_printk = 1;
 

-- 
2.55.0

