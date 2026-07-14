Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871E142BEAF;
	Tue, 14 Jul 2026 23:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784071339; cv=none; b=kJf7mrghEZcq8HRPW2Nbtk/fZ00WSQbzFc6vubRqBLWiMbB5EP4M4Wyxlc+KucuqRsi4ghlCR8j9HonhW/1Hwtof1VcNaUXDaoYrwq3thJhJmioUpwTZ2W+PXeO7lFfjimy46FOTelgE5KLFEV6rn+X6ysiHXJ1d34kd3bBJIvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784071339; c=relaxed/simple;
	bh=fKGf1rjW1hYscqQWNWNAlML8by4gwlLXw/LHirpMF20=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SrpIktX0uS9V3tS7zVkgUEZOsz9t2UijVN0Z+OSf3+iVmlNgPmWWnZxgpMHdv18Vnre8aKKPQPWL+Xvt74E6yxLDW9EYUanv1vGc1NhGZGvBqvFXqHjfmYDdcQUknsxx538U36cT1ltq2uwA12S/KAbog8/5Vf9jST6dJAHOgjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BjIBFC38; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BjIBFC38"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66EJC0eX2176712;
	Tue, 14 Jul 2026 23:22:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=EYT4RNmJUbCfng6WjAcgEfQ2uuYtfOQhD8BGJDFce
	E0=; b=BjIBFC38IET4tliiRVMd/dqFa+x9eR4tILvSx5wM1nZzwlgCCYXedYfHQ
	k3PkEvFTrPbDIw17LR3LxqSYhm7qmvgLqZWxtTnLX2cBQ1+Wu9SB9wDpV4RLGfp7
	WWmH3ic0IiwX2v3i4q1suBs7eDt6qn11F7eiiYiEui/vvbfOMZ4yupJxgEdWDqRn
	sz0/qhEM3sP4XVHeNeK/kKUsCLyDbxZf9knpuaBW8DtsT2+NfY7EuQkeSBIMFloY
	B5/R1hANNQ3h5jJg5F+bUwjZKYtt44F3g+kzt9UnAmMLN1bgo+9jZzdjl9zluoPj
	XKvbATEHmSjAzXusMEVeU05v7Vf1w==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbegbr7b2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jul 2026 23:22:17 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66ENJdqe023960;
	Tue, 14 Jul 2026 23:22:16 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc2uy4vrc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jul 2026 23:22:16 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66ENMCDb48562510
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Jul 2026 23:22:12 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6635020043;
	Tue, 14 Jul 2026 23:22:12 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 426BF20040;
	Tue, 14 Jul 2026 23:22:12 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with SMTP;
	Tue, 14 Jul 2026 23:22:12 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
	id 193AD16263C; Wed, 15 Jul 2026 01:22:12 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>
Subject: [PATCH v1 0/6] s390/vfio_ccw fixes
Date: Wed, 15 Jul 2026 01:22:02 +0200
Message-ID: <20260714232208.1683788-1-farman@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=fOcJG5ae c=1 sm=1 tr=0 ts=6a56c4a9 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=8VNdgESh-TNV8XaPrrcA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDI0MCBTYWx0ZWRfX1CB1bD0VRXOf
 RI43kS2FzwPDtyLey9ti5I+poYGBqIoTLKAXCPyHmhkZykDsMj0vV62gXbW4Xg3bPGJI1Vqywqs
 hT1/7UhBDLYyQJJoqhMtJKqi01m45P7TMYKNg7ZVA1DPly9Y4eF8++DXWz6JSGWvmoisZ4B2q7G
 bZXStoxe+N1Bo86mo+s+iMCIPMvyHaHf874xbcC++FNBYP9XMj7VOnOWZ+TgbOl5pV5stcHBq8d
 dj2K7S8FwVz0tTxZdqx/lzd3hYiGYlIo0qisFjBCl5DCws2phGfYYd2soJj5NMxe+l4oTgkQTfN
 /pbjlqesasL+uhYWGRuOinGAZHUZY8Wxe6bDwkfZ3eMdnDjtgvWWvR8SyMzI6hqmVrtmWrQVk0i
 wUyES3F787iGC1oQje1eKxYchBA8D+FgHA5c4vq6axU7gpSvzKtqZF9OUKXzkeis3G/UL20Jp+9
 kJr9PD6wF6vU99xXcsQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDI0MCBTYWx0ZWRfX/1r7RADanBpC
 vZoPbAeLjpLgP0jNOJfMAEj+ZgqwylONMoo9/6itQwxPXSyXYVMqyXV6yd/iyXk2O8TvW1B0TD/
 sVRvt+NjreMOoi1DFdKelTpEDsYjSQw=
X-Proofpoint-GUID: w-QCkZmlElVJiHBq7x-Y6RYpFmKx1CrW
X-Proofpoint-ORIG-GUID: w-QCkZmlElVJiHBq7x-Y6RYpFmKx1CrW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_05,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607140240

This series addresses some pre-existing issues found in the
s390 vfio_ccw (dasd passthrough) driver.

Eric Farman (6):
  s390/vfio_ccw: fix out of bounds check on CCW array
  s390/vfio_ccw: limit the number of channel program segments
  s390/vfio_ccw: free all memory if cp_init() fails
  s390/vfio_ccw: copy maximum possible IDAL from guest
  s390/vfio_ccw: ensure index for read/write regions are within range
  s390/vfio_ccw: lock I/O resources alongside I/O regions

 drivers/s390/cio/vfio_ccw_chp.c     |  2 +-
 drivers/s390/cio/vfio_ccw_cp.c      | 58 +++++++++++++++++++++--------
 drivers/s390/cio/vfio_ccw_cp.h      |  7 ++++
 drivers/s390/cio/vfio_ccw_drv.c     |  2 +
 drivers/s390/cio/vfio_ccw_fsm.c     |  5 +++
 drivers/s390/cio/vfio_ccw_ops.c     | 13 ++++++-
 drivers/s390/cio/vfio_ccw_private.h |  2 +-
 7 files changed, 70 insertions(+), 19 deletions(-)

--=20
2.53.0

