Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BD43F9276;
	Fri, 29 May 2026 15:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780070190; cv=none; b=dL9pNymZKHMV/Jni5V2vfgUCuS040TcAzgOw5qE8RUjr8xoCWsxXQ1uCXbfpGA04Hx0X3AfnBmxYUCuOD0/fR1R81xeLz5Ra+295l7CPGB+NY//HcWetZBLlmhlgO5sfIOQ/HbKDYlF2wleGCjdqpwF30wPi6tp4rME6I1VaUX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780070190; c=relaxed/simple;
	bh=tjuJSvy87A6cVWbudTYOVPxNt1QdD+XhxSPmslH9XQk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MKCPiHrnx9XmQnG+KKnmAnBlVqxbYc7g9YB14Q3e36YWhn2jmxDa9vNjgZ8PnGJKjK6lPtLPKXuS8o103973WcNJMFpNlU4NQASVzTEyW8ywAL4nI8geHT43MxVQWQWu8vKy+Lz8E2I4Gx/ceM78FXVGZQAKAewZaqGHJZBdOsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AXNGdUch; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AXNGdUch"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64TFZ5hW1684858;
	Fri, 29 May 2026 15:56:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=7WJoSNxNCqAD1yMb5
	BggkCxNMBPVI9mELDSocM+HPU8=; b=AXNGdUchGt+EKII8ibBc0IXKzgVrMYHGu
	15IpxwrKwCf73UDiZulwisrnJGqJEQ/+cocWakBSIScC6qHRvYKEND9H0v6odc0/
	u4/Ax25rM0CkYYdx994iBFfG3r8vykVl3gneL7cTCq7dztU6gvrXtnn9NL3pm9Ku
	lRhfXngAmVhhe9RxsWKMBPChiz6ggz9ue2IKplQzAl1KM30baWoLyOUYZaKoQjvk
	InXRhsKdHimdbEHHveqAT/dkYSqt7gp1iaKvlVxQSDbjy1d5+c6tKSqJFuUHJuLd
	v7mAfTWw5r1xwGhiMaSw6kchafITj1AecWmM5FImUVpjDTfT0cKOA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ee884mh3w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 15:56:10 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64TFs9LN029222;
	Fri, 29 May 2026 15:56:09 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4edjrbgkns-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 15:56:09 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64TFu3aN41877916
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 May 2026 15:56:03 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1577620040;
	Fri, 29 May 2026 15:56:03 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BD2D42004B;
	Fri, 29 May 2026 15:56:02 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 29 May 2026 15:56:02 +0000 (GMT)
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
Subject: [PATCH v1 02/26] KVM: arm64: Remove __expand_field_sign_(un)signed
Date: Fri, 29 May 2026 17:55:35 +0200
Message-ID: <20260529155601.2927240-3-seiden@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=fIYJG5ae c=1 sm=1 tr=0 ts=6a19b71a cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=8GpaujLIwWfsa4wt0MAA:9
X-Proofpoint-ORIG-GUID: 3I44r_DIBytvrXZTWkT_uTU1h5rmPzRk
X-Proofpoint-GUID: 3I44r_DIBytvrXZTWkT_uTU1h5rmPzRk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDE1NiBTYWx0ZWRfX1KhKBwY2gvl2
 t/NYK0TgB5NS37wysRV+k4on33aX+pB9kji43Wr2RbAdV+dEY4lg8OVfgh5sqk34D5bmE/7eo68
 ssrMD5nl0twm65zxGLHszNqeJbkaaqSQYcPL5k7HejuWlwXyG3zZ7VWNdzp2OLDsZhP9QZHYC52
 LlS7c7Ap/6+BsoJkCd/ANZtIc4Sos3OvsffJGAw2GlTpchRWJGMGwqiIBCFCiFSH0ejKv+hcQcy
 Kq3md6GF8P7vtn/MQLlqeN/IaaJV0dquFRGNzmiCbNiJwj24Ccpi5CWprxlr866Gw5w50wIY2XX
 BGP2MQ1iNEKiyXaSlRbYcxS2LYH0Ao+cuJwlNNty/lTgGY4WscfyZyObXAfEyLAGdspfHTDInCS
 rYpQluYFQuXbiM2XEgjK5SGvmzBjb9LWLvd9GfWoxrCckucTQyxIut3Lo1RKA9N4tFMyvCth9xP
 Q0/bzea+peapDHh2IKg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2605290156

__expand_field_sign_unsigned is a very small abstraction that makes it
harder to see what's happening when looking at the caller. Just inline
it. Create a macro S64_SYS_FIELD_VALUE that is a sign extended
SYS_FIELD_VALUE. Then also get rid of __expand_field_sign_signed.

Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/arm64/include/asm/kvm_feature.h | 13 ++-----------
 include/arch/arm64/asm/sysreg-defs.h |  8 ++++++++
 2 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_feature.h b/arch/arm64/include/asm/kvm_feature.h
index 8d0c65246aa0..d580f4ffab34 100644
--- a/arch/arm64/include/asm/kvm_feature.h
+++ b/arch/arm64/include/asm/kvm_feature.h
@@ -6,15 +6,6 @@
 #include <linux/bitfield.h>
 #include <asm/sysreg-defs.h>
 
-#define __expand_field_sign_unsigned(id, fld, val)			\
-	((u64)SYS_FIELD_VALUE(id, fld, val))
-
-#define __expand_field_sign_signed(id, fld, val)			\
-	({								\
-		u64 __val = SYS_FIELD_VALUE(id, fld, val);		\
-		sign_extend64(__val, id##_##fld##_WIDTH - 1);		\
-	})
-
 #define get_idreg_field_unsigned(kvm, id, fld)				\
 	({								\
 		u64 __val = kvm_read_vm_id_reg((kvm), SYS_##id);	\
@@ -31,10 +22,10 @@
 	get_idreg_field_unsigned(kvm, id, fld)
 
 #define kvm_cmp_feat_signed(kvm, id, fld, op, limit)			\
-	(get_idreg_field_signed((kvm), id, fld) op __expand_field_sign_signed(id, fld, limit))
+	(get_idreg_field_signed((kvm), id, fld) op S64_SYS_FIELD_VALUE(id, fld, limit))
 
 #define kvm_cmp_feat_unsigned(kvm, id, fld, op, limit)			\
-	(get_idreg_field_unsigned((kvm), id, fld) op __expand_field_sign_unsigned(id, fld, limit))
+	(get_idreg_field_unsigned((kvm), id, fld) op (u64)SYS_FIELD_VALUE(id, fld, limit))
 
 #define kvm_cmp_feat(kvm, id, fld, op, limit)				\
 	(id##_##fld##_SIGNED ?						\
diff --git a/include/arch/arm64/asm/sysreg-defs.h b/include/arch/arm64/asm/sysreg-defs.h
index 27646c91e15c..3e280d4156ce 100644
--- a/include/arch/arm64/asm/sysreg-defs.h
+++ b/include/arch/arm64/asm/sysreg-defs.h
@@ -998,9 +998,17 @@
 
 #ifndef __ASSEMBLER__
 #include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/types.h>
 
 #define SYS_FIELD_VALUE(reg, field, val)	reg##_##field##_##val
 
+#define S64_SYS_FIELD_VALUE(id, fld, val)				\
+	({								\
+		u64 __val = SYS_FIELD_VALUE(id, fld, val);		\
+		sign_extend64(__val, id##_##fld##_WIDTH - 1);		\
+	})
+
 #define SYS_FIELD_GET(reg, field, val)		\
 		 FIELD_GET(reg##_##field##_MASK, val)
 
-- 
2.53.0

