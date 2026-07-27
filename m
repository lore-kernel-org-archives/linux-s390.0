Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41E83CF670;
	Mon, 27 Jul 2026 19:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785180165; cv=none; b=J/fynb/0FBVLDRsm3IWvr49hDmkjJ2Wi3Q9n4VA58NVhccr8pIkDdN0wjYhBjnzGWfVPK67caCGX4S0xb9utNvDCQMpkieFyVCZXNuAxUB0/Hfk3AFzqr+V23pYklL4ikz4wZH3o1Wm2wBcIwnVwE5KZK0UCg/IzXrn2aF1gnFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785180165; c=relaxed/simple;
	bh=s+Cg5L61UmhSnoTa+iUaBbZDY8THcaErXU2k+QFxDCU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QcH2vZvhnvYY8/GzNrncIvcFrX9GaC8TE2FSJyLfPl+zuBAb+cmP9YmdwDtQ70PBeoTqutGWov3GhODCenfYcA7V5kSwNMqdbtOT8rDHyBagv5LTKITnUkeDRsdsxL+GssNYr/O7olHzfdS+bAWZoSeHotVe5oNFiwiVSgKkOlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DQG9+kGn; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DQG9+kGn"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RII22W1096250;
	Mon, 27 Jul 2026 19:22:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=xnx/ElIVcA06ZDm+y6zDlO00ZG+8TNBl0to14mSSg
	1c=; b=DQG9+kGnE+LNmC+An66nDw+VXYnHCZ+8UbXQ+CU9oOxcd+1sf9vKimqTF
	0rM98nc5ZXj5yrcmSgi5zl2k4NZb50Eoyrdxo+wRqB8hRk5n4DeoWDQHtebb2zfy
	wYItoiSp/8x/9o0paaEw9cWoIMS70uhAy8IdLmOhKMbe/79dWI4gVWxRaCYeIiZq
	lbDtOkawVQRdvPCALxnkXxQhUfXzaJl+S5sUGiX6Uw95sbSDmdzhOAk8ou8VZ+S6
	pmevh1ro6pZBdA3e7HdqbZEQHIR+qL+1zPyIickhWjqrIOUPUhmyFJ20vCssBWNI
	h9/j9Ti3ejMJBMuEFl1nLDvuU3iQA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyc9prk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 19:22:41 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66RIug1a010974;
	Mon, 27 Jul 2026 19:22:40 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn9pg6gpp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 19:22:40 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66RJMbjE47776082
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jul 2026 19:22:37 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F05A2200B5;
	Mon, 27 Jul 2026 19:22:36 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CEC9D200B3;
	Mon, 27 Jul 2026 19:22:36 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with SMTP;
	Mon, 27 Jul 2026 19:22:36 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
	id B53981627F0; Mon, 27 Jul 2026 21:22:36 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>
Subject: [PATCH v7 00/10] s390/vfio_ccw fixes
Date: Mon, 27 Jul 2026 21:22:20 +0200
Message-ID: <20260727192230.2715207-1-farman@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: GVDecPt5rE3Qn54_Nn8W4H-PaaNcYsFm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDE3NyBTYWx0ZWRfXwymugm6FYFkH
 21YKsrZkO1aU7s/UlKDsE/8n3X9DQG8QZw2JZ464rfa932mll/MLe6TT4hIlSvbwGqW3uNg0awr
 eJei0+v/Kwe8J8DcSHB11EaeuxLHjzI4d5K0Fp7S1zjeOL5nUZsIjp3tznJ3ujI7DgRDnItHarc
 qv6PldJZE9Go68ey22puzHtc7FtPAb0aKdrD6n2Y9qCbri/JGLNMze8nDyVKYUQXnAV1L3FRSHe
 EE7PTSZCxHFbZ2VCOo3ywzhPv7Z5Wi41OexQM7RZDfxgHQJoTxAu7UEaNg6orhuQTSvc9BJW3Rc
 D8vnTr80hibflQcuO2wLND9poBHO2HkHRX/i8vGRrQ4dZh6Lf7i7QN6jCp/6fNvqDVILucbqcZ3
 +VOQZYIwZcBrTJYdQK8ITdsxwDudSZ41xyD1JXVUZZ20z4rCukCRoMuBQU0uIU6k4GN04m8kRE2
 n5kGFQvG7CIb7Y+Kqow==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDE3NyBTYWx0ZWRfXzthk8QTDcFw4
 dtJyGN57xG4I5j2My+QZTnTI8QY0IJ9f7/T0bzabIAN8Ll1MTqphyGToHSji782PK/mc+hOHAXL
 UiecV1rCjly9EZmcFMN35pOBUidgbvE=
X-Authority-Analysis: v=2.4 cv=AZeB2XXG c=1 sm=1 tr=0 ts=6a67b001 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=Xq2SPA-IMpQdQLpMtacA:9
X-Proofpoint-GUID: GVDecPt5rE3Qn54_Nn8W4H-PaaNcYsFm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_05,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270177

This series addresses some pre-existing issues found in the
s390 vfio_ccw (DASD passthrough) driver.

Patches 1-6 are identical to v6.
Patches 7-10 are a continued attempt to improve access to private->cp .

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
v6->v7:
 - [sashiko/EF] Replace the cp_mutex idea (from v3+) with an expanded use=
 of
   io_mutex (as in v1), but with the workqueue idea for the FSM not-opera=
tional
   case that was added in v5

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
 drivers/s390/cio/vfio_ccw_ops.c     | 22 +++++++--
 drivers/s390/cio/vfio_ccw_private.h | 10 +++-
 8 files changed, 159 insertions(+), 33 deletions(-)

--=20
2.53.0

