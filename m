Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B4E3DCD94;
	Wed,  5 Aug 2026 09:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785923360; cv=none; b=svWtXVjRuv/Ae652KlfQSWtfiTLvzwOnAvoYDNJtpEPTj3FAG+NrLVo8OrAexY6K+HSVXAJ+LUI0x3NJctFskoVp4Fa4qpGeThWpr1zIsbGpDq8nF6zt1kdNR2Oh2wkeN4CuffF2zX1O20VBwKOo5KeEolqR4547gOc7++6grW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785923360; c=relaxed/simple;
	bh=rvt+7Q3AjBxjuOexhM+FrTCcXp0MokH4qAipzV1ON30=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QIstVAoF0dd8kIrOUJp0JW3IRMmECz3kiWEFc+4g4Wb10dzn64zhH0jOexwrNP3BFQlIxXcvh2jP6O3vICDKzGuVnKllWCqQXfyIE+LAtE+2AasX/CPqIRgzyoHppklyqepav9kSgQzhkn76T7PwRsCQn7q8JvC02d004LAGNMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Ehg0kGpt; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ehg0kGpt"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6758m5HO3355781;
	Wed, 5 Aug 2026 09:49:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=NTnK3a
	A2hMq+5R6RYOaJhRMPnSUyUzOWXGeXNTankOw=; b=Ehg0kGptof2gUd+bmTgV32
	5Or5eTZQVtj6n0Ng5Z4uIud2JMf3wixJMlOnw32gtkDY9dZxLLDCJ7tfTUNczYSJ
	tMtsah+m1TJAgyJdioQ5OeFdpnIBYy3S97MJuUibnbpm9aNjX/oYI81VE6sWdf7U
	1kt7A7HsoYXWVrDHZt9ohqEtESwjgQXAe0w0lR1nlsIZs9Siwj6/lEhFdCPhf55K
	/h6qvWvk0moPMiYtY3prt9vYmdsKAEVicnXYW4IRgasle8tR5ldx4OuV5WmY1N00
	FTk0VM0aKUcYY0bHv9rDFsi8CtdNSG/+BrLL7UopbM4H7mny/YErMzbKEeac7nUw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8a42drs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 09:49:04 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6759fJu3031793;
	Wed, 5 Aug 2026 09:49:03 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fsu4qp46q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 09:49:02 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6759mxoE15532416
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Aug 2026 09:48:59 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 41FA82004D;
	Wed,  5 Aug 2026 09:48:59 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1379E2004F;
	Wed,  5 Aug 2026 09:48:59 +0000 (GMT)
Received: from [9.224.76.67] (unknown [9.224.76.67])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Aug 2026 09:48:59 +0000 (GMT)
From: Mete Durlu <meted@linux.ibm.com>
Date: Wed, 05 Aug 2026 11:48:37 +0200
Subject: [PATCH v4 2/3] s390: Implement arch_do_panic()
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260805-arch_do_panic-v4-2-af4a36f99414@linux.ibm.com>
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
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=jlr_GaNLoAU3iIlrA6wA:9 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: E_YNYjeeE1LkbBTnfbST4oraBptgzVop
X-Proofpoint-GUID: E_YNYjeeE1LkbBTnfbST4oraBptgzVop
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDA3NyBTYWx0ZWRfX4bhZHGsyoWKC
 tvjLJ77kGsPaLOH7pELLnpfj2MzaNRrCtB8SLodhclNOo9riUOGKRIcSfpncsHIhDKkbEERFfDb
 hpOrq7L9O6kl3wUHasKYDXYraDUoAsw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDA3NyBTYWx0ZWRfXwh/qApJsqYYq
 /CdZTqPFrT/GU2mKsWaEs9akky3bjJjuRhhHcxAXYbX4jqV3Z5V/rBNBlesRjBUwI02nPdfpMC0
 kg+gRmQMym7VbgYbDIqPKxfh8n6KUCwXnqMUFV4eU3krXxs24T3YTFlaAaOdkqkjOAqsFN/pPax
 r/STl9LCLk5YCd2xGb4Hv1aOXwLzKTngQVrrwl3+my3vmvKJ/Z3Kr6cw9ptkUKZUGVJvmQngC+E
 8Xhv1xwQLP2RxNPf40emLuP0ExlAW7DWOL3lwWQ+xwQGiQn0YCBrzXWDmQRITL5AZDybX2Hc1jS
 bqsYSY1Ka+Spn+LLQP2lwbKnP05NQ6l3qmyZbqn+ReNiY+GA17z6yibGrRZqEH9pJxuuPVSCPJK
 P+gXrBaQ9U1Gp7BjWJGljIs6LoSRMGBUn/pP2du4Xj3I4X9sO647ayyyQHLgVll8vBoW6wlkGk/
 DJA0PL8CFaIgh5oktvg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_03,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608050077

Implement s390 specific arch_do_panic() instead of using s390 specific
ifdef sections in vpanic() code.
No functional changes.

Signed-off-by: Mete Durlu <meted@linux.ibm.com>
---
 arch/s390/kernel/ipl.c | 6 ++++++
 kernel/panic.c         | 3 ---
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/s390/kernel/ipl.c b/arch/s390/kernel/ipl.c
index 3c346b02ceb9..31ff7c12c354 100644
--- a/arch/s390/kernel/ipl.c
+++ b/arch/s390/kernel/ipl.c
@@ -13,6 +13,7 @@
 #include <linux/device.h>
 #include <linux/delay.h>
 #include <linux/kstrtox.h>
+#include <linux/panic.h>
 #include <linux/panic_notifier.h>
 #include <linux/reboot.h>
 #include <linux/ctype.h>
@@ -2343,6 +2344,11 @@ static struct notifier_block on_panic_nb = {
 	.priority = INT_MIN,
 };
 
+void arch_do_panic(void)
+{
+	disabled_wait();
+}
+
 void __init setup_ipl(void)
 {
 	BUILD_BUG_ON(sizeof(struct ipl_parameter_block) != PAGE_SIZE);
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
2.55.0

