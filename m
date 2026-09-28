Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5806E248896;
	Mon, 28 Sep 2026 12:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790599015; cv=none; b=CLsQqQBHcO5oHTWxOXFvtGvJu6zmOPtsVcnRxvVGAaP1yDMDApj8A5ju8wU7eQtfU8psSQfeZGCZVYv/WJbopArS5HWiELIwUg5IQOfGb59EkeliDaZFn9Lbdxh2B02SM2+MJGeIhwF0ospOYXjBdEM/Mw3gnyTqvSc1ourpaPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790599015; c=relaxed/simple;
	bh=O/Vyp579dG2DSb1JtTXKS7CHdimKv84DuQOuoonYGP8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lUEkaptCVLluc/0PeN/nNAwLRRIeIhNFF8TGHBDDSPpWt0lcnaUMWKakoMO6VB7v678i8djtKwP+oo4X2JchfVw53myR46XwM5M60/gl+WNhwah3JA+zWSYD3awFYgndyUPtTX6b6/k0laZcXJoaLnqURtLW0U5cX0rSbzb6nWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QyLP7ZjS; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QyLP7ZjS"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68SBZnI6823911;
	Mon, 28 Sep 2026 12:36:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=EZY5mFpZvNHzE+Dk7eG46/6uCV2qNAOfnoU9WOFa+
	iI=; b=QyLP7ZjSO9LddpjDS04/uCvpsEvbXDHkMUmOx4UmCTxGMUEiHtARPZBpN
	wm0/RgzxrJauxuufir2bK78Xi19XMbM6+mL9ug4YAm5Dz7aMRMBM4yI1GVmrWIzu
	Wlm/hrHBuTfy12qpVGOPD0zXfaq1cQn83UQKskeotNCkceuITON9PCAuV41y8us8
	HIlwzcZX71gojLtCDcMmWV33mP8bZNwmUz8y/4wZ2HV9RBZjliJy3FU9MaViAX+C
	ObU5cjsCRi/WQI/Zgq9QMM31uZ7RHbcOwIjVkLZiBJ9IX33Iawv1pD1DA1dN4qUp
	uEHUev1PweXM/tr/qaZGeu3IcEyhg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx3fk16v5-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 28 Sep 2026 12:36:53 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68SBHXBK069407;
	Mon, 28 Sep 2026 12:36:52 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gxrcpnbsw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Sep 2026 12:36:52 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68SCamZr26476898
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Sep 2026 12:36:48 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B842D2004B;
	Mon, 28 Sep 2026 12:36:48 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 976C320043;
	Mon, 28 Sep 2026 12:36:48 +0000 (GMT)
Received: from b46lp25.lnxne.boe (unknown [9.87.84.240])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 28 Sep 2026 12:36:48 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        imbrenda@linux.ibm.com, pasic@linux.ibm.com
Subject: [PATCH v5 0/3] KVM: s390: Improve floating IRQ injection behavior
Date: Mon, 28 Sep 2026 12:30:54 +0000
Message-ID: <20260928123639.34226-1-frankja@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: HWU_lu_nvK1DQOYdDIuxJSGXqjq39FyT
X-Proofpoint-GUID: HWU_lu_nvK1DQOYdDIuxJSGXqjq39FyT
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA1MCBTYWx0ZWRfXyh2j461lXDOx
 TBYOkMRul/12MHCfolMJ3nM60bmSbCvhlwHzK8Bvuq9MAndNZUsiNHkiAj6hxBBcPSEEajgKE8M
 u+r3QkY2+IEedlAJBN1Flgg46Uwk2Gc=
X-Authority-Analysis: v=2.4 cv=Vv62kO2n c=1 sm=1 tr=0 ts=6aba5f65 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=xTi3Lt-ftUr7KJ_HG0gA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA1MCBTYWx0ZWRfX8UKkg7gqGkzh
 bIrzQBGl5XzqtCnvC0f3uVUkN7HUxbvy50JOCQQX2exDYFemwSN6e1XBX4OWBsNdsTbdM1OB8kA
 YlZt+FFZG1EZnBkd5eDPOz/qmLYe+mFYEGIN0P1Mrs/U8A1vEFvh3sqCqYsCFIbz99pzGYV61hA
 zWFlTYjYtO3mv5guLbjMQFqRXJlFgIgykwunNssh370Gjr8dPfABPGUnE9VdPgj3fFtxiC2lrJ/
 upUE5TASdEyUQas/lJnjkJ3jzNKIyKAQVmNr5fePqBpS02tWbSKPFUeSQ88bIheHcs72jjMqCwS
 i98JzJRXJQuqSyQ/n8XSLT1RjU1KqNYwDcbQArsVj1GG9YKly2Yb3y3boxEwvVEKlLYloorXfAf
 egoKsMrFgLZYf8c9aLTghHJwmSQP0wA2X+AUcznagayFAquAcKB3W+nUpf9BH/De+q1XYyqEKhr
 3Vt6OhXKzqy4Ky5c+Gg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609280050

Multiple fixes for the floating IRQ handling triggered by the firq
kvm-unit-test sometimes failing for pv vms.

Only waking up cpus which are enabled, re-kicking after the
instruction notification for pv cpus and a general redistribution of
IRQs on entry (pending guidance from performance measurements).

The floating part of floating IRQs can make it difficult to make
absolutely sure that an IRQ is actually delivered, especially if the
OS doesn't regularly have the masks open. We might miss mask
enablements if the intervention bits don't get set properly and the
kicks might end up nowhere.

v5:
 - Rebased on rc5
 - Adjusted commit messages for first two patches (Christian)
 - Moved opportunistic delivery into wait state handling (Christian)
v4:
 - Replaced pv check with mask check which does not need locks
 - Fixed bitnum to bitmask translations that Sashiko rightfully
   complained about
v3:
 - Separated code into two patches
 - Added a patch that fixes service injections for PV vms
 - Added IRQ filtering and kick all if no cpu is enabled
 - Fixed the IO pend type translation
v2:
 - Rebase onto master
 - Added IRQ type check before delivering

Janosch Frank (3):
  KVM: s390: Improve floating IRQ injection behavior
  KVM: s390: Kick PV cpus at the right time for service irqs
  KVM: s390: Add opportunistic floating IRQ injection

 arch/s390/include/asm/kvm_host_s390.h |   1 +
 arch/s390/kvm/s390/intercept.c        |   9 ++
 arch/s390/kvm/s390/interrupt.c        | 156 ++++++++++++++++++++++----
 arch/s390/kvm/s390/s390.c             |   1 +
 arch/s390/kvm/s390/s390.h             |   1 +
 5 files changed, 147 insertions(+), 21 deletions(-)

-- 
2.53.0

