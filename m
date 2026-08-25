Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650CD3FB06D
	for <linux-s390@vger.kernel.org>; Tue, 25 Aug 2026 12:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787662721; cv=none; b=MwKGttDusgD2uFwm434hB/bYSzNjfxr8hfRbodUEfPL8Ek/kl160rV2hNoJjG96pOkn/aqrHSiWKMq1ddP3wcnRTJHXpqXgw3eFvazT3H9Ptib1JWY1/0wdx6M3xcYn5VkyR/JdhVjrG7zH9L2x2BSiW6ZE42Ne34ht4Fsg8VrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787662721; c=relaxed/simple;
	bh=XIRuiuN8kFvBaFeARLCSaLobkYk84dQWc2hvELklDfw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=uAGEYHdJmnNSwUUTH0RvrZPBnSSPhZi7REbdEURRr+yddhAao7fLA9dOERhgNqWYYq52qC0xk65OyXZ1NQUYaFiq8QcAeROhMW6kO9kARLyJJ+ljoph4gZxE0eXI2sugBa6GLhCu853SKCgvpH13iAAY+eYrYGfyupgvaoLkjus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TSXuTGeX; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TSXuTGeX"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67PB1gee542709
	for <linux-s390@vger.kernel.org>; Tue, 25 Aug 2026 12:58:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=rcbNC/gF3c1mBiCINVb9KTQrczFS
	B2MKUTnFb24/I9o=; b=TSXuTGeXmgBBxbFDEhqSpGSHdHKtYJomu2ev7jP6VmEn
	H1IdwqKu3Sw8oTrJyKVL96VN+3bLImTQ4MbcERL3r8WbmMZFi49Np/Xhm0aLhQEa
	EQ3g+ifPFk4zaQONICNtS5vn99i3P3CKSHn1pXh1qQrFsUFBYP/ipP7R73VUZSK9
	Y0wsf3Ib0rAv4o2WAbHD7cLWCJdQS+SiedJCAr+NGQq96vHknseFoDuAiROYCvb2
	eW9gvF5OEDpULGrb5keFAvgmo5qV+2qH4pLPLVwxjhpWmfzrZjpDu6lFxGiWsdAv
	YqSn54AeN/es5NMFUXfSKZqGF2oYaPkiTblmf0tCgw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g716hrc5q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 25 Aug 2026 12:58:38 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67PCfL8Z014542
	for <linux-s390@vger.kernel.org>; Tue, 25 Aug 2026 12:58:38 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7q3jva1d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 25 Aug 2026 12:58:38 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67PCwYnJ49086840
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Aug 2026 12:58:34 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0539F2004E;
	Tue, 25 Aug 2026 12:58:34 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B13742004D;
	Tue, 25 Aug 2026 12:58:33 +0000 (GMT)
Received: from [192.168.2.169] (unknown [9.111.67.90])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 25 Aug 2026 12:58:33 +0000 (GMT)
From: Mete Durlu <meted@linux.ibm.com>
Date: Tue, 25 Aug 2026 14:58:20 +0200
Subject: [PATCH] s390/topology: Switch to common cpu capacity code
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-common_capacity-v1-1-1cdfa3ad5e14@linux.ibm.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDCyNT3eT83Nz8vPjkxILE5MySSt3EVOO0JHMzM3MTyyQloK6CotS0zAq
 widGxtbUA2D7FtGEAAAA=
X-Change-ID: 20260825-common_capacity-ae3fb766749b
To: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, Mete Durlu <meted@linux.ibm.com>
X-Mailer: b4 0.14.3
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDEwNiBTYWx0ZWRfXwmEwJDlimkBX
 eY/o7YxIojbg+CJA5hHq2NETtS8eu4spZTfoEdwnHPATJH0m5roRQ1fFXcwPz1BynpRO8ujVf8X
 6yAQxtqTjETF1iupXi0WseEtky6WQrA=
X-Proofpoint-GUID: q9XITGQf7ckmRCKHpjvrKJ4BGwODOcZ_
X-Proofpoint-ORIG-GUID: q9XITGQf7ckmRCKHpjvrKJ4BGwODOcZ_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDEwNiBTYWx0ZWRfXyHjjKP2VsFhs
 aJvU6YirunmjW4183md2Ch/Ji8tgbiUbcWKf1mDblCcVubyKW7rElj0oiCfXTK9cMD7rVlO87qI
 tIlpN4vIiaQ7vloQLUwKlzk4ySg0bc78/T+OYLqRtpC1cBawEymCHub7q1W7wuZnMxyDEFawiqM
 gTtqMC6SB6xke4Jvet6nWziGw/p/t0a2/XXQcQC4kUK03QrdMLHS/TvoAni86IMgFXrZcGkpK6w
 zxnLz8NIPioReCppSJnkSU4WIA52yLko7C/5X4ZVAJWKpJGCpVeN32es5bJBqbreREpMKUigd3p
 +D7z34ygSZuROCBowNWbq0uFF+Hhum4+d/p4/rWue86Td1N8uCzkwsqzlAprohP1A9J3PaG7HtR
 qShCitQo/CrWzFnnxoJgCobnxP2kK0FYYTii3xaSgN0irlKrByehgZn6cQQZXBh1oKJq1+epGB0
 026gYW1eA5HlJxIcsOw==
X-Authority-Analysis: v=2.4 cv=H7brBeYi c=1 sm=1 tr=0 ts=6a8d917e cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=46jTwGdD1nV7OPauSF8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_03,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608250106

s390 implementation of cpu capacity management infrastructure code does
not do anything different than its common code counterpart. Switch to
common code functions and remove the smp_cpu_*_capacity() functions.
Make s390 code better align with other architectures which utilize
cpu_capacity. No functional changes.

Allow cpu_capacity attributes inside sysfs to accurately reflect cpu
capacity.
ex:

$ cat /sys/devices/system/cpu/cpu0/polarization
vertical:high
$ cat /sys/devices/system/cpu/cpu0/cpu_capacity
1024

$ cat /sys/devices/system/cpu/cpu40/polarization
vertical:low
$ cat /sys/devices/system/cpu/cpu40/cpu_capacity
128

Prior to commit 6bceea7a1e07 ("arch_topology: Relocate cpu_scale to
topology.[h|c]") cpu_capacity attribute was only available to the common
arch_topology driver's users. Reflect the correct values to the newly
made available attributes.

Signed-off-by: Mete Durlu <meted@linux.ibm.com>
---
 arch/s390/include/asm/processor.h |  1 -
 arch/s390/include/asm/smp.h       |  4 +---
 arch/s390/kernel/smp.c            | 16 +++-------------
 arch/s390/kernel/topology.c       |  2 +-
 4 files changed, 5 insertions(+), 18 deletions(-)

diff --git a/arch/s390/include/asm/processor.h b/arch/s390/include/asm/processor.h
index be8369115f6d..9434c76c25b8 100644
--- a/arch/s390/include/asm/processor.h
+++ b/arch/s390/include/asm/processor.h
@@ -46,7 +46,6 @@ struct pcpu {
 	unsigned long ec_mask;		/* bit mask for ec_xxx functions */
 	unsigned long ec_clk;		/* sigp timestamp for ec_xxx */
 	unsigned long flags;		/* per CPU flags */
-	unsigned long capacity;		/* cpu capacity for scheduler */
 	signed char state;		/* physical cpu state */
 	signed char polarization;	/* physical polarization */
 	u16 address;			/* physical cpu address */
diff --git a/arch/s390/include/asm/smp.h b/arch/s390/include/asm/smp.h
index fb2bdbf35da5..a6c621e0491c 100644
--- a/arch/s390/include/asm/smp.h
+++ b/arch/s390/include/asm/smp.h
@@ -30,7 +30,7 @@ static __always_inline unsigned int raw_smp_processor_id(void)
 	return cpu;
 }
 
-#define arch_scale_cpu_capacity smp_cpu_get_capacity
+#define arch_scale_cpu_capacity topology_get_cpu_scale
 
 extern struct mutex smp_cpu_state_mutex;
 extern unsigned int smp_cpu_mt_shift;
@@ -53,9 +53,7 @@ extern void smp_save_dump_secondary_cpus(void);
 extern void smp_yield_cpu(int cpu);
 extern void smp_cpu_set_polarization(int cpu, int val);
 extern int smp_cpu_get_polarization(int cpu);
-extern void smp_cpu_set_capacity(int cpu, unsigned long val);
 extern void smp_set_core_capacity(int cpu, unsigned long val);
-extern unsigned long smp_cpu_get_capacity(int cpu);
 extern int smp_cpu_get_cpu_address(int cpu);
 extern void smp_fill_possible_mask(void);
 extern void smp_detect_cpus(void);
diff --git a/arch/s390/kernel/smp.c b/arch/s390/kernel/smp.c
index 167c72803ccf..32499cad86f0 100644
--- a/arch/s390/kernel/smp.c
+++ b/arch/s390/kernel/smp.c
@@ -659,23 +659,13 @@ int smp_cpu_get_polarization(int cpu)
 	return per_cpu(pcpu_devices, cpu).polarization;
 }
 
-void smp_cpu_set_capacity(int cpu, unsigned long val)
-{
-	per_cpu(pcpu_devices, cpu).capacity = val;
-}
-
-unsigned long smp_cpu_get_capacity(int cpu)
-{
-	return per_cpu(pcpu_devices, cpu).capacity;
-}
-
 void smp_set_core_capacity(int cpu, unsigned long val)
 {
 	int i;
 
 	cpu = smp_get_base_cpu(cpu);
 	for (i = cpu; (i <= cpu + smp_cpu_mtid) && (i < nr_cpu_ids); i++)
-		smp_cpu_set_capacity(i, val);
+		topology_set_cpu_scale(i, val);
 }
 
 int smp_cpu_get_cpu_address(int cpu)
@@ -727,7 +717,7 @@ static int smp_add_core(struct sclp_core_entry *core, cpumask_t *avail,
 		else
 			pcpu->state = CPU_STATE_STANDBY;
 		smp_cpu_set_polarization(cpu, POLARIZATION_UNKNOWN);
-		smp_cpu_set_capacity(cpu, CPU_CAPACITY_HIGH);
+		topology_set_cpu_scale(cpu, CPU_CAPACITY_HIGH);
 		set_cpu_present(cpu, true);
 		if (!early && arch_register_cpu(cpu))
 			set_cpu_present(cpu, false);
@@ -967,7 +957,7 @@ void __init smp_prepare_boot_cpu(void)
 	ipl_pcpu->state = CPU_STATE_CONFIGURED;
 	lc->pcpu = (unsigned long)ipl_pcpu;
 	smp_cpu_set_polarization(0, POLARIZATION_UNKNOWN);
-	smp_cpu_set_capacity(0, CPU_CAPACITY_HIGH);
+	topology_set_cpu_scale(0, CPU_CAPACITY_HIGH);
 }
 
 void __init smp_setup_processor_id(void)
diff --git a/arch/s390/kernel/topology.c b/arch/s390/kernel/topology.c
index 1377c6f3f670..42fc0294f543 100644
--- a/arch/s390/kernel/topology.c
+++ b/arch/s390/kernel/topology.c
@@ -147,7 +147,7 @@ static void add_cpus_to_mask(struct topology_core *tl_core,
 			cpumask_set_cpu(cpu, &book->mask);
 			cpumask_set_cpu(cpu, &socket->mask);
 			smp_cpu_set_polarization(cpu, tl_core->pp);
-			smp_cpu_set_capacity(cpu, CPU_CAPACITY_HIGH);
+			topology_set_cpu_scale(cpu, CPU_CAPACITY_HIGH);
 		}
 	}
 }

---
base-commit: 66498c75b4f8017f62d720d9b59675bdf3abce91
change-id: 20260825-common_capacity-ae3fb766749b

Best regards,
-- 
Mete Durlu <meted@linux.ibm.com>

