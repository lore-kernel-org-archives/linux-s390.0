Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55711F16B
	for <linux-s390@vger.kernel.org>; Tue, 18 Aug 2026 15:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787067380; cv=none; b=XZtEv3gWWeNUlV7DpcLJaMoM/CA7hMUJ+MCcs+A0QPKZMpJt+DozH2isObb9IYH2J99gjQ8pPCREsBDloFQBFOUVrWeSrVCOMuIMcBg6YGK1auU6UAlF71x7ta8zqB/LSosfDCVIRR3IXzRDT7CeFsnTBoGC23jqXXkLEvzsQWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787067380; c=relaxed/simple;
	bh=VYgwwRl6DPU8Cjz8r7bSK2aL47WdQA55alGtRoWXjX0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DwfUQkAYYwVTXLWtL7uoxeK8msDp1E8q8iinCAu6cYFn2AgTlspmNQOjqfag92Be2jkqmuPzQYP+qOjVtKlxwo4Vz3JCgVhnhiULQ+CYOi4zGUC5OsiFgbChlY09R2mY7VqdtXh4kpGFl4MpnI5OIZTTRJ2iqXLWS5XUEWRZ6jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RdRC0QEJ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RdRC0QEJ"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67IE48mr402368
	for <linux-s390@vger.kernel.org>; Tue, 18 Aug 2026 15:36:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=qCH3Z1Kl04UQ1SE6GqN3xTkPSxReqyc9J/hEzfepc
	Hk=; b=RdRC0QEJaxnUs89UPUnhj088nChBUjKyfv0cbTdrpEuPkvZK3feylBIfU
	n9uR2uT+qocqpmo0NNRNA4QPctLCyPqY5cBQOoga8vIZ3k+JOWVJTU3+91e2JOl6
	Y/w/hXN8dSRW0py+wcscZA0fbfLues1kmY6IZODBgtrnCklk9Mb5xJt9MetvS24F
	TUeGw0EnU1j1F0kYQstDBNqk45SNMZknQYLN4spwVxtLYajDbTAY3G2Ufkpl2Xsg
	2dFCWdhDpZO5yVyZ+c122TOOgrVs1IofXTTV+qdeiHssnFCfLnbTV1wn06JvfnQE
	Qv5Ub479l+27Kiq0khwswEkH5yxbg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2dhm0ywc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 18 Aug 2026 15:36:17 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67IFQLNC009525
	for <linux-s390@vger.kernel.org>; Tue, 18 Aug 2026 15:36:16 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33ek3y1a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 18 Aug 2026 15:36:16 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67IFa8pl33751322
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Aug 2026 15:36:08 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5C7D32004B;
	Tue, 18 Aug 2026 15:36:08 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4120120043;
	Tue, 18 Aug 2026 15:36:08 +0000 (GMT)
Received: from b315lp23.lnxne.boe (unknown [9.87.84.240])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 18 Aug 2026 15:36:08 +0000 (GMT)
From: Joseph Cathcart <josephc@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: eoin.mcnamara@ibm.com, iii@de.ibm.com,
        Joseph Cathcart <josephc@linux.ibm.com>
Subject: [PATCH v1] s390/iomem: register initrd as an iomem resource when retain_initrd is set
Date: Tue, 18 Aug 2026 17:35:59 +0200
Message-ID: <20260818153559.5700-1-josephc@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDExNCBTYWx0ZWRfX83zsrzND16lG
 s8dj+tYM+9RCLXwZnXUs26oo7nVvgylJowcS+dks60r69OjXBckBxd0JbKkVWEwhzaHF8laIU/w
 Yqi+alff93htgAfO270ICnBliwvQ6jj2RvWTtmS319E8qcOLvHEFbSivqmjqi3Th6qnMQfDZJAc
 Mn7QgPWfZIwtq4JEoLgQKUrCykMmLOAZuuMkcr/xMcnBi7WNuII/b/OKxkBlPKnr1XCbcAp7kPL
 ZiygJLCchb4z2cIrWtGWyWeMj64SZpol+Gp54m/68hzSfsZ9rWIs2OfHVXU0qdMt8/Heh4gl1p3
 d6g/YKWgjCBPqOQdQB5avbcACxD5+9khwWHoPth0hpGyqHEWZc+9JbrQjOJoBL6taqQ0saXem9v
 acn1QjtkbQxl5lOBFBbtadC/XVm2A/0IxkMVvchOzeae5fWbkFN61paDHGSW+xOpbkIzNA1H2Al
 O80E2O9BPhNBZQozQTQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDExNCBTYWx0ZWRfX8I2q5Y5okbn8
 k0Kz1wTfRN/ZIWEltHesolnXMPUeWIROB0OPjZ3T8aAxt7c4u1ZdxeY99y5qPR1DwIcKehByAT3
 29PELGtPU57lYjSfW5qUVEFpOMH3bL8=
X-Authority-Analysis: v=2.4 cv=JKkLdcKb c=1 sm=1 tr=0 ts=6a847bf1 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=kAqIDUJJv3-bWE_SvTMA:9
X-Proofpoint-ORIG-GUID: CdyBrsNHZyiPBthTgjoH6v26R5WVnt0h
X-Proofpoint-GUID: CdyBrsNHZyiPBthTgjoH6v26R5WVnt0h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_02,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1011 adultscore=0 impostorscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608180114

Currently, /proc/iomem contains no reference to initrd memory, even
when initrd is retained and still held in RAM. This makes the memory
ranges invisible from userspace, and unusable to programs such as
kexec. (A sysfs bin file is created for initrd, but this doesn't
help programs which need the explicit memory ranges)

Add initrd to standard_resources[] unconditionally. Add initrd as a
child of iomem_resources only if retain_initrd is specified.

Signed-off-by: Joseph Cathcart <josephc@linux.ibm.com>
---
 arch/s390/kernel/setup.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
index b60284328fe3..a3c57ff40bf8 100644
--- a/arch/s390/kernel/setup.c
+++ b/arch/s390/kernel/setup.c
@@ -481,15 +481,22 @@ static struct resource bss_resource = {
 	.flags = IORESOURCE_BUSY | IORESOURCE_SYSTEM_RAM,
 };
 
+static struct resource initrd_resource = {
+	.name = "initrd",
+	.flags = IORESOURCE_BUSY | IORESOURCE_SYSTEM_RAM,
+};
+
 static struct resource __initdata *standard_resources[] = {
 	&code_resource,
 	&data_resource,
 	&bss_resource,
+	&initrd_resource,
 };
 
 static void __init setup_resources(void)
 {
 	struct resource *res, *std_res, *sub_res;
+	bool retain_initrd = false;
 	phys_addr_t start, end;
 	int j;
 	u64 i;
@@ -501,6 +508,17 @@ static void __init setup_resources(void)
 	bss_resource.start = __pa_symbol(__bss_start);
 	bss_resource.end = __pa_symbol(__bss_stop) - 1;
 
+	if (strstr(boot_command_line, "retain_initrd"))
+		retain_initrd = true;
+	if (IS_ENABLED(CONFIG_BLK_DEV_INITRD) && retain_initrd) {
+		unsigned long initrd_addr, initrd_size;
+	
+		if (get_physmem_reserved(RR_INITRD, &initrd_addr, &initrd_size)) {
+			initrd_resource.start = initrd_addr;
+			initrd_resource.end = initrd_resource.start + initrd_size - 1;
+		}
+	}
+
 	for_each_mem_range(i, &start, &end) {
 		res = memblock_alloc_or_panic(sizeof(*res), 8);
 		res->flags = IORESOURCE_BUSY | IORESOURCE_SYSTEM_RAM;
@@ -517,6 +535,8 @@ static void __init setup_resources(void)
 
 		for (j = 0; j < ARRAY_SIZE(standard_resources); j++) {
 			std_res = standard_resources[j];
+			if (std_res == &initrd_resource && !retain_initrd)
+				continue;
 			if (std_res->start < res->start ||
 			    std_res->start > res->end)
 				continue;
-- 
2.55.0

base commit: 0f23d56f17fdfc7db69d51f64c8b91bbab947aa9
