Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87FE1D619D
	for <linux-s390@vger.kernel.org>; Tue,  1 Apr 2025 13:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743515019; cv=none; b=TNthUs1yn5PH23o0AUD4+g8HXcFgIwFjLSq45SyrNFVpLzuMia9Z4y/8U49Lm4G4OfggevppDXu8eg1A/QQuDmBflbMLSPxVFMUF9ODdhQa1SyULOwmj+hm0LRfXlmm9DJNoXJLNHRfs0uw//22NcTSZ9R87iGsxpuXf32vIN9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743515019; c=relaxed/simple;
	bh=pApsc8J7ORt1Z6BrqXC98wcdycahuySfjkTpZVn/gHk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ErUUNTvSayqrnysQwjKr3+JgYCJC0Pc5Xvx/T0AgLx6GX3TwHI512jt5M+GKp/dxBaJyiz1Jo0xmGO54k6DI6DRCNunudfTV08lFmU/IaMl4Qx5gfxmEFOI67bY+J0f5sPtCCqyR5d796szz5EYcvQElUkO+1Y5E5tbVqtzD2cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=S3kL6mET; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="S3kL6mET"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5319QQun030246
	for <linux-s390@vger.kernel.org>; Tue, 1 Apr 2025 13:43:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=kLxnjU/cCcxTiLqcGiWuebmnPPKoJEFofacOysl6I
	5s=; b=S3kL6mETwmH/lD0KPP+rHXyllSdHBVXHyonRCE5BWN0HfXNgHcV9Rif8Q
	RvPuPKNDvwdOpBauJKwjwqyjoDBtDdPz8MnVEEHivA0JBCk1f8uTV2Dm8qR0RONT
	zYKhISK/cpaOX9pWp8frTdKTXBz7AgE3EEqRNRZO3+AY+k7tVoC/rSL/OP9qZhAJ
	v+CTBPqjONpBIMi/mEQ4KsOWziXLSkGEXtm5fy8B4voc7iK4Ew5SuB6eEprE19PT
	lTkWQwCr1dAcZbtnIzTSeDtFnQaPbPHLo2EZtNcBXqQoezNc1aafQ6HardlBY5A5
	7W46I1TIXhM+NCBFdMH/xuUDaYcjQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45r27q3xd3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 01 Apr 2025 13:43:36 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 531CeMsW010272
	for <linux-s390@vger.kernel.org>; Tue, 1 Apr 2025 13:43:35 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45pv6ntpw5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 01 Apr 2025 13:43:35 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 531DhV8x30671372
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 1 Apr 2025 13:43:31 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C5D8220043;
	Tue,  1 Apr 2025 13:43:31 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A574420040;
	Tue,  1 Apr 2025 13:43:31 +0000 (GMT)
Received: from funtu2.boeblingen.de.ibm.com (unknown [9.152.224.229])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  1 Apr 2025 13:43:31 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: seiden@linux.ibm.com, borntraeger@linux.ibm.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, hca@linux.ibm.com
Cc: linux-s390@vger.kernel.org
Subject: [PATCH v3 0/1] Remove the need to alloc memory in uv.c
Date: Tue,  1 Apr 2025 15:43:30 +0200
Message-ID: <20250401134331.50421-1-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: E3d8NVEscaQkh0T91ZoYD1QwZVuwQJLc
X-Proofpoint-GUID: E3d8NVEscaQkh0T91ZoYD1QwZVuwQJLc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-01_05,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=495
 impostorscore=0 malwarescore=0 mlxscore=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 phishscore=0 bulkscore=0 spamscore=0
 priorityscore=1501 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2502280000 definitions=main-2504010083

The pkey uv handler may be called in a do-not-allocate memory
situation where sleeping is allowed but allocating memory which
may cause IO operations is not. For example when an encrypted
swap file is used and the encryption is done via UV retrievable
secrets with protected keys.

The UV API function uv_get_secret_metadata() allocates memory
and then calls the find_secret() function. By exposing the
find_secret() function as a new UV API function uv_find_secret()
it is possible to retrieve UV secret meta data without any
memory allocations from the UV when the caller offers space
for one struct uv_secret_list.

Harald Freudenberger (1):
  s390/uv: Rename find_secret() to uv_find_secret() and publish

 arch/s390/include/asm/uv.h |  3 +++
 arch/s390/kernel/uv.c      | 15 +++++++++++----
 2 files changed, 14 insertions(+), 4 deletions(-)

-- 
2.43.0

