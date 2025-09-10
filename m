Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915203081BB;
	Wed, 10 Sep 2025 15:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757517148; cv=none; b=hrzlzr3qA461AL5+H/idMnzoL0XeODKk3aHJATskJ1HsdpxwnkpKX/TzrKWcY5FEO6/n4yFZg1i/G5LZdLjIwM2eVwJJPIxSA7GO3U1dVTiUZ9V6uF8IIUDiYYt55kacWq7xLmEzSOXThaBP0Am6AS9JnTm78IoQLZaUmvbXxvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757517148; c=relaxed/simple;
	bh=tUywZVS0tIu8cR9uvwAaSp3gYd7EqxgG2g7QsySdCAA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bsiFNJaGx591Rrbwr0MxqzgNfS4gYeDkTovZIePj1M0KA47spQmtUIflbJJmTi2wao586RELZa5iHP4DOEDhWi7dEPwSFH6FNkr3Ltd+cOMNx4+1kF3ETlTp+5VSsZAOMrzgDRiTgtB3ddLj6foNcz9HvCjJx7Fpl2FcGwT03oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lixBCny2; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lixBCny2"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ABsdEb017992;
	Wed, 10 Sep 2025 15:12:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=+S3kcBpX4sue8fRAh+uluu8hhN5wFO7y2TwKEtj5s
	QA=; b=lixBCny25yii83Fg/Fd/FGOmNoTgsbveUD7EHS70YKE6zD+WogVTdQvFi
	En+WIjkZsH5pRa2zQzJYPaaWZK1iVG8SKnqAQrqwgIp94duWwSSE3g0VTyv+G4Is
	nyFQOIMC8HEXoZStTsu/s7Ltner5dgkbjACCGB+LosfhCwMDOR0fogZp0/gfcSbR
	BrupJK4458Xef/38w8bSsCa5nHBUz+ADj9G/t3m4Cd1VaWBIp07yyWYsBcZzSaD0
	YGtefjvBk4MKLXsd1zVplRwQuh+jkHyjSqwInlddQXWsaeuBcCW8pAmRBgQR5rgM
	YLM0KkLnwUAfwb5EEAMTu3F5GrOmw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490ukekyne-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Sep 2025 15:12:21 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58AE2kJT010666;
	Wed, 10 Sep 2025 15:12:21 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4910sn11qf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Sep 2025 15:12:20 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58AFCHhM50528704
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Sep 2025 15:12:17 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0CB3820043;
	Wed, 10 Sep 2025 15:12:17 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D218E20040;
	Wed, 10 Sep 2025 15:12:16 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 10 Sep 2025 15:12:16 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Nathan Chancellor <nathan@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Juergen Christ <jchrist@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Sven Schnelle <svens@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: [PATCH 0/3] s390: Fix and optimize __flogr() inline assembly
Date: Wed, 10 Sep 2025 17:12:13 +0200
Message-ID: <20250910151216.646600-1-hca@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDE5NSBTYWx0ZWRfX3YuPbvB/JHhZ
 5Eijojytsid+mpwu0oI0bnDLJnBxSVIh3X1JaKP/mnvNg8M2Royv24OlaXA5cYs02z5n3RDZ0Je
 kcSFaGSwQSL/YsZrcR8RdG71H/w62kpRi6wcTfMJC6u+97Z3kt4jIb15M3lIJQnSGdd22Q/9EvE
 Lf4b0iNnBT09OhZRxf67ouoYB83N+YzSShjASXBSnWvEhcZkr/p7ieU7hWghKaLG0s2OCmTRsVO
 1HNfHgzAiMv5KjSmYDWbBbDpvBJn1IfnWSY6BDYGC6IEHU0/dWpWUOfG6DNaY4or93wb2yESYGe
 NmbBTeBzuPSGYWPmP6sVc3mNWCn9QYV/sf9e2K2kfC8AD7jaaIfJ3Q0CMNnyhymEpAKy1/WPbip
 KAKMl0Km
X-Proofpoint-ORIG-GUID: XI0IBP9SoXeDVgC9nQiHGPv7KdXClr3H
X-Proofpoint-GUID: XI0IBP9SoXeDVgC9nQiHGPv7KdXClr3H
X-Authority-Analysis: v=2.4 cv=StCQ6OO0 c=1 sm=1 tr=0 ts=68c19555 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=yJojWOMRYYMA:10 a=2uNQNb8VGNDEgoMUXiMA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_02,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 bulkscore=0 clxscore=1015 adultscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060195

A recent optimization of the s390 specific ffs() and ffs64()
implementations leads to a new compiler warning. Instead of reverting the
optimization address this with the rather new assume attribute, which
generates even better code, if supported by compilers.

Since the assume attribute may be useful for others as well, add the
__assume macro to compiler attributes, so it is kernel wide available,
instead of adding an s390 specific optimization.

Heiko Carstens (3):
  Compiler Attributes: Add __assume macro
  s390/bitops: Limit return value range of __flogr()
  s390/bitops: Remove volatile qualifier from flogr() inline assembly

 arch/s390/include/asm/bitops.h      | 16 +++++++++-------
 include/linux/compiler_attributes.h | 16 ++++++++++++++++
 2 files changed, 25 insertions(+), 7 deletions(-)

-- 
2.48.1

