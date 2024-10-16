Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7923206953;
	Wed, 16 Oct 2024 11:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729079630; cv=none; b=nmVziO399pOZcXr1AnahMIGllK10DRLgJCP/lpE+IVxwMksz7ysCTKFymjQCg4K2/88OVzj3D9r0uqbPdbpyVywR/fGIOcuEWClzQkxQH5tAcbmdA2JoqyF6MkB+jQPVdx9abHCV7XXU3hpJEkGiwR988FBtq9UE+S8cLO0eF/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729079630; c=relaxed/simple;
	bh=AX30tUD6dKOkQQBmFEEpg1NhT/sQin54YAyP7K2bkRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e9KDWZHMbhoLRCi5orr+9lxC2sAwU1XUqQNzCkvAG81OnGTFnGu4Fbi9bxMeD4gnxVT9T+rJNo/6ZVWW8qbtb1wZ2dIOdE2OolDKy9sCqUwP3ZBCrETKU4B9MbwCWeNT8d55vH77TQ1JYmflMlkxhaDzP42lgwkiBhZNbgdnko8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=q9Izk5nb; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="q9Izk5nb"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49GBjSkc022394;
	Wed, 16 Oct 2024 11:53:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=2iEKv6VzLgvZF9EE2zsOh7qrMnIjPazyMscKpQ65L
	5Y=; b=q9Izk5nb1nonI2BvHQBGV+2KQmUnicg/0vj5lUkbQOXVECU5gpUXfW8UA
	5+ONHm492BrzXoFLizKulF/6eG5ifDaU4o6S52wTgaFtDWW5M/l4qFI8KzYZUUDu
	KYDmnv1nFkpRQzha2rrWHrrIUTLuWChNnTCzDztI5NcWigzCGOmJeOihel0/EkUd
	yTYpoWx1yJKZ44QmKBoyUSWVnGa6EGRsW0RAPOGSVHUh5Cbu76FVaxi+GIYqNosS
	EKjPDDYfRfiz8xXsGEhzJSsI6RPakPAGkG0LIcXpSEN7gWbhW8BbxvLnXTrbYNrj
	WCpeIlG3IF6dogthybuWmAe3Oi8wA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42acvvr18x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Oct 2024 11:53:44 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49GBrhDr007534;
	Wed, 16 Oct 2024 11:53:43 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42acvvr18r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Oct 2024 11:53:43 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49GAtwFN005215;
	Wed, 16 Oct 2024 11:53:42 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4285nj8wwf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Oct 2024 11:53:42 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49GBrdhs27329228
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Oct 2024 11:53:39 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5C8BB20043;
	Wed, 16 Oct 2024 11:53:39 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4A9D020040;
	Wed, 16 Oct 2024 11:53:39 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 16 Oct 2024 11:53:39 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55390)
	id F0979E069D; Wed, 16 Oct 2024 13:53:38 +0200 (CEST)
From: Sven Schnelle <svens@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Richard Cochran <richardcochran@gmail.com>,
        "Ricardo B. Marliere" <ricardo@marliere.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH v2 0/2] PtP driver for s390 clocks
Date: Wed, 16 Oct 2024 13:52:58 +0200
Message-ID: <20241016115300.2657771-1-svens@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: oLbaXVs7V8oqssfNq0cptimIG2tYsc0d
X-Proofpoint-GUID: uo1qAPiLEDfAwxmd1OpP7W1LU7o7yxDs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 clxscore=1015 mlxscore=0 mlxlogscore=855 priorityscore=1501 spamscore=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410160074

Hi,

these patches add support for using the s390 physical and TOD clock as ptp
clock. To do so, the first patch adds a clock id to the s390 TOD clock,
while the second patch adds the PtP driver itself.

Changes in v2:
- add missing MODULE_DESCRIPTION()
- drop udev event patch
- simplify eitod_to_ns()
- use store_tod_clock_ext() instead of store_tod_clock_ext_cc()
- move stp_enabled() declaration to stp.h
- use s390 instead of 'Z' in clock names
- defconfig symbol should be default-n

Sven Schnelle (2):
  s390/time: Add clocksource id to TOD clock
  s390/time: Add PtP driver

 MAINTAINERS                     |   6 ++
 arch/s390/include/asm/stp.h     |   1 +
 arch/s390/include/asm/timex.h   |   6 ++
 arch/s390/kernel/time.c         |   7 ++
 drivers/ptp/Kconfig             |  11 +++
 drivers/ptp/Makefile            |   1 +
 drivers/ptp/ptp_s390.c          | 129 ++++++++++++++++++++++++++++++++
 include/linux/clocksource_ids.h |   1 +
 8 files changed, 162 insertions(+)
 create mode 100644 drivers/ptp/ptp_s390.c

-- 
2.43.0

