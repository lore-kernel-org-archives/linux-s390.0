Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1013A6F06;
	Thu,  1 Oct 2026 10:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790850788; cv=none; b=remGCSHHL6Gz33EPz5hu+fiy2mALuxjjMxRjAMIQf2ejBYoOB+yS7foYtGoatV5bhpq7yyaKRx5m8SqAfYKz20KJvCbyxJaRg3UAnEy8OvzqVMcgzLn4UXQgX6AACtqcodUX5+hW9vOez4OogjuEIRgIgO2uSWowWPpx+qL5BGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790850788; c=relaxed/simple;
	bh=7ugPQVzQUgHN7F+f2uxG6rqrBRbhLvHDHQrb89+Pg4U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mNwUMvBatq6IJDMilh7ZGxH6zMJaSHQKq+I9hUdPIkQ0UGVdZ+t6Vc2q4Cv4QrQmLdqyPONQihxScEBFTGoeUtHlaTPaYzLm1/mAxAvwXYKlH3QhgwnoMiIAIF+1EmoDnpVt1AwEe2TohouaNEQmbb1FYAIi54MMMR8OCfDH7r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=n4BgPJ5T; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="n4BgPJ5T"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69175Wrt1086058;
	Thu, 1 Oct 2026 10:32:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=JKMDAPGLED1I8HqrR
	nRbOIFl/MW0e7+zmKWLJbf4XJE=; b=n4BgPJ5TigHTQyeKN1QugeSs7NXK45kEZ
	mNGPlBtbqFv/+dpbk5QSw/m/VV5WF/thic4OtymtT1YVlOzhS16GZd5vt0Gj+yLc
	kIx9KUI6dWEXqsLJmmdqBfYJilev9SDHoyhZiBbYVsigHh/iM/J9qfQsTtihDSnS
	ZyJnKxcbZzq1E6h6Tdr4gLb09xisJEMNiRl1kMYwaC44b4eYWNpKfY420IOPJRAA
	lzFvEXbX5KNrClwgpJO1CGw2LncWmLX0ovIiIbetypQWLuz60Mu2K+S3lb93ZsTr
	LKLna0UlBWU5n+VOg2q1SJYffpYBudG059RKU6VeDMpBYgGs9Bc4A==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5pthch2-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 10:32:57 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69172bbW561244;
	Thu, 1 Oct 2026 10:32:57 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h0g8e8kb4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 10:32:57 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 691AWroi52167128
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 1 Oct 2026 10:32:53 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 865A920040;
	Thu,  1 Oct 2026 10:32:53 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4108C20043;
	Thu,  1 Oct 2026 10:32:53 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  1 Oct 2026 10:32:53 +0000 (GMT)
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
Subject: [PATCH 19/32] s390/hypfs: Convert inline assembly to EX_TABLE_INSN
Date: Thu,  1 Oct 2026 12:32:34 +0200
Message-ID: <20261001103247.1989111-20-hca@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: NhyyCORywD5AA8xksZ_eWyLkTtCdz9GV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA0MCBTYWx0ZWRfXx+kHNmZYUKB1
 G/JdUxgm1CECx+vnwMEHHCZMmpVgsFDPiajaD0clAdJ70v8Hb2Ct3cSp8QX9wjjvDhqbmcCozI2
 uKx8IvS6rxj+KRa5uGgyS/2QS9R0w7iZzetukvdnqR77eyQlMvZkmr15Wc0OxmaECvBhxcDOHsd
 xkhyKmtTOdk+M10QEKZ8e9CfD61TI01byO2BHZd5S84qQwm+MU75nkB6DYNhLU/uZJ4ywr9XBtL
 XF3ljo4O3XwyfgaMx5tXSQBTTpUn4MzwYGz4aT42HH81IH6l5xXy0oIvR8fDQG40ASKTNFptrTQ
 tlpw1TOsvD0dT2i+QB8EPfZV4gXnzNHppkdwS4yOW/Xw0zPfeCE6+FZhS7UqeVrXjAMy+MyyHsU
 XK/Iwxm0dhwNB2Cj/ovkrEr5nssvHlmKgRuzWB4YctjnNuWJDMzq6uokbaoS772eHRPLUE17Y4E
 eMZTI60yBUV3tXAZhUQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA0MCBTYWx0ZWRfXzu470kGvj8w4
 rvbWuEqZQyegQmoLFYlthw4mu2Tzz0N501ZZwD/TfxHp1Y+jhIBNcoedk6tDKKawatiG82iMacO
 zUn+IOnxN29gZpVFYlpm9fkKA0kxnt8=
X-Authority-Analysis: v=2.4 cv=EY5d0/mC c=1 sm=1 tr=0 ts=6abe36d9 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=Ks4RsKL_jdTqRf1ktGgA:9
X-Proofpoint-GUID: NhyyCORywD5AA8xksZ_eWyLkTtCdz9GV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 adultscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010040

Convert the diag2fc exception table entry to use EX_TABLE_INSN.
With EX_TABLE_INSN entries always point to the faulting instruction,
so nopr padding is no longer needed and removed.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/hypfs/hypfs_vm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/s390/hypfs/hypfs_vm.c b/arch/s390/hypfs/hypfs_vm.c
index 4db2895e4da3..bd47fce59731 100644
--- a/arch/s390/hypfs/hypfs_vm.c
+++ b/arch/s390/hypfs/hypfs_vm.c
@@ -42,9 +42,9 @@ static int diag2fc(int size, char* query, void *addr)
 
 	diag_stat_inc(DIAG_STAT_X2FC);
 	asm volatile(
-		"	diag    %0,%1,0x2fc\n"
-		"0:	nopr	%%r7\n"
-		EX_TABLE(0b,0b)
+		"0:	diag    %0,%1,0x2fc\n"
+		"1:\n"
+		EX_TABLE_INSN(0b, 1b)
 		: "=d" (residual_cnt), "+d" (rc) : "0" (&parm_list) : "memory");
 
 	if ((rc != 0 ) && (rc != -2))
-- 
2.53.0

