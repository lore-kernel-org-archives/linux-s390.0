Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642DC3ACEFF;
	Wed, 25 Feb 2026 14:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772031114; cv=none; b=h7EDWjHMzV1Y8SsoptLD6Uok4g7Jq4nI89iWKymQ7wKttr3YuP4AmMyerVKwlJLwuVVO8QdGEzdM767AG7FzDlxhUHBYig1JBJYvNnwQVdTnxMF4W/alG8J2rFtjyJ6KGNbogYOvRfVUp+pREbzMKYFxzzj61rSiruU8Cg9ivQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772031114; c=relaxed/simple;
	bh=lxAa5dMpm9Qp1NpBWkQX5I6GVPDM3giQk7OWVzi21Ms=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RMETFiS0p1ovPQ0Jjqev8D4OGqwQQ/SdbU+Ey+28KAKQGt07XJLBnpCXQnFss2IBhW+54JYd+XRx1bFY9+IpQYsKiWyeYNnqaA/1754sUEhupYAUEAJyXW7J8Byd0W5SOBGNeSnoA84BYNoLoxBGBRb5uGUnpNWMk9kllatQeRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fdUv01u4; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fdUv01u4"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61PDoW9S2750096;
	Wed, 25 Feb 2026 14:51:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=FHHpPlHorju8sfsLyYFutddVFrhOIVeNrAZ2brQMt
	b8=; b=fdUv01u4EwXm1j78kYdTwrsNJAm/qO3kCcDYpGaqROHAvPKlz9ddVT8Vt
	1R1J0xUxJyWDfCrPZxAWGbOqVd9rXm15/klVzW/GnDsawuDPyaF47U2KdARYo9hr
	skJQ6QBXazFd0pSeRYcz2o8Xo9lAKMhhymMHcBO8i+dzy2sye+P1CIPaLJWo3wFa
	+WW0iy5a1QWA26yBx1NsLIdWwIdxX0IW51mdBF3ZDlLjfjHBMERNMHB6/33AJYrT
	QJWjJcTCSzF1rghlfryu6szSOvszx5blraVAKf4nCKpOInh8Z7Cepj3LKiYKnshj
	2Dv7wnbznNLrObBZzLX3emPodGODg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cf4720s0s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Feb 2026 14:51:50 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61PE7sBs027776;
	Wed, 25 Feb 2026 14:51:50 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cfsr1wf4d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Feb 2026 14:51:50 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61PEpkwI38535598
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Feb 2026 14:51:46 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 73E5F20049;
	Wed, 25 Feb 2026 14:51:46 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 55E6520040;
	Wed, 25 Feb 2026 14:51:46 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 25 Feb 2026 14:51:46 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Frederic Weisbecker <frederic@kernel.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [RFC PATCH 0/3] s390: Idle time accounting improvements
Date: Wed, 25 Feb 2026 15:51:43 +0100
Message-ID: <20260225145146.1031705-1-hca@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: sR4oVeT-7sMrOJxqW3gUx7CiOEmEQIwa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI1MDE0MCBTYWx0ZWRfX7ngapQ66jP8r
 IbXN9T2I1YK4LoFa6N5Vypu1+O8nj8Y86dCvLFzKPxLXQMV7hVLHUSioP1OWoPH0KwvXjSug4yu
 9qySFaVJA2J0PzQjVK9pMZd43eTRPebSSNIufvOZJaCYD4tDKGZYxrCOOTnh2F4252QyQF0YCNC
 dF2mqKZ/DATjsSWPTVBoXb7FMER55pivwpIl6xier3GnrwZf3va+P5jWZ4K8R1b152Ud3K8VFDO
 TdjEnGhDzgSoavo9PpXmXO5RzTrcx795WXlCqPdW3Iv/dLXoqynkfgiPZ+3XC9DTTw6nl4t7b3w
 M4Wttt8yyy4I9OOl1Vas0pyrQcuiZlmBh8SuwZ8jvghEemvnoESYMmTGdFVUnKdJc589nkenzBB
 r4A9UaFsDcynX7F6KFoVqqSw4jNeTrhiaWx3xQHNUGMv4StokCQ6EJbuI8e/Z0g3IlgCjLo69NP
 VPtb5qCgh7R8/myh2Tw==
X-Authority-Analysis: v=2.4 cv=R7wO2NRX c=1 sm=1 tr=0 ts=699f0c87 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8 a=60VfEbk_-fc-4h8Sot0A:9
X-Proofpoint-GUID: sR4oVeT-7sMrOJxqW3gUx7CiOEmEQIwa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_01,2026-02-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602250140

This series is on top of Frederic Weisbecker's idle cputime accounting
refactor series.

The first patch is a fix and should be merged into the corresponding patch of
the series.

The second patch is supposed to improve s390 idle time accounting, and bring
it back to the state it is was before arch_cpu_idle_time() was removed [2].

In result all cpu time accounting is done by the s390 architecture backend
again, instead of having a mix of architecure specific and common code
accounting (common code: idle, s390 architecture: everything else).

The code doesn't look too nice, and, as usual, might contain bugs. Therefore
this is an RFC. Maybe the outcome is also to drop this, and stay with
Frederic's code as s390 backend.

Thanks,
Heiko

[1] https://lore.kernel.org/all/20260206142245.58987-1-frederic@kernel.org/
[2] commit be76ea614460 ("s390/idle: remove arch_cpu_idle_time() and corresponding code")

Heiko Carstens (3):
  fixup! s390/time: Prepare to stop elapsing in dynticks-idle
  s390/idle: Provide arch specific kcpustat_field_idle()/kcpustat_field_iowait()
  s390/idle: Remove idle time and count sysfs files

 arch/s390/include/asm/idle.h      |  11 ++--
 arch/s390/include/asm/lowcore.h   |   9 +--
 arch/s390/include/asm/timex.h     |  20 +-----
 arch/s390/include/asm/tod_types.h |  30 +++++++++
 arch/s390/kernel/asm-offsets.c    |   5 ++
 arch/s390/kernel/entry.S          |   7 +-
 arch/s390/kernel/idle.c           | 105 +++++++++++++++++++++---------
 arch/s390/kernel/irq.c            |   2 +-
 arch/s390/kernel/setup.c          |   1 +
 arch/s390/kernel/smp.c            |  33 +---------
 arch/s390/kernel/vtime.c          |  37 -----------
 drivers/s390/cio/qdio_main.c      |   2 +-
 drivers/s390/cio/qdio_thinint.c   |   2 +-
 include/linux/kernel_stat.h       |  27 ++++++++
 include/linux/vtime.h             |   6 ++
 kernel/sched/cputime.c            |   4 +-
 16 files changed, 166 insertions(+), 135 deletions(-)
 create mode 100644 arch/s390/include/asm/tod_types.h

-- 
2.51.0

