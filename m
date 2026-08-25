Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FAC3D0BE4
	for <linux-s390@vger.kernel.org>; Tue, 25 Aug 2026 07:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787642984; cv=none; b=P2YWNs7I+3HRv8V8KvNC0IYYQo3E9OkLl7Exfai8CRtfHcPnlMxel7rnQX0mSP+GKCYObH+FTpYhjgbcsDiDeH5qFvHPXRD4OZJqiA7RYhith6Dyhq/UV7oI85PgzfzabEzNxp+pIGmMT6TgEjmxYlM0XwpZMXmQvmst+yRNWpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787642984; c=relaxed/simple;
	bh=OTKG3wYXCPqetdR/k3cAsdl9d1ma4AEE/Vb/s1NsdEM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h9p4jbwpg8EI/crDd4leZjhIr6MoCp89Z6ul86dlcaSssW/IhXY8Ae52CyDcKQsZKfCmLIkDRznKZcf3awCMQy6ihnvjvzSaoTBuO4cKy+8ESN9HSQG9Tvx4ni9DIovRle5FDAuAeED2D5lz3PbyEv8gRMPa5RlbWFIIRPep+Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JIH9+p8e; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JIH9+p8e"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67P2Vhit2619348
	for <linux-s390@vger.kernel.org>; Tue, 25 Aug 2026 07:29:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=NdG/qTI9efLmXaRtIK804bWnMzczdGpCupZf+Xc59
	68=; b=JIH9+p8e9ery//NaXf0VuFrDoYrSMDSwAVxLJk0B4N2J4DIGKSrijrdT4
	6avfFXJjM7bgpBFUoozKPZwQNY20F+1cSv8zc9vjWFEuGHP5+Z8A2+eAxqxCNbtg
	euy2LfAAv/FMBCkY6ZKvCjkEiUg8IfqJladRTay14cPGU9DkYCEKBayRsayDvds1
	IyzISs9XHH5H519FAdl+eabboZ6VLDdIOgr+snMg/l+qvlnDSHQOa1rbp3KojEjo
	BeKwnz25ip8AkgssHrvZGPK/dqzqIBLn+/66bDYHiyMIWLgrZQEbavaoVAKw/tJ5
	WqqCYBHFrAvrzopukOHOq/6QleA8w==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g726eekhh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 25 Aug 2026 07:29:41 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67P7QI9j029522
	for <linux-s390@vger.kernel.org>; Tue, 25 Aug 2026 07:29:41 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7qkh2s9p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 25 Aug 2026 07:29:40 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67P7Ta5547186298
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Aug 2026 07:29:36 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B86A82004B;
	Tue, 25 Aug 2026 07:29:36 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A4EE620049;
	Tue, 25 Aug 2026 07:29:36 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 25 Aug 2026 07:29:36 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH 0/3 v6] Add CPU hotplug support for PAI PMU
Date: Tue, 25 Aug 2026 09:29:28 +0200
Message-ID: <20260825072931.3738180-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=TfimcxQh c=1 sm=1 tr=0 ts=6a8d4465 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=lQW9TJnzQ4aT2Au-fZ0A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDA1OCBTYWx0ZWRfX9PE0qiRixWPM
 ZlK5rec1mk4EyFBa5zYLn9pbXOpnYbj6DkTXVi4dYVIXfSCnd+prSvnEd/50T3j+mb377d4gTGd
 NpNtLuDso195H8pUxWXGsF97gVYtgz0=
X-Proofpoint-GUID: nS779Y-Un9VjBP3SB1BOo9TFSjb-97rV
X-Proofpoint-ORIG-GUID: nS779Y-Un9VjBP3SB1BOo9TFSjb-97rV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDA1OCBTYWx0ZWRfX4/amIhZR+Sbe
 dpYDw0dIpdzqo77OIpC3BzBig0HdUCH3e69RUZn4wfLqFdxZRmd/I1CmBuMrw24oC3Jakx9JsiJ
 yNqYY7OwOR+6aiMWSwgY90Dtiok14GW5t9nwt6qWfva1pZDGstJaGvcilDAR4B4Y3sTIQiFQWT1
 SjmtM2klAAh05oYjFUJO3pUvBoWVsbdtHt5Nhbp0km/MUwwJfEPm1ZbJV+b0TuBJBX/j8GUW55E
 EZOFEnz2z+k+88NcxNhNsK06zHEMJTXyOxpHa3UQGeuGYpbpAf4S/dwh+m/k4nVBBy3WJAkJTYf
 3BshIyxr6+nJXkkcdjWhku+bmo3NMgJ1WeDbXzisvpFXN2u+8NxJPefU2iQ4szKEbqGaZfw+RQ6
 2CIiEu2Hky3WD8nVGVbPDzjaeeWKRu8qPWO4vecSROs6ZGMjsCMN7evdSUTxpkQaCRgO2PHZL0P
 NDy1cnDvypmXID7A8rg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_01,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608250058

V6: Add findings from Sashiko
    - Remove cpus_read_lock() and cpus_read_unlock() invocations
      from CPU hotplug handlers in patch 3.

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
 arch/s390/kernel/perf_pai.c | 182 +++++++++++++++++++++++++-----------
 2 files changed, 128 insertions(+), 55 deletions(-)

-- 
2.55.0

