Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795161570;
	b=yNWltBUL3j96h9B4/k5uZibMQWhYKNzHnmg/lFo7t7esWpwhry4TnkBAMFdwQoaHk2xi
	 yhYpU79/i4ccpGUP3m13rVjijsfQavzrBQHSiUjx4Sc0/go709WWW4CepNrWn/Jhnc9nE
	 CWJycbJF2HklNzGaAn2d/n/zS4SQy31/0S6TbjSuGqhYNdvS7LKE4KmzSoysQ0BjccNlm
	 pcJeIsAET0+MNBFf5bTF+YGeD/ZwCXSvgEGuynnWNDimQNb8/sCPRsBJ14uHraSwHbBpZ
	 s94fbRs2Oh1+Ya3V2PIYOpP8HrGx9FEhlN69oXFYtB1lY/cTv5w4wADlAyWFqr9xS+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795161570;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 X-TM-AS-GCONF:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=F2n+4r1Qd+k8zApxHYn/nInTmDlOUducVk8dWZ2hv7U=;
	b=K0NgdgMZbELmoFQMsuolqmy/PcQ3bv+Ci0vqM16lGHjHOl43am9EZ8SYVKq6I5FC6A6n
	 STSiif4UMmsGqyplhLAnZzkB9xDehhkX+5SOUFwQw2yxpOfX5Oy2TrhTnSMJ5A4JR4rWU
	 cciIMeK/S4qHErT9Oc+yL8l4sOlqyEzjmPE2OyC5A2NtcpTrBbe6v7BQheAxIH3ASnHZV
	 QjneFqFGuEvDzcvcD4OwXws8XSNhlqawvMvgejQgznITG6Dl0pf+LqbWzgzlN5jYTxmxj
	 mN4z6Ze25kk3CS1hk9fhiS4wcCh++bh59+dIgHoe8wdw8hqXq92+RnSJUDA0+5VDHRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b="OEQ/sW/t";
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2487606A320;
	Fri, 20 Nov 2026 07:59:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2487606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=OEQ/sW/t
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AK7uNZw2531150;
	Fri, 20 Nov 2026 07:59:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:message-id:mime-version:subject:to; s=
	pp1; bh=F2n+4r1Qd+k8zApxHYn/nInTmDlOUducVk8dWZ2hv7U=; b=OEQ/sW/t
	DO5k5qHIqnMFCTBcrLZMFFt05/VGISLK++OknAs3X93c9ZqUXnLdel2SWGnbjKc5
	ORhjf6zo/I7deziCpmAgHmmghW2FjnFTPwMFWrtwq20djCQh7IMlZTlvDXRHZfAH
	wRTy9xewnvS+ikI+kw1XGO/e5+1qvYHdyMRhCHZjxmKn7hiHLA3DyXeK5y6Mmz11
	M674HMkpMhY1/8KzgvpysPdsC6/kMafAzmZQjIC66u2cT1GVWxXyHO78bCl4VnGi
	zCV2KM5IYbdiRi78GCPy1hsez3iJUU2gznS1iKFxmBuIORVPpyrSSwVf9q81zvzn
	KkDtoFeO0coIcw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105vxqnb-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 20 Nov 2026 07:59:28 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AK7o6gk2242262;
	Fri, 20 Nov 2026 07:59:27 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j1hd71hwr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Nov 2026 07:59:27 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AK7xN5A45089144
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Nov 2026 07:59:23 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6069D2004B;
	Fri, 20 Nov 2026 07:59:23 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4716E20049;
	Fri, 20 Nov 2026 07:59:23 +0000 (GMT)
Received: from tuxmaker (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 20 Nov 2026 07:59:23 +0000 (GMT)
Date: Fri, 20 Nov 2026 08:59:22 +0100
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] s390 fixes for 7.4-rc4
Message-ID: <20261120075922.3382525Ad6-agordeev@linux.ibm.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Fm_K2aGAZITDy9ygzmUp6syw-Ytz-KQX
X-Authority-Analysis: v=2.4 cv=HL9WhYtv c=1 sm=1 tr=0 ts=6afffde0 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=Cb2_Q8YfTQsDjjc_npEA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: Fm_K2aGAZITDy9ygzmUp6syw-Ytz-KQX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDAzMSBTYWx0ZWRfX3BpkRxfpQOqV
 p2OPiPDJPVKsgEoeBKt89m0MgT6s393Izxcw5b4SxpXDPt1gX/4C0dYo8ZneeI5HCrMvHG+CbG1
 +aZv/9v0toK6A7w+YtlX2ak7bvIp0xkuQtczIcAvQnXgnjeADnhapmqNJfBoxIDaKJ12bQN1dQ9
 WSPTdHEs2cw4Off3mi4sGpxSPDNRcn4RTl2cDgwBhX2N5suR+hYksTDkjXvtZwCUYQmk+mmMB5P
 UBRGujkRk52xGRJTNebzKBqZJEY2uH/oDbDgNEFNMbM5c2mUfRiqSu5N6d98G8VKTLZmNWf3T2s
 WWGYbcyZPdamp8nHIkHRsjvUr88tNYWwAeSxbJDwWFVn659fc9aYuq/AC4uhRFlzDh1cmE3GTcB
 0gseYAvJ7FH9PIFizqsngJbPsWVLJyF9YVzVRuvHHtmgU3N2DZ4XDna/noEFrcVr2elkgZcmEr4
 aZASD4gewMYXzliGN2Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDAzMSBTYWx0ZWRfX+T67MH1GUozZ
 tP+EQP44N5ax8+q1FU+omfecfz6Jv9kx8C/ImUyLaGiG/wg1BJvNTGvsug6S3UpYUaAcrzLMl38
 Z9xEv42QUX+6sWOvUhHeCNdWb37X7tk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_03,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 clxscore=1011 lowpriorityscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611200031

Hi Linus,

please pull s390 fixes for 7.4-rc4.

Thanks,
Alexander Gordeev

The following changes since commit 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4:

  Linux 7.4-rc1 (2026-11-01 13:26:31 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-7.4-2

for you to fetch changes up to 64ee7f863655e67f26947420516daba4e232675d:

  s390/dcssblk: Initialize device semaphore before sysfs registration (2026-11-05 17:54:25 +0100)

----------------------------------------------------------------
s390 fixes for 7.4-rc4

- Fix error handling for monitor start and stop operations.
  Return failures to userspace, prevent inconsistent state
  and potential use-after-free scenarios

- Ensure skipped syscalls return -ENOSYS as expected. Preserve
  existing ptrace behavior while separating syscall number
  handling from the return value stored in gpr2

- Fix a race during module initialization where sysfs handlers
  could access an uninitialized device list semaphore

----------------------------------------------------------------
Gerald Schaefer (1):
      s390/appldata: Fix error handling in appldata_generic_handler()

Heiko Carstens (1):
      s390/syscall: Set -ENOSYS return value before calling syscall_enter_from_user_mode_work()

Jiale Yao (1):
      s390/dcssblk: Initialize device semaphore before sysfs registration

 arch/s390/appldata/appldata_base.c | 12 ++++++++----
 arch/s390/include/asm/ptrace.h     |  4 ++--
 arch/s390/include/asm/syscall.h    |  1 -
 arch/s390/kernel/ptrace.c          | 28 +++++++++++++++++++++++-----
 arch/s390/kernel/syscall.c         | 20 +++++++++-----------
 drivers/s390/block/dcssblk.c       |  3 +--
 6 files changed, 43 insertions(+), 25 deletions(-)
