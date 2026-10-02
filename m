Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFEFF322B8F;
	Fri,  2 Oct 2026 10:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790936878; cv=none; b=XinR99GMx7hKYpytTp/99YSl8S/MSrKmBMSduB3wyCRyeL/uOBEoXImbqRgVaUfXWfckTfOVYKp7A9+sLRn+uaFkvR09UhhTvXT8uX1DCOk+qXYfyAzH0Sfx7Tisp7r/C+hHtd7Utge542A/r9nUfMFHNFKT30NtudwM1A1TEPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790936878; c=relaxed/simple;
	bh=8wGqaC+jBBfUfJLAaHTguktlt0Aln9XSrj5KqsldJIM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JqrpPmDT8l4RoXSsV6m5N2l8VQsvqgFym/YGVE/pvE9X0kd+F0m1KRuCiWa+GA/AD/6Zkuqt31oHOj8cgUSSb8h9INSD7r/1v+fh2tcHsj2rA7V8d/tuYOQFuud1hKHFl85MvHswlMoviH2joaFNQSLII3Mz+WmB+PrZTray9Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NBFINY6/; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NBFINY6/"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 692A65TQ2567063;
	Fri, 2 Oct 2026 10:27:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=ZtCo0FdyDhkMCPz0Iuo3/oQ2+zcrRZbh3i5TUrD5d
	dk=; b=NBFINY6/QxohH9hyErIAgj6BDCxXKjs0te9ZgTwcvNeeJooOFr7Mz5X0N
	bHLJp0qdDrPnCmDSBAGV3Xmt+ttUWJv0RcuZniHKtL4bHseTAHxZmmsYpAm+QmcY
	4riSGgVLmtvV3PJysahYxfi8IGY3sX6y552Lk4HPocQlIbFsebdYO36tlo+xq2ZE
	oVaBL8dX/4RyjJm2qOU/dPHboi8RtLOXR5umZNXuZeC9ZXbTmtvii6RKu5t4507J
	pyiQ+AaYsHmsL1/GK7zFj7aaIONKn67wZdrOO4lP5WW7xmqBBLyTFZOFKVthhVOA
	cLyAmTGwFx4UUnNMdxWM8ISqx1ixA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5qrrnsq-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 02 Oct 2026 10:27:55 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6929lbNo2347875;
	Fri, 2 Oct 2026 10:27:55 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h21nu1qqc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Oct 2026 10:27:54 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 692ARppa51708246
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 2 Oct 2026 10:27:51 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 36EEB20049;
	Fri,  2 Oct 2026 10:27:51 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1A40020040;
	Fri,  2 Oct 2026 10:27:51 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  2 Oct 2026 10:27:51 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH] s390/extable: Fix mvcos instruction decoding
Date: Fri,  2 Oct 2026 12:27:50 +0200
Message-ID: <20261002102750.1994830-1-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDA0MCBTYWx0ZWRfX6a6FQ4E1W6+3
 SNmpWXyZRm3S0EcsIazF1l8mwGP2YBrhEnJGvQw0cfsbq6rQdOjvA4BM2vtIRek/lnAD0f0H3fR
 sN9ut3lyLHq1g6/t2NYfa/ylYrs7GgImNWgyd29pfT0S6yu/S28CMCa2RFVOARJJox2nrxd0FA7
 IyxDitu7IerOHJwd1Fp4zteUU2vLGR1bBKu0v1zWyrg0lZ1zXDEe2n/wmw6bi2KlNvi+pYkDn5I
 UlkkST8HiiV/mPkDqr8Pww97dgCwNHSLuzLSfrQiTbfhok97V6vQEvB3swQWNn8csCQpCsZQwhm
 XkD33TyvCbIUqxguDHh/xo9TyilN7AlKVsYIDL8G/c+gsJUNNUKIVGU+e6d22oulaVe5H7uQMHb
 rNBYiDLgOEcw1PWVHD8Wfj0OxlNzkyBrL1mSSJU8fIUjX7JKSHWtwW/rCTNU+48gPf9HA0EajRY
 FASfha/vRZLVhKsOsYA==
X-Authority-Analysis: v=2.4 cv=SPbXx+vH c=1 sm=1 tr=0 ts=6abf872b cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=ffBm7Ohb_I3oncLQO4gA:9
X-Proofpoint-ORIG-GUID: sXOvcy6QtcE3EhG9Kkw8xZPlKqBOdxuX
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDA0MCBTYWx0ZWRfX3Q+fE4ZIWuzK
 AmoADb8Ogytto3stwMakmIP5PNoG/8NLsdpcjqHjh4SxnaASYymVPJkj9p1Rr1+rRh97Bi4guSB
 J6agaY3mPHGFIaygJ8oFfIv2OEbpu/A=
X-Proofpoint-GUID: sXOvcy6QtcE3EhG9Kkw8xZPlKqBOdxuX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_03,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610020040

If either the b1 or b2 field of the mvcos instruction is zero, register
zero is not used for address computation; zero is used instead, according
to the architecture. ex_handler_ua_mvcos() incorrectly uses the real
contents of register zero. Fix this.

This shouldn't be a problem for any generated code, since the compiler
would only generate such code if it is possible to prove at compile time
that either the source or destination address is within the first 4kb of
the designated address space. Such code should not exist (also confirmed
by an allyesconfig build and decoding all ~7000 mvcos instructions).

Fixes: c488f5187a24 ("s390/uaccess: Shorten raw_copy_from_user() / raw_copy_to_user() inline assemblies")
Cc: stable@vger.kernel.org
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/mm/extable.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/mm/extable.c b/arch/s390/mm/extable.c
index 7498e858c401..848855da9a70 100644
--- a/arch/s390/mm/extable.c
+++ b/arch/s390/mm/extable.c
@@ -106,9 +106,9 @@ static bool ex_handler_ua_mvcos(const struct exception_table_entry *ex,
 	regs->psw.addr = extable_fixup(ex);
 	insn = (struct insn_ssf *)regs->psw.addr;
 	if (from)
-		uaddr = regs->gprs[insn->b2] + insn->d2;
+		uaddr = (insn->b2 ? regs->gprs[insn->b2] : 0) + insn->d2;
 	else
-		uaddr = regs->gprs[insn->b1] + insn->d1;
+		uaddr = (insn->b1 ? regs->gprs[insn->b1] : 0) + insn->d1;
 	remainder = PAGE_SIZE - (uaddr & (PAGE_SIZE - 1));
 	if (regs->gprs[insn->r3] <= remainder)
 		remainder = 0;
-- 
2.53.0

