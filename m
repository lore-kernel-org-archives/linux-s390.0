Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E654B04A8;
	Mon,  5 Oct 2026 14:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791211816; cv=none; b=lrHwxbwZiFzUT6+kXDV4qUNgPZvLcCV8HNNoAtYTxsOt8l9xoseCr8uPaf9DTQLKQHg1vEA68T4k3XFtJsGuYU+DfUZbEuUCn5pN+EtPCa1aooq1rMe2p9IGzO2VxjJ4N89TdlNC3hTrpJ6FLozAnjqJaOjeKbEQK5c40MTTAPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791211816; c=relaxed/simple;
	bh=tgTOnCQkjaNM78JLwnF2gszJUscnhALney7J7AgLZo8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WYNTa7e3P3uKUrmts2cmDveeaF8RQoiioBwW3tNJU3V9aCEGeDcZr66UJAkuO2Rpu3vDMdUeXECicGzCBnPIsPZVr7Hnme0+3trL4W20CdF/5CnH4vzIs5D7gsOWgR/zEHnL90XpQqfylE0BDp7t2XDyM36rFx6qKa6q/tn/mdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=I9j8zve/; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="I9j8zve/"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 695EZRfO964159;
	Mon, 5 Oct 2026 14:50:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=VtxA6WIDal7mq33+ffOIols47L7t+GH6/GwRhw5tr
	0g=; b=I9j8zve/K8MLhbBEPTQASHOwJqZyRXtXuHfx0ULJzBeTTAoTe4TgKagZV
	M3O7kBfsKXW84Ez6LnDfyThL3OGR3nmL/xyCDq96pPZF8lgqkc0RtuE0VWW+k/Fv
	YQX8R380aHTO91qJkEcdTS5uRp31UKmLPNlX3bGUdyUx2MEjNR7Xj3LLP/kdm928
	4wbLAXe3JRuOHTipQ85WCkA+UPF9GjEQFqTpBQkhkogDskM8NxoitlFbmtsNZ9AW
	gWp+cpTyK6SV199Z4SaKlwzrN55PHQuY2CbuWr12suQ9rpOF+BeP4xm7EYhR5eDW
	WshnMoR8j+d+jwmDikyR1ynC6ijfQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2s74jwkj-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 05 Oct 2026 14:50:09 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 695EWdX73063930;
	Mon, 5 Oct 2026 14:50:08 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h3eqy5nc0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Oct 2026 14:50:08 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 695Eo4XF11207124
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 5 Oct 2026 14:50:05 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D7ACC20043;
	Mon,  5 Oct 2026 14:50:04 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AADA620040;
	Mon,  5 Oct 2026 14:50:04 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  5 Oct 2026 14:50:04 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [RFC PATCH 0/2] s390: Remove vtimer infrastructure
Date: Mon,  5 Oct 2026 16:50:02 +0200
Message-ID: <20261005145004.156348-1-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: cax5GTVyQ3HVYQA3QcCSG45tJgeFCxl4
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA1NyBTYWx0ZWRfX+YOj1OQ2df+v
 jU7E49YQ7gwXfnzXbZOxHZ1tZV85vEktzh5KCIr4LsR6yXcbI9/y7uJlfFOYBIV0zwlwakYWvex
 xOU+4SxbOk9wMebG9kWNO8kOyE8sP/Q=
X-Proofpoint-GUID: cax5GTVyQ3HVYQA3QcCSG45tJgeFCxl4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA1NyBTYWx0ZWRfX1b+XywAMXNdZ
 Ot83k0sKXX99f+2Tfg4lxg2A0I7OITUtbvi1hqGPLR7BHVQkJbEQrlmGwzpHHNWOSJ0BEcpTq1F
 aujQUF8oVq/td4Q3Wm36lbel81U26h25NWQRH0Od2SvZLUQYivaYnC654n9z/oEwwKGCoJq2Itw
 RuJ0BBnWi4IuxWq9ZGLpBPz9uCac/JzO9BZZLrK2zvsxQ0gMlJQPFPkHTNkSOzN52+GTKJlbUgc
 sK7aQDjfQC2NrnaXrlb7ckZIVK/F8HNOpi7V5LPVS/d5QHK0fuUmODiURuifYOjH3asQL4Vyppr
 onJEPtWQxFBaQmJOOEf7G4LsoR5hF+talZzox1ovSAKOuofkBmrzqrGoN+CZoXxFdVviRb872zx
 l5e1Q3lv8+Wpati1w4vu2uJ/oBkobCtbHevM672tTUB67/OHOyFu1GYZg5cT1PRcbBCw2bNX7mT
 iH1nfMYnO03nSWrt8hA==
X-Authority-Analysis: v=2.4 cv=fM2sTpae c=1 sm=1 tr=0 ts=6ac3b921 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=IDWH8gVEt6i1YDZ61c0A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_04,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050057

s390's virtual timer infrastructure has only a single user and the
semantics of the interface are not straightforward: a virtual timer
fires if the sum of elapsed CPU time over all CPUs exceeds a specified
value.

This is suboptimal since the number of active CPUs defines how
frequently the timer fires. With many CPUs and short intervals this can
be very frequent. Furthermore the required accounting in the vtime code
uses a single 64-bit value to accumulate elapsed CPU time. In busy
systems this can lead to cache line bouncing when the value is updated
concurrently on several CPUs; which is the reason why other accounting
mechanisms use per-CPU data structures for this purpose.

In practice this is not a problem with the appldata default interval
of 10 seconds, however the interval is configurable via sysctl with a
minimum value of 1ms.

Given that there is only a single user, emulate the virtual timer in
appldata using delayed work: the work is scheduled for the minimum
possible wall-clock time until the configured CPU-time interval elapses
(remaining CPU time / number of online CPUs), with a minimum delay of
100ms. The work then reads per-CPU statistics of all online CPUs to
check whether enough CPU time has elapsed, and if so runs the
registered callbacks.

The calculation is more expensive, but avoids potential cache line
bouncing problem. In addition it allows to remove the entire vtimer
infrastructure code with a subsequent patch.

Thanks,
Heiko

Heiko Carstens (2):
  s390/appldata: Emulate virtual timer with delayed work
  s390/vtime: Remove vtimer infrastructure

 arch/s390/appldata/appldata_base.c | 150 +++++++++++---------
 arch/s390/include/asm/vtime.h      |   2 +
 arch/s390/include/asm/vtimer.h     |  30 ----
 arch/s390/kernel/process.c         |   1 -
 arch/s390/kernel/smp.c             |   2 +-
 arch/s390/kernel/time.c            |   2 +-
 arch/s390/kernel/vtime.c           | 212 ++---------------------------
 7 files changed, 94 insertions(+), 305 deletions(-)
 delete mode 100644 arch/s390/include/asm/vtimer.h

-- 
2.53.0

