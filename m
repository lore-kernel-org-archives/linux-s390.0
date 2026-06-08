Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60518146A66
	for <linux-s390@vger.kernel.org>; Mon,  8 Jun 2026 05:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780897083; cv=none; b=Zhwaf06LYKypm85uiFrakBh5onBw8oUMp3jHTAN5JsjLMy7unUHqR40mIVvlH5ZrTSKOcI50QJ2pZACGB2as4wC31P7hmBTD1lx9rjrbQ3XsqM5nVHhPIhOHoWEZsHk8aYF8tKqrdzsI8kQ+I0oWvFuU6FIOpzwrgYVIlsM3FU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780897083; c=relaxed/simple;
	bh=JvRASPB93QlaqetwTT7veyxsE7KJJcFSqBAu1gUqZ4s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EIjYPTwB+LP6fpy9x75ohVH1VqcuceYLFr83bgoyGQXX84SrdpBKnRQMUC5v6pKiHtA0bS+WYwmk3Ov1ywX6QFcG1USofeId/ngDTkvy4T+q50oQFf/RcleZFinJM0BZMGXPgHk+QfMAEbgvyFW+MFJ/hfW2N14CqwS0gReWZUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HLZCp9SA; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HLZCp9SA"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 657BN02B3223957
	for <linux-s390@vger.kernel.org>; Mon, 8 Jun 2026 05:37:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=pcIUENn8k0O4G7ulGtXWCV884GtKTHNImxQjfR0re
	cY=; b=HLZCp9SAw8vTW9ADWtmptsLOwLATeEvK7w8FzleR4nUb9hYfRs9rhkNO3
	rNIE9O4/3VwQmZx8CjrmbRvHpc51G4zLfu8v58RRpy3eQYGpowr8iDi8hbORYXVE
	HB8vxFwwbXrDs8P79073bRXlpKeM/f9hI9rC8KPMh9hAeSJG6cNzyR2NtyFbEZuS
	lWPrl1xF+D0UNUcyO93zJkJYycrvXhUhn54AihK0IoaQ8ZeRV9jggXmFn5jWvHox
	NNsTpFR5exLkdvBwA4GfWjP4js3no2TiVliA5fXGrmNOQlwIO3SjEGnNCTbBQOFX
	E8aR4Q8lf1q0K59+qrVwDGl9UZtAA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4em8yhny1c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Mon, 08 Jun 2026 05:37:59 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6585Yfuj022745
	for <linux-s390@vger.kernel.org>; Mon, 8 Jun 2026 05:37:58 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4emycguv1k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Mon, 08 Jun 2026 05:37:58 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6585bs7t51970420
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Jun 2026 05:37:54 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 90D5420043;
	Mon,  8 Jun 2026 05:37:54 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 71A7B20040;
	Mon,  8 Jun 2026 05:37:54 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  8 Jun 2026 05:37:54 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Juergen Christ <jchrist@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
Subject: [PATCH v2 0/8] 
Date: Mon,  8 Jun 2026 07:37:46 +0200
Message-ID: <20260608053754.571282-1-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA0OSBTYWx0ZWRfX8VeTFlAd7GJk
 cnf4n6V+VeTAcbh1tZFermW3ETByYo7Ei//Ej3Lj3gUUOBZxagVwg3tCzlMKFuzxA2QU4bInadh
 rSJdd4d5xAyhEMExr8keP3xqN+d2NUQ8u5gqySjh6NU6001NQWz4ejgOKI2dIFxdHGwRPZIIErF
 akA8VZ82HlQyF+KJBKV8kGGA/4M/juxbbi+muy2lzsCRFUHkcw0c+hSlMmP9mtM6MuATtR1inoP
 shNLegh0AzQq8o9VluPpORElJq9YHzNlNte6w9TFffMEEjr/o8MTvDfrpyYTK8r/QGUe/80X/tc
 NTmiIiVh4Un0wdyYypjPoZvMoUD22bNdibNX9+IvadqNysSP3SVLQf3j7QS1R+Fzy1mF/UP8O6+
 jczABxeMaOUaLtezoMhjOGc87NUmQ4+qKkDc5+2OKeMKV+fh1oF1Eu5+XvYlg00dpWb2aR1/gUZ
 jVqCSp85Ne5ezA4CQSw==
X-Authority-Analysis: v=2.4 cv=HvFG3UTS c=1 sm=1 tr=0 ts=6a265537 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=c92rfblmAAAA:8 a=VnNF1IyMAAAA:8
 a=Edh_RgK51w-PSKYyiAAA:9 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-ORIG-GUID: LEA0YtOmtNky-KHg6Lj4BjCozg3Q3TFw
X-Proofpoint-GUID: LEA0YtOmtNky-KHg6Lj4BjCozg3Q3TFw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_01,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 phishscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080049

v2:
Address various Shashiko findings [2]:

- Off by one comparison bug, which leads to slow path for memmove()
- Incorrect ifdef around __memset()
- Incorrect commit description for memmove() conversion
- Missing noinstr for tishift functions
- Missing header guard for tishift header file

v1:
While working on something else I stumbled again across the various mem*()
helper functions, which were implemented in assembler to avoid recursive
calls [1], when using the compiler's builtin functions.

Convert the functions back to C using inline assemblies, which makes them
hopefully a bit more readable and maintainable. Also improve the memmove()
implementation by using the mvcrl instruction for the backward copy case.

Thanks,
Heiko

[1] commit 535c611ddd3e ("s390/string: provide asm lib functions for memcpy and memcmp")
[2] https://sashiko.dev/#/patchset/20260607162937.2927356-1-hca%40linux.ibm.com

Heiko Carstens (8):
  s390/purgatory: Enforce z10 minimum architecture level
  s390: Add .noinstr.text to boot and purgatory linker scripts
  s390/string: Convert memmove() to C
  s390/string: Convert memset() to C
  s390/string: Convert memcpy() to C
  s390/string: Convert memset(16|32|64)() to C
  s390/memmove: Optimize backward copy case
  s390/tishift: Convert __ashlti3(), __ashrti3(), __lshrti3() to C

 arch/s390/boot/Makefile                |   2 +-
 arch/s390/boot/mem.S                   |   2 -
 arch/s390/boot/string.c                |   6 +-
 arch/s390/boot/vmlinux.lds.S           |   1 +
 arch/s390/include/asm/asm-prototypes.h |   4 -
 arch/s390/lib/Makefile                 |   1 -
 arch/s390/lib/mem.S                    | 192 ----------------------
 arch/s390/lib/string.c                 | 210 +++++++++++++++++++++++++
 arch/s390/lib/tishift.S                |  63 --------
 arch/s390/lib/tishift.c                |  64 ++++++++
 arch/s390/lib/tishift.h                |   9 ++
 arch/s390/purgatory/Makefile           |   9 +-
 arch/s390/purgatory/purgatory.lds.S    |   1 +
 13 files changed, 291 insertions(+), 273 deletions(-)
 delete mode 100644 arch/s390/boot/mem.S
 delete mode 100644 arch/s390/lib/mem.S
 delete mode 100644 arch/s390/lib/tishift.S
 create mode 100644 arch/s390/lib/tishift.c
 create mode 100644 arch/s390/lib/tishift.h

-- 
2.53.0

