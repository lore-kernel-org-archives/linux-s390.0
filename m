Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0ED6446BF6;
	Fri, 28 Aug 2026 11:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787918107; cv=none; b=mlJW8G3i6EDXCMEsOhuJ+kFr43Mdnx6jwQ/HU/4TVvmRZQhw7kiKKdv3WsQ/qCKj6P3lex3Gs4+NBXwbNgQykfh9CxquW8/uqDYpsy/dbGZp4rEPj73ZRRXFj9RGpi1J2LBbQYMktN08iQdorGaT0BZYSk70rq3kBbLa/VThKVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787918107; c=relaxed/simple;
	bh=mSBt+ft5i3VY2sYn2+QD1Cmy6rcNR4+0gWd8SZ6u8us=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iJM+DRn0rY84fiDVHqLSYXupwV870GotKB+y3SJJ1jXewGDVNGLeDYi+bqH9dfB3qvv4C1KAelulNia1YVLL/7kJAOc6BfD+X9LadIj+vGWGXBUKOEoYVjLVCSIjC5VxgDdPGgTrlj0zXx+Sh40e/Ziy13Og0u5mwo9ehpvv7G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZoGCQtp4; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZoGCQtp4"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67SAVXKr4048474;
	Fri, 28 Aug 2026 11:54:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=Cw+bWhlQiSGF7aUmYu6PcvczgYONhdHQ2IKNfr2cA
	GM=; b=ZoGCQtp4jjof5CM0fonbgEA2cR86yDSD2wac0AVd86AtW7wptKxo+3YVP
	rgyr/ROP4usIkHGMiGXvCRexnkXPcI1BulAFdUXx5sAeBPU0h5WtSuwZ9Tw9dz+J
	Z0mjvfID5EJWoPTT6ThxPi8Og7uuWcLusvQte/VUzx0EnIxZOQ3L4Ic5GPD6npcp
	kjk/aFp0ScG63Lc/PCyOm2KTkNVnSXGiCEb43IQBrmdNcuwc5cs3tzBwBTdQ2o2u
	CV3Yf/oOD3FeI2gYNwKO0imiknY4CMmS6BSYxHEThlkexQviQVJq409626/DYRKe
	ZdQmXeyePW3LpE9ZQ+mpmjqUKVADA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73erbtyv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Aug 2026 11:54:47 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67SBfKNe000650;
	Fri, 28 Aug 2026 11:54:46 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7pfwp0qe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Aug 2026 11:54:45 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67SBsdTD40894862
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Aug 2026 11:54:39 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A65FA2004B;
	Fri, 28 Aug 2026 11:54:39 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 80E8E20043;
	Fri, 28 Aug 2026 11:54:39 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 28 Aug 2026 11:54:39 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v3 0/8] KVM: s390: Even more misc fixes
Date: Fri, 28 Aug 2026 13:54:31 +0200
Message-ID: <20260828115439.145885-1-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: kBLenNX9nfg0jeiNmVb0r7Ufe2dSRBYR
X-Proofpoint-ORIG-GUID: kBLenNX9nfg0jeiNmVb0r7Ufe2dSRBYR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDA5OSBTYWx0ZWRfXzpzImylqnhwf
 ehlsmgrJTsmhewz2smCaFtojvk0eLDsJTYFubz4e5pQ7XiGbTie3PuCjp78awBqCdPSDTMtpUSH
 siAvfouZp8Cy8saZVoBwmA+7NkBqGd4UgEOtjl29754togbwsYxq5aR78zfAa+pA9VSzAQj0lMC
 PlKbXTNSGX3PsB/sDDAQMBCeIctbwoIn8wu6L5b/EJ2eIdmmGuyITQdt9Q7dijkYNINGJ6jzPDh
 mw3UUvmJCY0nxUfd+4Y0dPGy376W4u8ZV9KIdngASgiuoPqL7jCdagkVuqFUksM6nU8HlyemyUJ
 brZuHJLcd4nnCYix57o2O12d7FCHFQ/hvUx0BlkSdLh51wan8hvjE4fPnPMt9CP+67BB3DWnv/x
 JU+9BbrTaxdA0nuSZEPyoSg3bPEakEAYx7M7pSA9qpMXep5BKs02BwdksNOrWRDi0hLFvZWb3lR
 a2fQT4ivUzglDBB5vrA==
X-Authority-Analysis: v=2.4 cv=QsRuG1yd c=1 sm=1 tr=0 ts=6a917707 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=JBFffvtJgn9pzkdXSAIA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDA5OSBTYWx0ZWRfXyWGmb/3AsxwI
 KvvQK3AWgoQNfOm1QwN+o+zq6yYjGt//mbBG5LQqxEg7Iezgq8Iy+BbtQUzlV09r1LMayEFA7UA
 RMeqahykELfS3RG92KO22POo3ysivJY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_03,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280099

A few fixes that had been dropped from previous series due to still
having issues, plus a few new fixes.

v2->v3:
* Rebase on master
* Reworked first patch to use scoped_guard() more, and restrict the
  scope of the srcu so that it excludes the page pinning
* Add missing const to parameter "old" of kvm_s390_update_cmma_dirty()
* Fix potential infinite loop in dat_get_storage_key() and
  dat_reset_reference_bit()
* Fix potential race in _destroy_pages_crste()

v1->v2:
* Fix racy usage of sg->parent in patch 2
* Fix wrong number of arguments for dat_delete_slot() in patch 3
* Restrict srcu usage to the bare minimum necessary to avoid potentially
  triggering page faults in the guest while holding the srcu
* Fix races also in other skey functions


Claudio Imbrenda (8):
  KVM: s390: Fix dirty marking in adapter_indicators_set*()
  KVM: s390: Fix compile warning for kvm_s390_update_cmma_dirty()
  KVM: s390: Fix _gaccess_shadow_fault()
  KVM: s390: Refactor dat_set_slot()
  KVM: s390: Move all code into s390_kvm_mmu_prepare_memory_region()
  KVM: s390: Add missing srcu in kvm_s390_set_irq_state()
  KVM: s390: Fix potential races in dat skey functions
  KVM: s390: Fix race in _destroy_pages_crste()

 arch/s390/kvm/gmap/dat.c       | 65 +++++++++++++-----------
 arch/s390/kvm/gmap/dat.h       | 10 ++--
 arch/s390/kvm/gmap/gmap.c      |  6 ++-
 arch/s390/kvm/gmap/kvm_mmu.c   | 91 ++++++++++++++--------------------
 arch/s390/kvm/gmap/kvm_mmu.h   |  4 --
 arch/s390/kvm/s390/gaccess.c   | 13 +++++
 arch/s390/kvm/s390/interrupt.c | 79 ++++++++++++++---------------
 arch/s390/kvm/s390/s390.c      |  3 +-
 arch/s390/kvm/s390/s390.h      |  2 +-
 9 files changed, 137 insertions(+), 136 deletions(-)

-- 
2.55.0

