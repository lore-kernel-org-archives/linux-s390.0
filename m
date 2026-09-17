Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E3B391E64;
	Thu, 17 Sep 2026 19:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789672975; cv=none; b=mJqHhCbbB53hY53Lh1XBGi5f3bQ3OxWx18sRz2IgrFV96a9REE+nc+8NpfqOk2DVLXs4Bka/tP4BiqznuAmo9YJHO+ngjV+9sIvTxTwVWX39Zz+L2c7sM4tIhU57LoBabL73O3LaH+Nwd6hwWhf4Yz2eUbz9cOsGGOmQ5VT/f0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789672975; c=relaxed/simple;
	bh=QuLPXVAFgIJ9fPxmYJemmPvdwZIjvEMVor4YZEw3MJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GSDUuwUIrmElCT/NZEvhHaiNvKWdOjjp+95sHg0jkBdNUEf33w6aLp0MHq31HqD/WWldeQLynASUla3AxkSIQmUtOkDQRXW3TY9VTd5sGSxxvUZDD0KSyC7Lpp+7S46HQ5Fy6tbqF2ox6AF0ZhdXTVyfwX3m4AoW+e3DBAVS4xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Hqf9UKCs; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Hqf9UKCs"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68HHVUrZ3143304;
	Thu, 17 Sep 2026 19:22:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=UbSM4J6q9wHJGxcag
	Fzwg95TRKRs0Sfalw4VwKXSGug=; b=Hqf9UKCsyaWrTkyiSPY6qTCbtlIiXxUIx
	7SNqecuB2OWRkFA4BFiBjVp4tO78RFyQs0FvvDCPIl5mjhPprNvDSSNad5lFHp3c
	MrtGMXpTa2mQGXm4LY0r0Uu5sQCTwc3LA1IflAcdFSVDdBWSRagmMn4OCE6l66x1
	bjKLNCiYHiNguyusfle5L7qU9T34AGz0zznrmpGxtKUDzoWYQZcJlevCVeylx3Wx
	sWAWdDzKf1GwgVugQ2rMf7uEpLU5IvxvmTjqdKjWxlF5tD3GifJ2oaXEWNtc3z4z
	L6z6PLx7m2u1T9YXEyyGZWw7kG7orYidWb8/hRp4+qTASfBM++xZA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmx844d3e-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 17 Sep 2026 19:22:42 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68HH917C3546859;
	Thu, 17 Sep 2026 19:22:41 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gr5ffc0er-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Sep 2026 19:22:41 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68HJMcBN38142428
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Sep 2026 19:22:38 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 263E120040;
	Thu, 17 Sep 2026 19:22:38 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EC0EF2004B;
	Thu, 17 Sep 2026 19:22:37 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 17 Sep 2026 19:22:37 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Mete Durlu <meted@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Juergen Christ <jchrist@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 03/12] s390/lowcore: Remove _AC() from LOWCORE_ALT_ADDRESS
Date: Thu, 17 Sep 2026 21:22:28 +0200
Message-ID: <20260917192237.638324-4-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917192237.638324-1-hca@linux.ibm.com>
References: <20260917192237.638324-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDI3MiBTYWx0ZWRfX6Jrqbjt/05P5
 x8lgyAuL6TOruU/4vtQ4HWDEHYtwNnG7OMtGxRLf3ny/pL/7crNV+XSRQR08xes2rDLPT6OZLUZ
 wCUAZ8kDrdwYlGD9cu3zGeZ8iwREWD+YlLctirprHpcBiUI6/gUj4YT/35/QD+qoTK/0qhrIIFH
 nSqQF4zN7nrRjxTqpyeNS0hJ8uDgx6cesE+CLAlt7flu6jUb+38D01VKQYOvAxbWKMf7z6bS+qt
 0lAg1SGrdhA7N2sv5kLboBhsFjO7q9UnSMQhjpIZj0I2anYoTqS1+lTKZvy8iOuVQshYZk8T3rP
 H9G5Do81/6HjnTFs9Mt2Xkz1CKAWcCOIhDwGZ8H1R+RbrKYsvoKZ3Dq/LQZ8FkolQUzd+csgBDG
 tZjE1LgPC0XPxA+EuXupTin4+cErwFSSNU53RG3IJh8UviE7Q6464xI/WlAXMRNp6QIt642Ss7u
 wwHj3B57/aivuqEXOKQ==
X-Proofpoint-ORIG-GUID: ABtCn93jc2FTv25Uf-pzxWRJLfvAoC1L
X-Proofpoint-GUID: ABtCn93jc2FTv25Uf-pzxWRJLfvAoC1L
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDI3MiBTYWx0ZWRfX4KY2WgyJFvfG
 ICfg8IyDkcWVLJ+BlnDl5heT5bExwt3b24WLgzWpbxz6s8JKnzmgfZTcCibYQZeLY+StPA4zwFL
 nXp4GNKsNf4cQWGdgWZGenlKNOxoQSY=
X-Authority-Analysis: v=2.4 cv=cY9HPXDM c=1 sm=1 tr=0 ts=6aac3e02 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=phCDqYjOjFlr_q_ZZjMA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 impostorscore=0 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609170272

Remove the _AC() conversion from LOWCORE_ALT_ADDRESS. This changes the
type of LOWCORE_ALT_ADDRESS from unsigned long to int in C code, however
looking at the current users this should not cause any changes.

This allows to use __stringify(LOWCORE_ALT_ADDRESS) for inline
assemblies, which otherwise wouldn't work because of the UL suffix.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/include/asm/lowcore.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/include/asm/lowcore.h b/arch/s390/include/asm/lowcore.h
index 5cef215d30e7..f0364a9f8a19 100644
--- a/arch/s390/include/asm/lowcore.h
+++ b/arch/s390/include/asm/lowcore.h
@@ -21,7 +21,7 @@
 #define LC_ORDER 1
 #define LC_PAGES 2
 
-#define LOWCORE_ALT_ADDRESS	_AC(0x70000, UL)
+#define LOWCORE_ALT_ADDRESS	0x70000
 
 #ifndef __ASSEMBLER__
 
-- 
2.53.0

