Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795789451;
	b=seSPJhy4yhjQZbBIQNExpH73037tP2BDWfuU08zXEt1O+STwNHiUYEBJdznXoY5nTUHr
	 W1pQzHg3nCphOMTWbw7AyNAr9TSNI5b+/IYOewVA8Kx5Iomifwl4++Mp+ozWo9UV3cuRZ
	 BVMhiW/y1GFKqzGjpvWzp2Vof041/9iOqAvd3aifLT1sY5+h/H93um2zKUqUNIcMm5Vz+
	 plfVscTVcseZwwhNCFh1laYNzl3djFhX/022+ibaWT15WhuqWs7FZYlINdk6Kq866ePWA
	 /Y67w38l1bo9jw/S1nHO4q2tIX4gAqAUvpUCcDZL6LB+nTq2UNdCoad13zT6ZS2F4gQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795789451;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-TM-AS-GCONF:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=6LRP0fw5N/nrTs0/Dr1BIXK84/e1KYWOdfre+EoJdf8=;
	b=zpHGSnqlpgOuiTZFQVvHrQE0gwYdmmqXJ798blMmR4S0zLVfhi6Qz+GgQewROlntjvUJ
	 StNDqOgU/tpcPak8BWfFEfVquWjTFCxIR+BtlYjiXa+hhJFrWOe4M+WoyoX93W1u729j4
	 vR7KXKNOQHXubzHY2wFW8kwsi3D9be5MPTyhYBDx9JvLQ1UIl3yHJMVggCyMeQ9qfdKtG
	 sGc2sLc5lTK3SzTEDnIFDueKxWvFFCOWfgrzEFcEoxidcpjQq2QOwS6qTeBWFjKzw0Xys
	 m3j9pEmB98lcv5WXfqQaWS5uzX8VoXgfd6n6c+I2bMR7D5FKqXjLOv9h7WMxLBZSLZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=aDoFlBY4;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308AE60A380F;
	Fri, 27 Nov 2026 14:24:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 308AE60A380F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=aDoFlBY4
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARE5Ifb3267360;
	Fri, 27 Nov 2026 14:23:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=6LRP0f
	w5N/nrTs0/Dr1BIXK84/e1KYWOdfre+EoJdf8=; b=aDoFlBY4AwvG2dusQlCVja
	o/a+tOyRlxgJ6Yu2UpMeXE4iHqcZUBbM09qy64+NQDmUykCIbbofULdVPkoWOe2g
	5Eo8AbnLoc0s5pafWjgvRQlHBs2yxLUEZK3xCx/LL+lLbW/ITo6T/wT/q/Nfn+kj
	9ZGNKWCDRRFKFJDF6s7B04bT+DEULyH7GOkZGgYgPotGbB5Ghln3OKXzdCJUzGbc
	e6dWkRBUUtv7X9f3Lj9YKnOVmQKAuDl7DzVMsKip+6dw9vfEc5vvECEG0x+J6Nc0
	Lf3wGxtuzKbX/28FGyq3z3laCXtwgo/kTIHAFQ2j7Vg9Xh/ayeMYALV83PcokcpQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34g1ne1g-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 27 Nov 2026 14:23:26 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARE4KY43893271;
	Fri, 27 Nov 2026 14:23:25 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j6ucctx3g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Nov 2026 14:23:25 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ARENJsI50528674
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Nov 2026 14:23:20 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7B3CF2004E;
	Fri, 27 Nov 2026 14:23:19 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CB34B20063;
	Fri, 27 Nov 2026 14:23:18 +0000 (GMT)
Received: from a46lp73.lnxne.boe (unknown [9.87.84.240])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 27 Nov 2026 14:23:18 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
Date: Fri, 27 Nov 2026 15:22:14 +0100
Subject: [PATCH v4 11/25] s390: tools: Share arm64/kvm headers
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
Message-Id: <20261127-sysreg-v4-11-a6318d18aab5@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: O6fkt2PLb2y0SgR3hV0w-UKTx4BQXp6H
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA1NiBTYWx0ZWRfX5HhJi2/ZeaqL
 BtiJCp3LwJxG3zUK+ICwc1jUtDVhXitFxwDdMOX34ylJIujMhB4xjJk5AK2nPry77WqABk4kbPm
 xJCO5Xr1MlDuH3OTBPzRpd3bsO4iJBk=
X-Proofpoint-GUID: O6fkt2PLb2y0SgR3hV0w-UKTx4BQXp6H
X-Authority-Analysis: v=2.4 cv=c8M+0h9l c=1 sm=1 tr=0 ts=6b09925e cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=JnuShpNMQp8jTc-98rsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA1NiBTYWx0ZWRfX9e2gVcMSMU9y
 BVoVjzkMlJZkxEw7P7sTVUPZLcTdFWGS7n8bLGbvXcN7XHLKuo2PDbolwVCVdrtC48V0/aR53o9
 hVEvbSLZNfwZt7eGigbeHCdSNxw2VmpxOVg+HBuA1WwZ+eZ6WFKrnaTSDrDynLVEXtuBOlck3Wq
 q74LyY8VYNiKBzf3X+pmLM79R2zS8VOowEYqKWh2D0y4TEib0pmitWlcNBo/QofWmpxd9NelV2S
 esNbamxqpLLEPjqL8NQHyDJLJtQ5e6PpOdqiepbGF2pYn0LyXW3CF48Qbp/esQM7djJSAO5gpeD
 pNutZo+qCeLHrqHq4T7DwzqVIZ8qKXJU2jemoNNBuy3XmKZo96+//AjktfOlIeLEcg9E3dGKZrb
 VkxZvp1f/v30a66doxdOYjjsyN0PxA7BDQfTNu1mufPBeBI/tffmNZbYr3WUuYx76R9ViINRFxG
 CQiejMpTtapOSkBgU+Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_02,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 malwarescore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 phishscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270056

In addition to sharing headers in arch/arm64/include/{asm, uapi/asm}
also allow to share headers in arch/arm64/kvm which provide local KVM
definitions.

Co-developed-by: Andreas Grapentin <gra@linux.ibm.com>
Signed-off-by: Andreas Grapentin <gra@linux.ibm.com>
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/s390/tools/Makefile.arm64h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/s390/tools/Makefile.arm64h b/arch/s390/tools/Makefile.arm64h
index f3f8e9d9bdd8..88dcce26179c 100644
--- a/arch/s390/tools/Makefile.arm64h
+++ b/arch/s390/tools/Makefile.arm64h
@@ -7,10 +7,11 @@ arm64api := $(objtree)/arch/$(ARCH)/include/generated/arm64
 arm64uapi := $(objtree)/arch/$(ARCH)/include/generated/uapi/arm64
 
 # List of ARM64 headers to share with s390 KVM
-# Format: [uapi:]header.h or header-gen.h
+# Format: [uapi:|kvm:]header.h or header-gen.h
 #
 # * header.h - from arch/arm64/include/asm/ to arm64/
 # * uapi:header.h - from arch/arm64/include/uapi/asm/ to uapi/arm64/
+# * kvm:header.h - from arch/arm64/kvm/ to arm64/
 # * header-gen.h - generated as header-gen.h from ARM64 header header.h
 # If a header contains partial markers (#if ARM64_S390_COMMON == 1) only this part will be copied.
 # If the file does not contain any markers the whole file will be copied.
@@ -36,7 +37,9 @@ arm64-type = $(firstword $(subst :, ,$(1)))
 arm64-base = $(or $(word 2,$(subst :, ,$(1))),$(1))
 arm64-src-base = $(patsubst %-gen.h,%.h,$(call arm64-base,$(1)))
 
-arm64-src = $(srctree)/arch/arm64/include/$(if $(filter uapi,$(call arm64-type,$(1))),uapi/)asm/$(call arm64-src-base,$(1))
+arm64-src = $(if $(filter kvm,$(call arm64-type,$(1))),\
+		$(srctree)/arch/arm64/kvm/$(call arm64-src-base,$(1)),\
+		$(srctree)/arch/arm64/include/$(if $(filter uapi,$(call arm64-type,$(1))),uapi/)asm/$(call arm64-src-base,$(1)))
 arm64-dst = $(if $(filter uapi,$(call arm64-type,$(1))),$(arm64uapi),$(arm64api))/$(call arm64-base,$(1))
 
 $(foreach hdr,$(ARM64_SHARED_HEADERS),\

-- 
2.56.1

