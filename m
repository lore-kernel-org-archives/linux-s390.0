Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0812F3C07;
	Thu, 13 Nov 2025 15:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763046483; cv=none; b=T4pneMwlH4kn6Z6oi9TSwTrixxRsYI8I/5Ohs/eSJezwj6bCcTBPPIPwR+0rOoqPgJlv76MJ39mQd2vxZ3qODpmi2n1C6SCVquMkP48h+PuSSiex9tKdpFXphOTd4iyZPNTjz7qn7oYUjFMKJRHN1Pz1TxdU2ATeG9sVboF/zkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763046483; c=relaxed/simple;
	bh=je4ANgvATSrmNvlyMHpmPP8XRFeZ32lSUqcpv7CElZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lUIS8h1IX1fycjlHEIjdRbe4w+w68Ja37sF+y/X3xe7wldZ59ZIYsmT2PVYqCjpfHDwclza4xaElEOnovUiGNsrfY4f/sc4sCUga0ft9lxLYFvX/1HEtB2e0NXf5kelWovGPVuJK4wfrqGcxEd3KQPCxja3euCtyuFMMl57ACbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EMKvFf++; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EMKvFf++"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AD3Fpha003733;
	Thu, 13 Nov 2025 15:07:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=++9kxAUwda/Uq3U2J
	7Ffhpde5ggo2IPjNxql96xaQYg=; b=EMKvFf++1gE6Qw7/Jey6JDpXq48O1nNR8
	H5SakFxr24v4DJwxH43rbNv67NZMEudTlDHuc4AKtUz8Ih7/OavU7xdCN0sLPmwB
	gvMf4zo6VxCtToAO6V09+UPBjv5pr5b3VAaWs+9rTcwAOVz++V5Yr+VGbSbpJqmN
	4aMBWxLYHmtEUrbhslAUumWWwhxAy1bGyNP+oBPsydWXtknfoLDe8RFCCVrNjSHP
	kFvHVFXmjxhXuhmlpW29ZYceUhklPOqPsZwsZNM6v6FOmCiwcmasTuPGAn1W8wss
	IdXrmRKtzKzabi9Cka5anfwVUwAdgu68RDoBvWKbCzAfPENXuRFvA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aa5cjfff5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Nov 2025 15:07:36 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADCtJVW011441;
	Thu, 13 Nov 2025 15:07:35 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4aajw1p40k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Nov 2025 15:07:35 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5ADF7Vxj39715092
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 15:07:31 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9CCFE20043;
	Thu, 13 Nov 2025 15:07:31 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 703942004D;
	Thu, 13 Nov 2025 15:07:31 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 13 Nov 2025 15:07:31 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Andreas Krebbel <krebbel@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Willy Tarreau <w@1wt.eu>, Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 1/8] s390/ptrace: Rename psw_t32 to psw32_t
Date: Thu, 13 Nov 2025 16:07:23 +0100
Message-ID: <20251113150731.2697279-2-hca@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251113150731.2697279-1-hca@linux.ibm.com>
References: <20251113150731.2697279-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Ss+dKfO0 c=1 sm=1 tr=0 ts=6915f438 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=nS4I4FvftzVw7nn0310A:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDA5NSBTYWx0ZWRfX8zu5Sf653e7N
 oXONufKHhXN/pCto6tz8KTXNtpEuHNlBPoAuoFqCOSx48RYt1Bfi66UbuXntkvMs4E+Df8zIM/R
 YdxuleVOwtS5WVrsT2f4KgPCrthEPXEe+1UUu7GUrKT1TB5UunISMqiOkKY7l5zTNV76YLtcO0u
 d5b1VvgkfMuLw35gae8B/NfFi2F2UBDSWo+Z0TRRWzpKo8hOneQ64sIRbnWOwE+DWsFl2kjaWG+
 vN/wa6j//yX8RSJp4wcqcuZpkKTMdy+JsXIpjXqMnNsj+DJof1hljwwctFnGlSTv9nI0oNZWnBd
 CGbKder5NKuRilVosK2mCzBPXJ9lNnI460udOD4cdBg/zEuEBxyHyq4ZmMmmPwtRiYLos/zyLle
 s0cOfiIwRRMoL8pNB2RjRKB5Payagg==
X-Proofpoint-GUID: 6hRYfS_clGVNaL4DgScFtq4LRcJ_6TaB
X-Proofpoint-ORIG-GUID: 6hRYfS_clGVNaL4DgScFtq4LRcJ_6TaB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_02,2025-11-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 suspectscore=0 impostorscore=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511080095

Use a standard "_t" suffix for psw_t32 and rename it to psw32_t.

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/boot/ipl_data.c       | 2 +-
 arch/s390/include/asm/ptrace.h  | 2 +-
 arch/s390/kernel/compat_linux.h | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/s390/boot/ipl_data.c b/arch/s390/boot/ipl_data.c
index c4130a80b058..7957cc6554e7 100644
--- a/arch/s390/boot/ipl_data.c
+++ b/arch/s390/boot/ipl_data.c
@@ -12,7 +12,7 @@
 #define PSW_MASK_DISABLED (PSW_MASK_WAIT | PSW_MASK_EA | PSW_MASK_BA)
 
 struct ipl_lowcore {
-	psw_t32		ipl_psw;			/* 0x0000 */
+	psw32_t		ipl_psw;			/* 0x0000 */
 	struct ccw0	ccwpgm[2];			/* 0x0008 */
 	u8		fill[56];			/* 0x0018 */
 	struct ccw0	ccwpgmcc[20];			/* 0x0050 */
diff --git a/arch/s390/include/asm/ptrace.h b/arch/s390/include/asm/ptrace.h
index dfa770b15fad..f2ecc013a48a 100644
--- a/arch/s390/include/asm/ptrace.h
+++ b/arch/s390/include/asm/ptrace.h
@@ -99,7 +99,7 @@ enum {
 typedef struct {
 	unsigned int mask;
 	unsigned int addr;
-} psw_t32 __aligned(8);
+} psw32_t __aligned(8);
 
 #define PGM_INT_CODE_MASK	0x7f
 #define PGM_INT_CODE_PER	0x80
diff --git a/arch/s390/kernel/compat_linux.h b/arch/s390/kernel/compat_linux.h
index ef23739b277c..133f22b5deeb 100644
--- a/arch/s390/kernel/compat_linux.h
+++ b/arch/s390/kernel/compat_linux.h
@@ -33,7 +33,7 @@ typedef struct {
 } _s390_fp_regs32;
 
 typedef struct {
-	psw_t32		psw;
+	psw32_t		psw;
 	__u32		gprs[__NUM_GPRS];
 	__u32		acrs[__NUM_ACRS];
 } _s390_regs_common32;
-- 
2.48.1

