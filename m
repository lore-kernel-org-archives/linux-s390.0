Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37AB830F547;
	Wed, 20 May 2026 15:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779290243; cv=none; b=iHNDM9lYNkYqP0wvx2h7MKS176TVYpnESu69nK8zvkgO6xTNRHE7YX7sRf3KMQ1xsSpIBtt+N6W9va3oqOyfZRfs3BIdV7BNnKGGeQmEkMbE/laWt3WQlmGOrVlLrDtbkjqmKhKvIEEJU0ABahEaiK5TgNWuyFndwAM6G2OjP0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779290243; c=relaxed/simple;
	bh=wao69F2fYzGAm1xShC2L3IKB6BY+u01qVLgXZYpZ87U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b2lcaqoSMCcXN2SsNuZqaW2sfh5vFxLjdO2j7OFz0KPKnevYLqFyvLCaFkYV2kfhv9YcTI++tJGSHYxGBeLM6nbXXChleYmnPrw3zp0JMNWqQS4IaSToLfJ60cuPw66lm1ckZ9dtMAsTmpwaer8rv0ank9XkxpI/3lOzWq1RkAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IGzyPiKM; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IGzyPiKM"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64KDLJPf032105;
	Wed, 20 May 2026 15:17:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=Jg4Rx57yUMFUf3bJ8MXSUq0mVCrNSPhApK+Uqt7oG
	WY=; b=IGzyPiKMIgPkRo4qaUlkSkjMlt55Syd9NCHXBVEsP5GDk6pXykvFD41kC
	o3BPu0f9+x5uoZPksQ9tH+ydR4MktrE6WTdh+gdzxYCTWG2EQIjVYAwELlO9aNgt
	BHeFr4o/9nGUo1YhftISOvV5AY6dwGDpZdFip9KcSllUHJXOTL+FsnjO616z0N24
	XxziL30m+ief2aZBuDWge3OygiObk/XZL9V6eBBJWPjqBWi33wH5oltLb6dSgXny
	pHvMot/h4xu+hsp2rcx12enukvtGB7upGFPWyAguCLcKDLSqmRR7MIoauCIrLMn9
	VYOXNIeum1JpPTOqgnsSH5h87ytww==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h9y2sev-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 May 2026 15:17:17 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64KF96JO017173;
	Wed, 20 May 2026 15:17:17 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e754gfp1s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 May 2026 15:17:16 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64KFHBsW26018136
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 May 2026 15:17:11 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 63AC220040;
	Wed, 20 May 2026 15:17:11 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 23D7D20049;
	Wed, 20 May 2026 15:17:11 +0000 (GMT)
Received: from p-imbrenda.aag-de.ibm.com (unknown [9.52.223.175])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 20 May 2026 15:17:11 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com,
        pbonzini@redhat.com, seanjc@google.com, yan.y.zhao@intel.com,
        isaku.yamahata@intel.com
Subject: [PATCH v1 0/4] KVM: s390: Implement KVM_PRE_FAULT_MEMORY
Date: Wed, 20 May 2026 17:17:06 +0200
Message-ID: <20260520151710.231788-1-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDE0NyBTYWx0ZWRfX4EVSu5tSyKvN
 DrYG5Sb7J3b50kYVGudof4fsctdQL7P0nP2fecXo0/AKnAimq+qXK6HsG1OeCfzFmMg2bogxqpJ
 6I5xKAmnK9qozho3mwJasw8ySy600VjD7+8lQNNwbWjaGoAX25vHHQLo4JauTddORxWkJVk1DPF
 UPvoCDJ1UKdzAdqOekj4sEq6/WJEWCup45RSr6PEfKo9fvmAseZC5STLPneX198Vx3gJ15AGFJR
 GXD6bEXMxQwA+ReeS1FKiJGblJSXuV3zdxhVKId7DAY3iYZPSlu6EzgrPvr41SoRPqtKPQJyi1G
 lxdEXGVXkK1bMk+5L2zSujboPE7fw/ZnGbDvetelXzriHfwEJp4b4Y1GwOiVpIFSdChJYvx7vfQ
 cITGOxKu1hmWdPB78Azy4GDFqcq1/deJoWaFZ82ZUYWriGWu/VkSKEg4K1b1PQqetUCXPTr1aAl
 /5v+mgoMXLWU1xRjeiQ==
X-Authority-Analysis: v=2.4 cv=BNuDalQG c=1 sm=1 tr=0 ts=6a0dd07e cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=gonlQ4SBPNJqcCZ8TcQA:9
X-Proofpoint-ORIG-GUID: GVM5E0vT7xQR2duTEPQo5ObYPhVBdiwr
X-Proofpoint-GUID: RSsGa8SVrEW7u_jp0YhrgcvEC8i8VWQG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200147

Implement KVM_PRE_FAULT_MEMORY on s390, and update documentation and
selftests accordingly.

Faulted-in pages will be marked as accessed, unlike x86, otherwise they
will trigger a minor fault when accessed. Avoiding such faults is one of
the points of KVM_PRE_FAULT_MEMORY.

CCing x86 people due to changes in the documentation and the selftests

Claudio Imbrenda (4):
  KVM: s390: Implement KVM_PRE_FAULT_MEMORY
  KVM: s390: Update KVM_PRE_FAULT_MEMORY API documentation
  KVM: selftests: Fix pre_fault_memory_test to run on s390
  KVM: selftests: Enable pre_fault_memory_test for s390

 Documentation/virt/kvm/api.rst                |  5 ++-
 arch/s390/kvm/Kconfig                         |  1 +
 arch/s390/kvm/kvm-s390.c                      | 41 +++++++++++++++++++
 tools/testing/selftests/kvm/Makefile.kvm      |  1 +
 .../selftests/kvm/pre_fault_memory_test.c     |  7 ++--
 5 files changed, 50 insertions(+), 5 deletions(-)

-- 
2.54.0

