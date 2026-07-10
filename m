Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14299420E80
	for <linux-s390@vger.kernel.org>; Fri, 10 Jul 2026 13:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783690027; cv=none; b=bht1S256Ee09dOXFHfTrncDoBtVuMAj+SmJ2oipVYCbM978pDGpqKLJaXZ2lXyji6fr3FjaXBrkBViDA8PNfoWTMxP8OLDGn6Ec4GIUoO+7PrkS/eIvVtkzdR+nBOfONp0PoruBYyxdMq4/24zq2bwQ1H2vcmWKPimcQfvcrgF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783690027; c=relaxed/simple;
	bh=4OnnY2tOZ5hxnbJh8WEkx1uGVHXsZakopLzvT/sLhhw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d/5ZjJVx99Mjiu/dgcm/H8mLjBlqwYlQFpDGdHy0V3gPzRhT17r4o8qy/3KcUHq2WIn0CgwWnrj2zc385QZ7s5GIeHV8b4zZtPWZF9RQi7x8IPvNKbDq2+vTmeo0g6lwseVebUIHsuomB/RBKDAbi4yLLaJNce0WUBjtTXP2XWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ADP0Pizj; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ADP0Pizj"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66ADIp9D571290
	for <linux-s390@vger.kernel.org>; Fri, 10 Jul 2026 13:27:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=bAIXLew+Zjdu9+sKyxMesr7fnossayLQv/atHXgW/
	yY=; b=ADP0PizjS9PVutesDJqQXyo0joHAQwsL8CPTV3OKwbUswSXEUmtsx13en
	azIqP0ssi7zMCKLK+1aw8lTEkHU49zqk47YVsXdrG71crHMQvPRx3Pb64MeGZZBw
	8jcgYisdfk+B+DPgu9X/5mSCUEmjMuG5iYok5r21rx2jLT0XPFHESigt/Oec62CG
	FTTHOi4xo3ie+9V66KGv4KEFPU8y9tq3g4VO9molB9iclRotW/0Vx/8ceRyY9K6J
	u4bp2o1bbynwhPg/zlRD7FCnQdUuvktts7OlqBtJ57w881nR+zu6SiFk1s1/2vFx
	xsvUOVxPK6TgjzOqfu5QGzo7LH9/w==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6rke74de-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 10 Jul 2026 13:27:04 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66ADJbKH019792
	for <linux-s390@vger.kernel.org>; Fri, 10 Jul 2026 13:27:04 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7f6yhuh8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 10 Jul 2026 13:27:03 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66ADR02821365490
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Jul 2026 13:27:00 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1893220043;
	Fri, 10 Jul 2026 13:27:00 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ED42D20040;
	Fri, 10 Jul 2026 13:26:59 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.196.135])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 10 Jul 2026 13:26:59 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, fcallies@linux.ibm.com
Cc: freude@linux.ibm.com, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH v1 0/1] Fix missing mem scrub at clear key import in cca_clr2cipherkey()
Date: Fri, 10 Jul 2026 15:26:57 +0200
Message-ID: <20260710132658.77231-1-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=M7J97Sws c=1 sm=1 tr=0 ts=6a50f328 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=i6s2JdvJfTGb1sfd7hYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDEzMiBTYWx0ZWRfX6lgiHL6E/bI9
 saJ8bfuMimPm3lDW4ZAaAgnms6WnSRRrA49GPs128PtYIomAHPHfupYDe5nm0L2vp3M6w94Io0T
 N6xB3jCLIXFy0NYYsWkyGaJlhEEyCow7k/vzaagIkYEKXfJGRHTOinBTtiqmUvk++1aODRN5Gal
 iXMcMb+pcQJ+rt3zkOmXXtes6qWwIm6fwmOgXhuygpRkV+WY/5qyHb5FGYfNaVv3fsKSKDb3pKc
 g2QUr+WF+5jsABc3hyQuXl5yGjV7ln1udK6W6Z2YrS8Q9S2WcRWCQNQ6uUkFgxPumkv/QHXfxV7
 a1AT5DRZHVf8dZZ5OG0zVQNI9CIYAIFXBnSaG6hxaxsvNjgry18fRCgpkvdAsyoF8dnux62qfZt
 lir1QSix1i4VGp6pIptCcF7ImWHkb5cseVh10SeLqGlzNMHSE5mOqjInDXSNXGrmpL720zk6Eow
 MrJgFBc64K7sEW+3gpA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDEzMiBTYWx0ZWRfX9T2iYyjANVlw
 NDzqYjeSV3FWRijws8lEMd7HMTc9AyPeBrxLUGvyKdFx96brxIJ36HnYsjrfzkqWsAar1c8BE53
 KK1Ai98Tc2bjX5FFTxWX/R0h/q7bRPQ=
X-Proofpoint-GUID: 8kygTGvYh4uuOXWedxOzwjis-oxohlz7
X-Proofpoint-ORIG-GUID: 8kygTGvYh4uuOXWedxOzwjis-oxohlz7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_03,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015 adultscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100132

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

Overall this cleans the internal used buffer in case of clear key
import to prevent sensitive data to get exposed.

Changelog:
v1: initial version

Harald Freudenberger (1):
  s390/zcrypt: Fix missing mem scrub at clear key import in
    cca_clr2cipherkey()

 drivers/s390/crypto/zcrypt_ccamisc.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

--
2.43.0

