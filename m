Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218EB44E025;
	Mon,  6 Jul 2026 08:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783327999; cv=none; b=iXS5eV3gsBWXlfZjjx972qIEaj3RuUvBZMB4ltq8HFbRh/Tc92QwOkcqyFiP/XO6bN7Mf/ITibr1RApzho+jXGOhUTYXcXaohVSA+ruX9pm8tQitvt8VmEkxdzl4rbBHCvT8keFN6IeY3ZevQ+aiHfDccDTlop54T93+YrDGjPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783327999; c=relaxed/simple;
	bh=2r2DEUNdXBCAwZauEQVx6igBv4Bxu5eML3iKvYPDsrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c2AJJGs5Awdp0/bPFifxjGxQSY8fRY+XNehODkMVim7r4eVKqS+LR8bj1A5YtPatPGvzu/cioSVffnuBNpJZNY7Zaodbbuy4ycEb5PCjuaSI8vTzYaxtZ3MnGAFQ8065HOFnODFtcl9P1p+TnueU9DahXPWlK04AlwblNLxs3cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WmLoeCSv; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WmLoeCSv"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 665MIY6L1515286;
	Mon, 6 Jul 2026 08:52:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=37O/GVmlQ7WUeZfOl
	uuAeNU/TKXRrGR3niG0ZdI4IQU=; b=WmLoeCSvlh9obQPBwOXeOFA1+qEV8VO6E
	kDlMKQ2ECl+VODa1bd0H4lWF4ZLOAq2jFKGum7BoVZW0uFRyT6nJfCcGCa/M8jyJ
	/9NRDeDrKVm2ZL9h4zRZNur7VMtA0hT4FsxKi4ZtuYXxEZU7jWWMV7BathzEbae5
	r7CeTv8HPB1bnLys+n2mO4qYuJ2usxip7LpzzRuC1SMvqhPu29rQac764wjlK5+w
	8IzwIzrBnZhZD6UTuMdNJ8WlH8q5Ki+PYjoqGmoprN5K6rtcvB+jcja3jPVY169E
	VOJQGOtoRIPYGOERE9lQsRxXTkl1C12uQaC1V2ekb6mZtF/vPOziA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6rkdh6vm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 08:52:46 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6668nm6c022915;
	Mon, 6 Jul 2026 08:52:45 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7e0h4qe0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 08:52:45 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6668qcE114811560
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Jul 2026 08:52:39 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CDFA420040;
	Mon,  6 Jul 2026 08:52:38 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 735B52004B;
	Mon,  6 Jul 2026 08:52:38 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  6 Jul 2026 08:52:38 +0000 (GMT)
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
        Friedrich Welter <fritz@linux.ibm.com>,
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
Subject: [PATCH v4 21/27] s390/hwcaps: Report SAE support as hwcap
Date: Mon,  6 Jul 2026 10:52:21 +0200
Message-ID: <20260706085229.979525-22-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260706085229.979525-1-seiden@linux.ibm.com>
References: <20260706085229.979525-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=M7J97Sws c=1 sm=1 tr=0 ts=6a4b6cde cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=MMtvGDNtdIwsdepEW5QA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA4OCBTYWx0ZWRfX3LFzXaqOp2vI
 cxMzO2jfp5S8vn31VR+dzZ4VH8lwGtSmwdLIB5820AsD8yLKjtUknjpUeIxE3J024tEzIBx264W
 prM7jVHGWxqwK9ZK3sg6Cmk0n9iM5S82foWV/xicwd3ynJY6zYPy7slFEnBDI9X3AbHGtngJNHZ
 YRkcFtFvbwOmxe3BSYanx4meRoPit1BArcWyNEBTC4bie6G8c2nAG6VLzZDj+Artm+ZZ2kd2Xg3
 Ml3KmDJrZmrd/LK7HNbaQNdlCXP6SfdpSRNrH9MMdho8KtYmlo1yo0CxeFhGCUUhONrvPJGk4Vk
 rZTda45tYCsMlLLpe+5uLJrdylPrX64frElBVvG1xLV0ZlNipMcmYoYUXsRHF5nmcRMBubqGmwc
 2G27y1FgPzLpot/qjq/Dxp9CwzyKx6e5DbWUBJ5qOV/GRqYr1bGGrbUEHwILkt/vDOKRGeG5PQY
 Osmc91Kk+SzkjVzm4fg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA4OCBTYWx0ZWRfX9Ym6myaCWJG0
 Trm2rWmPmbay/soLvkSdnU9CcbzRtftSomOVfqLh8pNXSjM+0LCYmvgYnktbw9sNDbBag5GhcvA
 dBmYn+AXa/BuDLptrT+3kDIfn9Uf8BQ=
X-Proofpoint-GUID: 4Cyx8GMJTLOQKR5J7phq5SKoY35iq4Wb
X-Proofpoint-ORIG-GUID: 4Cyx8GMJTLOQKR5J7phq5SKoY35iq4Wb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015 adultscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060088

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

