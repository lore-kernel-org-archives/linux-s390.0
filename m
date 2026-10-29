Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793278854;
	b=3lTdmGhcKLHtZcYuYQ/OOauc3X7eXudeUtVTkyhNDBfw1Xi9WFpMxunVs8mEP2frhbgY
	 hczizQMdj4ZVgolv+lqLczxHM24flwZplN6+tuOlulrz3WZjNw7VoPHl13xUeh0gHf6Q9
	 KWFEa4PsldqpOVPJ6WXhX58ftsP8h2FySmEMeqG5JB1EfojI8b+jqBvUNDgmGqR68VQxu
	 ahslFp6RbjJ1oCYUJ0UVqA85h4BSViDRNojrZCMDHYhiIBKzL3OJmGZr4bGX+eVsPEwPe
	 ipmcSZ+JVZX3D1cQ/qL6k4da0u7jS3I3NFM8C8Ygx5BpZqqo9ccHEZoZuPlcoi6o1Og==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793278854;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-TM-AS-GCONF:X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=6CQXsIiq9KF7dfjRDf4pgTKUOfPi1lu3KBSiDo3qmec=;
	b=1oOD/INz8c+eDIGCZMMbxTcZ3HNV4hX6YmMjbOsHTPj2ycD8Ntb3KyIFD6N7Al2ETMgg
	 MrenOZpXanCSjCkKxqkaEJKyNnAyswXmdd565p1NICmRg1Pid+r685si+dSOuG/TEjZm1
	 EF67pVqFHnjo37Mr7M9kDN7QlUY783YNn48jrttrQVUYKN3tSR2GpYcf47KMEC7BvTABI
	 hAGjK9BRD1mjWMbmgjsLep9btZDFcTKw+D+93DmPs/4nBMWn8mEmq8LuHeSSHt6Rhx38a
	 mGopP5TDXwjmVE6SvO6600vUklwdVEwHWBL/ZhSQQ+ddiNmzI3e80QqyKT5yFJFRlEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=XiTLLno6;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BBB606A31F;
	Thu, 29 Oct 2026 13:00:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37BBB606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=XiTLLno6
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69TCiSYD2581151;
	Thu, 29 Oct 2026 13:00:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=6CQXsIiq9KF7dfjRDf4pgTKUOfPi1lu3KBSiDo3qm
	ec=; b=XiTLLno6K8u0m4rBJV/ElGv9TZn41dIMxd+xfcDIjUeIrm0tXHsM7GdZZ
	wqB9LcyVlsTUYh5sbH4O3pNL6FEjDUqk0RJ+BkDkMWXq5Q+Z6wwZrmZTiADGx7Uc
	pzCMXA+u5jVA31RVOwvpycphGg/fO0M+tWy83ebUeM1QFZlzeJknQLPp+MOqFY9n
	xeZXBfCzzAOYT0eR+ooHvsIZq47mMl4Qc5eCkLdSfJ4U2mz5IOIRArOCIxy7pMeU
	wMEeMRcYWekuS031efcv2BYJWEJaOj6SVqnBsKpiDoVSwOj8aQljJYZUn7ocIOZr
	oKsLWaK9D+6pV9G1wGiA2F/8UNXnQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgmbtaa4r-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 29 Oct 2026 13:00:51 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69TCo3743196606;
	Thu, 29 Oct 2026 13:00:51 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hjvh218w3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Oct 2026 13:00:51 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69TD0i5534341314
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Oct 2026 13:00:45 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D522520043;
	Thu, 29 Oct 2026 13:00:44 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B1CBA20040;
	Thu, 29 Oct 2026 13:00:44 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.68.31.243])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 29 Oct 2026 13:00:44 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, borntraeger@de.ibm.com, frankja@linux.ibm.com,
        david@kernel.org, nrb@linux.ibm.com, schlameuss@linux.ibm.com,
        gra@linux.ibm.com
Subject: [PATCH v5 0/7] KVM: s390: Misc bugfixes for 7.4
Date: Thu, 29 Oct 2026 14:00:37 +0100
Message-ID: <20261029130044.125032-1-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA0OSBTYWx0ZWRfX27auR0oCYslH
 oj1T1XXi2Edbcd3EROyly6ew15jEw0K4FESDtdlvmeTl73qYikQgUoTJOWFrBw3Nrz5DzOWV46/
 IW+XjnSjdzTSLaCTJvjcvWVvEPNVpkWiX9gugdUSEKZlK4o2TtDMAiysoh028DbpqYZsE/E/dXz
 MomYhHbk0gbVPZKyLo9YnCGdYZcwLAsTP12NsPqYmUPGxX1Q+aCRAyHxYxaiGhTAOVeZVZLIRb7
 7lDCxzfh8q6nQRXwbk/GOO4CTe2MnhupazyLvO1nkZukT0kirCf1vBWC+IER/JqVReWccVaQa/K
 QzG1I9BT5ssYPx372z86xIMdm7BgTRvugUUg/GBgSEjYjScmLENx722iMF17hcI2pjH/nVzL5m0
 cvsVaOoI9HcEOgDG1+eReTd41ug7p7+HJNqpg6ad5lXUZExDKbiWUm5IUmDEgoWx2qBcA9N+9e5
 OyCW9cQOlMKSDUH1Bpg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA0OSBTYWx0ZWRfX2WT7ER0n45ct
 uR4Qm8SKAXJBCZkKrxzZTNKucO/IkjthtUGO83FqMx5rgpYGtUyZ6a0YlX0R+5dRTWSBKZvK3xF
 BNnNQl/NbXjfbQQMcltnVT5cos+lRIg=
X-Proofpoint-ORIG-GUID: Ge_fhPkTKjX_dTmccwTe_Gi4THfc8OWP
X-Proofpoint-GUID: Ge_fhPkTKjX_dTmccwTe_Gi4THfc8OWP
X-Authority-Analysis: v=2.4 cv=CeKdd7rl c=1 sm=1 tr=0 ts=6ae34383 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=6_dDdnKulsZJQZLWuZAA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 malwarescore=0 phishscore=0 clxscore=1015
 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610290049

Misc bugfixes.

Some Fixes tags are approximate, since the bugs arise from slow changes
behind the scenes in the kernel, and not from an actual bug at the moment
of the introduction of the original code.

v4->v5:
* fix check gmap_unmap_gfn_range_fast()
* refactor and rename the function to enable cmma, now have a lockless
  version called gmap_enable_cmm_already_locked() and a wrapper called
  gmap_enable_cmm() that performs the locking
* fix missing DAT_WALK_USES_SKEYS flag
* fix some comments

v3->v4:
* oops! some stuff removed in the previous iteration was actually needed
* improve patch descriptions
* fix idte_crste() clobber and table type (partially picked from v2)
* s/IPTE_GUEST_ASCE/IDTE_GUEST_ASCE/ when using idte_crste()
* improve comments in gmap_unmap_gfn_range()
* do not attempt unmapping prefixes if the unmap range is above 2G
* remove useless !hpa check in pin_blocks()
* fix cmma issue when using large pages that caused the whole guest
  memory to be allocated

v2->v3:
* remove all non-bugfix patches
* rebase onto master

v1->v2:
* add "memory" clobber to idte_crste()
* remove superflouos gpa parameter for unpin_scb()
* clear the zero bit in the PGSTE when unmapping, add missing barrier


Claudio Imbrenda (7):
  KVM: s390: Fix UCONTROL inconsistencies
  KVM: s390: Move some skey functions to headers
  KVM: s390: Fix idte_crste() clobber and table type
  KVM: s390: Improve unmapping of large ranges
  KVM: s390: vsie: Fix pinning using the wrong flag
  KVM: s390: Introduce gmap_enable_cmm()
  KVM: s390: Allocate page tables when CMMA is used

 arch/s390/kvm/gmap/dat.c  |  26 -----
 arch/s390/kvm/gmap/dat.h  |  48 +++++++-
 arch/s390/kvm/gmap/gmap.c | 227 +++++++++++++++++++++++++++++++-------
 arch/s390/kvm/gmap/gmap.h |  11 ++
 arch/s390/kvm/s390/priv.c |   8 +-
 arch/s390/kvm/s390/s390.c |   4 +-
 arch/s390/kvm/s390/vsie.c | 135 ++++++++---------------
 7 files changed, 299 insertions(+), 160 deletions(-)

-- 
2.56.0

