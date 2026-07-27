Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5863F58EB;
	Mon, 27 Jul 2026 10:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785148605; cv=none; b=RE8pDKkfptD7ywXze5a0PByR7/oT/8mGGcj9ACbWdgnXdvsyUKM1aMvIH5QJenSYP7n5grxba23snykyQRdS1yvdygHH9xV1uOy45Bqvku4kX5NHfwDgirVmcmUD8nRIDw8BmYGb041+2HOIPlYWTaeU0Z96efRRRbsut1usTl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785148605; c=relaxed/simple;
	bh=RZCqd/4XZwF4Z5xB1Rvs8Gi9M1lZCtmW8YDSk4jKrYg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TDLVImFHR0IFSrhmJdPjoXABLUqehVjg50xdJZIt+pKKgfWWJxEOZNmwq1Ld3W0K81XGAtug/3LZNjcTiURHLJaswKbAp/x46cHXG0u5b+6d8ADmiVIchVzt0MQQKglr4uGayWnOIMBfmsPAm5WalnulHkXd2BYPFnOgp3SaD3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=owTg0/f1; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="owTg0/f1"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RAKM5H065095;
	Mon, 27 Jul 2026 10:36:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=TyuZYz
	MTxTJl+pM65+tPjPwwLDegp9cA11IioLEq6Q8=; b=owTg0/f1qJ6HiT5klX9Xvw
	NnmfM5dKRPV7QN6wEUSomwTU8zCbn3V3oKXst0OBA4T0S4i1lXNqFCh3ZB3lCHPe
	RXQhh0GoaKulvTP8e8yQmx3OqYRKyd4yxFnF2zjEdcAW3uJvkN1nF/w0hJ5Rx1DV
	QSFZDBmyR0WQ/BYqglxvFNgd2QinMDFpsm47lwOb7oUpwTz4c8G3AwcixOFF9eUT
	hAgkry+4LTweswL/V/7vG+9teKz6WdeaA063zVs9gm+rwSUu17mYBfzmbIyzrkjY
	uoU/B938Hbbr5iJdNlqKJDtCaL17WsV2pY1sc/EIbf0E8HEoIy7gcOS8yhrx5ARQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyc7gdn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 10:36:30 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66RAQbOL016816;
	Mon, 27 Jul 2026 10:36:29 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fna5xvq8e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 10:36:29 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66RAaPOt41812368
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jul 2026 10:36:26 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D165D2004D;
	Mon, 27 Jul 2026 10:36:25 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7011520063;
	Mon, 27 Jul 2026 10:36:25 +0000 (GMT)
Received: from [192.168.2.127] (unknown [9.111.31.34])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Jul 2026 10:36:25 +0000 (GMT)
From: Mete Durlu <meted@linux.ibm.com>
Date: Mon, 27 Jul 2026 12:36:21 +0200
Subject: [PATCH v2 2/3] s390: Implement arch_do_panic
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-arch_do_panic-v2-2-4e25ceb05075@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: jO9bpubYIJdy8sz3o_z5lIUbcIE35w8v
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDEwMCBTYWx0ZWRfX7C6XVRavkwub
 3tRA3fQ9CcCa3cLJzZGb2U2g3kqZ0qSJeYOn2RJdPsU1sUgLAAQ7qHIK2q8pRTMEErJys+LPZ/Y
 bScRLjuywpS2PEmjJC4VNO0989ylv7qpqYlxfjVCuJdgcmxYfxp3+BFOAui5vT4QDQHNWiQmki8
 6hDvuyzxjId8Qk8O1s6WPEeYvcaBv+VM+JTCCmoEx/QLFaGzpEogn//wA3IHBN97Gfm1qXO1BCp
 uyq/l2JoBnCucxDpA9rNMRZdhVOpakgliYTS6Nm1ai29dmxL4WsPtQn8OYOajKgLXoB2jEhcqSc
 rX4xsCyKWkS2PvIulUxOrhQrR+eaSt+xx/A1gEu9507QVPYSs7z+MeAXg0NfmTzLUXlNAFWMUz9
 XwRx6U9XiZuxPAwdIZrApGHs71LwjfnT5nytWuk7UNiaG88BOAEjeVab7flxMHKWEPRCdtyfdDP
 SNRjkVeJyewnPAQF9Kw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDEwMCBTYWx0ZWRfX/uVv+UNnU05y
 wu/SL/z4Lj/6cTZguFuyLQBdR7ad4smXsMLH8/P1TJY8iQ2NxNNhIulJER4vmLegMrUIm22JSZw
 XCFumemnfPMfg0VsvuUtD3nNKVnTphM=
X-Authority-Analysis: v=2.4 cv=AZeB2XXG c=1 sm=1 tr=0 ts=6a6734ae cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=Kzj0gvii5Zljd1z7FO0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: jO9bpubYIJdy8sz3o_z5lIUbcIE35w8v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_03,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270100

s390 has a custom panic handler which carries out user specified actions
during a panic scenario. This handler is invoked via the panic_notifier
call chain and executed before panic_timeout value is evaluated in
common code.

Use arch_do_panic() hook to invoke arch specific panic handling instead
of using panic_notifier call chain. The execution order of panic
handlers now allow for user specified panic_timeout value to be taken
into account.

This now means that the panic_timeout value takes precedence over user
defined on_panic behavior.

Fixes: ff6b8ea68f4b ("[S390] ipl/dump on panic.")
Suggested-by: Sven Schnelle <svens@linux.ibm.com>
Signed-off-by: Mete Durlu <meted@linux.ibm.com>
---
 arch/s390/include/asm/setup.h |  3 +++
 arch/s390/kernel/ipl.c        | 15 +--------------
 kernel/panic.c                |  3 ---
 3 files changed, 4 insertions(+), 17 deletions(-)

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

