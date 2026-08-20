Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390BF47604E
	for <linux-s390@vger.kernel.org>; Thu, 20 Aug 2026 14:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787235609; cv=none; b=E+vf35aGDyXBSFQJ7hYDbO4jna96EhcZDNsPyyHSGeaiDJIAoNTj8tQ73QkHvFyjE3Ddu+UjpJ89GUjVGJiMT/Gp/W1lMZDlhsTcE6v3bEIgDAFPh00yvHJ86CsEkK26J2I1O7H3nWyxD/mlOkTDfy8bjJX8vydiBI6zaRy/sLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787235609; c=relaxed/simple;
	bh=8agOoxlag9epb2/N7sdkkEGwASLPAv/IFfHpz9q6Hrw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B7EVS1EA+9sreWu9mNOueoDHfomwT7QIljW5hP+5UQaNQjUszTobwPVhqXBY8eH1QNbg4fVZ+7ZLSVt40X2fwMEnk1ssK97Y5PImG4atFhoqQupsQbQkx/pXMfrAC9pzFfKoLYmcYDs2UZY7P52aiiHGnW9BulAEUb2/Rl2szPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UJ/ukkwU; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UJ/ukkwU"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67K8bVIp3543726
	for <linux-s390@vger.kernel.org>; Thu, 20 Aug 2026 14:20:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=tI6hz/FTvzVvvACvU
	axYZNjb8OllCOVPMO81a3g3PWw=; b=UJ/ukkwU1KeuORFym9zq1wOxu5/CRigWB
	827jXDMXksqczF8R2P7p4Umb0Xrv8dUHPyuNl+fNnYCgFfTOeI20WYT0ltMNVZMG
	/hOYtfMmaMDgCqOLwFVFqhQw0fB7KJYWYO6v9SienYkfRwUinMDrhKnJBkafi5qo
	ZJNqwPgpC4PEsKRZhWNhzdyu4TMnofe/Xosgj1sHmMcuHHda/TaEkOe+8u8LAqFV
	CvwqfIaulCN0G1RVC+wJB2uZVYfYuvoznvRRs3ij5A68kEWHBf+ZAkNILyrNxVUk
	UbKyHLazFc+HDrvmYni2AYOXrzA2JoXjRhzbT/ZoPdInIAeCJvHgw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu2aqxd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 20 Aug 2026 14:20:03 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67KEC2RA002742
	for <linux-s390@vger.kernel.org>; Thu, 20 Aug 2026 14:20:02 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g354ypqk4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 20 Aug 2026 14:20:02 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67KEJwvY31392390
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Aug 2026 14:19:59 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CC1BA2004B;
	Thu, 20 Aug 2026 14:19:58 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AAC9720043;
	Thu, 20 Aug 2026 14:19:58 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.194.245])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 20 Aug 2026 14:19:58 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, fcallies@linux.ibm.com, ifranzki@linux.ibm.com
Cc: freude@linux.ibm.com, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH v5 8/8] s390/crypto: Map EBUSY to EIO when key conversion fails repeatedly
Date: Thu, 20 Aug 2026 16:19:57 +0200
Message-ID: <20260820141957.19091-9-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260820141957.19091-1-freude@linux.ibm.com>
References: <20260820141957.19091-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=AdqB2XXG c=1 sm=1 tr=0 ts=6a870d13 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=Fr3jCehX831DqKRPnFkA:9
X-Proofpoint-GUID: SGWr9Ks-PO2Tz4tPvEgxTfx3WRc8fO0b
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDEwNSBTYWx0ZWRfX0r0QzvFEWz8i
 OGvwIOgw/tIzFYUJBslNXpPsq+S1uP0hhkYOe0waZKDiSEqUtn1ssKDHgkl6hKCt05BrGPfrhtj
 IhiRfhbgSgxH5xdmYPplXZYMvOVj1nkLDQGo6FXAWfGZK+sqHkIhdrGaO8y71DKneYm8q8AETJB
 Qw3JNenDeA7nHXtIh2R4FYwhVoZ/gM+nZ6kLdphSjpqUmIcXJjtmJiY2rI0KGwo6JtF6DlbWh+j
 Pm/b+a6WElmfpCBEd/47JkDI3r8ckVjs73DDRLXp6M9b9kdfbHhFvmZTcaRz8YYl9dgOu1zZ6+8
 U98M14tEYAKHn+M3pi/LpAU7AlBTQDUzOlOr48RChYJRghjM/11xWZ+dez7IkpP/YNlGtuOmnnd
 +u/F2Hm/nX3R5b6hoLRpOwimVmMfQ/lIFQv0N0AH88s/93s0ul9k86zsx77n97cWaDmS0GVDH/a
 EyVPBWS4DMjMg0qLCcQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDEwNSBTYWx0ZWRfX6Ew4Lt80v7oO
 HP4UfxIvGK6hLjSpiqYHevoYUjBCX5eR6NGB2d0HX0R7Ujs7iAWLdBMaKVKO+X0adD2OyQWF0CY
 LFpbeo6PL0YUWol8EBo7Al6E5gymris=
X-Proofpoint-ORIG-GUID: SGWr9Ks-PO2Tz4tPvEgxTfx3WRc8fO0b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 malwarescore=0
 impostorscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608200105

When hardware persistently returns -EBUSY after exhausting retries,
the error propagates to crypto_finalize_*_request(). The crypto API's
completion wrapper treats -EBUSY as a queueing status and swallows it,
preventing the completion callback from firing. This causes callers
using crypto_wait_req() to block indefinitely.

Translate persistent -EBUSY to -EIO after retry exhaustion to ensure
proper error propagation and callback invocation.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
---
 arch/s390/crypto/paes_s390.c  | 4 ++++
 arch/s390/crypto/phmac_s390.c | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/arch/s390/crypto/paes_s390.c b/arch/s390/crypto/paes_s390.c
index 0bc360c7ef15..17ef788e3053 100644
--- a/arch/s390/crypto/paes_s390.c
+++ b/arch/s390/crypto/paes_s390.c
@@ -220,6 +220,10 @@ static inline int convert_key(const u8 *key, unsigned int keylen,
 				      xflags);
 	}
 
+	/* But finally map -EBUSY to -EIO to indicate an IO failure */
+	if (rc == -EBUSY)
+		rc = -EIO;
+
 out:
 	pr_debug("rc=%d\n", rc);
 	return rc;
diff --git a/arch/s390/crypto/phmac_s390.c b/arch/s390/crypto/phmac_s390.c
index 89c5fa3dced2..44817c3d25cf 100644
--- a/arch/s390/crypto/phmac_s390.c
+++ b/arch/s390/crypto/phmac_s390.c
@@ -341,6 +341,10 @@ static inline int convert_key(const u8 *key, unsigned int keylen,
 				      xflags);
 	}
 
+	/* But finally map -EBUSY to -EIO to indicate an IO failure */
+	if (rc == -EBUSY)
+		rc = -EIO;
+
 out:
 	pr_debug("rc=%d\n", rc);
 	return rc;
-- 
2.43.0

