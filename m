Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F99126D4CA;
	Mon, 20 Jul 2026 20:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784578780; cv=none; b=bo2iT36yFRQ4kLBDqa73IxoM0O0xfPZORicEPmpM7jJ6GTWwRR7IXFKFd8h7pOlZHhYE2ZIE6GX3LiYF0d3cuH7qyDf9zshLKyZ1crsCB/R4o+DLZS2pX+MvgJnqyvh+caO5tS5aO0fK34PQNkHGfaJA0ClCecq1AxJvX7rZ4cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784578780; c=relaxed/simple;
	bh=4I1wUmUBIz0jacpzYTCpj8R5M0W0uoqKVedUeTRoM04=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tnB7aUYf9Qm0HeiDeveMGV2H4+DgUpDQl4afS602m6rpMI6kwTWVR1U0n9Og1084d5Y9pAX63nuD0QdjjbLRjr9gxvi0vDe6yIn+mmB3+qLZZViLR5FMQATuSDscdEOPLoaLk1jRloqwtSfeMGvwkyXOpfgkdsOF75qMxSs0aQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cyym8QP/; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cyym8QP/"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66KJfcVM1245764;
	Mon, 20 Jul 2026 20:19:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=tfqYSOVOv7zXTNXPWb2fpb2fa/fSNjZxrNS5H2Hei
	7o=; b=cyym8QP/Em98nrWtD39e9U1l4CXvKi36FIeFae6tMqVmUpAzIlyuIJPDB
	mnNYVeJ1hT6l52VCMdi0CyDZ29tPRuD28J9w7e0jgVmmTAP6GMOcT+YFc2KdatJZ
	66zbtaQ67dtO/uigSjI2RBCXWQcLzeED0BATwRDBWyQ/JPGAdNaNhEwmtCWOSQas
	fTRnK8OfrrnyhKGA6u8cXtr8Uy2UfyOB8Xt0vX5jnPBuwe4pqXgjayDXZ8ibnnNL
	mtN8DGsmsN89ENRz5MmNKmgNqN1AW+dcqOf+vaedrVsA6QAXaVf/7nO4CwK/FQO/
	fU7mcKZ5DV+Q12BJmz8MdcPNJzr4w==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg77a9btf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 20:19:38 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66KKJbZs030481;
	Mon, 20 Jul 2026 20:19:37 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgnagy5n5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 20:19:37 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66KKJXTs51642674
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Jul 2026 20:19:33 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E93BA2004B;
	Mon, 20 Jul 2026 20:19:32 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CE39A20040;
	Mon, 20 Jul 2026 20:19:32 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with SMTP;
	Mon, 20 Jul 2026 20:19:32 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
	id B62BF162734; Mon, 20 Jul 2026 22:19:32 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>
Subject: [PATCH v2 0/7] s390/vfio_ccw fixes
Date: Mon, 20 Jul 2026 22:19:24 +0200
Message-ID: <20260720201931.976660-1-farman@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: n-GSdTVO6QJ-kr42DgJErN0W8PGSSFYs
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDIyMCBTYWx0ZWRfX/acycHgldmV1
 W2qGnFA+2hcfwc03eEggV/LWMj9kLBOzVxUPQZ6slrRkvOPVarbf+9f0dyVaaVxYYNWcTHN08wG
 ocPG4ycIYKXAxo0RfKM4g8R0dFRBFGs=
X-Proofpoint-GUID: n-GSdTVO6QJ-kr42DgJErN0W8PGSSFYs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDIyMCBTYWx0ZWRfX92d/4/IZ6uQt
 3RBj9X87BUGPtHFToC0iMYfQ6H4KXsZyA8iWRTwjtfqtX5hY4Zq7ukFnEiw5C2iX7g23d60Z5/O
 XEpLrWBmFx4rbpbfvWp8h0wJj4IDK/YrPS84yiwD6sELpDZbMvE0ivToVBIhYX2TvHVjduxhfUP
 A20g8rZWOYDwNPgXW4Bg1Cehwkw7UOLH7zI94HVz0zRsLjdXzSSAYMH1AiGvOLQB91/2gUQXiWO
 47vnHVHKCHNkSCLMndMAocHAr3YeRdILm7DXsrQ5AMEJxP0OAepLRzV99JkBI/i+0kI3lXNaIZ5
 O9dQDhyWl0jR+Nv9kkBeqz/nVIw4Lm4lmmVSy2fA/M1JRGFZav5VA4JKLJK85tNV+ZlyF38zCpD
 Qeha0M/lGvMVDVhnX2eq46ZxEbsEqApKyyprWLTdJl0OhglplYnI5FZ3EVJdPcb7SeRHgHzR6IF
 hf1SWUK2g72BwPjiNSw==
X-Authority-Analysis: v=2.4 cv=K7AS2SWI c=1 sm=1 tr=0 ts=6a5e82da cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=cNBfgpkUG3sC7fz4_G4A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_05,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 phishscore=0 malwarescore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607200220

This series addresses some pre-existing issues found in the
s390 vfio_ccw (DASD passthrough) driver.

v1: https://lore.kernel.org/r/20260714232208.1683788-1-farman@linux.ibm.c=
om/
v1->v2:
 - [sashiko] Reorder patches to put the cp_init and channel program segme=
nt
   pieces at the head of the series
 - [sashiko] Fix the out of bounds array check to break the loop correctl=
y
 - [sashiko] Move the nospec clamp to the default case, rather than the
   entirety of the switch statement (to keep it in the default leg of the
   switch where it's used, rather than outside the entire switch)
 - [EF] Return -EINVAL if ccwchain count is exhausted, instead of -ENOMEM
 - [EF] Drop calc_max_idal_len() logic in place of a comparison against
   idaw[0] before/after the pair of vfio_dma_rw() calls=20
 - [EF] Implement two new spin locks, one for struct channel_program in
   struct vfio_ccw_private, and one for the list of CRWs in struct
   vfio_ccw_private.

Eric Farman (7):
  s390/vfio_ccw: free all memory if cp_init() fails
  s390/vfio_ccw: limit the number of channel program segments
  s390/vfio_ccw: fix out of bounds check on CCW array
  s390/vfio_ccw: ensure first IDAW remains constant
  s390/vfio_ccw: ensure index for read/write regions are within range
  s390/vfio_ccw: implement a channel program lock
  s390/vfio_ccw: implement a crw lock

 drivers/s390/cio/vfio_ccw_chp.c     | 15 ++++---
 drivers/s390/cio/vfio_ccw_cp.c      | 67 +++++++++++++++++++++++++----
 drivers/s390/cio/vfio_ccw_cp.h      |  8 ++++
 drivers/s390/cio/vfio_ccw_drv.c     | 10 ++++-
 drivers/s390/cio/vfio_ccw_ops.c     | 13 +++++-
 drivers/s390/cio/vfio_ccw_private.h |  4 ++
 6 files changed, 101 insertions(+), 16 deletions(-)

--=20
2.53.0

