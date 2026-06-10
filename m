Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE2834753F;
	Wed, 10 Jun 2026 16:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781110378; cv=none; b=n47j7CriA8hkwDEOKHeZW7sOT7AXlyUkvyciimoEwTEuPZfuFBrPv3ofJQsfsqX6NVlIg8VBaX7uB0CE5f7FXF2ucBYjRdhXhFD5ByZWOMBwzQN76By+7AgWqK96WAjodWl3hhORjfSPBQEn4Yw++T51FGdXvQcNatU1235QlRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781110378; c=relaxed/simple;
	bh=jbk6yBEdIz+siIk4AW7hcrswKcQ5IcPD/9629Hos0/k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cpqUSKuCvxBhaS2UM20gXzYVWfF5GEiZM2dyglO0Gbf8QcDriUH1aWPxeqF1S3vF3AMISUInEFsEjfsJagDCR3m744nhA6bRFlVN/bPo1ZTWzJUEt3pfhifoxjfIoCWujYtEhDkjSKwWvbO98fqQfxoNGHzZF3BdNU9BAjmD3QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=geuYnpIl; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="geuYnpIl"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65A6Saof3739674;
	Wed, 10 Jun 2026 16:52:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=quHNC8xouJtRxjNmNIJvukXcwZ1ls4HZ0NJKzRWu6
	iI=; b=geuYnpIlZK8RCRW+O3KkgSvZnosxECF0aAGka9nmpX6bNurqxa5lYyN5m
	j8tymSZ7c4NW3cd3527+0cks/KC7rVaHb2C86O4WmYk0dBwuvq2KGfoe+RQBq2XS
	6oXp4kpUx8Qo8tDPEgsfJxRzBHbA0Gk6CO/IESaBreuWEuHtqmeOEs8j2FZ1kRn7
	3KoMsqKegfrj3oTg7V2UcpjMwGWgeRwvIDuQCa836Sykd7dg8O2XOgcnU/CYLKKk
	GypDDaV16hoKg0AhLszSvL7Zs99ZjycjaI9BGKp1p6+CAEPNBjvMLUDItUQ3uMs7
	pD/1tBPuoeFFbRPpZTHBdYHdCWZxQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4em8yj1xfg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jun 2026 16:52:54 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65AGnar8010361;
	Wed, 10 Jun 2026 16:52:53 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4emwvq7pe5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jun 2026 16:52:53 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65AGqlKD49545710
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jun 2026 16:52:47 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AE3F52004B;
	Wed, 10 Jun 2026 16:52:47 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7E78420040;
	Wed, 10 Jun 2026 16:52:47 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 10 Jun 2026 16:52:47 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org, kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        borntraeger@de.ibm.com, frankja@linux.ibm.com, david@kernel.org,
        seiden@linux.ibm.com, nrb@linux.ibm.com, schlameuss@linux.ibm.com,
        gra@linux.ibm.com
Subject: [PATCH v2 0/5] KVM: s390: A few misc gmap fixes.
Date: Wed, 10 Jun 2026 18:52:42 +0200
Message-ID: <20260610165247.238366-1-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDE1NiBTYWx0ZWRfX4d5SU0bndSkI
 DyjmBoyc3JqpC4JAy9JkERE/IWP1vfrQzcxnsoRBpUsKA0i2f1SDspYK+RfEnkZhXkeReJC02/X
 OTIM5cWW0psoqyiXqQNaQg4/mYj80/KbOuSR17JzmeBMf3Ko3c4RmGoV5DV9+jLOaA75lQ/+Oag
 qKgB8NrRt+RkLJp0dH7+1C24cyv5vrlyRe0gyz7+jsWSOqBAN3L+SpVvhBwkN++hGmt3nOwGJmw
 cektIHIx1zM0uNm+Kwoun/FQF4N9ogy7XnBdjWKdWIC0fo4RLyclcYE9oPwjbO9uiBFOSVEg9oX
 PDc0Gmb90CPNtV8Y+NNHyiBJXi09rwrKZF5LwDu2rjhM/Ak9XaCrmaHUDB7FhxNS99CeIAmEDee
 fAmtmbERvEX2a3deig3oDQbLeAFZCb0ELWiKSbgdRstKHahkkeAUTuIMK+nl3YTlYfpkwQZMCCc
 Dc65+koNTFEHm1Q8qAw==
X-Authority-Analysis: v=2.4 cv=HvFG3UTS c=1 sm=1 tr=0 ts=6a299666 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=NwVYdQMMGb_YwOmgCikA:9
X-Proofpoint-ORIG-GUID: 5y0QIONP62bslpwex0t_UFVzn-Uf0fVL
X-Proofpoint-GUID: 5y0QIONP62bslpwex0t_UFVzn-Uf0fVL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_03,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 phishscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606100156

A few more minor gmap fixes.

v1->v2:
* Improve suppression of __must_check, by using a pointless if instead
  of casting to (void)
* Fix allocation size for struct vsie_rmap in kvm_s390_mmu_cache_topup()
* Add missing radix_tree_preload() in _gaccess_shadow_fault()
 
Claudio Imbrenda (5):
  KVM: s390: Silence potential warnings in _gmap_crstep_xchg_atomic()
  KVM: s390: Fix unlikely race in try_get_locked_pte()
  KVM: s390: vsie: Fix allocation of struct vsie_rmap
  KVM: s390: vsie: Add missing radix_tree_preload() in
    _gaccess_shadow_fault()
  KVM: s390: vsie: Use mmu cache to allocate rmap

 arch/s390/kvm/dat.c         |  2 +-
 arch/s390/kvm/gaccess.c     | 65 ++++++++++++++++++++++---------------
 arch/s390/kvm/gmap.c        |  7 ++--
 arch/s390/kvm/gmap.h        | 14 ++++++--
 arch/s390/mm/gmap_helpers.c |  6 ++--
 5 files changed, 58 insertions(+), 36 deletions(-)

-- 
2.54.0

