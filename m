Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92BE71F3BA2
	for <linux-s390@vger.kernel.org>; Tue,  1 Sep 2026 08:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788252910; cv=none; b=DSsEa016PHP5f4MyS8x9agKNeww93+g3K4tnEp4q4dDKpQEDnNQhiaTVuYQDAYK1idUmuDJvVm9wNcCzsMs8yHSQj2Zh/DK+1z0nnOHGISHCdfOCQQvGaGCFfR7lZx3L9il8TFh4ENwsbU4CO2nkIGbY2bVu4NPmgB8bQBQv4hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788252910; c=relaxed/simple;
	bh=f3jujC11ZII90BMNve572/0oKB+V2yQ3D/ahemJ2G6M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i+RjfsPNlCKXlBJ1zeOXjgQNBD5X2DRh1l4j7Xg7BAdvPgwGxg+f7ZR52RDsNzFIwpddwyHc8P2kGW6oKldCLa/V3b4T4y4pXhQnh1o7QzkY7Pz644r7cyQsmDTySXeUufejejpi0fmQqtoDPjtX4tYdue8OwbfFjbnLAbUkIsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=j/4N3iq1; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="j/4N3iq1"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6817Vept3635874
	for <linux-s390@vger.kernel.org>; Tue, 1 Sep 2026 08:55:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=Jf+F6uHuulHijASl33wfo0XmtG8gQIJqKWwvc3/gr
	wE=; b=j/4N3iq1Kj14JgvkVQ0XLJx6ARJ9panCuZ6wu2dEtGGshOjFPxfUxZc/W
	d6nP+pgBs6IILyJ+ZfZFdlrQl1Q5U+gqDf0YacPY9LkRBSQVTm3NAQVhP088HZdA
	P2/8R7hz6cAMX2CzZ/Y6kfBvuYb+9Z+9BNAzJ3gwn2CCUvHvHn7eiG5Kx8L9YkGG
	geieOPiv5frKEgvown7FJBCTZbmUTboChlBGyxmCS9Z3FS5cGmMwTbdQCXLq9igA
	qWIkUgyslRqTWySNbwLei43wxz92NVGVRwgz/1qC4La44fqAgwmhH07Lxl4eq5h/
	Axsy+O82fXjHmzqkO7PX4s90jcRvA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbnudpmgr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 01 Sep 2026 08:55:08 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6818fNT5008858
	for <linux-s390@vger.kernel.org>; Tue, 1 Sep 2026 08:55:07 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gcb8hapnd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 01 Sep 2026 08:55:07 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6818t3MM10879272
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 1 Sep 2026 08:55:03 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8F3FA20043;
	Tue,  1 Sep 2026 08:55:03 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7823420040;
	Tue,  1 Sep 2026 08:55:03 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  1 Sep 2026 08:55:03 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH 0/3 v8] Add CPU hotplug support for PAI PMU
Date: Tue,  1 Sep 2026 10:54:45 +0200
Message-ID: <20260901085448.2260658-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: wQVCLNeYhN2VYSFcZDUmnCel6NlzTcP5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDA3NSBTYWx0ZWRfX5ZOVwZ6gUfPo
 EAD2naPA97swv57Zgy8R38jsA4IgkDMteE8OcXdxvSfAEOD5KjTRbW/QakKmxHz/3V7RGJYlv98
 XxQP/MQBOfMCaA1hDtD8mTvJId4aHcpEpMsDg/JuSbvSwGaEPUvInO9xYpBxLEkXtgalOxxUluA
 +FNPYCuf8pODlzWq3N10F1L54ml/WRcO7HwxpZkqSso0AWJw2KNfB62vnNw80G5JIbSQzXVJZsV
 Lxd2Vu9b0mWiYDbOOh+8Fc0TbcXLmHybO/ag8KpJf4umFGMTBo1e8Z3d9zq18a13UsM1Wh22Qsz
 wJ7kKZDmqyGH9CHJTpRgQ6FYzB4TGMYWOXs3KJPPXF/9QlzwPPquqZpyJcH4Z3ZNVFxo7JaBtca
 QUCMvDd6p8Q7/POFlxYK3dBpcdZiOo7wuYEIzgkO1l4Cv249vNWnWaV8h6SIQNKBe7kqS1ZQMyF
 cFLbTnXcc21LAYbDjyw==
X-Proofpoint-ORIG-GUID: wQVCLNeYhN2VYSFcZDUmnCel6NlzTcP5
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDA3NSBTYWx0ZWRfX4v8qFNWM2j76
 lPg2a9ZEW++v7EP9N3Y1cXHMZCFbLRlzfoEbhKav8IgMwZr/UZBtZabUcrEcBuGe5GNQxNODkxG
 e065jmaTbrIIKYNN+a78FZbcKeLDz90=
X-Authority-Analysis: v=2.4 cv=B92JFutM c=1 sm=1 tr=0 ts=6a9692ec cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=b1OuvuXAq8WmgBgwFWAA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_02,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 clxscore=1015 suspectscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609010075

V8: Add patch version 8 (v8) to each subject line

V7: Add findings from Jan Polensky
    - Fixed spelling in code and commit messages.
    - Added correct Cc: stable tag.

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

