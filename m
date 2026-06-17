Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47812C21F0
	for <linux-s390@vger.kernel.org>; Wed, 17 Jun 2026 14:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781708001; cv=none; b=tmIjNN3UbyftsUfJe01GNj9AthNbf+hIiMKQZ0qv8sOeGPQEYurgtFtfgw5n+jS9JlH3T3JLW7HOdcvLi2oCwKKSXYMhxEcciG96IiG/OoCw4N0wHT/VwSL0SUvDoYHrXRzmjBKDnMpI9mz4fq3YuyTQQlhV6FoJkW7ww4NaVHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781708001; c=relaxed/simple;
	bh=VE2WuZK60XFPPE8vSlyv01EjsmfAuNYtkvUsgqZyrYY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FoMBRR5owtc/+l0JrFfPoSgsejNXhWHqXFEy2shiEtuIBszP/oN9Mrjsu9cPcWHQ1EK4677NXsZxZyaFjsV7CY1ptR40yRS5mT18nQVNzvo1evKT60/ysEXrB0UDDdKC2QYkJpY+Irv2cYpiCi3uR1Iah+bGlwVxzs0YKpjnkbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=W1HKS/GU; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="W1HKS/GU"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65HEIA9r620448;
	Wed, 17 Jun 2026 14:53:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=q71M5eH24LqYQglyDMsIjrB5KdUc
	Bmmzf/Z1y1nApjc=; b=W1HKS/GUF/mTsLwDcKAc9ZAxhvD7yffpQZDQJ/6ooddT
	92aQgvFV4mHDNFA51/60VT/6l8VJ1gnUikW2kCCbFVHi4hqmW33ouEbKbDDSrUwi
	rkyVDY4ASMAEKR244ruGNUFFLB6DKK9pgI4UrGXbjO5+8dOxM7xlYfDBT9Xy+7nc
	m6O3T6M4Fuxp/aXUvev6Q26EhdHNU/U2R9awk0kGlhqCS6kUk5eBCOmLMUzxFyHp
	mlnDgcOF3oHogUoDXTMdkiub5PF16zklboO4KoOjPrVgJEqfkuOH1NPkTf5GFU1z
	do4T3G/OC4CzV5Yc+oaH6KFa6oF3rE12NEzwWgYo3g==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eueqvugdb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jun 2026 14:53:18 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65HEYo8O006804;
	Wed, 17 Jun 2026 14:53:17 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4eudvakmr3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jun 2026 14:53:17 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65HErE4E52691340
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jun 2026 14:53:14 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1B4C320043;
	Wed, 17 Jun 2026 14:53:14 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F004620040;
	Wed, 17 Jun 2026 14:53:13 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 17 Jun 2026 14:53:13 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
        linux-s390@vger.kernel.org
Subject: [PATCH -next] s390/idle: Add missing EXPORT_SYMBOL()
Date: Wed, 17 Jun 2026 16:53:13 +0200
Message-ID: <20260617145313.3910957-1-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDE0MiBTYWx0ZWRfX7pbJvKixk++W
 er7bixlKv3Ubj5dq50qstXC6kD8wEpDx51A8ufQSjBVZkMuqqIzqxBRiGzBdqztaZMIQ+E+J8ZZ
 fK/mS41gMtqlYKuat7uAh4jpfd4kh2s=
X-Proofpoint-GUID: PavxfHygcJB0zTfd5zAwq7z-YC7wftow
X-Authority-Analysis: v=2.4 cv=bMgm5v+Z c=1 sm=1 tr=0 ts=6a32b4de cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=IpJZQVW2AAAA:8 a=VnNF1IyMAAAA:8 a=RVLRUwhf08bJU_LQLTAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-ORIG-GUID: PavxfHygcJB0zTfd5zAwq7z-YC7wftow
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDE0MiBTYWx0ZWRfX3wD7Z9gETEzP
 96p/A5RjFCzvCzjnyrbx3wae32fCJgDPS4x34nuIRkasKe+ZmZCqlASdy+tjtW5AH2W8EAhAoWT
 7k0l3ijB8TSftO6qJpal4rVLljo1SWng6T/F8cwKiG6uwlc+B9jD0vo7+3Lhp98d4gH4S/5OegQ
 +IeIwBNhFSGQ7ThM5LnFPPQ1kfEtkPs+colAulAWxMrf2BIGJ/LyfxlZksMTGHIoq6KfedIuR3B
 3mmgRKYo2pgzPnI56iuZ8RsFm/iWxQ8Qz20LLt09Oy8A39B9ln0t4dybXaBi8jvNvN/kv8c/Jm4
 yUGuPQsa+C02gWMDmJsWCUP6+TIOu+Zb55NHzOUzCIUQCU2QXXjYj7ns0HcQEspaRHPM9STBLOt
 Ve91jgLxXklYEfAUZUGDnSVfdNcmVkxBpmPktreMLRMYZYpeDJ0JhgpAObPHxUcVFq8SbWuwjdb
 zjcJZUFitZeOQse5xPw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 priorityscore=1501 phishscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606170142

Uwe Kleine-König reported this build breakage caused by a recent commit
which provides arch specific kcpustat_field_idle()/kcpustat_field_iowait()
functions:

ERROR: modpost: "arch_kcpustat_field_idle" [drivers/leds/trigger/ledtrig-activity.ko] undefined!
ERROR: modpost: "arch_kcpustat_field_iowait" [drivers/leds/trigger/ledtrig-activity.ko] undefined!

Fix this by adding the missing EXPORT_SYMBOL().

Fixes: 670e057744e0 ("s390/idle: Provide arch specific kcpustat_field_idle()/kcpustat_field_iowait()")
Reported-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
Closes: https://lore.kernel.org/r/ajKsG0JP6qTssQBX@monoceros
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/kernel/idle.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/s390/kernel/idle.c b/arch/s390/kernel/idle.c
index 7f7851c001e0..6da8ee22a1d5 100644
--- a/arch/s390/kernel/idle.c
+++ b/arch/s390/kernel/idle.c
@@ -14,6 +14,7 @@
 #include <linux/init.h>
 #include <linux/cpu.h>
 #include <trace/events/power.h>
+#include <linux/export.h>
 #include <asm/cpu_mf.h>
 #include <asm/cputime.h>
 #include <asm/idle.h>
@@ -83,11 +84,13 @@ u64 arch_kcpustat_field_idle(int cpu)
 {
 	return arch_cpu_idle_time(cpu, CPUTIME_IDLE, !nr_iowait_cpu(cpu));
 }
+EXPORT_SYMBOL(arch_kcpustat_field_idle);
 
 u64 arch_kcpustat_field_iowait(int cpu)
 {
 	return arch_cpu_idle_time(cpu, CPUTIME_IOWAIT, nr_iowait_cpu(cpu));
 }
+EXPORT_SYMBOL(arch_kcpustat_field_iowait);
 
 void account_idle_time_irq(void)
 {
-- 
2.53.0

