Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4EF440587A
	for <linux-s390@vger.kernel.org>; Mon, 24 Aug 2026 12:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787574200; cv=none; b=aDEwpgGUPo2HSkUfXWNjtVYZKY115dbWpkgpBK7ynonf+wCX/O7/BbEqjMAQ/grqoY4c+Yt0jsamScLwprv1onfcXkTCjcu+JS5t/nztrNBqr1yALjDI46KIe2MYFp6W1R+KnMtv+aS5xdoU0UysKD1vAXjJdBKMUDaFpvQ7BQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787574200; c=relaxed/simple;
	bh=UaPlgEn5dY7afOMVcAlpEPgjrEbrcTXPYndEyeYLyXk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OFTr9GUWcBoOq1JLND0HRgpfClGVyY6XXldgielMYcmTrZ87v7FCrugTl1dn0lviKqAlT67ofGeqKt9LWCxVQlW8gHK9GeM6YQdBx/UypR3IKdpKCNbexqYLdosoDzWIQvC5oI0wDlghpucKzPCmXcYQ5QlBqNFtfw2AULNi9dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pb4El0v3; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pb4El0v3"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67OBVVVG4074286
	for <linux-s390@vger.kernel.org>; Mon, 24 Aug 2026 12:23:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=4LRq8XWoSmQj0EoIyGC5BWtRvtWJMWkCQ02C55e1C
	HI=; b=pb4El0v3/1ieBbtDG0ewrESRQFXORFPZQp1mqiBkSzjZCR1IP9oE8MfPs
	hDVyabJAzYnSYSHCFHx3CN1Ht9E7qu1IaqYJyGzGvfdk3mNz93SYSp8hG46zvZhe
	vtKNCcxR4q24lGQRn2zhOLGRNpWq0LkpwGV3hXNkXTHOyFSrr5+NnuV5X21xOdyd
	sXkUfOkORFf46MU2zBC8Jbptpn6+kAkYn6n/agNdv8aVrobzxJnaz/XaW79VJu/m
	sOoistW7MOMAreErnB6JSK6DXRfwnX05lt1695xtuEbvjn1iEsPySxdh6Y2Ea+Qi
	FWoO7TUJwg4fHynD+vx/gH/XY0fGA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73eqh5g2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Mon, 24 Aug 2026 12:23:18 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67OCBId5012193
	for <linux-s390@vger.kernel.org>; Mon, 24 Aug 2026 12:23:17 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7pfvwwde-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Mon, 24 Aug 2026 12:23:16 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67OCNCPu51380634
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Aug 2026 12:23:12 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CB2172004B;
	Mon, 24 Aug 2026 12:23:12 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AC6A320043;
	Mon, 24 Aug 2026 12:23:12 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 24 Aug 2026 12:23:12 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH 0/3 v2] Add CPU hotplug support for PAI PMU
Date: Mon, 24 Aug 2026 14:23:04 +0200
Message-ID: <20260824122307.86133-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ZrBzno4TUsUr7V7CJc5BxkprZOyqfnRF
X-Proofpoint-ORIG-GUID: ZrBzno4TUsUr7V7CJc5BxkprZOyqfnRF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDEwMSBTYWx0ZWRfXwZgS38OlMByA
 L/xAJBhT91guRohOda5eB4fxk5czhv00LJ78ii5E1WD5pek1vGF6002LrXCZPxHFluBGXb6HOhu
 WpvcJzEeDJnag48htJoCmOFXwrLrdbeaAAHqbtyiAGY2udVf54inG207W3nHQmXVSlPIr+bZtZP
 eBHASmWCxrSwZurae3+4ZLd3tDRyk4AtXNRpsSp8xiAJVjQbyzAlsA3SUTq27rXFXXAkbq4wxuv
 GyIas2PWRvUEkC9sXyvCZUMdhUnJ1082j/1Kx/1hEbk8rlU7wSBRkQmmG3oRfJetukyrcVMXqtl
 nYKiiRalz7jKTZJzGtSGfbIfrzu8PMTj7DesFoVUdz549xnBK+pDrjLw1TnRh7ZkgJgs4XxOMGq
 RweyMnckg/HXLyuSgPPCkRhHJ7UyWDj5kElyj8mndMhD0GPMB/u/NOo1k9nIjehRBRZ4ajASBCO
 uz8SXSUfv2N98NeG6VA==
X-Authority-Analysis: v=2.4 cv=QsRuG1yd c=1 sm=1 tr=0 ts=6a8c37b6 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=lQW9TJnzQ4aT2Au-fZ0A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDEwMSBTYWx0ZWRfX0k0FV9GqKxmU
 NAY9bcR7nkJBJ6UwXSHWDmbGwgs4CU/fVvoBulTYGhjiLo0lPeGF1fKPd66maTregAuXLszqkDu
 ZgWTuR2/aNvityWhYWyL2PL+/wezWig=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_03,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240101

V4: Add findings from Sumanth and updated patch 3/3.
    - Fix reference count for CPU hotplug remove while multiple
      per-task events are active.

V3: Add findings from Sumanth and updated patch 3/3.
    - Refined Fixes: commit id and messages
    - Handle cpuhp_setup_state() failure

V2: Add findings from Sumanth and updated patch 3/3.
    - handle possible NULL pointer dereference in pai_event_destroy_cpu()
    - handle possibe memory allocation failure in pai_online_cpu()
    - add Reviewed-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
      to patch 1/3 and patch 2/3.

Add support for CPU hotplug add and remove for PAI PMU.

Patch 1: Change function argument list
Patch 2: Move locking from CPU scope to event scope
Patch 3: Add CPU hotplug handler

Thomas Richter (3):
  s390/pai: Use PAI PMU index as parameter replacing event
  s390/pai: Move locking to event init and delete
  s390/pai: Support CPU hotplug for PMU PAI

 arch/s390/include/asm/pai.h |   1 -
 arch/s390/kernel/perf_pai.c | 178 +++++++++++++++++++++++++-----------
 2 files changed, 124 insertions(+), 55 deletions(-)

-- 
2.55.0

