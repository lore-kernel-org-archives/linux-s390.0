Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454BA434408;
	Mon, 12 Oct 2026 08:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791794196; cv=none; b=HEBoVvrtwMQb2gqiHzDWk+5T3YDBtJ2sNM42UjnaWhoHO2Sk3IOZl3bXCyrAYQp3HyFJbXk0d7WL02KGpv8MxPzrcNwBtBuHimFxy5cRnF114j5X5iX2QiHjZZj8DO+y3cD22WgK9lVF+gaL7gP11egOPMFHDbuwAPrvxD5ICO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791794196; c=relaxed/simple;
	bh=TNfYbVIhHxIjeFR+mW4AVvdASeFEyAVs5zqoZ9bQTKA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LgfmAYxRxRaYP/yrYZBbZIFV2I3RFAyHL7QpGyNDW0UNDw5Rk0BycRWTeUEjDuPRGZjNByCk4UQJ+iRQbzIbL0vqbsnwNhlFG3OxUMj0Ofa49yMn/rT3aj6y+3LVJh/HZnCUbQZQmMQOPXQm0gtX1tu+qeSkL65rFxS4QTggWq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MQf6AeJg; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MQf6AeJg"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69C5EOG81693853;
	Mon, 12 Oct 2026 08:36:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=ayYKQWbD3mIUHkpA5XXh6gNe2a7vCseeQBv2j6B5S
	N0=; b=MQf6AeJgJxZIS+QOTiQ7fl8S1CcmA9ucYt6EBzFOxFVDYVvjZ8SpjQkkv
	Y7KzmzLqYQ368kuk0/NkZq5siB7LHdaZrll/kDigRb0zGTfdG/4seY2VdP+yhtHE
	sySxNc1gcdNW1NZSjM7o/e+rMWmOXo4uFmA6DdPLg7jRboLfZxMcCiLUaLaYFxCp
	WuobY/mV8wzMc68WMc+uIFzOI6T1mHdLoAEruA6feEnUZ/IjP9pcr7MpOqCs38fX
	Nj7S8s2/tFihYDkCNmPT38l8X6KnJQUI4Z46pnOGR83tHscS/5Kg4uZDZIi+9ewv
	iXGH6AYbG6YvJjH5ZjOJn2iQy53Vg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dwh7xpe-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 08:36:34 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69C8JxPJ964544;
	Mon, 12 Oct 2026 08:36:33 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h7yppmgwh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 08:36:33 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69C8aTVF29950408
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 08:36:29 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B68F42004D;
	Mon, 12 Oct 2026 08:36:29 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8C9BE2004B;
	Mon, 12 Oct 2026 08:36:29 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 Oct 2026 08:36:29 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 0/3] s390/probes: Various fixes
Date: Mon, 12 Oct 2026 10:36:26 +0200
Message-ID: <20261012083629.2109206-1-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDAzMiBTYWx0ZWRfXw4LAxWwmS1oF
 wvifaU7Y2Agj8bIKHi17D8fAgnU51jrV7YWJRGXR6gnr9NVYHhmCqNDxDOrZGWyaGghl1iE5jKu
 +YgvZEUZ+B9QfNppkNEtW6M2BzawmRc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDAzMiBTYWx0ZWRfX1LcX/aMjqDa7
 hHQaCFQhzoF95M965gXBSg8YCnwAHtB1bupkv4V4Qk6YTS1knEXH813onIiUQc8D/5Ik5eWWVNC
 AcSXy9/EFxEHpdM9EFjTMxcWnMj0s7WFecHqTVOZb8CFwt9wc+lMQcrlbUjgIcgIuWb3sXb1xp1
 8mpNeKnagK4JY6ifOicgHg66uzGBKDRH7cKw88qS1SF7+Xn4+rkXhSjGFgk1n+wB4M5z/UVtRib
 HNDQ2tOvJhzyB6Fz1PT3uiOfkwRO3owogY8SS0MjuJopWbB72FeFdb44DucGO57dtGEMtO+ugs3
 DFctPCGTG59/0UaEwLxc7gblzYqwPHPB/OabKCvwUXeWfU6gLHuY+4Rj4V7YE/QqBZCspx3lCeY
 Lx8tsvlyW6mYbL/CzfAO+E7znjPFIGG3ruw7zaEfwUxf4OzD8ZsCHpB8Lwayq0bV4TIII81JScH
 QEtJlPnU0eq4M76NJ4A==
X-Proofpoint-GUID: 378b2Rqx37tCVT-Lk4ukUwoG1QmTNnIw
X-Authority-Analysis: v=2.4 cv=RoFQvymK c=1 sm=1 tr=0 ts=6acc9c12 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=V5RrGCjYUrwCLibBAOIA:9
X-Proofpoint-ORIG-GUID: 378b2Rqx37tCVT-Lk4ukUwoG1QmTNnIw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_02,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0 bulkscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610120032

Fix various bugs in uprobes/kprobes instruction fixup handling:

- For cgrb a wrong (non existing) opcode is used for comparison
- Handling for bctgr and bic instructions is missing
- Wrong comment for clgib

Thanks,
Heiko

Heiko Carstens (3):
  s390/probes: Fix wrong opcode for cgrb fixup
  s390/probes: Add missing fixup for bctgr and bic
  s390/probes: Fix wrong mnemonic comment for clgib

 arch/s390/lib/probes.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

-- 
2.53.0

