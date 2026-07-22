Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24555416856;
	Wed, 22 Jul 2026 17:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784739988; cv=none; b=q+zYcuH3GrwVJU2F0ENRGJvvAwsdUZD59PA4z5W7+bnjamxwBgzaREA2ZqbzTEmwotWqgpZN6+ENjIa7cDt0y3X1LY6zYu4IpJP0gNRJK+Ll7eMRhpieu+mqNydkMZSW4V7j6KrVLwk9UgnopTdUYP0LSL9PRCzXABdiWP6gA/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784739988; c=relaxed/simple;
	bh=n0nRc6YpuGz634f/OdjSUvjFzjRwGUoGG4Syun//wBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rK3qFSYSQP/RIEcRFSOuismeXbfKNocBonq4Tnq639yF8m06uIWPxuAW1lywrZ09dNt2c/pz/suSoB0DC5KY4a9Psl9B7zYFccaivHxb6oZcfO2+45qWaoM4XmRmkLlbK0NiHwe1VrQCVFbPBUxgza0s4k3HTuxacAjjhhY3ARY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aTnCBFgt; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aTnCBFgt"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66MFg6am2690677;
	Wed, 22 Jul 2026 17:06:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=noendmV5XqML+ZY0sdDDJC8/1RF4RcZoq7reYV9Bk
	O0=; b=aTnCBFgtWgFuYjxKhOztHF6azPgAgg9ltgnT/gBOZpLTODiiBLi3NbQTX
	nILsxGmkuyoz5+4RjXOiGHe4/sfzbGSHVKsPt44IWMnUePTPdtrsKge0Xk+0ibpZ
	xPQ6tFvwR30Pb69/H1Zx52bM5XGt5MdytaUGgfuk+bvuUyWoAxsMMdD8xxKLH+2y
	EEa5CXV3NSq4pM27UzKsfbSBs+teqDKZVrFTZ0L85lOyeCbdVilJpQIUjAGLXxWP
	qEqYM7HijPgGxHSX6W8rmjlv2Hr4avSkdG+jrZG+2s+BdGWv1rrs0oargncwFEfv
	5ra0qL7h4M3Ed7wdT5y08Ab5CeUgg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg77akccq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jul 2026 17:06:26 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66MH4gZr026345;
	Wed, 22 Jul 2026 17:06:25 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgmtk0aht-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jul 2026 17:06:25 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66MH6Nhg29229612
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Jul 2026 17:06:24 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 92D5458053;
	Wed, 22 Jul 2026 17:06:23 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B974D58043;
	Wed, 22 Jul 2026 17:06:22 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.253.249])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 22 Jul 2026 17:06:22 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org
Cc: alifm@linux.ibm.com, mjrosato@linux.ibm.com, borntraeger@linux.ibm.com,
        farman@linux.ibm.com
Subject: [PATCH v4 0/6] KVM s390x PCI fixes
Date: Wed, 22 Jul 2026 10:06:15 -0700
Message-ID: <20260722170621.1686-1-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: SjQ7VSxzI_uFDvan3LZxioM0gpxKAfaS
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDE2NCBTYWx0ZWRfX2U8X0KDgKsC1
 Bn/xvwHRkUuWr7UDtkh4hLEhK5uVOMDTe5eXsWUZNOlmG4TiiQn0svPOBg9HiTOWj8rp2XwMQf9
 3i89zMasrLRWIRFm3sf0/lw2yyavBJY=
X-Proofpoint-GUID: SjQ7VSxzI_uFDvan3LZxioM0gpxKAfaS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDE2NCBTYWx0ZWRfXzJuzr9OL/M1+
 yWHKJ3l/Q88qKUhoHiwLUtmgqIXy0etAdhbI75jx8ffHxpphW/kWsLWMr482a+/lTRg/dUI5sej
 yKCpFG9ZomYRJTRHxV60WyJYu6patIU50aKvZNp/KUkM6M1CT1qSuNeI98+A2apeK8LNhcoyuuA
 1oHubLAmbU8qnDJMN6WrlQPRqafMy7WqBvdtB+YoUwXz8W8363PJcYBgd1H1sv6qb30TkOzpWx/
 6b3hJgSsuHaCfvgCh3kDyweT/kqdgSqnDUmvfC/qIe3TzFfs+h2MPGupulSn/6Ut1AU466P+L4f
 utvL0qz0Rd45MJm20i/V7d/GPvXbrIMQrUAI+4uTa71a46CY2qb5flp1Qi36Z4Sj43QGJNcLrAP
 6glV3eQYbM2eXK9n6wah8nRAbJ+mFnyO9xx0j3+jNBn7f2T2E/Bg2vKiGndtP5JOxTOfJzdzV24
 DAJgHQ2HIu58sizBCbg==
X-Authority-Analysis: v=2.4 cv=K7AS2SWI c=1 sm=1 tr=0 ts=6a60f892 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=36iXiGq6ocEqfiKSoJkA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_04,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 phishscore=0 malwarescore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607220164

Hi,

This series attempts to fix some the pre-existing issues[1] found by sashiko.

[1] https://lore.kernel.org/all/20260624063447.85DF51F000E9@smtp.kernel.org/

Thanks
Farhan

ChangeLog
---------
v3: https://lore.kernel.org/all/20260720175819.1723-1-alifm@linux.ibm.com/
v3 -> v4
   - Add validation checks for AISB/AIBV spanning more than a page.
   - Reject multiple ioctl call for the same device, if adapter interrupt
   forwarding is already enabled for the device.
   - Rebase on 7.2-rc4.

v2: https://lore.kernel.org/all/20260716175241.1039-1-alifm@linux.ibm.com/
v2 -> v3
   - Remove overwriting guest FIB since we don't use it for
   re-issue (patch 4).

v1: https://lore.kernel.org/all/20260713172600.1284-1-alifm@linux.ibm.com/
v1 -> v2
   - Drop fix handling AISB/AIBV spanning multiple pages.
   - Fix memory accounting functions for the case when interrupt forwarding
   is enabled by one process but disabled by a different process (patch 1).


Farhan Ali (6):
  KVM: s390: pci: Reject adapter interrupt forwarding if already enabled
  KVM: s390: pci: Fix memory accounting for pinned/unpinned pages
  KVM: s390: pci: Fix missing error codes and memory unaccounting
  KVM: s390: pci: Fix NULL dereference on AIBV allocation failure
  KVM: s390: pci: Fix resource leak on IRQ registration failure
  KVM: s390: pci: Validate AIBV and AISB before pinning guest pages

 arch/s390/kvm/pci.c | 102 +++++++++++++++++++++++++++++++++++---------
 arch/s390/kvm/pci.h |   2 +
 2 files changed, 84 insertions(+), 20 deletions(-)

-- 
2.43.0

