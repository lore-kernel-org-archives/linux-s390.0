Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654343D7D86;
	Mon, 31 Aug 2026 09:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788170267; cv=none; b=YkmJw4UdtB2K7KDeNcmoSioP5/nfOC1ykSMveH/5FE/xMMXq32j0x/BMlrWe3xMtO+HqSspM7YJHzPkjA+rm2w1vs3AucdOwt1k2Ao/a1TEs77bTtL0IgSNVTmHFf0sjFOZUJKI3MAZT14nH4+Ckz+uzJT6pi+6M1sLfExBlGL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788170267; c=relaxed/simple;
	bh=DlF9IHbbF22AcJ0tr0lCXTyXnYA2+IBigt3XcbsRnPw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mU3/6sTJXlbdBi4qqYkTApsAOn5JRp+hKZJW6VQPN+N58AjWZIchJF6+lqVnIK4GMgTb1331Kv1ryf2jRKCsdGfMKh92vFboszpfty6dKTSyeYp/e+PdU3x1AwpRitxSMWxEanSFOwcG7XmpiSSnBtn3nKuiUoe3p0RWy/ExUyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fOACtQ+l; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fOACtQ+l"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67V82iX9512780;
	Mon, 31 Aug 2026 09:57:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ZENuRT
	CKJYzkvgqkVlKx5zklT9/NSGHh+ctgB31DoVw=; b=fOACtQ+l4+I5A7ACOhUrw/
	8CdInYpIHUWn+yfQ3NmQgxLoAEYPE5IIUycQhbuI+tbQPbI88seNwLVyKaCILxi3
	aKEKJ/fy7OSreclbmP1SdqSnvMBPgvj+utz85XTisNc1pnfOGS2dCVUJkDTli5OD
	ptFWlCY5OcTtXMaNyhK9jBw5Qs2+3SlQRvw0dd/3r19wszoxuFGn/ip5OHB42Wxj
	0RcTUCbtv9h7Q7KI4LLR2ojwVo1kmyJYM8sSUiVoM5eLVu70VjKy85AookkGtLNN
	QojZ1f4Oia11p2Zu4gRKEBRkfnz1V1eMDxls3Wcxa2f29jQsmmaSIUFEH73QAhaA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbnudggkd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 09:57:26 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67V9uM5X027710;
	Mon, 31 Aug 2026 09:57:25 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gcarjw76h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 09:57:25 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67V9vL6j31261402
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Aug 2026 09:57:21 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9169F20040;
	Mon, 31 Aug 2026 09:57:21 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 285F72004B;
	Mon, 31 Aug 2026 09:57:21 +0000 (GMT)
Received: from [192.168.2.169] (unknown [9.87.144.92])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 31 Aug 2026 09:57:21 +0000 (GMT)
From: Mete Durlu <meted@linux.ibm.com>
Date: Mon, 31 Aug 2026 11:57:17 +0200
Subject: [PATCH v6 3/3] sparc: Implement arch_do_panic
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-arch_do_panic-v6-3-a1e170a9e7fd@linux.ibm.com>
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
X-Proofpoint-GUID: PZAbfiRYNLtSdh916t3REmOfY0bRsTtW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA4MiBTYWx0ZWRfX0UdAjcGwu9aB
 rK0mDMd6+McVwXsbN7eJLoFXf2QS/QDL6y71gLJ1dv6YZaZP7wHrCMHZHQm9Fznxzhn3VbAtamc
 O//gMlHCZL+aPuKBCm85dOAl8CDpPQ62J/USiKymk8TkRWHXD5K0NqVZYTYQ29MrCNLcMXH9k4q
 lr5nwy3+w5qgvrZpdcdH3RBUvTcHT1XqTZTXXR71hOMlyDIylFZ3cCZMaI0C1kIA0Y82aipaxb6
 SeuUxtNG2PPQlArwLCItwfZ5TOTAYBYWlAEhS530IWA28Eb0MKqjhAn5yyLZIk3Np2jS1gqBDVl
 kr0WDtf6ioPS8rGkKSEqFOU0FMqZO/5kEmGDiCoqAbAgy7nfIcE0vKlFUOGz431pfP6MB9tReLa
 qOoYBjjtf8COReTfXbj9k30hWdV1aJw0i0Dp1Y/BCMvMNhFlSWfQ4sydCZ9oEJsxst34sz87rlD
 gZhWwZICaJ1blv0uUaA==
X-Proofpoint-ORIG-GUID: PZAbfiRYNLtSdh916t3REmOfY0bRsTtW
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA4MiBTYWx0ZWRfX/2MWG8YR23hN
 7KAPga96cjsLPCEqpuK3jGHejplHIWIcihByta8oPUSELEUT1s02pC8gk/2O0nIjhFsHOOi6aT2
 +nA17pLSvfrPN3jd10ALzthS5d5XgzE=
X-Authority-Analysis: v=2.4 cv=B92JFutM c=1 sm=1 tr=0 ts=6a955006 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=jcFIXsoQAAAA:8
 a=VnNF1IyMAAAA:8 a=N4o6LLa-OltFePBdAboA:9 a=QEXdDO2ut3YA:10
 a=M1-Q_cRM6PFdmZSamPpU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_03,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 clxscore=1015 suspectscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608310082

Implement sparc specific arch_do_panic() instead of using sparc specific
ifdef sections in vpanic() code.
Reorder arch specific panic handling, sparc's Stop-A messages are now
printed after "end Kernel panic" marker.

Reviewed-by: Bradley Morgan <include@grrlz.net>
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

