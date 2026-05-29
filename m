Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0350E3FF884;
	Fri, 29 May 2026 15:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780070200; cv=none; b=R3UKQOrwOXT1wZ5fP2mz3+tqLFWJWKfYWsrXQrVt46yzBFPYCwUWD/HaPpqXm+Q8WLhqaVAyKWxofJwXPgXoR5h+YNHtrOwMu3xu2pBm9wztKnggOBmqMqm7QPkg2Q/97acJ0hk1nj3FUQLKMD4GxD06Z0CuvyBoZDevtN11sNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780070200; c=relaxed/simple;
	bh=tDUPaKRpTyz68q1SoICI7EnRFiMWtlFnRYt/3QcOi/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hvsurbAwFO8hPFfO8hY+1lBcd0xqTTRRCaSuH2sH0KcOrV391J7NW3hAu8G78MPXDa9GhikadSu+fyGp1Jr5SDMRS3beZndUYxqd7ICy36ALDM0ooa3040LjjefoBsHonLo4zypTlaDsWUl4xL5yTUEDvICmT/HHVJMveB/AKVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aBTU/fwY; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aBTU/fwY"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64TFDvEC1684674;
	Fri, 29 May 2026 15:56:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=o53yR+CaUtzV3aGfV
	+UvVE5sv2cSNRU3xdbCbsPiryg=; b=aBTU/fwYfHFuJOD9btnZkqgs2CiCERqAO
	HC53TWBgkABRCRPjBuIkMQwijjNSuZGPef6WuebDm+o7NYPYlwhOgWe6THlxpUK8
	swF7xL7ZeBxdYsteAInsFl7MtWF94QSrT2Za9kgq7xWcxPIB2V52c+g9Rh4VQP+2
	tFSxSGfTKtinj7aW/1XVUiVu9POtEU2gIQdXIn/4UPfUfMPO+bHHCi/1LZrCOUg5
	uzXM6+rd8SmK982SbVh5P1NV7IZBX3RNXAb4sl6+KRRpNoiONL/pw4vh2hdvu3Pl
	o7e0BSYtYh2j2X3PxVJ0zpz4oNIK5jtVGqfNcbWvKet025amyZFlA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ee884mh52-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 15:56:12 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64TFs5HY016958;
	Fri, 29 May 2026 15:56:11 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4edjrbgjng-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 15:56:11 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64TFu3YE41877922
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 May 2026 15:56:04 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C409C20040;
	Fri, 29 May 2026 15:56:03 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 77A822004B;
	Fri, 29 May 2026 15:56:03 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 29 May 2026 15:56:03 +0000 (GMT)
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
Subject: [PATCH v1 04/26] KVM: arm64: Generalize kvm_cmp_feat_*()
Date: Fri, 29 May 2026 17:55:37 +0200
Message-ID: <20260529155601.2927240-5-seiden@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=fIYJG5ae c=1 sm=1 tr=0 ts=6a19b71c cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=_j3w4fkP5V9tGIP_pu8A:9
X-Proofpoint-ORIG-GUID: LwKL746gUuzqFOb_cvnxjsPLxtZNxuA6
X-Proofpoint-GUID: LwKL746gUuzqFOb_cvnxjsPLxtZNxuA6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDE1NiBTYWx0ZWRfXx7ll/KPOg9Zh
 qKwcPJ1vxRGBqw1V7I37q1tG2FZG8gbYHjnuMPcnybFBgttruvnxyEsvrccF5xa3gDCVEpzKDad
 55gUaOlL65YNEL4ub+66bU1in1bNGLrYm7l/RczFcAd1vWyIbiuYHWTXwo5a5YKyhuv6qfH9TgV
 w3THlYphBhrh2fI56cPnquEZrG9LaGqeMDrumy6JuLZWdMH7pbdAqyVwDlPhrACnkeKUbhc4AKp
 XE+zQ8kWDJZrr6+poTo00g+mDG6NsDWwdeU2jQIbGyHSbdnjwCZcAV8cU4RImS/FzKYf6Wsn0Nr
 XTM1XFlnVPxpXIT+ayCRoTUVz6lXydeFi9lwnsiOmBZszVyz+lxUdyzoAWNpey6HX1AGJS4N7Ys
 ruW0A+B9k9Bmcygj305loQh7W0y4GTZvfsMmWmLTu9ZjKn4bwyil5fxeq32bhnwiUup2nC9xPD5
 UcXXS9n1Ps/YV0wzDSQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2605290156

Introduce an intermediate macro that extracts the value from a passed
parameter instead of reading the VM's ID register. Allow using other
sources of ID register values, i.e. read directly from the hardware or
during a sequence of sanitization steps.

Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/arm64/include/asm/kvm_feature.h | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_feature.h b/arch/arm64/include/asm/kvm_feature.h
index 067550d5b208..6dd7b4a4929c 100644
--- a/arch/arm64/include/asm/kvm_feature.h
+++ b/arch/arm64/include/asm/kvm_feature.h
@@ -15,6 +15,17 @@
 		sign_extend64(__val, id##_##fld##_WIDTH - 1);		\
 	})
 
+#define cmp_id_feat_signed(val, id, fld, op, limit)			\
+	(extract_id_field_signed((val), id, fld) op S64_SYS_FIELD_VALUE(id, fld, limit))
+
+#define cmp_id_feat_unsigned(val, id, fld, op, limit)			\
+	(extract_id_field_unsigned((val), id, fld) op (u64)SYS_FIELD_VALUE(id, fld, limit))
+
+#define cmp_id_feat(val, id, fld, op, limit)				\
+	(id##_##fld##_SIGNED ?						\
+	 cmp_id_feat_signed(val, id, fld, op, limit) :			\
+	 cmp_id_feat_unsigned(val, id, fld, op, limit))
+
 #define get_idreg_field_unsigned(kvm, id, fld)				\
 	extract_id_field_unsigned(kvm_read_vm_id_reg((kvm), SYS_##id), id, fld)
 
@@ -25,15 +36,13 @@
 	extract_id_field_unsigned(kvm_read_vm_id_reg((kvm), SYS_##id), id, fld)
 
 #define kvm_cmp_feat_signed(kvm, id, fld, op, limit)			\
-	(get_idreg_field_signed((kvm), id, fld) op S64_SYS_FIELD_VALUE(id, fld, limit))
+	cmp_id_feat_signed(kvm_read_vm_id_reg((kvm), SYS_##id), id, fld, op, limit)
 
 #define kvm_cmp_feat_unsigned(kvm, id, fld, op, limit)			\
-	(get_idreg_field_unsigned((kvm), id, fld) op (u64)SYS_FIELD_VALUE(id, fld, limit))
+	cmp_id_feat_unsigned(kvm_read_vm_id_reg((kvm), SYS_##id), id, fld, op, limit)
 
 #define kvm_cmp_feat(kvm, id, fld, op, limit)				\
-	(id##_##fld##_SIGNED ?						\
-	 kvm_cmp_feat_signed(kvm, id, fld, op, limit) :			\
-	 kvm_cmp_feat_unsigned(kvm, id, fld, op, limit))
+	cmp_id_feat(kvm_read_vm_id_reg((kvm), SYS_##id), id, fld, op, limit)
 
 #define __kvm_has_feat(kvm, id, fld, limit)				\
 	kvm_cmp_feat(kvm, id, fld, >=, limit)
-- 
2.53.0

