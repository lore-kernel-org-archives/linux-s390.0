Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8DC321F4C;
	Wed, 10 Sep 2025 15:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757517151; cv=none; b=mh7dL0Rr6j5iFvf0DNYXb1Ul2HY2ZkrAJ/SCiACxiQdSSs16oDTBwklwSL81vY8eCBWzwN/ldZJaaAWVkcm4hJIowA77X8eu0ibZ5S9X834T3TTrT/MDj5cOebXjTFOPen0Vqp9C8EngH/u2gaUkx7mQzfEC85p6LCntzdO1JqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757517151; c=relaxed/simple;
	bh=fJv13jBpoC8uKmCgvZhfybDn3QE4ZT0YE98S3y/4/v0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZUpN/86MmWBpnH3CeTmX4ddDiT7QhSeY0C3aKc10mkH0WKMrVvWlKtQmpBtle4PI6nyzCxpeKS4ECfitGmGHrjrr4nL9a9Pue0iLFvHtMzv82IP+LGcqwjX13J83p7SBEw/WsKOrk+jW3An2LUWE3LKqEB2aVc27Z8+yFP+gf2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hA+rmZaM; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hA+rmZaM"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ADIVL5012534;
	Wed, 10 Sep 2025 15:12:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ykBuZzk8rSfXiOVKU
	UmpAYZmcQahu3m28c92splTc58=; b=hA+rmZaMLOlzHRazxMySiwtc4k1a3AE8o
	ATwsdk7IN0iZ183LftCRBkqttGlcIVHrR1wzEZhSGyROD6VaWfhlHGEjXANmRPLu
	FJ5SKEvezZQY6Twcx4DD5qH4E+SCC8ZShF7B2pdq88MMD0+3+br9zYY9+oFPPtMf
	/sUYiS3yfqdavPTg0SlzMzLtxQ6QbDYZvbuBtFZCLUwnlr5gv0aK8TzWKRX4Ipvz
	z4FvwuFa7nOeBrGsM7IbjY+6C+3BCIeNafsYkFucHpoVUkbZV1dl9rUdrSVsAHhB
	QPDLXYWFrmShrmwtNElkS0lED4DeUnn3QhOexDjLfUKzfKMnKdUsw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490cfff3ft-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Sep 2025 15:12:21 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58AF24ZL001163;
	Wed, 10 Sep 2025 15:12:20 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 491203gthe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Sep 2025 15:12:20 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58AFCHE950528706
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Sep 2025 15:12:17 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 35A2820040;
	Wed, 10 Sep 2025 15:12:17 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 112092004B;
	Wed, 10 Sep 2025 15:12:17 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 10 Sep 2025 15:12:17 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Nathan Chancellor <nathan@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Juergen Christ <jchrist@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Sven Schnelle <svens@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: [PATCH 1/3] Compiler Attributes: Add __assume macro
Date: Wed, 10 Sep 2025 17:12:14 +0200
Message-ID: <20250910151216.646600-2-hca@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250910151216.646600-1-hca@linux.ibm.com>
References: <20250910151216.646600-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: YIAUAYhLb2lyyG6XlyZXSycdmUv7NWLp
X-Proofpoint-GUID: YIAUAYhLb2lyyG6XlyZXSycdmUv7NWLp
X-Authority-Analysis: v=2.4 cv=EYDIQOmC c=1 sm=1 tr=0 ts=68c19555 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=yJojWOMRYYMA:10 a=mDV3o1hIAAAA:8 a=Twlkf-z8AAAA:8 a=VnNF1IyMAAAA:8
 a=sjXywTY0MiY73472-yoA:9 a=ppDDjHLidN0A:10 a=yTjAz9eSMYQA:10
 a=-74SuR6ZdpOK_LpdRCUo:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyMCBTYWx0ZWRfX08iMdLWYzSuj
 FUV0tTVPegVAFqiWUXxrMbN97CcW3DT0gCd6c5XgmqpRue7dnU3xgAn0LylbH06/O3lh91JeQaG
 0+OIf3uP+Ilp93rCi0k1t2qk375Ra8YzJuJLFdHwPV+oUD/DeDRfoVQXV2jILa0rfvrgt19G1Fp
 /BLtzhMORIMagMAFNFDmji6457+RvNxZ0H8VVWtY9OswFRsmGbf4vzBfMvMYg5dM9kVSl8X6fKI
 ncQcsIFOcMsa3HMMcwuPX2rCK7OUJjotJ/n9pqDMMwHBOFBkhs9+m1XJ9p+E7iRlpUyovPXqi52
 /i+tQ2tcgGzGBrPpbDRQEafZ9llda91ul9lMo7o2++D/sM541/L3R4PH22GFB9H4MVa/CIbPjDF
 kbZgw819
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_02,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 spamscore=0 impostorscore=0
 priorityscore=1501 phishscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060020

Make the statement attribute "assume" with a new __assume macro available.

This allows compilers to generate better code, however code which makes use
of __assume must be written as if the compiler ignores the hint. Otherwise
this may lead to subtle bugs if code is compiled with compilers which do
not support the attribute.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 include/linux/compiler_attributes.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/linux/compiler_attributes.h b/include/linux/compiler_attributes.h
index c16d4199bf92..16c3d4a865e2 100644
--- a/include/linux/compiler_attributes.h
+++ b/include/linux/compiler_attributes.h
@@ -54,6 +54,22 @@
  */
 #define __always_inline                 inline __attribute__((__always_inline__))
 
+/*
+ * Beware: Code which makes use of __assume must be written as if the compiler
+ * ignores the hint. Otherwise this may lead to subtle bugs if code is compiled
+ * with compilers which do not support the attribute.
+ *
+ * Optional: only supported since GCC >= 13.1, clang >= 12.0
+ *
+ *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Statement-Attributes.html#index-assume-statement-attribute
+ * clang: https://clang.llvm.org/docs/AttributeReference.html#assume
+ */
+#if __has_attribute(assume)
+# define __assume(expr)                 __attribute__((__assume__(expr)))
+#else
+# define __assume(expr)
+#endif
+
 /*
  * The second argument is optional (default 0), so we use a variadic macro
  * to make the shorthand.
-- 
2.48.1

