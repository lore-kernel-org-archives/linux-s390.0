Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1003FD96D;
	Tue,  2 Jun 2026 17:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780422511; cv=none; b=QhTcR29Ywfyrp41F83eCLxIhg9nncalS3LPtIw75GXaiRwIxxuNTzDeloR6VmrrjVGFQ8uUrBHuwynTDoGvN8KvFpFx8EoHMmLXTn1CQKdKKnsnnQTpUwzfB8jC4qUoqaYX5zgil0zJ+pQsAtfSQfg9Gjn36mb1IT7x/y2GSGLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780422511; c=relaxed/simple;
	bh=WNtLAfR5mrn/tWcMG7T4k7rB+PT/iJt/moyZBlG1iHk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c9YzrjRCzBOu8AU95/c3JpI4D+eXIM6WUiC2ofgy72P3rrVbPSfdq1SxvTs5seQd2L8+C5ALeUqqDc48amiHMiLkkyttp7vMQmtAAsObYesQnUC1HIYS9P++JlSW+XZHCBiUVkFUivyY3kVFCzcnqALj6AaX9hRekZcrYTkYgLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eQRg4iKj; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eQRg4iKj"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 652Fmor2792406;
	Tue, 2 Jun 2026 17:48:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=Vg2SZBI521Ete7e5Z4JK88cbwfwQ2MYrThNYyLraY
	S8=; b=eQRg4iKjMSjssXDUKEsbaQgK1+pmNowJnQUHtQNVbBtqxkenXlINPm1WK
	/YY6TQItEkZIjlRPdYHM8iCNr57GUSHsKsYeYIGPHsSgQ8bECeND+zHFi32ci2Zl
	WkPzCChaNlYa45rRMVyuSQkAiAPL4Wz45JIBLJXhxYWgjfRlTZEVj2IQjGIujJQS
	kxueWOjzZAPJd2fs+LUNz6u8vG5DpJPdWVMZWBrSBkkVyM5DfDjuuqNR9/poF0Qp
	SlAhrknsg7eFHPLI0xmMJVAp0fU+QpvBPYT6CF5F2iMsmeNMgiXhZHx+yAn6b4MI
	bPBMBSpAewr0MGCGL0U3ikI/5mi7Q==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqjq774k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jun 2026 17:48:26 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 652HdTxQ000558;
	Tue, 2 Jun 2026 17:48:25 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egbqhcatu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jun 2026 17:48:25 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 652HmJRT31130120
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 2 Jun 2026 17:48:19 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5DD2620049;
	Tue,  2 Jun 2026 17:48:19 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3FB0B20040;
	Tue,  2 Jun 2026 17:48:19 +0000 (GMT)
Received: from p-imbrenda.aag-de.ibm.com (unknown [9.52.223.175])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  2 Jun 2026 17:48:19 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        borntraeger@de.ibm.com
Subject: [GIT PULL v1 00/10] KVM: s390: More gmap and vsie fixes
Date: Tue,  2 Jun 2026 19:48:09 +0200
Message-ID: <20260602174819.255785-1-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: _gPyd0FHOAbP8MD7NHJcE7EnEjdqFVG4
X-Proofpoint-GUID: _gPyd0FHOAbP8MD7NHJcE7EnEjdqFVG4
X-Authority-Analysis: v=2.4 cv=bcVbluPB c=1 sm=1 tr=0 ts=6a1f176a cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=OCTrKYgFWj1iwrhz590A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDE3MCBTYWx0ZWRfX7ZVre7rqJ/Yc
 zD5pTr/nr+bUPYqnizEP97vXNOQ0HTZOthjbtoKI0Ano1XfNntMBimJpASn+Z8lUjD0dJDth94f
 4+Y3im2Vqyq8ME6wIaLXNiZ3K4MtdeYcBIrut5WCna/wC0ZrwuiNfgj1stYyZmG67BM6NgRTQDg
 r3BLFkT12ohdHNc+Cr8rpiky0AvIohILiWLiCfonBQxFu0Wr35BSXS36NJv9CIYDjb0Dt9sVgt3
 MybNjqQJMGkeYrpDEbi836Aupou76+Jx+UA/eqI2mYdJp2wWFauonZCkGyKuKL+eWmDPfg+xaYl
 Rmt6syuizJlmai8eV1DFyWy2QMzj/siIxshe17vB3bZ/WMfc+eoiI0L6XQdRKgkKkumuSQk+boL
 Bflu4fjBOTUUnER7OTZGCRhuDyhC+ylv9kjCoTDScG+ZAmAJ8MCo0lG9MdnsBzaMBJixMPw1sVR
 1SjngwS2kw4BvW6qp4Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-02_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 adultscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606020170

Ciao Paolo, 

please pull some more fixes for gmap.

I really hope these will be the last ones, but I say this every time,
and here we are yet again :)


The following changes since commit e43ffb69e0438cddd72aaa30898b4dc446f664f8:

  Linux 7.1-rc6 (2026-05-31 15:14:24 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git tags/kvm-s390-master-7.1-3

for you to fetch changes up to c1edda54a0f713412f5914f9c9080856694bddca:

  KVM: s390: Remove ptep_zap_softleaf_entry() (2026-06-02 19:31:20 +0200)

----------------------------------------------------------------
KVM: s390: More gmap and vsie fixes

----------------------------------------------------------------
Claudio Imbrenda (10):
      KVM: s390: Fix _gmap_unmap_crste()
      KVM: s390: Fix _gmap_crstep_xchg_atomic()
      KVM: s390: Avoid potentially sleeping while atomic when zapping pages
      KVM: s390: Fix guest / virtual address confusion in _essa_clear_cbrl()
      KVM: s390: vsie: Fix rmap handling in _do_shadow_crste()
      KVM: s390: Fix fault-in code
      KVM: s390: Lock pte when making page secure
      KVM: s390: Prevent memslots outside the ASCE range
      KVM: s390: Fix possible reference leak in fault-in code
      KVM: s390: Remove ptep_zap_softleaf_entry()

 arch/s390/include/asm/gmap_helpers.h |   1 +
 arch/s390/kvm/faultin.c              |  30 ++++----
 arch/s390/kvm/gaccess.c              |  11 +--
 arch/s390/kvm/gmap.c                 |  19 +++++-
 arch/s390/kvm/gmap.h                 |   3 +
 arch/s390/kvm/kvm-s390.c             |  33 +++++++--
 arch/s390/kvm/priv.c                 |   8 ++-
 arch/s390/kvm/pv.c                   |  21 +++++-
 arch/s390/mm/gmap_helpers.c          | 128 +++++++++++++++++++----------------
 9 files changed, 165 insertions(+), 89 deletions(-)
