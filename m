Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DB53FE358;
	Fri, 29 May 2026 15:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780070198; cv=none; b=uB5D02o7IrqNugDAeawy/v8wMpPioT2cOicZTpGMLBGE9g7N/gUZn2GZBotlShl+9Fsbl5A3T4PlScXi/tUyIDqee/Aiu9zqqMLKTd+ax4kccweWR0HXdXtGE8CZnQfORkuDNdaC1x47cpeMG8YPHT5Fjys1GbEmT0jx5aMt1CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780070198; c=relaxed/simple;
	bh=duGQu2jfwKrEz5AtUFtktTOtLQqDhLn3V4YShFyx0n4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cp9IO1+bTaPa4bSkbd2ffas214NWSUtccEUsjF/3H/GT94lehFJZBcErrHVqjy1nrrgs4O22RmxrWRqjbIKcuyismJujNzi/dvspmZyKnKHVRltp1dSyO/+Gi2AaASttoxBhhU61EpKTv6mbvopHdi7OH16pf1FWSGFqhof/Bv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KX60PrKQ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KX60PrKQ"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64TFBnER3215536;
	Fri, 29 May 2026 15:56:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=oli/0CpBrVw+C5kY4
	hqojKRn9iZuZzYeBdWYURH49v0=; b=KX60PrKQ5W35puNXp8vVvBbLSC7fXlmGQ
	FRn7kFmMzyJBNmu3QXMv/Xb41RhcumsNLWsYWYLLdpADKT3R6UpTnHQy292ZV+df
	e6ImxcYcNUI4B/0eDd8c9U+sDmo/BH+/UWLSgEP0OgPiQZaYC3vdPHX3s5BboJOM
	ApZxSX61t6Acjh4H14Zc8NRch9zLsiNqLhKbvkObsxEmfpl8Y5qQdw2jmzehGAnA
	iGw21qI+bt10JZcedrXW3DsuNRiCmmcbkWOBMNJknLiuqL+7Hjb8E0/pBe8tzx5H
	omA/YyU0uZfF1llKmM6a27b7vhG6PUGjt/mEgEWg9Gt5rCJKg69Aw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ee88bm2jn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 15:56:12 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64TFs7LM009663;
	Fri, 29 May 2026 15:56:11 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4edjrbgku1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 15:56:11 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64TFu4rl16187696
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 May 2026 15:56:04 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7B89820040;
	Fri, 29 May 2026 15:56:04 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2F6B02004B;
	Fri, 29 May 2026 15:56:04 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 29 May 2026 15:56:04 +0000 (GMT)
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
Subject: [PATCH v1 06/26] KVM: arm64: Remove get_idreg_field_*() and kvm_cmp_feat_*()
Date: Fri, 29 May 2026 17:55:39 +0200
Message-ID: <20260529155601.2927240-7-seiden@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDE1NiBTYWx0ZWRfX4MxL7Si8G3/U
 uLpH/XYmYvlUN4YzqxTSQaONYql/vI9JWZZbGBCBXvlYEkosDq5+S2+5N9rgwEr4DyJAJbOXxAV
 5H21vjYL7wglHa2JYkKBIJDONSiIsKCVdGCgYMWWD910BC3MNRoEaO+F2B18SbOCBpaD2a6CKfy
 s2McYX2VWlzfGn+YLIx3+wm3cC/y7kGluAvoi6MjaxvB5f4aWcrBBKJJ5D+Mm1LB/XL1sQNwqU8
 u3pWGkEcyI4Ys8BP4fa/fannc4HSMjBIJdlwelpsv6covbNhF5odajk7KHenoq6pTXHQAQYKdCm
 j0nTD9ZNIaFRgv3BwK9fcxz1xpSOA3v1zJd+5g9wrbtd0oksxOONzKATKQv6gz+U/+3B2mE7j4y
 ri5s5UpgjUq3CXGPv6HIdzCxEgte4Ksp/N9EHPxM2rsVJkP5aS96ZlJXJ5SXWLHfbTacynQIT9K
 M2/MMCGMFqlr7LNsFrw==
X-Proofpoint-ORIG-GUID: gGyF-Vy7Mge0ZWxA2eii8UEGfWLcKPST
X-Authority-Analysis: v=2.4 cv=IJEyzAvG c=1 sm=1 tr=0 ts=6a19b71c cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=h1Z8OaWvIKWV_s2n3WQA:9
X-Proofpoint-GUID: gGyF-Vy7Mge0ZWxA2eii8UEGfWLcKPST
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 clxscore=1015 spamscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2605290156

These macros are now unused after generalizing the feature detection
code in the parent commit. The functionality is preserved through the
new generalized macros that operate on register values directly.

Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/arm64/include/asm/kvm_feature.h | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_feature.h b/arch/arm64/include/asm/kvm_feature.h
index b627696ac648..da9ba5041f44 100644
--- a/arch/arm64/include/asm/kvm_feature.h
+++ b/arch/arm64/include/asm/kvm_feature.h
@@ -36,24 +36,6 @@
 	(cmp_id_feat(val, id, fld, >=, min) &&				\
 	cmp_id_feat(val, id, fld, <=, max))
 
-#define get_idreg_field_unsigned(kvm, id, fld)				\
-	extract_id_field_unsigned(kvm_read_vm_id_reg((kvm), SYS_##id), id, fld)
-
-#define get_idreg_field_signed(kvm, id, fld)				\
-	extract_id_field_signed(kvm_read_vm_id_reg((kvm), SYS_##id), id, fld)
-
-#define get_idreg_field_enum(kvm, id, fld)				\
-	extract_id_field_unsigned(kvm_read_vm_id_reg((kvm), SYS_##id), id, fld)
-
-#define kvm_cmp_feat_signed(kvm, id, fld, op, limit)			\
-	cmp_id_feat_signed(kvm_read_vm_id_reg((kvm), SYS_##id), id, fld, op, limit)
-
-#define kvm_cmp_feat_unsigned(kvm, id, fld, op, limit)			\
-	cmp_id_feat_unsigned(kvm_read_vm_id_reg((kvm), SYS_##id), id, fld, op, limit)
-
-#define kvm_cmp_feat(kvm, id, fld, op, limit)				\
-	cmp_id_feat(kvm_read_vm_id_reg((kvm), SYS_##id), id, fld, op, limit)
-
 #define __kvm_has_feat(kvm, id, fld, limit)				\
 	id_has_feat(kvm_read_vm_id_reg((kvm), SYS_##id), id, fld, limit)
 
-- 
2.53.0

