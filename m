Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F02035C68C;
	Mon, 10 Aug 2026 11:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786361863; cv=none; b=k6ymBVtNdgdL2sJc+r+as2KapnrNM5MffLdKFTfRhujtxpg0BIxSptxdw/xxPdXxbGnGhGkwmylYyySi4xDNSxjsscS8d5os20Rmw7DIb5iCidhggdKjGqldCb85tGckHGbPiHT/oZ87UiSghZzZ/20tsgLnOjuqihe5vYFaL/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786361863; c=relaxed/simple;
	bh=BMJDIE6CHbO1/hXXuxN0Oc8LiGEVwJX2mXmYuVlwD60=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GeUFv73d3lIu6ZUv7yavfoFkhCPzl7nJd/K87wmqy5Tp9mlj31ptAhUrieXcUpIEV1fPGzfGU0tNkCOdctsuGSb3Zv+o5tHpIvcumd4Sej3kMfGQoInJ+ApRM4nXRyk4VRMAh0jTc4xzdZPtbyvOjhB8dxV6Z+NiGi1NQ95h+Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ryHsbdLR; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ryHsbdLR"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67A9Vjks1169813;
	Mon, 10 Aug 2026 11:37:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=7GrJgi
	WXNOuyc/JoQ56ScV07wQEhbyTHNRlFdfLNWQ8=; b=ryHsbdLRptfs2fLl+CyfB8
	ZZWf4q+DDMuPWRt7JryiNwW64PYGbvdtA003LldKeP6GS+2txIj76evAZMO3dmcl
	0hYAVmAdC9jtaf9xz3fCFPOuA0BMByIbHtQOCISmTVQcBEfCOolsizGlo2mGfeeO
	s3n2fU5z9dApNsmOO0EPpEirx26quDQYJDRZf7ytMGncMZuTV6gIZ1M3P+udkdde
	iMmZX1l2GSsBbfNqusX1YLKFWn/wzADHOdOiCiJqSCxucxdt1eKE65YX8NcBQhNF
	ak8S5Z/N02tLMi0RAjMSpVdVyRC9WgH54jhVrc5czW5xpvL3Yw+r3KD/yO9wRCWg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvp2qb6j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 11:37:28 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67ABQPFI006307;
	Mon, 10 Aug 2026 11:37:28 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxg9gvh62-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 11:37:28 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67ABbNkn41943456
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Aug 2026 11:37:24 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DBE752004B;
	Mon, 10 Aug 2026 11:37:23 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7AC032004E;
	Mon, 10 Aug 2026 11:37:23 +0000 (GMT)
Received: from [192.168.2.127] (unknown [9.111.54.108])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 10 Aug 2026 11:37:23 +0000 (GMT)
From: Mete Durlu <meted@linux.ibm.com>
Date: Mon, 10 Aug 2026 13:35:57 +0200
Subject: [PATCH v5 2/3] s390: Implement arch_do_panic()
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260810-arch_do_panic-v5-2-e86ae992c253@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=AMtp2X5w c=1 sm=1 tr=0 ts=6a79b7f8 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=978copb2vMzALUAMs8wA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Rle0Et69GdhUWL8gPMlYsxYokfQSbsYx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDEwMSBTYWx0ZWRfX0hzs8yKSzujt
 z8djMcrxeU2Ryz+OUoyRBm2d7G8pK7o3plos6bYo6HvqmbaR0eXTZK76vWUvrn644TA+PvH49nt
 hnEuEMAB1l4M1oHvN0zKp8KER5rcOc63BxO4PLCaYSgWOR4CKkgRy25WPOLHfAHSHMiXCMyzXL9
 kzyfMEHt5nfmUQT0aoe23TVYnu+g6YPLrp419Hp0gRg2ytwcspW53TNHnp4VkC5V4T/vYEYpJTG
 C+3hJddmtrg+p1w90rrPse4j4T7P51YCnSgesBCsKEOT+Tjiimj/8/hsxORtIslUZxUeY6EfEUE
 LWsCFgAxzUb5mD/b8gAc/3eC/DG2oYnH44+PZTM1x6evteWT5MKwyKRBL0/G02XPRT5gvf7Qw2T
 g+LpXeteL8Rj+j3wbx+KtXoGeALVOyuohsdNYdh/BnK1g8jdRjQTmzKXvS/+fRUD4iSvCiUAc7s
 BuWlXymriZM5JtJdSFQ==
X-Proofpoint-ORIG-GUID: Rle0Et69GdhUWL8gPMlYsxYokfQSbsYx
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDEwMSBTYWx0ZWRfX3C27axWJgJnT
 BP1O0HC2pi5K0ef1t53GfpuvcZJ5/nxqHeDJR+HLs3y8bwpKM/5vz7uF7yIUOd2fySc/RLaLFo6
 +zxhieSWWoBynZxCcmK3i0GvXHYDwFc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_02,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608100101

Implement s390 specific arch_do_panic() instead of using s390 specific
ifdef sections in vpanic() code. disabled_wait() is now called after
"end Kernel panic" marker.
No functional changes.

Signed-off-by: Mete Durlu <meted@linux.ibm.com>
---
 arch/s390/kernel/traps.c | 7 +++++++
 kernel/panic.c           | 3 ---
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/s390/kernel/traps.c b/arch/s390/kernel/traps.c
index 564403496a7c..309d3d3e95fd 100644
--- a/arch/s390/kernel/traps.c
+++ b/arch/s390/kernel/traps.c
@@ -24,6 +24,7 @@
 #include <linux/entry-common.h>
 #include <linux/kmsan.h>
 #include <linux/bug.h>
+#include <linux/panic.h>
 #include <asm/entry-percpu.h>
 #include <asm/asm-extable.h>
 #include <asm/irqflags.h>
@@ -31,6 +32,7 @@
 #include <asm/vtime.h>
 #include <asm/fpu.h>
 #include <asm/fault.h>
+#include <asm/processor.h>
 #include "entry.h"
 
 static inline void __user *get_trap_ip(struct pt_regs *regs)
@@ -275,6 +277,11 @@ static void monitor_event_exception(struct pt_regs *regs)
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

