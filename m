Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E939A219CB0;
	Fri,  4 Oct 2024 18:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066540; cv=none; b=e6Uqh8LHKsFPGF6Vh59zspNHw4dMbMKGuqVtcQuxH37vzI8Xai/9Vf64jkLKiVIiQiJMhuxE76AcR0lZ7Q+7VdcL3ElYonZsuO8m65kdPVXJmNhJo4IAWyp7YK9HniKeI6aMG+EpWOPBBPZSqFxkJpMCgS0QqB24+ThqrDypMXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066540; c=relaxed/simple;
	bh=NqcwfTBR5eoeF4EGop2ER9qqbcxFbYs8fnSyfhEMJx0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HUsJ+tEm3kdkIdY3nfoQ6SXBSjrHmrn50QTX0Ci4bbXEficcegYhEE6UlUyXFClrCLSc75s/MSZ4lii4P/4gt8RT4Q8+L8mjQ6Kbz92i6/vsmwYbbt65zwFzgGJMRUVE/LphTCQ5PxsmRhwIKx2C2Rol4cwmto9uabr150DNkS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b2GvOzAK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b2GvOzAK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 541C4C4CED4;
	Fri,  4 Oct 2024 18:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066539;
	bh=NqcwfTBR5eoeF4EGop2ER9qqbcxFbYs8fnSyfhEMJx0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b2GvOzAK1MbLlXlYfgJ/dXndWQ5acplXGPoFbbKcdSudnGIFvOSGm+thTQcs+7QiL
	 asmalkkZQH/sKT2AAEX1UdQpIFyrrA0Hx0P4Ul/FWG6bB4Fvf+Y2UPYb4iNdRfWN64
	 LRGy3TXW43ksctVed6ory8FK/46FhF2q1hor2v5iBe6pxG3ibN2vccrg90SA03vU/K
	 j9kepqn7GuF+X98aXk11Li8aS8tcIGQ+RCTlckmccq6fJEN6x0op2cdy9TDYAyaxS+
	 j2auMKJU9dsecIZDM/kt1JpMEtH/sQQZUids/oM1QNy051qHcC7MWyq2QSoaHuqjlt
	 Kv01Fqk3yDVYw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Heiko Carstens <hca@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>,
	gor@linux.ibm.com,
	agordeev@linux.ibm.com,
	nathan@kernel.org,
	akpm@linux-foundation.org,
	iii@linux.ibm.com,
	frankja@linux.ibm.com,
	sumanthk@linux.ibm.com,
	jpoimboe@kernel.org,
	linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 02/31] s390/boot: Compile all files with the same march flag
Date: Fri,  4 Oct 2024 14:28:10 -0400
Message-ID: <20241004182854.3674661-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004182854.3674661-1-sashal@kernel.org>
References: <20241004182854.3674661-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.167
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
index 0ba6468991316..cbfa9c150bd32 100644
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

