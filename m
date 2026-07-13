Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D585B31F98E;
	Mon, 13 Jul 2026 15:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783955350; cv=none; b=H4mx3o2E2Wwss0pnBnoSEnFV5Z5bkrgldqKpSuWA1mNIecg7mvc7RBm9fpZfb6vHJ/ZcoVJ1hJC71rU0qJ9DqObicupv5WJCMGvfakCm00sSH/H6zuveZj0HMVB9QimiBYz7r6NQJQr4cfyvdAfUykmxqg/wpu80ElGE/eYYut8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783955350; c=relaxed/simple;
	bh=6N0Ir9Kg/XEe0jPUqurPQTkrJ+Ni7mK58I8b4RD51QE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uZRspVcdSqhx9Rg74J00Cwd/iVDAZndZpQkgLNts2vBVIdvPMoYrvPSL0tKUpSLdNSqpeAcyb7x8bsVgNwT6i7pkz8BGEanssMlOIiz31UnwdMM424O3hfoeJuMHMswGPT5i8VO17P0PSeylfqekGCm8ruD6aGRaLsxWODJDQnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nZg1rxLs; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nZg1rxLs"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DCD4AT554820;
	Mon, 13 Jul 2026 15:09:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=4cCLrMXsrocNdq46JjucqSSBcoQJd82L1LH7veeBI
	yk=; b=nZg1rxLsa7Boa1I45c3ACOuhff34YCxlqWIaNLbaiTk+jHm87fRCE37M3
	vBqMbNR+eY4HymdBpfIjGWzU+hFBx2dXyReV62GK2avpdp0KEfNZZXe4yL6oVqFt
	A9BYs8mm8okB3NkKjWF9WaMFScWFRvp2G0FaysyaednPQ2e+cxwhkSxclLcFHe6M
	qqJSa29BBmSzwxp//gHO5DOpc2pajnTjHfri8RScXroyl7Rv8sIceVVS5wTfr/s+
	QDt9s1DyrVkplZ+pkjrCY/ng8WdZv2zD5vqFNtz16S+2FKjO4N8ms8/JVloluc4E
	G7fOgDCk92/7wqYL6x0IOn3YebuEQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fcv331uyt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 15:09:07 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66DF4dZ5006297;
	Mon, 13 Jul 2026 15:09:06 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc1nh654a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 15:09:06 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66DF8wu650397538
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jul 2026 15:09:00 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ABF7C2004B;
	Mon, 13 Jul 2026 15:08:58 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B506B20040;
	Mon, 13 Jul 2026 15:08:57 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.87.153.197])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 13 Jul 2026 15:08:57 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v2 0/7] KVM: s390: Misc fixes
Date: Mon, 13 Jul 2026 17:08:50 +0200
Message-ID: <20260713150857.269954-1-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDE1MyBTYWx0ZWRfX3BBCgVQcfDp4
 PmmtorceJtIUCl/YdOlKDGEeuc4sdMVjKQKrDE8if9+gxWQKczBVA9xEhtG07JnSK6+fga+gjnf
 RMyQ4E4DYaUgw26+ve9kpmz5Z9VtWjw=
X-Authority-Analysis: v=2.4 cv=Mp1iLWae c=1 sm=1 tr=0 ts=6a54ff93 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=NIC-QdJEwcXExtY_VYkA:9
X-Proofpoint-GUID: kqxqdcMrDRl_bXTIuJqfOO6GtHY1EKsN
X-Proofpoint-ORIG-GUID: kqxqdcMrDRl_bXTIuJqfOO6GtHY1EKsN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDE1MyBTYWx0ZWRfX7qhPE1ZO0EMP
 nPeSMkLBoKB0+xm/ofYB/59E4/p+Idk27r0ykFCqlilcn00Yuz8lx6o9nmvH/CE6hhXx6qAlZgv
 vLcz4LnU800X4nM9FqL84hXIR7p8upHqFUs0U7AEmwOI0vZnuz/ZRu8aSB1EXIC3GH4Jp/OgWCa
 foUo4RucRlwc/nK5mSABLQrI6/NPQwDWVENkrFcRZCkFbEui0SMPPaYDJi1pO6otE55UeMJEgJu
 n/nF5ZwW3d1BAGwoLPuim7r4WMfXdk2K98uAWRQvQRrltYz0JrDqP6preBIWYdYZBpK2bYOYpRr
 pRp+fwq7Wsrc8VZ3FBok2p3h0H3TTeXItv0Dq1AhSpqAFG07Eyi6anTyVxxlN1bXBDf7uB0zp+Q
 EVM88yllniHIX42LWureUMQCFC5t2aEdiGuKIfaD0XF6eWCG168L/z8cAHOonvoJvFiN1xnvjiT
 sArAqtYiHajVQjDNzNA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_03,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130153

Fix a bunch of small issues that came up during the previous round of fixes.

They are mostly extremely unlikely races, but they should be fixed
nonetheless.

v1->v2
* Drop some patches that have been picked upstream in the meantime.
* Drop patch 3, as it was trying to fix a bug that does not exist
* Avoid the NULL gmap dereference by using a flag
* Fix the return value of kvm_s390_[gp]et_skeys too
* Use kvm->slots_arch_lock instead of kvm->slots_lock for CMMA and ESSA
  handling, to avoid potential deadlocks with the RCU.
* Three new patches to fix other issues that came out while fixing the
  other issues


Claudio Imbrenda (7):
  KVM: s390: Fix unlikely NULL gmap dereference
  KVM: s390: Return -EFAULT instead of PGM_ADDRESSING
  KVM: s390: Fix race in __do_essa()
  KVM: s390: cmma: Fix dirty tracking when removing memslot
  KVM: s390: ucontrol: Add missing locking around gmap_remove_child()
  KVM: s390: Fix overclearing ESCA in case of error
  KVM: s390: Return -EINTR if a signal was pending while faulting-in

 arch/s390/include/asm/kvm_host.h |  1 +
 arch/s390/kvm/dat.c              |  7 +++++-
 arch/s390/kvm/faultin.c          |  2 +-
 arch/s390/kvm/kvm-s390.c         | 39 ++++++++++++++++++++++++--------
 arch/s390/kvm/priv.c             |  5 ++--
 5 files changed, 40 insertions(+), 14 deletions(-)

-- 
2.55.0

