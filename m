Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68EA53B9DAC;
	Tue, 11 Aug 2026 15:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786463812; cv=none; b=cXQsVT7pXNIlPcn1KhEuryBjUb2Hj1sxpz7ZZUM1W30depVZtVl7qmudvewVDp5uIoEDIQEEMuPQirIpaqwuROlh+cuZ8kkydjm6OO1xTdgvi1GJ9zEyiBfv5MT50jUHWy5ukJTQtx+tRdv8ze4ietl88vSnVffjCdR8oIyaA54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786463812; c=relaxed/simple;
	bh=QMwbJeVhixoOmg97g+1Mv63yZRt5vKmC7vT5E3Wu5b0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AK8TvmcIJA6WOy7Dhr4amw1KlQ1KDVQ/apOkJnbsc0cjeyKv7+NNHXoawB0JhO8nYThBb2MAhVyUOb3baLdP3Jm3503Yl6/Je2rhjGOPSna1bHSvN5xf7j3bGzAXSqk37T8ecP5+cMD+OMzsQ+P8epTV3tI2j/HO/MMl/PW9lx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jl+CeXad; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jl+CeXad"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67BDWQQt492246;
	Tue, 11 Aug 2026 15:56:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=ogCTgDTBxZKT9mQjSQdF6e2YoCs7JVw3Y0Id0s15p
	T0=; b=jl+CeXadOnhUQlI20DW2T6vut1oqLLkWGY5ujDr48yELkQPHPQEWwLjFp
	/bhKpBS7j5xWrbuTeAP1VdKDQi2n60pdjlSt1LOZktCYnIuO7Ns2qEDl/ZAc79N3
	8N5yLN61ALWHHQpuq85RWqrSvpR9HDTo+D6mH7TTJ+vYrZRXE7Y5f/wkzjgxwq6R
	8ZwsQGCMfxRkXzKUUS/N5SBUYQDt3rvJJZ7VV0A8E/dDoup2MWlaz/HdEFYoTj52
	CN3hadiBc1yibjBKFOyuvom/3uRAfTX1dyJjRcQp4Xs6oqF/nU9irLrUSNqiXECA
	u8f1rLc6ytsSd3yJrjSzUn5gvLgZA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvq9dsga-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 15:56:49 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67BFfFMp011186;
	Tue, 11 Aug 2026 15:56:48 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxesq1s26-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 15:56:48 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67BFug3d16187864
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Aug 2026 15:56:42 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5CC912004B;
	Tue, 11 Aug 2026 15:56:42 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2A4BC20040;
	Tue, 11 Aug 2026 15:56:42 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 11 Aug 2026 15:56:42 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v1 00/11] KVM: s390: And then... even more fixes again
Date: Tue, 11 Aug 2026 17:56:30 +0200
Message-ID: <20260811155641.219777-1-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: NpUFagDIyCSuCZs0skF4VlXLElM4bm3d
X-Authority-Analysis: v=2.4 cv=PbDPQChd c=1 sm=1 tr=0 ts=6a7b4641 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VJqvdCRdbKvEAzS0hIoA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDEzMCBTYWx0ZWRfX/tAPXCJnT9LN
 lD8OvM8pSq11p0jHlUqeVIBkE2ynJvtcvcCsRv0kLEJCYRX0Bs7TK8EqbmssFtCEjEJ5+ZTbDe3
 Wbawa2w6RQbZQg1VyfzNsUk4w0nnNhVyaKro84u1+qAs+3tCOMaMbW6aKqPi2wXfjaqPhHAejpw
 0VXrjsfymmart6a50RH9jgN24GGOTeExGFAEzxZk8yYh0kgHJptU3t4SQDelqW4AnUqndbJOC8B
 KyucpWvYQzVcSNxh/lXns6wwhVdZyTYo9W64Mv+OwsmTgmmI+PqZk6jF4GSG+1tfbkmBdxAP9pl
 bUyUpVXWu8CkqYaUVimgw8Bv+yKJs/8cEQolooUYstM+pLTXcTKJVXwQmDF7fCF7pceqpeEV4pS
 wDaQBnIB34ZpPZLE96CyCufzzwXQHpCNeAAZ7HB+bUjLeE4IfoyR3pXEr/EyMYJj0pfJD9/ABDC
 6baCBbJeRL/09j/gubA==
X-Proofpoint-ORIG-GUID: NpUFagDIyCSuCZs0skF4VlXLElM4bm3d
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDEzMCBTYWx0ZWRfX0i36QsEL//36
 YfCv0fIsllNY1gC59orAuIflL6Lq/Hzdo5jstMXpZ91rcnbMxFz8jtpS26DJiclfu58XQz050iX
 kuFnzwC8JIedCywMIsN+cXNDGQiNMWQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_03,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608110130

Another round of mostly unrelated misc fixes.

Mostly small and/or unlikely issues, but they needed to be addressed.

Claudio Imbrenda (11):
  KVM: s390: Properly handle NULL pointer in dat_cond_set_storage_key()
  KVM: s390: Use srcu in kvm_arch_vcpu_unlocked_ioctl()
  KVM: s390: Fix get_all_floating_irqs()
  KVM: s390: Fix dirty marking in adapter_indicators_set*()
  KVM: s390: Fix pgste_get_trylock_multiple()
  KVM: s390: Introduce extended topup for struct kvm_s390_mmu_cache
  KVM: s390: Move all code into kvm_arch_prepare_memory_region()
  KVM: s390: Fix IRQ injection with SIGP Stop and Store Status
  KVM: s390: Fix kvm_s390_clear_pv_state()
  KVM: s390: Fix potential tiny kernel stack leak
  KVM: s390: Fix _gaccess_shadow_fault()

 arch/s390/kvm/dat.c       |  24 ++--
 arch/s390/kvm/dat.h       |  25 +++-
 arch/s390/kvm/gaccess.c   |  10 ++
 arch/s390/kvm/interrupt.c | 245 ++++++++++++++++++++------------------
 arch/s390/kvm/kvm-s390.c  | 126 ++++++++++----------
 arch/s390/kvm/pv.c        |   4 +
 6 files changed, 239 insertions(+), 195 deletions(-)

-- 
2.55.0

