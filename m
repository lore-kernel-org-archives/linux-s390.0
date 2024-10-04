Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8D31EFEF8;
	Fri,  4 Oct 2024 18:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066135; cv=none; b=hcb+Km8c+Axiq76pk8MRs2BD1f+WrMsI1BcuFhggF7Rvf22jxXuD65oYd7IJcT/E8s1MG3MJm8Kccgnld47+p/0GZTLXdpe+WCk4csID6otKVL1UnClVp3K07jZBRrido17xaw0z49C2K3IURbWmnGWR/IywGxWp59nE2oOsPe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066135; c=relaxed/simple;
	bh=BkZTvcqrJr1kVa8DRGYLQE675x9DtbRiL3f0kgBfEac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e2i2FyxiW1AaZfzRQ22uvB9M0G+xfJbjgVF5a6pnH4BFaJcqycGXExOaviHqd0DAAK9dDjhP+RDV1QOnT05jDLLeEa6U9WhF3fi4yqAm36SipN1XdS3l3rOccsxxT979MgPR/ZXC1Rj8rWYVIcXcLk+vWE75czRWWp/hyIl2aIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m9jzluZS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m9jzluZS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74860C4CEC6;
	Fri,  4 Oct 2024 18:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066134;
	bh=BkZTvcqrJr1kVa8DRGYLQE675x9DtbRiL3f0kgBfEac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m9jzluZSwWw7siuxucK5M/x9tmEusZx3wZAwy4wgKEU3TWehfbzlm/oWlIKEc3oJv
	 27Ivm1iSidTak8SqA6DmXp5gcQW/U2Mv3k8K8I5BQueVnmuMfdB9YKBWpq2CIsbOgu
	 zWErPMuPbAxL1vvnBx6UH7i74fPfHt1m21jfniGkBrdmp1RA4VChgdoCCLozOCtzB2
	 Q7SDhavgahboLbGbGYN/Q3cxWF1L/CCCEKx392FF5/K4vEhvqe4wP2AtqmP+ckXRdU
	 1on4AZOpU68zRTbnHLL5ozJIagJDYS8tEfM4hNE0YWS1nMfT4pT7XBws1+iFj5s5KJ
	 ooxaPUnMu8itg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Heiko Carstens <hca@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>,
	gor@linux.ibm.com,
	agordeev@linux.ibm.com,
	nathan@kernel.org,
	glider@google.com,
	iii@linux.ibm.com,
	frankja@linux.ibm.com,
	sumanthk@linux.ibm.com,
	jpoimboe@kernel.org,
	linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 6.10 07/70] s390/boot: Compile all files with the same march flag
Date: Fri,  4 Oct 2024 14:20:05 -0400
Message-ID: <20241004182200.3670903-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004182200.3670903-1-sashal@kernel.org>
References: <20241004182200.3670903-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.13
Content-Transfer-Encoding: 8bit

From: Heiko Carstens <hca@linux.ibm.com>

[ Upstream commit fccb175bc89a0d37e3ff513bb6bf1f73b3a48950 ]

Only a couple of files of the decompressor are compiled with the
minimum architecture level. This is problematic for potential function
calls between compile units, especially if a target function is within
a compile until compiled for a higher architecture level, since that
may lead to an unexpected operation exception.

Therefore compile all files of the decompressor for the same (minimum)
architecture level.

Reviewed-by: Sven Schnelle <svens@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/boot/Makefile | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/arch/s390/boot/Makefile b/arch/s390/boot/Makefile
index 070c9b2e905ff..b3f4f41816185 100644
--- a/arch/s390/boot/Makefile
+++ b/arch/s390/boot/Makefile
@@ -9,11 +9,8 @@ UBSAN_SANITIZE := n
 KASAN_SANITIZE := n
 KCSAN_SANITIZE := n
 
-KBUILD_AFLAGS := $(KBUILD_AFLAGS_DECOMPRESSOR)
-KBUILD_CFLAGS := $(KBUILD_CFLAGS_DECOMPRESSOR)
-
 #
-# Use minimum architecture for als.c to be able to print an error
+# Use minimum architecture level so it is possible to print an error
 # message if the kernel is started on a machine which is too old
 #
 ifndef CONFIG_CC_IS_CLANG
@@ -22,16 +19,10 @@ else
 CC_FLAGS_MARCH_MINIMUM := -march=z10
 endif
 
-ifneq ($(CC_FLAGS_MARCH),$(CC_FLAGS_MARCH_MINIMUM))
-AFLAGS_REMOVE_head.o		+= $(CC_FLAGS_MARCH)
-AFLAGS_head.o			+= $(CC_FLAGS_MARCH_MINIMUM)
-AFLAGS_REMOVE_mem.o		+= $(CC_FLAGS_MARCH)
-AFLAGS_mem.o			+= $(CC_FLAGS_MARCH_MINIMUM)
-CFLAGS_REMOVE_als.o		+= $(CC_FLAGS_MARCH)
-CFLAGS_als.o			+= $(CC_FLAGS_MARCH_MINIMUM)
-CFLAGS_REMOVE_sclp_early_core.o	+= $(CC_FLAGS_MARCH)
-CFLAGS_sclp_early_core.o	+= $(CC_FLAGS_MARCH_MINIMUM)
-endif
+KBUILD_AFLAGS := $(filter-out $(CC_FLAGS_MARCH),$(KBUILD_AFLAGS_DECOMPRESSOR))
+KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_MARCH),$(KBUILD_CFLAGS_DECOMPRESSOR))
+KBUILD_AFLAGS += $(CC_FLAGS_MARCH_MINIMUM)
+KBUILD_CFLAGS += $(CC_FLAGS_MARCH_MINIMUM)
 
 CFLAGS_sclp_early_core.o += -I$(srctree)/drivers/s390/char
 
-- 
2.43.0

