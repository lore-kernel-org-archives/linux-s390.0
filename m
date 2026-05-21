Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9279B3B893A;
	Thu, 21 May 2026 17:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779383012; cv=none; b=s2d7hID1M2PIs85ZwoJrt9YNfBh0SuJK/6gseArefmHLwkpTZL7vqop2CdR1KKqkpbZSixVQnfyqmG8XhUECc3UOZ1NhtcGq5TixDAvwsLGFP+ivstvc/EzreCcKYZU1otqA9VP5cl3ocEP0gpR/AawNndQACphzKQSBbWCrkpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779383012; c=relaxed/simple;
	bh=AE96ysDvTfW+wL2gqr5jGuV43yJGXLi9V3PiE5t81zU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M6WNtUWY1vDG3b26Q/KOHjglOF8GDbTBkafBt4xBaLPwGTzFOcCXOIsGCxLu7aMWd5MPNY3wf8gk+KyRzUonlNOG32PLY5ZQBLRUDmylifhAy8mXsh0t8UGSx2Rkj4ryiJVbmCKPwKq6u++vteFJgSSJfpE3Io9P0IfSV2Xj+Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XKSaBRHE; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XKSaBRHE"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64LFSHLv032105;
	Thu, 21 May 2026 17:03:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=KxxQPlzD5eDc0Edg8
	cqNTUqRIgahCCo3DqOjtQPquM4=; b=XKSaBRHE6sJ7QWClf5vB5d2Q90OWiEPbO
	P+jSfEqE9DO2QlzCfTYvsVvx6lkX33rRpyNt+jWaiRrBwq/MZp2lRZt7i0bXLBwI
	jHw7M1cxseS73+vZyWiaBcCvq166Fw7I7b5M6z7wNrdgjr4auzozNlkXqoT+wI4H
	5wqyJghBRPJiqCStn37La9HIA10ZC9l2nzVIvnCYOcXKe2bzkoq3bOuxFjPiz3Dj
	knrBczUoFzHQX4EAexTNf+NEPH4Uz+SzTDE93pBOrRJGbn4PBVnOKxvhdcGf4VVE
	XEro8vTfdHvMJwOBCXDN9uEKxArhoBO8ybFum07RU4qsRY29jeKaw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h9y89yh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 May 2026 17:03:12 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64LGsEfQ013544;
	Thu, 21 May 2026 17:03:10 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e74dhw7e9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 May 2026 17:03:10 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64LH364E28377488
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 May 2026 17:03:07 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D03B92004B;
	Thu, 21 May 2026 17:03:06 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 991E82004E;
	Thu, 21 May 2026 17:03:06 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 21 May 2026 17:03:06 +0000 (GMT)
From: Jan Polensky <japo@linux.ibm.com>
To: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        ojeda@kernel.org, peterz@infradead.org, jpoimboe@kernel.org,
        jbaron@akamai.com, aliceryhl@google.com
Cc: borntraeger@linux.ibm.com, svens@linux.ibm.com, boqun@kernel.org,
        gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
        a.hindborg@kernel.org, tmgross@umich.edu, dakr@kernel.org,
        rostedt@goodmis.org, ardb@kernel.org, linux-s390@vger.kernel.org,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/4] s390: Enable Rust support
Date: Thu, 21 May 2026 18:56:22 +0200
Message-ID: <20260521165622.279953-5-japo@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260521165622.279953-1-japo@linux.ibm.com>
References: <20260521165622.279953-1-japo@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDE2NyBTYWx0ZWRfX+LMzXOb+cy5v
 Lh1CXkrJy5Vi4+l60HrAs2626FYOqdXr34TdoVi757dj9Lavu6VvZclA8Rmv3UwlXlkGWjF8GaN
 zgMAHJtrfWO/t2APTn4wTv6LFNx7Hlt67qQ96DOXwGrEJOuIXHmQVeFoVLnDoMg2CUwrvQ6jXxa
 whuy48rWhH7aX95ouOXIZg91tiHGDjiAr/EtVWGnUGzXHxhegWJviipg9sAlsC1C7JEj9KZxaG3
 EZSN2TGQpbprPdtaGdyzm94a3YTnFWalLTQkT6BlJBIG5jmFO8BKo++liQQiERnzloRtFMBCLeQ
 yZNjEHnDF0ntBGKI79EQc64P9UubszlunNV4wQs0Fb9qqwmqxUmiT+G3cH1oNrOQ8aYUiVyY3aK
 jNodCcEj6NvW4dGQLKjQro2p/oF0VfvoPWq8LQUtOhDLFH8BBWLpZg48qn/5Jrka1fnVSXLtHoI
 6C2M/4wbeMY0XBp6b8Q==
X-Authority-Analysis: v=2.4 cv=BNuDalQG c=1 sm=1 tr=0 ts=6a0f3ad0 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=OycHxKo1JGOom9522MEA:9
X-Proofpoint-ORIG-GUID: HScK07kSUhfEbLmED5oeeHq5SJX8D0Rx
X-Proofpoint-GUID: mhuHPDlcwYUX93kb127XP2xxRQDSzmpP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210167

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
index 297976b41088..8b712cd85fcd 100644
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
+mflags := -march=$(march-name-y)
 
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
index b96ec2d379b6..296acf8f71aa 100755
--- a/scripts/min-tool-version.sh
+++ b/scripts/min-tool-version.sh
@@ -31,7 +31,11 @@ llvm)
 	fi
 	;;
 rustc)
-	echo 1.85.0
+	if [ "$SRCARCH" = "s390" ]; then
+		echo 1.96.0
+	else
+		echo 1.85.0
+	fi
 	;;
 bindgen)
 	echo 0.71.1
-- 
2.51.0

