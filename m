Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1135349CA;
	Wed, 30 Sep 2026 17:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790789726; cv=none; b=DdLsIK+KZA697E2tr0Z73klOyckEwU5bz7LQcilT+51VP46c7rEOvBuXq23a9v7o1NYQcR17hI45+Yeh0DjGfjvWtexnAumCqT9Wo66QF/qPC8fJsdG1v9VzRbAFaM6gOKOOMMpgOyjCzL3kKhgZBHrdSnXHZNY9nWtaWDoLNhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790789726; c=relaxed/simple;
	bh=+/CMTMEkTMja21AR+FFFCriDRuv5qmKcmI7OX1DIK6A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dARAlnJPbdUR0cVVVlnv/C5YXX6td9XlQ3GP7oM6ulBApO8TsuLurPIOmzLJGHlDzq8DPc6pl4ZJKq9hYNpjuynjMMEz5LyysLXF6dq7kDYwHYo0XzxjEDvhZ4v1Y5vG4Aimg+R6VGIS7XTD+Y/CkAMg0Tqtp8UA9eyiDL9RIxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=th1EkGkm; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="th1EkGkm"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68UE5NLZ3170675;
	Wed, 30 Sep 2026 17:34:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=LbUMLq4MLEQvzj/Lj
	kB+3g3DvnN8l3i6J8lufcGxFx8=; b=th1EkGkmUX/TuhgSz9LIlxGrFZ1Tc7LQG
	QLYQDWPlQYpDx3ve/tsEPgJBp9j2GYZSDJyfYSJPxojWsjdUW8PyTWq4EfRrz6jP
	bxxnbuotYEwNV4Kq6eO1k0btLmFoAZBLr9uF0AqVxirCBGe+reP2eY8RS0ST941G
	1A4yUGxj+LZdEmhs+G006SqpjqpUeLFfqTLZpKQ+tQR9NDkfOxZieU9ZqgBMACdl
	5AB9cR1busMHWNg7BworsTkNkcUeQrVWgOVJWn3/vDyRvcb6QuWGKfKStuFmeSvI
	jSc+ukOr6dVdYTfKJpskgILAekoeuQOfltWVw7BwaHeD3jgu7UTdQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5s5eh19-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 30 Sep 2026 17:34:58 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68UEI17l3569533;
	Wed, 30 Sep 2026 17:34:57 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h0xcsa670-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Sep 2026 17:34:57 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68UHYmtc36503854
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Sep 2026 17:34:48 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8B6B020049;
	Wed, 30 Sep 2026 17:34:48 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3CB542004D;
	Wed, 30 Sep 2026 17:34:48 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 30 Sep 2026 17:34:48 +0000 (GMT)
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
        Sean Christopherson <seanjc@google.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH v9 18/24] s390/hwcaps: Report SAE support as hwcap
Date: Wed, 30 Sep 2026 19:34:33 +0200
Message-ID: <20260930173441.66762-19-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930173441.66762-1-seiden@linux.ibm.com>
References: <20260930173441.66762-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA2OCBTYWx0ZWRfX92RE+/4pemds
 B4xMqAjDfroXObyCDgcBDPGh3bpnTdDRe1esIhSpaQZ9dfZjRzDhn9MD/p1wxkuwQYJVCY15D8+
 YeeFyJDktuI7N/zm6NrC5DoqLwArolg=
X-Authority-Analysis: v=2.4 cv=HJ5WhYtv c=1 sm=1 tr=0 ts=6abd4843 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=MMtvGDNtdIwsdepEW5QA:9
X-Proofpoint-GUID: b9ekAwtunJkge1FuSyNcce54BYbHrktu
X-Proofpoint-ORIG-GUID: B3ccF0ekupMMBfHHMcdEXxy0zWMcFzLq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA2OCBTYWx0ZWRfX/O+BFCu9JP37
 A4JzZygVbSVPPNIioNx9Kfwr3PXf0DpTqHn8bKOpwZyr4Mr8VhG8n1TSjtfHoXVmvQePJ0Vhsim
 kOHc8n4CVsM+lqhp5qtukFq/JIhKM5UYEGf+/V9AwgkKG+FnHAmOAClNlepPYOvd/uorNQ0/VX9
 WKhWY/zBZbtvuAJI0jevr76yFbNYPaclthZti6tCC8ReZPyFC8viNQUQs9xTWhEr6DopJ728Ipw
 uYS5ab9xIJe7kXzD49z6Bb15zr9ukpOLZhv5tzIwOEi3mWUKVD8+SPJy3c66cowNEJKS/NIklgk
 DClLH/bo+yhHJ2wgqJVru6Lh/H6/nI/h/ewhCMHTUE5ArH0TTyQaO9hcywMQDK29bo9zKlOw6av
 /+kRRP4TTmcHgqxog7piWzcs/q9iOJ9ab1hCRCiBRPBLzpHpk+65P7S5agoVEKz6908UGgMHUoV
 Ipj9nWvUTwJ87duGtMA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 spamscore=0 impostorscore=0 phishscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300068

From: Hendrik Brueckner <brueckner@linux.ibm.com>

Report SAE support as hwcap (and /proc/cpuinfo)

Signed-off-by: Hendrik Brueckner <brueckner@linux.ibm.com>
Reviewed-by: Steffen Eiden <seiden@linux.ibm.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
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
index 44066550b9b1..68f61b71a2d5 100644
--- a/arch/s390/include/asm/sclp.h
+++ b/arch/s390/include/asm/sclp.h
@@ -56,7 +56,9 @@ struct sclp_core_entry {
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
@@ -109,6 +111,7 @@ struct sclp_info {
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

