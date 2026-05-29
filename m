Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179003FB07F;
	Fri, 29 May 2026 15:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780070194; cv=none; b=TcgDdimXZ9DlSqx3oHMh5SNyJgMG5mwjbWy0Pr6i25638wQliAD3qbRqjv/dO0zpsJ2wCE2upfozR05Kjt4Y2t0Jr9K2Dvfa0Zcxmg8ySXLFRANQt6iW4KD+h8+/5+SIsFcrf0juTZhTJlniBkroITy8o1JJGEFH1SV5cBkQJsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780070194; c=relaxed/simple;
	bh=Qi+J57+Zfp1XErQQdrCLh3UBuVWDZKgF4zxzj0KQAxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fBMA8tJTMz4vE/duMSNXDkiWMATMJJ+ORo4tnPzSshCuRWy1+QpmqKks7qe/K2948lWvBEMR9UUCtSgqcPZUn9iGVxpst9zfOs02sQWDLRwJ79q+wO9gwHNJAoOzCARX5o+c1fd8D0WZ2U+l1PMjB8+EktYYcmzmc8V2wyGAeLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=g6b1nInc; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="g6b1nInc"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64TF5i9E2418034;
	Fri, 29 May 2026 15:56:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ZtdNOjsS5e1+chG/S
	OEjXZHnwNU0fc8NOy7/AKFWsBU=; b=g6b1nIncytF7I5499HWr1yrq1R/EY6xyr
	TpedGbyJUFiQuSiP5dHBcTGVkd2NTw0gC1p9DisYRdfu0ZIeaHZ3GcBZaxE5oB0e
	pJSgUV2YjM/XhEc9/2f4qIk1Go/6oV2DIasxS5xEw/TCF7WpHDUmggpcmHYdHlOR
	cCfC4rSh6pi1VhhDK9daGQVM8QZkD6WJsiX7qDnf56S2PBPigi60gYxGjkAF6aWl
	9CBbAlmdURPPpo8/WmXDqpo6z2N/gs+sZMRwE2JoPrs9QI3iWyXg9hyASMgpnhYD
	0wxREnxZGzLUcP/WOvTbs7B7tO8OT7kEmYM5vdGD1UTelTZD7xyiw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ee884vkmn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 15:56:10 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64TFs5Dd003155;
	Fri, 29 May 2026 15:56:09 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4edjrbgm7r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 15:56:09 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64TFu3Dc41877920
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 May 2026 15:56:03 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6A71F20040;
	Fri, 29 May 2026 15:56:03 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1E7BE2004D;
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
Subject: [PATCH v1 03/26] KVM: arm64: Generalize get_idreg_field_*()
Date: Fri, 29 May 2026 17:55:36 +0200
Message-ID: <20260529155601.2927240-4-seiden@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=L4MtheT8 c=1 sm=1 tr=0 ts=6a19b71a cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=Qz9-bC73Ewa-9BkP4PUA:9
X-Proofpoint-ORIG-GUID: Y8uUbAKDXN_ID0QggIym4anEE5667k0U
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDE1NiBTYWx0ZWRfXyDiYpjBYGR3M
 8DzHC0YkcfkpvmaUG1sT7vzwzaTmojweT/MfINdf7VZOBWRVmf/u5NKJP8eytk1Ik4rkGaB4gjO
 bHT1XNig42Hc3gdqFs3u/2vz9VjmRurEOyBE1DHvrQI7pgS/6joLKTF0hfjUtpvgu16YoUqS4Vy
 vjPGySXjkiE1po+O9TKyfJcaylw8f3fpskeXclADc7fZfElKxbWvSaN5V2decooYIDkgccuwOp6
 KJu3KTwBlx2igMhoxqWhP3N/mxU5IKEffO04xfPzRUAYd2auxb7/pUqdCAjb1CJAZNDwFMROLT/
 AN/JvehoyYHHXM01P5J06qKaAnQUEO0LBT/cdpXvudkrOGB3xzglfZyh0peYG14wB2WftzuZ0KJ
 cEHw+PwrIH1xIYEF93C9EUF48stwT2sLAtENSqXkdxN0MwWKh0YjbW9uuwWw/i8BP2WMaMup+A5
 dXrgRLxIFCCVavQW2XA==
X-Proofpoint-GUID: Y8uUbAKDXN_ID0QggIym4anEE5667k0U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 impostorscore=0 adultscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290156

Introduce intermediate macros that extract the value from a passed
parameter instead of reading the VM's ID register. Allow using other
sources of ID register values, i.e. read directly from the hardware or
during a sequence of sanitization steps.

Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/arm64/include/asm/kvm_feature.h | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_feature.h b/arch/arm64/include/asm/kvm_feature.h
index d580f4ffab34..067550d5b208 100644
--- a/arch/arm64/include/asm/kvm_feature.h
+++ b/arch/arm64/include/asm/kvm_feature.h
@@ -6,20 +6,23 @@
 #include <linux/bitfield.h>
 #include <asm/sysreg-defs.h>
 
-#define get_idreg_field_unsigned(kvm, id, fld)				\
-	({								\
-		u64 __val = kvm_read_vm_id_reg((kvm), SYS_##id);	\
-		FIELD_GET(id##_##fld##_MASK, __val);			\
-	})
+#define extract_id_field_unsigned(val, id, fld)				\
+	(FIELD_GET(id##_##fld##_MASK, (val)))
 
-#define get_idreg_field_signed(kvm, id, fld)				\
+#define extract_id_field_signed(val, id, fld)				\
 	({								\
-		u64 __val = get_idreg_field_unsigned(kvm, id, fld);	\
+		u64 __val = extract_id_field_unsigned((val), id, fld);	\
 		sign_extend64(__val, id##_##fld##_WIDTH - 1);		\
 	})
 
+#define get_idreg_field_unsigned(kvm, id, fld)				\
+	extract_id_field_unsigned(kvm_read_vm_id_reg((kvm), SYS_##id), id, fld)
+
+#define get_idreg_field_signed(kvm, id, fld)				\
+	extract_id_field_signed(kvm_read_vm_id_reg((kvm), SYS_##id), id, fld)
+
 #define get_idreg_field_enum(kvm, id, fld)				\
-	get_idreg_field_unsigned(kvm, id, fld)
+	extract_id_field_unsigned(kvm_read_vm_id_reg((kvm), SYS_##id), id, fld)
 
 #define kvm_cmp_feat_signed(kvm, id, fld, op, limit)			\
 	(get_idreg_field_signed((kvm), id, fld) op S64_SYS_FIELD_VALUE(id, fld, limit))
-- 
2.53.0

