Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70033298CAB;
	Sat, 25 Jul 2026 15:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784993236; cv=none; b=civ1yV0qKC6QT4rDdEAqhbNhVGGjZtqBAtTajHfosrDQ92wN/1DCgEbQoZL+TcOsqgNrH8TCwD2lLI/NeAQT5VK8i1YnrsC8eKXXpOoMzSkqwMyBedJN29qmgoGwo/ONNUSq5d8Ye3cTclTPG78LNzQTaK3L9X0Og4XamIxvx1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784993236; c=relaxed/simple;
	bh=E1q3RDAkRXmhzyOr/5dIhS7EiI5Kv/KPAZRWb63Ze40=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q3lUwtb6+2T0dPHBCGWdcnWsfVCnNIjXPu7OpuPBQ7Jt5oBYTDIoKDAYc9BiA9NGk0CffPzEGl85J0m+ewn62AMeDijzRlFVJIXlC0j9YbOrwF6Co9r7tewVI14mp+SsmTIJokUA3D0MxhPokgmWGG+xLgBey4LtkAojXoIBxQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QgwzQB5A; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QgwzQB5A"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66PDlaQl815207;
	Sat, 25 Jul 2026 15:27:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=0K7UjKc3PF1bDItY+HDySpLmh13Paj5jS+dEF3m2a
	70=; b=QgwzQB5AWAoUgOAyuuxAwuxBkCNoFqi06ghGfjR9J7b/h063gLSJZTGtu
	SbIYuLT3ZnL5nZ2YxhmnYjgiSEG9sixSThWW3c8U1smu9XFQvzrZI9bd50uOmnHY
	kqoNpfmVPXYV8W4olC8lP3iY8ESsaTL6uRqtIexZTnGlJzuOb4LgwRyfuWFzfP+K
	BDpPQb7z8oGa0wLqDU8HNnNtqa8ualhvUNhS4cff3ALXx80MM46GBL2oP/Ba5tgh
	lF10SWaqMhZltbDbEEDovBWEP1WS/Y2TOPQJEWSRI8VnrRfTLX0BkYIjswq/5JCm
	4u5DQRGMOFyvY1VwJkOaObtIxpbbw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0x8jrv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 25 Jul 2026 15:27:14 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66PFQM5e014015;
	Sat, 25 Jul 2026 15:27:13 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fmn5h9n24-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 25 Jul 2026 15:27:13 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66PFR9Rf42860876
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 25 Jul 2026 15:27:09 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9CB5420102;
	Sat, 25 Jul 2026 15:27:09 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7BFA120100;
	Sat, 25 Jul 2026 15:27:09 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with SMTP;
	Sat, 25 Jul 2026 15:27:09 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
	id 6310516267D; Sat, 25 Jul 2026 17:27:09 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>
Subject: [PATCH v4 0/9] s390/vfio_ccw fixes
Date: Sat, 25 Jul 2026 17:26:56 +0200
Message-ID: <20260725152705.3958100-1-farman@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: dhC-Q7l60duuQL5wcY0IqblGDEw_WmsN
X-Proofpoint-ORIG-GUID: dhC-Q7l60duuQL5wcY0IqblGDEw_WmsN
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI1MDE0NCBTYWx0ZWRfX1FuQpXlAd9Wc
 V9wYcQBoUTOv9YRZ3ful0q1AYxvZVqo4QDDLWsOpkKcMccUuE0gx31kYZknUQ3rFYHJwwvBd20K
 TTIxUjRDMDaAeA5Mui4L/AdCxpvSh/o=
X-Authority-Analysis: v=2.4 cv=dYuwG3Xe c=1 sm=1 tr=0 ts=6a64d5d2 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=Xq2SPA-IMpQdQLpMtacA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI1MDE0NCBTYWx0ZWRfX6oeGnU3vGyFW
 B+0pfEhBej4IMzTlmolqqRog63O95XiXC/ZCUY9diyJPfb2OD6Sty7/9bnyqo6PTozjyq7vTzwI
 mx/3cMLa1DEnn7oqlLCHV/ifTYSs7T+MZR+RSvVS4ehwJud/EpVwc7yLR58v+KMC9x1P8KJ2hWH
 thfz0ptlfK+WblLf4uWCk4na4VgzIzYaQ7VDw+uyJmBaufekNELbZEitBUUxSML4oUXGmp/pglA
 ySqDgSfHXSlMpoLSfjHtrBqSeCOzK308mMZ5V8U4je64M3Svglq2j/Sqwg6WTfpdaaWNEsaW2XC
 EyAczr5Sq6dnvmbDnsQRQES91w/VKVa9EaFb1MLCzd3IhEtQvfqFqwCCZ1eNVjRQMfNLUy1DRdY
 WRPM/ne7acNW6qUdOAMp8urSC3gS+mreKEKJZEUG8Xwg/mtxAG/8Yqzcsw5qCXxdGHw4GMHhHfO
 zwy6ni9uDzkXJOmXtwg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-25_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 phishscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607250144

This series addresses some pre-existing issues found in the
s390 vfio_ccw (DASD passthrough) driver.

v1: https://lore.kernel.org/r/20260714232208.1683788-1-farman@linux.ibm.c=
om/
v2: https://lore.kernel.org/r/20260720201931.976660-1-farman@linux.ibm.co=
m/
v3: https://lore.kernel.org/r/20260723174751.1180334-1-farman@linux.ibm.c=
om/
v3->v4:
 - [MR] Added r-b where provided (thank you!)
 - [MR] Make ccwchain_count unsigned
 - [MR] Reworked loop in ccwchain_calc_length()
 - [MR] Add boundary check before nospec clamp in async, crw, and schib r=
egions
 - [MR] Add lockdep assertions where appropriate
 - [EF/MR] Add definitions of new fields in channel_program and vfio_ccw_=
private
 - [sashiko/MR] Fix calculation of DMA address between Format-1 and Forma=
t-2 IDA
 - [NEW][sashiko/EF] Defer cp_free() from fsm_notoper(), so it can be cal=
led
   while holding sch->lock, without needing to dance with private->cp_mut=
ex

Eric Farman (9):
  s390/vfio_ccw: free all memory if cp_init() fails
  s390/vfio_ccw: limit the number of channel program segments
  s390/vfio_ccw: fix out of bounds check on CCW array
  s390/vfio_ccw: ensure first IDAW remains constant
  s390/vfio_ccw: calculate idal length based on idaw type
  s390/vfio_ccw: ensure index for read/write regions are within range
  s390/vfio_ccw: move cp cleanup out of not operational
  s390/vfio_ccw: implement a channel program mutex
  s390/vfio_ccw: implement a crw lock

 drivers/s390/cio/vfio_ccw_async.c   | 16 +++++
 drivers/s390/cio/vfio_ccw_chp.c     | 30 +++++++--
 drivers/s390/cio/vfio_ccw_cp.c      | 96 ++++++++++++++++++++++-------
 drivers/s390/cio/vfio_ccw_cp.h      | 10 +++
 drivers/s390/cio/vfio_ccw_drv.c     | 19 ++++++
 drivers/s390/cio/vfio_ccw_fsm.c     | 23 ++++---
 drivers/s390/cio/vfio_ccw_ops.c     | 21 +++++--
 drivers/s390/cio/vfio_ccw_private.h | 10 +++
 8 files changed, 184 insertions(+), 41 deletions(-)

--=20
2.53.0

