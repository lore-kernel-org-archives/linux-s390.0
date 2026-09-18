Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9014F5E17;
	Fri, 18 Sep 2026 13:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789738312; cv=none; b=pzWnyojvXRkYbAbrpON602J2PpbtK4ThiPHXM1Id5LhZPH/FMWupHNEd1K550U2PxgZDe4XCacb23prod0JJfwc4nsAVPH7/Vc4aBFT8XwjLKU+SKSbEssGQBjJt3adGeftXQOXB4eXYEU8ufu4w7USZeTrmU1zgQnhlF9sTdxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789738312; c=relaxed/simple;
	bh=xgyFBZkX1lfguFXAovdRbxiILkOiqxiVY2yq3ZyfKUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CG3/c7Saleb2wC6spbL2gSmkh2BZuy7ymhvCM2+WhjuLg3aGTXIO4TvTszl//5BIQVTQlLW2NBAzJLfpUtIETmnU4k/PC3X4dS3DC2RWo/zmNQkMSSS8cjTlXfw4NDNTkUd58wK8Naawpfn85b3sVs6kjIXYrEva3b7uJXUIUGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=a4ViReZa; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="a4ViReZa"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68IA1hDv3979521;
	Fri, 18 Sep 2026 13:31:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=6ujg5jeqG2oaiYOFz
	tA2vnfZWM7LZJyeIoTsnRjkAX8=; b=a4ViReZa5ZcXRJ0nVKwGfniPy4RRrDwFl
	7zZl5x7AIO8CINzb2SPs/B2xhthzSxjPy2UxT1P6YZAW6dZbFQU6uQ5OjspAmHZS
	8N/LLh1S917gjpUNLsmkH/j3TAFLXe6EjMOYx+MLqoATUif5tHB3gA7bG95ENzKS
	xuOqHR2x2rSWF+Ac7RCSS5P6KZRX5HH6KK4QO1l6UaaCfdLR9qb/+OR+V02dozWF
	l11HZID2JsSf7u5pO7ZtTgwEkQIAVWJb33w5sTu6eFJnmK3CqWc5HFnBF/96LjKZ
	KCsRNwqtrKy75qvZ1TKAnCn5freAzNXAqwKy0/FIMa7USp+bpUxxg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmw5eftsj-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 13:31:21 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68IDNs2H739440;
	Fri, 18 Sep 2026 13:31:20 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gs56q88u3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 13:31:20 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68IDVCQF53215498
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Sep 2026 13:31:12 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7C7DC20049;
	Fri, 18 Sep 2026 13:31:12 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2DE082004B;
	Fri, 18 Sep 2026 13:31:12 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 18 Sep 2026 13:31:12 +0000 (GMT)
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
Subject: [PATCH v8 12/29] arm64: sysreg: Convert SPSR_ELx to automatic register generation
Date: Fri, 18 Sep 2026 15:30:49 +0200
Message-ID: <20260918133107.1042730-13-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260918133107.1042730-1-seiden@linux.ibm.com>
References: <20260918133107.1042730-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDE4NCBTYWx0ZWRfX9SeeaGmrAO6i
 eSs60ivzBVn0Ia8MEbS3fNkVfiaSu7oXTD4opt8F4NIygUYrBCjxkF4JMltZ0eGXa2OhN+IaKEq
 nLGirM+xCgjfOU82M6r6gwy66u5z7MPM3r4GPQDEYot+jL44P3ypDx26NfIuybOcHVmdmKqxg02
 3uQ+O29K32ZbaisbAP7HAJ82M+5ucJbuSSmXchD64uSnMksURhISnZ8RJfQRXdz/RA2zm2LOnYx
 cHzuHA6MjVxS47LtfDxc5TZazqm/HiNe8t+6euZTlnGn4yU05YeGrvrtKl26YcK2uuSroDNphaS
 FsPFLwSmCKSujo72H3OpHncFFbGaSKq3ZZuUBDtXly90oFc4uerRqxkrcPLu2VwgOc0Gdp5eALQ
 pjWNBuzOuaV8fnCCCTf8mexkDUExa4PcvGvRRE5LC7aDZuSV1uGzkNFnjj1Jp4rBBVPcAnvxWYN
 sVDZhXJOR9io8FgHcDg==
X-Authority-Analysis: v=2.4 cv=E/NYNqdl c=1 sm=1 tr=0 ts=6aad3d29 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=qAnUzrOnmDNqMeXR4cMA:9
X-Proofpoint-ORIG-GUID: oSxcbNzd3Cv9LjDtWOtb6m-y7R9u6NOs
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDE4NCBTYWx0ZWRfX1tW5FVWgaOiZ
 l1gJhiJepboIh873XtOWXf81KyrhD967GRegWRYWu6KDg7bOfI9XdGpla19GFtsmFPNdrX4rqkf
 WowuEGGZujLyCg3UZX+BnDt99jqT0z0=
X-Proofpoint-GUID: WvcPuc0D3J2eK4oREXHIxHlFwLPERoiI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 adultscore=0 clxscore=1015 bulkscore=0 malwarescore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609180184

Convert SPSR_EL{1, 2, 12} to automatic register generation as per
DDIO616 2026-06. No functional change.

Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/arm64/include/asm/sysreg.h |  3 --
 arch/arm64/tools/sysreg         | 51 +++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 4bfdac9401bd..1aa601c95188 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -295,7 +295,6 @@
 #define SYS_APGAKEYLO_EL1		sys_reg(3, 0, 2, 3, 0)
 #define SYS_APGAKEYHI_EL1		sys_reg(3, 0, 2, 3, 1)
 
-#define SYS_SPSR_EL1			sys_reg(3, 0, 4, 0, 0)
 #define SYS_ELR_EL1			sys_reg(3, 0, 4, 0, 1)
 
 #define SYS_ICC_PMR_EL1			sys_reg(3, 0, 4, 6, 0)
@@ -518,7 +517,6 @@
 #define SYS_VTTBR_EL2			sys_reg(3, 4, 2, 1, 0)
 
 #define SYS_HAFGRTR_EL2			sys_reg(3, 4, 3, 1, 6)
-#define SYS_SPSR_EL2			sys_reg(3, 4, 4, 0, 0)
 #define SYS_ELR_EL2			sys_reg(3, 4, 4, 0, 1)
 #define SYS_SP_EL1			sys_reg(3, 4, 4, 1, 0)
 #define SYS_SPSR_irq			sys_reg(3, 4, 4, 3, 0)
@@ -604,7 +602,6 @@
 #define SYS_BRBCR_EL12			sys_reg(2, 5, 9, 0, 0)
 #define SYS_TTBR0_EL12			sys_reg(3, 5, 2, 0, 0)
 #define SYS_TTBR1_EL12			sys_reg(3, 5, 2, 0, 1)
-#define SYS_SPSR_EL12			sys_reg(3, 5, 4, 0, 0)
 #define SYS_ELR_EL12			sys_reg(3, 5, 4, 0, 1)
 #define SYS_AFSR0_EL12			sys_reg(3, 5, 5, 1, 0)
 #define SYS_AFSR1_EL12			sys_reg(3, 5, 5, 1, 1)
diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index e2d37ee221b8..893b5f9df575 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -401,6 +401,57 @@ Res0	3:1
 Field	0	SO
 EndSysreg
 
+SysregFields	SPSR_ELx
+Res0	63:37
+Field	36	UINJ
+Field	35	PACM
+Field	34	EXLOCK
+Res0	33
+Field	32	PM
+Field	31	N
+Field	30	Z
+Field	29	C
+Field	28	V
+Res0	27:26
+Field	25	TCO
+Field	24	DIT
+Field	23	UAO
+Field	22	PAN
+Field	21	SS
+Field	20	IL
+Res0	19:14
+Field	13	ALLINT
+Field	12	SSBS
+Field	11:10	BTYPE
+Field	9	D
+Field	8	A
+Field	7	I
+Field	6	F
+Res0	5
+Field	4	M4
+Enum	3:0	M
+	0b0000	EL0
+	0b0100	EL1t
+	0b0101	EL1h
+	0b1000	EL2t
+	0b1001	EL2h
+	0b1100	EL3t
+	0b1101	EL3h
+EndEnum
+EndSysregFields
+
+Sysreg	SPSR_EL1	3	0	4	0	0
+Fields	SPSR_ELx
+EndSysreg
+
+Sysreg	SPSR_EL2	3	4	4	0	0
+Fields	SPSR_ELx
+EndSysreg
+
+Sysreg	SPSR_EL12	3	5	4	0	0
+Mapping	SPSR_EL1
+EndSysreg
+
 Sysreg ID_PFR0_EL1	3	0	0	1	0
 Res0	63:32
 UnsignedEnum	31:28	RAS
-- 
2.53.0

