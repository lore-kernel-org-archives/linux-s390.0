Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2C1377A87;
	Mon,  3 Aug 2026 10:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785751664; cv=none; b=FRenj0cjhpXRpKabYEeHf7J8Q8pbC5wempNnTKePZbDKzkXuazJy1Zn2x9MoNt9QSNcoOmSQ1yfL2KpK7lguiCS/jASb0UVMK1re8FkZ1jx5feb/vf9gC+fLpKx1Zme9sWkf8jN8vvnvrlsTXepSyUPnJrKeD1uJFfJAcG0lX6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785751664; c=relaxed/simple;
	bh=6CuPsNKDYTTktILCQvu+n3fNh2A5ABYDCWla/BB4GbE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rq9rysmPc+88n1yWQ61usb4TY3tHBDmtEasX9n5tlOlYgyACdEJM1USpn5z6OUQEj054vsfJXFLLIYmWqEIqw4qlP2r4ve2zz+UD45wxm09GxYs2V37KiGRp5ZE9pVQVagD1qJLYPMjX3BSYTj5HcTKyg7+qC/Ico+MAALPRPoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gdcLuqNN; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gdcLuqNN"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 672LmLkr168876;
	Mon, 3 Aug 2026 10:07:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=fH0S1TN4EtwwR5ukB
	s8k/yYVc+ejtC9ELYeDMRd3FVs=; b=gdcLuqNNYewgvQBJWHbxTCZovsDuIMRJ+
	CrMPmKnhJvXsEO1MqkaVi59cAOL0IqVBb7AhnTyXJSYMEaPFNS9f1wanUicRZMFD
	Sm5LWNyx9UgSltZy4de/moHIYhZYRJHi9cwGqjSzUbNAOsAdJeGoznn+t6Bls5Sd
	2fMX8L5P6mzyf1/58k8Oq54BL/StMpW2Ibipy+mJSOJ4Ai7877WRI0kqDWVdi0hn
	p+xrfXYFGZW/7yxy/oEkcRfo9QbcczoUFOxiX6skAScYlGbhxDEVUhwU+bTCLr4g
	2D23ikBKUWzoPOw0iNFKAs2gtxqbMavKxcZW2xBQAqZER3HVG6vnw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs77g007g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 10:07:29 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6739ug5W020665;
	Mon, 3 Aug 2026 10:07:28 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsugvvxm6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 10:07:28 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 673A7ORN41681252
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Aug 2026 10:07:24 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8100C2006E;
	Mon,  3 Aug 2026 10:07:24 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 548E720073;
	Mon,  3 Aug 2026 10:07:24 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Aug 2026 10:07:24 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] s390/pci: Enable CONTEXT_ANALYSIS
Date: Mon,  3 Aug 2026 12:07:23 +0200
Message-ID: <20260803100723.2343688-4-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260803100723.2343688-1-hca@linux.ibm.com>
References: <20260803100723.2343688-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDA4NyBTYWx0ZWRfXyYfnU92436GN
 6QAkLjKe1fouRSJ7zq6jgw/Ahdwwz/S3r9Lmn5avITLIlxIYFTTUuu59uKf92oMeSYGdGsiZ6HY
 vAPI6PFd+U179RgXmriI9MznceTy4b1UVT9TI+FHxtLS3d1V5SOkRQ0/t+2hpdzDeDfPbTDZX5e
 1s1HW/7zT+YcIuRmwYKoc0A32df5UkwjZkxDg/Dw5sEPGgJ6FHYSMrcXiYquqn/4C0MBOjE12hU
 2YBGXPdJ+n2scVC+ZK9K+sRO/o/DiX4dK2SuqujGNDLYXuYLnDWu4Rxx7QsFyWsFQo3Kuv5cAWz
 Y9PzS8kZrPxTe9aZRxUGMl6T0LO4SD7/bLkZ0yPfe+U+XofT1aggKTN+w8GFoXYXBuPj6CdzIIs
 PjfW7FSCPWL+64oO9X+baewYN8didoAWJg3xylrQQAMwDzUDHGeAN6rHSu3C3RNv+9Ken7ox1oG
 7YezvKDI+tJELxEWhZg==
X-Authority-Analysis: v=2.4 cv=WIFPmHsR c=1 sm=1 tr=0 ts=6a706861 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=BVUoiYlOf69TRVgg-NoA:9
X-Proofpoint-GUID: lQo43vmkiHTV7MSdWE8yI34PgzdMo6nk
X-Proofpoint-ORIG-GUID: lQo43vmkiHTV7MSdWE8yI34PgzdMo6nk
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDA4NyBTYWx0ZWRfX6jzh3WkyTkg5
 TghYXYPfv4JxrUNwswESoQ3hXFoRedlvVbFNUATu+bB3EsAk7EA9eOVqqVao499kTk858UdNoM3
 srI3qMM7V4LNq46m3LPdrolsqHbPepo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_06,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030087

Enable CONTEXT_ANALYSIS since s390's pci code compiles now without warnings.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/pci/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/s390/pci/Makefile b/arch/s390/pci/Makefile
index 1810e0944a4e..b8be1316491b 100644
--- a/arch/s390/pci/Makefile
+++ b/arch/s390/pci/Makefile
@@ -3,6 +3,8 @@
 # Makefile for the s390 PCI subsystem.
 #
 
+CONTEXT_ANALYSIS := y
+
 obj-$(CONFIG_PCI)	+= pci.o pci_irq.o pci_clp.o \
 			   pci_event.o pci_debug.o pci_insn.o pci_mmio.o \
 			   pci_bus.o pci_kvm_hook.o pci_report.o pci_fixup.o
-- 
2.53.0

