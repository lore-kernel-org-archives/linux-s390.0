Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794482488;
	b=x0mw8bfc7s7IMduw8F9PWuXGr9RHNeIMSJMQupSw8U7BfrK9tmBqO/4Xl9DsF63fyR0B
	 4mHi3cpwfcWw3RQiihc9q/fgAjbhyMQ83JTRqCwdOGsF1lZv7S8a4h5goP6mbEK/r4FLW
	 oX/XHHJy7Lp3KZ60ETVkzpIRKodrDn5zDMWxXNiK9ihSHPdMkbaHC/d/AM69uK+0D2ui5
	 BQMRO+yyRepS8Y4hMOqHf9BboulvbfEhRtGCqoMdA3hMD+ymn7BgQCkRxd1UtzDloGIOu
	 uxF8/gnrpda+LagWxmgnaFhvjrVmRJ3g27Ibc1IiJPgLrftx6mOgc7m4JYKGpc7daog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794482488;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=ZuZS0Q+xul1oPQxuMNPvqNTBiPzzWmk0cOi1Zcv5X8o=;
	b=Cxf32eKWjHFg03hlHHeps+rrzgQgMqRLMT8LIUB9p4tBq1fZ2MA++UDzM3jnBFSq64I1
	 FIpoa1p02yXURsZH/Sr3xNgr4lPeKL8Zn9ozND1xag4YaZ85CvCERsXdMSGzqYd64QjAM
	 +VWPknehsOcdB7vN7CXz9RcYbZi9vXHqKelBjkKc/el8587bZLljIzKk47omW5kPQrex7
	 L+izZSVKdt0rnXxU+FOT6/UOtE3LTTGL1ocXxXzFCy8cjIj081Kjv0r4EA3zvkCOOkx1z
	 KB+evrHOCYsjZP+rt2ps4snyebwx40C7a2oeSvKOu/YVbuhm8hgGxf3iTqI/ZtShFVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=dmHbUztD;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6218B60A261D;
	Thu, 12 Nov 2026 11:21:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6218B60A261D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=dmHbUztD
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC2iFGM2795612;
	Thu, 12 Nov 2026 11:21:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ZuZS0Q+xul1oPQxuM
	NPvqNTBiPzzWmk0cOi1Zcv5X8o=; b=dmHbUztD1ea3Cvve7WC6oZYyuQqB5cPGg
	+vacFnoSC/xeRXTRYKCovonb6BJQqxTEelrSkqtpl3dIq7kzH17KjbcmFI3y1F34
	c7RQ4FwzEKY5cb4IweefBjw2y5dbRsF7+1sZaJI+JeuXfgCLBTFQuLMsVeddBBcA
	peiKPw7oqeSLhYJgDhKB2insHri5kx2Fkf0T5EbjWNFXlopyaysMIjqJ6nndtBA+
	zQz9+ESyIBpahqIWPbqtAMpRTjZBMWXm4TOYqTlUbq/DQMkCAm0t9OzVRaGWbjsa
	6OFm6AY9wy9A/aDjPFCD+J8wPYSvWmiLIss25VqRO6rKYa/6ov0Ng==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hssdkxq5b-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 12 Nov 2026 11:21:10 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC8H4OB3146060;
	Thu, 12 Nov 2026 11:21:09 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hvd51x6xk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Nov 2026 11:21:09 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ACBL6Wf29294974
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Nov 2026 11:21:06 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0E54020043;
	Thu, 12 Nov 2026 11:21:06 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D6DAF2004E;
	Thu, 12 Nov 2026 11:21:05 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 12 Nov 2026 11:21:05 +0000 (GMT)
From: Mikhail Zaslonko <zaslonko@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <baoquan.he@linux.dev>, Mike Rapoport <rppt@kernel.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        Dave Young <ruirui.yang@linux.dev>, Jiri Bohac <jbohac@suse.cz>,
        Jonathan Corbet <corbet@lwn.net>, Usama Arif <usama.arif@linux.dev>,
        linux-s390@vger.kernel.org, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/8] s390/kexec: Pass crashkernel CMA ranges to the kdump kernel
Date: Thu, 12 Nov 2026 12:21:00 +0100
Message-ID: <20261112112105.1169118-4-zaslonko@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261112112105.1169118-1-zaslonko@linux.ibm.com>
References: <20261112112105.1169118-1-zaslonko@linux.ibm.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=POqaavqC c=1 sm=1 tr=0 ts=6af5a126 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=XvEJYhg04x5BklFTpm8A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA0NCBTYWx0ZWRfX4Y9oJcnT/c7m
 Ukri+P4ZBzEatQyvRdYa6qseCOsgZat/CrUFP2SggZy71XvBBjRoT0XO49AE3qZkpV3nba0d9fx
 ZHeGFCZnSZMBqeEgy2nic6B8j/QiMBAhxuC8/+I/97IDrSJ5bOim3plPdMpwH6N8daKg3OK06LF
 mxmqxhZK4SZamit4n0DJY6kM9FhRdiSDnTyx8YvJYFGThMN/oPfdRZeNHYbrEdD2kfHrWY/bTOZ
 cQYkhhdCclVPemnzzgcFvl7/N1y4vRjdatExDPyYG+Cr5VrgVIKQRt2JjmFNzZNI4SIaR+4QYV9
 32JRG17Rf+4BcpdhTs/Hehs+GAxV4sJLeCVzxtL0LaedEZ3EOkvrRBfpSdgKWvyYph0YHPYxysd
 xsEDjWFrOYR/P7WRx3T8PH7yrxPjNfg9g+ynP9sfiZLAWLpqBz0itOuqxsdD/KDY/f60p3WwkC3
 Z4y2yqZDxAnapm6k9gw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA0NCBTYWx0ZWRfXyLxTKuUBUVPb
 90l9MpJFA1YOeub4zifaJCTTwXJrqTgQ8dDMD7+OjIMfEyP8PjFNcrANwy/AawUn+dKp5DnVWB/
 wdZKx7KZ9dEJKsFxlWV0L4S42f5Btls=
X-Proofpoint-ORIG-GUID: GoYENiemKtDo_bWzETdPJXb8yUCCAmJt
X-Proofpoint-GUID: GoYENiemKtDo_bWzETdPJXb8yUCCAmJt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120044

Store the crashkernel CMA ranges in the parmarea of the kdump kernel,
next to oldmem_base and oldmem_size, when it is loaded with
kexec_file_load().

The ranges use 64 of the 72 bytes of pad1, which is enough for the four
ranges the generic code reserves at most. They are sorted by address
and unused entries are zero. Older kernels ignore pad1 and kernel images
have it zeroed, so old and new kernels still work together.

For kexec_load(), kexec-tools would have to fill in the ranges. It can
read them from /sys/kernel/kexec_crash_cma_ranges.

Co-developed-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>
---
 arch/s390/include/asm/setup.h         | 9 ++++++++-
 arch/s390/kernel/machine_kexec_file.c | 5 +++++
 arch/s390/kernel/setup.c              | 5 ++++-
 3 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/arch/s390/include/asm/setup.h b/arch/s390/include/asm/setup.h
index cbf60ade741d..7e992f3953b1 100644
--- a/arch/s390/include/asm/setup.h
+++ b/arch/s390/include/asm/setup.h
@@ -23,12 +23,18 @@
 #define STARTUP_KDUMP_OFFSET	0x10010
 
 #define LEGACY_COMMAND_LINE_SIZE	896
+#define CRASHK_CMA_ENTRIES	4
 
 #ifndef __ASSEMBLER__
 
 #include <asm/lowcore.h>
 #include <asm/types.h>
 
+struct crashk_cma_range {
+	unsigned long start;
+	unsigned long size;
+};
+
 struct parmarea {
 	unsigned long ipl_device;			/* 0x10400 */
 	unsigned long initrd_start;			/* 0x10408 */
@@ -37,7 +43,8 @@ struct parmarea {
 	unsigned long oldmem_size;			/* 0x10420 */
 	unsigned long kernel_version;			/* 0x10428 */
 	unsigned long max_command_line_size;		/* 0x10430 */
-	char pad1[0x10480-0x10438];			/* 0x10438 - 0x10480 */
+	struct crashk_cma_range crashk_cma[CRASHK_CMA_ENTRIES]; /* 0x10438 - 0x10478 */
+	char pad1[0x10480-0x10478];			/* 0x10478 - 0x10480 */
 	char command_line[COMMAND_LINE_SIZE];		/* 0x10480 */
 };
 
diff --git a/arch/s390/kernel/machine_kexec_file.c b/arch/s390/kernel/machine_kexec_file.c
index 6f0852d5a3a9..198e0d736aa0 100644
--- a/arch/s390/kernel/machine_kexec_file.c
+++ b/arch/s390/kernel/machine_kexec_file.c
@@ -282,6 +282,11 @@ void *kexec_file_add_components(struct kimage *image,
 	if (image->type == KEXEC_TYPE_CRASH) {
 		data.parm->oldmem_base = crashk_res.start;
 		data.parm->oldmem_size = crashk_res.end - crashk_res.start + 1;
+		BUILD_BUG_ON(ARRAY_SIZE(data.parm->crashk_cma) < CRASHK_CMA_RANGES_MAX);
+		for (int i = 0; i < crashk_cma_cnt; i++) {
+			data.parm->crashk_cma[i].start = crashk_cma_ranges[i].start;
+			data.parm->crashk_cma[i].size = range_len(&crashk_cma_ranges[i]);
+		}
 	}
 #endif
 
diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
index 0251bd35954a..3c1c66e6c281 100644
--- a/arch/s390/kernel/setup.c
+++ b/arch/s390/kernel/setup.c
@@ -663,8 +663,11 @@ static void __init reserve_crashkernel(void)
 	 * A kdump kernel is handed the CMA ranges of the crashed kernel
 	 * instead of reserving its own.
 	 */
-	if (!oldmem_data.start)
+	if (!oldmem_data.start) {
 		reserve_crashkernel_cma(cma_size);
+		/* the ranges are handed over in ascending order */
+		sort_range(crashk_cma_ranges, crashk_cma_cnt);
+	}
 #endif
 }
 
-- 
2.55.0

