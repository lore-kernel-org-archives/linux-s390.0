Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8D7407590
	for <linux-s390@vger.kernel.org>; Mon, 24 Aug 2026 13:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787577483; cv=none; b=EY75ICQSDM4eTyTAiBDHMPeoVQYRziSgzwcnw6MA2jCxlm1LxUmPod+aj8l8/4SpM4eGaF5pD94OaE62v38C6LR8XPlQ0gEHGxS5lbDAJGa5Oq5G8vKyIXiD0Ae4bNGkj9LgrO4rVueEOXgkGWGSLaXzDsV4JCbhF8LG4QQY7HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787577483; c=relaxed/simple;
	bh=6GrSaPnVBTTSHM7+m053SxqX76785HoSxWdxo2sg/3s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rnL2EG9I5XeBgBKm1ktVEvXoRe29mJldoLJqWwNFOnF8nPz8br9zeL9VKC6eUPCgrbTOASgrJCmlV5f8D8cCO5W/m5nFVeJ+/YUmXjH0ygNPbhAVYgWzgGuxxdT6s6fg5TP9AubVD/IguhDxSB9N+9Fq32bjiJqPCa5OeXQFHSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=K5bdn1yV; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="K5bdn1yV"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67OD1rAr1846170
	for <linux-s390@vger.kernel.org>; Mon, 24 Aug 2026 13:18:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=ED7QCTgucfl0DxkFcXKo3hFG3VImoCQt6TW55Mq0N
	LI=; b=K5bdn1yVqMMFbIhj6feubyz+HnKNhv4mQ82tYA/HS0wbZeILa9/xAGNco
	dQo8gQOBj+AWSiwp8gEekgN1Dl0CHsqfb0p79hvwB07fVlUbkxwoe77M6ngWXEQL
	CaNSIj/Zu6AqDUSHBB1N7jRV4uL5k+Tf44mKc1GM5j4W1jO0cOaLalmTo2PNSJiG
	hD4pwsuoACn+1wN1amJYrY80i4YcN1e4EACrT01a1tP+NPcJlDjxleBi+jSL/HHJ
	265EUKfczfgXnASdM4ajkqQzgdmFZnmgn4wwdbdjYkYEXcOG0823KjMp5ig/mVhu
	QiKjvNbaPc0S4cwsGNVgjHKAUWxgQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g716hhqm7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Mon, 24 Aug 2026 13:18:00 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67ODBLPk024298
	for <linux-s390@vger.kernel.org>; Mon, 24 Aug 2026 13:17:59 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7p3px8fd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Mon, 24 Aug 2026 13:17:59 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67ODHtPV40894804
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Aug 2026 13:17:55 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B56B52004B;
	Mon, 24 Aug 2026 13:17:55 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 98E5220043;
	Mon, 24 Aug 2026 13:17:55 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 24 Aug 2026 13:17:55 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH 0/3 v5] Add CPU hotplug support for PAI PMU
Date: Mon, 24 Aug 2026 15:17:48 +0200
Message-ID: <20260824131751.179275-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDEwOSBTYWx0ZWRfX6V2d01hpltkc
 AaJxz7pXPwJntBupSy6oIHKjielgB33BAxEO0CL6Hwgxxdh0SpQcQjkDnqPgABy6449TQ+py6Or
 VuaMsz+nm4CO964lpcCeTwaDqtN3uts=
X-Proofpoint-GUID: 1X6jJI23EH-m6ZrkPeM1xb0m3261cOlo
X-Proofpoint-ORIG-GUID: 1X6jJI23EH-m6ZrkPeM1xb0m3261cOlo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDEwOSBTYWx0ZWRfXxDVvAk9X5otx
 ytmTJqjBwfc3WtDhNWIegAwe8HVfATA6cRZcuik52ID/DYzYpcK5bFrNzJP2aLY23SqRq24JVF9
 JymjDgTg42beBwp2KF+qNZC5+12BPPllt6ksQ7riFcw53qIc/5jp1DaI3wyw2aeGDgUhoaUNva7
 359rLCqUCLooiPAbzkvJAVzOzUNjt1kFagwYX9x3KFwmvo3DsmUL4ZownzZv9M6brRVThzsZ4nz
 hzYqeyMHf3DBF/Gcj8y9KeTt9I1UXhdNSFbPOXpUA/pOhXs9PMflmB+CoNJNWmryqdV5znmPLJ7
 TanpqToOQuFjsLb3dV3Ze66J+fQifRmVHYpLzvrxGFKSqr/gu4hxX3SrpbUNaQoW+fFyNVQbl3g
 Rd6tgUK+WtbMpA4xS/eNqSLsUEp8ZdsD+hELv20gHpSaX04KRcPBUTxw4oqKbJBHn4VGR1blH55
 HPEOuNDE9kdUNMzTqfg==
X-Authority-Analysis: v=2.4 cv=H7brBeYi c=1 sm=1 tr=0 ts=6a8c4488 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=lQW9TJnzQ4aT2Au-fZ0A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_04,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240109

V5: Add findings from Sashiko
    - Add cpus_read_lock() and cpus_read_unlock() in patch 3.

V4: Add findings from Sumanth and updated patch 3/3.
    - Fix reference count for CPU hotplug remove while multiple
      per-task events are active.

V3: Add findings from Sumanth and updated patch 3/3.
    - Refined Fixes: commit id and messages
    - Handle cpuhp_setup_state() failure

V2: Add findings from Sumanth and updated patch 3/3.
    - handle possible NULL pointer dereference in pai_event_destroy_cpu()
    - handle possibe memory allocation failure in pai_online_cpu()
    - add Reviewed-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
      to patch 1/3 and patch 2/3.

Add support for CPU hotplug add and remove for PAI PMU.

Patch 1: Change function argument list
Patch 2: Move locking from CPU scope to event scope
Patch 3: Add CPU hotplug handler

Thomas Richter (3):
  s390/pai: Use PAI PMU index as parameter replacing event
  s390/pai: Move locking to event init and delete
  s390/pai: Support CPU hotplug for PMU PAI

 arch/s390/include/asm/pai.h |   1 -
 arch/s390/kernel/perf_pai.c | 186 +++++++++++++++++++++++++-----------
 2 files changed, 132 insertions(+), 55 deletions(-)

-- 
2.55.0

