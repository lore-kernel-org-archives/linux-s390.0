Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6937B3ED5D6;
	Thu, 23 Apr 2026 12:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776947972; cv=none; b=UnQYzGH8I4d6crk/fgmh/nbiqXtHGVOhT864Rpu1coHZ5jFT7bkhj3vHIUXnLld3v5Siqo8DpzHn0AX1g1V3/LoWszSmw+WBN993fyK7/Exaw7xa3ap4AQ4rP4ZPq/kwecRSWpemEX+4UaaGiD53XneRZbSRP0NmKB2Av3j9P3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776947972; c=relaxed/simple;
	bh=2J5RHw9q1lXOm2f7WysPab7ia3qyGVCWgWQrs027k50=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PfGlz/GI7qTXgvq0l7G9UsoDz75PpJbRdfTr2ZjJCH6BAo+5cZ1pqLH9o896gAWpVFoqT7iiBvhqdQ9y4b/NvTfdc37ve4KLYWJX7t0ppCTsptth6rPOO9UzvNu0IQeOI5BPsK7lkBV7YoEOgEBTtuVF40C3OYrFuuoJ++DavAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DFl/AtsA; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DFl/AtsA"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63N6wvGe3229030;
	Thu, 23 Apr 2026 12:39:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=CqBreVrg+lCZGMRiImoE/4xa7xBz0hRBrSGPDMeMp
	go=; b=DFl/AtsAGLRVGrVjzFdgATnCx8QjBmFm3Bn3xpcpCZYmNK2dFlyIc3bBY
	zZqQXiwu0MonNsC3ntG2hpPrbqjnIey1Lmc0mD/tN+CzaRSHJFZ38Nxsr/lywqkO
	LQrvvLFkGTywkslO+QQM2EKm+josjvyr9BU5KFvdWD+n3RjEUqSq1yRWABQz/Mi4
	WKXp4JeCtnVDHIHUM+R+6lo8Fq17bBtol1vOmyQJUmKUxja2fPFROQ72JKNBL0sC
	kvAz6H1CjPna27TGlVbKjblC/3jMKnhJzuoYTDFN/zhxNXnFAOtdLycG+gy/fdeM
	sShJS50y1w9He+vA+wIxOwhebpJ0Q==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dpeu28m8v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Apr 2026 12:39:25 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63NCZXTh017764;
	Thu, 23 Apr 2026 12:39:24 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dpjkypk5s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Apr 2026 12:39:24 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63NCdKJS31719816
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Apr 2026 12:39:20 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 740032004E;
	Thu, 23 Apr 2026 12:39:20 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 50ACF2004B;
	Thu, 23 Apr 2026 12:39:20 +0000 (GMT)
Received: from b46lp25.lnxne.boe (unknown [9.87.84.240])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Apr 2026 12:39:20 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, imbrenda@linux.ibm.com,
        borntraeger@linux.ibm.com, hca@linux.ibm.com
Subject: [PATCH 0/3] KVM: s390: Additional LPSW/E fixes
Date: Thu, 23 Apr 2026 12:36:01 +0000
Message-ID: <20260423123902.14663-1-frankja@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: KKnqTDTb0UowJc90hrsS_wXejtuVOcjI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDEyMiBTYWx0ZWRfX2ToK62VMWtP7
 DLV0HGoLHoOgfwGeExP+BDG0e1VxdYlgrvyJByQXI0kLJ2c5GTKmFbD+nWDUqb7sY6YFWEF/O0o
 2SexqSQEPlX4GyYKudYxq4HhIG/eiokAGmA/hu24rhKrZf1GKBgXZf/6VrolIT3k7E4P/DwXepm
 nf16gjeQP8HhdGnG+V1TPSUtGlTGc4kb5SSegqFJfJ23fhwZvbD8pHMGEotSWJsgvqqJ1nBg9K7
 3ZdQzpwE1WJ+GDsF6zQVyKwgARuNQISrINJ3c000HkmT0uh5L99X3shFBvz2VfaOIwU0trCu78N
 GoWsFYnPBfYuiCE0KarxaVFS546F9k4M1vOylX0/KYcAjLUcr2Z/bxzv6/eH5hCd2i7fj0cYben
 OclU/P3dd2Hg/dvXtUVmP48lviAgRNfAS/XDbgkfvensBf0aPc6CLLkla0aMUMsyU8j3UjbpW/o
 g4l1vZ5+YNhB7V+zi1w==
X-Authority-Analysis: v=2.4 cv=C8LZDwP+ c=1 sm=1 tr=0 ts=69ea12fd cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=eHXGqAvx3rN5R7lAsOoA:9
X-Proofpoint-ORIG-GUID: KKnqTDTb0UowJc90hrsS_wXejtuVOcjI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 impostorscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604230122

Another round of fixups for LPSW/E since Heiko found a problem with my
fix and I found another pre-existing issue where the ilc is not being
set to 0.

To verify my fixes I've added code to the bear test which loads an
invalid PSW and checks the bear and ilc values. Due to the current
s390 lib state I had to resort to real address memory accesses.

I'd expect the fixes to arrive via master while the test moves through
next landing after Christian's cpumodel change.

I've added \n two the first fix to make the code a bit more readable.

Janosch Frank (3):
  KVM: s390: selftests: Add load psw bear test
  kvm: s390: Fix LPSW/E early exception bear behavior
  kvm: s390: Fix lpsw/e spec exception ilc reporting

 arch/s390/kvm/priv.c                     |  20 +-
 tools/testing/selftests/kvm/Makefile.kvm |   1 +
 tools/testing/selftests/kvm/s390/bear.c  | 250 +++++++++++++++++++++++
 3 files changed, 267 insertions(+), 4 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/s390/bear.c

-- 
2.51.0

