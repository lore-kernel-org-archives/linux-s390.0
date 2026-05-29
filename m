Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C1F3DA7F5;
	Fri, 29 May 2026 15:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780070219; cv=none; b=Z30YEd1GQMVwnyY0iDb+f60W94ym1gmJaTX3XBEeefoPBHQcxholFhOWYlAsNxY/1q8XVlmeE9eafRJf0gNZKuRHqXpD60pSCISjKfiBjgj184qpK/5MNuivV09O+1Z7VckHNVf12NGi4XwvM+cWpBIAZ/GLcbT2mu6t6/F/3CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780070219; c=relaxed/simple;
	bh=Kjsr5tXV2TixyM/dq6YUT3Xky/CisxizSj98DM/4okU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H7jaVUJrae4oJPXroagKVROtU5B7gC/dNDLCah5ZEE/9ykFeCS5fLLo7puLDb0fDGPhd1HMG5WM8FTD4Ft7IZyiSeZI+LmzfMP+YUvfCLWe6J0EAQOV6W1oesJ2ndzSeZI3/dHtgoeYLDeDGQID4bWJWS2I5Xf6AlAXGow7gFCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=I0nhmUfo; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="I0nhmUfo"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64TF7d4s1468503;
	Fri, 29 May 2026 15:56:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=EQ2VuK7ZFaehrQoRt
	zvCBljTp7pTrarwgW+FNoWOdfE=; b=I0nhmUfo4LDAlEHf3BKf2nOYyI/Je41nO
	igFFNOwda9L57DJa/sMfVSmqDD4UOFrfl/ns1Zh7aMDpMZjElW1KxI7YenFnSe8z
	Fb0J0cDY2jam7h7Q+d0XffE/TGeD5gAoajRvPXWxuoOpxjdlb7wRThElrfMazEU4
	rRxqMoXJkMNd9+DnEvOGuwe7xIxbZuKL6Nf+8+0EYcmy21wFAEbtZQYJzNL5Unju
	ADp7xZZZKyOr62Nxctgy7CYUd2Y6sSm6u6bR3bYuwaOUYcJ3R2dq3OkehQTGoYhs
	UJgSSiyKiQafZ/d3CvYSedv63LAHsx1M6KXrA2WPhsrnYNA/w+J9g==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ee886mgjh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 15:56:18 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64TFs9LX029222;
	Fri, 29 May 2026 15:56:16 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4edjrbgks5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 15:56:16 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64TFu7tH50004440
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 May 2026 15:56:08 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DC33820040;
	Fri, 29 May 2026 15:56:07 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8EDCA2004B;
	Fri, 29 May 2026 15:56:07 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 29 May 2026 15:56:07 +0000 (GMT)
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
Subject: [PATCH v1 15/26] s390: Add functions to query arm guest time
Date: Fri, 29 May 2026 17:55:48 +0200
Message-ID: <20260529155601.2927240-16-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529155601.2927240-1-seiden@linux.ibm.com>
References: <20260529155601.2927240-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zh0j-2KLsmXGXQtSfEQu2miThfmIi10t
X-Authority-Analysis: v=2.4 cv=Z8Dc2nRA c=1 sm=1 tr=0 ts=6a19b722 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=Hmczd7efCeE0AqCQNNQA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDE1NiBTYWx0ZWRfXwHVnBeyemYoW
 TMg9EI8tQhju9p1KhbfdE08dbjeWDSJ8P5oJJCiJ6wup0bFIwxSCgUcFure2M36PZCTQfq3uWza
 /rakQn7/qjlP2ZWcpWwcSzwdDu8X3ZjU9x2f1jRQ/tUO0z7WV/z3OmJVfeIcDYlzHoRcx6kvtBy
 xko2J7N3LnkDLWTiPhbpDNrv32fDd54Uyw+3qAg77u75nfceFUzxGg6NzWAGAIVe1uILaJX7s8t
 2c6ZzWQNt87a5st8cZ70HkjrVKmT4Yudclhq+XCCJM8cdysaUAZDyZ7knZicepFWnTNU91xVR8v
 IvxIHaQCp2uIBqV/DSlDKKYwTygRUnNPObi27ULQ050OlaT7q6lSmpeQ8bBNEtViePN2hU4zg8Y
 6/trH9IAoFstnckcZfvfBy5a0DcodKx/3ocBxFacSrwjb0k4dJCcP+L+V10RobxUk5ID5yMl/aa
 94fQ/gYd6qQ0twv0o/g==
X-Proofpoint-ORIG-GUID: zh0j-2KLsmXGXQtSfEQu2miThfmIi10t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290156

Add functions to convert between ARM guest time (LSB0) and s390 host
time (MSB0) using new ptff function codes.

Co-developed-by: Nico Boehr <nrb@linux.ibm.com>
Signed-off-by: Nico Boehr <nrb@linux.ibm.com>
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/s390/include/asm/timex.h | 49 +++++++++++++++++++++++++++++++++++
 arch/s390/kernel/time.c       |  1 +
 arch/s390/kvm/arm64/arm.c     |  9 ++++++-
 3 files changed, 58 insertions(+), 1 deletion(-)

diff --git a/arch/s390/include/asm/timex.h b/arch/s390/include/asm/timex.h
index 49447b40f038..9ec22a28bbda 100644
--- a/arch/s390/include/asm/timex.h
+++ b/arch/s390/include/asm/timex.h
@@ -99,6 +99,8 @@ extern unsigned char ptff_function_mask[16];
 #define PTFF_QSI	0x02	/* query steering information */
 #define PTFF_QPT	0x03	/* query physical clock */
 #define PTFF_QUI	0x04	/* query UTC information */
+#define PTFF_QAGTO	0x10	/* query arm guest time offset */
+#define PTFF_QAGPT	0x11	/* query arm guest physical time offset */
 #define PTFF_ATO	0x40	/* adjust tod offset */
 #define PTFF_STO	0x41	/* set tod offset */
 #define PTFF_SFS	0x42	/* set fine steering rate */
@@ -136,6 +138,17 @@ struct ptff_qui {
 	unsigned int pad_0x5c[41];
 } __packed;
 
+/*
+ * Query Arm Guest Time
+ * used for:
+ *	- Query Arm Guest Time Offset
+ *	- Query Arm Guest Physical Time
+ */
+struct ptff_qagt {
+	u64 in;
+	u64 out;
+};
+
 /*
  * ptff - Perform timing facility function
  * @ptff_block: Pointer to ptff parameter block
@@ -286,4 +299,40 @@ static inline int tod_after_eq(unsigned long a, unsigned long b)
 	return a >= b;
 }
 
+/*
+ * ptff_qagto() -  Query Arm Guest Time Offset
+ *
+ * @physical_time: Arm guest physical time in MSb 0
+ *
+ * Converts Arm guest physical time in MSb 0 bit ordering
+ * into the Arm guest offset in LSb 0 bit ordering.
+ *
+ * Return: Arm guest time offset in LSb 0
+ */
+static inline u64 ptff_qagto(u64 physical_time)
+{
+	struct ptff_qagt qagto = { .in = physical_time };
+
+	ptff(&qagto, sizeof(qagto), PTFF_QAGTO);
+	return qagto.out;
+}
+
+/*
+ * ptff_qagpt() - Query Arm Guest Physical Time
+ *
+ * @guest_time_offset: Arm guest time offset in MSb 0
+ *
+ * Converts Arm guest offset in MSb 0 bit ordering
+ * into the Arm guest physical time in LSb 0 bit ordering.
+ *
+ * Return: Arm guest physical time in LSb 0
+ * */
+static inline u64 ptff_qagpt(u64 guest_time_offset)
+{
+	struct ptff_qagt qagpt = { .in = guest_time_offset };
+
+	ptff(&qagpt, sizeof(qagpt), PTFF_QAGPT);
+	return qagpt.out;
+}
+
 #endif
diff --git a/arch/s390/kernel/time.c b/arch/s390/kernel/time.c
index bd0df61d1907..2b989bebd220 100644
--- a/arch/s390/kernel/time.c
+++ b/arch/s390/kernel/time.c
@@ -65,6 +65,7 @@ ATOMIC_NOTIFIER_HEAD(s390_epoch_delta_notifier);
 EXPORT_SYMBOL(s390_epoch_delta_notifier);
 
 unsigned char ptff_function_mask[16];
+EXPORT_SYMBOL(ptff_function_mask);
 
 static unsigned long lpar_offset;
 static unsigned long initial_leap_seconds;
diff --git a/arch/s390/kvm/arm64/arm.c b/arch/s390/kvm/arm64/arm.c
index bf0866659421..636bbeda98a8 100644
--- a/arch/s390/kvm/arm64/arm.c
+++ b/arch/s390/kvm/arm64/arm.c
@@ -692,8 +692,15 @@ long kvm_arch_vcpu_unlocked_ioctl(struct file *filp, unsigned int ioctl,
 
 static int __init kvm_s390_arm64_init(void)
 {
-	if (!sclp.has_aef)
+	if (!sclp.has_aef) {
+		pr_info("SAE is not available\n");
 		return -ENXIO;
+	}
+
+	if (!(ptff_query(PTFF_QAGTO) && ptff_query(PTFF_QAGPT))) {
+		pr_info("PTFF for arm on s390 is not available\n");
+		return -ENXIO;
+	}
 
 	return kvm_init_with_dev(sizeof(struct kvm_vcpu), 0, THIS_MODULE,
 				 KVM_DEV_NAME, MISC_DYNAMIC_MINOR);
-- 
2.53.0

