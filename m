Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D612D2ECE91
	for <linux-s390@vger.kernel.org>; Thu, 25 Jun 2026 13:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782393401; cv=none; b=mMhcRI5XJDpclzyIX3qIv80uzG6pJVDjeXUVC7ZArOB0fdoo6Ufgj/muNAQh/7s62hv2vr0ltrqzv/62Ywht+9sTJXkp4BtXHJC4XhdySnEZwzXU+yefdG3RNpadsOvGo0P3HMiywfWIImrx29zRcElO8cw95PK2OQDmHTk/DAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782393401; c=relaxed/simple;
	bh=42i3vL16POVViUft2nLJ+75a9SohgaMj2xwyLCuKw54=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lCXAVyy+iX/iF62QcUgCjpZT8hKxh9PiMP7HamNa1/Lq9X/PuZe1Gk3uoZAKreAA+s4siS99a5zBqTAvwbtOKVZUzr7vNeJr72GTx55/zEcVmvopCrJI1p4pUlOWoAXXoLHiuN2dqQ8USt3WhvGmGHEpGP2amoSgVVgRQa7dit4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AEchJ0xq; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AEchJ0xq"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65P3mg8a2889642;
	Thu, 25 Jun 2026 13:16:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=L3B3BzU3QwrwxN1mrUcbwN8DK+cni4tZJsvm5Zcyt
	UY=; b=AEchJ0xqRSJRWAo/O5ZpXtreT6mlPbFtKwduC492SB3IXUlt55qCpwDBC
	S+mf3EmsAhg1AyIOJMQB96+IqCdwnSXII2m93le8MsUyLliyREMKaPlLmEn22GcM
	Fb/s7TIvGl9uR8Kc6t7FKYQbaBEpsDgekjQacmtcraAlLs9H1SzF3mlpJwMJu4lg
	dduQ8b69q/tM8bHggLrdRDDcollZp3PXQcFigeDYxT8AF+NdFDJgdmbGZUkG/Wl2
	rliqqbQqs9Pw/xywpFBV/t2Up+fwnptFEWx3rcVrefA5lC1tfutVM8MkpGQWcbd1
	uE98uEDYCYcDzW2rtZ6dD/hrP5kKQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjgt1h08-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jun 2026 13:16:32 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65PD4f9b004117;
	Thu, 25 Jun 2026 13:16:31 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex7vyx056-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jun 2026 13:16:31 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65PDGSXU41222584
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Jun 2026 13:16:28 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 240122004B;
	Thu, 25 Jun 2026 13:16:28 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ED3E520049;
	Thu, 25 Jun 2026 13:16:27 +0000 (GMT)
Received: from t35lp84.lnxne.boe (unknown [9.87.84.240])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 25 Jun 2026 13:16:27 +0000 (GMT)
From: Ciunas Bennett <ciunas@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: borntraeger@linux.ibm.com, frankja@linux.ibm.com, imbrenda@linux.ibm.com,
        david@kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, svens@linux.ibm.com,
        Ciunas Bennett <ciunas@linux.ibm.com>
Subject: [PATCH v2 0/2] Improve DIAG 9c observability
Date: Thu, 25 Jun 2026 15:16:13 +0200
Message-ID: <20260625131615.262367-1-ciunas@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDExMCBTYWx0ZWRfX9yfoG2/OqXva
 UoTV4OU5TsEQ96px9dGj+F7PzyOXuKr2Dt1ehyR2oTw8M77y7CWgcpr/jzlKiSAfQxlIHK0CDNd
 7gCLMht4BXJ6eo4Gp2HoAcULxi1yeLp9wlAYGYhUkCgQxBxW1jdYhrFSkzlcWhGerrjAHOFeWHR
 S6k/F2V6TuCn/EAMz3OjMKEd/JqYkTcSOBTz5iItPkoGVMds9n0h/Z1X1jlSMvE9plXjFJEBhT+
 eDJYgjznuL35A8+ULbt+n9j8pd9heHNNk16rGwSYTCMgXsSczAh0MnzrScZXVsyIsBlUm0hSw7H
 V0em9wjvfFUQ722qrAduI4t5hJynzh0sCqF5vMm9vQIVhCyrDsTUySoX35w7oVWrnNNKf0HsJk0
 KiYSti1tJuGiTRpHoSF5xPvPoYrn1gQ9JIPAulspkdY5gIJsPNP10YwPt6NDsEnuc8sdqfPpbLJ
 tESRw6hRCdffrZp7oLA==
X-Proofpoint-GUID: 2sw1DvJFrg_O3Awx-6Lkv5FJmrt1BdcG
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDExMCBTYWx0ZWRfX/m7MYmcauMKv
 sXImDkvH+uBTeR+JZXUCjEaXKga9co4xh/jc90HKwh0+k7gIBrILkwRnhrDTeelpox1gs8L3nk8
 ioB5GiQJp1rLaFStXYzPtqr8jxUHpts=
X-Authority-Analysis: v=2.4 cv=I/lVgtgg c=1 sm=1 tr=0 ts=6a3d2a30 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=e05qxJdhFS1Mp7vzFoYA:9
X-Proofpoint-ORIG-GUID: 2sw1DvJFrg_O3Awx-6Lkv5FJmrt1BdcG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 phishscore=0 clxscore=1011 priorityscore=1501
 adultscore=0 impostorscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606250110

This series enhances observability for DIAG 9c directed yield operations
in s390 KVM by refactoring the handler and adding comprehensive tracing
support.

The first patch refactors __diag_time_slice_end_directed() to use a
single exit point with a result string variable. This consolidates the
control flow and eliminates code duplication in logging statements,
making the function more maintainable.

The second patch builds on this refactoring by adding a new tracepoint
kvm_s390_diag_9c that captures detailed information about directed yield
operations, including source/target VCPU IDs, physical CPU numbers, and
operation results. This enables better analysis of VCPU scheduling
behaviour and helps diagnose performance issues in virtualised s390
environments.

Together, these changes provide kernel developers and system
administrators with better tools to understand and debug VCPU scheduling
patterns related to directed yields.

---
Changes in v2:
 - Add system maintainers to review mail
---

Ciunas Bennett (2):
  s390/kvm: Refactor __diag_time_slice_end_directed for single exit
    point
  s390/kvm: Add tracepoint for DIAG 9c directed yield operations

 arch/s390/kvm/diag.c  | 19 +++++++++++--------
 arch/s390/kvm/trace.h | 30 ++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+), 8 deletions(-)

base-commit: 184fc1890bcc8242f00fee660d2651290f1461a2
-- 
2.54.0

