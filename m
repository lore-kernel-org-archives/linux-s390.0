Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9B33BE155
	for <linux-s390@vger.kernel.org>; Fri, 21 Aug 2026 08:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787302017; cv=none; b=Gqk2uyZhBpxUVWLUx6LgCHfDh4ifjlRClZnoPz5Pt2ON9tN2ZvWVLYcYN1e81mFvEN3SfHIH1DJ5IxseVNPfOsEAJOovobc5jSBmRh6MYwSPJ2v00Xav+KFDU1V+vukTfX76IW2FtPaXTBXxsfpfCqt9j4/xundBJNTfkW2DpkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787302017; c=relaxed/simple;
	bh=LUFJcedcUarmZ/aWuqtUQw1wgDu44yRqq5Df7k1kJh4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LnFWiEQQjqx3hp0wPnyAV0djTqyXOmgYPsjbBPTPbuHGlPBc5T4xxokWziXsUMSMpjsXC5n2m9uRaj2JioJu9o6Hbyf3bIgK5ZftRDCuPkls7rVYsq2agXbQAkaB2i5JLEbeVZNgP63R0R6ZaKzKZMAt22kD+RCoJH6wGgKj9M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QmPgkbTD; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QmPgkbTD"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67L8WpFg864639
	for <linux-s390@vger.kernel.org>; Fri, 21 Aug 2026 08:46:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=71sbkMOMz+2dfj4fp
	ebeowJL8APGigbmWCPvl5qD1tc=; b=QmPgkbTDIpFX711RIUGCUxNf89W9yj5iB
	MlNAi6c/tPUoSDsCUtyfnDW7KOh2PyddZJQLzMn7B3QGHhgwbloqAGoxFHbUx/yx
	F67t/VWoqCUX6+QjMeHQ/B0CbJtNqGkwhUn+175ERUN4ez0WV/A63g31yb9fT7no
	TV6U8OoEHd2OYe0vUxG5fuaG5DB4dfh2GNTcyJcyBiCLpRx0ntyAo8A0cO0HnlRS
	mRGbxFpGFCVQjtaz9RD25DKOfmnY286oI121xurb8f0IVxdsrpQRIGocIxiorblb
	WZKUWurYaHxOLoLQPmAzd7Renw0WH9T8PuwlVb9ux93nroNoIGYeg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu4g3kf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 21 Aug 2026 08:46:54 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67L8fjRT021806
	for <linux-s390@vger.kernel.org>; Fri, 21 Aug 2026 08:46:53 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g354yuavm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 21 Aug 2026 08:46:53 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67L8kmv352035876
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Aug 2026 08:46:48 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9D14320063;
	Fri, 21 Aug 2026 08:46:48 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 824952005A;
	Fri, 21 Aug 2026 08:46:48 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.162.88])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 21 Aug 2026 08:46:48 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc: freude@linux.ibm.com, linux-s390@vger.kernel.org, dengler@linux.ibm.com
Subject: [PATCH v6 2/9] s390/crypto: Fix missing scrub of temp buffers with PAES algorithm
Date: Fri, 21 Aug 2026 10:46:41 +0200
Message-ID: <20260821084648.23222-3-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821084648.23222-1-freude@linux.ibm.com>
References: <20260821084648.23222-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDA2MSBTYWx0ZWRfX+XiuU/EClCDY
 vKbzjay2rQJl2IYNadgY/3hfYu5BQifZRzQYV+vsF/nBuTO3oDOHGAhPLHllvuMGQBXHiGynik5
 LEO4VBvoJssYf2K/qD9zUr/UYZasgkM=
X-Proofpoint-GUID: vqyUqK5fSkWZH_lmMcWZ0E6Hguv6FueU
X-Proofpoint-ORIG-GUID: vqyUqK5fSkWZH_lmMcWZ0E6Hguv6FueU
X-Authority-Analysis: v=2.4 cv=RPmD2Yi+ c=1 sm=1 tr=0 ts=6a88107e cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=xgcJR-P8mceqExzzGMoA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDA2MSBTYWx0ZWRfX2mw0Bdh/zGPu
 QABS5Utnj5WPayq0+BjY6PiGKj6rvrcU8SZPp0ArXPVP5DrId9BEbu9gGUuLBYx/qKKTBSiEje2
 Tee6/B68OHfSMHNePkX6OKjgth1by82N02n7Mq6HNYALa5CWzHkbFjN9dhvSKxYfozDTbLFW/ob
 h1a2dIufqQ1ycyCdUvjptSH1NwxoxpJmaiP90bh3Hp2mMVKrQ1T6ZAlXTqTEwfpab8t7+oeuDHi
 aWqMAtebaXWnOx2J10GknmscicVtPTSHgoMhb9JKEn7gSJh5X8ci/Dr0Pbo0Kf6QabfvYPlF70H
 kwAi8S/oDNXi+d6XASnKv4AREWIMOwexllmvyxAyXr3XKzAACpkKAbviJVdwW1fkAHbDeuct9Ng
 zq0nfwVQSQR66J3i5c6sEtrUB9Ic8vt3hu2bP+pNAUj/92SCThFmszvOuS8HFF/qV8b++1EsYGJ
 0RZsLP59fciYW/eIfDA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_02,2026-08-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 spamscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210061

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

