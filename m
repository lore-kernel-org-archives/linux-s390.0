Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C1F24A7C1;
	Wed, 15 Jan 2025 19:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736970942; cv=none; b=qrUiaYkpbyKZqlRZ9pGkoICSleaIemZBZk2mpXauNTb+siIGO62nsg9l5lVbtWyTwPA0yuC1P/ZLwoe2qDnhoxqbgm7cQgvfDVz2Te4fBRrvZ0WCNzaGlo1j43QpR3IuqGvBho3jD1+Tq9DG3zldodl1Rna5a/XkgmDEnLfEdMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736970942; c=relaxed/simple;
	bh=URER+ve/7o8bQ14HVZNkSBa842yhHjcwBvGZsIFEZlQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=akUMYSzuG/3pV2+79yRIPhBZcmRD3n/Pr5Qy9jTzgCzKJSkcbAUwmzxLE5JlOd4XtFT0FJFdvYcCX4OJdQ6+6zEXq7+deW5QnG3kOnG+sphgxm+h+hYpWM9mEatEKe1j3bAQU52WEfHeJsn61+1lm+5ZIStKEUUp9OErowhChOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=c0k7c6+J; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="c0k7c6+J"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50FHX5ro024459;
	Wed, 15 Jan 2025 19:55:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=zz1mtA76pjWNB2+5P+/yRtrpc8/inj9rL6PnXi62/
	gw=; b=c0k7c6+J4E0BS1NeZPF0p8vh0fWm/mrIB/KXSqC000afzvs/Nq5LG7G2L
	9/tCr3hS4mPUAcC3Dog4h8lYWeJbIhxfQk4icx34rMbDQm+8DTtGCaZTyesxHHIp
	Q1XY/BdTwXK5fvQV2Q0GEPlyrnk7wHvUrQppWdHyW9RfnhZFZUNIRvFRqFXfKwg3
	69rL7ENS7o5EIaTnlpP3ppHFO936u+H8fxeSEMeOcj24lfqryLTP4TmzoRSrpA7L
	F8HmIe6dxMzvPut2AXEppslvuaM5kl7Ztl6ycKSjbnOIjk3ooTfuOEbYe13Kjla0
	AlRvIxqvjKTzy7yui5ddOwgx8FPGg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44622hw1qu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jan 2025 19:55:32 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50FJd95h003960;
	Wed, 15 Jan 2025 19:55:32 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44622hw1qq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jan 2025 19:55:32 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50FJ4taS000881;
	Wed, 15 Jan 2025 19:55:31 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 44456k1xbk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jan 2025 19:55:31 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50FJtRb720251046
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Jan 2025 19:55:27 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A2A2D2004D;
	Wed, 15 Jan 2025 19:55:27 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8B49720040;
	Wed, 15 Jan 2025 19:55:27 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 15 Jan 2025 19:55:27 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55271)
	id 42BCBE0394; Wed, 15 Jan 2025 20:55:27 +0100 (CET)
From: Alexandra Winter <wintera@linux.ibm.com>
To: Wenjia Zhang <wenjia@linux.ibm.com>, Jan Karcher <jaka@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>,
        Alexandra Winter <wintera@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        "D. Wythe" <alibuda@linux.alibaba.com>,
        Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Julian Ruess <julianr@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Thorsten Winkler <twinkler@linux.ibm.com>, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Simon Horman <horms@kernel.org>
Subject: [RFC net-next 0/7] Provide an ism layer
Date: Wed, 15 Jan 2025 20:55:20 +0100
Message-ID: <20250115195527.2094320-1-wintera@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: L9m9kQyoFocGi9G-ZwsiY007MA63nxFB
X-Proofpoint-ORIG-GUID: idMy6fx94ESkuPMl_ny886V02hr6NbDG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-15_09,2025-01-15_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 impostorscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 mlxlogscore=999 malwarescore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501150142

This RFC is about providing a generic shim layer between all kinds of
ism devices and all kinds of ism users.

Benefits:
- Cleaner separation of ISM and SMC-D functionality
- simpler and less module dependencies
- Clear interface definition.
- Extendable for future devices and clients.

Request for comments:
---------------------
Any comments are welcome, but I am aware that this series needs more work.
It may not be worth your time to do an in-depth review of the details, I am
looking for feedback on the general idea.
I am mostly interested in your thoughts and recommendations about the general
concept, the location of net/ism, the structure of include/linux/ism.h, the
KConfig and makefiles.

Status of this RFC:
-------------------
This is a very early RFC to ask you for comments on this general idea.
The RFC does not fullfill all criteria required for a patchset.
The whole set compiles and runs, but I did not try all combinations of
module and built-in yet. I did not check for checkpatch or any other checkers.
Also I have only done very rudimentary quick tests of SMC-D. More testing is
required.

Background / Status quo:
------------------------
Currently s390 hardware provides virtual PCI ISM devices (ism_vpci). Their
driver is in drivers/s390/net/ism_drv.c. The main user is SMC-D (net/smc).
ism_vpci driver offers a client interface so other users/protocols
can also use them, but it is still heavily intermingled with the smc code.
Namely, the ISM vPCI module cannot be used without the SMC module, which
feels artificial.

The ISM concept is being extended:
[1] proposed an ISM loopback interface (ism_lo), that can be used on non-s390
architectures (e.g. between containers or to test SMC-D). A minimal implementation
went upstream with [2]: ism_lo currently is a part of the smc protocol and rather
hidden.

[3] proposed a virtio definition of ISM (ism_virtio) that can be used between
kvm guests.

We will shortly send an RFC for an ISM client that uses ISM as transport for TTY.

Concept:
--------
Create a shim layer in net/ism that contains common definitions and code for
all ism devices and all ism clients.
Any device or client module only needs to depend on this ism layer module and
any device or client code only needs to include the definitions in
include/linux/ism.h

Ideas for next steps:
---------------------
- sysfs representation? e.g. as /sys/class/ism ?
- provide a full-fledged ism loopback interface
    (runtime enable/disable, sysfs device, ..)
- additional clients (tty over ism)
- additional devices (virtio-ism, ...)

Link: [1] https://lore.kernel.org/netdev/1695568613-125057-1-git-send-email-guwen@linux.alibaba.com/
Link: [2] https://lore.kernel.org/linux-kernel//20240428060738.60843-1-guwen@linux.alibaba.com/
Link: [3] https://groups.oasis-open.org/communities/community-home/digestviewer/viewthread?GroupId=3973&MessageKey=c060ecf9-ea1a-49a2-9827-c92f0e6447b2&CommunityKey=2f26be99-3aa1-48f6-93a5-018dce262226&hlmlt=VT

Alexandra Winter (7):
  net/ism: Create net/ism
  net/ism: Remove dependencies between ISM_VPCI and SMC
  net/ism: Use uuid_t for ISM GID
  net/ism: Add kernel-doc comments for ism functions
  net/ism: Move ism_loopback to net/ism
  s390/ism: Define ismvp_dev
  net/smc: Use only ism_ops

 MAINTAINERS                |   7 +
 drivers/s390/net/Kconfig   |  10 +-
 drivers/s390/net/Makefile  |   4 +-
 drivers/s390/net/ism.h     |  27 ++-
 drivers/s390/net/ism_drv.c | 467 ++++++++++++-------------------------
 include/linux/ism.h        | 299 +++++++++++++++++++++---
 include/net/smc.h          |  52 +----
 net/Kconfig                |   1 +
 net/Makefile               |   1 +
 net/ism/Kconfig            |  27 +++
 net/ism/Makefile           |   8 +
 net/ism/ism_loopback.c     | 366 +++++++++++++++++++++++++++++
 net/ism/ism_loopback.h     |  59 +++++
 net/ism/ism_main.c         | 171 ++++++++++++++
 net/smc/Kconfig            |  13 --
 net/smc/Makefile           |   1 -
 net/smc/af_smc.c           |  12 +-
 net/smc/smc_clc.c          |   6 +-
 net/smc/smc_core.c         |   6 +-
 net/smc/smc_diag.c         |   2 +-
 net/smc/smc_ism.c          | 112 +++++----
 net/smc/smc_ism.h          |  29 ++-
 net/smc/smc_loopback.c     | 427 ---------------------------------
 net/smc/smc_loopback.h     |  60 -----
 net/smc/smc_pnet.c         |   8 +-
 25 files changed, 1183 insertions(+), 992 deletions(-)
 create mode 100644 net/ism/Kconfig
 create mode 100644 net/ism/Makefile
 create mode 100644 net/ism/ism_loopback.c
 create mode 100644 net/ism/ism_loopback.h
 create mode 100644 net/ism/ism_main.c
 delete mode 100644 net/smc/smc_loopback.c
 delete mode 100644 net/smc/smc_loopback.h

-- 
2.45.2

