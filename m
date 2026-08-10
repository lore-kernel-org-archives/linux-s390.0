Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FF23C1D4E;
	Mon, 10 Aug 2026 11:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786361865; cv=none; b=pKF/brC8H58XAIEFzonnUImoq34eAEut+gMfmnIx4MSalqd8g5ItCU5giTdegllq3lDejdn/UJkkheYrXhW4M0EKQqGZOcVbg999gXaHmHxUAz6oOS8KPNPRXeVtYnM3z/OKi2WnZX/AUezqwcg6zNwlSqAz3Clsg7hMKrRxfKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786361865; c=relaxed/simple;
	bh=8TtrqoL2Yh9qCJlLNrX4fffO+yHXVrEcHsx/nEfuuvY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JQFsZOcY8q6XKvtEdpneLn5Aa9T1HVPjtM5kCHK9Wz85iXlCpe292fqyWHRZDm8eG1F195FwBc7Fx2l7gxfanHvGbEtZHqnXmCxogTd1BYZAr6m2754tZRbsV3kdI6zGnuUKRZ6JZR2812xGCGze4YuXmNnHHyKXHLI7xwISxk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=POdKs5CC; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="POdKs5CC"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67A9Vicb3584609;
	Mon, 10 Aug 2026 11:37:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=L9Ho77
	rBoUiSa1kTm4Lh2zkf8YWSkoONqgld5Wi3NSw=; b=POdKs5CC2GnfRsuoqnOWNc
	36oCx+a+8InUB46dNZ2n1nL15LDG60A58r+9N2YDo/VjbsNnzG26xtXfkxMJW+nB
	x9+Q7mNeprafa+Xx2tctIX+sV6UtvYX+TBS9ChPvA/B5VyFZPBC136dPCOak02U3
	iNXhGHsF5BqulZR/5Z7mEDwl5OtmVobsWJqnKsmZtehYQg7RDvGX4KzDo/IrUNMP
	w0osE30/zj1rM2HnnIvnS0OltKVr053/ETfMVOqm5jc+tZpyWYN7KlhsEPFo3owJ
	fl2K/4MV0qWfBjIPnkWfxmA4Hmi5fdRCu5NcHIIZCHoJIi88NFayLOx7fjpYX0/g
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvjyqnrw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 11:37:29 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67ABQPeF000669;
	Mon, 10 Aug 2026 11:37:28 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxhfxvc35-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 11:37:28 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67ABbOJg30278212
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Aug 2026 11:37:24 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 536C420043;
	Mon, 10 Aug 2026 11:37:24 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E6E5C2004D;
	Mon, 10 Aug 2026 11:37:23 +0000 (GMT)
Received: from [192.168.2.127] (unknown [9.111.54.108])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 10 Aug 2026 11:37:23 +0000 (GMT)
From: Mete Durlu <meted@linux.ibm.com>
Date: Mon, 10 Aug 2026 13:35:58 +0200
Subject: [PATCH v5 3/3] sparc: Implement arch_do_panic
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260810-arch_do_panic-v5-3-e86ae992c253@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDEwMSBTYWx0ZWRfX34V+7gLHdaim
 HsPIJg6zp3slJSNiXKE9zSmLFneMxpsMX0RztinTvw5Mo0LbClGek1OpcerLD+7NIR9Bv0KpiFk
 4N1Hh8Tj7qr0tTj/cXbzGULuvE9CCn9surKmG4Q84sCL8DEccNy9p3livgWTChV2o27GvzXUklt
 rc+AK1nGmulhOIjYQx8CjDSxuZWIH3LLKE2kf9K8Qyh9bhgjZn3Lf7VIpxtV0NLrz7x7DhL4izv
 +bY2JOVBLEKHNcNTjaN9FxRkDFac4Vfzae64HSEClYKkGLVLknldJgbvauHPNhPfofK/DOY52bR
 HIdH67Ouh92FL4MLDSZgktFaCeXbzhJGnlmjiIMDUtV6dECEq8BWp5Hqa5bhRLEWHjySO4oF41w
 OgxuhGTvwDkhCdjp0oUcuh+rDFP8AH6K1d/cP0CCuKLiNK90/TGOfNWXni4IxlA2UYAFvZH/vJs
 jHrAcybxG7tU1ZhACLA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDEwMSBTYWx0ZWRfXyssXpEMUlrM0
 y1qCwwwRBtscvA6TAi06PYa2YRfe2W+yHnanc4V6d+Qil8310OxuIZe2dhTqEA69tMv6SrV0DxE
 NIDqBiZeJjHDHhvxs55qF7P8usRH5T8=
X-Authority-Analysis: v=2.4 cv=RqD16imK c=1 sm=1 tr=0 ts=6a79b7f9 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=Iwkn-W_Q9BMZrAFg0pEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: SpkibIsQNEdF_S3i-vOq9Bf-40MqJRIs
X-Proofpoint-ORIG-GUID: SpkibIsQNEdF_S3i-vOq9Bf-40MqJRIs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_02,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608100101

Implement sparc specific arch_do_panic() instead of using sparc specific
ifdef sections in vpanic() code.
Reorder arch specific panic handling, sparc's Stop-A messages are now
printed after "end Kernel panic" marker.

Signed-off-by: Mete Durlu <meted@linux.ibm.com>
---
 arch/sparc/kernel/setup.c | 9 +++++++++
 kernel/panic.c            | 9 ---------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/sparc/kernel/setup.c b/arch/sparc/kernel/setup.c
index 4975867d9001..5f43cef80638 100644
--- a/arch/sparc/kernel/setup.c
+++ b/arch/sparc/kernel/setup.c
@@ -2,6 +2,8 @@
 
 #include <asm/setup.h>
 #include <linux/sysctl.h>
+#include <linux/panic.h>
+#include <linux/printk.h>
 
 static const struct ctl_table sparc_sysctl_table[] = {
 	{
@@ -36,6 +38,13 @@ static const struct ctl_table sparc_sysctl_table[] = {
 #endif
 };
 
+void arch_do_panic(void)
+{
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
2.55.0

