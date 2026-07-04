Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7A41D5146;
	Sat,  4 Jul 2026 16:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783182490; cv=none; b=gHA5lSSR8bxvTIRUNDkM2Y6cA6ql6yPcJsWmACy9RM9qlSyp4w+14gRa+FDqVGrTd7Y0IMdtaeEJQpx8WSLQCXKZdBQdQTsgEMRXfmPUl777bof9OteKqbDko0OrTHZUGgkQMXOwLUKFCHRtR8Uk4SVhMXBuB+1obMoDOwlnOGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783182490; c=relaxed/simple;
	bh=YSDol0sUi4vZ8bmVEk/j5pCeZbH7aKkc0iWx9ez4RBI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VbCjyT7kEwGWlDFP/fhewe3tWoLSvuafsPlPiOTerb798fSLxMYCVznBjWEMdOtMIT6GCPD0n4gxijYaFjCdOvJDj5N9EqphGaknsMET3gLtY62GxTiOvZyLJXMQKbZzxX3Lch25dmlt3ry0lw0TmpdYRw3BFGbT23CiCbuUhqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aMJ9GAs1; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aMJ9GAs1"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 664GIEF21946572;
	Sat, 4 Jul 2026 16:28:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:message-id:mime-version:subject:to; s=
	pp1; bh=sh+wLtJM+V+f4p4yy7MpCaZl5sO3PbOwG3tdeRdUJJI=; b=aMJ9GAs1
	/Qi7kaf3DLXAWe5VV/XQ3BtLXTuwbJzecI9T38U+f4hDr1LujfdYOQIK6T0SIbA/
	2f9pAaORc7D0ukBEUSsExt4el5pQ7AopWzxf9WJcWhZTByuobGGXOrsPWVGcrwcv
	LlH4tLMeEjukV0v9+FwUhPR3VNcjQYtgB9MS1kGboPRJiAyJhFRkhqgivweuVFKv
	/J0mBCFpyZkVmQh41jMOa470OhCcWNuAOG8tMn+OabeGfli9EYwiRgps1q09LuiK
	6mwfhh1T6G5CeKWHR4HgG+V5VsN6TsaPuhcIW0Arxk3knWuT21e/hodiLvuJTcFl
	uZo+LGkrWQVTvA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sw4a33d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 04 Jul 2026 16:28:01 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 664GJxJ4028719;
	Sat, 4 Jul 2026 16:28:00 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2uhyw3rh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 04 Jul 2026 16:28:00 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 664GRufI11075970
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 4 Jul 2026 16:27:56 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 669E720043;
	Sat,  4 Jul 2026 16:27:56 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 22E1420040;
	Sat,  4 Jul 2026 16:27:56 +0000 (GMT)
Received: from localhost (unknown [9.111.9.151])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sat,  4 Jul 2026 16:27:56 +0000 (GMT)
Date: Sat, 4 Jul 2026 18:27:54 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [GIT PULL] s390 updates for 7.2-rc2
Message-ID: <t@ub.hpns>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: pjecjnkzTi3QtM1iZAev90Px3U51iTDc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA0MDE2OCBTYWx0ZWRfX/U1NL9Mckdnj
 xPxtb4N4/JboVN2SXx0xmJr3XaMlGQuG7h1OIhhXGpPFJNt+AG/3VFMRC0bwg7MJeP8DNTs6CZM
 +ADtEgknUijP0E2YntHwwFsXgwDYux7ZduX4dqvvN4oUBQlOF3Q6vUiYSgzwaKNxAIhHJlpL5ct
 ImqRN5ZQAFlVpDiBF2hT1tpWSl4Hb34rJc0RrzjYHQ+NYjOj8S9dPvObSVEG5BdX4qt+L8f+587
 cMrSsVWiTUaiqePwjDIKYj2SA4l5ont7dMJWO9Gmtl5lgrFiOZ76haP+RqEVkIbc/uGdU93AMIc
 5XjNKPJrtYnHSZwyyAQuSoPWqO41+nkGAiPVJXYZYFjBwbJVXPUljBtC5hI18orXksZO0Zz+AIL
 ADLkl6rs5YjeCp+HGB5NhXwbydbhnUh9WE7qKKEf9AD+oc0uqRTvmJsZdjrq0vsGDyRSC9dNYok
 AsimvkUjoNzS+n0ZDQA==
X-Proofpoint-ORIG-GUID: pjecjnkzTi3QtM1iZAev90Px3U51iTDc
X-Authority-Analysis: v=2.4 cv=FqQ1OWrq c=1 sm=1 tr=0 ts=6a493491 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=j1zNzP0ku-nBEIsX26oA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA0MDE2OCBTYWx0ZWRfX8OHjDY3NBjKW
 p9Pa+YJtuY7186nHnqCSw7UTESbMNULLZRP8Gc2qCBtlrtERVhOlLZu4+Ec2GqDwJakWiQj+HS2
 yvbBVTDaS/zJw8qWbaTrhc/y5TGdvc8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-04_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1011 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607040168
Message-ID: <20260704162754.hJ_OC5sYW7E2VwEaE_owX5yg175FOc3MFL7PLLKRnpI@z>

Hello Linus,

please pull s390 fixes for 7.2-rc2.

Thank you,
Vasily

The following changes since commit dc59e4fea9d83f03bad6bddf3fa2e52491777482:

  Linux 7.2-rc1 (2026-06-28 12:01:31 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-7.2-3

for you to fetch changes up to 2995ccec260caa9e85b3301a4aba1e66ed80ad74:

  s390/monwriter: Reject buffer reuse with different data length (2026-07-02 16:51:06 +0200)

----------------------------------------------------------------
s390 updates for 7.2-rc2

- Fix PKEY_VERIFYPROTK ioctl key type handling by removing the generic
  key-length based type check with its wrong bit-size calculation,
  and leaving protected key verification to the pkey handler

- Fix monwriter buffer reuse by rejecting records that change the data
  length, preventing out of bounds user copy into the kernel buffer

----------------------------------------------------------------
Gerald Schaefer (1):
      s390/monwriter: Reject buffer reuse with different data length

Holger Dengler (1):
      pkey: Move keytype check from pkey api to handler

 drivers/s390/char/monwriter.c  |  3 +++
 drivers/s390/crypto/pkey_api.c | 11 +----------
 2 files changed, 4 insertions(+), 10 deletions(-)
