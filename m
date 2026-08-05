Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E703BBFA4;
	Wed,  5 Aug 2026 09:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785923360; cv=none; b=HGtJX1l9UWLrn0t/nyyK6GfdmOvtV+ghGzNsE10knZmK0LVuZvKW03l2hkP/NCoCSRbgaBkcI3WRMS2epAGJICnpyCmsRxh7TIxXIBRwfwvA8lt1a070NEsRiFLEmmVrNnoEillPrPF9M4Ie2LpOs0KAsrmr3ZaBD0GyI9Lr0jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785923360; c=relaxed/simple;
	bh=8TtrqoL2Yh9qCJlLNrX4fffO+yHXVrEcHsx/nEfuuvY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TGhusTDnKGSvfggcGEszod0eeR5b1SER5/CkaTPnHu4hVH+JBtUtTcmrX3cRy2Yj1CuvLGQflzc5gLiFDLmz9PVQxdRmH1NcWwdKWTICCKQ4vdRORhfzuDgPdA5Nyo2gWLkcHitedNiZtQxuaZGSsuvsN+9PeWtOM7M1WiumT9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Uf1wPzTe; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Uf1wPzTe"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6758lb3p3387311;
	Wed, 5 Aug 2026 09:49:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=L9Ho77
	rBoUiSa1kTm4Lh2zkf8YWSkoONqgld5Wi3NSw=; b=Uf1wPzTecbCBTFHNmNYXEA
	oo+14soQeSNQ7XSOvRB277fU/kXNTR5owscxyZdBMN7TPBfHS2rouwSj33CjyXAk
	tpocnDNaJx9LrCuGRHSaDvnyg/OsPwLo0UIBIXrogxlDxGhbxtULYUIdzuuoUGmN
	s/N2igUg5X4M3aK5ekST10P+Ab3sJE+JE/KhCkoiIQFzJRvzVMqDC40iqrlkXm6G
	V2NNLoPJFiLeE/1C4Sjr8f9kmq9XnaRpF0JnTHD8qrovXkohYGN6Pz44O9ii3BOw
	XqvdpPq0V3dFbGmQWuVjOCPOqP0P/cKt69SNZxYrddog5xiFAeEFqhRwAb+I3KJQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8h52e20-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 09:49:04 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6759fR2c014460;
	Wed, 5 Aug 2026 09:49:03 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsugw63bt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 09:49:03 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6759mxlP13369692
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Aug 2026 09:48:59 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 77CE12004F;
	Wed,  5 Aug 2026 09:48:59 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 45F532004E;
	Wed,  5 Aug 2026 09:48:59 +0000 (GMT)
Received: from [9.224.76.67] (unknown [9.224.76.67])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Aug 2026 09:48:59 +0000 (GMT)
From: Mete Durlu <meted@linux.ibm.com>
Date: Wed, 05 Aug 2026 11:48:38 +0200
Subject: [PATCH v4 3/3] sparc: Implement arch_do_panic
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260805-arch_do_panic-v4-3-af4a36f99414@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDA3NyBTYWx0ZWRfX5oyVWSCyS4L6
 NtxLLfTpkGKrqv6F9wliidw/6Yo6gK2kEDFrazdztmfRntZJtk13PxvsMTR2UGVc5QKt7ep8Zso
 919y8Gh5jgxYh7nfBxAVrTcLobF2sw8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDA3NyBTYWx0ZWRfX/TNYVfwCON/q
 gW733BS7+G7OpetT+kRzbNUd0mQ0HbK/O48hPDxkuhIdHMTKZEGJ8Tae5brnX0ZTR7VKvrr/vOc
 EYcBSoLwucuLaPSJaqJkQIB1m64eDm3ZLcFy9Kh9Ej/01sdideFDTOw3wa0Iz7LMLqVbExx0AFX
 7nAk0BdY8lRIMlwZp3gOnt1cNsW3e4P96kfWFdp8K1TKsC+QsZymz8NuZ2PuCmaNV59DJGmzZog
 OKsj5Z70igVRHtUs40SvStuMutOs6k2/X+oyhOmJz2nGYjbktyflQ13WVlNDJB8LVLm97ytr9Mu
 H3zbE+Qjl2Mx6sodX2IOk5erD1moWcr6eipGF3CtWli2uiL+WzqtIHEmPCJaJClsRkDLxTd3Lfd
 p+VZw49v0E1btiNSEy2sV74hQFFD5/8EnFhWiRZ02+GdHwWG+CNqcSy1j4GQLbWiWtGRY2CBCci
 wEl7W7eL1nmdA2+pXVw==
X-Authority-Analysis: v=2.4 cv=SI1ykuvH c=1 sm=1 tr=0 ts=6a730710 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=Iwkn-W_Q9BMZrAFg0pEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: socpUiEkEdUWPH4iJJGHP-H0BScl2WsQ
X-Proofpoint-GUID: socpUiEkEdUWPH4iJJGHP-H0BScl2WsQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_03,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608050077

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

