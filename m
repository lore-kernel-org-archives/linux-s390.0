Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E360423784
	for <linux-s390@vger.kernel.org>; Wed, 26 Aug 2026 14:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787753580; cv=none; b=QzrPdSCjpeIYID5+Jg14hebbRzF1axFKVcUgtzvqMpAsbVq0iX1h9ZmED6n3WpecFrNCyNrT5CCd1D7kelOK/rQHt0QLX99aKm7zby6YqdnerZkXiMpfHHpkssZJr0ZdXBD0NYR3I85+hibUPaIHjRxTg7/1TKTklzhyrfoVasY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787753580; c=relaxed/simple;
	bh=Tszi9wN1H38fO5MmzrN8Pu1rwFjhZ/JN/iHKLnw+cE8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pc+1jAqjUQxK4etga/HvJGJ4F4h5+R2xKJ7+suXQTJV0ZZ4OlYJIK0CHjyi2c2Zn6TZkgjS+KWrIRZ3aek8AeBjd7Svj71QelGGi3RW2OLKpy8Mb5s91FRMAgUR7ww1WiVPpRsDk640oYPo5A8pIiAZmOrA79fwkM/snAREpNW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mwmo15JS; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mwmo15JS"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67QE1cKL3084606
	for <linux-s390@vger.kernel.org>; Wed, 26 Aug 2026 14:12:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=cm033VLsWofc3XFyZ45tJ2AtCPudkIy3ryLpCg6yp
	So=; b=mwmo15JSG5IUDE7bORz/ipYjj0SHXvjUkhteFiP1LpxFAYdxlCXJmzGy5
	mYg3h4n9RHHHl1FyW0ThZjUMyXpTwYa5a34/FMJQBswTwF64kAlM5P8kG6RcoR04
	Pgqafit9sR6sjj0aWscvBOB2iLRaTASNaQZy0bwTXsQAniaNdQjshqwwZKZ8+1Al
	xKysW5UHwuy9cLcic8ipknYq5HVraiGKoHjctBOiD7FJrsN0O7SgQD1gEtLi6frV
	JaJBy9KEHzCJ5ZB4Xjv9GBcC8JWW5mzG3+3Nmdjh9WjcpqT0/Kz6sK9mMTJgsLUg
	UpP0j6CTxOFEsptb05VitYecbIAtg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g726eq2k0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 26 Aug 2026 14:12:57 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67QEBLsN024319
	for <linux-s390@vger.kernel.org>; Wed, 26 Aug 2026 14:12:57 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7p3qajaw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 26 Aug 2026 14:12:56 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67QECqSb25690620
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Aug 2026 14:12:52 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C606D2004D;
	Wed, 26 Aug 2026 14:12:52 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A342920040;
	Wed, 26 Aug 2026 14:12:52 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.134.62])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 26 Aug 2026 14:12:52 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, fcallies@linux.ibm.com, ifranzki@linux.ibm.com
Cc: freude@linux.ibm.com, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH v1 0/1] Fix zcrypt handler functions
Date: Wed, 26 Aug 2026 16:12:51 +0200
Message-ID: <20260826141252.113706-1-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=TfimcxQh c=1 sm=1 tr=0 ts=6a8ef469 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=I44unb0yF_DCswbUO6oA:9 a=zZCYzV9kfG8A:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDExNiBTYWx0ZWRfX5xiIBM7a9C5q
 f6S13Upd11oG9PKC8zVaVAT/gwlzFVVPtoN/k65qlnVDTa17l9GBGUWum6Fmt6aB/YxO4s1U06T
 JC6mjN65Rx3rREtcnqmXwE99xFrDk84=
X-Proofpoint-GUID: XYSsp8ZfXbFntu81j6IhQ7eGty08UUBl
X-Proofpoint-ORIG-GUID: XYSsp8ZfXbFntu81j6IhQ7eGty08UUBl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDExNiBTYWx0ZWRfXzpiZz9WFkWWx
 xQXjxe1GWtWBnuLSFXVIfSni2v/TO8CvOfAx32iucV8gji31QLDKjVEh9/+bWGQiT4a3QbyXGUc
 /sTD5CQEZBEW0PGLI4ckAkLPBxOx1OwAIHwThjtlSTJzuXWV8JYsURXndtb9XAR9EgbqD30lsUV
 rF/n5KQFo21ljD13g9qLxVbeTcHN0v1g/vLhlN5eLgc8zLxJNlJAE7wdatnwSC4f9zPnhJNpbqw
 0d1ipi8txrwXQGcsonxkFjqZZKqc5WowxK4NRjap2JGv8Qhc9dOBrfebRGwRT4K/yaHRS+h6B/k
 oCtTxw3IIlhOnhS1ivbhFayQYv5ymPIrDwJvEN2DxLRAsK8w9tSeiBqlXSKwxGHZF4PG8bzfIE7
 AUb3a4lV+ouRfcKr530Hc59C2Q7g6I1QSCA9sXEGm4t8/KdIif8ax3Xgc/1epQ86W4CkBE9WpuR
 O2zK3ZR+KLr1B9ccBUg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_04,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260116

As of now only one patch dealing with a missing initial message length
check on receive of a zcrypt message type 50 or 6.

Changelog:
v0: Initial version, just one patch fixing missing initial message
    length check at all 3 handler functions.

Harald Freudenberger (1):
  s390/crypto: Fix out-of-bounds access in zcrypt message type handlers

 drivers/s390/crypto/zcrypt_msgtype50.c | 3 ++-
 drivers/s390/crypto/zcrypt_msgtype6.c  | 6 ++++--
 2 files changed, 6 insertions(+), 3 deletions(-)

--
2.43.0

