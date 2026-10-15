Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69FB4493D29;
	Thu, 15 Oct 2026 10:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792061313; cv=none; b=J4PvB+tx8NNYdzNtl0LQ8Dji4lm6uO3LbISmj3t8/oUP4sFGDqaA38q7XQY0U6SSsf3I99zLuw4/kvckcRfJtAviYtEPSKegMNOROJ1w1VJw12//BCDN3p9TVWxcO6VrQi3Q1X7JlT7t2am1qh9e4lgWjQE4NMZc2HkQ7uTMdzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792061313; c=relaxed/simple;
	bh=UD6CUQrfPvpCEm3YxfObHA2+AWMACNzVpgtRSpFGncQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CvTH7AKvgr+lwgwxRjwzWufEwxPzEU4ZoZxR6+usaoAfYEkP8+Yj7HwjztcUZbkeyF26RfMBYGmP1WD4YGQSI0ptjXd3l3WB1o+FBLwktSwWY2Jkwz6s6ofS6bF8y0xp81gkFhQHSD8sfkBEtbB7vmI5F3ZL3Xe/uTPYOMu8X08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VZxas6kQ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VZxas6kQ"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69F9kSNX531747;
	Thu, 15 Oct 2026 10:48:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=TEnXgblTZ8WiyV2f0aWQtSLIFNIlls9e0+cNn2Ugi
	BQ=; b=VZxas6kQou/DW4GJZQIyO4kYittAr34f+WlhB6n/+/PQBYRXn9osEwdCB
	Wb4U1fZXJMP6CRA325o44+iNCqVja0uIz3apw8EnYvkydEamSKeo5k0L4EHiZ4bF
	gCLwGJegb24K49X1aRRBSyy+w0QVRmAHFjoBUy6Pmc1MAPLH59FPgsq2smNWPyQI
	0LxfCMIPtJW8QkfTOh6BviUpj1npmlakxAmKyg+yx5JflCDiu5MPA3ljKByVzdSy
	f/+I2HEh/NUfRbD2qTCLdIrD5EpnK7rGK/Phpui5bZyZaYzolYIspaFsX4RXKf11
	Z67DiP/pZp0xG4MqjOiU+Wcr8E0Sg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dv3se0y-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 15 Oct 2026 10:48:28 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69F9nuUK1929703;
	Thu, 15 Oct 2026 10:48:27 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h9pb3sapc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Oct 2026 10:48:27 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69FAldUE30867996
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Oct 2026 10:47:39 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 69F8158059;
	Thu, 15 Oct 2026 10:48:25 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 21B4858062;
	Thu, 15 Oct 2026 10:48:23 +0000 (GMT)
Received: from t83lp65.lnxne.boe (unknown [9.87.84.240])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 15 Oct 2026 10:48:22 +0000 (GMT)
From: Gautam Gala <ggala@linux.ibm.com>
To: borntraeger@linux.ibm.com, imbrenda@linux.ibm.com, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc: frankja@linux.ibm.com, david@kernel.org, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com, svens@linux.ibm.com,
        pbonzini@redhat.com, seanjc@google.com, shuah@kernel.org
Subject: [PATCH v2 0/2] KVM: s390: fix ESSA addressing exception injection in migration mode
Date: Thu, 15 Oct 2026 12:48:20 +0200
Message-ID: <20261015104822.77062-1-ggala@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: tDWkgNV7iJg7CykvAEo2sFbwYkHfa1aV
X-Proofpoint-ORIG-GUID: DbWpArQ23dqDfIde8V3ijiLlTft8Lcyo
X-Authority-Analysis: v=2.4 cv=aqInmiZV c=1 sm=1 tr=0 ts=6ad0af7c cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=8gBezWMw3N2eau65p0gA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA0MiBTYWx0ZWRfX+Wy28cpNMb4l
 yV3M0vJxxXyBYTMrIzWr275lnYWldIRO9sj9TKhirnYXer5azM2j6UMVe+n+2LMxRHeYJ5Wvl1l
 LgizEn0TRWCm713bCMe0i4i/3YJPNUY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA0MiBTYWx0ZWRfX5Z0L9N6AWvaP
 FHMZs7/WCqfA5JOgOH9VF0N62/0dNZ8zuXUoXgYF1DeO/4o2nWcT4fjSRum1H4dkAlMv3h1RhQi
 oCmRrgSRsawFLNoABHfrpVo7mmQ/VBjqarucah1mCiNNi4Ko9m51W0TpJ0OQ5Sr0skRGftc+MP/
 3TRZwZ49zZ+EIn8TcQTflJlSC6iqQkc020YCKFiVqX4fc38GN/jJkH09M7tScyjkki/cz5IXhTF
 q65A7VGcU3WPaNpOqpVhPbvthtqUxWxRCsY4lFiqdHEalUilzO3a7ALwvmbEGx3B4QAsdfSXu+T
 289YbU8G1V4mkf1O379FDpku/6Kj9tgqvRwlMwU9NCcrptdBqQLg9aQhf9m0NPATH1rExiqWXHx
 2EmN5pUFy0jIkBWIR6Ei3l7tH+dz01kuBFrXLccDOGlWpdPmf0YLffJpnkygYoMcoVqPcr4NF5x
 BVIS1na2eb3asAkydGQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 spamscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610150042

ESSA emulation in migration mode silently dropped addressing exceptions
when the guest page-table walk failed, so the guest never received the
expected PGM_ADDRESSING interrupt during live migration.

Patch 1 fixes dat_perform_essa() to return PGM_ADDRESSING on a walk 
failure, and __do_essa() to inject the program interrupt when it sees 
that return value.

Patch 2 adds a regression test integrated into the existing cmma_test
selftest.

Changes since v1:
 - dat_perform_essa() now returns +PGM_ADDRESSING instead of
   -PGM_ADDRESSING; kvm_s390_inject_program_int() takes an unsigned u16
   so passing -5 would have wrapped to 0xFFFB and injected a bogus PIC.
   __do_essa() comparison and inject call updated accordingly. The
   kernel-doc return-value entry is corrected to %PGM_ADDRESSING.
 - Selftest: pgm_handler_c() now reads the actual PIC from lowcore
   (__LC_PGM_INT_CODE) instead of hard-coding PGM_ADDRESSING, so the
   test would have caught the sign error above had it been in v1.
 - Selftest: virt_map(vm, 0, 0, 1) added so the DAT-on guest can
   access the lowcore to read the PIC.
 - Selftest: PGM_ADDRESSING, __LC_PGM_INT_CODE and __LC_PGM_NEW_PSW
   constants moved to the shared s390/processor.h header.
 - Selftest: SIGALRM/alarm() timeout wrapper removed.

Gautam Gala (2):
  KVM: s390: fix ESSA addressing exception injection in migration mode
  KVM: s390: selftests: add ESSA migration mode PGM_ADDRESSING
    regression test

 arch/s390/kvm/gmap/dat.c                      |  5 +-
 arch/s390/kvm/s390/priv.c                     |  2 +
 .../selftests/kvm/include/s390/processor.h    |  7 ++
 tools/testing/selftests/kvm/s390/cmma_test.c  | 69 +++++++++++++++++++
 4 files changed, 82 insertions(+), 1 deletion(-)

-- 
2.55.0

