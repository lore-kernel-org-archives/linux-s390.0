Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA191B87E8;
	Thu, 11 Sep 2025 09:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757582903; cv=none; b=NKR2xv3es5tv0BDw53gUsXb/e4AQIjiYs17nZoK2HkaY/wc+4HrSdSHWztKVl/aDEI/u84voIzAhiwTyMsxJF+f5QBXqKkVPPGXUZe0aHy/BahuYHhJKhynos/+R0a1A7EymnWAoWxd8WPlDxFlWTPDJ1q3OUO6UT5TzK+c/LnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757582903; c=relaxed/simple;
	bh=7O8wP6YesOxxPGXF72XoQUQIVWCXf1NXL+JFB7E9gf8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qixV3yRdLtb7t9SkvEdLcgAlALPKqdLFD6wjwzMlYOF7ecC1PjeiMbkf9vTXlAk3S85xXz5u/Mag+cduyQoNkSqoeoWN7YQ1HNSc1G0F9no3xlShHS6lKGStpNAkOQHbxUgHmi83gO9dsEhWq0gFOd+wB0CVgpJchKO2Mm77CEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ScSwbN5V; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ScSwbN5V"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58B7MOiO028317;
	Thu, 11 Sep 2025 09:28:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=XqbZs9hf4mUfj4ECMbTUhoGBGdSmHUuLJrDP1bxxu
	2w=; b=ScSwbN5VTAUnm2YOcI8EjmtIu6IugVleFPELT7GdADsJKy1836QeVEjJE
	6JE1GIsqyMtPSQsQHhDEgSDgED4iHCE6avwjSlO+2fFGNZ6GZKV3th+Go1UdUNsx
	6CI3wDjELgvkoxE3B8AJKGV+oontxUljXLjoCHyIvltdN62tXcBWQnzSgLGkKlLX
	A2zUd5mmU5lxozrCquLrSrf/tTqqEqVhtgvDW8FZqhD3pPBY36JQLxKmyilXW3cU
	eEGUFY4PS45VWNE4QGd3+ZKxcJjWIBSdXlQXmkDZvC1Wc9Zx4gL2UpOcyklUtXyh
	SA/69Bli5alD6SMDC1kAeNhnRcc0Q==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490cmx3pw3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Sep 2025 09:28:18 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58B9D2mJ007912;
	Thu, 11 Sep 2025 09:28:17 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49109pw2wc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Sep 2025 09:28:17 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58B9SCIT33161922
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Sep 2025 09:28:12 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C9FB42004B;
	Thu, 11 Sep 2025 09:28:12 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B9B7920040;
	Thu, 11 Sep 2025 09:28:12 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 11 Sep 2025 09:28:12 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55390)
	id 66890E03BC; Thu, 11 Sep 2025 11:28:12 +0200 (CEST)
From: Sven Schnelle <svens@linux.ibm.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH] s390/entry: Remove unused TIF flags
Date: Thu, 11 Sep 2025 11:28:06 +0200
Message-ID: <20250911092806.3262481-1-svens@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: nEprxwTOVfEOWQ9MvyTq4uRpIPPFQuys
X-Proofpoint-ORIG-GUID: nEprxwTOVfEOWQ9MvyTq4uRpIPPFQuys
X-Authority-Analysis: v=2.4 cv=J52q7BnS c=1 sm=1 tr=0 ts=68c29632 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=acghSI3q7n8i0AATrVwA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyNSBTYWx0ZWRfX97o0IK0PZ6Uj
 myTE/QqBteZ3EIqhM4H1r7PJEG+iE3q9iYTagABNOTcOMqQuoLPKuyD7cterD0iNqbaa4t8sWis
 GqXaP/8IGahR5yviLpDUX6K2+eqPOtLhH350QZSbYDb9RLEyVjcjpLeNcxcAgMGNGtRNv2JNPTz
 FaMdvjyRh9ZYJmW6bVzWAxUsOEETmFYK+8J1NAXtDEADLgm5urfpiJjwmT0Ea5vwHcHu1RrvStY
 R729vsYgRtPcY6i8kCZ8aIgYjHPBA2V9cmgpwKjzZTN1JBPxUoWKNQOy2hr/Ef8m6VyrjA6opxq
 lKOASVfuyvKVbYKlTOYiuda0UBSTwIojiU8+2C6//ExLq/ovy2LNBAJuW+LI0tkyDs9k4igPDDQ
 OXW16Fw6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_04,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1011 suspectscore=0 spamscore=0 phishscore=0
 bulkscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060025

The conversion of s390 to generic entry missed to remove the
TIF_SYSCALL*/TIF_SECCOMP flags. Remove them as they are unused now.

Fixes: 56e62a737028 ("s390: convert to generic entry")
Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
---
 arch/s390/include/asm/thread_info.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/arch/s390/include/asm/thread_info.h b/arch/s390/include/asm/thread_info.h
index fe6da066b123..7878e9bfbf07 100644
--- a/arch/s390/include/asm/thread_info.h
+++ b/arch/s390/include/asm/thread_info.h
@@ -74,12 +74,6 @@ void arch_setup_new_exec(void);
 #define TIF_BLOCK_STEP		22	/* This task is block stepped */
 #define TIF_UPROBE_SINGLESTEP	23	/* This task is uprobe single stepped */
 
-/* These could move over to SYSCALL_WORK bits, no? */
-#define TIF_SYSCALL_TRACE	24	/* syscall trace active */
-#define TIF_SYSCALL_AUDIT	25	/* syscall auditing active */
-#define TIF_SECCOMP		26	/* secure computing */
-#define TIF_SYSCALL_TRACEPOINT	27	/* syscall tracepoint instrumentation */
-
 #define _TIF_ASCE_PRIMARY	BIT(TIF_ASCE_PRIMARY)
 #define _TIF_GUARDED_STORAGE	BIT(TIF_GUARDED_STORAGE)
 #define _TIF_ISOLATE_BP_GUEST	BIT(TIF_ISOLATE_BP_GUEST)
@@ -88,9 +82,5 @@ void arch_setup_new_exec(void);
 #define _TIF_SINGLE_STEP	BIT(TIF_SINGLE_STEP)
 #define _TIF_BLOCK_STEP		BIT(TIF_BLOCK_STEP)
 #define _TIF_UPROBE_SINGLESTEP	BIT(TIF_UPROBE_SINGLESTEP)
-#define _TIF_SYSCALL_TRACE	BIT(TIF_SYSCALL_TRACE)
-#define _TIF_SYSCALL_AUDIT	BIT(TIF_SYSCALL_AUDIT)
-#define _TIF_SECCOMP		BIT(TIF_SECCOMP)
-#define _TIF_SYSCALL_TRACEPOINT	BIT(TIF_SYSCALL_TRACEPOINT)
 
 #endif /* _ASM_THREAD_INFO_H */
-- 
2.48.1

