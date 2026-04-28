Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06543C9ECF;
	Tue, 28 Apr 2026 16:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777392125; cv=none; b=LVLj0igx27oEQYIJMcCvX3Gqjv6aOeq6ZTbnydMlLw6yaygDxpZz0liZ9shXDeMiEti4+ySpBgfgKENEDprsA79lCBkpa/r+cpZW3bbEHcyLu0KWRU2aA3rj5Q5Fokpq8amaNyOT5aNFWLvDPaRZKZ2BZdvgEcP1nYGor/dKQOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777392125; c=relaxed/simple;
	bh=vOfb1Z8WWJXosJc9eTuRDjpxuWbt7lM7iVOCig2wEfc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XkNfw4Je8fJwo55ADUqFaRhBjA4inBZx9kTFYylt8xhzN6L/HV0q6h2hfnaMOFeFs/+z0shP69ZmYLNfc5sNB3XG6V8dguwrJkOdJUCV97MaTsKb9VMbMGIyXWKUQDp67ULg0zuBv1moO1E3hmzAK+KyBQry4Q1S4art4hKxJgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IXMXT5NL; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IXMXT5NL"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63S5herV3108202;
	Tue, 28 Apr 2026 15:56:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=pwrtGSKb3DiGnpal5
	1eSSw/8ReV7/MrJHHB/70Xx4MU=; b=IXMXT5NLE8QPz6y1nnyzPquZaynVspDuW
	iPEtQ53j3dghWeP6/g4/z81/U5Yf2m+ByuWT+jw/B3tDCF57LVNBmtCO9Z5xcgNi
	csR4yeZkCuCNMHsxS1MvLDIfU5EW6PaLZwziNLT0Keg8iyq1BzctTX6khCQDA4/Y
	TUl8YB72NatZYD+Ju2z2LWq7jreudQVp2RVuo86GMO5qodBfe+fvyLgNxrXRQbIn
	JrCTCFxfPcF+t0+Gbx385H6ZbBga91BfkeGukIAHZnAZhgBV6MJ9h6PYMvQwsCaV
	vUhGx0zDGmujyAtVkbMN7HfhvXEEyZqLR6xJMZrt94qd2b/mlwzMw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drn44pfb0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Apr 2026 15:56:36 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63SFrqdJ027883;
	Tue, 28 Apr 2026 15:56:35 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dsamya556-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Apr 2026 15:56:34 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63SFuVcs56885512
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Apr 2026 15:56:31 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4CCBA20040;
	Tue, 28 Apr 2026 15:56:31 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 031DF2004E;
	Tue, 28 Apr 2026 15:56:31 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 28 Apr 2026 15:56:30 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
To: kvm@vger.kernel.org, kvmarm@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Cc: Andreas Grapentin <gra@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Gautam Gala <ggala@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, Joey Gouly <joey.gouly@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu>,
        Oliver Upton <oupton@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Will Deacon <will@kernel.org>, Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH v2 22/28] s390/hwcaps: Report SAE support as hwcap
Date: Tue, 28 Apr 2026 17:56:14 +0200
Message-ID: <20260428155622.1361364-23-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260428155622.1361364-1-seiden@linux.ibm.com>
References: <20260428155622.1361364-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: a09jN-gS9E4C-tir1UrNyqu1AZvb6FWn
X-Authority-Analysis: v=2.4 cv=Ft81OWrq c=1 sm=1 tr=0 ts=69f0d8b4 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=MMtvGDNtdIwsdepEW5QA:9
X-Proofpoint-GUID: a09jN-gS9E4C-tir1UrNyqu1AZvb6FWn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDE1MSBTYWx0ZWRfX62W1If7z1zuW
 6X/PTU30r6mHqTOcftFywKe3lvTiK5mz11jafieV5cmVnPpeyVwOjYh7dzmC9zcAx3CoomzMCK8
 TmQgC+g9foCxAz+a7U2MRGismaaE2T9bMZQW5Ngd4YDoH4pOVW1y5RkOO8BA3yAm8PNSEKg1Ejp
 b4f8mYm5TgEoi3kC/HrfX8V2JTQAOCdKrsu8eKvvYeUTVN9MDz2tsg7MMi/aVfE7MzO3B0Smp0o
 winYP9hckElHR+XKeS4JzO4ER5GfM1sopoMqmnecav00XRmjCQZFlKvgk0gM5+VHxj4MKKRBPb4
 KuwbIr70/OrEP4elDV4C6e8iHlfptexVpFlFoqAXi5zQrpPJobMYr/AwWK06L+lX1Z9xZ+F8zHA
 5FlE6IMKPd/kw8g6KEKDZSt74CrmQaNegdBldbJZQQeKrdeOSz02CRDwBD1Ek5p+dUqM7HeKcki
 EYGtokbg/vL0Yg+rBeg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604280151

From: Hendrik Brueckner <brueckner@linux.ibm.com>

Report SAE support as hwcap (and /proc/cpuinfo)

Signed-off-by: Hendrik Brueckner <brueckner@linux.ibm.com>
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
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
index 0f184dbdbe5e..18e46654227a 100644
--- a/arch/s390/include/asm/sclp.h
+++ b/arch/s390/include/asm/sclp.h
@@ -52,7 +52,9 @@ struct sclp_core_entry {
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
@@ -104,6 +106,7 @@ struct sclp_info {
 	unsigned char has_aisii : 1;
 	unsigned char has_aeni : 1;
 	unsigned char has_aisi : 1;
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
index 6bf501ad8ff0..26a76f09b19a 100644
--- a/drivers/s390/char/sclp_early.c
+++ b/drivers/s390/char/sclp_early.c
@@ -94,6 +94,7 @@ static void __init sclp_early_facilities_detect(void)
 		sclp.has_ib = cpue->ib;
 		sclp.has_cei = cpue->cei;
 		sclp.has_skey = cpue->skey;
+		sclp.has_aef = cpue->aef;
 		break;
 	}
 
-- 
2.51.0

