Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14814365A14
	for <linux-s390@vger.kernel.org>; Mon, 24 Aug 2026 09:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787563261; cv=none; b=kx6hvf5ZC9ZmNXEobUK94uAxa/TXNllw3aD8aGca+3/SER8v0LKJ/Wz8gh+6Dokrfg7/dAnfnGChQFKuBLPcpCApQuUml9I5wLWPWPHSRT2EuE5InaWQSBr/GfJkFcnwu1qE99HR/JAXr+2pEo8cLWYKDfgVab+2vhRcihpWP34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787563261; c=relaxed/simple;
	bh=UaPlgEn5dY7afOMVcAlpEPgjrEbrcTXPYndEyeYLyXk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uYgGNXLAxC5hSeQXnG8CdDweBhyTSB6/0ZDNyazxYttwCO9p6aONBLoCRmHuv7QB3e36I8NWPY5+mezqQWVtETpC+ApYZJdlIkrxFJgKRiJZcF9Ivby/SZE7p+u4Q0GRGthBEoCfQhTDq//TKMGJdN55dMw4rLdvDooMyRa4pWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fQiTcTLP; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fQiTcTLP"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67O5W23K1014976
	for <linux-s390@vger.kernel.org>; Mon, 24 Aug 2026 09:20:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=4LRq8XWoSmQj0EoIyGC5BWtRvtWJMWkCQ02C55e1C
	HI=; b=fQiTcTLP5t12DlLaKTj3tFkyY9dqjZg1v6CYw04wIS2J1AWcYUp/HugKR
	+3yWCeaQuyzoQSJ2h923Ubsfh2eM3kuoikMVV1zaZWlYU5hcZyoC3QcKvKZxoMiD
	T2W+eSFodJiZG95GkYID2uCKR9D8vu26oV8NNIEuX3cvlna/s3zxLiHtGBC7wvQL
	3O4/d4TxgpMcrRtlueftZDsTaJRVbDf2W2qRhdfs8Gh7BBAZRHklCaD02pvTL4Cx
	YtdJ+i/BTs0/ltDhRxXjzQQonS6uKdljcc05jA5GwxhPFKMK/LuF+5/PXYcAkag6
	FzLQ77QPQckHPHF841YMcWF8I71ZA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73dx055f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Mon, 24 Aug 2026 09:20:55 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67O9C7eC011181
	for <linux-s390@vger.kernel.org>; Mon, 24 Aug 2026 09:20:54 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7qkgvxnt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Mon, 24 Aug 2026 09:20:54 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67O9Kobe37880292
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Aug 2026 09:20:50 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7D4A420043;
	Mon, 24 Aug 2026 09:20:50 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 60AF920040;
	Mon, 24 Aug 2026 09:20:50 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 24 Aug 2026 09:20:50 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH 0/3] Add CPU hotplug support for PAI PMU
Date: Mon, 24 Aug 2026 11:20:33 +0200
Message-ID: <20260824092036.3075553-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDA3OSBTYWx0ZWRfX9pdxY5EtLStw
 w8gG7taz7nnpu5nbRhGM/DCsu3yvEeN30fez4osJFL4FM+9fPGxBNos0jv5u3YdVARVbM+BpWSi
 Dp5OITvdACPfHrGGRvxFgDdR/z2B7dw=
X-Authority-Analysis: v=2.4 cv=AYuB2XXG c=1 sm=1 tr=0 ts=6a8c0cf7 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=lQW9TJnzQ4aT2Au-fZ0A:9
X-Proofpoint-ORIG-GUID: RCrB22Bni3Vk0t7mr12wxVXJ1yZb_FzM
X-Proofpoint-GUID: RCrB22Bni3Vk0t7mr12wxVXJ1yZb_FzM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDA3OSBTYWx0ZWRfX4tFfpdWSztDx
 yFrEGtVZmg5nFv7jSJ5hO5fiR5zeybd6YDI9k0Jvb3oo6QGxUb41h4B2GzH5MRY28eGILJ4xvQ3
 i1oY0TH2ebaSiZr7AD4+ZYmUUDLRt9BExTFSSGHwRucW57fe/ddCWchaYKjZlsMIi8bhydByWPZ
 hvpsLogs+X824RtyDQfAoh8XWnXu54sopMEcHOHh2gOARyO5YUc8hZJrAhXxbzCfR+tCgkZZaIr
 xTkpX+1N7bR5imZZwrenQkjFdkB88yDY65Q+H20shN6R0DZLG2kt9SV5Qle4nxDaqPtwvohXNCN
 OoqINTAxTbMaOssnpUN/X6VVMwtaL2g84Gx57JE+GgZao+SQBLe5yaPZCV6OehdCsKgF0DhcfkE
 P8CEnx9pdzGCuCpRN4SLOq8Wi9HHKI811Z1Ltg+O0vMCP2d58lMyCYawCtqusP1DZClsHD3SkRW
 ylSrAfS3TwJXGuo1yFA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_02,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608240079

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
 arch/s390/kernel/perf_pai.c | 178 +++++++++++++++++++++++++-----------
 2 files changed, 124 insertions(+), 55 deletions(-)

-- 
2.55.0

