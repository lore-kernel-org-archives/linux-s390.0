Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85F53783C7;
	Sun, 26 Jul 2026 04:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785038517; cv=none; b=JiiaUFO0P0IhH21eowZIwDpQPcDqMae9i7oR3HgbC+gIzDza6t61QGQGQJusiCYiI59tiCW+Pva5WAhK5plPHRmd/ASDHkC4a1+rv+VmOcBsKyz0OTUNn/IyZ8yArPiDteGVMR6x3RNNHmZPNQWAoBtilwfog52dRNhgQzsyt0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785038517; c=relaxed/simple;
	bh=tBqNqe3c0BcZwM2Uwx3S0Bli57hl5JMuIlHGBKf6fKI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Rq+CL0O4AS3llUcvScpfhIqoNMbv5QOZdq9rA9shjVSSAQ+utyZuMIbhS60YvjkSm50SIhrmBCqTBhZkF/NLjuAIjsnAZB1KrkkcJ3YETJZ6ExgIgdodAlXNYg2SldMtglO16EIF4yOZtXisNabYcQJycty2oj3PYl+OqZEuMHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FHZcX8pW; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FHZcX8pW"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66PNIwAq1914477;
	Sun, 26 Jul 2026 04:01:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=KoaSCttseZ9qjM5hoR3UdX3GyV3YubYFg0u7FONih
	J0=; b=FHZcX8pWzW1pzfnD94w+RHXtWSW0MUVmQfrpDN8HSCQbbKJMWa66tQZ+0
	hwrAqZcBYrOTMVwc0OlxMHxLuonA1bofNIfYd0zQ7l5xIkAAeA5813yAg+NqXsYx
	IPSBjxJI5McBDTBL/rZVfbeZ2zGHZA3seLL5oQkbohkl4b6VPlI0sci9MFdkGBl9
	W5jjWjzUpZqbSJ3SINjymPbCEvImC/ucMrERHwg9E7hMnkUBGpHr3jebqUvR/gp6
	jrKXaFjrt5xNakljkhvGNn02XJAQH5CeogOLp55r6T6OC5LxPoAs5R2zupHpI1ev
	dX02ErxAzBFVdhNv61/xqGqVnLvcg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuw72brm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 26 Jul 2026 04:01:55 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66Q3uRAn009026;
	Sun, 26 Jul 2026 04:01:54 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fna5xr2r0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 26 Jul 2026 04:01:54 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66Q41ovU46334378
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 26 Jul 2026 04:01:50 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0336C200C5;
	Sun, 26 Jul 2026 04:01:50 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7913820191;
	Sun, 26 Jul 2026 04:01:35 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with SMTP;
	Sun, 26 Jul 2026 04:01:35 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
	id 1AA8C1612C9; Sun, 26 Jul 2026 06:01:32 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>
Subject: [PATCH v5 00/10] s390/vfio_ccw fixes
Date: Sun, 26 Jul 2026 06:01:19 +0200
Message-ID: <20260726040129.2946151-1-farman@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 1H_HAFsLa3GtGuJxWXjaDiPh_KB84obZ
X-Proofpoint-ORIG-GUID: 1H_HAFsLa3GtGuJxWXjaDiPh_KB84obZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI2MDAzMyBTYWx0ZWRfX1x15GhLj1ou9
 jMNAQ8tnAaUXaQEg3KUkM7+jj65LMKMNREmoCmp7W2oDutl8OVCz9lhP2K+HdGZ/3oyL08W0k07
 LMngpU6hWJWQVC+z7czwW7d8+42nOdR9TQEg6F4hTNhH4YpfYOFeNLHASMkYHI8RbboYcWxW/ZJ
 gzoD6KvWJzVpGWGNH1tTfvZ+nrQQPaiky2DmhygeqoecmPtf1RT3SF63Nfr+18KLr5EX5Qltp37
 CnC3nOs7Uo4ZRYOB2ydYZRRZAaVZ4wv1ECZOsy2wnPyN5jNVYg9imgaoOx8Nk/zx9gjKqXrAGDw
 D7C2MXqOIJ04m0dVWDlA6f1Yr0JyiNRezZpZTtBTVwmjXG/8lu3K1dbZFZNsymeVhzsf82JtEwO
 UYU6pBl3ideX7LPYjsJu1t/CM8IOsgeV3paed7sNlTf2RIVYc3477KTmaGlFnkei1YTDxIbJfBS
 EjlFGp8nBCaab2KKMcA==
X-Authority-Analysis: v=2.4 cv=SKFykuvH c=1 sm=1 tr=0 ts=6a6586b3 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=n-mabKtkLk_wMGDdTDcA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI2MDAzMyBTYWx0ZWRfX4MmYReKuUC9U
 h2I6epjJ6Yj4U2NNnuDXTA0IAqdGCxdQ7oemhpw6D+9YtuUWVJ7iMm4fBqaBcQUYGP/OHUc69Ki
 grFRyM5JzxHvSMjMsLEg7GZDkQ3nlaM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-25_07,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607260033

This series addresses some pre-existing issues found in the
s390 vfio_ccw (DASD passthrough) driver.

v1: https://lore.kernel.org/r/20260714232208.1683788-1-farman@linux.ibm.c=
om/
v2: https://lore.kernel.org/r/20260720201931.976660-1-farman@linux.ibm.co=
m/
v3: https://lore.kernel.org/r/20260723174751.1180334-1-farman@linux.ibm.c=
om/
v4: https://lore.kernel.org/r/20260725152705.3958100-1-farman@linux.ibm.c=
om/
v4->v5:
 - [MR] Added r-b where provided (thank you!)
 - [NEW][MR] Call cancel_work_sync() for existing workqueue structs
 - [MR] Add cancel for new notoper_work workqueue
 - [MR] Commentary change to definition of crw_lock
 - [EF] Acquire/release crw_lock with irqsave/restore

Eric Farman (10):
  s390/vfio_ccw: free all memory if cp_init() fails
  s390/vfio_ccw: limit the number of channel program segments
  s390/vfio_ccw: fix out of bounds check on CCW array
  s390/vfio_ccw: ensure first IDAW remains constant
  s390/vfio_ccw: calculate idal length based on idaw type
  s390/vfio_ccw: ensure index for read/write regions are within range
  s390/vfio_ccw: cancel existing workqueues
  s390/vfio_ccw: move cp cleanup out of not operational
  s390/vfio_ccw: implement a channel program mutex
  s390/vfio_ccw: implement a crw lock

 drivers/s390/cio/vfio_ccw_async.c   | 16 +++++
 drivers/s390/cio/vfio_ccw_chp.c     | 31 ++++++++--
 drivers/s390/cio/vfio_ccw_cp.c      | 96 ++++++++++++++++++++++-------
 drivers/s390/cio/vfio_ccw_cp.h      | 10 +++
 drivers/s390/cio/vfio_ccw_drv.c     | 21 +++++++
 drivers/s390/cio/vfio_ccw_fsm.c     | 23 ++++---
 drivers/s390/cio/vfio_ccw_ops.c     | 26 ++++++--
 drivers/s390/cio/vfio_ccw_private.h | 10 +++
 8 files changed, 192 insertions(+), 41 deletions(-)

--=20
2.53.0

