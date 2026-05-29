Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2687C42E00A;
	Fri, 29 May 2026 15:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780070215; cv=none; b=h0Wj0vCOkAidocOMVEz39QCtvROyStt6BuYrOdwfPC4giWR0DCPSsw2bMi6uARbZ+40twDImjQYGpdwvjKx5gm+ob68LLMMJaBk8zIMUeO0hBCuZB9wbuAclkd+RBd6HsNRlUNMXjIyeXzsL3fUOB2QhPuYESwMa/pTxdIBNfOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780070215; c=relaxed/simple;
	bh=nvH5ExHBNuEU0ejc4JAuj1WtgtBL0E6UaEDyVGGLJUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JPTFMUsXSB7vrCNyGqlH7pd22YmESSsT2fIXC/V8n6imYlvBRTUOWZqRUEdTMTWJZWLftppoJx9jfsaJoFtoU1iZAcXoledKLghrt0Exl+aoQDMazMEFE+3mffXjuvr73uMLpdOgVRs6iNlYhFh37eBmpjtrr1qhkdqLULMPLrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VQ9qNVER; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VQ9qNVER"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64TF73Vs2778440;
	Fri, 29 May 2026 15:56:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Is1nyIcJfv6NVfSOr
	nexMYVzhmTQoSC3qzLaTacV2Nk=; b=VQ9qNVER0U9fgEyCiuxMLQBja3KHoy5zF
	irJwrYtYLf7aCPM3NzBL9FWDx1ciIm2p4S/tdpKXEwl+HtIX0KTgBQkig5rWEVJh
	NYA4FXgdNsbBhxN4VmW1ydayKts6cR/zj4eLzOucKOFbzJv6mttvo7JZ7C5WGCEb
	lJqXwTNttbMK+IOmSc/pB0HYf12pFRUqtRF70k9zW+o3LBH3rsLcBPVfI/GDSMaG
	/q2kAdAPLDbt07IUMY6hvzTVQIycZhTrSRbO0ZT7Ho85RKzdHC5mHtNhlNo/az+p
	EZfF38hBG4xUFbxGnUYOu6gpfRvg+43kUqsewoier5s5DOEFyKuRg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ee889m2dq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 15:56:18 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64TFs7Xa009669;
	Fri, 29 May 2026 15:56:17 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4edjrbgkwa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 15:56:17 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64TFu8FB30212446
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 May 2026 15:56:08 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AFC6D20040;
	Fri, 29 May 2026 15:56:08 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4E2AC2004B;
	Fri, 29 May 2026 15:56:08 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 29 May 2026 15:56:08 +0000 (GMT)
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
Subject: [PATCH v1 17/26] arm64: Extract cputype definitions.
Date: Fri, 29 May 2026 17:55:50 +0200
Message-ID: <20260529155601.2927240-18-seiden@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: O_8cEhutoYgDeJRmdXjOcEwlst_hBrz4
X-Proofpoint-GUID: O_8cEhutoYgDeJRmdXjOcEwlst_hBrz4
X-Authority-Analysis: v=2.4 cv=XqfK/1F9 c=1 sm=1 tr=0 ts=6a19b723 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=T5dvmTGJR8rAyywy3tIA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDE1NiBTYWx0ZWRfXz7uDMCyl0q2e
 IriHEkU9hzFpxAFfGTcC9HzsooxKWns80nuTxf+ZI7uS7YmmgYK/GfFMjE0s/J60H6peW4AcKUA
 qVY2yQ1MPflYyXEygYeL7nNCOFWkqasJ2/L6ub4uQ3lpJGFh4ZRDwMFuFO27eUmqmLmiaA6IlVy
 u5vEG8ABEdNvXl4bvFqNEI/jV1wqhPSVLl+QSrAWIWrrh5yKT8iPGiPBTJo1j4nmMDCFRV0g+s4
 JEFmPBsxXreBkfCk3l6VOyaU7AMGkR8WUXnsMVdNvRdJvoh50dNvb0xeFneEhDI/dL74ETxdp/L
 W/CjBrPodXuChuS3WPP3h3dDzkf6OGhLhr0+suIaUYO+LAKmHx9L0J43+LC6B8bcjp7JreUrQT8
 edm8z84Pxbn2V4s7hRIZeJlNpBCu2oIG3CqrYOOieAP7C1DWcie58Crfu7YYkDdxae/cBVMUbic
 U9xh2jMxiffnzM9q1fA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 impostorscore=0 adultscore=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 suspectscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2605290156

Move CPU type definitions from arch/arm64/include/asm/cputype.h to
include/arch/arm64/asm/cputype-defs.h to prepare sharing with other
architectures. No functional changes.

Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/arm64/include/asm/cputype.h              | 246 +-----------------
 .../arch/arm64/asm/cputype-defs.h             |  92 +------
 2 files changed, 6 insertions(+), 332 deletions(-)
 copy arch/arm64/include/asm/cputype.h => include/arch/arm64/asm/cputype-defs.h (85%)

diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
index 7b518e81dd15..67765cdbce84 100644
--- a/arch/arm64/include/asm/cputype.h
+++ b/arch/arm64/include/asm/cputype.h
@@ -5,251 +5,7 @@
 #ifndef __ASM_CPUTYPE_H
 #define __ASM_CPUTYPE_H
 
-#define INVALID_HWID		ULONG_MAX
-
-#define MPIDR_UP_BITMASK	(0x1 << 30)
-#define MPIDR_MT_BITMASK	(0x1 << 24)
-#define MPIDR_HWID_BITMASK	UL(0xff00ffffff)
-
-#define MPIDR_LEVEL_BITS_SHIFT	3
-#define MPIDR_LEVEL_BITS	(1 << MPIDR_LEVEL_BITS_SHIFT)
-#define MPIDR_LEVEL_MASK	((1 << MPIDR_LEVEL_BITS) - 1)
-
-#define MPIDR_LEVEL_SHIFT(level) \
-	(((1 << level) >> 1) << MPIDR_LEVEL_BITS_SHIFT)
-
-#define MPIDR_AFFINITY_LEVEL(mpidr, level) \
-	((mpidr >> MPIDR_LEVEL_SHIFT(level)) & MPIDR_LEVEL_MASK)
-
-#define MIDR_REVISION_MASK	0xf
-#define MIDR_REVISION(midr)	((midr) & MIDR_REVISION_MASK)
-#define MIDR_PARTNUM_SHIFT	4
-#define MIDR_PARTNUM_MASK	(0xfff << MIDR_PARTNUM_SHIFT)
-#define MIDR_PARTNUM(midr)	\
-	(((midr) & MIDR_PARTNUM_MASK) >> MIDR_PARTNUM_SHIFT)
-#define MIDR_ARCHITECTURE_SHIFT	16
-#define MIDR_ARCHITECTURE_MASK	(0xf << MIDR_ARCHITECTURE_SHIFT)
-#define MIDR_ARCHITECTURE(midr)	\
-	(((midr) & MIDR_ARCHITECTURE_MASK) >> MIDR_ARCHITECTURE_SHIFT)
-#define MIDR_VARIANT_SHIFT	20
-#define MIDR_VARIANT_MASK	(0xf << MIDR_VARIANT_SHIFT)
-#define MIDR_VARIANT(midr)	\
-	(((midr) & MIDR_VARIANT_MASK) >> MIDR_VARIANT_SHIFT)
-#define MIDR_IMPLEMENTOR_SHIFT	24
-#define MIDR_IMPLEMENTOR_MASK	(0xffU << MIDR_IMPLEMENTOR_SHIFT)
-#define MIDR_IMPLEMENTOR(midr)	\
-	(((midr) & MIDR_IMPLEMENTOR_MASK) >> MIDR_IMPLEMENTOR_SHIFT)
-
-#define MIDR_CPU_MODEL(imp, partnum) \
-	((_AT(u32, imp)		<< MIDR_IMPLEMENTOR_SHIFT) | \
-	(0xf			<< MIDR_ARCHITECTURE_SHIFT) | \
-	((partnum)		<< MIDR_PARTNUM_SHIFT))
-
-#define MIDR_CPU_VAR_REV(var, rev) \
-	(((var)	<< MIDR_VARIANT_SHIFT) | (rev))
-
-#define MIDR_CPU_MODEL_MASK (MIDR_IMPLEMENTOR_MASK | MIDR_PARTNUM_MASK | \
-			     MIDR_ARCHITECTURE_MASK)
-
-#define ARM_CPU_IMP_ARM			0x41
-#define ARM_CPU_IMP_APM			0x50
-#define ARM_CPU_IMP_CAVIUM		0x43
-#define ARM_CPU_IMP_BRCM		0x42
-#define ARM_CPU_IMP_QCOM		0x51
-#define ARM_CPU_IMP_NVIDIA		0x4E
-#define ARM_CPU_IMP_FUJITSU		0x46
-#define ARM_CPU_IMP_HISI		0x48
-#define ARM_CPU_IMP_APPLE		0x61
-#define ARM_CPU_IMP_AMPERE		0xC0
-#define ARM_CPU_IMP_MICROSOFT		0x6D
-
-#define ARM_CPU_PART_AEM_V8		0xD0F
-#define ARM_CPU_PART_FOUNDATION		0xD00
-#define ARM_CPU_PART_CORTEX_A57		0xD07
-#define ARM_CPU_PART_CORTEX_A72		0xD08
-#define ARM_CPU_PART_CORTEX_A53		0xD03
-#define ARM_CPU_PART_CORTEX_A73		0xD09
-#define ARM_CPU_PART_CORTEX_A75		0xD0A
-#define ARM_CPU_PART_CORTEX_A35		0xD04
-#define ARM_CPU_PART_CORTEX_A55		0xD05
-#define ARM_CPU_PART_CORTEX_A76		0xD0B
-#define ARM_CPU_PART_NEOVERSE_N1	0xD0C
-#define ARM_CPU_PART_CORTEX_A77		0xD0D
-#define ARM_CPU_PART_CORTEX_A76AE	0xD0E
-#define ARM_CPU_PART_NEOVERSE_V1	0xD40
-#define ARM_CPU_PART_CORTEX_A78		0xD41
-#define ARM_CPU_PART_CORTEX_A78AE	0xD42
-#define ARM_CPU_PART_CORTEX_X1		0xD44
-#define ARM_CPU_PART_CORTEX_A510	0xD46
-#define ARM_CPU_PART_CORTEX_A520	0xD80
-#define ARM_CPU_PART_CORTEX_A710	0xD47
-#define ARM_CPU_PART_CORTEX_A715	0xD4D
-#define ARM_CPU_PART_CORTEX_X2		0xD48
-#define ARM_CPU_PART_NEOVERSE_N2	0xD49
-#define ARM_CPU_PART_CORTEX_A78C	0xD4B
-#define ARM_CPU_PART_CORTEX_X1C		0xD4C
-#define ARM_CPU_PART_CORTEX_X3		0xD4E
-#define ARM_CPU_PART_NEOVERSE_V2	0xD4F
-#define ARM_CPU_PART_CORTEX_A720	0xD81
-#define ARM_CPU_PART_CORTEX_X4		0xD82
-#define ARM_CPU_PART_NEOVERSE_V3AE	0xD83
-#define ARM_CPU_PART_NEOVERSE_V3	0xD84
-#define ARM_CPU_PART_CORTEX_X925	0xD85
-#define ARM_CPU_PART_CORTEX_A725	0xD87
-#define ARM_CPU_PART_CORTEX_A720AE	0xD89
-#define ARM_CPU_PART_NEOVERSE_N3	0xD8E
-#define ARM_CPU_PART_C1_PRO		0xD8B
-
-#define APM_CPU_PART_XGENE		0x000
-#define APM_CPU_VAR_POTENZA		0x00
-
-#define CAVIUM_CPU_PART_THUNDERX	0x0A1
-#define CAVIUM_CPU_PART_THUNDERX_81XX	0x0A2
-#define CAVIUM_CPU_PART_THUNDERX_83XX	0x0A3
-#define CAVIUM_CPU_PART_THUNDERX2	0x0AF
-/* OcteonTx2 series */
-#define CAVIUM_CPU_PART_OCTX2_98XX	0x0B1
-#define CAVIUM_CPU_PART_OCTX2_96XX	0x0B2
-#define CAVIUM_CPU_PART_OCTX2_95XX	0x0B3
-#define CAVIUM_CPU_PART_OCTX2_95XXN	0x0B4
-#define CAVIUM_CPU_PART_OCTX2_95XXMM	0x0B5
-#define CAVIUM_CPU_PART_OCTX2_95XXO	0x0B6
-
-#define BRCM_CPU_PART_BRAHMA_B53	0x100
-#define BRCM_CPU_PART_VULCAN		0x516
-
-#define QCOM_CPU_PART_FALKOR_V1		0x800
-#define QCOM_CPU_PART_FALKOR		0xC00
-#define QCOM_CPU_PART_KRYO		0x200
-#define QCOM_CPU_PART_KRYO_2XX_GOLD	0x800
-#define QCOM_CPU_PART_KRYO_2XX_SILVER	0x801
-#define QCOM_CPU_PART_KRYO_3XX_GOLD	0x802
-#define QCOM_CPU_PART_KRYO_3XX_SILVER	0x803
-#define QCOM_CPU_PART_KRYO_4XX_GOLD	0x804
-#define QCOM_CPU_PART_KRYO_4XX_SILVER	0x805
-#define QCOM_CPU_PART_ORYON_X1		0x001
-
-#define NVIDIA_CPU_PART_DENVER		0x003
-#define NVIDIA_CPU_PART_CARMEL		0x004
-#define NVIDIA_CPU_PART_OLYMPUS		0x010
-
-#define FUJITSU_CPU_PART_A64FX		0x001
-
-#define HISI_CPU_PART_TSV110		0xD01
-#define HISI_CPU_PART_HIP09			0xD02
-#define HISI_CPU_PART_HIP12		0xD06
-
-#define APPLE_CPU_PART_M1_ICESTORM	0x022
-#define APPLE_CPU_PART_M1_FIRESTORM	0x023
-#define APPLE_CPU_PART_M1_ICESTORM_PRO	0x024
-#define APPLE_CPU_PART_M1_FIRESTORM_PRO	0x025
-#define APPLE_CPU_PART_M1_ICESTORM_MAX	0x028
-#define APPLE_CPU_PART_M1_FIRESTORM_MAX	0x029
-#define APPLE_CPU_PART_M2_BLIZZARD	0x032
-#define APPLE_CPU_PART_M2_AVALANCHE	0x033
-#define APPLE_CPU_PART_M2_BLIZZARD_PRO	0x034
-#define APPLE_CPU_PART_M2_AVALANCHE_PRO	0x035
-#define APPLE_CPU_PART_M2_BLIZZARD_MAX	0x038
-#define APPLE_CPU_PART_M2_AVALANCHE_MAX	0x039
-
-#define AMPERE_CPU_PART_AMPERE1		0xAC3
-#define AMPERE_CPU_PART_AMPERE1A	0xAC4
-
-#define MICROSOFT_CPU_PART_AZURE_COBALT_100	0xD49 /* Based on r0p0 of ARM Neoverse N2 */
-
-#define MIDR_CORTEX_A53 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A53)
-#define MIDR_CORTEX_A57 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A57)
-#define MIDR_CORTEX_A72 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A72)
-#define MIDR_CORTEX_A73 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A73)
-#define MIDR_CORTEX_A75 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A75)
-#define MIDR_CORTEX_A35 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A35)
-#define MIDR_CORTEX_A55 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A55)
-#define MIDR_CORTEX_A76	MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A76)
-#define MIDR_NEOVERSE_N1 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_NEOVERSE_N1)
-#define MIDR_CORTEX_A77	MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A77)
-#define MIDR_CORTEX_A76AE	MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A76AE)
-#define MIDR_NEOVERSE_V1	MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_NEOVERSE_V1)
-#define MIDR_CORTEX_A78	MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A78)
-#define MIDR_CORTEX_A78AE	MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A78AE)
-#define MIDR_CORTEX_X1	MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_X1)
-#define MIDR_CORTEX_A510 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A510)
-#define MIDR_CORTEX_A520 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A520)
-#define MIDR_CORTEX_A710 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A710)
-#define MIDR_CORTEX_A715 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A715)
-#define MIDR_CORTEX_X2 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_X2)
-#define MIDR_NEOVERSE_N2 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_NEOVERSE_N2)
-#define MIDR_CORTEX_A78C	MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A78C)
-#define MIDR_CORTEX_X1C	MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_X1C)
-#define MIDR_CORTEX_X3 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_X3)
-#define MIDR_NEOVERSE_V2 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_NEOVERSE_V2)
-#define MIDR_CORTEX_A720 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A720)
-#define MIDR_CORTEX_X4 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_X4)
-#define MIDR_NEOVERSE_V3AE	MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_NEOVERSE_V3AE)
-#define MIDR_NEOVERSE_V3 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_NEOVERSE_V3)
-#define MIDR_CORTEX_X925 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_X925)
-#define MIDR_CORTEX_A725 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A725)
-#define MIDR_CORTEX_A720AE MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A720AE)
-#define MIDR_NEOVERSE_N3 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_NEOVERSE_N3)
-#define MIDR_C1_PRO MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_C1_PRO)
-#define MIDR_THUNDERX	MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX)
-#define MIDR_THUNDERX_81XX MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX_81XX)
-#define MIDR_THUNDERX_83XX MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX_83XX)
-#define MIDR_OCTX2_98XX MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_OCTX2_98XX)
-#define MIDR_OCTX2_96XX MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_OCTX2_96XX)
-#define MIDR_OCTX2_95XX MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_OCTX2_95XX)
-#define MIDR_OCTX2_95XXN MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_OCTX2_95XXN)
-#define MIDR_OCTX2_95XXMM MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_OCTX2_95XXMM)
-#define MIDR_OCTX2_95XXO MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_OCTX2_95XXO)
-#define MIDR_CAVIUM_THUNDERX2 MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX2)
-#define MIDR_BRAHMA_B53 MIDR_CPU_MODEL(ARM_CPU_IMP_BRCM, BRCM_CPU_PART_BRAHMA_B53)
-#define MIDR_BRCM_VULCAN MIDR_CPU_MODEL(ARM_CPU_IMP_BRCM, BRCM_CPU_PART_VULCAN)
-#define MIDR_QCOM_FALKOR_V1 MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_FALKOR_V1)
-#define MIDR_QCOM_FALKOR MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_FALKOR)
-#define MIDR_QCOM_KRYO MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_KRYO)
-#define MIDR_QCOM_KRYO_2XX_GOLD MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_KRYO_2XX_GOLD)
-#define MIDR_QCOM_KRYO_2XX_SILVER MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_KRYO_2XX_SILVER)
-#define MIDR_QCOM_KRYO_3XX_GOLD MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_KRYO_3XX_GOLD)
-#define MIDR_QCOM_KRYO_3XX_SILVER MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_KRYO_3XX_SILVER)
-#define MIDR_QCOM_KRYO_4XX_GOLD MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_KRYO_4XX_GOLD)
-#define MIDR_QCOM_KRYO_4XX_SILVER MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_KRYO_4XX_SILVER)
-#define MIDR_QCOM_ORYON_X1 MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_ORYON_X1)
-
-/*
- * NOTES:
- * - Qualcomm Kryo 5XX Prime / Gold ID themselves as MIDR_CORTEX_A77
- * - Qualcomm Kryo 5XX Silver IDs itself as MIDR_QCOM_KRYO_4XX_SILVER
- * - Qualcomm Kryo 6XX Prime IDs itself as MIDR_CORTEX_X1
- * - Qualcomm Kryo 6XX Gold IDs itself as ARM_CPU_PART_CORTEX_A78
- * - Qualcomm Kryo 6XX Silver IDs itself as MIDR_CORTEX_A55
- */
-
-#define MIDR_NVIDIA_DENVER MIDR_CPU_MODEL(ARM_CPU_IMP_NVIDIA, NVIDIA_CPU_PART_DENVER)
-#define MIDR_NVIDIA_CARMEL MIDR_CPU_MODEL(ARM_CPU_IMP_NVIDIA, NVIDIA_CPU_PART_CARMEL)
-#define MIDR_NVIDIA_OLYMPUS MIDR_CPU_MODEL(ARM_CPU_IMP_NVIDIA, NVIDIA_CPU_PART_OLYMPUS)
-#define MIDR_FUJITSU_A64FX MIDR_CPU_MODEL(ARM_CPU_IMP_FUJITSU, FUJITSU_CPU_PART_A64FX)
-#define MIDR_HISI_TSV110 MIDR_CPU_MODEL(ARM_CPU_IMP_HISI, HISI_CPU_PART_TSV110)
-#define MIDR_HISI_HIP09 MIDR_CPU_MODEL(ARM_CPU_IMP_HISI, HISI_CPU_PART_HIP09)
-#define MIDR_HISI_HIP12 MIDR_CPU_MODEL(ARM_CPU_IMP_HISI, HISI_CPU_PART_HIP12)
-#define MIDR_APPLE_M1_ICESTORM MIDR_CPU_MODEL(ARM_CPU_IMP_APPLE, APPLE_CPU_PART_M1_ICESTORM)
-#define MIDR_APPLE_M1_FIRESTORM MIDR_CPU_MODEL(ARM_CPU_IMP_APPLE, APPLE_CPU_PART_M1_FIRESTORM)
-#define MIDR_APPLE_M1_ICESTORM_PRO MIDR_CPU_MODEL(ARM_CPU_IMP_APPLE, APPLE_CPU_PART_M1_ICESTORM_PRO)
-#define MIDR_APPLE_M1_FIRESTORM_PRO MIDR_CPU_MODEL(ARM_CPU_IMP_APPLE, APPLE_CPU_PART_M1_FIRESTORM_PRO)
-#define MIDR_APPLE_M1_ICESTORM_MAX MIDR_CPU_MODEL(ARM_CPU_IMP_APPLE, APPLE_CPU_PART_M1_ICESTORM_MAX)
-#define MIDR_APPLE_M1_FIRESTORM_MAX MIDR_CPU_MODEL(ARM_CPU_IMP_APPLE, APPLE_CPU_PART_M1_FIRESTORM_MAX)
-#define MIDR_APPLE_M2_BLIZZARD MIDR_CPU_MODEL(ARM_CPU_IMP_APPLE, APPLE_CPU_PART_M2_BLIZZARD)
-#define MIDR_APPLE_M2_AVALANCHE MIDR_CPU_MODEL(ARM_CPU_IMP_APPLE, APPLE_CPU_PART_M2_AVALANCHE)
-#define MIDR_APPLE_M2_BLIZZARD_PRO MIDR_CPU_MODEL(ARM_CPU_IMP_APPLE, APPLE_CPU_PART_M2_BLIZZARD_PRO)
-#define MIDR_APPLE_M2_AVALANCHE_PRO MIDR_CPU_MODEL(ARM_CPU_IMP_APPLE, APPLE_CPU_PART_M2_AVALANCHE_PRO)
-#define MIDR_APPLE_M2_BLIZZARD_MAX MIDR_CPU_MODEL(ARM_CPU_IMP_APPLE, APPLE_CPU_PART_M2_BLIZZARD_MAX)
-#define MIDR_APPLE_M2_AVALANCHE_MAX MIDR_CPU_MODEL(ARM_CPU_IMP_APPLE, APPLE_CPU_PART_M2_AVALANCHE_MAX)
-#define MIDR_AMPERE1 MIDR_CPU_MODEL(ARM_CPU_IMP_AMPERE, AMPERE_CPU_PART_AMPERE1)
-#define MIDR_AMPERE1A MIDR_CPU_MODEL(ARM_CPU_IMP_AMPERE, AMPERE_CPU_PART_AMPERE1A)
-#define MIDR_MICROSOFT_AZURE_COBALT_100 MIDR_CPU_MODEL(ARM_CPU_IMP_MICROSOFT, MICROSOFT_CPU_PART_AZURE_COBALT_100)
-
-/* Fujitsu Erratum 010001 affects A64FX 1.0 and 1.1, (v0r0 and v1r0) */
-#define MIDR_FUJITSU_ERRATUM_010001		MIDR_FUJITSU_A64FX
-#define MIDR_FUJITSU_ERRATUM_010001_MASK	(~MIDR_CPU_VAR_REV(1, 0))
-#define TCR_CLEAR_FUJITSU_ERRATUM_010001	(TCR_EL1_NFD1 | TCR_EL1_NFD0)
+#include <asm/cputype-defs.h>
 
 #ifndef __ASSEMBLER__
 
diff --git a/arch/arm64/include/asm/cputype.h b/include/arch/arm64/asm/cputype-defs.h
similarity index 85%
copy from arch/arm64/include/asm/cputype.h
copy to include/arch/arm64/asm/cputype-defs.h
index 7b518e81dd15..6f5279aaaa19 100644
--- a/arch/arm64/include/asm/cputype.h
+++ b/include/arch/arm64/asm/cputype-defs.h
@@ -1,9 +1,8 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright (C) 2012 ARM Ltd.
- */
-#ifndef __ASM_CPUTYPE_H
-#define __ASM_CPUTYPE_H
+#ifndef __ASM_CPUTYPE_DEFS_H
+#define __ASM_CPUTYPE_DEFS_H
+
+#include <linux/types.h>
 
 #define INVALID_HWID		ULONG_MAX
 
@@ -251,85 +250,4 @@
 #define MIDR_FUJITSU_ERRATUM_010001_MASK	(~MIDR_CPU_VAR_REV(1, 0))
 #define TCR_CLEAR_FUJITSU_ERRATUM_010001	(TCR_EL1_NFD1 | TCR_EL1_NFD0)
 
-#ifndef __ASSEMBLER__
-
-#include <asm/sysreg.h>
-
-#define read_cpuid(reg)			read_sysreg_s(SYS_ ## reg)
-
-/*
- * The CPU ID never changes at run time, so we might as well tell the
- * compiler that it's constant.  Use this function to read the CPU ID
- * rather than directly reading processor_id or read_cpuid() directly.
- */
-static inline u32 __attribute_const__ read_cpuid_id(void)
-{
-	return read_cpuid(MIDR_EL1);
-}
-
-/*
- * Represent a range of MIDR values for a given CPU model and a
- * range of variant/revision values.
- *
- * @model	- CPU model as defined by MIDR_CPU_MODEL
- * @rv_min	- Minimum value for the revision/variant as defined by
- *		  MIDR_CPU_VAR_REV
- * @rv_max	- Maximum value for the variant/revision for the range.
- */
-struct midr_range {
-	u32 model;
-	u32 rv_min;
-	u32 rv_max;
-};
-
-#define MIDR_RANGE(m, v_min, r_min, v_max, r_max)		\
-	{							\
-		.model = m,					\
-		.rv_min = MIDR_CPU_VAR_REV(v_min, r_min),	\
-		.rv_max = MIDR_CPU_VAR_REV(v_max, r_max),	\
-	}
-
-#define MIDR_REV_RANGE(m, v, r_min, r_max) MIDR_RANGE(m, v, r_min, v, r_max)
-#define MIDR_REV(m, v, r) MIDR_RANGE(m, v, r, v, r)
-#define MIDR_ALL_VERSIONS(m) MIDR_RANGE(m, 0, 0, 0xf, 0xf)
-
-static inline bool midr_is_cpu_model_range(u32 midr, u32 model, u32 rv_min,
-					   u32 rv_max)
-{
-	u32 _model = midr & MIDR_CPU_MODEL_MASK;
-	u32 rv = midr & (MIDR_REVISION_MASK | MIDR_VARIANT_MASK);
-
-	return _model == model && rv >= rv_min && rv <= rv_max;
-}
-
-struct target_impl_cpu {
-	u64 midr;
-	u64 revidr;
-	u64 aidr;
-};
-
-bool cpu_errata_set_target_impl(u64 num, void *impl_cpus);
-bool is_midr_in_range_list(struct midr_range const *ranges);
-
-static inline u64 __attribute_const__ read_cpuid_mpidr(void)
-{
-	return read_cpuid(MPIDR_EL1);
-}
-
-static inline unsigned int __attribute_const__ read_cpuid_implementor(void)
-{
-	return MIDR_IMPLEMENTOR(read_cpuid_id());
-}
-
-static inline unsigned int __attribute_const__ read_cpuid_part_number(void)
-{
-	return MIDR_PARTNUM(read_cpuid_id());
-}
-
-static inline u32 __attribute_const__ read_cpuid_cachetype(void)
-{
-	return read_cpuid(CTR_EL0);
-}
-#endif /* __ASSEMBLER__ */
-
-#endif
+#endif /* __ASM_CPUTYPE_DEFS_H */
-- 
2.53.0

