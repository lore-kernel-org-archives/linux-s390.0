Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89391282F0B;
	Mon, 23 Mar 2026 15:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774280214; cv=none; b=U/pTJ7R0dOWRbYWoNfdFSfxvNaWx2akySuuWDeN6BlIOu9L2m9bnfuYVKYDtK6RO+GvM2/FSAhLxvmXlqzr0a7SlAA+pkaq3aeNzQ0JHfUAoZHOojD4qe5Sc1cSVRQO+UJ4L29al1WtkVktDHtIIfPiryxlCkxbwQm+/KCha+dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774280214; c=relaxed/simple;
	bh=bHvL3mTTJkNKY9cDafYDX0aHKnfEM2PLNCf/VMCNzGE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MN1cbaEC+X5ezZtdoj8uYWDLRRe6hkFrX09OhcjxNoSicf8Vh5bLYdaIllU79y172+wG3NIaXsqRmapHnpXJE0ZCrqXCjufAjUXCohc2EyatyYsSyAvFeBPRIe2r8j3z+R0y0mM+DgCuZoJIG/kE4N4ys+7zkPABK2TU+u6SOQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TsCpEAJM; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TsCpEAJM"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62MNCZQk632924;
	Mon, 23 Mar 2026 15:36:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=wNCh1MG+zNfmqNOOF+yxiv6p8fp9Bc/Mj+TBCDGsi
	CA=; b=TsCpEAJMOn1oh5wzXeLgerN/xyhfbvq+I2S2bsGePQiFEIoht1AzUi7uH
	LLvKAGumKcGisgV5h49ofQsM9r0m0XRzr0ptDosYoTmjLJxZs5qUSXKlJYsyEiqS
	MOFFqiH6Eir4cwDMg6o7eC664f9EnErwMNpII4UlYgHAt/oXUcBQ0olgEjjVGPmd
	K1pmf0QfJA8YtBX3hvl3VOdAxmkKqmcE7iTUBoLoKxu7DY97wAzYaU8ENDBqtpwH
	1cdLYTKhsNasN2I1aBUN6esCoa5ypZoaaTzGlY43UQ+sg+/tF5VDUcRrg/RbCy0G
	oc+dluC6YVxX+PEnhHwfBptUweCDw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kumf8jb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Mar 2026 15:36:52 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62NCCoGJ008722;
	Mon, 23 Mar 2026 15:36:51 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d26nndwts-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Mar 2026 15:36:51 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62NFalt547251870
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Mar 2026 15:36:47 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9D79520043;
	Mon, 23 Mar 2026 15:36:47 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 78E1E20040;
	Mon, 23 Mar 2026 15:36:47 +0000 (GMT)
Received: from b46lp25.lnxne.boe (unknown [9.87.84.240])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 23 Mar 2026 15:36:47 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, imbrenda@linux.ibm.com,
        borntraeger@linux.ibm.com
Subject: [PATCH 0/2] KVM: s390: Fix lpsw/e breaking event handling
Date: Mon, 23 Mar 2026 15:35:21 +0000
Message-ID: <20260323153637.3683-1-frankja@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: u0fYzQ8mxwI4ADhaohyWu8Gwyy2azrnx
X-Proofpoint-ORIG-GUID: u0fYzQ8mxwI4ADhaohyWu8Gwyy2azrnx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDExOCBTYWx0ZWRfX2GsJfdOus8eI
 JchamRFPD1lxnFPpMfufEPBh3q5nXYHFA+ZIqEmF2XI0PhsczeMbTYzeDTo8mLdyYBDO2lXKWiM
 4V20hbeIdZGjBUaNmc7jS6jrMUkL4E4ksUmPWyiHPdzqUFt3L47eYNkMlDLn4hFETkEduHvmcmm
 66MOo4/u7lK6evvHXTOUvUyaaSPPcUN4XIJr69fpshxr1dXuso+QgINUoPrkBXLEsh/lGJ03cB/
 9Pcf9WOfrMWkCUHP1ZFkXSsWtiglPUf6QDibBBlrop58vq1TJyBO3pBCUgZCDSjWAf+Bscj4cdZ
 qSNfmxQTW9W8L6yX/mOHBtM+tucXpYOu2b7f6o0SBDNAWWAHJ6aFHjnrazYKkjHkFO0mPmywPyy
 jmjAniDQhlsqhtiUeqaBlbj2hRfAagBwKqMz+9hvJaWeDvy+JDhcfi6HgQpdlENY4rnYpcXC4iE
 oYJP8fgyZSslu9UQKXg==
X-Authority-Analysis: v=2.4 cv=KbXfcAYD c=1 sm=1 tr=0 ts=69c15e14 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=yfD5ejUAVKq7M6gFPusA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_04,2026-03-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230118

LPSW and LPSWE need to set the gbea on completion but currently don't.
Time to fix this up. LPSWEY was designed to not set the bear.

This is only ever problematic when a machine check is pending and the
guest hasn't opened the PSW machine check mask. In all other cases SIE
handles the BEAR. So impact is very low.

---
v2:
 - BEAR needs to be current psw address - ilen since code 04 is
   suppressing
 - Added simple test
---
Janosch Frank (2):
  KVM: s390: Fix lpsw/e breaking event handling
  KVM: s390: selftests: Add load psw bear test

 arch/s390/kvm/priv.c                     |   8 +-
 tools/testing/selftests/kvm/Makefile.kvm |   1 +
 tools/testing/selftests/kvm/s390/bear.c  | 184 +++++++++++++++++++++++
 3 files changed, 191 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/s390/bear.c

-- 
2.51.0

