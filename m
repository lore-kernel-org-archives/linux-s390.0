Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F153839A9;
	Tue, 12 May 2026 11:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778583626; cv=none; b=qdH2G0EZRvcW3Fbf5dCnbfYsMSHvFhhns+nNIskwZEJS7hq0VfxYUi793chSCpYiFsAvNwMtRMGYx7yUliB0Cb0o9WP7ttDH/N7yYqe6YfAEDRHGvlnHCw2K8R/0dMhn0iE7a6207j53iD9bX4OF2nJ0fnwHZvP6AFpWeKUVKqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778583626; c=relaxed/simple;
	bh=q2R+EVNo1o9PgkGYpslbUjkN2z64oCvqM+PH3e97aBc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UZR6cAF6PQvY/Qs0VR8A8yEItLMl0tBd9nd7UE/qSdlu805etHVLZflsc/989yvJ0pMhgkPoJqTCTRA1n/LX+66rqT3Yb6eb8BDb4RHQPy814wwHb7qrYoZw5ybNcbnBGlnBl3GASDDI7T00JZ9YzsqljsVnrerkGMi594qPdmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OeHSfNZz; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OeHSfNZz"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64BK7PvM3180075;
	Tue, 12 May 2026 10:59:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=k0wTovysRtG6sqD3D
	xP+NT+DiL9VptC1pj45zPv0kww=; b=OeHSfNZz44h6NlwkS7d39u6aEkmujteYg
	b8ZbI21SEoNCbQKnsBX8rUWn5xLBjBbNfgZmOmQv9HypDPGe1KVvY5iEg3OP+Y1T
	YI7sxiyQYSLVlp0c8CFOcCfQtWVr+K17RmH5zjtnrxbUoOBrzOO65dwFFTVu8A/d
	5nFn61X2CwJX3N3piZkQCfLii7u9vqoGDHFKk/ZyZ8+JrFPrBTFJwA2wHIObqx0Z
	XFZXGldodUi+quv0gQna+Wdxwfj/Fgg4kBLziPqTaNZ/pCKQRIJpdNDAgU8CKHnA
	O5AeC2Un7nr4W7zzxEmZsN+1prfLSkSCZNRbq7ibfgVLKGAqEstbg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e3nv6jhks-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 May 2026 10:59:38 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64CAdYnw007502;
	Tue, 12 May 2026 10:59:37 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e3nfgjtcn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 May 2026 10:59:37 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64CAxXvl29950678
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 May 2026 10:59:34 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DB39320040;
	Tue, 12 May 2026 10:59:33 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8BA8D2004D;
	Tue, 12 May 2026 10:59:33 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 12 May 2026 10:59:33 +0000 (GMT)
From: Jan Polensky <japo@linux.ibm.com>
To: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        ojeda@kernel.org, peterz@infradead.org, jpoimboe@kernel.org,
        jbaron@akamai.com, aliceryhl@google.com
Cc: borntraeger@linux.ibm.com, svens@linux.ibm.com, boqun@kernel.org,
        gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
        a.hindborg@kernel.org, tmgross@umich.edu, dakr@kernel.org,
        rostedt@goodmis.org, ardb@kernel.org, linux-s390@vger.kernel.org,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] s390: enable Rust support
Date: Tue, 12 May 2026 12:59:20 +0200
Message-ID: <20260512105920.2426293-5-japo@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260512105920.2426293-1-japo@linux.ibm.com>
References: <20260512105920.2426293-1-japo@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=Us1T8ewB c=1 sm=1 tr=0 ts=6a03081a cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=OycHxKo1JGOom9522MEA:9
X-Proofpoint-GUID: 0qdPOTKxaVl0fE-6NJ_YAIzcXSUzmurX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDEwOSBTYWx0ZWRfXyy4DR4X8iF+V
 opC6FbN6RGvfnkHMHGJrbQ1x43ezBlRdEtRN7m9tgwlQFKwk5jcorSaDE78869xF1gE08PAomlE
 gN7pT2CfDIko+Spy/RGx8Fiwx/9JQ3F5qVpsz5T+6sCEStKtCg2asSUJsVgccVT3xktPy3ZI9nV
 IksDWNETNWg6Uo26l/cS6wvHQJPglIyVQa+L3BxfcH7jurLQjtUp9O4HnToFKDy/eOWJYcLAZ0F
 G2Yidr955B1NEkOFCXBGOgw2H7Wyi1/ACXOsVdnCo0dN7nhBOGtI6v19ijtZKPz0deatHiKhq85
 kqhIr6TZU15aUj7s+f60cArmvb5VXPh1HOfBnph1OXRCt163TTwiXI658lkuqPI230PLKufNhXZ
 xg5aWOG1krviw8H6QsQph3urlCM0LHbbrSw4O3akWBtohkTvLq0C6AgNEVfYfikhT9FHA4L21oB
 FHH0493yEqE1oNOmMnA==
X-Proofpoint-ORIG-GUID: j-eSqocwXA4keioqoHmZemb-aQmd4aaC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605120109

Enable building Rust code on s390 by wiring the architecture into the
kernel Rust infrastructure.

Add s390 to the Rust arch support documentation, provide the s390 Rust
target and required compiler flags, and set the bindgen target for
arch/s390. Adjust the Rust target generation and minimum rustc version
gating so the s390 setup is handled explicitly.

The Rust toolchain uses the "s390x" triple naming for the 64 bit target.

Rust support is currently incompatible with CONFIG_EXPOLINE, which
relies on compiler support for the -mindirect-branch= and
-mfunction_return= options. Therefore, select HAVE_RUST only when
EXPOLINE is disabled.

Signed-off-by: Jan Polensky <japo@linux.ibm.com>
---
 Documentation/rust/arch-support.rst |  1 +
 arch/s390/Kconfig                   |  1 +
 arch/s390/Makefile                  | 28 +++++++++++++++++-----------
 rust/Makefile                       |  1 +
 scripts/generate_rust_target.rs     |  2 ++
 scripts/min-tool-version.sh         |  6 +++++-
 6 files changed, 27 insertions(+), 12 deletions(-)

diff --git a/Documentation/rust/arch-support.rst b/Documentation/rust/arch-support.rst
index 6e6a515d0899..ce9804b8226c 100644
--- a/Documentation/rust/arch-support.rst
+++ b/Documentation/rust/arch-support.rst
@@ -19,6 +19,7 @@ Architecture   Level of support  Constraints
 ``arm64``      Maintained        Little Endian only.
 ``loongarch``  Maintained        \-
 ``riscv``      Maintained        ``riscv64`` and LLVM/Clang only.
+``s390``       Maintained        \-
 ``um``         Maintained        \-
 ``x86``        Maintained        ``x86_64`` only.
 =============  ================  ==============================================
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index ecbcbb781e40..26951781d74d 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -248,6 +248,7 @@ config S390
 	select HAVE_RELIABLE_STACKTRACE
 	select HAVE_RETHOOK
 	select HAVE_RSEQ
+	select HAVE_RUST if !EXPOLINE
 	select HAVE_SAMPLE_FTRACE_DIRECT
 	select HAVE_SAMPLE_FTRACE_DIRECT_MULTI
 	select HAVE_SETUP_PER_CPU_AREA
diff --git a/arch/s390/Makefile b/arch/s390/Makefile
index 297976b41088..c393c22c47c8 100644
--- a/arch/s390/Makefile
+++ b/arch/s390/Makefile
@@ -35,25 +35,31 @@ KBUILD_CFLAGS_DECOMPRESSOR += $(if $(CONFIG_DEBUG_INFO),-g)
 KBUILD_CFLAGS_DECOMPRESSOR += $(if $(CONFIG_DEBUG_INFO_DWARF4), $(call cc-option, -gdwarf-4,))
 KBUILD_CFLAGS_DECOMPRESSOR += $(if $(CONFIG_CC_NO_ARRAY_BOUNDS),-Wno-array-bounds)
 
+KBUILD_RUSTFLAGS += --target=s390x-unknown-none-softfloat -Zpacked-stack -Ctarget-feature=+backchain
+
 UTS_MACHINE	:= s390x
 STACK_SIZE	:= $(if $(CONFIG_KASAN),65536,$(if $(CONFIG_KMSAN),65536,16384))
 CHECKFLAGS	+= -D__s390__ -D__s390x__
 
 export LD_BFD
 
-mflags-$(CONFIG_MARCH_Z10)    := -march=z10
-mflags-$(CONFIG_MARCH_Z196)   := -march=z196
-mflags-$(CONFIG_MARCH_ZEC12)  := -march=zEC12
-mflags-$(CONFIG_MARCH_Z13)    := -march=z13
-mflags-$(CONFIG_MARCH_Z14)    := -march=z14
-mflags-$(CONFIG_MARCH_Z15)    := -march=z15
-mflags-$(CONFIG_MARCH_Z16)    := -march=z16
-mflags-$(CONFIG_MARCH_Z17)    := -march=z17
+march-name-$(CONFIG_MARCH_Z10)   := z10
+march-name-$(CONFIG_MARCH_Z196)  := z196
+march-name-$(CONFIG_MARCH_ZEC12) := zEC12
+march-name-$(CONFIG_MARCH_Z13)   := z13
+march-name-$(CONFIG_MARCH_Z14)   := z14
+march-name-$(CONFIG_MARCH_Z15)   := z15
+march-name-$(CONFIG_MARCH_Z16)   := z16
+march-name-$(CONFIG_MARCH_Z17)   := z17
 
-export CC_FLAGS_MARCH := $(mflags-y)
+mflags += -march=$(march-name-y)
 
-aflags-y += $(mflags-y)
-cflags-y += $(mflags-y)
+export CC_FLAGS_MARCH := $(mflags)
+
+aflags-y += $(mflags)
+cflags-y += $(mflags)
+
+KBUILD_RUSTFLAGS += -Ctarget-cpu=$(march-name-y)
 
 cflags-$(CONFIG_MARCH_Z10_TUNE)		+= -mtune=z10
 cflags-$(CONFIG_MARCH_Z196_TUNE)	+= -mtune=z196
diff --git a/rust/Makefile b/rust/Makefile
index b9e9f512cec3..77460502f576 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -403,6 +403,7 @@ BINDGEN_TARGET_x86	:= x86_64-linux-gnu
 BINDGEN_TARGET_arm64	:= aarch64-linux-gnu
 BINDGEN_TARGET_arm	:= arm-linux-gnueabi
 BINDGEN_TARGET_loongarch	:= loongarch64-linux-gnusf
+BINDGEN_TARGET_s390	:= s390x-linux-gnu
 # This is only for i386 UM builds, which need the 32-bit target not -m32
 BINDGEN_TARGET_i386	:= i386-linux-gnu
 BINDGEN_TARGET_um	:= $(BINDGEN_TARGET_$(SUBARCH))
diff --git a/scripts/generate_rust_target.rs b/scripts/generate_rust_target.rs
index 38b3416bb979..8f1df6819d0b 100644
--- a/scripts/generate_rust_target.rs
+++ b/scripts/generate_rust_target.rs
@@ -256,6 +256,8 @@ fn main() {
         }
     } else if cfg.has("LOONGARCH") {
         panic!("loongarch uses the builtin rustc loongarch64-unknown-none-softfloat target");
+    } else if cfg.has("S390") {
+        panic!("s390 uses the builtin rustc s390x-unknown-none-softfloat target");
     } else {
         panic!("Unsupported architecture");
     }
diff --git a/scripts/min-tool-version.sh b/scripts/min-tool-version.sh
index b96ec2d379b6..b1020cb9b755 100755
--- a/scripts/min-tool-version.sh
+++ b/scripts/min-tool-version.sh
@@ -31,7 +31,11 @@ llvm)
 	fi
 	;;
 rustc)
-	echo 1.85.0
+	if [ "$SRCARCH" = "s390" ]; then
+		echo 1.97.0-nightly
+	else
+		echo 1.85.0
+	fi
 	;;
 bindgen)
 	echo 0.71.1
-- 
2.51.0

