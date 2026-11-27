Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795789445;
	b=sUBBDTzPUtnZlPGj4699/CngGTArNFV/PBBTNNaFfgZmB1J/iMe9JtXagdoDlitUaaZv
	 gfaDhvMOK7h8crqo3xKJFK34uLiU6nGW9Gz9XnJiZNmfZ2BDW7ypn31n3m/RyBw9WMsnd
	 innDZCJFTtNaWDrJOzG0BPxUk5sbN6Gne990h/aQ7uyGInkqWL081sfSz4xUfLHPGOMN3
	 lQbcvM8gsfqf1sJRv4bmT6D/nO8uEOLxRbExcNak9/ZX8NkKL9b3oJAZtQu9ZIItnbA7P
	 vKHwe5NQdlyxnb+dGfVLq/DxsvFJM2NmgKpNAXQt+ub7B8hfOjOUdMvOqjZFzrwP6Hg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795789445;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-TM-AS-GCONF:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=x3wKeRgQn3K+x3tZ3X2EDKaSNjcSdkwUoCfWG9V8P0I=;
	b=A0DftaRcxX8AGu/r6iJ3ddel1bD6ZIvp7MuuR/Tl5jyUXCpp8bWfQi8SZ1uxcBSQcXl6
	 L7SqWDRLkj02PwusrlU8jih5fxzaKwlpgu+IlPu/WZ9ZlF4/JNZfSq2eC5w2jSYAU7I+5
	 mfhcka3TYtN6D6tJr+b3f+VBv9PF8EWomD8LvvraHpe+RSBvprjmZLQ38KVoWARPC64qV
	 bHwRAsvet1GUx4JE4a8AoyZgwI3Bv5aWShBpP96EXY9SUUW6yTQbOcMINNqf03XCeGKQa
	 uwUzAVhY32Ay/jjwPAoLhbuf+HBH5LwCf1/eroOZ09vqeUQbPmC0FAm/8HB+iMWaN5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=h0vahw4J;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E8E606A6B0;
	Fri, 27 Nov 2026 14:24:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86E8E606A6B0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=h0vahw4J
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARE4uew2012171;
	Fri, 27 Nov 2026 14:23:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=x3wKeR
	gQn3K+x3tZ3X2EDKaSNjcSdkwUoCfWG9V8P0I=; b=h0vahw4JyNZOj2of2zSTdJ
	W3CRJJJrfsHcuUQCCR4HiDBhP5WKczlHgEM9eR8BxmXzu0zZVpy1fAVx5HlLNTby
	kboOUghsbaQKIPyNGjWCxXUciF4SkgqY+qT5vUewWXd5xGS9v7fmo7k9AKhhYLXV
	y+odxeTIYAuOCf82fEj2kzGJgM6pvBq+FOJLgHiUyrAskFQdU0RIH4FW7c7HGkNJ
	z5eU2gFdU3RkwZztmhxtQKfdE1Png0rC8/nhhKn61boQXiUyO1E7OtkjCkHCJnc2
	YqEheovXiBiJFcQ1HtHj+wPARNHHK70K65lodXVjhJDBITWRJ+qbQutRae7podRw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34p4w8fw-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 27 Nov 2026 14:23:23 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARE4HwW861610;
	Fri, 27 Nov 2026 14:23:23 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j6mjg4d5a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Nov 2026 14:23:22 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ARENHWl18088434
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Nov 2026 14:23:19 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 781102004F;
	Fri, 27 Nov 2026 14:23:17 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 062F62006A;
	Fri, 27 Nov 2026 14:23:17 +0000 (GMT)
Received: from a46lp73.lnxne.boe (unknown [9.87.84.240])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 27 Nov 2026 14:23:16 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
Date: Fri, 27 Nov 2026 15:22:11 +0100
Subject: [PATCH v4 08/25] KVM: s390: arm64: Prepare for sharing arm64 SVE
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
Message-Id: <20261127-sysreg-v4-8-a6318d18aab5@linux.ibm.com>
References: <20261127-sysreg-v4-0-a6318d18aab5@linux.ibm.com>
In-Reply-To: <20261127-sysreg-v4-0-a6318d18aab5@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA1NiBTYWx0ZWRfX7Rd9jNslBOz4
 9S8fvPJqPpEeh864YB/c0A36nu7vxSC1XR64uBtrWVQnGo2N16DrH6kfuWvaUqjiwa3NdN/C01M
 fNYP6cuepkiJJy1yRcGXJ1F5hrWqDaU=
X-Proofpoint-GUID: lZ_6xlPBJlT6QTnBJulvU0AfgSHuW_ls
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA1NiBTYWx0ZWRfX1BSZogXyHG1I
 SB6n+4TYJUSo7tukKUp2N8xh4a8/TsLjiB4287fS3KcSliEbV+cPNGrP8443Gl0V/qSW8u1BFrH
 XBeuuKnW0N/5r8tyHWynrSvNvkvWeNjH5HVzSlJPK4QJXJSrxdC8fpHeTuFauSNA2YCI0p5DFKR
 gRy8v1C/6HBrtWHPHvIWyWBFUi6WBsJzUAja3xtVgFabQw71vCrbyTnOJ7w9VXaW0cSeBTzzBWY
 iuyvbPmBc3EGc2w1k3hR+qQsHh627RwAlUdQIfnaZ/4jQmSD7SSMBJoXd6Y9Eid4kw73SMemqKx
 lrQAdwF9n8OSEeDGhGhgtePu6n2Ha7+6kHAPNxbArzGb/J54R/ycU9rA2R4/Kq+0+aAn1GNe+xr
 qpFPBa7tkG8YyRg5LNi6gUTSAhkDYLQXRxEx0rh05Ilu/51H3iMGxyogEKy3OeXPvUORFJyR/0R
 +xvv+E8fzMPbtn/RKfA==
X-Proofpoint-ORIG-GUID: lZ_6xlPBJlT6QTnBJulvU0AfgSHuW_ls
X-Authority-Analysis: v=2.4 cv=QabzLcbv c=1 sm=1 tr=0 ts=6b09925b cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=pU5mCtL58HmMNmPAhBwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_02,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270056

Add required SVE and feature-register definitions to the arm64 on s390
host code. The definitions are required to be able to build shared SVE
related code.

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
2.56.1

