Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CCD3DDAED;
	Mon, 31 Aug 2026 09:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788170265; cv=none; b=OODJsi0kiZwkOc8Juqky61Y8kVDYwEtLXQ4360vQNosbM6e0QkakR5DCSf2mlPS7ywA+qeBKvxMCAGgT6eB3Tikn0XntarXCumF+IhouSissuasAoR1MvPBGI1aIz9Ascw3Aweczy4YylZruzyCrzfurK7oUWOaLfmoFczOFC9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788170265; c=relaxed/simple;
	bh=92hixnRvobGNFPLV9JSrjDki5GamPSPiNR11I6RP+aY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hACHr0mb17zdEv1FLLjaoFE7cVc54e54948chgOylKv3Zc+v0lv+NZfjuB1/jprKQMNBBjOyppmlOvqNbJSebsU/TgCN9l9prplgsFjsz5Ht/ZQQr9l5ZzM5tkZWxClNqlld6/8c5vTaN6kBg94dn2VtMaXrWZW9LrQzmS8bVbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YDAqbIl9; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YDAqbIl9"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67V82ZD01698460;
	Mon, 31 Aug 2026 09:57:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=u1Jo3v
	9IF8WM4DTFnA4FLvNszr5Of9u9jmZT9HlBM/Q=; b=YDAqbIl9lDGKh6C10qIcij
	gPmBn/VVIC7gBKw1erj70keT8yvyqgSvQ7xhRzSHQaR4U3+QSjqTNF0VRKwgdFCl
	L7IYbd7AxVbH9isBN7GKDbtpycZqzW97eCIReSsYfNM+7u5NG9BxaUv9rwPFPFfw
	dEOIOporz7mU3vvPBJ8o2hF303pKNg+KPT/9bjfiIeIfx92BSl4vI4Ao8ZwH+12U
	mDEJZ42By1wnGtZPsQ3mO8q/I0BAfyZCBFaarmBpLTbfyxPo+rDGm4OP+YiAemBJ
	c3H/K4xN6ibW/mdq8LDYYdr2whogNnJL6eINlsoZ6N+h7P1GqE2OIOjOtYbsPgPw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq2t0aux-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 09:57:25 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67V9uQfJ022125;
	Mon, 31 Aug 2026 09:57:24 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gccexvyq0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 09:57:24 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67V9vLFj31261400
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Aug 2026 09:57:21 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1DDEB20040;
	Mon, 31 Aug 2026 09:57:21 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A763120043;
	Mon, 31 Aug 2026 09:57:20 +0000 (GMT)
Received: from [192.168.2.169] (unknown [9.87.144.92])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 31 Aug 2026 09:57:20 +0000 (GMT)
From: Mete Durlu <meted@linux.ibm.com>
Date: Mon, 31 Aug 2026 11:57:16 +0200
Subject: [PATCH v6 2/3] s390: Implement arch_do_panic
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-arch_do_panic-v6-2-a1e170a9e7fd@linux.ibm.com>
References: <20260831-arch_do_panic-v6-0-a1e170a9e7fd@linux.ibm.com>
In-Reply-To: <20260831-arch_do_panic-v6-0-a1e170a9e7fd@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=bc1bluPB c=1 sm=1 tr=0 ts=6a955005 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=jcFIXsoQAAAA:8 a=_xSrkdfc7yNGjjOxUnYA:9 a=QEXdDO2ut3YA:10
 a=M1-Q_cRM6PFdmZSamPpU:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA4MiBTYWx0ZWRfXxwrgQ+JC4EsE
 JtN50+Vjh0hYdnQA10baDZzy7JXe7AeBlBKy18EwO4MZ7GB+D3HdUkjwvddpc3kBTbo7r3NiYJM
 yO2uREcF0FX/Z1YGTFFlvbeciihpyRY=
X-Proofpoint-ORIG-GUID: L5-rd_S8Ng8RzJ9qF4gL0TVleff-Cb-J
X-Proofpoint-GUID: L5-rd_S8Ng8RzJ9qF4gL0TVleff-Cb-J
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA4MiBTYWx0ZWRfX2tMWIUi9v2FP
 yQtmZcAsgYfKNRr84j9owV70bBa38yZjon1o0MhTmBNmxGc67duqJqLp9xqiOu9eu/oqZmqGJmL
 AFe6sW0Pc2EoazUvXybI6j7SPblAcCTh6mQGYb5ZmEOgm/1LlG3FAOYbe6nFhValTbzdgfDJysQ
 AVhRCZSB0986oMSyRoQITDU2QqqNYk1ItUgcsAsz3Y6Gg7gO0QIP2cBRP8WFno/OLwC/QUfTXeE
 K/9z9agFDZ6VfC6aqEL/WTbdjyd7KBZzfWwn1ZiH6tBq61JF4ksBsIohVvgPGlntpXA6XNm3sRw
 a5RAQyHPqEm9nzTknLbyeLFPYWrRO8SQ9MeCJqwpDKvicJ2nmU85wQ1GEzqKO41+Gp5nyun7il2
 1pGEwmooYUEtl0dEXPUK6Gz9N5Aef6JMrX8AV09Km0q+wEXmu9XFmF31Hn9BVTXgHo6RHE8ZHiC
 lp5nQZLQ/W6xcccNzzg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_03,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608310082

Implement s390 specific arch_do_panic() instead of using s390 specific
ifdef sections in vpanic() code. disabled_wait() is now called after
"end Kernel panic" marker.
No functional changes.

Acked-by: Heiko Carstens <hca@linux.ibm.com>
Reviewed-by: Bradley Morgan <include@grrlz.net>
Signed-off-by: Mete Durlu <meted@linux.ibm.com>
---
 arch/s390/kernel/traps.c | 7 +++++++
 kernel/panic.c           | 3 ---
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/s390/kernel/traps.c b/arch/s390/kernel/traps.c
index b6ba4465f59d..115cb3373247 100644
--- a/arch/s390/kernel/traps.c
+++ b/arch/s390/kernel/traps.c
@@ -26,6 +26,7 @@
 #include <linux/entry-common.h>
 #include <linux/kmsan.h>
 #include <linux/bug.h>
+#include <linux/panic.h>
 #include <asm/entry-percpu.h>
 #include <asm/asm-extable.h>
 #include <asm/irqflags.h>
@@ -33,6 +34,7 @@
 #include <asm/vtime.h>
 #include <asm/fpu.h>
 #include <asm/fault.h>
+#include <asm/processor.h>
 #include "entry.h"
 
 struct pgm_stat {
@@ -283,6 +285,11 @@ static void monitor_event_exception(struct pt_regs *regs)
 	}
 }
 
+void arch_do_panic(void)
+{
+	disabled_wait();
+}
+
 void kernel_stack_invalid(struct pt_regs *regs)
 {
 	/*
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

