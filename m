Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5EB346E55;
	Tue, 28 Jul 2026 03:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785209431; cv=none; b=O/A+SmZBV5B773fLvJyrBr9WdnMe1l1FwMl8tAs1xoaxfQv2svAgxfFxvZ+WK3hWh+oxzPfw9PRsWj4ZobefjxWrMhWrjsV8XdVxwsWOlFcvVyI0h/72yJ89oft5R1Djd1t441Q5DwD2YSRbfxaCi6cgLvT6KoWwi6lJ5uFxLmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785209431; c=relaxed/simple;
	bh=CkzG2irJTWae0cu56Fkgqk7cOduOVl6BsUme+I+JQNs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=unn7ZUzC/LgNAtiEh4SSVMEjjhJOGjdjuFuJmCLT4tbi3IdYzGM7iwHLfM7uFe3N06xl1lZDlXwniDjME6RvYeD/RHPYVs0o8SebXO9rfbOaFQPH8Z4Fmm+mp5O77eMbe9FLaBRH1tnec0GUivWXdTVK1Hztonk2Rpm6Zo2Yxns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=anwK3C8M; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="anwK3C8M"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66S0lxfJ3783825;
	Tue, 28 Jul 2026 03:30:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=l0wgYDHImUzB+wnsFFSgpyVE/Y967yhIS4sNmcb3q
	jw=; b=anwK3C8MGXFwuoIH2eMT63xbMpfzB/MvSw1JFCharHOJxQDcN5rjYJcH/
	Qob9Yqss6BskxgsGFz4qY+9bQ5/0rUe9s2Nmju9InwDLjEtAoJwnWD3n1uR6Oy0c
	wyCGjaNGC0ZLjO1C7csibmpMqCYQLp8e1NelWQfj33IazJc9aQaDrZWfYtX3Wu2o
	bhQ/tWCp2Q42YKZtLKusAA9q/jariTWdNIcudNDgLdD1JkmSXx1754o3jVzR69GW
	Is207dGiwzhdXw0TtB7SFfnvBZISZUYsmjn/1ArYG0HUD6y5Sm2tVwaq4Ab3ONjh
	zbBviBagGB6Ru3n+SEnB38WP3eOMg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0xk93m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 03:30:29 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66S3QQVa002950;
	Tue, 28 Jul 2026 03:30:28 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8yh80d4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 03:30:28 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66S3UOT927722464
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Jul 2026 03:30:24 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 42FA52004B;
	Tue, 28 Jul 2026 03:30:24 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2528520049;
	Tue, 28 Jul 2026 03:30:24 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with SMTP;
	Tue, 28 Jul 2026 03:30:24 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
	id 0FEB816162C; Tue, 28 Jul 2026 05:30:24 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>
Subject: [PATCH v9 00/10] s390/vfio_ccw fixes
Date: Tue, 28 Jul 2026 05:30:12 +0200
Message-ID: <20260728033022.2658232-1-farman@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Fop1ORBclNCt4Nt0KnOpCZySF5QUePsJ
X-Proofpoint-ORIG-GUID: Fop1ORBclNCt4Nt0KnOpCZySF5QUePsJ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDAyOCBTYWx0ZWRfX7HCxmCNfO5fP
 6WDyZjj1ayOv+gKGTjGb+hF/ZQH6725fA5U8yBfivcbaJRnyA5Z9q1HhcoFPI5qZzGTy0FjnViP
 cUdpo4d0HMUFmpym1PVvCvhYlPR3g8Q=
X-Authority-Analysis: v=2.4 cv=dYuwG3Xe c=1 sm=1 tr=0 ts=6a682255 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=vR5ihhkRQY44bnTQV1kA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDAyOCBTYWx0ZWRfX9TS73NZW7hDr
 H+Wotfgq0/rzEyCGw0etns47SZswM1dq7hj5eZ/SRZn/jjNhqykfcbf5EciUasTdmAlpuw2PCCV
 fJjbxUrhMwXKCygyuMBdeXqbA1Grwrd98a8Ug9pyZpGwpBYmzx+t2/yrutRKJtL94fJ8w+6sM0J
 d50UY1DCjwTkScZ6H0kDFJF4k9jwtM2XbvpmfMRDx2gbQRDRYPyIT7nIQJHqcsymtakqlTrkhyp
 r3I5H4LcBszZnQwQjkz/Tl1Z1vxvEGF5hBqiaKVtQXnGCw//UyfAWET8Pl8t4JIyh3fOvzwrWWM
 OONp+2lqQPvWNTzfEam3KmYnWXnYrS0QslHABchgIZbmFmehI74LiYWd9sz4I16Ije0QGNNgaOu
 srGGFazqAsVr6sebThdJidcyxRiPg3XUX83ku9ClmllsczYGJFMlo9XI5xb2HyRkZKpSGKX/oBY
 rCfKGhr1EkHUaKNglWw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_07,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 phishscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280028

This series addresses some pre-existing issues found in the
s390 vfio_ccw (DASD passthrough) driver.

Patches 1-6 are identical to v6/v7/v8
Patches 7-10 have minor changes compared to v7/v8

v1: https://lore.kernel.org/r/20260714232208.1683788-1-farman@linux.ibm.c=
om/
v2: https://lore.kernel.org/r/20260720201931.976660-1-farman@linux.ibm.co=
m/
v3: https://lore.kernel.org/r/20260723174751.1180334-1-farman@linux.ibm.c=
om/
v4: https://lore.kernel.org/r/20260725152705.3958100-1-farman@linux.ibm.c=
om/
v5: https://lore.kernel.org/r/20260726040129.2946151-1-farman@linux.ibm.c=
om/
v6: https://lore.kernel.org/r/20260726172153.1818056-1-farman@linux.ibm.c=
om/
v7: https://lore.kernel.org/r/20260727192230.2715207-1-farman@linux.ibm.c=
om/
v8: https://lore.kernel.org/r/20260728013509.1551753-1-farman@linux.ibm.c=
om/
v8->v9:
 - [MR] Added r-b (thank you!)
 - [MR] Commit/comment message improvements
 - [MR/sashiko] Re-add workqueue cleanup to vfio_ccw_mdev_release_dev, in=
 the
   form of a flush_work() call

Eric Farman (10):
  s390/vfio_ccw: free all memory if cp_init() fails
  s390/vfio_ccw: limit the number of channel program segments
  s390/vfio_ccw: fix out of bounds check on CCW array
  s390/vfio_ccw: ensure first IDAW remains constant
  s390/vfio_ccw: calculate idal length based on idaw type
  s390/vfio_ccw: ensure index for read/write regions are within range
  s390/vfio_ccw: cancel existing workqueues
  s390/vfio_ccw: move cp cleanup out of not operational
  s390/vfio_ccw: selectively expand io_mutex
  s390/vfio_ccw: implement a crw lock

 drivers/s390/cio/vfio_ccw_async.c   | 16 +++++++
 drivers/s390/cio/vfio_ccw_chp.c     | 31 ++++++++++--
 drivers/s390/cio/vfio_ccw_cp.c      | 74 +++++++++++++++++++++--------
 drivers/s390/cio/vfio_ccw_cp.h      | 10 ++++
 drivers/s390/cio/vfio_ccw_drv.c     | 21 +++++++-
 drivers/s390/cio/vfio_ccw_fsm.c     |  8 +++-
 drivers/s390/cio/vfio_ccw_ops.c     | 39 +++++++++++++--
 drivers/s390/cio/vfio_ccw_private.h | 10 +++-
 8 files changed, 176 insertions(+), 33 deletions(-)

--=20
2.53.0

