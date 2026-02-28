Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B609B44DB72;
	Sat, 28 Feb 2026 15:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772291324; cv=none; b=X89Gb0P0bJlLiQ+pIR94sm19DaErqYlaX8uJvXuBk4kTRs7+SEcZgBwJHjRfAI1f4B85QM+gv4O+iF+T4n9Fjww8vNMO+f+ivn1BYaH95fre2+5AmsPqSOKxkYCN+/U0cXLqL730ypm9BCh8gcE2iu3cLS8enfWxTE7LrnplBFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772291324; c=relaxed/simple;
	bh=XooppfVXskym/51Pk8nyGODgkk6GYIXIATX+0fCKc4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tP2nx7N8hlWs437cqPPTMQ/DDDpQ8TpPpYZB8BSTrWnnx/+sLjnZr9+DnPt/bEGiVTrRSr4Ds+Bwo+cGpl/Q+meLLlzGbHEg9Yk7WqEmfKedbCUm0PCNLeS8P7+LiYLuRM2S+OEIiIx+5g73g7kThGUgBWC5GQHrrF357bxXW1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ANdfwQZc; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ANdfwQZc"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61SF07xO2787553;
	Sat, 28 Feb 2026 15:08:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:message-id:mime-version:subject:to; s=
	pp1; bh=5DE0vZKpJ8DF8ix/JIfrJO83kXaIYwsLZinTpANtswI=; b=ANdfwQZc
	tQ7efYAwA7Wj7DhArvVz62pZA6GJBfPAoCLcUqZ65hfaI0s3O8Qn3TJRICU4hL2X
	Ssdih3VgpuuFv9a0I2C+J5DBya8HXHICsEqpCb6Do0bmGEdcU1vh28L0XS4zJ0pt
	EUF9MkacrEDN4AaX7MhKcoSXYqt2QT9DdLa5DCkuS/rLLQ/RBy3B/g83nAgoQXws
	vnsG4gin6b4Y2141gm3wEDyf9ddo6tQSGZPRhLNAGZfOHIMAwIuSmGDhfwtlRz0o
	j4Nmod0TJ/95kE+CHpSJb3k18BnVFAOplfy0mhJ0Vgp3iq7joccsC/RnmFCczT4Z
	BZ8xN42CkhhPvw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cksjd15ft-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 28 Feb 2026 15:08:41 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61SEVOS7013411;
	Sat, 28 Feb 2026 15:08:40 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cfqdyq43y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 28 Feb 2026 15:08:40 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61SF8a8H40632772
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 28 Feb 2026 15:08:36 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 703A02004B;
	Sat, 28 Feb 2026 15:08:36 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0D2F220040;
	Sat, 28 Feb 2026 15:08:36 +0000 (GMT)
Received: from localhost (unknown [9.111.38.228])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sat, 28 Feb 2026 15:08:35 +0000 (GMT)
Date: Sat, 28 Feb 2026 16:08:34 +0100
From: Vasily Gorbik <gor@linux.ibm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [GIT PULL] s390 updates for 7.0-rc2
Message-ID: <your-ad-here.call-01772291314-ext-5802@work.hours>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=M9BA6iws c=1 sm=1 tr=0 ts=69a304f9 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=T2WKjkLyC72pc3uQUdAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: uelG8jQKUK5lZS0ODe3AW_sJeSWU0B0S
X-Proofpoint-GUID: uelG8jQKUK5lZS0ODe3AW_sJeSWU0B0S
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI4MDEzOSBTYWx0ZWRfX3lPX6WBwE0NQ
 VMbMCtHIXpf9FF4i3MQhH5P/G12dxYr4D1yj4AV5U6OH98EDi+g4gtYPLK39JJArQgqPVeGb9Ma
 SrDAgcF+MtF2JVvwNex7VGHQBN8wXsQlKG88nKGHQ3YbQhhvKBThkqtiit3RvFk3twmuQNFwudR
 ODQTEQtvOeDHs2uc4jPCMyN73Dz5dQ++XP2Kp/ND8Ryqrmqrh+FHzdwGalcoqxnXfdPZpdyVnSV
 4RAoGn+6Fujx/XpRo/unIWNgj7Sf2ADn6O+qyrElDDTG6xPqaW/pxtYH/VBaPdv7og1yYoZUT3+
 qzam/mzhJA1rfctnktcS2rayN4dFKCA6/DSsg+PzMrbXqNUj83HNq8UFsD8nNGI00AODBbabf/C
 /YVRrBz3b4B/9Cbe0KREKiG9TDUfv1h98NV+vnfvC9aXs+nDt3o9OZLVFDS0LgG8U+pMcYsvlj/
 aOkG4RA5in2KsapjIvQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-28_05,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602280139

Hello Linus,

please pull s390 fixes for 7.0-rc2.

Thank you,
Vasily

The following changes since commit 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f:

  Linux 7.0-rc1 (2026-02-22 13:18:59 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-7.0-3

for you to fetch changes up to d879ac6756b662a085a743e76023c768c3241579:

  s390/pfault: Fix virtual vs physical address confusion (2026-02-25 17:00:25 +0100)

----------------------------------------------------------------
s390 updates for 7.0-rc2

- Fix guest pfault init to pass a physical address to DIAG 0x258,
  restoring pfault interrupts and avoiding vCPU stalls during host page-in

- Fix kexec/kdump hangs with stack protector by marking
  s390_reset_system() __no_stack_protector; set_prefix(0) switches
  lowcore and the canary no longer matches

- Fix idle/vtime cputime accounting (idle-exit ordering, vtimer
  double-forwarding) and small cleanups

----------------------------------------------------------------
Alexander Gordeev (1):
      s390/pfault: Fix virtual vs physical address confusion

Heiko Carstens (9):
      s390/idle: Fix cpu idle exit cpu time accounting
      s390/vtime: Fix virtual timer forwarding
      s390/idle: Add comment for non obvious code
      s390/idle: Slightly optimize idle time accounting
      s390/idle: Inline update_timer_idle()
      s390/irq/idle: Remove psw bits early
      s390/vtime: Use __this_cpu_read() / get rid of READ_ONCE()
      s390/vtime: Use lockdep_assert_irqs_disabled() instead of BUG_ON()
      s390/idle: Remove psw_idle() prototype

Vasily Gorbik (2):
      Merge branch 'idle-vtime-fixes-cleanups' into fixes
      s390/kexec: Disable stack protector in s390_reset_system()

 arch/s390/include/asm/idle.h  |  4 ++--
 arch/s390/include/asm/vtime.h | 34 ++++++++++++++++++++++++++++++++++
 arch/s390/kernel/entry.h      |  2 --
 arch/s390/kernel/idle.c       | 25 +++++--------------------
 arch/s390/kernel/ipl.c        |  2 +-
 arch/s390/kernel/irq.c        | 20 ++++++++++++--------
 arch/s390/kernel/vtime.c      | 42 ++++++++++--------------------------------
 arch/s390/mm/pfault.c         |  4 ++--
 8 files changed, 66 insertions(+), 67 deletions(-)
