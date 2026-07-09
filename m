Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6EB3B8BA4
	for <linux-s390@vger.kernel.org>; Thu,  9 Jul 2026 19:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783626958; cv=none; b=QL64reS97XvNwUVIj+YwBD2IlPXLnz8VYERvNZv2EDprAyrSW6Gt8zFEfaCynu+63plfjMUWX52SE84ZiXeVIi+8SsEOL/+loshHqqfWZ+f+flp7ABhLhgyQSdO9+GoyhkMI31D3Ce9GpXfjhEAVoHZcM9UMtrvPN2YIR3mPq+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783626958; c=relaxed/simple;
	bh=09cocIM7s853BZrSCE7icz+faDUaUOxkViFKhnvsIHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EYX55fREbD7Cuyh3IBW0ytgorMlFxmUHah+ZfPmnhikdVtkZcV6WopMGbImxz56nqINDzP2jeICWJ0jx+qUuSDyVn1CsnW8u+sMWCH9QnzAMdKdgzYBlRvhqEO/LtwLq3w4jZdYtPQiEarBHGuodO6+fSHrmaSTkO3wRTnf5iHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dsNdgM+J; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dsNdgM+J"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 669HmVvS2623601
	for <linux-s390@vger.kernel.org>; Thu, 9 Jul 2026 19:55:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=yjz6og6CmaPZojXhNA6B5L6mDSsuxtgh42MwWsHwj
	SM=; b=dsNdgM+JSiJFZCjAeX7r2VbSCa04dJlRWzjQ4IJjFAUPgcLIDg2bHSdaV
	ta3d+vZPwRmDCQJoDLh8UbxpEMcmsjiKp948LVMyEMSMVMnji3EaHRCbWs5xStdL
	dZK+HBZv83Xs+uYfeFrpg7nLie2H9S5dH1fCcXJi4SxL2OL9EJkCPp2r70OXUHi/
	GwBhFkU47+d0IELfsIXmWfsEjfuNArSn8yRvWDelI1/Abi2jVB2qks8qRK5Vy7ZK
	sfDMMEiITOoGxwrUNO/YL8tID2pnWkpkx9WGBocyQoyjuy2HOPFhHXtpA3bYsxbV
	tKI68H2ZkAboohSrcZWwtL/EKt7CQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sw53exx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 09 Jul 2026 19:55:56 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 669Jnp8X010472
	for <linux-s390@vger.kernel.org>; Thu, 9 Jul 2026 19:55:55 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7e0hpnbn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 09 Jul 2026 19:55:55 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 669Jtosb39911830
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 Jul 2026 19:55:51 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DD8322004D;
	Thu,  9 Jul 2026 19:55:50 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C148F20040;
	Thu,  9 Jul 2026 19:55:50 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with SMTP;
	Thu,  9 Jul 2026 19:55:50 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55390)
	id ACA141615EF; Thu, 09 Jul 2026 21:55:50 +0200 (CEST)
From: Sven Schnelle <svens@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>, borntraeger@linux.ibm.com,
        linux-s390@vger.kernel.org
Subject: [PATCH 0/2] s390: Remove PIF_GUEST_FAULT and add PER trap flag
Date: Thu,  9 Jul 2026 21:54:58 +0200
Message-ID: <20260709195500.1241833-1-svens@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: AeELpqfR8yPevHq0jRZjW3yeoCeWCkHm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDE5NyBTYWx0ZWRfXxQxk5tMgrwIo
 FLAp73kkXeUu5Vnd94QhH5YTj2cI3NC8vXRu0tjCn9JvD7N4riq2+P7adoKd0iZ9Gea/KbieS/7
 x5uddoc+IUwbfmUJP5jgSu9bnDYxLSXOvLhd6e+GvgWsoD+VfTE1KwWHFGMdbdU2wFaDOM9VBSx
 qkyuxtovq0IEL8MzrVQ7ANOpmMVkBU7HuIIlDXC4knqnPquMaaJYXjYW1p4eqYDUtQoyPLA0r9C
 bpBryxNYDRL2gILR1Y4VscvkommZR2qRIN1nNux/liwrocPn3qHr7cTd88xF0mkbl51m19rwk8B
 K7rP6sbD12edURYyGaAPnP0kPy72OstxZhb+m22ZTy0S8468bGKAf8yYVnDoB9yDU6wIefwHLTr
 vwbAZaZVb/BWAQpTOH8930fu/IiVlnei9mxl0q1VAc+wT6sDMOSZaiOYqMc2EPbErKiuHsgNXkS
 HFcn49VXNaumJayXzHQ==
X-Proofpoint-ORIG-GUID: AeELpqfR8yPevHq0jRZjW3yeoCeWCkHm
X-Authority-Analysis: v=2.4 cv=FqQ1OWrq c=1 sm=1 tr=0 ts=6a4ffccc cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=3Hg_7TKRh5T29VDKnC4A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDE5NyBTYWx0ZWRfX0mMy2L2zcYiZ
 r1Dhufqn52kaip23N+MAVNN+hK3EU/JZiS3i0e80/OTEoN3J3pDpd2OKp2RfiPqY98zbRRFPW7C
 jtrvGsHAMK+b5gFWqGhTOQKubjJXSXY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_04,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090197

While looking at the syscall code I noticed that entry.S still sets
PIF_GUEST_FAULT in ptregs even though it's only used in __do_pgm_check().
Remove that and pass it directly to __do_pgm_check(). Heiko suggested
to also add a define for the per trap flag in system_call().

Sven Schnelle (2):
  s390/traps: Remove PIF_GUEST_FAULT
  s390/syscalls: Use define instead of '1' to indicate PER trap

 arch/s390/include/asm/ptrace.h |  4 +---
 arch/s390/kernel/entry.S       |  9 +++++----
 arch/s390/kernel/entry.h       | 10 ++++++++--
 arch/s390/kernel/syscall.c     |  4 ++--
 arch/s390/kernel/traps.c       |  4 ++--
 5 files changed, 18 insertions(+), 13 deletions(-)

--
2.53.0
