Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D92D3043CE;
	Mon,  1 Jun 2026 17:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780336040; cv=none; b=Wc1/jZqrZd+zoGM+FU4JDJ+uIHpKbg2LI/WEnMfHWn40/slTV33WdOrURKIiqERiz3ohoZ4/P9gibkSBd7soRQ30Ulz/czcEFqSrTTH3xKlMZkKcx29YtciXD2xZsZloBsrCvdkwyruIwHMCyFX85aSPriHm5TNAe8qJjzE2k6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780336040; c=relaxed/simple;
	bh=+s4EAgt5oeCOZsZMGoJeB1wSEWIEp0X8A2PtY7urlc8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f1isPkoNRQcZTu9PrG7qlGGyiJNkiUq59yY9EOLzs5vXxFmPAriX9UO9TLjedQsLHMilTmD4duY4e75piCEzYgW7I66ofP3QVqNOKe4n+NlhKopEcmK9s9FNhTzMXOP7zqp7N7ReB/GtZFujRPthsc6kfwlB+EKuKWXRnETKFPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kicStDHt; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kicStDHt"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 651GPMMD1959545;
	Mon, 1 Jun 2026 17:46:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=DXiytoeGyO7kgBmmb
	h6FhjAYCwg4hBJWO7+aT3ceJig=; b=kicStDHt1DxqxFy6Av6RXJKh/tCQLPr5A
	MtQDbfuWkjY6Ns6RPviTVF2zKNb5evy48LhNDS9YQPSdttH1+i+0P4xLv9Wk8pNq
	UaPllsjGU4s/u3kZb6xY5za9trjJHOIeMEwYSrwHtQtjqIrUmLDEG7dix1Ni2U6z
	c0OYvfrDJ299n6b0zL96AL8qJYV70YEIG3JrBF4U1JVrDIShADiAz1xmhvO0+z8X
	+LwuGs7lkzRNrMcEkYmWXo6GfuXtAHs9jCe/RfxYZkiocjyb1820EqAKgmHeJsop
	1hG0BMyB1dEHLQxUXc5L6FRs0s+cQPAdcXDmz/C3/8miSdb6d2W0w==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqm4t5sa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jun 2026 17:46:53 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 651Hd6m5009469;
	Mon, 1 Jun 2026 17:46:52 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4egcegf602-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jun 2026 17:46:52 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 651HkmFH16777592
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 1 Jun 2026 17:46:48 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8FB8020040;
	Mon,  1 Jun 2026 17:46:48 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4980820043;
	Mon,  1 Jun 2026 17:46:48 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  1 Jun 2026 17:46:48 +0000 (GMT)
From: Jan Polensky <japo@linux.ibm.com>
To: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        ojeda@kernel.org, peterz@infradead.org, jpoimboe@kernel.org,
        jbaron@akamai.com, aliceryhl@google.com
Cc: borntraeger@linux.ibm.com, svens@linux.ibm.com, boqun@kernel.org,
        gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
        a.hindborg@kernel.org, tmgross@umich.edu, dakr@kernel.org,
        rostedt@goodmis.org, ardb@kernel.org, linux-s390@vger.kernel.org,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        japo@linux.ibm.com (Jan Polensky)
Subject: [PATCH v5 6/6] s390: Enable Rust support
Date: Mon,  1 Jun 2026 19:46:25 +0200
Message-ID: <20260601174625.2910233-7-japo@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260601174625.2910233-1-japo@linux.ibm.com>
References: <20260601174625.2910233-1-japo@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: zLNKOTYxxpM0m-Y2XKpaULcA3P5npdVC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDE3NCBTYWx0ZWRfX6Zzla8HUBsAL
 umXcf/EdSgQ32Ufp7x+gSykULozrLT5ACZpFxQKDoQRcaAAhf277VJQI3LUcmcXSaJNTk0udI7q
 IcbF25mYJOnYBeLlS4LZFr/Uw+GZdSKhGA6XICR7gVOIFsaJmtzYMbOQWZJ/Bvs4ZUt/np4E3Ge
 nHqikgCj9jycXsGxWQky0JgnTW1yyPDqY9Y8mVdWoHYh7Zm8vRVZp0Ze2s8pWq9NPyHpxAiua4G
 OgHQpyoHRZTR77qv6DlVhu1WZ2sdCbefMhvgU1JFo9ebpHGbbXyBWSJT8+1sO7xZIdYlOCEE36j
 rskhnV0WDMIhaoDCV7jXldyjo/UftOItGAPMW+ltVrwpAZJzr5jpODfK7iwWLKYSK0XnOrfK7/I
 9pEGZGgBKkCxixXquTcfK5XPIlGHugrsWsOdPMqW4ixPuInV+faBaSzgetDm1PRzkjd4QPFVP/G
 6G8bBPovLiK5pfhyRqw==
X-Proofpoint-ORIG-GUID: Ej5xcbn-zXfQYZVXZGXCrjL6g2DHWYvf
X-Authority-Analysis: v=2.4 cv=Vf3H+lp9 c=1 sm=1 tr=0 ts=6a1dc58d cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=dVHDsLM4Y7J7NbvvS_QA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606010174

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

Acked-by: Miguel Ojeda <ojeda@kernel.org>
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
index 6e6a515d0899..4f980815e92a 100644
--- a/Documentation/rust/arch-support.rst
+++ b/Documentation/rust/arch-support.rst
@@ -19,6 +19,7 @@ Architecture   Level of support  Constraints
 ``arm64``      Maintained        Little Endian only.
 ``loongarch``  Maintained        \-
 ``riscv``      Maintained        ``riscv64`` and LLVM/Clang only.
+``s390``       Maintained        ``CONFIG_EXPOLINE`` must be disabled.
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
2.53.0

