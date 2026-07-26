Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46471E5714;
	Sun, 26 Jul 2026 17:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785086524; cv=none; b=QzWopGTubg0rY8uReVdSpF/ZQb41/Sg79CNKlk/XP9igalNWhvBaNLeTAPF6RLdPGL0mTv4Oqt6SrWlegX/GTbb3t/U+3Tg5q6MsuXJwjekuRH2rcwN+daoXmzGFAKhRAQXCJ13UA2kJ7/TCpoKdYJXOkS/6LdSUwia5ulXAzq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785086524; c=relaxed/simple;
	bh=UtHgudZM8EKJmbiX94Yaf3ibGOtomRCN6QNzwLI0xRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qzNJW0Yxu6QOZHSb4Fv9bkwt6H3Engt2GIZBU2cjWSFXCXiYmNpVhoU3fxnZOkmdSJf5UkCQJ1JkpBIMUwaxnZH2FK5LJ6f7DJB9a8ga6S8sUBuwE7yCe2JJ6lXxhKqUzc8bbDVSW2IDOXeCAUnm+7XO/TQHAor52JSQAdXbmfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=glJ34pNo; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="glJ34pNo"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66QHIQ5f4079457;
	Sun, 26 Jul 2026 17:22:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=mcmjq+mu1+EfRZ9j5+atEZHPcmiK3BOQsgB2mUQTT
	pA=; b=glJ34pNowiwm3TIUBxi4KEZVuWrl6wLOnuQvgRtH3unFLcRvdUrIOT2mo
	tkK3hBDilodePONURgI3FM4E1o0RYGy/QYougyw+Ckl7/aL/jW6JYVRVKHamOhzQ
	sYVcDCgFKQF23mb7/4NgtMCZ2zYOaJVpzmzskt4wj8P5B0JHQGg8M4GWqyD4OVFM
	HyeMQ1sTaIpzo6mpAvr+B/4swRQmqxIFpp1fJzrdFVoUJCFVuymBu5twjoX32qVu
	J4xw4TGrzHc6DCnbILYYlKUulyNDJq3Man8qjG3aktu8vwECcU/pgliJA2aSsMMr
	KOhrcQeH29Lu3oLhBPyCzNPTWYuuA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuwcm46d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 26 Jul 2026 17:22:01 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66QHBbHV007992;
	Sun, 26 Jul 2026 17:22:00 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fna5xsy38-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 26 Jul 2026 17:22:00 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66QHLuSL48562622
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 26 Jul 2026 17:21:56 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BAFE120071;
	Sun, 26 Jul 2026 17:21:56 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 998F32006E;
	Sun, 26 Jul 2026 17:21:56 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with SMTP;
	Sun, 26 Jul 2026 17:21:56 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
	id 7DC70160392; Sun, 26 Jul 2026 19:21:56 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>
Subject: [PATCH v6 00/10] s390/vfio_ccw fixes
Date: Sun, 26 Jul 2026 19:21:43 +0200
Message-ID: <20260726172153.1818056-1-farman@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: QvZSceEkiRdNheE7PWHaRy54nhe1X0Qi
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI2MDE3NSBTYWx0ZWRfX/AK0gqB360O+
 6+MZy5VSHKzLHAL8Mq9ZUiq/AQP35yO3pepjRzaygHMr+NRqxeNZlSiPdhV6FoH3KP67u7xuWcn
 6FHo/XFAqTKYaHyCgrlCgobIhPZsO9E=
X-Authority-Analysis: v=2.4 cv=E/z9Y6dl c=1 sm=1 tr=0 ts=6a664239 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=Xq2SPA-IMpQdQLpMtacA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI2MDE3NSBTYWx0ZWRfX1hnIekvtsDvY
 ENmVf0zcH3U/8oXUo8r+rjR3G2LJZTp3kUSj38xAuEd6L2sxRNuTgm2AdvruXSCj6iVTv4LfzXp
 PIy1L4eXmpBoU/SXAisdXpYKO7rySqaqzx2nDMvOnAYJVAbF89NE/MV9xEVdcy8qE5xWfGnfTw7
 Luv9/zy05ZYWxGLn1vDEnVqLEOUk6Zf6yTEr8yw3nwkW+x/MJyWo8e27wKX6D4unO8biESJfijC
 m7muonE39yjmpPXAlbCnhxUU/zcpZY83Z5RtI+0gj1L9PbxDF02/CNaTWzT9LbLD+48l2cYWgpG
 gSg+zk6YArXvQr4jzktKh5DypOAp7H6L2th/K6m/+XGIJ7tUNaCMtgsbJ8ArCHsERLWZMrTbLlS
 +A9ptf6mfl/bMfsyWacbkdpJFIXg3ZD+ENkkcBQo9ObAl6kjoxCLCNaHZ+MeqGEBYwPOQCUxwA0
 MRdUpaEato1dRtejySA==
X-Proofpoint-GUID: QvZSceEkiRdNheE7PWHaRy54nhe1X0Qi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-26_05,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607260175

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
v5: https://lore.kernel.org/r/20260726040129.2946151-1-farman@linux.ibm.c=
om/
v5->v6:
 - [sashiko] Add cancel_work_sync() to vfio_ccw_mdev_close_dev() as the "=
usual"
   cleanup, and keep them in vfio_ccw_mdev_release_dev() to cover corner =
cases
 - [MR; offlist] Remove the proposed notoper_work queue, and move the cp_=
free
   from the FSM to vfio_ccw_mdev_close_dev() to ensure we cover the case =
where
   a device becomes not operational (due to sch_event) while I/O is in fl=
ight.=20

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
 drivers/s390/cio/vfio_ccw_drv.c     | 10 +++
 drivers/s390/cio/vfio_ccw_fsm.c     | 23 ++++---
 drivers/s390/cio/vfio_ccw_ops.c     | 40 ++++++++++--
 drivers/s390/cio/vfio_ccw_private.h |  7 +++
 8 files changed, 191 insertions(+), 42 deletions(-)

--=20
2.53.0

