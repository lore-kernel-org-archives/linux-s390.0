Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B764515746E;
	Fri,  7 Mar 2025 23:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741389246; cv=none; b=f2y2bR3KLObNH3XN5JiOfg+yghSfuuYRmJMCzl3Qc80xWDj3Jh4mqZ8GNnYUEc7sOJquWWJITB1BcRVrkWnwJCptnywb6T/gNVvQbPJMfQXOjLNCg6B6bPCCSabQaEMH66rEEjS0Y5izohaSd+2FsXhnKVKVC9ZpdVCp5Z0IBx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741389246; c=relaxed/simple;
	bh=4C9O5IfLxoqALAVxpI1tRWW7zTFY8vqbF0bNmC70UVw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BUAAZvjRJn68wiL+Fj7K7fu7YYxtxGHTerrqpGDPMW3B5EZ83g8Zn7ZvjHTo7Da6/M6qnCYuqqHwB/SzNw85m/kRDeUEsbCCh0x2Jl26dRZxgKUQ+aOWqWSa0X3NbcB+8IMaqtE8wqq5ZitfObW+1D/i9EEyvSMCriCZm0v352E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BFjrU/uC; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BFjrU/uC"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 527KqTPL023264;
	Fri, 7 Mar 2025 23:14:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=9fzZUkk8QdDhoK9eiYVYMl630UKE
	8hRxbL04c2VHNbQ=; b=BFjrU/uCLB9lApiTyTzgXstIXP9YrH0OFSv4vAVBBhUy
	+2AJppWxohrefaiSNdY+Caz8sloRL2phKIu91SHPK67MivxoH5cmM62qCRAMYU1D
	mzL5+wZqCrBSPTJs7z+eRwZUrWUHwE8Ag57LFquXq3mQylVmzRxsIJDSf7cXV5JG
	EuaxgptJxV6eK+KYs+DLROwxZpJNXhervICmLpxrvzPeyfEYRc2h0vaUt+EilvSE
	ewdLWD0znK9ex2u8zR4e9d9IdIv1g2lodTiwpePL0TtsLj21GsYK0DdxJhxeUzkH
	LtBRiy/ipAGh6r5hT9a+e1tRToSW/nrea7VI/5CDfw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4588768eev-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Mar 2025 23:14:02 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 527N3pSV009038;
	Fri, 7 Mar 2025 23:14:01 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 454cy01mws-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Mar 2025 23:14:01 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 527NDv7g52953400
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Mar 2025 23:13:58 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DEC0A2004D;
	Fri,  7 Mar 2025 23:13:57 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 641C520043;
	Fri,  7 Mar 2025 23:13:57 +0000 (GMT)
Received: from localhost (unknown [9.179.11.245])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  7 Mar 2025 23:13:57 +0000 (GMT)
Date: Sat, 8 Mar 2025 00:13:55 +0100
From: Vasily Gorbik <gor@linux.ibm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Shuah Khan <skhan@linuxfoundation.org>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: [GIT PULL] s390 updates for 6.14-rc6
Message-ID: <your-ad-here.call-01741389235-ext-8883@work.hours>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 1Uh7G7H5ec4mEeRFGTGArVS_oHZuerkE
X-Proofpoint-GUID: 1Uh7G7H5ec4mEeRFGTGArVS_oHZuerkE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-07_08,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 mlxlogscore=782 priorityscore=1501 suspectscore=0 malwarescore=0
 adultscore=0 impostorscore=0 phishscore=0 mlxscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503070173

Hello Linus,

please pull s390 fixes for 6.14-rc6. There is also a vDSO selftest fix
for s390, acked by Shuah Khan.

Thank you,
Vasily

The following changes since commit c3a589fd9fcbf295a7402a4b188dc9277d505f4f:

  s390/boot: Fix ESSA detection (2025-02-18 18:49:24 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.14-6

for you to fetch changes up to b4a1dec11793936ffe1a9fb811724532ff3b1174:

  s390/ftrace: Fix return address recovery of traced function (2025-03-04 17:15:19 +0100)

----------------------------------------------------------------
s390 updates for 6.14-rc6

- Fix return address recovery of traced function in ftrace to ensure
  reliable stack unwinding

- Fix compiler warnings and runtime crashes of vDSO selftests on s390 by
  introducing a dedicated GNU hash bucket pointer with correct 32-bit
  entry size

- Fix test_monitor_call() inline asm, which misses CC clobber, by
  switching to an instruction that doesn't modify CC

----------------------------------------------------------------
Heiko Carstens (1):
      s390/traps: Fix test_monitor_call() inline assembly

Sumanth Korikkar (1):
      s390/ftrace: Fix return address recovery of traced function

Thomas Weißschuh (1):
      selftests/vDSO: Fix GNU hash table entry size for s390x

 arch/s390/kernel/ftrace.c                 |  3 ++-
 arch/s390/kernel/traps.c                  |  6 +++---
 tools/testing/selftests/vDSO/parse_vdso.c | 10 +++++-----
 3 files changed, 10 insertions(+), 9 deletions(-)
