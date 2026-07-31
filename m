Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCBA3DCDBC
	for <linux-s390@vger.kernel.org>; Fri, 31 Jul 2026 08:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785487227; cv=none; b=ll7NKDVN/8nf87UMjX8SW4p0wr1duUVgUET6Z27WcUvsha1eCe915qNouS1bYCzNFNjiWocjiJY7NGP17c+yw6jkoj7dffevHgLRuV8NZEoANwFb88fZ7UHQ9aQ31I6sXmxeTLj1OdgEA2jUf/0WjLNg6hfAcgp7MEm6c07mMsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785487227; c=relaxed/simple;
	bh=FH836yu0SUdeHjDbydJssAVAZvbNSOZlHu4huPfhOVY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L+HDiZxtbpOhloULZNfi+Rskfszts6hGkbDPM2BTKUHo4JDlMUj4YaGvZQXXW72qlFsUi8DKJXEweGOYItJfBQ1k+6tzLApbmcxzVaB8Axj4xDMKQGtt5lTeubxGZlnWNkckaGEIOnYLL2QotU45T4wbTrTbDJlpuRGJngjNXQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hPmI63Pi; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hPmI63Pi"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66V8I5aP1231716
	for <linux-s390@vger.kernel.org>; Fri, 31 Jul 2026 08:40:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=biEBa3fvFBCyWf7lcL9cM5l5R7BOjD/x9JHCVfkSI
	8o=; b=hPmI63Pio3r9ORnbktKTnTLDp8fTLNctj5YWTt6uPdbnt56F6vpLm1Yie
	l+1h/XYTM7u2STZN4J+ZzDueIK3qA7ZR46u52enaF0RCsBXZC9+ZUPiudKpVMZMD
	eAkGDBQp4wfgDJDeB/jLbaMJP/pYsdj/c+olmMzDreR/JTMIC/THOIJIU8N6QyDo
	u3Z6oKBIq7Wli4pLmaU2rUWUxP2FBgRlQWlierVAcnbIu84tRKkh/yOg1vykENq6
	Ix46gEz+VphTBgOPz+DBSHGUKgJPXC4t4Y9qdM4iWdvgXaYJlWAZpUZ5oCxYfH0z
	A8SwZIn8Tr1WDCWhcv1uEoteb2cXA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0p33y4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 31 Jul 2026 08:40:21 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66V8QHAS003428
	for <linux-s390@vger.kernel.org>; Fri, 31 Jul 2026 08:40:20 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn7fqqb1f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 31 Jul 2026 08:40:20 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66V8eHHv31326662
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Jul 2026 08:40:17 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0D5282004B;
	Fri, 31 Jul 2026 08:40:17 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E8C8520043;
	Fri, 31 Jul 2026 08:40:16 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 31 Jul 2026 08:40:16 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH] s390/pai: Handle CPU hotplug add for PAI PMU
Date: Fri, 31 Jul 2026 10:40:11 +0200
Message-ID: <20260731084011.2568310-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDA1OSBTYWx0ZWRfX3nDmk378xv3r
 IyWspCG8pjoffe2ZXmbgjqCsNtHicDxLnapoVLIz3Fmy9rji3R9tOjcYkJgEAQek6Awd6ASFTMN
 a5GlkieEm4gbayvGzvDcxuDjasR53lA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDA1OSBTYWx0ZWRfX+1uafGYi2k6/
 YcDyifiUSRJhyQZYcUNBNFjb3QZZUNK78xOJSikzbErL8jStD5+yM9IWEGjV/a9zaF7HS1QdI5i
 T5dgY6j0OV3sPdCw7ncjy+I+aBbhO3Z/a9dmY3iOf9VYv3Muj4wTtUph9rLUgcJlkDKvouKAY49
 pelxkLXTAwUMLpF/afsrvDET9wXqRVE44YNUP9U0Gdxvci39Zh0p8P9GtRoX3bBJNgP+sAMHoKI
 7KOchz6Vo+UuGIuUfV9fo2hLh9nOKs6wNq0m4bJmsmgYrlXHX+2MjvTfGNsED0AauDV9JQEFnDO
 t1q1kABLnyjliG3Nvba/bDNruiYHP/aA7m9YjVe9XAZE1rlIQOgrC/q5mYNy2IMAG1hMqiE2uu2
 PrwRMuFKFY58mBaiX3QY4ZCauEBgUJBJFEx03AJDBEa0Bav/L8tbKysco8oAz/gfNlnZZwNll8v
 4RB01K9X7+Cqouy5nLQ==
X-Authority-Analysis: v=2.4 cv=b5WCJNGx c=1 sm=1 tr=0 ts=6a6c5f75 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=iIXgiIn9oVCNSMPch38A:9
X-Proofpoint-GUID: VHyFAhd4gSNXq1GDcCsjqFiJ2ZLRt6iF
X-Proofpoint-ORIG-GUID: VHyFAhd4gSNXq1GDcCsjqFiJ2ZLRt6iF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_03,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310059

The command 'perf stat -e pai_crypto/CRYPTO_ALL/ -- <command>
crashes the kernel when CPUs are hotplug added during that run.

Root cause is the allocation of struct pai_mapptr at first
event initialization. The allocation is dynamic and the first
event that has task context creates such a structure for
each online CPU. This is not sufficient. CPUs may be offline
during event creation and can be set online during the
perf run time. For example commands

 # echo 0 > /sys/devices/system/cpu/cpu1/online
 # perf stat -e pai_crypto/CRYPTO_ALL/ -i -- stress-ng -t10s --matrix X
 # sleep 1
 # echo 1 > /sys/devices/system/cpu/cpu1/online

create an event for CPUs 0,2-X. Since the events are created with
task-context, the scheduler will eventually schedule the program
on CPU1. This CPU has not created and initialized any per
CPU event infrastructure as that CPU was not online at the time
of the perf invocation. Thus when the scheduler runs stress-ng
on CPU1, the function pai_add() refers to a NULL pointer:

 struct pai_mapptr *mp = this_cpu_ptr(pai_root[idx].mapptr);

This function call is invoked after the task stress-ng has been
made runnable on CPU1. And variable mp is a NULL pointer.
The result is a panic.

Allocate the necessary per CPU event handling infrastructure for all
possible CPUs, not just the ones currently online.

Fixes: 92ea686840ac ("s390/pai_crypto: Enable per-task counting event")
Cc: <Stable@vger.kernel.org> # v6.11+
Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
---
 arch/s390/kernel/perf_pai.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kernel/perf_pai.c b/arch/s390/kernel/perf_pai.c
index cdb8006220ca..793bda20df14 100644
--- a/arch/s390/kernel/perf_pai.c
+++ b/arch/s390/kernel/perf_pai.c
@@ -325,7 +325,7 @@ static int pai_alloc(struct perf_event *event)
 	if (!maskptr)
 		goto out;
 
-	for_each_online_cpu(cpu) {
+	for_each_possible_cpu(cpu) {
 		rc = pai_alloc_cpu(event, cpu);
 		if (rc) {
 			for_each_cpu(cpu, maskptr)
-- 
2.55.0

