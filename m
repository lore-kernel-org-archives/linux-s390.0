Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669341DAC86;
	Fri,  4 Oct 2024 18:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066611; cv=none; b=gs3KB6Sa7h52UQtpt3W7I2Yv2YoKm45ewwi88CsaOQAEmoXqBJu7guDF7YVDk21/ADcEtJUSdEiAN4Xv4H0ijFKOvQ0Q6LLYj0H9L1ogCdakvvvYjbIDejT+CYHvuh2jMC7pTzBuSwbSz2NmTohalttWIP0caMcddcuQm3EPoHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066611; c=relaxed/simple;
	bh=/HJChuA+UwaKKNj96ZJZiKhTQqrC2wONWRpyxCCnJWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EwKomXJS/zw6Cw6L9h7baeXheltCQP6XPDRBmgpUYqOXgEiDH+fnBdieLAWRIWxMyesLiX8o1xIHquzAyQqiJif1sAPc/+JrqlxvCej5TILAmz/KP19kvDwm9s7aPMgsWnItoXiPNm5QZCoMeLzYQmEI/YCV7eNo/Legt8dePw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CIYdJ7iy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CIYdJ7iy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7959DC4CEDA;
	Fri,  4 Oct 2024 18:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066611;
	bh=/HJChuA+UwaKKNj96ZJZiKhTQqrC2wONWRpyxCCnJWE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CIYdJ7iyh+3IVzufNo1i+jXngkDy05ZK7N2E1okBvIiHul9dGhMF/Q52xc5rqZutb
	 GWB7gw5AsZyPxT664v/+s2MOor5vhB12WM5uw1ujkiRfTP/B0n7lJyoTxbMDttpkxu
	 97XcWVv6bOzeWAs3h474MUrP3tonbxoKSDHF5bS+VTzH5cOoaaXVtWJ+C/C1EOdknr
	 Bo/FxOeFI63vYKwmm+XlUmW8P+SURCgTuUo2lcqsIrrpcn5jATVgP0QppRnwpb91PA
	 UCSwGmSVqCPJVvsd19WTBqCEIz3dGCkz9YVgQfiQ7eunleha9vWOhIchRlD8jBRfF4
	 Bh/sOlVuNN5Hg==
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
	jpoimboe@kernel.org,
	sumanthk@linux.ibm.com,
	frankja@linux.ibm.com,
	linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 02/26] s390/boot: Compile all files with the same march flag
Date: Fri,  4 Oct 2024 14:29:28 -0400
Message-ID: <20241004183005.3675332-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004183005.3675332-1-sashal@kernel.org>
References: <20241004183005.3675332-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.226
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
index 41a64b8dce252..6294ddc2ff891 100644
--- a/arch/s390/boot/Makefile
+++ b/arch/s390/boot/Makefile
@@ -8,11 +8,8 @@ GCOV_PROFILE := n
 UBSAN_SANITIZE := n
 KASAN_SANITIZE := n
 
-KBUILD_AFLAGS := $(KBUILD_AFLAGS_DECOMPRESSOR)
-KBUILD_CFLAGS := $(KBUILD_CFLAGS_DECOMPRESSOR)
-
 #
-# Use minimum architecture for als.c to be able to print an error
+# Use minimum architecture level so it is possible to print an error
 # message if the kernel is started on a machine which is too old
 #
 ifndef CONFIG_CC_IS_CLANG
@@ -21,16 +18,10 @@ else
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

