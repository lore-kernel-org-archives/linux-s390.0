Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218DA47D458
	for <linux-s390@vger.kernel.org>; Tue, 18 Aug 2026 16:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787071156; cv=none; b=uH7UIJThpHxDnjzRUhH2oE7pr6HSI3f3e+D3pHj0Vu8jlUCMIr2daOeMgGtP+4NUIfePbhDM6l7MQKzDzPw1n0BpNBLOzU+woEcxCpgFe1oMX8EejMiuaCUzLkguNeU6trdLkWhHBWp7fo2BzS4bBrnbbUPkUdBfaJyhOkU1cWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787071156; c=relaxed/simple;
	bh=ytUDgpB2ABHnkmWsqfPem9i0VDyUyFkllyj7MeemYiw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CfjF7qtbgE1VeT4ZOfe0aERyaaSLSbNQxsa0+kIErukmmoH4d5amIRB8otbHgCzK2JszMNmW3dcffZLaS3GAXCjOuagITe7C6c6o9kqnkGICn6832nKZwsHiHlEpiYDQuR9Ak9zxpmardcJsIkHPP71Uz/2Lvh/vzC8fCcoYb+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RbPOKt4n; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RbPOKt4n"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67IE3evH455218
	for <linux-s390@vger.kernel.org>; Tue, 18 Aug 2026 16:39:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=CZV0abSICgTV1urwPf7doEfYRmLNI5GkJ6hAdef+r
	fk=; b=RbPOKt4nx3k5XuBd0T2L/PgAVXbuknr4zrbvYbdno5z+EPngLcU4pBhgU
	4hp9ybe57JyhRzSytcJIEX2Eb4j3BEFMLFUThjB4ZkNGlGEGUPGmuvqQdzEPNOc7
	oZx701FmxXf7Q41VgaGyGHprEYTXDUwfwdTzGIXDzc5OOCfEwc4hAYzHQqIjTJ3I
	+ltVVo9z87NtNzXK82N3pwjcUB7MKuQSh+7BWc0NwRYrPhybLj0y5uHQ1qXSYxB/
	zqaGWiIJs6y8fswtiisYs4ewtWRA/8DSt/cRWvS8KIDqXVFq/YrN/uNDRKk3esgt
	B0XGhGDJCVFGxSk/DF5UGY1xwVO9A==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2fm3sh0s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 18 Aug 2026 16:39:13 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67IGQOiE022448
	for <linux-s390@vger.kernel.org>; Tue, 18 Aug 2026 16:39:12 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33ek489w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 18 Aug 2026 16:39:12 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67IGd6Z450856418
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Aug 2026 16:39:06 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6403020043;
	Tue, 18 Aug 2026 16:39:06 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4688620040;
	Tue, 18 Aug 2026 16:39:06 +0000 (GMT)
Received: from b315lp23.lnxne.boe (unknown [9.87.84.240])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 18 Aug 2026 16:39:06 +0000 (GMT)
From: Joseph Cathcart <josephc@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: eoin.mcnamara@ibm.com, iii@de.ibm.com,
        Joseph Cathcart <josephc@linux.ibm.com>
Subject: [PATCH v3] s390/iomem: register initrd as an iomem resource when retain_initrd is set
Date: Tue, 18 Aug 2026 18:39:02 +0200
Message-ID: <20260818163902.14422-1-josephc@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: h6tjUmlZpt-hOD4Usi1WiL-ZEJ1zVd5R
X-Proofpoint-ORIG-GUID: h6tjUmlZpt-hOD4Usi1WiL-ZEJ1zVd5R
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDEyMiBTYWx0ZWRfX7RhP0WB8EULz
 /IYdpaPOQOLPAsML7cOqhg9cH9HPgNBR3WaqE25Zt14W6y73Hn4j81fzuZbYQqWlMevz+HMx2j3
 Lvn0BKLK9Q7JXB1caje30N5rYLvWtQ0=
X-Authority-Analysis: v=2.4 cv=WtQb99fv c=1 sm=1 tr=0 ts=6a848ab1 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=kAqIDUJJv3-bWE_SvTMA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDEyMiBTYWx0ZWRfXyK+d8G4+YYn/
 hPj2M2X54aIAo9fDPJ+Tz6IqhRk6O28ljr83TGLhVLRaKi5mu1Cr87lZBWwuoprP8Az1/HpSN5u
 la3G3TV+jZELUZAHD8JzGqwC6GXKokJCEawNTQblEh4z9dR+kQagAuKdhe1pJta5LyzP5/v2yRX
 YlgDXe9HQoJ327J7iK0y1mgMrF0WsdAoEMUZ12em5GT8x2X3Z+qzRANQs498FELwca7CdIXD5fB
 NlPEdPOxxCuU02E2WP0Glm10+WgaVFCZ8SCV5/O00Uf0wBzOi3o0eA+/AZ4wKx7KTI+8UfhLuVh
 zye7uNwPPpS7p7qd/I/q52tcX/UbqDdxtFEf5L0K0/rIi2Kbhf8sovyWF0KvyU8kGjsBF7iyq4A
 NDmBbd2/PGeH1PoOpUgWNwBKAhBinihxwIadQHvcmnZFYZwijGANDtTuWYltEYDCf2ZPPm4/8Ms
 i6+yZO4cQ61Kjf4a3eQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_02,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608180122

Currently, /proc/iomem contains no reference to initrd memory, even
when initrd is retained and still held in RAM. This makes the memory
ranges invisible from userspace, and unusable to programs such as
kexec. (A sysfs bin file is created for initrd, but this doesn't
help programs which need the explicit memory ranges)

Add initrd to standard_resources[] unconditionally. Add initrd as a
child of iomem_resources only if retain_initrd is specified.

strstr() could match substrings like "retain_initrd=0" or
"no_retain_initrd", but this is how PPC chose to check for
"retain_initrd" param too. (arch/powerpc/kexec/ranges.c)

Signed-off-by: Joseph Cathcart <josephc@linux.ibm.com>
---
 arch/s390/kernel/setup.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
index b60284328fe3..45b0e19bdab2 100644
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
@@ -501,6 +508,19 @@ static void __init setup_resources(void)
 	bss_resource.start = __pa_symbol(__bss_start);
 	bss_resource.end = __pa_symbol(__bss_stop) - 1;
 
+	if (IS_ENABLED(CONFIG_BLK_DEV_INITRD) && retain_initrd) {
+		unsigned long initrd_addr, initrd_size;
+	
+		if (strstr(boot_command_line, "retain_initrd"))
+			retain_initrd = true;
+		if (get_physmem_reserved(RR_INITRD, &initrd_addr, &initrd_size)) {
+			initrd_resource.start = initrd_addr;
+			initrd_resource.end = initrd_resource.start + initrd_size - 1;
+		} else {
+			retain_initrd = false;
+		}
+	}
+
 	for_each_mem_range(i, &start, &end) {
 		res = memblock_alloc_or_panic(sizeof(*res), 8);
 		res->flags = IORESOURCE_BUSY | IORESOURCE_SYSTEM_RAM;
@@ -517,6 +537,8 @@ static void __init setup_resources(void)
 
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
