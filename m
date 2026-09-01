Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0B8CA6B
	for <linux-s390@vger.kernel.org>; Tue,  1 Sep 2026 12:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788266014; cv=none; b=SRNS//nDACjKYTv+AV1uJb4F3ZNjGJgUabq3ghIfRe0SH0OUdmez8WXp8PQ2X14YgAY/FkoRxoO+W1ZAf6aJTFMZ8zEM8jqY9aekrVP9BNjRDWcyv9PNt4eJ9nInT430S+MIH3l7hYcSDwQkw90nuBhKbEUHcDDTzdAM2WdvQuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788266014; c=relaxed/simple;
	bh=/I4iAei1m4+ZpqrLXIeR1nzVlKhlgFbrx0F6sjXcDio=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Nj4qygK7gLxU6zxiy9AuUVd9Ao72QAz/GshpP4j5MiauzN6/g2FMGABMzay1MNxrqeH6KB2cWmumvlSxomfW62Q5w8ZIhJK6Cjg5CqLpHfI53X0fd4kPl3VuXOsnDjenEP9Qc4xX7YIQ+DNKflxVzbARrYybrgycFRPuRcOQ7ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NZ5n94EH; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NZ5n94EH"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 681AVeYM4009803
	for <linux-s390@vger.kernel.org>; Tue, 1 Sep 2026 12:33:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=4owOEO3Ge8QxABZrLKdjEVW0Xl5lDMUzqo+ffHup5
	Go=; b=NZ5n94EHAu6r2KmDFlDYMjlW1cRACE4+EsshM1qj3/GcsQdIwCs9Vhcth
	Tlj7Ac21CrAcDhBEoadSSoyljpvIZzjuW5ixmFDUvAxJru52DAtp1p8sWPbaC5hE
	U50rsxqF8+PQT5jMWl0NuypneXPhFT3eWDeCIovHSABqA0qV2MWaQNv3lUNUocq+
	vzUg84cbEVjlIqEWoYfLr5eu2aPuKofDpMFJ9qtVr7iQsSj7+SMPDtimO0H1nIUj
	agZkTuj8ec5rcqWn2z7nJl/BgtsXN9yfX6EaWAj6u5/3M56BmwMbmuXIyfeKZXJM
	SuNEEk3xjOl+Z9+RwUxz4GbGgTL9g==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbnudqme1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 01 Sep 2026 12:33:31 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 681CQJWT014750
	for <linux-s390@vger.kernel.org>; Tue, 1 Sep 2026 12:33:30 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gccey3ej1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 01 Sep 2026 12:33:30 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 681CXR4D46399988
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 1 Sep 2026 12:33:27 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1CA1E20049;
	Tue,  1 Sep 2026 12:33:26 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0967020040;
	Tue,  1 Sep 2026 12:33:26 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  1 Sep 2026 12:33:25 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH v9 0/3] Add CPU hotplug support for PAI PMU
Date: Tue,  1 Sep 2026 14:33:17 +0200
Message-ID: <20260901123320.670897-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: seHQKGBYe6VkI26cJNXI3ShcPBhp-1CL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDExMSBTYWx0ZWRfXxrXf6yGRr2Gm
 CgpYOX76WnXAVHoRQL/QVd18ZzbVvZRQtgUvio2dOTpuDg9maBAFPiJCrfEWplExzeHLq5Bpgu5
 +WCLWEZy1zkkEBN5Ffn950EZ/d7cgaJwPZAa0jSIeDgAQp5gRimG2GW6Fbjdg+sXKrD4m6H+fZ8
 48Fk1Ks3oxFzonNHCFn2Q1isWk6eBsT0GVOenF+hhJKkwZqVe5cBE0g8iVmBO4LquT+LwyThRPJ
 Cyw+GlQl/mDyxmDR1AJh3pjAEtCBn3ayki8DwfqO/1FzsfrASNustcXqnqhF8bRywjBY9b5zXaC
 lU/ckgxoK9Gx4CZMdqoBst9hzyf5mYMsRlD3Okzh/3W14syKSxvmmcjrQkje3PY+KrPe6BcuHZg
 DDlqtLDNyI1jkkyxW8vSNhBVkbYH0NIjJSLnyDhEoWnpxwGftt0BNKHaANrX5WXeof2WGyvEm6w
 vHLD3PKvpUPnC32rtoA==
X-Proofpoint-ORIG-GUID: seHQKGBYe6VkI26cJNXI3ShcPBhp-1CL
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDExMSBTYWx0ZWRfX3EdnpWEdhpjA
 nb+YIh5EuSKdFQRIZrCE6DUlHab57hE/TvewNVlrgZ4/r30KIezFhmfbWvCalOjqD2Rw99GS7LG
 WBk9PhAAeF8YTIhWF015ylCpCUPupcc=
X-Authority-Analysis: v=2.4 cv=B92JFutM c=1 sm=1 tr=0 ts=6a96c61b cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=b1OuvuXAq8WmgBgwFWAA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_03,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 clxscore=1015 suspectscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609010111

V9: Added suggestions from Heiko Carsten
    - Changed coding style in patch 3.

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
