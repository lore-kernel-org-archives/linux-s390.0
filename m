Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07F85221C3;
	Wed, 30 Sep 2026 17:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790789714; cv=none; b=fKrLlqqfigJGymfmO+8xIBdTDZ8gx6s2byDY+Aq2zs4rYfpp6RY6Z/ZszI8b08w2MY3wncFWUKY/NwEVXLf0aopcxlWvHN10dJ435lspyJeBTF4X0FazQXGH2NXm4F/K54OONfHDRL4Zh3IqAjIxbQgU43z/am+oSBhpnqwpRHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790789714; c=relaxed/simple;
	bh=VJLvBmoGaiO2DPEj5Ki5mtnYK7RD0RLOEtV1h9jvYcY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F9HTex+F420A12xqpBBleI0QA28EeSzSIM89DWHvX+QiDZGSn5Nxw1Q58MrzipbO2ARh8wHdgIQf9A2Kpipde5x85R0qqifkFz9MOoCNusT2j0F5knBu7e/T2Ah3gWU1lbMnwmRyfD2LOXV84XT2+tdbFMuwIOZ5HsDDBme4hZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ICHO1pKj; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ICHO1pKj"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68UE5vIw3167177;
	Wed, 30 Sep 2026 17:34:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ihC3cLkRFCy3VMN0Y
	OVT+1xOka210qaHcOn3v4ow/tc=; b=ICHO1pKjJC7gEdxraLGcR14qNoGmbs5oA
	DwluL+z/wFUJa3QkOnAFA4f6sVAHOBmz3Tcpw4Nuzh+4j5NVzJ25MwllZI4OyXJe
	692nc4/LQNy3HZGWZOChsKIIkw9CN/2bC9qAY0gNvWC7ZYEmz/ThR28Bj2CZveAO
	/69n7uJKEzJ7+eGvgZmIUGBugJcaURea01R8Shqy/kns4Frkp9rDjP6MsaMlCeFn
	d1s1jfnfZzW9EJ81SgsFowwJkgBXntIFw63z64uwtUIqPSnepJOaM0Tyq5aRnRv6
	3mr/J5BYG/A6ldkUoPItEh4kC78HoWIM7FmeyqIOxaUsEDeJ5ZIYw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5ptdj60-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 30 Sep 2026 17:34:48 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68UEHwJ73569222;
	Wed, 30 Sep 2026 17:34:48 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h0xcsa66e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Sep 2026 17:34:48 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68UHYiFq15991178
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Sep 2026 17:34:44 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3869A20049;
	Wed, 30 Sep 2026 17:34:44 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D8A492005A;
	Wed, 30 Sep 2026 17:34:43 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 30 Sep 2026 17:34:43 +0000 (GMT)
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
Subject: [PATCH v9 06/24] arm64: sysreg: Convert SPSR_ELx to automatic register generation
Date: Wed, 30 Sep 2026 19:34:21 +0200
Message-ID: <20260930173441.66762-7-seiden@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: k9F2T8FcywoYCR2wRgMveNwcjR4TRNJ-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA2OCBTYWx0ZWRfXzIgZteHUORgK
 b1DldQwfDAYANapQ1Jtvp3MYKSZaoyzORBVlvxbkBuXNNzYoJgROvc1Cr+HKtub/JXjcZq7brbG
 r36LaD92sLuE7p5z9pGN83KBI7P4yTjKyspy3K7DM7N04uwc1c6LRFCxPnhX4myq1XynYiXqOPF
 b2tTffBB1un3q/Pt+EXMB96yxJWl/YhuWvoMmwS7y9ioZ8n/XU7dMmexP3qdascGDJJTpbbaNOn
 eZtNcQNsynS7eoKDDaE5o/vMgQn4/QsciFLfCTuPWcX8YY5G1GMSnid2FboFc9tMvazPSDqUmNI
 IW6VAYgi4RPq1mrJZXWALqOezgGwOTu595DSLAfXYs+tEJO/Q9Vm36uuAqmg4UJxIThE0+vTmb4
 h0kma3gclBmtpe5TGZKcRlweObFAEjAB058rt7uJjUIWmYmzs3CLQmFUULMWklWnDDIBJQZdMsO
 QRQzZoR+rga8pLhLnjw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA2OCBTYWx0ZWRfX+BHDjJirDX3X
 j63YcmboUMzt2lMnSfv2XwZVR/EiJQHGXtat5Q3/qsuMzZv7sBbKwcM12/YpXsSMrnJ+soivHgS
 BiDSFTwee4yBEUgdsSc+IelH6mtClQY=
X-Authority-Analysis: v=2.4 cv=EY5d0/mC c=1 sm=1 tr=0 ts=6abd4839 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=7CQSdrXTAAAA:8 a=VnNF1IyMAAAA:8
 a=qAnUzrOnmDNqMeXR4cMA:9 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-GUID: B5fYK2fGV5ZYFD3BwqrcJpPxiHE4avfw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 adultscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300068

Convert SPSR_EL{1, 2, 12} to automatic register generation as per
DDI0601.

No functional change.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
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

