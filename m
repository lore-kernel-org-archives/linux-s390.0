Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274E2476CDE;
	Wed, 12 Aug 2026 15:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786549053; cv=none; b=QSO71PW62+XOT4UWRZa7KQ2NcK6UdRjpdrkDXfaSztS6TZcBEp2M9sgbt1bpDLtcqRtC0l/HvJchKSUTpBiI2XwPmMTZzasLq0GVuuJCFNK8grMb3tyEXfEG/fCxxrQXjk+xUVY2H/W3EK0TL1l7d8JHbBSvQqUBkmt3iHHAwTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786549053; c=relaxed/simple;
	bh=CdRBGytXIXa1zx9eXOvGAuzKgsrn2BprzimKUV3/4dI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H1VU/BWeQNpvWgsA3ZbGooVl4tw5ofNHpFgchyoQ4xeaqE5k9WAQTKRb7h1cWyMABayVfGNO88zc5UH5mk4AvDSvWXlVG2st8J2loFLJW3T7Snvk9HL5DH6+61jTWJOgn+pwircpMm1V97sZ/qIdycqgK6pTI5tc7D0mblnKmIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=c/UNId0h; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="c/UNId0h"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CE1mmH3717448;
	Wed, 12 Aug 2026 15:36:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=eGPgAnjtKT6ftTAM6
	aOkUfJetBSRY7Y8hfEs8FIUvWE=; b=c/UNId0hpEOA58rnxwOmyntRiuISlwrDT
	FiZh4n6pQ1CpXnj0eux/G2tuDsHBEo/8Me1UTJV1UCzQsI1IK8/L0cI/L9bmjxzt
	/o3c24i1XAkfiT7O5uzYgOVupWIrVZ/m1qcsVwHMPXfw7dpgie2Pu7xsIOBiFsl1
	w+F2MUpLaIQVKR6jm00JYCfGAV6WQr6p48VFxcLwTTl2Q3Etfm8tXGO05C7yCtTw
	EuNu9WFaUn1Ic7pyuOJ/8cDSlHx4rluywr5aQaDRVN0iV7omkilOkSEXqrE2sODL
	U37qOxjzO8vBIirJd4zDkb77B5GJDrHcmNYnnj7ktHv1/ANO3BgpQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvnwads8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 15:36:38 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CFQHri024761;
	Wed, 12 Aug 2026 15:36:38 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxfsjxpj2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 15:36:37 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67CFaYrf48693682
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 15:36:34 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E92C720049;
	Wed, 12 Aug 2026 15:36:33 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 97B192005A;
	Wed, 12 Aug 2026 15:36:33 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 15:36:33 +0000 (GMT)
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
Subject: [PATCH v6 04/33] arm64: Use proper include variant
Date: Wed, 12 Aug 2026 17:36:00 +0200
Message-ID: <20260812153631.3376090-5-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812153631.3376090-1-seiden@linux.ibm.com>
References: <20260812153631.3376090-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=RsP16imK c=1 sm=1 tr=0 ts=6a7c9307 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=d3WjOe2bLlXSZPWdUOEA:9
X-Proofpoint-GUID: P6gFbGSDggD4L-zZXBOItFsSrc5gX5tC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEyNiBTYWx0ZWRfX6gr+77HpB1d6
 En16SZVNMJQwSeEHCRyYKjjjz0E5vjNOJeQVSNTW1jDHKnZLqDXwFoTurRdVH9Ls2xckIC04U3A
 IOC/idlGzKGOE6F6uv15feSJT0tRHr3sls/b/dyyMOgvhYUjlOWxPbeZl1sNYuiOgiLNK/6+OK2
 xi5TTYTRMCZ9J7xkoaIw7w3E+jnWzKg8YaXX9F8Kyv7f6ma4Kj9pBxEr0cLsTaBNaK4dduFM8il
 b2e0U8xPZMsQAWWzk6il+EHquGlnnJHTY+KkBhF3fWvQXFFAfBcVQSoF1wm+DxWCgaxE/xlT7GB
 K9hRYDYgsT8KMTt2jSIZ97JdPim9yEOx3JnmTi6/o5rvbVWVnf95bD0mscyVBvq86bOtCq0cI5Q
 2e/l7gBdm+mCbYuwIgZQtdPu+uxqRLakEkleFA3nfCgNJjrtFEG7D6nluTTdx2iSh3FO4b8LseR
 jEvU+mNpNOHfKEoICgA==
X-Proofpoint-ORIG-GUID: peK-E1XwVJ35p7lF-ahfEIF6XNutEUJr
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEyNiBTYWx0ZWRfX9MB+Ec1YYNIS
 dK4Cn6GUYAgzdaakqy06b088+y+upwIVb+xJ4CnytLWdf4Tu5uHSSlYbakjaMeuBmiSjM9F5mvT
 CSvXeSzcxRTQ87e0Due9prEpa56IyI4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120126

Use <> for including the sysreg header as it is not discoverable from
the current directory.

Fixes: c07d8017bceb ("arm64/sysreg: Enable automatic generation of system register definitions")
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/arm64/include/asm/sysreg.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 7aa08d59d494..4bfdac9401bd 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -173,7 +173,7 @@
  * come from here. The header relies on the definition of sys_reg()
  * earlier in this file.
  */
-#include "asm/sysreg-defs.h"
+#include <asm/sysreg-defs.h>
 
 /*
  * System registers, organised loosely by encoding but grouped together
-- 
2.53.0

