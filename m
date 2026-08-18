Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C80F377558
	for <linux-s390@vger.kernel.org>; Tue, 18 Aug 2026 16:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787070287; cv=none; b=b74NuUjEVJvsD4nkjYk9IL0Xs+P3FlFjDRBPvpLyu9U1uKw0ygoPJhrHqbvk0VsRIADCckxjEZfg4AfWF6G1DzIKq9NYsRbcFSdPnGBoxjrC0BOyPX6OPSe56xqUA5JLMGWRGuJIH2mCz3oz+Z2VG1oCp3q9dMnob0Dm58IerWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787070287; c=relaxed/simple;
	bh=ZZWOVL8y3TaiImGmQvdq0ahw2oFgElS4OpjexRVVOfk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OQcuLK03DXFxA9A3IQZ0yU9R9kbGnKwWki3kPiROPf1+JK/rkDSTDmT87rAnzwh9+I0hDmuqIVXAbWSoXbWXt7wSEiRqVmCmPhfHncXhKFLaQPXbmjFTFedA5imnH9L3BAd3cpsXXqwDz+qP8+XND0uD2UFsWBnid4Nb2MeiHD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rmqbXWFa; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rmqbXWFa"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67IE3ko92831516
	for <linux-s390@vger.kernel.org>; Tue, 18 Aug 2026 16:24:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=5lhl/FV5TPRon2wQJDXGeErzEBMeFvHv80EYRWZwZ
	T4=; b=rmqbXWFas+l+iTooWXxS5NaScdIWfVSW0imM0DfD9WUL8J0tVmkfiv5Gp
	+XhcA8QBBzlt2UtVMC73uCTUTzeFdRnyV/qMcE2tIRoRQY7gOQIziuNDXqISl+Oi
	JGxSUtzkpDLAT08mZXNDF9psOKVTeTDOGehMBGgfQaPL/E23U5iIk/8fy2HH8mg9
	uRjNIuKsr7eoGqS1fw708M0gkRWOMdgYyuC8NTNnYSrfMJFAGzkR7y3MHDt0Q1Tl
	X9bZ07OgF9DIDg4l8u4ci0F7I+TEkozEwVH6c5GIazhWe7OdIbAJ9FM/Y3Ak/n8E
	i5TY28Fs5ImpbFovTDmuvlrD7+1jg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2fsqsdpe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 18 Aug 2026 16:24:45 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67IGBKa5015172
	for <linux-s390@vger.kernel.org>; Tue, 18 Aug 2026 16:24:44 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g34ngbyd7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 18 Aug 2026 16:24:44 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67IGObGA51970348
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Aug 2026 16:24:37 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BD31620043;
	Tue, 18 Aug 2026 16:24:37 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9EB4E20040;
	Tue, 18 Aug 2026 16:24:37 +0000 (GMT)
Received: from b315lp23.lnxne.boe (unknown [9.87.84.240])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 18 Aug 2026 16:24:37 +0000 (GMT)
From: Joseph Cathcart <josephc@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: eoin.mcnamara@ibm.com, iii@de.ibm.com,
        Joseph Cathcart <josephc@linux.ibm.com>
Subject: [PATCH v2] s390/iomem: register initrd as an iomem resource when retain_initrd is set
Date: Tue, 18 Aug 2026 18:24:36 +0200
Message-ID: <20260818162436.12383-1-josephc@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDExOCBTYWx0ZWRfX+J/6H1uondFC
 iw+wG7BLNbKtn3GHHdBszkqIgY0XZnj3fuZC6JFmSrt4bzemiKBAdz7DIwO6tNNTPtMKXORIy/7
 e/p66BtZ0v7BWMMNQdo4yjVlu5J2oc/BdrZr7L6uUib6VDyebVqZVJFNuhBCo/tfIcIcrLbuA/M
 9xi37dLdwQMaP9zq94Csvhwnd3oMj6nxrZJZzXJy54p7EZFbdhRHEghThj28b9DW1uTwOlQfAgi
 cMJwTDvTJHgMpJhfuv3+UHwjGqZchEqcXQBoJ43P70HkHyVMr4+i/dRQ9CAK8H5YD9W556rkdKW
 DxTiVpQ1Zz9BmMUzaPymSEORuMOLSzpv+3fjUUrT+I5CH9gLwRmKM3X8usa/mVznAWwcQNwMl4G
 dve4PKsHbe4JdbRgIEF+8txwHKxjSF6DLPNczgQxow6NMNlbpSu8qtHQmxMuMz3MiXwVcBzZz0M
 8B21aJJNcd92Tbmf2SQ==
X-Proofpoint-ORIG-GUID: YBqcV4-W-MIr3NtEJwOjMA_BZSjg8r6d
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDExOCBTYWx0ZWRfX2WBXGBwAnff9
 0TOT5LuIpLLIlZSRw/sMKtTvyLE4aUGfiy4j4nFU1GYNswUqBZxfw5JUv/03782lu1N0Cn9RHju
 MzBlkV/oWvxTiEAtNtSNMOP36zP9Ia4=
X-Authority-Analysis: v=2.4 cv=DJe/JSNb c=1 sm=1 tr=0 ts=6a84874d cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=kAqIDUJJv3-bWE_SvTMA:9
X-Proofpoint-GUID: YBqcV4-W-MIr3NtEJwOjMA_BZSjg8r6d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_02,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 spamscore=0 clxscore=1015 bulkscore=0
 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180118

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
index b60284328fe3..cd61e286628a 100644
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
 
+	if (strstr(boot_command_line, "retain_initrd"))
+		retain_initrd = true;
+	if (IS_ENABLED(CONFIG_BLK_DEV_INITRD) && retain_initrd) {
+		unsigned long initrd_addr, initrd_size;
+	
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
