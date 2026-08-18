Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91EF3A6F04
	for <linux-s390@vger.kernel.org>; Tue, 18 Aug 2026 17:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787075907; cv=none; b=Py/IZjwH586cXPePok11nuC5YDO4R0nozQOACZ1tRaxMZB2UmH7pBq9YnMcAC6aeDhrKtRSWBQJFVkF2wyKyrOHnc1BCPuH3WacTwdDJZiyh+SEu50cWlcLk9fiMV/uR/h0fgbpEh8EI3Jw2MsY+ahIxEgQlPDz2qRxawmGrzx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787075907; c=relaxed/simple;
	bh=+RugMVnw5cLlXmUWVkMXnjl1AWFMvP1qfdZBXUENnvw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jeUpQw6LfMHW9NIA5KAC15EO79Zm40EbqLo8Y02s/j0MixFnfaxUaHdTGeDOsJEgBkQs+2aGU6ydwqRgYYlhHIplZEvj41bWy+XkuXRLgOS6xdltVqBfv5+fIB3an9F+gzvcHXEAoVpvAxrWKCKk19GHIYfa4MWNd9P9WJhdrJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tbpQ7G3o; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tbpQ7G3o"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67IHVr7P875362
	for <linux-s390@vger.kernel.org>; Tue, 18 Aug 2026 17:58:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=NKmTkg7pKnMbrQbLsFOHq/nhJ8d7rvOnbSOje6ZQb
	zI=; b=tbpQ7G3oqmuTVL8LnX5++lXpMkhHRIP10wI6KDAYTvMHb91gLmUZlnoOB
	50soHNt3tXHtxe4M2QEajNpjbdUqnF7mGJyKv4cAHFa2FeO6ZZnfRjQShD9tTBvE
	EMbCBvBL4vgW5JLtpCFrpZwgZEUvUbdx1BicwuK5CdfDgmQT+/e+ccDUtPJlBATo
	hIfQJbjb6J1O20sXp47qN0k+ajrvL+gwzGHPmJ3uH2hFC14fZgzikXtGrs1yC3i4
	BAfi21Ha4JQAcE82RkOX/mi+uHKkTPcOCbloSKBDyHI53F8zFUkcHmRsXS8VkVVk
	9XhGy9WlWctQ4USWpBo6qsf6PvcDw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2dhm1rcj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 18 Aug 2026 17:58:24 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67IHuM5N000988
	for <linux-s390@vger.kernel.org>; Tue, 18 Aug 2026 17:58:23 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g32eq4smj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 18 Aug 2026 17:58:23 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67IHwHcr34603488
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Aug 2026 17:58:17 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1789320040;
	Tue, 18 Aug 2026 17:58:17 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F3E2620043;
	Tue, 18 Aug 2026 17:58:16 +0000 (GMT)
Received: from b315lp23.lnxne.boe (unknown [9.87.84.240])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 18 Aug 2026 17:58:16 +0000 (GMT)
From: Joseph Cathcart <josephc@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: eoin.mcnamara@ibm.com, iii@de.ibm.com,
        Joseph Cathcart <josephc@linux.ibm.com>
Subject: [PATCH v4] s390/iomem: register initrd as an iomem resource when retain_initrd is set
Date: Tue, 18 Aug 2026 19:57:55 +0200
Message-ID: <20260818175755.3520-1-josephc@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDEyOSBTYWx0ZWRfXyJUsM8auUGkO
 sCvgVlq8Ug00JAM5bXCWsPCbazXXbsW0poUFCnmFVhpVkoyPTCDw+2lO15DuCOtVZkokROqRa43
 AeTdzN2jIlHdhvd6Fo2XhXhmj3/D/RSJKYcPWDEMUYn0afa5FaSejLBg0F7EhCGAWmFq6B/iHE8
 qMb7WCXRhUk81sTwXp+0rQ3K//OVdu2wFXwMkNVKm8F/I64kwryTz84aXIP/Li6Izpd+9SgmdIR
 4bh+JE9ILq4Kps8N9BpOL+FSDBK5JCxN/dRuN7nNJ1X9AICUljvq5sxY0q4FNhfp+/p1LVJlF4O
 SI7C0CSubOgfH9MadSDmetTJu+lEgIzAZjknFsr9LWGSYJJAKPpGI/+jd6k1y8b7/WC+ADYlhrK
 CeRav3+sm71ikAcWxvvwxV+sZ4B+52mEPEqWnIElKUYBOiaI7G8QlJ1Yj9iAFiCTRPCPHH0MjUI
 ZcrYsoGnQeQWJ4w5fWQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDEyOSBTYWx0ZWRfX4xKE/eyCcfzj
 3K/1JWeWM5d5yhk2cxOe1Pnw/dlBAymav6y1lnOLbuAszXMf1bJt7LKLrUURR7Zvgjbfch+U8Cc
 IZKpTJOSlHgjYrwV9NpcmzT/9tdue64=
X-Authority-Analysis: v=2.4 cv=JKkLdcKb c=1 sm=1 tr=0 ts=6a849d40 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=kAqIDUJJv3-bWE_SvTMA:9
X-Proofpoint-ORIG-GUID: gUK3N3d3l93tSZguPEK8IaDtqF2naQjA
X-Proofpoint-GUID: gUK3N3d3l93tSZguPEK8IaDtqF2naQjA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_03,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 adultscore=0 impostorscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608180129

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
index b60284328fe3..373e54ed7519 100644
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
 
+	if (IS_ENABLED(CONFIG_BLK_DEV_INITRD)) {
+		unsigned long initrd_addr, initrd_size;
+	
+		if (strstr(boot_command_line, "retain_initrd"))
+			retain_initrd = true;
+		if (retain_initrd && get_physmem_reserved(RR_INITRD, &initrd_addr, &initrd_size)) {
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
