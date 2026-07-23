Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6711B318ED2;
	Thu, 23 Jul 2026 22:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784844854; cv=none; b=U54pkEO98HJWUcUIdTK//aoHPm8qsb8r73Z1qxjw5xn+/AN3nWBIP9/hl1KVciONXUerAX9RbZOm/zBa5iIpIeBRpF+yu8J4hSG+a+OJb620mKjzgYLq25DhmsiV3Pbwi5F+lH6lH6WD1um8kt92tsFbqDKQIcdP3dwsH2u7aPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784844854; c=relaxed/simple;
	bh=VATgoIKrhzXFCuBjumb+uRHAGEfTfX/cUBgZ/MTT7Ew=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fGjCEKyFKnypM325DEkbLD7tkFFAcIRyUnnIdWiU44TgzIfNzb+hUouCzRVpFgFokVQxJxoeDlVQIZrCbtmziOtVPuJv8q1cSqv/PqLqlnqYuSFMg3+bdjLZVmOxjwDbaCSs0uTfNAetSB6OEYwF67KXiI/hiLx2yRhzj7Y1Ctk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pKJb++P6; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pKJb++P6"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66NLg8hc4081161;
	Thu, 23 Jul 2026 22:14:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=PRY+Yc52W6rDt94KRuPvbPs6Fb4E9pMlUd6rMrgzf
	4M=; b=pKJb++P6+QrSwxOv7+nm1RmTW5zBggonTujxW2BO0IWxCZ0mWziaZaPbx
	BMV/XgpGfZlPFkR0HE8jBG45KafpIdc8DSUlsACAshIyCQ3feND/xj0MFXZLQnKB
	umzblFFTECLx47I0cxuqgDoLm2/t2iP4/qlEoc27bpl9JriWzj18Y4FUcLQsZiVQ
	Vp0g9d80vYZl7Rtty7KyHqav2bkBQL5ATK4rtYf9zzYqpM+UvTo2VqNlmFb/t1av
	AL/N606ltJzqcoYzMKgcpuWIC1Y8x8u+/ixKoIMtEo4kq8T5oBmRUS35S/SDaoaH
	FIECmyBB/BsVLvTR3zIxWW1J0fq/A==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg78gh7k0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 22:14:11 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66NM4aJB029411;
	Thu, 23 Jul 2026 22:14:11 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgm6wecjk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 22:14:11 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66NMEAH621955312
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jul 2026 22:14:10 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2321B5805A;
	Thu, 23 Jul 2026 22:14:10 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9926958056;
	Thu, 23 Jul 2026 22:14:09 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.246.245])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Jul 2026 22:14:09 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org
Cc: alifm@linux.ibm.com, mjrosato@linux.ibm.com, borntraeger@linux.ibm.com
Subject: [PATCH v6 0/6] KVM s390x PCI fixes
Date: Thu, 23 Jul 2026 15:14:03 -0700
Message-ID: <20260723221409.5874-1-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDIxNSBTYWx0ZWRfX7shH6eM6vqVU
 YBjEF8JQyZPRNhrg1LjXsqT1RoldKRmIhVjn/H0aTjalyH7BHQrWKfP+wn/bhUHXHDzkcqEUst9
 ggO64Bhn9v8+iIgFSyRt4+andJlyFGCCASfYY1DiMFxNCPTt4rkja0F8bOsjMGQSnQTDCsxWhIF
 JZqJxK9zngHY3BVcN/rC7uEXVjWaIyJnrmdabKkmROkio+Na+NJvWDP6Fa5L46CtBUbrYGfmD41
 39QV3NWyBUygaL3YAYJsU59g4STzOGIaWrOPASG/1Z32gqu3NsD8SIfo1LGTXLchplXPWeIbPB3
 lRgLSdXbrUyIa1gUATbSgputfpYS7LCwu3gCV8kxW+sYhEjJXf6axBlXGHoSG2cRCmDK5ScnWu/
 0RIb5FWxVBTz5+of3g7o9upzRJnTrBMznIOi8Ig/Djradee6n4FPzNvbqSszQsdvSKJEQn3NxVI
 NM7SSN0V63qoQil8/Mg==
X-Proofpoint-GUID: ZWo3qP4s7mix6EZOiwl-Paq2LNeeweWB
X-Authority-Analysis: v=2.4 cv=MelcfZ/f c=1 sm=1 tr=0 ts=6a629233 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=36iXiGq6ocEqfiKSoJkA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDIxNSBTYWx0ZWRfXykSRfG87VaaI
 8lFi8cXep9Rn0j9j3iB5PAX/o68Go8BMCT5+7adws+uGnx7BEE8z5iBL68798i+EuSKA9zc8Vz0
 oGhtShw0UnLv+xJ/htLGd88EwVkZ180=
X-Proofpoint-ORIG-GUID: ZWo3qP4s7mix6EZOiwl-Paq2LNeeweWB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_07,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 clxscore=1015 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230215

Hi,

This series attempts to fix some the pre-existing issues[1] found by 
sashiko.

[1] https://lore.kernel.org/all/20260624063447.85DF51F000E9@smtp.kernel.org/

Thanks
Farhan

ChangeLog
---------
v5: https://lore.kernel.org/all/20260723183440.3271-1-alifm@linux.ibm.com/
v5 -> v6
   - Fix the AIBV calculation (patch 6).

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

 arch/s390/kvm/pci.c | 107 +++++++++++++++++++++++++++++++++++---------
 arch/s390/kvm/pci.h |   2 +
 2 files changed, 88 insertions(+), 21 deletions(-)

-- 
2.43.0

