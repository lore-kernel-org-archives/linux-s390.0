Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018A33D813C;
	Thu,  1 Oct 2026 10:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790850780; cv=none; b=CsEc7ZNYkLJWQs58Xi2bIMMzM9/rD+fLbT+EJp0ewXRl4UsTPBZYRS1aL5P9ovLeot0Lpgv+AUwA0LiuvE/eRK2WzNCtObIxZB0nJSttBDrU3kg1QeNyrH5GcElqWMW2FjuDm+wD821zpm5j03YMBCgU7/YF9mbWDnV4sFfVH3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790850780; c=relaxed/simple;
	bh=9ymcvElRLSf7BVBe2rHWYFKJjTp2hZUORDKB7hXkJCk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ULgJCDHfWqs30IPZWoEAC5K8HRSSbRPwbLmBLAMlcqVH7ZOMYmvdNWvtiNqXA9HAr+fQSEYnnzGrdmTG4ZlOp/rIbmlFeXrWpTdcqe+TBzMw1fcNSwrSChTuCR2Lkx6xr7JSXAi2H7a8wFnl9mTwujyIjYrR5NDaAA0nKqOVFjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RguuWuL6; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RguuWuL6"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6917618l4041238;
	Thu, 1 Oct 2026 10:32:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=bENsCR73H/OgS1QoZ
	ApJv5C0vS/g95KkrDrpgfoiASc=; b=RguuWuL6cPfj0FWWZAKU0gPmqmXXRPGhV
	qltduIND++m3S+Zanz4IX3UMXJTRDbVI6Zo6giLaTLFBk7jH3oZ0qGAgdEHem3AR
	76flb5guTdCrIAWP0gcTdv4EUAZPKahYhsPdRB+LYckKYNkyz+mIv04+hNBybX8G
	CaBUqBBvIYG9fR/uONBcou7RHXcDW+FUMDti2HH+iFZAfuiZyky0zD+ce3bConzE
	1CaRj3TEi5b3AZWukuDcSHAfo07QEaIVWPb773GhMMZYh9jr1ZkepaxWvFz4gi0V
	ekey0rPdoKu8SvPrbkhVq/ms0qBBsbUIuScDJtGr82a/lNTz8BN+Q==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx4fehfms-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 10:32:54 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69172vUJ3460511;
	Thu, 1 Oct 2026 10:32:53 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h0q4pexat-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 10:32:53 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 691AWn2C31523080
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 1 Oct 2026 10:32:49 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 14FE120043;
	Thu,  1 Oct 2026 10:32:49 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CD7822004D;
	Thu,  1 Oct 2026 10:32:48 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  1 Oct 2026 10:32:48 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Holger Dengler <dengler@linux.ibm.com>,
        Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 03/32] s390: Clear pt_regs flags field
Date: Thu,  1 Oct 2026 12:32:18 +0200
Message-ID: <20261001103247.1989111-4-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261001103247.1989111-1-hca@linux.ibm.com>
References: <20261001103247.1989111-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=FYWiV5+6 c=1 sm=1 tr=0 ts=6abe36d6 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=vG85Bs01LOTUVlHRul4A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA0MCBTYWx0ZWRfX4zPqPjq/RYV0
 5xOHCnvr7Rjy3Vufe4AMlb6YmC2MFHinMB0JpBZHhvYFz+AKOB67FIZBXlVynleQikTTjwI4nFm
 KD5B5EH+ETDcL1EDcioSm+PuUvNyDfA=
X-Proofpoint-ORIG-GUID: uv-ix80b-h3VBfViWJOsGcIyYlP6guJC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA0MCBTYWx0ZWRfXxm6VbNIkMjAp
 jR5nQSm20KTN9cCx4tzJCiiOqrGKGqZvkz76qLY3OO3eKTZkkD7y80iItlhRi4HLSAsmZiqj48u
 mR4tNbDlHbNcI9cN9jyDb6rDVgeppNsn8MIOf4/gjxBVgD9Ug7F029tze9qZALMbzsuNJZUEWao
 k1WTP1y/bv14BN8kEiyTUeT766xRL4OCyBmyPTVucMkE0bC9w8jySwQ2Z9Hle18BN6bVf7whB+5
 gCV+VL4nvHlHEF+zz0y9OVNm36lekeWBVJvIGdWGf8qiyEbx11fyAg5lK+9BxD/6l4pR2m4C+0T
 vr9jz72FuZQEEyX0ovq2ijdLr/rRcDXrS/E9SaatF8GXN08jiKaLIaVvhF3mgyyY8D9UkbRTqNf
 MZ5oMHPn5GV6+r6eiEEStIDtR7N8Ryl31MChCzOg1KeClx5VrN5YDMOwSoEZTyxLpUK335kBooQ
 jUnOq7P2fslOHJjAsDw==
X-Proofpoint-GUID: uv-ix80b-h3VBfViWJOsGcIyYlP6guJC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610010040

Clear the pt_regs flags field in the early program check handler as well
as in the stack_invalid handler. Without this the pt_regs flags field will
have random values, depending on previous stack contents.

This matters currently for bug reporting and disassembly, where flags like
PIF_PSW_ADDR_ADJUSTED may then be incorrectly set, which could lead to a
partially incorrect disassembly or wrong code markers.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/kernel/early.c | 1 +
 arch/s390/kernel/entry.S | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/s390/kernel/early.c b/arch/s390/kernel/early.c
index 1fc153d8385b..b8e3c065fbec 100644
--- a/arch/s390/kernel/early.c
+++ b/arch/s390/kernel/early.c
@@ -154,6 +154,7 @@ void __init __do_early_pgm_check(struct pt_regs *regs)
 {
 	struct lowcore *lc = get_lowcore();
 
+	regs->flags = 0;
 	regs->int_code = lc->pgm_int_code;
 	regs->int_parm_long = lc->trans_exc_code;
 	regs->last_break = lc->pgm_last_break;
diff --git a/arch/s390/kernel/entry.S b/arch/s390/kernel/entry.S
index 10dd9bbdf985..f51ecd8e7d21 100644
--- a/arch/s390/kernel/entry.S
+++ b/arch/s390/kernel/entry.S
@@ -621,6 +621,7 @@ SYM_CODE_START(stack_invalid)
 	stmg	%r0,%r7,__PT_R0(%r11)
 	stmg	%r8,%r9,__PT_PSW(%r11)
 	mvc	__PT_R8(64,%r11),0(%r14)
+	xc	__PT_FLAGS(8,%r11),__PT_FLAGS(%r11)
 	GET_LC	%r2
 	mvc	__PT_ORIG_GPR2(8,%r11),__LC_PGM_LAST_BREAK(%r2)
 	xc	__SF_BACKCHAIN(8,%r15),__SF_BACKCHAIN(%r15)
-- 
2.53.0

