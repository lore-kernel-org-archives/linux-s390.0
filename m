Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8231542883B;
	Wed, 12 Aug 2026 10:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786531488; cv=none; b=GSI1e/azglh+Kn5/uSTJvCZmmAZNQhT97w6dI8hbDMAVwMef2/pFFPkQGi01Y/DwuAiE+NF41cLRf9E3iEPF2A9CTPeDlzcDfZdYa/J0aMQusvvQXBNViPtACRgXRiQaUQyjJn5I1wNdTuKj3xL8G2jpMSjfBhZSZW+glzpyfC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786531488; c=relaxed/simple;
	bh=zM500VnO3UxD+Byw9TjYlA5BJOWBLRwfR5SIWexiUzg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ba8wejIfEGqVlz2ZkJY8xCpwACbqsd75z79cCCpd5ixWhtdww/VvYAmmEiHSmcCsuZd37zJMhs3BQFs3tVeBwzc9BIqHF9O1vnbmeiI1L3stSvSC/j0IG7eMZvMTAgAUVb/4eAZQSKz+c502lel7tTNqTU5f49GXxVRPcnD7BMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lokO9ekN; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lokO9ekN"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CA1mck3086666;
	Wed, 12 Aug 2026 10:44:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=evu0a0S9CMJR3MaxQEjyhRkohNvkpeAb22E2f2FJU
	EY=; b=lokO9ekN56JHqPACS9Fgzrz0CmY3cKyvo+wX4Zpf6qwC8YL3hhwpIb+q5
	suA5lUCg9ue8NZUtbcKXz5KpOrVD4FAJ9aIMp4S0hvs1yZSYaAoEJcvmMsXgdTor
	aIaQWOlq/1EMQ6tvBLdP1NxMa7wQFvpGiLxfVriJx5SSnndCAVCxsgpxmuXQ/kbp
	ASGj9akSaAELaSWILMHQpsEXyY+FycvEhKESjBPMTWiqQTRaHpPRTPXAV2uFD3hi
	thJy3mPpHpxKBpVMVqrm1BhEiuenLNTcLsTod2OGD3L/5a3LrAzcAj6w0XFERcju
	TWx2XiE3BkHP9XO3kly7Mac7H67Qw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvp317jr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 10:44:43 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CAfHaQ002328;
	Wed, 12 Aug 2026 10:44:42 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxhfy5dhx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 10:44:42 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67CAibNd17170898
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 10:44:37 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1571020043;
	Wed, 12 Aug 2026 10:44:37 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E3D6220040;
	Wed, 12 Aug 2026 10:44:36 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 10:44:36 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v2 0/9] KVM: s390: And then... even more fixes again
Date: Wed, 12 Aug 2026 12:44:27 +0200
Message-ID: <20260812104436.109741-1-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=AMtp2X5w c=1 sm=1 tr=0 ts=6a7c4e9b cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=T9e13GXfYF5GVN7FE6wA:9
X-Proofpoint-GUID: QBnj5hOFzt7QwZPkDVoB0tmaJvV1IdxM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA4NCBTYWx0ZWRfX9GEJGDYem0ab
 DpCBvDS4gb7Z+zA7gmIiR1JhYR/UzJ4biCrG4M5XSXbuF0qHg5APya+HgheHDf856n7emX+wte5
 b+7u/28DQ2dr13RmnVkWfJ1JNpEsUfFLoNUu8S1n8RYKlMIA6p3Pj7bbdVnCA29Eoj7+Nc01gcs
 nqQWbXcwalipC3eqtho6mL6bGtVjsHc+THa6W3aYTje+DyCnoliD0UKKbnIhNI259S4G2UDIhIf
 TTRinhKUSq/o11BpUcvvbb1tP4RA+m9u8PGqziQoRQaRoSKzmDItrYcYAMesXW9NS4FIT4fFkhq
 jGVzOyd7jjfedK1vDNEksdfs7eyyjE8aaInzj7aVpGvw9rJ9hR/G46AnijdksGFw9SSyakYWexo
 GnrLD8G6bPGGbjWBan/605KZqbJ3Ij/gp5/Tsq6Lxma5mcOs97ydNDvFbL1NGkEucMLvchPtXhP
 qo97lyzA896Yq+IEDzQ==
X-Proofpoint-ORIG-GUID: QBnj5hOFzt7QwZPkDVoB0tmaJvV1IdxM
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA4NCBTYWx0ZWRfX0Ec5qkErtfwY
 rl1ydMO77RhzU+7TBwUpeHIyawRlDphg6pQdHCFIUpWbHW3xiNyPAWY0B24L67kI2Px8l81SZ2C
 UzZm2R8ujxYoJ3XkIIHeSUOYa7mwZkc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_03,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120084

Another round of mostly unrelated misc fixes.

Mostly small and/or unlikely issues, but they needed to be addressed.

v1->v2:
* Use the srcu only around kvm_s390_inject_vcpu()
* Wildly simplify the third patch: introduce gisa_test_ipm_gisc() and
  use it in get_all_floating_irqs() instead of gisa_tac_ipm_gisc()
* Use set_page_dirty() instead of set_page_dirty_lock(). In all
  scenarios we are holding an extra reference to the page, we don't
  need to also lock. Also move things around a little to avoid races.
* Fix return value of kvm_arch_prepare_memory_region()
* Fix return value being overwritten in patch 8
* Drop patches 6 and 7, they need more thought

Claudio Imbrenda (9):
  KVM: s390: Properly handle NULL pointer in dat_cond_set_storage_key()
  KVM: s390: Use srcu in kvm_arch_vcpu_unlocked_ioctl()
  KVM: s390: Fix get_all_floating_irqs()
  KVM: s390: Fix dirty marking in adapter_indicators_set*()
  KVM: s390: Fix pgste_get_trylock_multiple()
  KVM: s390: Fix IRQ injection with SIGP Stop and Store Status
  KVM: s390: Fix kvm_s390_clear_pv_state()
  KVM: s390: Fix potential tiny kernel stack leak
  KVM: s390: Fix _gaccess_shadow_fault()

 arch/s390/kvm/dat.c       |  13 ++--
 arch/s390/kvm/gaccess.c   |  10 +++
 arch/s390/kvm/interrupt.c | 125 ++++++++++++++++++++++----------------
 arch/s390/kvm/kvm-s390.c  |   6 +-
 arch/s390/kvm/pv.c        |   4 ++
 5 files changed, 96 insertions(+), 62 deletions(-)

-- 
2.55.0

