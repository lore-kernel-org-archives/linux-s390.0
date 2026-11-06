Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793981325;
	b=yRRCx2d1b7gWc8DGlX6VHiF7RnyuWR/hZRswMOWyBnxjYsmhlrXfC7YIZOw2p7YJaxjM
	 Bfo61U/tqL15ZWqsEZx3QwLmrcSiKthPHRg/J0BXYkPnopJXw1+vzEsMY3FIQqvPQxi8D
	 NLWdraB3K0ZJ7MGOG5qxTX4tM3No4YJefFys2i1EW0EyKyN6BG6+aniJsed/KJ8sGA6NB
	 ey5E2onHOiYkoFqg3sL0B5cvADqT900zsPyijwnSwxivKO4T6AKPTaJ9X/cyg7YiK/3CE
	 Xi6h1QmnqCcKERF/DUrALnILwE+b8VsTSNaCNOkKm2akWCmJn36tlOpXuuj4MJ0z+CA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793981325;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-TM-AS-GCONF:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=W127d2adflmjvt3WWavZucVr9TwbuK1rER800FERqDo=;
	b=l5B/mrn/9xILPVHo5YnA3r2kCCWdcxCv/9idNXw8FqYE819ucRmGrwugAZAu1oy/nCDK
	 9s6j+t10vBloieWRpah+L3z1NpeXL8BQ+Q57IBUZRaJt30/MJEiflu40oimjVIcDoECa2
	 gHoD3FT8agpS5jWoec9Nyvfdk+vLFv9OkunM+RKdC2ZbzjiHCP+7TDJ52kkyFTnZDm7c+
	 /O2G73U1YUF2DkiWqPi0IXZbfjMT2kSipJzUMz5dJ/Jp5h3ThMzQkdXbhxHkSpElCiepb
	 W2T6cAqlQv8ZB79vBV08aGowyrg9EB68sV9DcwuPvPaI1et3S49Dp/DOwXz+1+FQ+xg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ai74M2c+;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C1E606D80D;
	Fri,  6 Nov 2026 16:08:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93C1E606D80D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ai74M2c+
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6FEAPk1094572;
	Fri, 6 Nov 2026 16:08:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=W127d2
	adflmjvt3WWavZucVr9TwbuK1rER800FERqDo=; b=ai74M2c+4gU6e6QH8W5V6z
	G0Togt0SHtIMqwNEq9C0gVBmoAzc5yiwVkWMRwKvlUwuH2P+Z6/v4LW1VbISxxQq
	O4Il+m7pZeDXQeA5fFM7066MH9tDf/E0vtpeBc+1tim1xBZD4iO4Rj24yyb+oRwA
	dDecooXIkp+ua5ZjBK5HHtQUnjYCd9u8YhwlvcNIxUURH8o2ce0gtT8CkD3xZ5HK
	eOjysexAaqR618eET1eFy9fFIs6lYJwwHeMxKU1e61jD4Od3kYm/qBQ0+h7rRCoC
	HlhhV69DNyi8momXR3J53MrYKzf9r2vXoHDQrppjBxtLRriirT5DWCHxUhz04e/w
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hs3rawhyq-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 16:08:21 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6F4vHX3617207;
	Fri, 6 Nov 2026 16:08:20 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hrdd7ukc0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 16:08:20 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A6G8Gur47579590
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 6 Nov 2026 16:08:16 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5FFAF20040;
	Fri,  6 Nov 2026 16:08:16 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 03FC42005A;
	Fri,  6 Nov 2026 16:08:16 +0000 (GMT)
Received: from a46lp73.lnxne.boe (unknown [9.87.84.240])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  6 Nov 2026 16:08:15 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
Date: Fri, 06 Nov 2026 17:07:39 +0100
Subject: [PATCH v3 06/23] KVM: s390: arm64: Prepare for sharing arm64 SVE
 and ftr-reg code
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-sysreg-v3-6-75e95980fb10@linux.ibm.com>
References: <20261106-sysreg-v3-0-75e95980fb10@linux.ibm.com>
In-Reply-To: <20261106-sysreg-v3-0-75e95980fb10@linux.ibm.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>,
        Fuad Tabba <fuad.tabba@linux.dev>, Joey Gouly <joey.gouly@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Andreas Grapentin <gra@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Friedrich Welter <fritz@linux.ibm.com>,
        Gautam Gala <ggala@linux.ibm.com>,
        Hariharan Mari <hari55@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Nico Boehr <nrb@linux.ibm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>, Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, Steffen Eiden <seiden@linux.ibm.com>
X-Mailer: b4 0.14.3
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=QYDzLcbv c=1 sm=1 tr=0 ts=6aedfb75 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=6ud2rAkrWTPY0GCDnFoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 9fyAJ52TrLGHCQDehdYavzsUJGtEwYpq
X-Proofpoint-ORIG-GUID: 9fyAJ52TrLGHCQDehdYavzsUJGtEwYpq
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA2MiBTYWx0ZWRfXwoCa7takuaX0
 zhk77HMKKmIq0whq5sF8gsi1FcjgsP25TQov/zaCk8W7DhZd2ydmpFdIbiKF8M+B8WPriknYjX/
 a01Lp04mSnrTJXx44A4rqm49grtMg/4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA2MiBTYWx0ZWRfX+jvDCirEzeOj
 bw7xbJbAPKhX6EWmqH9h46MNwnqPSEfZ7uhW+xWut916BADkjZCkR4k4cM373r0Q4B6jqtyiqdJ
 e5k50Q3UCZMfLpFQ0D3Txqvi7W7t88L30Vkbr5Zl0D/ZEl6hyKAnS1TDM0AHi2jc5s7Z24/A13Q
 Qy1kTAVR/taIKzuLLRozY82HQO4Ib/gqZyrYpbRD/MZHt4YA/DZk3iSoopYEj02Y7L9h/FC+L6Q
 Aw8n0I/eMwneN3P9c4tsieu5Pbeh66DZ7Pu2fUwqe4w5tg0QJ2KZJECG99yRJeaqcn3TLyn0LbN
 U0Gqve0AlT7aFjayv9d/7PxED9YKReJwQXN7wqeKvRZOPBC+mm8mZDRK/U8oxY2aOAlrbDNBsPL
 /HhBLwq1SuEPa31KtEH+TT93oAebpZ8SzMciKv+6oZDQdgdleqxrJ1ANo8HYL1kDS5xeNGUfvNR
 LxlYmIWWs1uE5Up2INA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060062

Add required SVE and feature-register definitions to the arm64 on s390
host code. The definitions are required to be able to build shared SVE
related code.

No functional changes.

Co-developed-by: Andreas Grapentin <gra@linux.ibm.com>
Signed-off-by: Andreas Grapentin <gra@linux.ibm.com>
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/s390/kvm/arm64/arm.c   | 2 ++
 arch/s390/kvm/arm64/guest.c | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/arch/s390/kvm/arm64/arm.c b/arch/s390/kvm/arm64/arm.c
index bd9d85235f43..29d3add0bbda 100644
--- a/arch/s390/kvm/arm64/arm.c
+++ b/arch/s390/kvm/arm64/arm.c
@@ -8,6 +8,7 @@
 #include <linux/kvm_host.h>
 #include <linux/cleanup.h>
 #include <linux/fpu.h>
+#include <linux/bitfield.h>
 
 #include <asm/access-regs.h>
 
@@ -24,6 +25,7 @@
 #include "trace.h"
 
 static unsigned long system_supported_vcpu_features(struct kvm_vcpu *vcpu);
+#define read_sanitised_ftr_reg(_id) 0
 
 #define __INCL_GEN_ARM_FILE
 #include "generated/arm.inc"
diff --git a/arch/s390/kvm/arm64/guest.c b/arch/s390/kvm/arm64/guest.c
index 4ea6fe2c270d..8b5ee9e79a4f 100644
--- a/arch/s390/kvm/arm64/guest.c
+++ b/arch/s390/kvm/arm64/guest.c
@@ -5,6 +5,12 @@
 #include <arm64/kvm_emulate.h>
 #include <arm64/kvm_nested.h>
 
+#define SVE_VQ_MIN	__SVE_VQ_MIN
+#define SVE_NUM_ZREGS	KVM_ARM64_SVE_NUM_ZREGS
+#define SVE_NUM_PREGS	KVM_ARM64_SVE_NUM_PREGS
+
+#define vcpu_sve_slices(_vcpu) 1
+
 #define __INCL_GEN_ARM_FILE
 #include "generated/guest.inc"
 #undef __INCL_GEN_ARM_FILE

-- 
2.56.0

