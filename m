Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A0F466B57
	for <linux-s390@vger.kernel.org>; Thu, 10 Sep 2026 16:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789057154; cv=none; b=sparsp5orUvwBbZtVU/aMntvfu2OmwKwXnAoK0FmlOw5K/HenmaQutJNqS0Dqkn7fit5ebELyA9eNo03ZQNurBpjsNpKIvrgngI50wHNSw44XHLSa18HpYDwr+uowR+O28S+eEUBU0OVpPPqilbrBdd1Mm9E13I1wSSP/Yka4GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789057154; c=relaxed/simple;
	bh=nUM3oj5Yyhrn6OXpKzV8dJt/omJigjU36GilOvTJVdA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ikyhpSg/ct+HbFy6edlQ5GcD+6eSAtYJH97hNa0yTeO7z6v0X8Dh6pqJMR1QvvpTUzGIqCEna/ndjQLAYZqLSAJ8MWYnog5OrXSIi6Vb+9OnHyCTiWxiV0j4TlAir4YIZEdR2r4s7hTM4GPZipX1oMTqyzLA1OdXCF3JC5h1wMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JthloTeI; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JthloTeI"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68AFCr1t1372458
	for <linux-s390@vger.kernel.org>; Thu, 10 Sep 2026 16:19:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=Z4Y98GUvGpntBKN8/a+pWlFd+VFMzPyb/Ee6kMQKH
	Nw=; b=JthloTeI+qCpWMgJ58ih0wT3X3xvyyf71Fi9dOWotojve2wKA95/y7xU5
	7hgCgn3ZRoEp+V/H6K2v8wCyQoTbQe1UrhyPS/JvmfHwmh/IRbQwPRgHfrryuxdQ
	kZwrOzQra7EO+X6yNUPp6NlpgPBC4wmqNmYbKOag/dABvMu5rh1V2VzgqUb2T63i
	jyjKKcqU+Cf9sMcQrBDdCZi5vAPU5RS/alQG73y53PCIbkkRJIMRQaQANZHL1mxf
	VyzP5chEU9qxNyymCb9b3efhBowLAmdEMJVQylucUt47qywgQjmhqpw6FNCZsK3m
	nbPHGqDBxUT98R7pcj9fO4oWrd0ng==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gkd8n5xkd-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 10 Sep 2026 16:19:11 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68AF7uiK202001
	for <linux-s390@vger.kernel.org>; Thu, 10 Sep 2026 16:19:11 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gkvq2s5u6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 10 Sep 2026 16:19:10 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68AGJ7W653608874
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Sep 2026 16:19:07 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3016620043;
	Thu, 10 Sep 2026 16:19:07 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 99FB020040;
	Thu, 10 Sep 2026 16:19:06 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.139.154])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 10 Sep 2026 16:19:06 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, fcallies@linux.ibm.com, ifranzki@linux.ibm.com
Cc: freude@linux.ibm.com, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH v3 0/1] Fix and improve zcrypt reply message checks
Date: Thu, 10 Sep 2026 18:19:05 +0200
Message-ID: <20260910161906.36251-1-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=NMVAaE6g c=1 sm=1 tr=0 ts=6aa2d87f cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=A0JRhSI_t6n0dhEY3XcA:9 a=zgiPjhLxNE0A:10
 a=zZCYzV9kfG8A:10
X-Proofpoint-GUID: VYy_T1cAEnxQismPnyjbOemLsPK9uEqD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDE5NSBTYWx0ZWRfX7+Rj6hwuq/bx
 NPcSHraiuAfApe5yAuEzZx0L2tg3cRH8PI42t6rM+O+Yi6/WbzIx2w7S7WXsjpnvR7YzgD6L0iU
 FlclGDgd8f6ZCYMONA9Xfje95lBQj0mzLNJWBS2oyeQXAfZnJ/h0aeSqR1BSdehGyqh+KGEDMdL
 FQn7p02m1DHIqKo6hNgh7AMiHu7E0Sdq3dq9LDI7KgGr90XtcHqUSS5R3sHcChQqLiKoPCYu5sE
 RJzFqqkDxJxoQCrLa3Z6wbPTFpixTkyNzbBipPx+h/gpEz0lN1AAHX945rmERDQIb+ey22fdcQf
 L8xplGTZOjwLcKX58DnFDJZvIZSl713diLG1Df8KMgAk0zoCUbYgbXitE8QQ2OHThl+WMeZlKJh
 y4EwY5to3QkoSTyuxQxbEOrRWYwPRY26VGg6W/z96d7LaLKeFJG5xHcXxOHTwkDGmhC/rbrwp/t
 GVXeqyiH19k1PS5vYBg==
X-Proofpoint-ORIG-GUID: VYy_T1cAEnxQismPnyjbOemLsPK9uEqD
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDE5NSBTYWx0ZWRfX/4uP8ALDJ5m4
 iBjpWDZlER6L6vVQlaKaXtLXmcon4MH8Mi9a1Ce+HUGknUNdQcddouJCnvF4nltfClhU4vvAlSq
 bgBIhrT0gyOijM7PqaM2DcnP4JXTN/c=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_05,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609100195

Fix and improve zcrypt reply messages checks of type 6 - CCA and EP11
- and type 50 - ICA.

Changelog:
v1: Initial version
v2: Sashiko complained about not checking offset1/count1 at all if
    count2 for an CCA type6 reply is given. And a check like this was
    in place before the rework. So now offset1/count1 is always
    checked and only if count2 is non zero offset2/count2 is
    additionally checked.
v3: Again Sashiko had some complains which let to a broader review of
    the reply processing functions. Especially the zcrypt_type50.c
    functions convert_type80() and convert_response() got slight but
    significant improvements - and also a mysterious BUG_ON has been
    removed.

Harald Freudenberger (1):
  s390/zcrypt: Fix and improve zcrypt reply message verification checks

 drivers/s390/crypto/zcrypt_msgtype50.c |  95 ++++++++----
 drivers/s390/crypto/zcrypt_msgtype6.c  | 196 ++++++++++++++++++-------
 2 files changed, 214 insertions(+), 77 deletions(-)

-- 
2.43.0

