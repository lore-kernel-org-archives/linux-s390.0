Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D533E7BC6
	for <linux-s390@vger.kernel.org>; Tue,  6 Oct 2026 11:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791285207; cv=none; b=BCTWD4Ku0FfnEsuL74f4gnFU2tw571HpJHCyuykAxiwzGkALWbOk7R1ebBLQGakvTbUR1uUufvK/4Tsnl59uCjt44ROG6ISFTL0Sb/VbKun5tCmpSLb8VqeYRVdTXM5WJ/QNynViW7hsgb5Bhk9xi7kByktgMJIe5XRy8Up7flw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791285207; c=relaxed/simple;
	bh=COo9YfqjRE3nPRjp7zUGacg8ADtno16Ud9cCRCiD8PU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jnsqW0QBLOL4fqoz4HVyCRYrmr1N5Gn3PRNxUFps7N39DUuBAv516nNsf9x91rztCntTc9xOlhRfGR7WD7xRV+HcEXpxHPdiCbZgF3oL7fQEKknPjnTIOWhahkVbT/67iU9PIfPsGmN3/awSDn30TfxWabDSMNP/l6v46qZ7taM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Q09kards; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Q09kards"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 696A5tpJ2199174
	for <linux-s390@vger.kernel.org>; Tue, 6 Oct 2026 11:13:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=21zW11pLCAKNj5Qn4I9yET6QLklm0FI3y9J4qCiq3
	NA=; b=Q09kardsctwaQW7cc3sGAhsc50buYKeiwTY10yYadM5iDvJjs55wbM1a7
	78rNHp9YJB2/lqb3hsMrxBKgbfvLt92GwF3O9xCaWm5OhIRUMZsLQn8ccAYniZTm
	dsnKJsO3eFviFGP24vc9L9x5ExFyNo+jZ1Z2kEpHsF1eW04D/j08YtoDGftxFvPc
	/1pBqvRq6tpQD1NLzlXpYuTdMc4CdUrpG09L9Hp9BOCvRwnX81SN2CckdQtftWtb
	whf0eLUwkcMrt2D/rjCQCWS0JscqDm0RC2WlgKoledpu5xE7iVaRrbQ/O1JWNtBb
	sMq9/HgSmmtagdcSoB4iTnuu5h7yg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2r4fxtun-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 06 Oct 2026 11:13:23 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 696ALBec126456
	for <linux-s390@vger.kernel.org>; Tue, 6 Oct 2026 11:13:22 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h3cdvsqfy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 06 Oct 2026 11:13:22 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 696BDIAP51183966
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 6 Oct 2026 11:13:19 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D178720043;
	Tue,  6 Oct 2026 11:13:18 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 892B720040;
	Tue,  6 Oct 2026 11:13:18 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  6 Oct 2026 11:13:18 +0000 (GMT)
From: Sumanth Korikkar <sumanthk@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Jan Polensky <japo@linux.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>
Cc: sumanthk@linux.ibm.com
Subject: [PATCH 0/2] s390/cpum_cf: Check session cpu mask during hotplug
Date: Tue,  6 Oct 2026 13:13:02 +0200
Message-ID: <20261006111304.4023017-1-sumanthk@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=TOPQ2Fla c=1 sm=1 tr=0 ts=6ac4d7d3 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=6VcFeyx0Gwr6KzQQbJQA:9 a=zgiPjhLxNE0A:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDA0NCBTYWx0ZWRfX1KK/1S6iVAg9
 ZYKpC0MGpDUVC5c6e6BBpjtjKURyn/hV/gTt3SvCivosVV/CyMwj7T+vJNbBLBW1S04GZOVHkSY
 j1FpSgghcb6ckKwCvG4sFu3WD2tp2qH2nZxaOW47nugtI0PV5LgropGUFBN6E9GvC5a8yqKKlIL
 zLGUmc1i9KjJfCezyjY5KesKzl26prhYfISlGXDHU3QiNB2vHcxbaVWuZOoOZ5lHIqXwpZRqeIR
 //cB9+bBvByEsZPGrD2yqgWnX7yAlPS7vDhg20w820/Ct2/7oj18FzOC2P9l6leai8hS9+ISdfU
 Bfgk5hdQt/fmUBNWFPhhTt8vL+qyYkZSP0KwGPBfOB1V0ejZvE2shaGAxqOh3SYWreuk2pGVsbV
 Cdg5/jJyMu1JS/04GFC71p5dEOoxz1K5rttPWQINeS9q6b1hUhyKzCT3wTujNJvCoAjEfw/RvI9
 y9n5RG3AOO+789PdPhA==
X-Proofpoint-GUID: oEwhtUi0cZR8aGL8RfvdCVHqgqtsCJe8
X-Proofpoint-ORIG-GUID: oEwhtUi0cZR8aGL8RfvdCVHqgqtsCJe8
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDA0NCBTYWx0ZWRfXzMZl2YLAHT6Z
 IqIx1RRh0SIdAyYgLN6Vk1XYRyCYWnuvKjz/IPRAVtBuMrmQI7xM6m9MxMHb7OEsF+Mxo7+EK2A
 1IejmvtHt39eFl2xzsQEL0IlHxqK0Lw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_03,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060044

The cpu hotplug callbacks start and stop counter sets for every active
hwctr session without checking the session cpu mask. This causes a
reference count underflow when an unrelated cpu goes offline, and
silently adds cpus to a session when they come online.

Patch 1 fixes the reference count underflow in cfset_offline_cpu() and
is suitable for stable kernels. It does not change the online behavior,
so no matching lshwc change is required.

Patch 2 extends the mask check to cfset_online_cpu() and keeps the
userspace provided cpu mask unchanged across hotplug events. It requires
a matching lshwc change and is therefore kept separate from patch 1.

Sumanth Korikkar (2):
  s390/cpum_cf: Check session mask before cpu offline
  s390/cpum_cf: Honor hwctr session cpu mask during hotplug

 arch/s390/kernel/perf_cpum_cf.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

-- 
2.53.0

