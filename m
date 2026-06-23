Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606FE376A1B
	for <linux-s390@vger.kernel.org>; Tue, 23 Jun 2026 10:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782210024; cv=none; b=Q0qRb/NIJZ1yQlJgBLhfv6oF/KWNrx5Lr4PE6lXTemPQOHjjiY08RtnB/2POfdq913jaZ1GYdLcjuEaqitLHE6pNAjUnrEG6XqSe0MJarjqy0GuezrNit2dYGCq1ZnTWUJswp2AHcOYw20Q58tj7vtBNteydz2NJVsOFgSC4Kow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782210024; c=relaxed/simple;
	bh=QhmW2FbnYMqWgIcYQW9pojEfgArMT9Ovg90fAqldYUE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZoClNEQoGTyqk75w0e4ZXDnR0h+QHDiJPknyLv3K+s5/uKph5O+8fGcbc1SvEIf9hKxWEF9PdhPOUnANoKKx4iWNG0Nc0gIN29HDAb9xu8pZXO1L1Crd/1jdW89/wvOt1krFPprEhBjehjDOXcOOwO80UFGIUhDtuDC5otf8H7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RH6utd3p; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RH6utd3p"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65N6mHdl1147941
	for <linux-s390@vger.kernel.org>; Tue, 23 Jun 2026 10:20:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=PqdZ2pz25amqEMvpfxm6JfRb2PWjfoOng7GhTb31F
	VQ=; b=RH6utd3pOe8MZ4CRx4BW6P0MrO/Xo+7lo/muV/1nKqZvYJtJLdgxILkZV
	5l+an/OaIKH7pBmiTFPRynvy46aY0GYvOiL1r2fOW8mMp7eL+x66qgmYnKb+tPx6
	+HaVqyaWm27UsjAa3mPTCIt4TQP1nLZedaShAJ/XfeIenNp2SaJSM9QDsqiypvPE
	r2+ANA++rWZkvVu/fAtWdlzAexluFCqToCjWPLh81zYOqX55mTGud5Ub05T8u/F9
	vEJ099k40JytiJOaHaL4cKW2+0Lb0Z0eIxXLVJAqh7a3Y3wP1QQDs9ai6Ljeb7jq
	x2aie2q+rS3QyokuZWdml+jYgkg3Q==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjk4dwkg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 23 Jun 2026 10:20:22 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65NAJesW028764
	for <linux-s390@vger.kernel.org>; Tue, 23 Jun 2026 10:20:21 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ex6phanhv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 23 Jun 2026 10:20:21 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65NAKH7c44368266
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jun 2026 10:20:17 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2311920043;
	Tue, 23 Jun 2026 10:20:17 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C1DF220040;
	Tue, 23 Jun 2026 10:20:16 +0000 (GMT)
Received: from ibm.com (unknown [9.111.90.150])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 23 Jun 2026 10:20:16 +0000 (GMT)
From: Holger Dengler <dengler@linux.ibm.com>
To: Harald Freudenberger <freude@linux.ibm.com>,
        Ingo Franzki <ifranzki@linux.ibm.com>
Cc: dengler@linux.ibm.com, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH v2 0/1] pkey: Fix for PKEY_VERIFYPROTK ioctl
Date: Tue, 23 Jun 2026 12:20:15 +0200
Message-ID: <20260623102016.3930343-1-dengler@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDA4MyBTYWx0ZWRfXznmLUjUgzLyf
 a5a1wGBk5cjJhawmY1YzWo6pDRAiBTGLlkgLWqP7LEE6VSJ4F7ClKGwaU03CHEhw9MzWEBEK7/1
 WARDANP0lhvaMLFxqtIIaZ3Grx/EzC0=
X-Proofpoint-ORIG-GUID: iX-0w2IL6jG5tMFZOotPxkjhH4ACtqmc
X-Authority-Analysis: v=2.4 cv=Oph/DS/t c=1 sm=1 tr=0 ts=6a3a5de6 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=9NpZT5uGZDCZsRst-LoA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDA4MyBTYWx0ZWRfX6EpTfmJzE8Uj
 PIT8V3UjgDJoarUVhRQc9jr47UcjtY1DucP5jYKUHgPXle+9msNHtRfFc5OgX0GoNV3mfnM2jsr
 SaQcHP5uFyH5Qfb2AbDA/E7dK7k50SZLh7rpRgZLpe7t5wzEHdxUoWULpbiuVKlukztRg23yfTz
 sJKToi5r16mCfHtQ3Hr34t91+A/hlY6hxT/mc4yzwXmj4lLNNwEF7Wpn6ylkadVhJZtxSVCKK9S
 /PsdAER2HEh8ZvPW/JULIJ/ZAyQUkU42sBkojXTijocCLVmVyanBFIseZhpKXMhBoq59umJMQcM
 e5xu4SqC9UYzmRPhjBVHDAN+cX8H+xlZ3x3jdzpu2KfNce2HQIOTFhHpBJuhzlGjzwaSifk6+dn
 QFluUAWBP3KCzk1TtZe2603UFqLSa/PG8QzfOOT+61fnz2+e2JM8X88L2ImKJZ4dwBCAXznkSXN
 YkqGEoIqMQFDgPZhUQQ==
X-Proofpoint-GUID: iX-0w2IL6jG5tMFZOotPxkjhH4ACtqmc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_02,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230083

The PKEY_VERIFYPROTK ioctl is used to verify protected key blobs. The
verification is mainly done y the called handler implementations. The
following patch 1/1 removes the (broken) length check in the generic API
code. The deep-inspection of the key blob is handler-specific.

The v1 of this series has fixed the length calculation for the keysize, so
that the correct keytype can be derived from it. But this is a violation of
the layering in pkey, where only the handlers should have a deep knowledge
of the key blobs. Therefore, v2 now removes the keysize calculation and the
keytype check, as it is always done by the handler.

The v2 has been rebased to the current master, as it adds a missing length
check for the ioctl request structure. This addresses one comment of the
Sashiko AI review.

Changes since v1:
- Remove the keytype check (instead of fix the length calculation)
- Add stable tag
- Rebase to current master

The patch applies to Linus' master branch.

Holger Dengler (1):
  pkey: Fix for PKEY_VERIFYPROTK iotl

 drivers/s390/crypto/pkey_api.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)


base-commit: 502d801f0ab03e4f32f9a33d203154ce84887921
-- 
2.54.0

