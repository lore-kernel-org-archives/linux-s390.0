Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA3E381E95
	for <linux-s390@vger.kernel.org>; Wed, 19 Aug 2026 09:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787131074; cv=none; b=E7Es5piQIW2KYB7W1R7OujWJUsExIS9oCLWHi6oxrI6ViZw1mpz6gkTSRUJ2yHsQp5TGlRH46gWi2zxyoc1fmvxyqLufdetQ1zeXP7z5t427E6t7maGfYNtnwfATkQ3VB58wLUEJhaSO8KErwDP10/BNnBC8ksPZvl8W4Ls9qxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787131074; c=relaxed/simple;
	bh=LUFJcedcUarmZ/aWuqtUQw1wgDu44yRqq5Df7k1kJh4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Va6jJdhFemCXh8A9mT3vWU3Mhu3cB9cLXiF0nnWjeYYMcX0sJNsSgz3pWfi71N9BtANMkkm3uBHq/wIkpWz0uHl7H01yG4yOvlLIPlaD1QFkWbNaWGPXY5JkgypLg2lZi0LHEdBLNKp6TMJpJ0mGZGHgP209sYEgO7nf6zi9Dao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=K9gHwPMn; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="K9gHwPMn"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67J6WZAX1545680
	for <linux-s390@vger.kernel.org>; Wed, 19 Aug 2026 09:17:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=71sbkMOMz+2dfj4fp
	ebeowJL8APGigbmWCPvl5qD1tc=; b=K9gHwPMnlCeyi0sZlmeBqxI/NUIBVHnIS
	qWB/zo19xPoo7J8GuT+SzmCuy0w/zDggQPSdmYCmKC/WEtFfU0vAQ7F7lK+JFn0i
	Zex1a+W/yMYeqIt407rKkzhTrq+jbRk5rKvniwcp920QQAExCZwan3pnV7zke4FX
	G5aOIW5aIgmed3JK1WEXoydUIgZlNhv0UVntfpURwbLHjPVZqiIribx7RHBTuZrR
	BsvvlvCkJNckN/WrZpn1MSCCV7XBC6fGzh2+7lIGkXlwr1jyyVJU9BgEqLug/3IN
	eOpKcA9GAwYIEer5C918LiuKDPHGWVH+8tSD5rWXka4gmtRTJTORA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu22pm8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 19 Aug 2026 09:17:40 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67J9BSLD032723
	for <linux-s390@vger.kernel.org>; Wed, 19 Aug 2026 09:17:39 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g34ngfwtp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 19 Aug 2026 09:17:39 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67J9HZvU51315080
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Aug 2026 09:17:35 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8A0DE2004D;
	Wed, 19 Aug 2026 09:17:35 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6AC882004F;
	Wed, 19 Aug 2026 09:17:35 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.129.41])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 19 Aug 2026 09:17:35 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, fcallies@linux.ibm.com, ifranzki@linux.ibm.com
Cc: freude@linux.ibm.com, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH v4 2/7] s390/crypto: Fix missing scrub of temp buffers with PAES algorithm
Date: Wed, 19 Aug 2026 11:17:29 +0200
Message-ID: <20260819091734.7331-3-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260819091734.7331-1-freude@linux.ibm.com>
References: <20260819091734.7331-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=AdqB2XXG c=1 sm=1 tr=0 ts=6a8574b4 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=xgcJR-P8mceqExzzGMoA:9
X-Proofpoint-GUID: ffQ4w4i_03YEPw342TsWd6Q1dFnLfpCl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDA2OCBTYWx0ZWRfX64btcPlOsc6P
 XracmfP3WL2rWycJZ/IMds5aGW9tVUtnUZSRLBBuvjjoKLZT9I6Efn3kcWN0pCixrxk0RFgeYzM
 M623/EF+OzNw4Av0bhjWvD8PZ3z5oAdYd3y+zZlRhzeYkraLey+8JEdo0at1ablAJjGZvsQ8CiP
 ip1Buo7ULkdxIZ64b0B4bQl68SKcILjMZ1NTEw4phac0OFn3XqvvZ57T4M9Cp6S7zx9/EdKHdL1
 umQ8BIAVlSX91QaxhQYj76l3apP9aJIYclgVR7jgE18MjqiAcW/AgFfUpdAo1DL5IMeV9Uf1nuS
 eFuTNYeNCV7hvpCtg8/nzplqOKhTNeh5j8czAYR1SkVHfGgZOMQBCItYAjBQz3aqOgK6a8BR45H
 z40S/JVlwBp1GX0jwPUf0U/YfjihIsI2LCCy7xgGnkEAXn/RMHSgR9wWXTwSL6KbO/tIx6qQld6
 m25EpDhjeQ36hTkzZgw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDA2OCBTYWx0ZWRfXwZm6JhDJgl16
 nvDn7W8nTHDeRZQHxHdXNJjFzfPNbN5AzNiNCh6y8ivf8uKwkirrYJ3+Mtrp0cdfKqvt6WOFPS1
 5axN8UsOAWL4naw4wZx9/cvEpNJzzCQ=
X-Proofpoint-ORIG-GUID: ffQ4w4i_03YEPw342TsWd6Q1dFnLfpCl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_02,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 malwarescore=0
 impostorscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608190068

In function ctr_paes_do_crypt() there is a buffer used to process
remaining bytes < AES_BLOCK_SIZE. This buffer was not scrubbed and
thus could lead to expose of unwanted data. Rework the code to
explicitly scrub the buffer at the end of the function to avoid
exposure of maybe sensitive data.

In function __xts_2keys_prep_param() change the existing scrub to
clean the whole param block instead of just the key field.

Fixes: 6cd87cb5ef6c ("s390/crypto: Rework protected key AES for true asynch support")
Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Reviewed-by: Holger Dengler <dengler@linux.ibm.com>
Cc: stable@vger.kernel.org # 6.16+
---
 arch/s390/crypto/paes_s390.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/s390/crypto/paes_s390.c b/arch/s390/crypto/paes_s390.c
index ccc7da106c3a..d075b0241f1f 100644
--- a/arch/s390/crypto/paes_s390.c
+++ b/arch/s390/crypto/paes_s390.c
@@ -1044,6 +1044,7 @@ static int ctr_paes_do_crypt(struct s390_paes_ctx *ctx,
 	}
 
 out:
+	memzero_explicit(buf, sizeof(buf));
 	pr_debug("rc=%d\n", rc);
 	return rc;
 }
@@ -1377,7 +1378,7 @@ static inline int __xts_2keys_prep_param(struct s390_pxts_ctx *ctx,
 		memcpy(param->init, pcc_param.xts, 16);
 	}
 
-	memzero_explicit(pcc_param.key, sizeof(pcc_param.key));
+	memzero_explicit(&pcc_param, sizeof(pcc_param));
 	return rc;
 }
 
-- 
2.43.0

