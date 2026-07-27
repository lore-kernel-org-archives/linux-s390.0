Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1839D3E9C33;
	Mon, 27 Jul 2026 09:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785142856; cv=none; b=Sr53Bgl84/jjm+UgDJvwNvRvZtcaikZ/icGDHfpE3+kMd7aP8MF/rK7eaNtIDXvQ34CtyqHA0ooHXAv3w0QBxHH7EfQxm2nw0VoXNdTnHbFWObaF/lK9fzslmh5vkbvItRPrVpDqaKNVQ+ONIcCNFHkk0sqy09bUYHNys6wYct0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785142856; c=relaxed/simple;
	bh=KDZAMf5wqhI9BpaUjEshoNeZUu6y6Qjk4yL7z4op2M4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k/apSVJxuq4FSxtYatwM3bOYwBeeqLr+tF///6x2u0tDZis4DXLXJTPwEFbnS3/hDbweiwdeXgJhDz3b+yqsowQFVkOc+rn+0w6wPa1pa+7vdwcbKerAGmoh0Jxk3qQN2d3kZltRtI9/R1l3jIVG2DasN5jvjnA7u5qsCSKXwns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=W9S1EKKG; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="W9S1EKKG"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66R7lggO1598411;
	Mon, 27 Jul 2026 09:00:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=9j7sPK
	9K1SAHxND9pGdw658fQZxeh/9WOC2FdmN/Igs=; b=W9S1EKKGHseMqhn59zqPxq
	0+6OD75c35kTp+LXOvfhP4HftKeUxD0rWhOq48zAfr1ygp2f/uzQy8RMMqfot3Gq
	qK+3hPDIN3mTlxJprra351ytUtkCrmwZsPIxMo5Ky87COWjOJByFMv9xaumoMTx2
	nEiNj2iLlPtNsy5Nkg28nAa8g3u4Um+5ufbTo/CYZ6qh8FPz41CwqhIMSneBxG0Q
	x3/dkpZzs6zZtzA79tPJfM5yRbh3JGxf7s8xnEei8yDd3wQ+F1BcIMucaClpl2D+
	hl8En6AJMEVzP5bbQgfYEF8Wil2eFIwoBQAoA0ErPrdB9UBBvty6/sYVg0m41xiQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuw77533-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 09:00:46 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66R8uJ23004549;
	Mon, 27 Jul 2026 09:00:45 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8yh4k1t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 09:00:45 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66R90evT46137756
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jul 2026 09:00:40 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 71890200EC;
	Mon, 27 Jul 2026 09:00:40 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1312E200EF;
	Mon, 27 Jul 2026 09:00:40 +0000 (GMT)
Received: from [192.168.2.127] (unknown [9.111.31.34])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Jul 2026 09:00:40 +0000 (GMT)
From: Mete Durlu <meted@linux.ibm.com>
Date: Mon, 27 Jul 2026 10:58:49 +0200
Subject: [PATCH 2/3] s390: Implement arch_do_panic
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-arch_do_panic-v1-2-ca1777547c38@linux.ibm.com>
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
X-Proofpoint-GUID: vEuGOgJw_vZpo5xAHxYiH6IKSlvCg9Pj
X-Proofpoint-ORIG-GUID: vEuGOgJw_vZpo5xAHxYiH6IKSlvCg9Pj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDA4NiBTYWx0ZWRfXxZf2ILGpA3ms
 Xvk35x7reQP5dzWXv27/1sIc8fNbLyXo/pl8EPa17mkpZPGArbjTCsD/xVaMufYCcV2PQYhcmUU
 5Waf+5mLMBlTXQoZUZdeuc1dIfKLyX/0FeuY/V4BlU3nbMwJ+HN/TuQNsCeIWvAgGtSPNgORHvT
 Ml7fUtDCjyQh+gfky6k1hZaFDL/NpNTJdRBENGNSlrHVfdugshNS2AaO1lDv/OgpE/cNhqXDeEj
 XiROijaBN95POYdoFUyDLU43dbKBBhFkLZo0sNqGloWRKeEHUoil/op9a6OaDinLyhXdGE3LCsG
 1omyALvy0H+gau68pydbMg5bVWIM7mJHLY4Aulu+ynJTCmkLIz0LFEO/Tmr3xzMGhMaqddCnc5N
 LI18QDgpOmWftEqzYdeLUFKV1ef58KWDgQTmgmEgY7K7y9t+9RNmEvg/iSkPnQZlF7FUf2tg75a
 0r9hQMFjDnGFkrryfvQ==
X-Authority-Analysis: v=2.4 cv=SKFykuvH c=1 sm=1 tr=0 ts=6a671e3e cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=bzDWoPb2IVNMdpXiKfIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDA4NiBTYWx0ZWRfX+CQrfD+LdX9X
 GhbzXjCXQgyEa/VkIlCOShfLyZKmi38+i0XeO8aUKm34Q+BWpN5fgw5RF9P6jfkMRJ2DNVLtNyR
 x1yZW2FZtN5lr4KLkdApZxQiZmcBFg4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_02,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1011 adultscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607270086

s390 has a custom panic handler which carries out user specified actions
during a panic scenario. This handler is invoked via the panic_notifier
call chain and executed before panic_timeout value is evaluated in
common code.

Use arch_do_panic() hook to invoke arch specific panic handling instead
of using panic_notifier call chain. The execution order of panic
handlers now allow for user specified panic_timeout value to be taken
into account.

Fixes: ff6b8ea68f4b ("[S390] ipl/dump on panic.")
Suggested-by: Sven Schnelle <svens@linux.ibm.com>
Signed-off-by: Mete Durlu <meted@linux.ibm.com>
---
 arch/s390/include/asm/ipl.h   |  1 +
 arch/s390/include/asm/setup.h |  3 +++
 arch/s390/kernel/ipl.c        | 15 +--------------
 kernel/panic.c                |  3 ---
 4 files changed, 5 insertions(+), 17 deletions(-)

diff --git a/arch/s390/include/asm/ipl.h b/arch/s390/include/asm/ipl.h
index b0d00032479d..38924c4a5d1d 100644
--- a/arch/s390/include/asm/ipl.h
+++ b/arch/s390/include/asm/ipl.h
@@ -166,5 +166,6 @@ enum diag308_rc {
 extern int diag308(unsigned long subcode, void *addr);
 extern void store_status(void (*fn)(void *), void *data);
 extern void lgr_info_log(void);
+void s390_do_panic(void);
 
 #endif /* _ASM_S390_IPL_H */
diff --git a/arch/s390/include/asm/setup.h b/arch/s390/include/asm/setup.h
index cbf60ade741d..6b38017f7cf3 100644
--- a/arch/s390/include/asm/setup.h
+++ b/arch/s390/include/asm/setup.h
@@ -90,6 +90,9 @@ extern void (*_machine_restart)(char *command);
 extern void (*_machine_halt)(void);
 extern void (*_machine_power_off)(void);
 
+void arch_do_panic(void);
+#define arch_do_panic arch_do_panic
+
 struct oldmem_data {
 	unsigned long start;
 	unsigned long size;
diff --git a/arch/s390/kernel/ipl.c b/arch/s390/kernel/ipl.c
index 3c346b02ceb9..8ab02e821256 100644
--- a/arch/s390/kernel/ipl.c
+++ b/arch/s390/kernel/ipl.c
@@ -2115,7 +2115,7 @@ static ssize_t on_panic_store(struct kobject *kobj,
 }
 static struct kobj_attribute on_panic_attr = __ATTR_RW(on_panic);
 
-static void do_panic(void)
+void arch_do_panic(void)
 {
 	lgr_info_log();
 	on_panic_trigger.action->fn(&on_panic_trigger);
@@ -2331,18 +2331,6 @@ static int __init vmcmd_on_poff_setup(char *str)
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
@@ -2375,7 +2363,6 @@ void __init setup_ipl(void)
 		/* We have no info to copy */
 		break;
 	}
-	atomic_notifier_chain_register(&panic_notifier_list, &on_panic_nb);
 }
 
 void __no_stack_protector s390_reset_system(void)
diff --git a/kernel/panic.c b/kernel/panic.c
index 1eb0cdc159d9..de0bda946cab 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -755,9 +755,6 @@ void vpanic(const char *fmt, va_list args)
 		pr_emerg("Press Stop-A (L1-A) from sun keyboard or send break\n"
 			 "twice on console to return to the boot prom\n");
 	}
-#endif
-#if defined(CONFIG_S390)
-	disabled_wait();
 #endif
 	pr_emerg("---[ end Kernel panic - not syncing: %s ]---\n", buf);
 

-- 
2.55.0

