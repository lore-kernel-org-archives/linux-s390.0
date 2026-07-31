Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22CE432BDE;
	Fri, 31 Jul 2026 13:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785503389; cv=none; b=usYSyXIMWbQH4FhdezlWrhZie85zeIqA2mX9rTwlLjJ14XjtIFpY4Rswd3Mm0OPXcOvdFtVqzgT8HvlnMFU+aBB8xkiBl3HjKEitoWrWwFgcxm1UhRHy6itxH2Jta+AUu1pnG5rGKQRjwbCGaCa0uAmVfS2Kemxbqo+SIqO3d2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785503389; c=relaxed/simple;
	bh=Pos6nmaUPNL3lxQa1N0CrZuoNDmpENnoUchtZV26rK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=otr826ufhTjSowt22xMUGleDq1Zno3BQ7qMZHRipCXADCWt0DTawHEDPy1kgeGpLrKlcdEh/qKPefTMrJZkKqoQAHaSKQ78yVjXlsU1wyXjtX3fNS3K2+sh48Q29ZmUzxy8RaturpbG0P0d2om3PUjJiVRZKbaiy0BHCMSTNnhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OLQOSbBO; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OLQOSbBO"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66VBm6QB1731999;
	Fri, 31 Jul 2026 13:09:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Zocp9/JW8snOJaLwF
	hMIVmepe7GtTtK1uYzpqfqDF+c=; b=OLQOSbBO3SyCtgVfdMs34Pr/cj/5Oru+i
	9p84jI6dE4tsqgexWx5auaSok8RWXSvmT4KHIGayB8BX8KkWzsfy7Ir5RHZdERi1
	y7GCND+naEF3mR0CWyr1Ih3xJQitA5vsHrdXRZmOW+xzhPH4bQix9GVf0GnOgBFa
	WvTUEO8qSGXznlmpjCU85x0rfJ2Y8MNtxoz7tRfbjbL66yR/XnUwxekAY0z0toHE
	0rY0QBHai4S2riuOISSgjkGNNCxern4OGIIzqVsmAoCt9f/zsn4/moykwkq14ZeB
	90u9yj9cxJ8GtDI+BKIsolsKRd/4boXn6pCxjmwn882iQV67z6mAw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuw7w4mg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 13:09:24 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66VCuI68012635;
	Fri, 31 Jul 2026 13:09:23 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8fkg08b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 13:09:22 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66VD9EEs32309542
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Jul 2026 13:09:14 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 500CD20040;
	Fri, 31 Jul 2026 13:09:14 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E298820043;
	Fri, 31 Jul 2026 13:09:13 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 31 Jul 2026 13:09:13 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
To: kvm@vger.kernel.org, kvmarm@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Andreas Grapentin <gra@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Friedrich Welter <fritz@linux.ibm.com>, Fuad Tabba <tabba@google.com>,
        Gautam Gala <ggala@linux.ibm.com>,
        Hariharan Mari <hari55@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, Joey Gouly <joey.gouly@arm.com>,
        Marc Zyngier <maz@kernel.org>, Nico Boehr <nrb@linux.ibm.com>,
        Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu>,
        Oliver Upton <oupton@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH v5 25/31] s390/hwcaps: Report SAE support as hwcap
Date: Fri, 31 Jul 2026 15:08:53 +0200
Message-ID: <20260731130902.654679-26-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260731130902.654679-1-seiden@linux.ibm.com>
References: <20260731130902.654679-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: yRsL3s7jocKRH7G7Ute6S3Xxu1VBu3bv
X-Proofpoint-ORIG-GUID: AcdARCuc8L7EJt5e9_PwsTOxk9j9WtGN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDA5NiBTYWx0ZWRfX3NKTKAiweY/I
 uR62reel/qsp0JqjMv1BzFLlopHYAW6zjqgyPAPI5g47xHFELr4w/HpjaUTL8FibSbOv18RkwMH
 uSugGgCYROsG+9xDP1HIBgc8fp07RixW0F6Hsycba4N79m7dlTQqsaULhOU0g6pMHrTiN+uNspX
 k6M1kFgv/GM5y8bxWP1xMyYYZOD0QNoTt43ddsEEWCxH85SIw20vd762yKSuTd9cFofNk4EI9yf
 svSE/HwRv4HncdgvPfe68gCp69Ccwe2FH8vwOATPi+GGFufY7F95OsirPVB8QHJ+0SyOp6qfgEv
 wuqxt5raWbYBhe9R/NghW4ExieqrIWstGd+ocG85w7g4K2/E6BbeMwwWONsuFGrXIMUuFgcHTGe
 FOl6ttfFSs7n3CPjcx0J99Ih8gszdga4Ah1NaAo1o/2zTbs8ou6yNcxqpKhcQd3x1sh9UUrwxuk
 cSWS0nw6/K1bQcMX0wg==
X-Authority-Analysis: v=2.4 cv=SKFykuvH c=1 sm=1 tr=0 ts=6a6c9e84 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=MMtvGDNtdIwsdepEW5QA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDA5NiBTYWx0ZWRfXyKKl41jsvbh/
 R03uUdRF5kQyVNx7CUG2LEEQMX9cYooIBPb0HQBAnW7blf+86bxTmnJazBf/Qf7/0nxlUyE00kG
 CP+Kern7T7mowbytgwVwyOWc8KdgQ98=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607310096

From: Hendrik Brueckner <brueckner@linux.ibm.com>

Report SAE support as hwcap (and /proc/cpuinfo)

Signed-off-by: Hendrik Brueckner <brueckner@linux.ibm.com>
Reviewed-by: Steffen Eiden <seiden@linux.ibm.com>
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
---
 arch/s390/include/asm/elf.h    | 2 ++
 arch/s390/include/asm/sclp.h   | 5 ++++-
 arch/s390/kernel/processor.c   | 3 +++
 drivers/s390/char/sclp_early.c | 1 +
 4 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/s390/include/asm/elf.h b/arch/s390/include/asm/elf.h
index bb63fa4d20bb..ad3108ecfb07 100644
--- a/arch/s390/include/asm/elf.h
+++ b/arch/s390/include/asm/elf.h
@@ -123,6 +123,7 @@ enum {
 	HWCAP_NR_NNPA		= 20,
 	HWCAP_NR_PCI_MIO	= 21,
 	HWCAP_NR_SIE		= 22,
+	HWCAP_NR_SAE		= 23,
 	HWCAP_NR_MAX
 };
 
@@ -150,6 +151,7 @@ enum {
 #define HWCAP_NNPA		BIT(HWCAP_NR_NNPA)
 #define HWCAP_PCI_MIO		BIT(HWCAP_NR_PCI_MIO)
 #define HWCAP_SIE		BIT(HWCAP_NR_SIE)
+#define HWCAP_SAE		BIT(HWCAP_NR_SAE)
 
 /*
  * These are used to set parameters in the core dumps.
diff --git a/arch/s390/include/asm/sclp.h b/arch/s390/include/asm/sclp.h
index f2d490558054..f669569cf78d 100644
--- a/arch/s390/include/asm/sclp.h
+++ b/arch/s390/include/asm/sclp.h
@@ -53,7 +53,9 @@ struct sclp_core_entry {
 	u8 siif : 1;
 	u8 sigpif : 1;
 	u8 : 3;
-	u8 reserved2[3];
+	u8 aef: 1;
+	u8 : 7;
+	u8 reserved2[2];
 	u8 : 2;
 	u8 ib : 1;
 	u8 cei : 1;
@@ -106,6 +108,7 @@ struct sclp_info {
 	unsigned char has_aeni : 1;
 	unsigned char has_aisi : 1;
 	unsigned char has_astfleie2 : 1;
+	unsigned char has_aef : 1;
 	unsigned int ibc;
 	unsigned int mtid;
 	unsigned int mtid_cp;
diff --git a/arch/s390/kernel/processor.c b/arch/s390/kernel/processor.c
index e33a3eccda56..6da55a158027 100644
--- a/arch/s390/kernel/processor.c
+++ b/arch/s390/kernel/processor.c
@@ -150,6 +150,7 @@ static void show_cpu_summary(struct seq_file *m, void *v)
 		[HWCAP_NR_NNPA]		= "nnpa",
 		[HWCAP_NR_PCI_MIO]	= "pcimio",
 		[HWCAP_NR_SIE]		= "sie",
+		[HWCAP_NR_SAE]		= "sae",
 	};
 	int i, cpu;
 
@@ -254,6 +255,8 @@ static int __init setup_hwcaps(void)
 	/* virtualization support */
 	if (sclp.has_sief2)
 		elf_hwcap |= HWCAP_SIE;
+	if (sclp.has_aef)
+		elf_hwcap |= HWCAP_SAE;
 
 	return 0;
 }
diff --git a/drivers/s390/char/sclp_early.c b/drivers/s390/char/sclp_early.c
index 22dd797e6229..e58d24b95bd1 100644
--- a/drivers/s390/char/sclp_early.c
+++ b/drivers/s390/char/sclp_early.c
@@ -96,6 +96,7 @@ static void __init sclp_early_facilities_detect(void)
 		sclp.has_ib = cpue->ib;
 		sclp.has_cei = cpue->cei;
 		sclp.has_skey = cpue->skey;
+		sclp.has_aef = cpue->aef;
 		break;
 	}
 
-- 
2.53.0

