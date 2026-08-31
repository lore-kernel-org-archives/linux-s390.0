Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5D73A5E87;
	Mon, 31 Aug 2026 14:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788188194; cv=none; b=jp0MFiw9DDM8EnG1Nd56oSCy6rj+WpNmrRAb1FnIPfH/ijq/oiQP1JjQ4VE3KWEc79BqpmjQqymzxVYiqVATS9r6W1Yf0PF5DdGJEVirwy6DTe22WC9smI3Z1qfOdwa2CoI0kywhwI10kyGtbkrUgMwcrvnHZkQOsNELknLdHVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788188194; c=relaxed/simple;
	bh=IOGGvwsixcOZoYaq6Z++p9NglPknSV04MjoluEgWUbs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S4m/NrRAor8vYSj5r2Hxhwvx0RIh+DATc3F7mdCpL+loN3w5pda4c0/Dt3v/SCmu9O7nOJsFsgYa6qKCDrEsbdLOCTLjmZuBI3IsWJvdop/WtR3GZhPaFcR/+MHTna+L+idc9LRMOkUfCTsZqExa2rM9a9UnnccFsroSNNW4WKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rWAfDko4; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rWAfDko4"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VEZDLL2414961;
	Mon, 31 Aug 2026 14:55:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=xGLDQwdW7DxwkSiHm
	Ret5rPRKi9PJ7VSBlBhzeVwPkI=; b=rWAfDko4B1y2GaMGt+S/3YQmsZG/4udy7
	D92pFhzsOc2MBiS59BHrfeRmx+RqkR0Vf0qY6SDTRl3Xugoq7/vyaHeNkjvdtEfN
	cPVjD5BXHtxZUKUA4iACcNFl8QQVAC66AMaGVMdEDk52J9UPim+JnEtP3ZxiR/Tm
	Ksh/WsFeMUjam9pXLawG5vrSycDVe7QA7avGcWwYaUo43UpQlm3D5tagsVT/x4X/
	ai+pJLk3IGiVDt8r9fNydRO2xCW39Ty+nK5dko/csMhu3bjnl+grZaUTYhw92jQp
	OHpwfhEkDD6x5b5bTGBGmIrO3QpSCK1d1sdGXLJBi1drCuYWP6DgQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbmuhj663-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 14:55:50 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67VEfdFI029538;
	Mon, 31 Aug 2026 14:55:49 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gccexx8uy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 14:55:49 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67VEtgAv48759262
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Aug 2026 14:55:42 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 72D2720040;
	Mon, 31 Aug 2026 14:55:42 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F31E42004F;
	Mon, 31 Aug 2026 14:55:41 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 31 Aug 2026 14:55:41 +0000 (GMT)
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
Subject: [PATCH v2 10/20] s390: Add functions to query arm guest time
Date: Mon, 31 Aug 2026 16:55:25 +0200
Message-ID: <20260831145536.913567-11-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260831145536.913567-1-seiden@linux.ibm.com>
References: <20260831145536.913567-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: uMF_uENXEeg89Z0zfvnqJLaVc5nTEbik
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDEyNSBTYWx0ZWRfX9MKJCnXGmZWB
 H1EExZIUXy8xvoO2kxFlBKul8Chgc2sCBVdI0kBqXfaZCz7dHTA2SEaUNNuVwy/MM7JkVRK4PkA
 NpwCAEe1S/AXCCREjlKmusW30Wnyidd3r3/ZfE+WtKNhVHs9qrWEvcQ4KAhml+aoX7awAYsDdQB
 zeRd16Qr4CHvRDQhPD50SgzIDSRWVqJetuP3qKosBii2vGsfCXdkSg6hFhD02TkGvqMDHHEFXFY
 GJaFuJoelNGqJYplkbL91M7lTy7GnhHgyKtFbEviKZwX1srYnyTg2woXAZtXZqJGmkbTg4V4i9N
 yL0W3sNuEVWZidst5fpCeMcTzda6E12yDs6KhK2/Y2lx9bgwySrGbclBK0Rwc0vsZttNrdQRwps
 DF5genxnl3Rl5IEMJG6TT9uE9Q2r+AS1mgQEWgoxL0C8WaXm/G4FsM7Oj5D1w3AqxqKRHy8nvfO
 dgT2gohkKQzVNdtWztA==
X-Authority-Analysis: v=2.4 cv=Osl/DS/t c=1 sm=1 tr=0 ts=6a9595f7 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=zcYnEf6ijrO-n6df9P0A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDEyNSBTYWx0ZWRfX7Qsjf5A+Aywh
 EOCfhDi2pTxmRelUxZKe3a4J8Ifxik7NTtjIePVnz3W21W5hwNhPuNh5a9e69l3bUwpclDCN4BY
 aePHw+J19lCBd/anmmKetlLh+gkWj/4=
X-Proofpoint-ORIG-GUID: DpC-zNWhyRfXAWpYM09Nx0mIOct46RbM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_05,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310125

Add functions to convert between ARM guest time (LSB0) and s390 host
time (MSB0) using new ptff function codes.

Co-developed-by: Nico Boehr <nrb@linux.ibm.com>
Signed-off-by: Nico Boehr <nrb@linux.ibm.com>
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/s390/include/asm/timex.h | 49 +++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/arch/s390/include/asm/timex.h b/arch/s390/include/asm/timex.h
index 23421b6eb225..e3a2b13022c7 100644
--- a/arch/s390/include/asm/timex.h
+++ b/arch/s390/include/asm/timex.h
@@ -81,6 +81,8 @@ extern unsigned char ptff_function_mask[16];
 #define PTFF_QSI	0x02	/* query steering information */
 #define PTFF_QPT	0x03	/* query physical clock */
 #define PTFF_QUI	0x04	/* query UTC information */
+#define PTFF_QAGTO	0x10	/* query arm guest time offset */
+#define PTFF_QAGPT	0x11	/* query arm guest physical time offset */
 #define PTFF_ATO	0x40	/* adjust tod offset */
 #define PTFF_STO	0x41	/* set tod offset */
 #define PTFF_SFS	0x42	/* set fine steering rate */
@@ -118,6 +120,17 @@ struct ptff_qui {
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
@@ -266,4 +279,40 @@ static inline int tod_after_eq(unsigned long a, unsigned long b)
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
+ */
+static inline u64 ptff_qagpt(u64 guest_time_offset)
+{
+	struct ptff_qagt qagpt = { .in = guest_time_offset };
+
+	ptff(&qagpt, sizeof(qagpt), PTFF_QAGPT);
+	return qagpt.out;
+}
+
 #endif
-- 
2.53.0

