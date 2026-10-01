Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E80E4CCDC4;
	Thu,  1 Oct 2026 10:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790850798; cv=none; b=pSYGT3ucS0r8UxUMJLYSNVdJIduP2gJt2rwuezSNQbbVpXLnckaOIpYQ/E5bQ8M8EXCDkaFehd6t4gefGsc5QG/LGXIPIF2TjjMx6e3Fa1VrerAUuAWTYkQeu+9iByVGrAXvaIzw89dQhtIBumLczoVN8mib+54ADtE/16KCuLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790850798; c=relaxed/simple;
	bh=nNnDwsS/uIAXtJ8PamNLBbzBJ+Eb8bJRKDK1m+NqcV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aM7jy/S2nJauujbFowkD2IjMGE5CbLk5fcZ0dFuS0llxqRN/sKZUX6KCj3nJF1qlTfqUP7ZWIj+Ji/tHQ438hNzwvxeBvw8JEKU+UDc8d18iumCOi8T7myTKnCDd/owfIWMevGpyDdrilzHO+E81XmROhnqAJrGNdhM75RKOSTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=r7oeRRno; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="r7oeRRno"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69175j1E1086248;
	Thu, 1 Oct 2026 10:32:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=5CqcLh24Ck4CVNhVq
	Xvru9zlwu2qU9vFuw9HLKyAj+M=; b=r7oeRRno9D3Q3Lgkp1gJy7baGdxlvymPL
	Q1WHayQswRpeNZbcbpGLbgbT+EJrif/6iAniU+teVoXh6RET7V89xSG2qCzG7U4O
	HmlkRgkgeFnjzBp5zkJ3w1QvSSJQ6SXWXEKPJ8M+JrEaHNf+aHTTnT4TVDyQkNqN
	nLSgw+lYrlNqIxIU1IHu3FcUXUaCUr2oy8ZZCRrphEso9hvaE4ZWk0Vt17K3opVh
	jAeuGyWmofL4ujy+JQNfw6EfR7MNhsfVV6x7tPVuLBeNThusqBd9TiVk6NbE6w+R
	sZs2oTc85S4zPZwNV+kLZ60xObM3rTm1Bx+GxBxAI3syWhWKDcSiQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5pthch0-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 10:32:57 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69172aiD520749;
	Thu, 1 Oct 2026 10:32:56 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h0hfpga5s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 10:32:56 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 691AWqDw47055338
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 1 Oct 2026 10:32:52 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9A49A20040;
	Thu,  1 Oct 2026 10:32:52 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5F11C2004D;
	Thu,  1 Oct 2026 10:32:52 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  1 Oct 2026 10:32:52 +0000 (GMT)
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
Subject: [PATCH 16/32] s390/cpu_mf: Convert inline assembly to EX_TABLE_INSN
Date: Thu,  1 Oct 2026 12:32:31 +0200
Message-ID: <20261001103247.1989111-17-hca@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: C7mRQGTP3xSc9saKBFBKxuzgh_GDAqgZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA0MCBTYWx0ZWRfX3Q/Zx3Sg0C1N
 +srHUOwa9kNDm8Co5UZmmib8qwF9wg9Hl3/hm1Ra/2DrtCKrii2cTJW64SYoGxuzHU/RkF88vQu
 cKmxUsKaQ26i05QU2UYpbIVdo4XoI1tkHja3E0a3l46HO8Oek1JuynngVYtzYlo5bj2VM8jE0J8
 Z5iTYjTOSueSaCTWhKsLbqKlduAefQhO50GiaDt9TIYE/gkDj4h3pqQdobBuNym9Fwg8DeRDIx9
 oQsoNoMtsFLt7GI4cPq1h1hiqwqKwWyIy1B5aWCeAXEtGhsJMrZDq6h++9YzIHh7bscH6KUl2UQ
 UEEoMc3XtrnwEy6uCjGc7phY5eYBkfhwNFVQDYdt6q0QHDNoZj6ELCiddYM6t7barWlM/QEre+d
 9QPMw0TGlTsQkW0y4DkWkerQ8n+mU1mCsPMjQ7IZEvSuGd5wTsoykcA/lFGm41pzvYcynoF9Q7N
 c0RLhrrT/v4skwbiqKw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA0MCBTYWx0ZWRfXyJcEVNz6Umb9
 2uRsVDVBTYNkkfVP9ZU/RguG3wdvk+LuGTlkLh79f5JkdLZ3iKGdKRQPPTdh3c86NMbw8rr39fN
 9NU/zaRjBuKhceA0+7waI2MjsuIMUto=
X-Authority-Analysis: v=2.4 cv=EY5d0/mC c=1 sm=1 tr=0 ts=6abe36d9 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=imVGdzJB3aOyz5-kiykA:9
X-Proofpoint-GUID: C7mRQGTP3xSc9saKBFBKxuzgh_GDAqgZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 adultscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010040

Convert all cpu_mf exception table entries to use EX_TABLE_INSN.
With EX_TABLE_INSN entries always point to the faulting instruction,
so duplicate entries are removed.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/include/asm/cpu_mf.h | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/s390/include/asm/cpu_mf.h b/arch/s390/include/asm/cpu_mf.h
index 1798fbd59068..dd2991622e82 100644
--- a/arch/s390/include/asm/cpu_mf.h
+++ b/arch/s390/include/asm/cpu_mf.h
@@ -173,9 +173,9 @@ static inline int qctri(struct cpumf_ctr_info *info)
 
 	asm_inline volatile (
 		"0:	qctri	%1\n"
-		"1:	lhi	%0,0\n"
-		"2:\n"
-		EX_TABLE(1b, 2b)
+		"	lhi	%0,0\n"
+		"1:\n"
+		EX_TABLE_INSN(0b, 1b)
 		: "+d" (rc), "=Q" (*info));
 	return rc;
 }
@@ -257,9 +257,9 @@ static inline int qsi(struct hws_qsi_info_block *info)
 
 	asm volatile(
 		"0:	qsi	%1\n"
-		"1:	lhi	%0,0\n"
-		"2:\n"
-		EX_TABLE(0b, 2b) EX_TABLE(1b, 2b)
+		"	lhi	%0,0\n"
+		"1:\n"
+		EX_TABLE_INSN(0b, 1b)
 		: "+d" (cc), "+Q" (*info));
 	return cc ? -EINVAL : 0;
 }
@@ -272,10 +272,10 @@ static inline int lsctl(struct hws_lsctl_request_block *req)
 	exception = 1;
 	asm volatile(
 		"0:	lsctl	%[req]\n"
-		"1:	lhi	%[exc],0\n"
-		"2:\n"
+		"	lhi	%[exc],0\n"
+		"1:\n"
 		CC_IPM(cc)
-		EX_TABLE(0b, 2b) EX_TABLE(1b, 2b)
+		EX_TABLE_INSN(0b, 1b)
 		: CC_OUT(cc, cc), [exc] "+d" (exception)
 		: [req] "Q" (*req)
 		: CC_CLOBBER);
-- 
2.53.0

