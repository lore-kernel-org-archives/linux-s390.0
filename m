Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6CB13F6606;
	Thu, 30 Jul 2026 09:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785403444; cv=none; b=iBzc+qvk0Iv8DesWIqxuFXzqIuk3AynkxY/C2DZfQ9Ww9U/BKWxvD1pQOFQiTO3pO/UaZjLUxkYojPRs7Haz07Rgj3vsQwGMGzgXkxjDSQep8ANBN2hwlQbZDrrnbVuw1NYzLb12xLI7i1qxN68nnyC8P601mIlCwQ1WS8mTIbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785403444; c=relaxed/simple;
	bh=k03v3JYtF2BbfAJ94xJm6VK8ZMvE9FaWHPZ6JzHrwy8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YcyXpxVE1PX/YnsWFLxrIXfnRUAROrgGv5JII3m8pDIeiY/qgHqcNOEVcLK3nFSvQmjtap9dbLKqUs3XEjkIuSFRqv5/HhDCuCjuPePzSFbVtobYqLGwcFmd61PpBH02Rez2paA1p3BmGFNwweZkDXuGmbZ4FdSy08o9OHBDt3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rqAXVWCB; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rqAXVWCB"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66U6lc29404229;
	Thu, 30 Jul 2026 09:23:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=/f43ty
	XBd8dCGSO8Uun3BrDEs2+KaggmDg4SuxGSZXQ=; b=rqAXVWCBQhPXabqY9x7vl6
	7GMB1Gnirzu09crXTVN3t5C7XHNgugHzGZnmSTSgveu8py+Sh7NZ+zfuTdqpUolV
	dAKY4wM83al3qSluNHvS5+0WqaHj4YvsLEDnY53MLYm2/hLAwlpZ1u/vKuUw4cpO
	Hnyuq28zZoYK+uJ+5qDdUtpWhdWGg6wMZXAj3m4BSb3XBkOS/Byjasm3nGr4ExfF
	bSuq5m73ZtAJzMr+A3/rX1dCOryg79sodpjUpy03/FMKjSL52ycRQl+oWU1lNTIz
	yRpStwU9krvOxbzsUkp1mtQXl5Qp/OirvZyHdDN6zVvrMdluJud0swdjqhue/g+Q
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuycpwst-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 09:23:43 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66U9BQHA002040;
	Thu, 30 Jul 2026 09:23:42 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8fkanrw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 09:23:42 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66U9NcpO35586366
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jul 2026 09:23:38 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1338C20040;
	Thu, 30 Jul 2026 09:23:38 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D57752004E;
	Thu, 30 Jul 2026 09:23:37 +0000 (GMT)
Received: from [127.0.1.1] (unknown [9.87.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 Jul 2026 09:23:37 +0000 (GMT)
From: Mete Durlu <meted@linux.ibm.com>
Date: Thu, 30 Jul 2026 11:23:28 +0200
Subject: [PATCH v3 2/3] s390: Implement arch_do_panic
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260730-arch_do_panic-v3-2-d5401e683cdb@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: u3KLgCS5S3Ny7VDjbRbwneeT6h_vDoen
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDA2OCBTYWx0ZWRfXyuVbC5T6/8v5
 NZ9SChb3+dqzXv8TLB/bC5ZbWNJ1oeYVpIMJEhAQ2cdVwoWpGr/gSVhKGom7L3yTwhZ30BIUica
 HaNUgBpkLOAfvq1p8jujnmhhk6ircNPLZMbd/vLONZLWIUgykAhwNRTrbCHkYV2Aeel1AEESR79
 7GYp1jeGq9x30Wexovx4cgrKBCv3SgSsXoQIiDb6YHGtTgbfhqopvX7LL0KI5NFEqdbIfRR6P7B
 8mUUmYDonXfx+7BwA5BJxQ0zSfHYWqAWGfVBJluIhmS6ujAb5SKuB/QBm/qWC70r6TEQkBAdoDc
 sJb7aMVskKknk6Vuc19UHO30y4q/AGDui9KdnBzIBocWkx89zwpPaWW2cryvkcrHOtnokHu12+4
 1huWKUM9f9e0fB1dHCXjR/FqXN5yN1Mk6S1+NGdpaP7qcto5WaJZQFV+s6YwkTvZ7ifhDVaiqHY
 XLybUKU6RgNs6hOXmyQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDA2OCBTYWx0ZWRfX9Yvy9EtIVezo
 6fplPsjElFMqs+xiy+NMKfOhdhWcy9J5VuVqBUkGN+tfOCm4PxrgvyGgnJWuHrycBEXDChLsuiB
 fejf2cyatkbU5ZcKIZnbjyyneENQAog=
X-Authority-Analysis: v=2.4 cv=AZeB2XXG c=1 sm=1 tr=0 ts=6a6b181f cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=oSiA8-2kMAKa6GL4jYQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: u3KLgCS5S3Ny7VDjbRbwneeT6h_vDoen
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_02,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300068

s390 has a custom panic handler which carries out user specified actions
during a panic scenario. This handler is invoked via the panic_notifier
call chain and executed before panic_timeout value is evaluated in
common code.

Use arch_do_panic() hook to invoke arch specific panic handling instead
of using panic_notifier call chain. By reordering s390's panic handler
allow more information to be printed during a panic.
The execution order of panic handlers now allows for user specified
panic_timeout value to be taken into account. This fixes the broken
"panic" kernel parameter for s390, earlier it was just ignored
inexplicibly.

This now means that the panic_timeout value takes precedence over user
defined on_panic behavior defined via "chshut" or writing to
/sys/firmware/shutdown_actions/on_panic.

Fixes: ff6b8ea68f4b ("[S390] ipl/dump on panic.")
Suggested-by: Sven Schnelle <svens@linux.ibm.com>
Signed-off-by: Mete Durlu <meted@linux.ibm.com>
---
 arch/s390/kernel/ipl.c | 19 +++++--------------
 kernel/panic.c         |  3 ---
 2 files changed, 5 insertions(+), 17 deletions(-)

diff --git a/arch/s390/kernel/ipl.c b/arch/s390/kernel/ipl.c
index 3c346b02ceb9..6a5fa9213450 100644
--- a/arch/s390/kernel/ipl.c
+++ b/arch/s390/kernel/ipl.c
@@ -2111,11 +2111,15 @@ static ssize_t on_panic_store(struct kobject *kobj,
 			      struct kobj_attribute *attr,
 			      const char *buf, size_t len)
 {
+	if (panic_timeout) {
+		pr_warn("on_panic action will be ignored in favor of panic timeout (panic=%d)",
+			panic_timeout);
+	}
 	return set_trigger(buf, &on_panic_trigger, len);
 }
 static struct kobj_attribute on_panic_attr = __ATTR_RW(on_panic);
 
-static void do_panic(void)
+void arch_do_panic(void)
 {
 	lgr_info_log();
 	on_panic_trigger.action->fn(&on_panic_trigger);
@@ -2331,18 +2335,6 @@ static int __init vmcmd_on_poff_setup(char *str)
 }
 __setup("vmpoff=", vmcmd_on_poff_setup);
 
-static int on_panic_notify(struct notifier_block *self,
-			   unsigned long event, void *data)
-{
-	do_panic();
-	return NOTIFY_OK;
-}
-
-static struct notifier_block on_panic_nb = {
-	.notifier_call = on_panic_notify,
-	.priority = INT_MIN,
-};
-
 void __init setup_ipl(void)
 {
 	BUILD_BUG_ON(sizeof(struct ipl_parameter_block) != PAGE_SIZE);
@@ -2375,7 +2367,6 @@ void __init setup_ipl(void)
 		/* We have no info to copy */
 		break;
 	}
-	atomic_notifier_chain_register(&panic_notifier_list, &on_panic_nb);
 }
 
 void __no_stack_protector s390_reset_system(void)
diff --git a/kernel/panic.c b/kernel/panic.c
index 726a97842232..ee6e3f9e3900 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -752,9 +752,6 @@ void vpanic(const char *fmt, va_list args)
 		pr_emerg("Press Stop-A (L1-A) from sun keyboard or send break\n"
 			 "twice on console to return to the boot prom\n");
 	}
-#endif
-#if defined(CONFIG_S390)
-	disabled_wait();
 #endif
 	pr_emerg("---[ end Kernel panic - not syncing: %s ]---\n", buf);
 

-- 
2.53.0

