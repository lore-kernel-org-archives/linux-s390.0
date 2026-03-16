Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5777233CEB0;
	Mon, 16 Mar 2026 18:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773684268; cv=none; b=RsqyXn6Oadg1r3XL8W/AtI/o001NSxXeBpHHxumukakyaNdB0BmvYfVHHY+GNUXXz+vT/OYTZUp+0qTwDf1/BVuDEdEgxE7IrqoXhsjQjGpN5tcJVgzV83htMuSoueVhzYX9ZamubrC3Pirc5UrXEsgeG/OJurOVoLbumgBXqkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773684268; c=relaxed/simple;
	bh=4+HoN8MJPq/VDHo1p0CPDtEXUH3Cr8OONGqxwYUMPaE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QcvESbNHgod81EQmkHvIPSA+VmN/C1Op+TavTj+wIr5MzLx5Qrbinn0FoaTUGBRMCsJpht4pj0/bbr8jaC19+NtBfYH8MQ8tbTz/XJQ1hxZZWal1ibknjRPi95qFq61tLO4ETdpDJf921je6F373XRnMR2hIa6ixBgm8o4SDW8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=h5iLDg7a; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="h5iLDg7a"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62GDdsMP1363601;
	Mon, 16 Mar 2026 18:04:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=Egxw+3ZO+w7qQy3UP8zLGt9NROMTL3WgKb4pfYjSM
	ao=; b=h5iLDg7amnvEtQZaoS/FbZHTIqUyK8kLjuDiMSDMFYN+KZ+rz/1F6vdAS
	H/x2aBRSFLnrkn5gr/+B7tW/SqR6NBui31KH124c3Ha3AVbM27u1Oqm3XFkAy38k
	4c1lWhuQS+ppYkQtry/tnTSNrgrE8OjBEj5ju9XvF0bP7r1SpCXaf14/9pi4SLPj
	cIlJwvDR6jNUnbN4lQCzL9z+mS18adsW8aY3Tr7hJpa6gVcg8USDrGSKVlP+JIaQ
	+EnaOr7/wPING9rlZTAF0mW5SaC6+PtTdyvyCeeU4eGwkbsO/K+gH6YbIM00USvc
	lfazKSlvn4wG84PWY9awpuwfF7t5w==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvy64h7gd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 18:04:25 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62GFCRjx028765;
	Mon, 16 Mar 2026 18:04:24 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cwkgk5sfb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 18:04:24 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62GI4KFQ22085908
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Mar 2026 18:04:20 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4B21620043;
	Mon, 16 Mar 2026 18:04:20 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2AFCB20040;
	Mon, 16 Mar 2026 18:04:20 +0000 (GMT)
Received: from b46lp25.lnxne.boe (unknown [9.87.84.240])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 16 Mar 2026 18:04:20 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, imbrenda@linux.ibm.com,
        borntraeger@linux.ibm.com, akrowiak@linux.ibm.com
Subject: [RFC 00/10] KVM: s390: spring cleanup
Date: Mon, 16 Mar 2026 16:23:47 +0000
Message-ID: <20260316180310.17765-1-frankja@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 5inE6wV-pxbSEfcCnrLg3xRWOtU1FWvS
X-Proofpoint-GUID: 5inE6wV-pxbSEfcCnrLg3xRWOtU1FWvS
X-Authority-Analysis: v=2.4 cv=KYnfcAYD c=1 sm=1 tr=0 ts=69b84629 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=DfnaV4d0-cqvsRRct5oA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDEzOSBTYWx0ZWRfX5Xk20yWuMAhr
 BlGL0QIh2R7y0MFc2hQA9vafh16t7a82ynYDbWJrdvPg0QSRNXxVnIhgXXNvpvIkpIUFK/5hUI/
 RidL/9ziU76H0HofgyUIB11t8k5Zlrq744KUW99Wromn7PKmoQXdu91Eif6mqHhQgoidyRtHLcC
 0HCqu0jMJLI+rKdfaI6OoMhKzeFH1Wdhcy/MiVnNqw4EqPuduAvjtHvBvLW4sVVI3gdZwcec3z/
 Bap/6hvoEZS90u4nNXTr5vD4mt8CEeEeHQk5e3xZaz8g4r4CyAc0Pg0oinby/jmxbE9FOxD0Blj
 4lnxnPDU5R+BMwojoPBqRprRwHwCn7ZnsURSu1B8ePCyxH0YjfP+5XGDWhKY8/PZz9ZSDNS/cbB
 tstCKjC5K5nyhNB+i+5fpdIIk5NtaQt4nssJoF9RGg2zI9GrtOVThx2PM/XB0WUpIlNBMBs/f3i
 zo4FJtkS3mFSuK2SrtA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_04,2026-03-16_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 spamscore=0 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603160139

When looking into the new gmap code I also had a look into our
handling of addresses as a whole. I've found that we have a lot of
unsigned long variables which could be gpa_t or gva_t. There's code
where we could use provided functions for calculations like gfn
shifting and in general we have a lot of magic constants left which
could be defined constants. Some of these contants are already in our
code base anyway...

This series tries to clean up some of these problems. 
I have more commits that also introduce new types for real and logical
addresses but these have to wait until I see a real benefit.

Janosch Frank (10):
  KVM: s390: diag258: Pass absolute address to kvm_is_gpa_in_memslot()
  KVM: s390: Consolidate lpswe variants
  KVM: s390: Convert shifts to gpa_to_gfn()
  KVM: s390: kvm_s390_real_to_abs() should return gpa_t
  KVM: s390: vsie: Cleanup and fixup of crycb handling
  KVM: s390: Rework lowcore access functions
  KVM: s390: Use gpa_t and gva_t in gaccess files
  KVM: s390: Use gpa_t in priv.c
  KVM: s390: Use gpa_t in pv.c
  KVM: s390: Cleanup kvm_s390_store_status_unloaded

 arch/s390/include/asm/kvm_host.h |  6 +++
 arch/s390/kvm/diag.c             |  2 +-
 arch/s390/kvm/gaccess.c          | 20 ++++-----
 arch/s390/kvm/gaccess.h          | 49 ++++++++++++++-------
 arch/s390/kvm/interrupt.c        |  4 +-
 arch/s390/kvm/kvm-s390.c         | 24 +++++++----
 arch/s390/kvm/kvm-s390.h         | 12 +++---
 arch/s390/kvm/priv.c             | 73 +++++++++++++++-----------------
 arch/s390/kvm/pv.c               | 12 +++---
 arch/s390/kvm/vsie.c             | 50 +++++++++++-----------
 10 files changed, 138 insertions(+), 114 deletions(-)

-- 
2.51.0

