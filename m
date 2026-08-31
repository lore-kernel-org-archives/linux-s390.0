Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91477509F0B;
	Mon, 31 Aug 2026 15:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788188475; cv=none; b=oHUF39zuYiOI1POGBMpM8d0X6Kx6+b4h6qZGSRN5wNTPOA8rU6MswMO+34RVZIK1DbwvfgIlFt8Z2idRY7vahEIQstb77EbqgWYDvU6j6iYHlQX9CbWN7KfDFwmMGbCP4wKBTJaqGueyIuIPP73GRlcUCqrmK0oVe7kcX8cVuC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788188475; c=relaxed/simple;
	bh=UD6JzfeJFW1+g4mq8CI1sGLpq5rXAfC3urPwGzLQqXU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yyx06e+wemzK1VYf37C7zjyMw3xZ5HQEFUHhYJYTIzEoOXPO66Eg8ozFdocTcfcsZR/db+B/tLeHKgqc3J9Mgvq77eFovlXDjwB4+4ARmeIxRUGTbbTr0qTZebaBHmlJXf4dFw8ruhlcINJxp2L2U/RQ6RxG2EILod6K2YJ5C7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZvqWwe4l; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZvqWwe4l"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VEZ4g02530222;
	Mon, 31 Aug 2026 14:55:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ZQ6/rBl2AXAKC3/js
	pod2HkSOUm4OUYWybZdHfBRsUE=; b=ZvqWwe4lDukSdH3NqX3qq4JQMPXZcYwcu
	stvon5Z3aVB5znTFnGnizBDSpoxp33mc8UipXqY+bpYE34lmdwH9gsMav16+dIeV
	bjSLF8/DwNyGRx2UT7ASo3yR+J76VVbMAD+ollLNTZhixo1cvkq5zLm47FkTTte0
	Rm6Dzog6QgUDne4Ie+TdrFMO5SDyyGxLl9JMOwjkQpN1gxU9znlBbdI6OLBlwdy9
	VCzICiVCMrveLWBrs/lxy0VhgtOWprk4A8aiv3xQiJAX9kdxHSWdccWse3s60Iyj
	yKhBRLIlbeQLSo8/D8bJjEZVzgQITF/LTePs+j9NtLOuFkwY0xbLA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbpx5a1u6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 14:55:49 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67VEff4Z015566;
	Mon, 31 Aug 2026 14:55:48 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gc9rq6nby-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 14:55:48 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67VEtfpE39190924
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Aug 2026 14:55:41 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 74C4020040;
	Mon, 31 Aug 2026 14:55:41 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 04D7820043;
	Mon, 31 Aug 2026 14:55:41 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 31 Aug 2026 14:55:40 +0000 (GMT)
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
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH v2 08/20] s390: tools: Allow sharing arm64/kvm headers
Date: Mon, 31 Aug 2026 16:55:23 +0200
Message-ID: <20260831145536.913567-9-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260831145536.913567-1-seiden@linux.ibm.com>
References: <20260831145536.913567-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=PPc/P/qC c=1 sm=1 tr=0 ts=6a9595f5 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=PHJEzuVwBb3QFcunwvkA:9
X-Proofpoint-GUID: UMNWpMJk2ENAtM0MjfA3-fXfYTTATyY_
X-Proofpoint-ORIG-GUID: KQSLgSP_zQtd4TJFxuGZ9mrgsqOh9Mo8
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDEyNSBTYWx0ZWRfX+sqHJLXVhD57
 bU8L4eI9jE/WLIvlGgHJEsLT1UAA+ZV7b82MFIt5YqDLefsoPqFo1Ro4hrm8mMxNUftDcggp+je
 u7LB+Q9xAdFSjImMyul5tRUX2d2ISo8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDEyNSBTYWx0ZWRfX0sjm01PStajR
 pzRuszUOTBSDwpU+H07PoFwdR0Fcqy/UP2Y3BIC6bIMnnitmiaNkVowK52zK3RyXB8MdE2uXFWZ
 xac5H7mlzHfUz79h31FUdP1e6bJ4gZi3nIACvScekyTJpc4aSWuQk5dX/Gack7vo3JnP+MAvApc
 i0de8HCiNqVRwX3HNhy4QyvC961S8ZaWJ7yMncU+4Lmi9Wbp1DXty5eEzALNvl1YvKHpi9XxehA
 kgVcRxWPODW56t0Xj6RhwRbhZBFfXAspbLLUcFIzBkxeVvIFgMamp/w1grKC7xNl39C4Cf5PwxA
 fw6fqQT1xHl7qbqOHcoprE3pxR9EDmENkv9QtZJDIQ8VOOymGuMcPoj8qjg/Jz6BgrpC3tWUejh
 tYImISK7tKXXzfTaLt9ziNYJ/lALn6OCnkUj5Q3WY8U2LKIs5Viaqd968B5rwRzGlw8L9BEoFpm
 xO9dHFCTMan7zHnYGNg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_05,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608310125

In addition to sharing headers in arch/arm64/include/{asm, uapi/asm}
also allow to share headers in arch/arm64/kvm which provide local KVM
definitions.

Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/s390/tools/Makefile.arm64h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/s390/tools/Makefile.arm64h b/arch/s390/tools/Makefile.arm64h
index 069473ea335d..49f344636e83 100644
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
 # If a header contains partial markers (#ifdef ARM64_S390_COMMON) only this part will be copied.
 # If the file does not contain any markers the whole file will be copied.
@@ -37,7 +38,9 @@ arm64-type = $(firstword $(subst :, ,$(1)))
 arm64-base = $(or $(word 2,$(subst :, ,$(1))),$(1))
 arm64-src-base = $(patsubst %-gen.h,%.h,$(call arm64-base,$(1)))
 
-arm64-src = $(srctree)/arch/arm64/include/$(if $(filter uapi,$(call arm64-type,$(1))),uapi/)asm/$(call arm64-src-base,$(1))
+arm64-src = $(if $(filter kvm,$(call arm64-type,$(1))),\
+		$(srctree)/arch/arm64/kvm/$(call arm64-src-base,$(1)),\
+		$(srctree)/arch/arm64/include/$(if $(filter uapi,$(call arm64-type,$(1))),uapi/)asm/$(call arm64-src-base,$(1)))
 arm64-dst = $(if $(filter uapi,$(call arm64-type,$(1))),$(arm64uapi),$(arm64api))/$(call arm64-base,$(1))
 
 $(foreach hdr,$(ARM64_SHARED_HEADERS),\
-- 
2.53.0

