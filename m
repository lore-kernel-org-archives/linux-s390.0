Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8646D3E63AE
	for <linux-s390@vger.kernel.org>; Tue,  6 Oct 2026 11:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791285209; cv=none; b=H8+IFA37Sv/4585Rz0FWCCbIfY9khaeWjp5HEf5vSzEh9Om6N9O9fSlRwKkV0vnosNxC5NLeVF3rxy7nmm04K0Aoi9ZLE5vnTbsv1yKsh3PP4laPm/nXXvlr33vOSBfEpINZ5H4Y7F7jQQZM+NQgFwmQOOZF8XS7gxMtl0askKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791285209; c=relaxed/simple;
	bh=hD6tSJJBqQwvh8xyW/RWx/bsvVjL5SjpOzMLFiY9VpI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sViHOrHsyyfxK6NfbAe7aVAh9UxCnQTfhJpbHd52nhTv7eheCalI4ysRpWw856Yo5/U9sgcjhHbC66qwZFQw1tJ6gBogPGU5nxIvzAO+EMIfqsk20XezE/JTNyNtnARQp56wF+APOya68P/1LYraALMNQoIDDPGED85+n2Xb0SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=f2v/5Twc; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="f2v/5Twc"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 696A646v3272706
	for <linux-s390@vger.kernel.org>; Tue, 6 Oct 2026 11:13:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=227KVzs76huXq4MlS
	VjaKvfFaRwf7E6KvNVXH2zs4SQ=; b=f2v/5TwcGAss8ry+MKl5+RGhqUEL2dZmw
	nVK7gUcS9tkXU1LayU/LKZwd1DmuIi505KPAmScQ1GgT1Z8k6spw+oU9RRsFNYvD
	zLc/Zepn0V5HfZMI9MuXdlRafY7UiEX3vYcQBEwB/yBgVElH+YR0iGAYR7C9QB4k
	5w9lG+ftEBwub30kaXPx7xPnGUhGQRFUUKRlFP6xsDKWX/XPvRMhVCYt7ekReykR
	LHOCZicY7jZ6UgmZ7/yJLBYoDIOm6c2q/P0OGxeP7b7KXJjW+UZoYXsfZk5Tdzs3
	5/WKOH5HiP26Ds52Y4hC1zCkwBQZW0N3NXXhH5HI/fw/H9XGjDCtA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2q4jq1yt-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 06 Oct 2026 11:13:26 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 696A6Irc108869
	for <linux-s390@vger.kernel.org>; Tue, 6 Oct 2026 11:13:25 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h3d1jsm4s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 06 Oct 2026 11:13:25 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 696BDJrd28508528
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 6 Oct 2026 11:13:19 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6D15A20040;
	Tue,  6 Oct 2026 11:13:19 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2F32A20043;
	Tue,  6 Oct 2026 11:13:19 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  6 Oct 2026 11:13:19 +0000 (GMT)
From: Sumanth Korikkar <sumanthk@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Jan Polensky <japo@linux.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>
Cc: sumanthk@linux.ibm.com
Subject: [PATCH 2/2] s390/cpum_cf: Honor hwctr session cpu mask during hotplug
Date: Tue,  6 Oct 2026 13:13:04 +0200
Message-ID: <20261006111304.4023017-3-sumanthk@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261006111304.4023017-1-sumanthk@linux.ibm.com>
References: <20261006111304.4023017-1-sumanthk@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Uy6U_RRVcG4Xs6jWyu73YnyNkxuGcB5C
X-Proofpoint-GUID: Uy6U_RRVcG4Xs6jWyu73YnyNkxuGcB5C
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDA0NCBTYWx0ZWRfX2TTo7nGvlCid
 AKZizWCk1EurzJoEeRHgxFSHFtkhjYQCbbw7Fe6P6xG04OQJqhPpHXU17//ju5KZc4LO3WO7xBg
 fpbHFY6lPcHhYCp46IYkzRlYNtPIMzE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDA0NCBTYWx0ZWRfXwAp/i5EWJ0Zk
 4igTInYVDE1/F+r04S0rRQp/7R/04lXVqig+X+VzaKShUWVlL+/TiMvyR6NR3RRaIusoRDXD8Eo
 7sguDRof2Y4PNi/Ca1GiN16L68F4PruuK5vkjEoTfi3OXna7/DpvZurmj0t5YXL49JvPoFNTjLU
 xFrgVatW9vPmfWiCnPb+HoeRm5a/DA79u1uAPcO1KXnPFAyyOyLuStBAnalD7q16yS0Xt8RCOQl
 EE9BXKTFdWu30ARYNs8Vcd+AIhDfG4tHs8cxDg01eSRntnb/mfMHpHZrcMQ7HRD5/ldQAXryjBm
 ZjEDOXzkdg1E/3zYKtqlBx3zT7YpgkN/pMAEUsuw3kJPwgSGfMch7v8x1mzdwpADFa0kAEP/z+w
 CeETozW/2EJp9G/DTZmej9PId3xOqdnN5QmtDz5E7im1dlfcN2Tsai+FmpHxPoBevwNcCkaqxq+
 vygOm6sO09p50MVEczw==
X-Authority-Analysis: v=2.4 cv=eYeo7LEH c=1 sm=1 tr=0 ts=6ac4d7d6 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=oSw9zORoKruouPY7b7YA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_03,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0 clxscore=1015
 spamscore=0 malwarescore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060044

cfset_online_cpu() and cfset_offline_cpu() cpu hotplug callbacks start
and stop counter sets for every active hwctr session without checking
the session cpu mask, and dynamically modify that mask on each hotplug
event.

For example, assume cpu0 and cpu1 are online and cpu2 is offline. Start
an hwctr session restricted to cpu0 and cpu1, and then bring cpu2 online:

lshwc -l 9999 -i 5 0-1:b
chcpu -e 2

Although cpu2 is not part of the requested mask, cfset_online_cpu()
starts the counter sets on cpu2 and adds it to the session mask. cpu2
can then appear in lshwc output (s390-tools) and is handled as part of
the session until it is stopped.

Keep the userspace provided cpu mask unchanged and update counter sets
only when the hotplugged cpu belongs to that mask. For all cpu requests,
lshwc should supply the possible cpu mask so that cpus coming online later
remain part of the session.

Note:
A corresponding lshwc (s390-tools) change is needed to supply the
possible cpu mask for allcpu sessions, ensuring that cpus coming online
later remain part of the session. Without it, newly online cpus would be
silently excluded from an active session.

Since this userspace change is not yet available, the patch is not
suitable for stable kernels and intentionally omits a Fixes: tag. The
prerequisite bug fix is in "s390/cpum_cf: Check session mask before cpu
offline".

Reported-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Signed-off-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
---
 arch/s390/kernel/perf_cpum_cf.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/arch/s390/kernel/perf_cpum_cf.c b/arch/s390/kernel/perf_cpum_cf.c
index 1d63dc3b0ab9..a2334af51544 100644
--- a/arch/s390/kernel/perf_cpum_cf.c
+++ b/arch/s390/kernel/perf_cpum_cf.c
@@ -1768,8 +1768,9 @@ static struct miscdevice cfset_dev = {
 	.mode	= 0666,
 };
 
-/* Hotplug add of a CPU. Scan through all active processes and add
- * that CPU to the list of CPUs supplied with ioctl(..., START, ...).
+/*
+ * Start counter sets on a newly online CPU for each active hwctr session that
+ * includes this CPU in its requested mask.
  */
 static int cfset_online_cpu(unsigned int cpu)
 {
@@ -1778,17 +1779,19 @@ static int cfset_online_cpu(unsigned int cpu)
 
 	if (!list_empty(&cfset_session.head)) {
 		list_for_each_entry(rp, &cfset_session.head, node) {
+			if (!cpumask_test_cpu(cpu, &rp->mask))
+				continue;
+
 			p.sets = rp->ctrset;
 			cfset_ioctl_on(&p);
-			cpumask_set_cpu(cpu, &rp->mask);
 		}
 	}
 	return 0;
 }
 
-/* Hotplug remove of a CPU. Scan through all active processes and clear
- * that CPU from the list of CPUs supplied with ioctl(..., START, ...).
- * Adjust reference counts.
+/*
+ * Stop counter sets on an outgoing CPU for each active hwctr session that
+ * includes this CPU in its requested mask.
  */
 static int cfset_offline_cpu(unsigned int cpu)
 {
@@ -1802,7 +1805,6 @@ static int cfset_offline_cpu(unsigned int cpu)
 
 			p.sets = rp->ctrset;
 			cfset_ioctl_off(&p);
-			cpumask_clear_cpu(cpu, &rp->mask);
 		}
 	}
 	return 0;
-- 
2.53.0

