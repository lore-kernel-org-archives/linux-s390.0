Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E5D3D1CBE;
	Tue,  4 Aug 2026 16:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785860684; cv=none; b=sDvdFyCmVoQebieAoXXKjbtKpXu9UHH7s1XNtpCyEC1diUmXcsTNE1V/24zH4+jPCxXYyGPxi68+p7tKhrtBzPzFV5viCB2Pq10d8xpiEmXPvy+mYrXkV298zWGbqhnRx4yhQJfwEAA/ftBskcswg6JbAz4VR0Abzqj2fpYcrWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785860684; c=relaxed/simple;
	bh=CYD14KIcQ8dN71UIUGim0zfDulh9Pb4wiWeTWzQRBo8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g7lKaqoyQ/jiwjVw91L8D8s4jcp6Jl0YNzNvYeCHdotFGGbkmin/u/s4aumu3eFA/Wadj5gBbwYZA27QaivaveFy3IRki6GaDjrcg6aZQ8Tcg72rMrq0SIi25YND9w9NFoSYG9WQpcuPNmgnueejrNh5ewA/TOwIg0kjBGvF2kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Rpgz84oB; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Rpgz84oB"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 674FlaMi1254293;
	Tue, 4 Aug 2026 16:24:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=dZxFb/OF1R8dIB6Htz+/wOYrnQRxqKJNuhR5cMpjg
	WQ=; b=Rpgz84oBWUEt8BYvXfM6o7cmG5g84hBooSAdk8JzMxjzaC6lP/3toCqza
	FtTvuCfACv+PhmpBgkZUl5nOCU8PDeJKCySw/IEswmZXAJM6K1z5eViZO6nsaB8s
	+ewl9p7zDbk0lOYP5O7HomU9IYItKCUbxMQe0SiPJMPj2gFCE1ZfzAsU/pzt4Z26
	QoPcisEjPRro99I65CnNVTNM5dyw++VsInbFsg9oXEFmPoc6zAjaqSVr70kxihqj
	pZ33gPME2ybaxqV8MoW+QSf4McTPWcF93hM6gDR3HwCIj0ZPsXFGh0e96EhpQ/aA
	xJGdmU9DE9rlzwLF9p9fi9dxckbZg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8a3xt8c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 16:24:41 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 674GBHSv010888;
	Tue, 4 Aug 2026 16:24:40 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsv4k2qnf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 16:24:40 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 674GOdv724249050
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Aug 2026 16:24:39 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EBD5858058;
	Tue,  4 Aug 2026 16:24:38 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A5B6758059;
	Tue,  4 Aug 2026 16:24:36 +0000 (GMT)
Received: from b35lp69.lnxne.boe (unknown [9.87.84.240])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Aug 2026 16:24:36 +0000 (GMT)
From: Christian Borntraeger <borntraeger@linux.ibm.com>
To: KVM <kvm@vger.kernel.org>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Douglas Freimuth <freimuth@linux.ibm.com>
Subject: [PATCH v2 0/7] KVM: s390: more fixes
Date: Tue,  4 Aug 2026 18:24:28 +0200
Message-ID: <20260804162435.28617-1-borntraeger@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=E6P9Y6dl c=1 sm=1 tr=0 ts=6a721249 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=bC8FS_QDvYdq3oshdmcA:9
X-Proofpoint-ORIG-GUID: pxtHF2Orw1KCn3SPLuKwR20QKSZwQpqP
X-Proofpoint-GUID: pxtHF2Orw1KCn3SPLuKwR20QKSZwQpqP
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDEzMSBTYWx0ZWRfXyA5TYc0d+GTs
 u7ZV8Z4gwqu6vQYv0Zvfay2xJFeULjVOz/FteluXyp2WDf3Gfv6HjV1jc7J7n7+TAjFUyl/O5An
 yax3Guw5Dz4QtJvM5kWggZR9CoFrvU4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDEzMSBTYWx0ZWRfXz7Dd8ZlZ7Lji
 zjS1mFS/r9aS1dKCCBIrTdwRivol52TPCCV3aRK7d45wdMZvWcJQlHSR1UMKmleuk3FZqcHaynl
 JIPOWPyvHNKRjGEhfdUkrt3/4D31/dFHfQCtabVx0VwLFW6WwXpuV6Pty+vLEoEueO4vP4K2Mio
 BK5KAoDPkjV2QxCJTB8rIuIToJTDy33+dPRS+ugtaL+fQ7+z3uW1GxqD3w51+TIJH5cPI3nXQOR
 7SWHzNiVQEbNKMD4KSGk1j24NBryNwCA85DvPdbkiSLnYB034u4W02lznGRgTXxMG4aTDLbRuw9
 9+bI4fgdeJwCPsjMDZakQ2mYi6jE47599L6tXAcSty9j9QIlS+Z2id0/140VZ+hT6z03nh8+Is4
 GSdelLF4WmfGZstswIvDbg76CsNY7+IMWj1tex+DmU3qLZ+6RLCBBOqDE1XVd7+T8I08afWzuSt
 THn/t+sGK8A894grvsA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_03,2026-08-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608040131

v1->v2: several sashiko reports added
- machine check stack exposure
- extend zeroing to pfault done interrupts
- old_data leak
- srcu protection missing
- guest debug allocations not freed on destroy
- uppercase patch title

The comment about double free in kvm_s390_reinject_machine_check from
sashiko is technically not wrong, but this needs further rework.  We do
not want to forward channel subsystem damage to our guests and we
actually do not expect to see those in the wild. 

Christian Borntraeger (7):
  KVM: s390: Remove user triggerable WARN_ON
  KVM: s390: Zero initialize data structures for inject_pfault_token
  KVM: s390: Zero initialize irq in reinject_machine_check
  KVM: s390: Fix memory leak in guest debug handling
  KVM: s390: Fix old_data leak in guest debug error path
  KVM: s390: Take srcu when importing watchpoint data
  KVM: s390: Free guest debug data on vcpu destroy

 arch/s390/kvm/guestdbg.c  |  7 ++++++-
 arch/s390/kvm/interrupt.c |  4 ++--
 arch/s390/kvm/kvm-s390.c  | 11 +++++++----
 3 files changed, 15 insertions(+), 7 deletions(-)

-- 
2.53.0

