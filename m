Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B53C2009A2;
	Fri,  4 Oct 2024 18:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066313; cv=none; b=B+/futPQcL64hxCoL8+Z83qSVZBEHKaMa6awnK/4Q2oIi+ZQNepYw5JQE566d00fxgCQaVov8zaxthjQmQWBoePL9+Og8xzBra1kZ4lFpTiLtNKO+BSeirPc6GDE9fZfcShhcaczI+iOg/RBkbiogKY1M/BepSZyN20vW6LI7PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066313; c=relaxed/simple;
	bh=/xEHbD1S9fJifTO2lK5CNHKP/Ub5l6y09bgLXiTTMk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y/+rzHOwVLNCRo1jEbY8jR0395KMIObMpWC1xO0ywm/ThKGxLIYE5+spV7qsu3YDxaqhlKqtXlY3y2ZD91CioxclLjQf5DEFhnCQhVrGcxlj3/TKCK1Jo8NkK3ZWv1hWC8kSFypzBToXv747V0O8f0GzMqUi1nmfS1/GAk6tw+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=abG/5t4p; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="abG/5t4p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D98F7C4CECE;
	Fri,  4 Oct 2024 18:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066313;
	bh=/xEHbD1S9fJifTO2lK5CNHKP/Ub5l6y09bgLXiTTMk0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=abG/5t4pKbTkt74KteSLZsxVxDbeLA7WsrsTr3L6o6ni6yl8o4NUONjpltFzc88Xb
	 X2+y4f+HtdhR3qpjC4NGI1Sy9hynvWit8b63a+9VkduoIDy1GcU1cboO8WTDoHRA7k
	 AqWUfoJiRTP8QYQOcGV6dg2/wY8VT+Tt2BeLGCKH2G+sd0q2S2vjVSWPupCd7rJECE
	 XCUxMGTWrqXumXI/96ozcB7ihVWC3V/ITbOYjtFdq/Foxj0ktVcDWI+MqRmAPyIHXv
	 ofJqjXHZyqvUAkJvOhMLgZEor+xLIRDLkOWRNOdiBKaLKQirlkz0gMVMSRhoeYf3tM
	 iO2rHmVi7IFmg==
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
Subject: [PATCH AUTOSEL 6.6 05/58] s390/boot: Compile all files with the same march flag
Date: Fri,  4 Oct 2024 14:23:38 -0400
Message-ID: <20241004182503.3672477-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004182503.3672477-1-sashal@kernel.org>
References: <20241004182503.3672477-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.54
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
index c7c81e5f92189..e4def3a6c6cca 100644
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

