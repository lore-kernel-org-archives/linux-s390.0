Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74BAA374E79;
	Thu, 23 Jul 2026 18:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784831689; cv=none; b=MFNBStnoyI3cZL8kOneb3fEP4Txz/PFALr2zYhXBBov+1fOxDJaejIeYZnHYW88cY1N3a6nYrE0hIA/ZzpVjLPKpQnrDoAzvSTlHInki/H0k2vnQB+Ock/1ndygjEMDYHRuZDiBZe8Zklk+aErthOzQPMKxnTG/JDp7aV2MxElo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784831689; c=relaxed/simple;
	bh=KAHVEbIed6+6/ZHWaDBEWkpNRGzOUex2H80j/GwPGdc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T1nlZ9uyKjT7B+JXSD2duPFjXTYYLT1tLhKngp/e/jivoQzu3MhjCmPpjLtEpuW+U8kRW38x8zc65HRubt50QtgQUVAP8Lqsz3wsZO3iFF57bpaIhUTQKyM2SQJi81wvByg/By8RRK2h6e8wffJ7IFwyogFIouvPPYvS0ygyn+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aCT+yZX5; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aCT+yZX5"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66NHfsWw3578916;
	Thu, 23 Jul 2026 18:34:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=e6NuS8wD/32maTFF3CXfSnvjq9GzTwgdoCBrKx+sN
	Vg=; b=aCT+yZX5WsxlRAiiEf2HOQrnKPYZYCY+0gJMXLkLfmUP3dEuVXlvRte2i
	v6YtaD7kFRT04VzD6VUlE3tyOnLU9OTueXuUVjQi5oWir5hs0LxC5hIKWRbqA2ac
	5scNjY28iV0vdyJXNkzW/qua5RVYq2yNEJN19lwduYOiYA27Z7emTiWnzlBSxjnd
	PO+xQ7bsrI5cahCx+zPKGniPM0LnhApVpgEGQ/SciDLQiRofswP/Ty20FCg7AcuG
	N7VQc2fEQzUKWCZSAS4mgm1aAyS9hAFmuSfi4lMRmJ1oyCHi0sxRVTu83lkvs+Lj
	gUPSs36nYzLn+zrXu2/rPH5t3Uk/g==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg78gge2u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 18:34:43 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66NIYdlb005311;
	Thu, 23 Jul 2026 18:34:42 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgm6wdmfw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 18:34:42 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66NIYfMs18481720
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jul 2026 18:34:41 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5A7F558054;
	Thu, 23 Jul 2026 18:34:41 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 98B4F58050;
	Thu, 23 Jul 2026 18:34:40 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.254.118])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Jul 2026 18:34:40 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org
Cc: alifm@linux.ibm.com, mjrosato@linux.ibm.com, borntraeger@linux.ibm.com
Subject: [PATCH v5 0/6] KVM s390x PCI fixes
Date: Thu, 23 Jul 2026 11:34:34 -0700
Message-ID: <20260723183440.3271-1-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDE3OCBTYWx0ZWRfX8dfE+qnCiqjq
 ZPp1iccEODDfiDotnkAmOiWKzYmW7HUEzCvD2H6VEnw6BIwaaUV+t97z1w2Sn2ij3h//ZTsIirY
 hwkgT6C3/rZcVkPsaBzfvIts2GstXA+lWj5MEZ+O3b4V8vXulZOBOWdBTr3RlWDNwU+8Nxvp6cI
 7LD+CFtNrefCV1EmH/Mzukp/2Gfg96sQcE/27xgJseSmIQyla1vcKBWe50lD+Wk7nQZ9Gzhx2YQ
 bW8mQd83y9LBXBtoGlqq3oL/J0PfMR1H29jeWERWieBX4ClUzyRWyymVOfs3ZlxJK9y7RHJD144
 4u0b/8QDF6NzaVup14AloTti7GxW4ytTKVnK0+gZJh6M/IgEyVmDPg0oYit/5WsoADzJ8SY5mE0
 EupIkSCFaIhwAmxX+mdgjcBW/HSPsd3yVLdenjqTqj07sInChWadYpqVlGFfUiQGgVk/LUMhe64
 s10dFIlI8pfozDCdznQ==
X-Proofpoint-GUID: OADudSl0fcanT22NB9cNOY881KsAyUxI
X-Authority-Analysis: v=2.4 cv=MelcfZ/f c=1 sm=1 tr=0 ts=6a625ec3 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=36iXiGq6ocEqfiKSoJkA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDE3OCBTYWx0ZWRfX8Hs1APAiuE8v
 fukur6G9of68+USpffFExN0EGO51ASzAA3U8rwo6yB97/+UJpIB5any4f8bG6vaWiXfADwvCHFB
 4zs+nKkUESQndldwaG6fUSADoF6yO1U=
X-Proofpoint-ORIG-GUID: OADudSl0fcanT22NB9cNOY881KsAyUxI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_05,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 clxscore=1015 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230178

Hi,

This series attempts to fix some the pre-existing issues[1] found by 
sashiko.

[1] https://lore.kernel.org/all/20260624063447.85DF51F000E9@smtp.kernel.org/

Thanks
Farhan

ChangeLog
---------
v4: https://lore.kernel.org/all/20260722170621.1686-1-alifm@linux.ibm.com/
v4 -> v5
   - Fix off by one error (patch 6).
   - Add check for current->mm in account_mem() (patch 2).
   - Fix commit message as suggested by Matt (patch 3, 4, 5).

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

 arch/s390/kvm/pci.c | 108 +++++++++++++++++++++++++++++++++++---------
 arch/s390/kvm/pci.h |   2 +
 2 files changed, 89 insertions(+), 21 deletions(-)

-- 
2.43.0

