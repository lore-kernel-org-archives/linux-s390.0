Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6207E2DEA86;
	Wed, 13 May 2026 14:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778680909; cv=none; b=RpgCy0qRx8spmjDI03Q36xlk6YrENotyHcMSYWQVW6b53OdOgLdW+YuiReIlxJ8PhczsY8WzJeHtKKZ3gUDKKJyTZJzv5SCtE+KJMWsiyqv3pscmdZ9qb9R/eD8rHUkH/d4LRylatTzrR6BrshmtZIZU+hwPUDxGT9f60Sec2EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778680909; c=relaxed/simple;
	bh=kDmC16sFa2Np2Su6ebMwDhXC7E/lLjxNg2NTwKLPu/g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Sinqj1gigbgo8AtTQS9JdCimXzrrSmkstCFjZJu22+B/Bz5NeinsB2rre6vJfaw/o7cA6rPtekXqA1JB2EIOuuj8wmtVJDb3QKVcu4p7AAsKAHExhdEwNvnJ5xxYa9MILg+xE4xT8Bnrl4dGBqSqYAfsQZCNQlA2vtY6BsJPi7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eQZuE8Po; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eQZuE8Po"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64D1U8l12611676;
	Wed, 13 May 2026 14:01:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=Dpb15MXbHpf6sMenPr2WYyo9TcFu/0kb9Gd3epOqN
	LI=; b=eQZuE8PowRc/e9qmtzxTThsw7aLdBADPlY8xfcA1XajIEsypJttdTyaY0
	XPv3RllSHSWe1cnApgEoZJv/2e1c1rG4QrKIbDYWDvs1yH+obCbBkb/hSX33HuD5
	OJuXXVeAF/UJP5xfTXZusLfWXofCVMyAPfDIBv5IvUMeBazIfVthTaDPpz3SAp/S
	SoUh5AhW/YB//w+reMWCuU5OjKyAF4/Tok/AUGl19VPf9YYsbX96SzvkMMUWPBrI
	OqFvttabftKlzCd/Mx5tbSASq8yGN9a3OLCV0n8Xh9CRqqaobdujQucmpw10wsh5
	wVkGRMvb5ISVW05nwa7Pewr/ZxVjw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e3nve01n5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 May 2026 14:01:34 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64DDsRKJ013062;
	Wed, 13 May 2026 14:01:33 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e3nfgg2jm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 May 2026 14:01:33 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64DE1UMG47710596
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 May 2026 14:01:30 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2C47F20043;
	Wed, 13 May 2026 14:01:30 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 054C820040;
	Wed, 13 May 2026 14:01:30 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 13 May 2026 14:01:29 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@kernel.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 0/4] s390: Idle time accounting improvements
Date: Wed, 13 May 2026 16:01:25 +0200
Message-ID: <20260513140129.4100822-1-hca@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Y/XIdBeN c=1 sm=1 tr=0 ts=6a04843e cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=rdpmcdVeJmqN62aiCTwA:9
X-Proofpoint-GUID: rfmJBT7PW_G1WH43Ww-3JiHLAY3geKxx
X-Proofpoint-ORIG-GUID: rfmJBT7PW_G1WH43Ww-3JiHLAY3geKxx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDE0MCBTYWx0ZWRfXwwCi9qT9+WS9
 V7txnJYoVR14Pua8tht16nThpnyiIySLK/jldZuFWU3inZdJY5Flfvn3UsQlHn+EbzBNNqPIrjv
 9bx+WTqWWXGSJHKk/cQcm5/noRm5WYBsCktpRTP8ATeJAWh01Rbx5BT3bNuXUGMVmG+NSBmhmdU
 xxYVirrsp0lN4dmNIeAFUfuf7rU7cef7N/HQlykYCTqxPVVTUwbt8+GMeXWLL5xDk2BKKxm43Dm
 jH3KgX6xAsSCBiqzfDcJtrC9+PsyXxgOZo+c24WDKHT+41PVnTm9YbF68jmcYKWUCOoNUKoceVB
 RPoy+UygLAdHTUGmQPOTVDXrRB1zqqdEtsVd+4/kSPF0ZTZJYl+cJkU1Cs1gq9L1llyq8qe+9w8
 YMu9bNd0ifsrLFwubMtLnNUfsMwmvQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_01,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 spamscore=0 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605130140

This series is on top of Frederic Weisbecker's idle cpu time accounting
refactor series [1][2].

This is supposed to improve s390 idle time accounting, and brings it
back to the state it was before arch_cpu_idle_time() was removed from
s390 [3].

In result all cpu time accounting is done by the s390 architecture backend
again, instead of having a mix of architecure specific and common code
accounting (common code: idle, s390 architecture: everything else).

Changes since RFC [4]:

- Split into more patches

- Fix various build errors for !CONFIG_NO_HZ_COMMON

- Get rid of private seqcount implementation and access seqcount from
  kernel_cpustat directly from assembler code, as suggested by Frederic
  Weisbecker

[1] https://lore.kernel.org/all/20260508131647.43868-1-frederic@kernel.org/
[2] git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git timers/core-v4
[3] commit be76ea614460 ("s390/idle: remove arch_cpu_idle_time() and corresponding code")
[4] https://lore.kernel.org/all/20260225145146.1031705-1-hca@linux.ibm.com/

Heiko Carstens (4):
  s390/timex: Move union tod_clock type to separate header
  s390/irq/idle: Use stcke instead of stckf for time stamps
  s390/idle: Provide arch specific kcpustat_field_idle()/kcpustat_field_iowait()
  s390/idle: Remove idle time and count sysfs files

 arch/s390/include/asm/idle.h      |  14 ++--
 arch/s390/include/asm/lowcore.h   |   4 +-
 arch/s390/include/asm/timex.h     |  20 +----
 arch/s390/include/asm/tod_types.h |  30 +++++++
 arch/s390/include/asm/vtime.h     |   4 +-
 arch/s390/kernel/asm-offsets.c    |   7 ++
 arch/s390/kernel/entry.S          |  14 +++-
 arch/s390/kernel/idle.c           | 129 +++++++++++++++++++++++-------
 arch/s390/kernel/irq.c            |   7 +-
 arch/s390/kernel/smp.c            |  33 +-------
 arch/s390/kernel/vtime.c          |  55 +------------
 drivers/s390/cio/qdio_main.c      |   2 +-
 drivers/s390/cio/qdio_thinint.c   |   2 +-
 include/linux/kernel_stat.h       |  27 +++++++
 include/linux/vtime.h             |   6 ++
 kernel/sched/cputime.c            |   4 +-
 16 files changed, 203 insertions(+), 155 deletions(-)
 create mode 100644 arch/s390/include/asm/tod_types.h

base-commit: e64ba052ce04e363ff76d3cb8bedc5f812188acb
-- 
2.51.0

