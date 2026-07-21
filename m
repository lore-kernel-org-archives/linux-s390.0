Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABAA46EF96
	for <linux-s390@vger.kernel.org>; Tue, 21 Jul 2026 18:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784659683; cv=none; b=LDmAhDy0LN572ZlwrDdDAm2qlR6wn8pX06sSntuESz44cRP3UUiCJlw2LISo7vC6moz9D5o/SKoh7iGQZpFM8wVrMzQwkK4vbNB7eDor8s2sIFDkSoAgJ/eT5fpiDjBe7HOfI63yQqgJRKUz6Xu68ghkV+iRQ0NQd0YXGYpaVx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784659683; c=relaxed/simple;
	bh=8Rod68UTmzxwksfHCVl5jU0iNXL4MUIutpMAcL303uA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Blw6xPfMHBctnbQ3+ydnJS/oQ1XBFz41vm7aGIXaXRXnwBW3MTZiHSUdw12cSTAS9aiqYBQ19Gn4czNvHmfhAA893tGE7wvYUPU1UJ3gfv1N0KSF/HMCMN9q4ylNCbncaEX5JhDBRq6VgFl65FRWCAwaURLXZIsPOIlMYMT1QZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=syeqdZHi; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="syeqdZHi"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66LHBkcV1651764
	for <linux-s390@vger.kernel.org>; Tue, 21 Jul 2026 18:47:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=F8kGQiKCQiKZPtIokH+v34l1Qw0e
	i6q/TVERHSQFfiw=; b=syeqdZHihyoEMSoXi7yeHooLGLOjmvFl9QkEzkQv/tii
	Gbbl4hbxiURNa5e6iAJ2phxXhkvWAsX9eb5/5odyNgaU+FFsufEFUUYdCx24xcpp
	ssjqeXUT3fUejbNWmHVRJj0PQoklsx4ystCK2Y+ygOdoe9aaF2KiLpik1V824KxD
	Tbu1keEhWkz6kLspkudu8fCn9y2UUZMZChn7ReDzqu80Tg5c2RQC6VHzOhd1iDJx
	IL5Mc0TSK8MxV4EnbPt9HYMzaH27rYqKoFJO60TFWiI8S0+uMRC8v2PYI1M+19qt
	Bvj5ZxX9FsYMKptZ0TMP3Gj2MGfDhsPAphJygj3yJg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg790x8b5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 21 Jul 2026 18:47:57 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66LIYaC9014160
	for <linux-s390@vger.kernel.org>; Tue, 21 Jul 2026 18:47:57 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgpgybf6x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 21 Jul 2026 18:47:57 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66LIlrtp44892548
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Jul 2026 18:47:53 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3985C20093;
	Tue, 21 Jul 2026 18:47:53 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1418920098;
	Tue, 21 Jul 2026 18:47:53 +0000 (GMT)
Received: from [127.0.1.1] (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 21 Jul 2026 18:47:53 +0000 (GMT)
From: Mete Durlu <meted@linux.ibm.com>
Subject: [PATCH 0/2] s390/ipl: Improve readability
Date: Tue, 21 Jul 2026 20:47:26 +0200
Message-Id: <20260721-ipl_refactor-v1-0-4d5938de9a70@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MQQqAIBAAvxJ7TlAPFn0lIjZbayFUNCIQ/550H
 IaZApkSU4apK5Do4czBN1B9B/ZEf5DgvTFoqY0ctBIcrzWRQ3uHJMgZRLWhwxGhJbEZfv/dvNT
 6ARA/Fk5eAAAA
X-Change-ID: 20260721-ipl_refactor-ef6aa1bafa8a
To: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, Mete Durlu <meted@linux.ibm.com>
X-Mailer: b4 0.14.3
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: PK7YgPUGvi7XYcCoEYWbiAEjbflBEPX8
X-Authority-Analysis: v=2.4 cv=V6RNF+ni c=1 sm=1 tr=0 ts=6a5fbede cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=WAhjbKsIw7fcYmIzXawA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDE5NiBTYWx0ZWRfX533m0xooygLZ
 U/wPFczib9XPGTsMa7/mTKh4lcHo+cTuXrqHkSWqAUfAHTXXdLtQPt94NrZCrX5bDKA/wXoMRN4
 elm9eCF+wwOf8pqv/5zhJxoneF9xXdc=
X-Proofpoint-GUID: PK7YgPUGvi7XYcCoEYWbiAEjbflBEPX8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDE5NiBTYWx0ZWRfX4c5Q/dnBI5a4
 VfESXJy+AD8UR/1ZPdhy1ghSVPN8vt9WX/2hpdhRlEWcnKjrLsouumg+0tyAWlkgE7uIsUs/QXh
 65FusE52tNWKp8CPzRtZoIDOq+lsB6oblxY+eu9e8SZcyOg0dNVKQ9HtZ4Qzf0lm8ybembra0DN
 A0WEY1VipL1PpEmepyUYsn+jemn6R5/7K2IHRurgbjAqrH4hmxTxfUEzpMoUi2VGvAU/FuLm651
 iyl+fES9AxkowDLgA/JY2r6Jf8MMSPdwi0xny6JgT1lH0rJ5TZJzILLc9ercAeIc4AgCrXCFwna
 nLwySB/0s6jpkSiuFnPSb44zLi0tKeEk+4OPcXmYJHhrb4TczRlUlOED1A/SdPkNG3zs/UrY1YC
 IdgndjO7tQMiKr43dvKdwplYuuGgGDKNc9esx6yGvCsMIObHMlamL5+afmg6I9GKiCz6M89MyOn
 lhSddcLfpi03tavosUg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-21_03,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 impostorscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607210196

Improve readability of s390 ipl code by openly writing static struct
definitions, reformatting list definitions and using ARRAY_SIZE() macro
in suitable places.

No functional changes, only coding style changes.

Signed-off-by: Mete Durlu <meted@linux.ibm.com>
---
Mete Durlu (2):
      s390/ipl: Use ARRAY_SIZE macro
      s390/ipl: Improve readability

 arch/s390/kernel/ipl.c | 58 +++++++++++++++++++++++++++++++++-----------------
 1 file changed, 38 insertions(+), 20 deletions(-)
---
base-commit: 248951ddc14de84de3910f9b13f51491a8cd91df
change-id: 20260721-ipl_refactor-ef6aa1bafa8a

Best regards,
-- 
Mete Durlu <meted@linux.ibm.com>

