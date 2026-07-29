Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7121C46F49F
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 14:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785333705; cv=none; b=rv0oYcPCnyt/uFfVdwRxwKC445EJCPjiuHHZcfrRHNKBlK40gOWxUgSWKblOW88zPJLVM2sAY0mNVPFg0MI68UAZiw02Xdxf9rHZ7zaUU0dzI2g1tow9N5lVJfM+mDxvAheI+linGfw1RXivJsp3vo5j38ORmWK+p7WqRh/RHI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785333705; c=relaxed/simple;
	bh=Z0Wt9A0Z+2Tfblbcrp6PvHxHxp94I8zkifyhpctWKLA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i8u1rwSZJDzTmZHO+17ZcNofAoAurq/YGVZwdmoS2yxRUnLPWJfqSU3BUUEzTSNXW6DOdGoi5e0prDO6en5FjrOjSPJpaWB5gYxfv7Mp5McoKFS7mJNamQJteQczPj8yXoYwa/TQIIAu4UfjCtV/R/G6PXjpE67RMgTmai5dOEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=p9N/LWPu; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="p9N/LWPu"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66TDHvjX017802
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 14:01:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=w0ydhxDnmlvz4J1OKZGrCWQFFqVI0bd8RdVCP3XFc
	uQ=; b=p9N/LWPur/wwbI6bQ8VoMmjp8BRljs2VkaRAwwDg0uE9E+wzxnEgps9Ye
	uEsg2qaVGYNRpQs758Da9eri3kGQQb1YqOiuFMIeK/Lxi34dpODZGhMLnbeOT9u6
	vJ0/suQ3lkRY+xFpg+og82ehdPNbkAprHBTOX82xaYU+o9P5qVwbaYdk092rZ4IN
	brnBYCtA8QV2xReu5xfv4O4EXHcTSwP5BsLCKd0H7IaXKfOAeycyqDGT7rZYdmm6
	DTZyOu7/S0tEUkQR9DU5ZEVBaZexV6xalmAq0a/w/OslD+ImBErnZQJxPlRGv0YE
	TgFWnV4VeVF+V370lMOSs4hupNi5Q==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyja7nj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 14:01:40 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66TDuGZ1008597
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 14:01:39 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8fk6yy1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 14:01:39 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66TE1ZQh35127798
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jul 2026 14:01:35 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 955EC20043;
	Wed, 29 Jul 2026 14:01:35 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6E4C020040;
	Wed, 29 Jul 2026 14:01:35 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.165.15])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 29 Jul 2026 14:01:35 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, fcallies@linux.ibm.com, ifranzki@linux.ibm.com
Cc: freude@linux.ibm.com, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH v2 0/1] Fix missing mem scrub at clear key import in cca_clr2cipherkey()
Date: Wed, 29 Jul 2026 16:01:33 +0200
Message-ID: <20260729140134.191448-1-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDExNCBTYWx0ZWRfX6KPvMWtgUtzd
 rje+Dv3UAvf6Ct3g5j1fnWti0BJhqEf6NqHck2y6KWDiYbtngxILTmbaAyJm5eQLEQgGGwZdtTx
 C7xuwfgOwB9k2BGPHQ31Dz75xI2chHA=
X-Proofpoint-GUID: tru0q-SP21cSL9i_9d__b3cjJwUr2QUj
X-Proofpoint-ORIG-GUID: tru0q-SP21cSL9i_9d__b3cjJwUr2QUj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDExNCBTYWx0ZWRfX9LEYzZVQ/hTv
 kf7uLAUn91h3kzmGytL3OFpdQmqXaTFCES88g/SetzC8SXxcFZYEUYRGRmxifCWeyBIiW8uO7is
 duAnOh3UqTK8wFV1faIgERpobSFqL3lrfykjlNwbJAx6NS01U94lTvEAAkBsKCmB9mPM2LxtfVn
 YeXjWo9YqszmIAgojhd879uhKw5HJULHot9V83CCBPeQQdyXyOYrKOs3le6zXR6hcDYwFQU1Dsq
 sWy4GZURLHvuromF0O/RT4mQIT4r9luV+lUzgJ4fobVXx4qfNihCmY3dN21vR0eUhYkC4q/6a7f
 drw2aUvX7UWsYtyA5PgBQ7cz7bBw2WmgLmkanG9VoidOUxLi72TJehCiorVYBGo6LRwTY5//KPh
 B7Qy78UIlHLGK9+IJjG6vRXgOIIIK+ApxN3947gO/jOsPvksyE6VWFDFTQCLprhiWXk8a05in5Q
 yZwhCtenwVZKTuZj7tw==
X-Authority-Analysis: v=2.4 cv=X5Vi7mTe c=1 sm=1 tr=0 ts=6a6a07c4 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=i6s2JdvJfTGb1sfd7hYA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_05,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607290114

The helper function _ip_cprb_helper() uses internal buffer memory for
building and processing CPRBs. After use this buffer was never
scrubbed which could lead to leaving for example clear key material in
memory which could be exposed via tricky reuse of this same memory.

Extent the _ip_cprb_helper() function with another parameter 'scrub'
used to steer scrubbing of this buffer. So now the caller has the
opportunity to decide if scrubbing is needed or not.

Extent the clear key to secure key token import process in function
cca_clr2cipherkey() to tell the helper function from above to scrub
the cprb buffer when the clear key value is part of the request data.

Add explicit scrubbing on return from function cca_clr2cipherkey() for
the random EXOR buffer and the cprb buffer.

Overall this cleans the internal used buffer in case of clear key
import to prevent sensitive data to get exposed.

Changelog:
v1: initial version
v2: added explicit scrubbing on return of cca_clr2cipherkey()

Harald Freudenberger (1):
  s390/zcrypt: Fix missing mem scrub at clear key import in
    cca_clr2cipherkey()

 drivers/s390/crypto/zcrypt_ccamisc.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

-- 
2.43.0

