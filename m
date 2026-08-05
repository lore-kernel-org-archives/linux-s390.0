Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF2E3F8EB3;
	Wed,  5 Aug 2026 09:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785923360; cv=none; b=FGlt5R3MqlZFUu3vz8GwxtajIrxRpiCA9mlRs6Lmm7g6bsly8f3qO6DoPDDreEwl7G5yDIHWxuLyhH8/BMlhSs05MUS8BCYhA/k2ULKHPF44VKyrIl4O4Jd45NafL9fkniQb+DTo/sSr8XlVD/itP0XPKrRlGY4QzySSEBUFCBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785923360; c=relaxed/simple;
	bh=PYF3iNeENBdSaiAGyN6wQYwEL8sItA6lmOBg8rYNCMk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qhdT1ZsfhBMyELZWE4YsNw400JGpAh2N3zHk0C78jsYY627TRDmZOLFQxyDImaapNwrzcGANYSmvEs3m9Dq3UOZiEzT5pa6GHqAxDMVM+O8NSMTM2cCVdUi6rySY8p3yoA4KV+zeDiBKwzyAO6/JDmjSgSKqHYdy1vWMVIM+iWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cfeXndAD; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cfeXndAD"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6758liJ63354587;
	Wed, 5 Aug 2026 09:49:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=YgwZSW
	C2bLmMyDbaQo4SVNBWV5SCX4gDWVO4DIJgLiM=; b=cfeXndAD9DEnWCUja2qZbP
	/hI5fez+zEsytB3q9p0uFDrH4HXqiNd4b1ZTpi5N3IlwQh3ub+XdP4CYqnnFG5SX
	Q1iPn1eR8Ne9oBXSmfukBeduOdPjT2r+0ocNYATTOPtnYLAgSmov4E1ZWI4Zghs8
	TL6jLsSXc01VK0r9cVO44xqSGewmjF5jBuZhkzcYpES9ixg1IhCKjeIJKOC4VwH6
	RqV/v1zvEgEeogcC8ZMv3JiJRVD7G2tG5MkQVf4P1cL0mzv0djp8OL3K1GQHXBXO
	mW4234MQG4fq4vb3nm9PeGatXN0hv+PY3GmCTWKdMYtVgRUd9+z27Jw+eTkUXd8A
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8a42drv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 09:49:04 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6759fLJm014396;
	Wed, 5 Aug 2026 09:49:03 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsugw63br-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 09:49:03 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6759mxwb15532414
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Aug 2026 09:48:59 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0F5712004D;
	Wed,  5 Aug 2026 09:48:59 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D0A6D2004E;
	Wed,  5 Aug 2026 09:48:58 +0000 (GMT)
Received: from [9.224.76.67] (unknown [9.224.76.67])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Aug 2026 09:48:58 +0000 (GMT)
From: Mete Durlu <meted@linux.ibm.com>
Date: Wed, 05 Aug 2026 11:48:36 +0200
Subject: [PATCH v4 1/3] panic: Introduce arch_do_panic
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260805-arch_do_panic-v4-1-af4a36f99414@linux.ibm.com>
References: <20260805-arch_do_panic-v4-0-af4a36f99414@linux.ibm.com>
In-Reply-To: <20260805-arch_do_panic-v4-0-af4a36f99414@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=E6P9Y6dl c=1 sm=1 tr=0 ts=6a730710 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=jcFIXsoQAAAA:8
 a=VnNF1IyMAAAA:8 a=vDqFKWyYXM9dIk6-_9sA:9 a=QEXdDO2ut3YA:10
 a=M1-Q_cRM6PFdmZSamPpU:22
X-Proofpoint-ORIG-GUID: cLFMVufzigXiBUXx_BofWknMvIaIss0S
X-Proofpoint-GUID: cLFMVufzigXiBUXx_BofWknMvIaIss0S
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDA3NyBTYWx0ZWRfX+M+VvqfWJuaf
 EkIL9zziTDnLwLjxlxUhFpQKvEjCIBsPmMMzWokDc/fP13iF2azQIrQCuZ3VpQLrMKt8GPcemj0
 R9J7/0DceiP2Aop3EczJ3e0mTdMdsdw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDA3NyBTYWx0ZWRfX8u4S6BdhrSV/
 FJPN2ImdFZGWhtCXkKjquajMgnvfvowR3X1KzVTes2NMTDDHbcZwBWAzsmtvncNcbtsFKnfcqR0
 Sd6JC/sVbls63jkcifnSyueb/+BveFfAOkhKKn/X8dv6KlFp0/J64ALnzCXfY99WN6RPVix/CQk
 iA3h0OUQPRNqQTN+j+KEXg+SiO7SDI4711IstrZwXBAuQ1Mj53+kMioXpKOYV7tR2F9j8O8Y+vh
 3w6mTXTtdbTtJEL9+EFjt+pbB/6oFDS0tKVqsjEr13cqkGynqNAzPyCOe6WbpbZ8CottbDfP403
 e2qQH9SZza1k/6aczejlH9FIZPldGRu8CoPInVCujELdbVvaCQU3r6BO0v2zX/hqKc3mmGg6XGN
 5h18PsDUR7t2RUDyY85zEoIuTVwYlRJhiT330bbs9x6WLalzK7/cNsnjERT3Uq9vwXX1h2t7PUS
 ZcFbzF8TGjjIf6hOFIA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_03,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608050077

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

