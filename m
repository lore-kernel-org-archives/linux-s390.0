Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793981335;
	b=LxUtbqiXSo12VGYLnGtqfF1UZzUYf7jUWZtbg5eWsooeo/JSB78ctXbfOgvRM4AIVM/h
	 SBYNySRscqdjESsrVHva7lyyqp7fLHh+l9ePP2TTGGtQ2M3grAV0D+FkeEQtPLwP15BrS
	 RhnifQUfWnyGqdAi6Y7uWjzd5uECqUVR/o0ZSeyBEwOwfAOdkLamk2OCFEohDcxvc/uRT
	 pvHgNN+CCApTFj/FxmjfIQyx05M/oklluP9+0UxEP0qBmzryI2diDzCLSEcy6T1I6eV9M
	 0swhr2Y9X1nVreVK4j1jwDlxyQauaiz9S7PsfkcVsZAJ/qUddiiEhJoX7damR762grg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793981335;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-TM-AS-GCONF:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=dWgwJYW4tPhnJbqp7uT6/iL8mSoy6IIsneojKqkuyMA=;
	b=l1ZeP9YtfxE7dm0qta0iQE7AmoXv/IM2jln4DLjrZ2226FjPjAAiuVay9NTLS5RvIqRB
	 pfJR4LmJg+wDF20b5CKDrpGPdv3jZaMsTdlH7XtLxm7opOnQuHJ+yB3LcpZNocgfR+W8N
	 fWAAIGMtfvUEZYkIoT0qtI6gN/frA8xgiVyAn0THUjDSbETFmGYEXM7b6+jXGu1ltjA2Z
	 iOskS5I8KskHZ9ozFYKhXvs6UWFckaKj+FMpsnA7i3oR873Rfzbxlns9sqc2HN0iqYMM8
	 DEXtv5b1JoMADkX4HmrxMaBzP0qoVD2UfLtHUzhVG4Mpr3NhGzl6EWdXkz95onYJo0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=cRdAveco;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5369B606A337;
	Fri,  6 Nov 2026 16:08:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5369B606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=cRdAveco
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6FEj0s2936575;
	Fri, 6 Nov 2026 16:08:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=dWgwJY
	W4tPhnJbqp7uT6/iL8mSoy6IIsneojKqkuyMA=; b=cRdAvecoQJvb/fBNuPg1VE
	PaqYxdjuk7rSICEFnkkdFjdX28WIAsM8qplhuN/g3LnJgggBSdiYsXHDismtcluC
	zffGdMDuq5hS6Wpb8XrNyWRIKvRE6BisuJ7Kfo6omg6taDO1OBwSIiLFY9UDtQFq
	u0wRlxHTLSe4zIAFzKx0iFOkldJ1HMMWv/XjXDadZeRvxdLzN01MB3thx9Ryo1Oo
	eiYrO6XcQs5VklBpQP4U4cUczrt/osm+pcdPscpaKmtX92nlRBBCvwiKm9nMdtmL
	brQ4Q47aJ1muouhvtnqrMBiBpL2Fyr7UbeB1ypn87juYol7DafCCWenhnNj9ZHgw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hs3rcdhfk-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 16:08:23 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6F4rX82390066;
	Fri, 6 Nov 2026 16:08:22 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hs7h13we9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 16:08:21 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A6G8HOL25821486
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 6 Nov 2026 16:08:17 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 97A582004B;
	Fri,  6 Nov 2026 16:08:17 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3B9A220063;
	Fri,  6 Nov 2026 16:08:17 +0000 (GMT)
Received: from a46lp73.lnxne.boe (unknown [9.87.84.240])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  6 Nov 2026 16:08:17 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
Date: Fri, 06 Nov 2026 17:07:42 +0100
Subject: [PATCH v3 09/23] s390: tools: Share arm64/kvm headers
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
Message-Id: <20261106-sysreg-v3-9-75e95980fb10@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: 9lFL0Al8kRf0xXqWT2D7cmZh22WXLVZ9
X-Authority-Analysis: v=2.4 cv=A635rKWG c=1 sm=1 tr=0 ts=6aedfb77 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=JnuShpNMQp8jTc-98rsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 9lFL0Al8kRf0xXqWT2D7cmZh22WXLVZ9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA2MiBTYWx0ZWRfX5+ICAKsTkQVq
 rjztcZAMRPHVmTvhJzQtfE3/augRBLRzsrGNq21n/JvhtjnLPHugkIPzo5kQzVhvXR4FleApvy3
 4CR5rMODWvh/LsqeeNwFGkIvKv1ZsDGSjMVQ4OYX0Z3kFw5GCmvrYbGArNb6uqhw/oSndfK7aEB
 mx7lr3gUZbiNmb44fikF9X7NxEs5gINYGUAvvdcgd9h/v1CCqEnzDzJ+bJBtb2DqnLuCmdPibtA
 CVUo9kCjfr9Y1m+YwSBLJPMmIij24u1a42BaxhpEJrMpg5x+KkT46xpb9WoMwc8xAgxR54CaM8p
 3h9XHfkIqsYbU6uLnUQYuwFYJ9nr9dvAyYT8eo9ctx8SHllPpQRq5t3D0fIUBj+HiQoLUx/ZgKa
 0e8yIXs+S8qEaLkPUnj64TPVutotMXTVj40b/9znlamJLp8qhkSpv108Efd1/9+f3w2gyp38YhQ
 pQwkQ0MQ6FTu2IIBwHA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA2MiBTYWx0ZWRfX+hTRKzNYwRbk
 WZAibP8w1o4HKfClC2A+MOFRZP296SVdc8kkvd2XA5Im6yRic17BYBAq7T2s4+rtDtRcHFpqGh5
 PzkAc0DJ2hA3Nf1DbFmLKYyn+FuYwH4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0
 malwarescore=0 adultscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060062

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
2.56.0

