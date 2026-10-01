Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4572B3E40E0;
	Thu,  1 Oct 2026 10:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790850795; cv=none; b=oyq75oXnwZztz/rjimKq8XSsBT7dkVDhYJ86AlYbm6+CGpKLf8UzMADNIm5FGombwVFxd2epFG8FAwN8GGKgrDAh9jehcTw7eqqvzxLJ2rhCtig5bmCh/prWxDsu7cUfjIFhU35o2VWZ/3dGpTO3wS/FhJqlDFyyvqPuBugWAJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790850795; c=relaxed/simple;
	bh=PP6nyt0wGHOhvV3ksSf2vLjwy/+DS1fIKW3b/bOoVOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T9ha9ryAT8H12df56KG5Bm8kimtHkywD0NKz+qj+Q/rfEFkyjR66HD7XcEOp0TARjfl6/xfMwqESYnQ+hjhQ7Gxg/8Rmt4ON7N++rU0bSOZbQcK+H1sWenINPhKCzyEcA8+mkmCPLf9uqYG5Wcs8fX1lm5qStFPrfoGYqtZrcW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HLAoNjmO; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HLAoNjmO"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69175tY9908228;
	Thu, 1 Oct 2026 10:33:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=cPvIyCcUx2rNVKcmg
	vohDRagoCFhvRfDUy6qOnjQHNg=; b=HLAoNjmO5qJ/PSdZSdFKw1A+LtTy8QOef
	gY+wd2rW6kguwPP+Sua/ScGlzXB+hovce/6nvQjLg+7Q9XcVSBg9Yvq6C7+lIqHO
	53LroW+QK+V54Tox7ufBHWMyB7r62FrpgQanyuQiq/yEG41xssy3Goyq7EolDlKU
	B12RCTMmfOOxsXiubLstTNfCvEOZ1G3+BoYTWYWdd5iDvA1KfIazQuYagnzfd/G8
	QDyEMXZmm91Nu3WtlNLvi7uFljRc6zWZin0wXwyRLzSL1wiH0LtZZ46tERjklgNa
	OYVIyhb6O5ElQ3LApC56pLjRbs/3ZqTfIvvakRJyy9+uMYXsfT5sg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx3fkhsqb-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 10:33:00 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69172Vo0589646;
	Thu, 1 Oct 2026 10:33:00 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h1aa7tf5d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 10:33:00 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 691AWujX36897186
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 1 Oct 2026 10:32:56 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7CBBB20043;
	Thu,  1 Oct 2026 10:32:56 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 36D3A2004B;
	Thu,  1 Oct 2026 10:32:56 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  1 Oct 2026 10:32:56 +0000 (GMT)
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
Subject: [PATCH 29/32] s390/diag_ftp: Convert inline assembly to EX_TABLE_INSN
Date: Thu,  1 Oct 2026 12:32:44 +0200
Message-ID: <20261001103247.1989111-30-hca@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: j7_Vwfl6wpKdeWVEoJqr7UokRZsbIeKB
X-Proofpoint-GUID: j7_Vwfl6wpKdeWVEoJqr7UokRZsbIeKB
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA0MCBTYWx0ZWRfX/czVBxehYQOl
 bLk1egvTJWR1HzOl39orkMuKxB2SZbVZikHGzL5bzn4uLX/Wm1ju9wbEXm1PuYEqwPZ5kERh23M
 pXK1Lzfdpds0S4umwkod1HG1N2glSIc=
X-Authority-Analysis: v=2.4 cv=Vv62kO2n c=1 sm=1 tr=0 ts=6abe36dc cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=bn0qHtRZzI42D2Z6gEEA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA0MCBTYWx0ZWRfX+or6W19eGW3m
 AsZKXQFNkf5mGhqWMveWfjagWg/5gO6PFklKBqez/Nl4PEBaMso4lfyb7O9Utx7fRrEKREHLs1C
 JShwXlTTpZITTefzMak2fcft5ip6nuCdNcVRuwhGFDrsPoAMNxJXhD7zsf/F2v7JX2iC0Xrv7in
 amu5JrqoIUk4BNOII8qx5G1H+RZSARiypFtMH23gH8xOg4UH1eaPEWLOLH8k7zGzKg9g44SML33
 jFD8dxruokoxQgBrT5bjU4kRQNqZSmVOeBEVfx3q5002jjZm8o89DSCzruS6ZmllzMjqGqre1P/
 bYz5r1p/EBBkhQwsc1J5ISBr6dVKQwi+nrQmFsGmo8IOqd89UhxapuDvk+1QqxP00XdjIA0qOMb
 rJF5tWPbDWHR2UxfuOxpgTZ06Nh8nHZII0p5XejhsafuO9h9EciDtizX/ayReMltHKVMm5Zo+S4
 TW4Vhk5JysSsHqsbwyA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610010040

Convert the diag_ftp exception table entry to use EX_TABLE_INSN.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 drivers/s390/char/diag_ftp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/s390/char/diag_ftp.c b/drivers/s390/char/diag_ftp.c
index a1e110c96f74..0a506559799e 100644
--- a/drivers/s390/char/diag_ftp.c
+++ b/drivers/s390/char/diag_ftp.c
@@ -106,11 +106,11 @@ static int diag_ftp_2c4(struct diag_ftp_ldfpl *fpl,
 
 	diag_stat_inc(DIAG_STAT_X2C4);
 	asm_inline volatile(
-		"	diag	%[addr],%[cmd],0x2c4\n"
-		"0:	j	2f\n"
+		"0:	diag	%[addr],%[cmd],0x2c4\n"
+		"	j	2f\n"
 		"1:	la	%[rc],%[err]\n"
 		"2:\n"
-		EX_TABLE(0b, 1b)
+		EX_TABLE_INSN(0b, 1b)
 		: [rc] "=d" (rc), "+m" (*fpl)
 		: [cmd] "0" (cmd), [addr] "d" (virt_to_phys(fpl)),
 		  [err] "i" (DIAG_FTP_RET_EPERM)
-- 
2.53.0

