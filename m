Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447BB3AEF2D;
	Tue,  9 Jun 2026 16:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781021818; cv=none; b=nsZWE5+xgbhkvGd0GoWLzotn2XZk9zzYf8Vwt/a7j94l+APEAW73uT6m4BlZ+QN83Oqwu9ZSBdU4fw0KGWQ0DJ5EaEeDxZcd2OUDZUkBeek1mxI5sow4lSFzfgV2hAzoAHWZeNYpPF4fvVATmQKpsp6cyShl76aHzn3qtaovPSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781021818; c=relaxed/simple;
	bh=6okSZjKqF+i1RGCX3SAyQbIDklKN09eQ/YPEKOHDZzc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QU/L/K0v33OJUDSG5Eqqkqlz75+9aeROGPctRX6zyQmp2HP8vFGnL99o++ywIBc/wmdtILrPFSYJ8PRGvCUgcIDLqrDOEgloBXsIOkltsxy5TXIuoA0mp2O/8rxz4YhCNTdGAz7jM6QmYq3kNe83GWqo22J9kNWVlGm1E5RMABg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fRf1g0MG; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fRf1g0MG"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6595sE003405561;
	Tue, 9 Jun 2026 16:16:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=ARfgU5+Cl7CmZl1n2MVqzW77vefOU9NSMwI9jvfeE
	zI=; b=fRf1g0MG28IgIK0okwY2saw6/BrTzfRwUX1Owdtu0eOUynnZu68UrYd9P
	v4AkY7+tm7acngDzrSXvLXiqvU3/VlSv2cgkAxfRKzNM/Ic8sP7GZ7JOCpONad+Z
	tDliCzuykDtRaiAl6X1fAY3o5LDU20HQOAFqO7pdJbnJBJjeFO5GXsrFIiUELbGN
	CSzrIciLrN/QjI5FYe1/4ojENtB0Jdt8npuVaqsT7jBM+LmUJdTA9mfN6gFBfO12
	Hn0Uvi0qFRQUTUzI3gUOrhfqpgT/QfrBwkoukDEga4PkvPlS4bt3wYDKlwyng4tW
	CSPVLxS6vOhrNxNGttUFquivxnTwQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb7qn3ke-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jun 2026 16:16:55 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 659G4hhF018493;
	Tue, 9 Jun 2026 16:16:54 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4en0jyahuy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jun 2026 16:16:54 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 659GGmf452494792
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Jun 2026 16:16:48 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8642B20040;
	Tue,  9 Jun 2026 16:16:48 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 33D762004B;
	Tue,  9 Jun 2026 16:16:47 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.28.58])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  9 Jun 2026 16:16:47 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org, kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        borntraeger@de.ibm.com, frankja@linux.ibm.com, david@kernel.org,
        seiden@linux.ibm.com, nrb@linux.ibm.com, schlameuss@linux.ibm.com,
        gra@linux.ibm.com
Subject: [PATCH v1 0/3] KVM: s390: A few misc gmap fixes.
Date: Tue,  9 Jun 2026 18:16:43 +0200
Message-ID: <20260609161646.695361-1-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=HppG3UTS c=1 sm=1 tr=0 ts=6a283c77 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=EM6bAlJCgMabOG_lu0wA:9
X-Proofpoint-GUID: W55ydxbAYWStSpr1ZXe-6Ct1GkruP9GE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDE1MyBTYWx0ZWRfX6B60FX+bXmnz
 h/0Hk0udS38FUJVAiJlMW5UW0SZ0CUXNdihAFNe5t9j3QbfkrYEVbsWG/c8fedwtFxBhuOEID98
 ICUIiN0KLOw72rl0MVswD3QwIHTbCZQzwh0rbdLSm/NHkBGx5RO2L2O4S1XYINBoKdKLoZFSMqI
 D7OpdWCJWGr86hZNJzZkuG3Bqlg9SmGCt7lPBg1Ty048eqbdEVf0oKFqSvztYRlrtAI47x8xhRJ
 AODVbAwCcj4w7h2I0nLrjf8ciLWXe/GrEqBSJPQYs31yiPNi+faqOEASGWACkEhijMcepLDEVI9
 kFGy002fl1Ofo3M9tL3gicb0VMIFMONELAgwjbdC/5yKodCV1/b4gnUgtPPPs+rA9Cl11U4AdWN
 POxmCOjpWq2w2GAlyK4WH/+QmDD/IGxv5k9JOGag06cErvfa4iUBd+hoBvAi9mLcbgmK4K7MB5/
 qNEHlcsUvSVgBbEgWbQ==
X-Proofpoint-ORIG-GUID: W55ydxbAYWStSpr1ZXe-6Ct1GkruP9GE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_03,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 phishscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 clxscore=1011 bulkscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090153

A few more minor gmap fixes.

Claudio Imbrenda (3):
  KVM: s390: Silence potential warnings in _gmap_crstep_xchg_atomic()
  KVM: s390: Fix unlikely race in try_get_locked_pte()
  KVM: s390: vsie: Use mmu cache to allocate rmap

 arch/s390/kvm/gaccess.c     | 16 ++++++++--------
 arch/s390/kvm/gmap.c        |  7 ++++---
 arch/s390/kvm/gmap.h        |  9 +++++++--
 arch/s390/mm/gmap_helpers.c |  6 +++---
 4 files changed, 22 insertions(+), 16 deletions(-)

-- 
2.54.0

