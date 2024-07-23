Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0400381B1
	for <linux-s390@vger.kernel.org>; Tue, 23 Jul 2024 12:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721738693; cv=none; b=POMvNvBiqlEpZUOn/WI+oVbHhUtuZp/2dTdRIfK2SX0ka7DF6uenhJjWHTW3aYZo4/ZXIN4nEkccXpZp7LXQ1vskoGfHt5XmMZMtS/pdSDOaxYtV17MW+oHENcjreIJxzj05sIy+CjMtcgkWPnRDCrs0lgHwp/irlMoho9fV1v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721738693; c=relaxed/simple;
	bh=N4msscWibtTFBs4iChSD7RkyOLmtNnEX5d1Sy1DRSn0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hgp/pbOj6BI5k+gDh4+to/jnkWjBjn9GYuTJ+0KAAXLmrkARRHBEpFxE3vdPPqXbWNdfp4q+v+HgI9I4hRehW10uB7H+Pm/5Wy5sOP1SpS1y1Udk2296BwUxnkXIe0lUxrZvBihe6W2gdg0X2K5m3LKlhuJ86RkRXOU/TSa1FUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DJSJnixK; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DJSJnixK"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46NB07Gp010807
	for <linux-s390@vger.kernel.org>; Tue, 23 Jul 2024 12:44:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=pp1; bh=NB40ATcAEPxD3xNtaiaBgDkr5f
	9DSBnUw+SfdKUNMts=; b=DJSJnixKNyE5ewbirlqwq92gLsMfgsxwx9VVTAKNR4
	1dFQ4ZUgjmYUXsO2l7fLiIrFmkFozFB6NM9ls1oOGQ9u4NEdtFu18JzfXON+bPc/
	rqLgmamXchFKT6PikCtYB0U/pXwKDzZ8CVNyIvA/CKYf/aZSZj2uGlDEQRiEAJ+n
	Cse4J0BaeuuxJeg27a0PXC2hGsqS4GzvhIYFfhAhp7rU4N/zwblvUpGT8Tm1xKT3
	T21Rx4pg6W3xTkRI99/vusfi/IiUAcSpiClwNm1mZVR8lReD0mMRQ9A0Yc8wDcQp
	l62YcKD9Va2niFYhPR50+yLHS+iZDQPLWa4pLlKMHFFg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40jb7xr8ax-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 23 Jul 2024 12:44:49 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46N9Oqfn005890
	for <linux-s390@vger.kernel.org>; Tue, 23 Jul 2024 12:44:48 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40gy2paa9n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 23 Jul 2024 12:44:48 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 46NCigRw33751702
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jul 2024 12:44:44 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A64FF2004B;
	Tue, 23 Jul 2024 12:44:42 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5FDCE20040;
	Tue, 23 Jul 2024 12:44:42 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.179.13.42])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 23 Jul 2024 12:44:42 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 0/2] s390/kmsan: Two follow-up patches
Date: Tue, 23 Jul 2024 14:44:10 +0200
Message-ID: <20240723124441.120044-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: IjDxPKk5wcotTvBIB7n_FSWN-31tNy8j
X-Proofpoint-ORIG-GUID: IjDxPKk5wcotTvBIB7n_FSWN-31tNy8j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-23_01,2024-07-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=689
 impostorscore=0 phishscore=0 suspectscore=0 clxscore=1011 mlxscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407230089

Hi,

This is a follow-up to [1]. Patch 1 fixes a conflict with the lowcore
refactoring. Patch 2 had to be excluded from the original submission
to expedite its integration, so I'm sending it now.

Best regards,
Ilya

Ilya Leoshkevich (2):
  s390/kmsan: Fix merge conflict with get_lowcore() introduction
  s390/ptdump: Add KMSAN page markers

 arch/s390/include/asm/kmsan.h  |  6 +++---
 arch/s390/mm/dump_pagetables.c | 30 ++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+), 3 deletions(-)

-- 
2.45.2

