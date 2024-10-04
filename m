Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0601E32DC;
	Fri,  4 Oct 2024 18:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728065922; cv=none; b=Ydu/K6OJC3km6u4tl8+BlumMgVG/GojqAk9jhiLEhfuox5NQhMdgwcp3FGQg89rL5lQETYyskArac1SVwuKhTuA0A8xQ5j0yTHRL05A9iVmB5uKqrvtF5AJ97x4TpmbGCNdxGDO200RN7RJLyHh8Dt5dRDnZhucvwr7st1tn+Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728065922; c=relaxed/simple;
	bh=JzL+RlxzO7qSi45b22AfzImZk0BZNomq95pkaHw3GJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iqT405GuDXi0xaa3qZleTnWZsBAIH6JHn0tLz/lQzXnwPvjHyuYCjXvLbh6Awqvcfj4RDt5M5uTf41JZaHn7krGRFH5qo/EPdOtbCVSeW6ZmaJmGVnr/xuH11kH7EwqR3jdcNsLAV3X6bbQ9/tDjKaShSy435T2uCG37Xb0Vjfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A2kUz8n4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A2kUz8n4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5B45C4CECC;
	Fri,  4 Oct 2024 18:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728065922;
	bh=JzL+RlxzO7qSi45b22AfzImZk0BZNomq95pkaHw3GJs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A2kUz8n4X1uDVZZ8A36WBsVSK0QlfNqnJbvXOun/VpisEf3sUNo2+nEg0Etq0IRcC
	 QngniMd3XIKnSGlt8QrHUWxkIvQpIWUS6Uk6rJB1NKJnIazd6MpldCA639iJdKDn/2
	 QON3ybbf1llc2Viwbyo+TWOOWn+RBqcj240KCSthMe3rwiyQzWEqnuuAXWQa4fIYvL
	 rpJQSE36dSl32RmvfyUsWyhMarIq3ScObRvD0+3fJ1Z5Tmv5GYLPLluR/vTJou8VFx
	 M2pHgOF1pgzVQh7QFX6PJIG6pLt88QYId5AVIvcafXZGPzpKhTXBFlddEHSe5xjLV5
	 luxbPKr/YWp5A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Heiko Carstens <hca@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>,
	gor@linux.ibm.com,
	agordeev@linux.ibm.com,
	nathan@kernel.org,
	sumanthk@linux.ibm.com,
	iii@linux.ibm.com,
	jpoimboe@kernel.org,
	frankja@linux.ibm.com,
	linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 07/76] s390/boot: Compile all files with the same march flag
Date: Fri,  4 Oct 2024 14:16:24 -0400
Message-ID: <20241004181828.3669209-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004181828.3669209-1-sashal@kernel.org>
References: <20241004181828.3669209-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.2
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
index 4f476884d3404..f1b2989cc7cca 100644
--- a/arch/s390/boot/Makefile
+++ b/arch/s390/boot/Makefile
@@ -11,11 +11,8 @@ KASAN_SANITIZE := n
 KCSAN_SANITIZE := n
 KMSAN_SANITIZE := n
 
-KBUILD_AFLAGS := $(KBUILD_AFLAGS_DECOMPRESSOR)
-KBUILD_CFLAGS := $(KBUILD_CFLAGS_DECOMPRESSOR)
-
 #
-# Use minimum architecture for als.c to be able to print an error
+# Use minimum architecture level so it is possible to print an error
 # message if the kernel is started on a machine which is too old
 #
 ifndef CONFIG_CC_IS_CLANG
@@ -24,16 +21,10 @@ else
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

