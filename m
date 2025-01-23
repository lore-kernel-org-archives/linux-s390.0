Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A8335953;
	Thu, 23 Jan 2025 02:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737600905; cv=none; b=ZK5VGSAftowy60kOTnXcFe6OHfZcQy3xAYCRqaDeUs2bbmyBDVcNK/nZ4g2c7ctrWH7YgJPQZJ9TbL0mrXg+srfpDJ7tZVjKJbd3JaBpepWuBJZ8iwg3zbXVdM1utVe0IJ8ke5O9kxeAeyr6ABe+hyYHaRMfw9fq0tZamouzfrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737600905; c=relaxed/simple;
	bh=aP0wv4Tcdl0htzXTlWdd2dIsiad+/SokA8d20fknp/U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=snFK4qMwFd5jJUbPX8qhr2sute+H+Dl+Dbczq08Q55uqSPaL3re5/hDFdIalLmuyMNnK5fpkmZZvF8wK4/yNAEFMuaALZ9Sas7QejsafDEyshI4OtRBnp0E1H8WQnD8zXJIhN7cIdzPwhBwxyhuwUF5DbmoXkFV/6UkqrxCFfaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oNqK1gVd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oNqK1gVd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89ABEC4CED2;
	Thu, 23 Jan 2025 02:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737600904;
	bh=aP0wv4Tcdl0htzXTlWdd2dIsiad+/SokA8d20fknp/U=;
	h=From:Date:Subject:To:Cc:From;
	b=oNqK1gVdOwZ5RcPQhjVEkDB3l4UEXnTBUCvwCdy6+Eq6AdPHLeg4FtkJBe801Js77
	 sUJmgTRqtiYaPqfYUuS5mnAZwNCEDO43qS46PiPW8Ut6sQKxDqe4Bpx8lrF6RZvshD
	 bonsEvROMaQeSVM2sRKEAnAC6qhqn6KO+GhVVlBfDKNz41QZyXYo4GPR5YP/A4B+lM
	 CoOKMMq/s//P51qSK3MwTxijOJh+sYcH6DoacrUr6cCVh4Yn2vlZY3iHmK2A2lblur
	 ontSt/IYumU6zC5S8fgJ3j0t3/W++XD7bGcMPtPPjXzKmqO7tjsmWGizD/A90t/xif
	 A2UJMik9cinXQ==
From: Nathan Chancellor <nathan@kernel.org>
Date: Wed, 22 Jan 2025 19:54:27 -0700
Subject: [PATCH] s390: Add '-std=gnu11' to decompressor and purgatory
 CFLAGS
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250122-s390-fix-std-for-gcc-15-v1-1-8b00cadee083@kernel.org>
X-B4-Tracking: v=1; b=H4sIAGKvkWcC/x2MQQqAIBAAvxJ7bkEtkfpKdDBday8WbkQQ/T3pO
 DAzDwgVJoGxeaDQxcJ7rqDbBsLm80rIsTIYZazSxqB0g8LEN8oZMe0F1xBQW1R+Sb4PPjnroNZ
 HoWr952l+3w/R2jNDaQAAAA==
X-Change-ID: 20250122-s390-fix-std-for-gcc-15-0abfa4caf757
To: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4084; i=nathan@kernel.org;
 h=from:subject:message-id; bh=aP0wv4Tcdl0htzXTlWdd2dIsiad+/SokA8d20fknp/U=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDOkT17dFZs6VVUk20X65XXruygBeBqZkI7l5XWULvDtuR
 P2/3Piko5SFQYyLQVZMkaX6sepxQ8M5ZxlvnJoEM4eVCWQIAxenAExk9nJGhikvfx2MvV/5Oae/
 XzJA5mPI1d1OR8ysHqtWHzLbncw0cR0jwyOfJVpyFboL2zMyHnBGdsZ3l09qWJw36YXQ3SWvlpe
 HcQAA
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

GCC changed the default C standard dialect from gnu17 to gnu23,
which should not have impacted the kernel because it explicitly requests
the gnu11 standard in the main Makefile. However, there are certain
places in the s390 code that use their own CFLAGS without a '-std='
value, which break with this dialect change because of the kernel's own
definitions of bool, false, and true conflicting with the C23 reserved
keywords.

  include/linux/stddef.h:11:9: error: cannot use keyword 'false' as enumeration constant
     11 |         false   = 0,
        |         ^~~~~
  include/linux/stddef.h:11:9: note: 'false' is a keyword with '-std=c23' onwards
  include/linux/types.h:35:33: error: 'bool' cannot be defined via 'typedef'
     35 | typedef _Bool                   bool;
        |                                 ^~~~
  include/linux/types.h:35:33: note: 'bool' is a keyword with '-std=c23' onwards

Add '-std=gnu11' to the decompressor and purgatory CFLAGS to eliminate
these errors and make the C standard version of these areas match the
rest of the kernel.

Cc: stable@vger.kernel.org
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
I only see one other error in various files with a recent GCC 15.0.1
snapshot, which I can eliminate by dropping the version part of the
condition for CONFIG_GCC_ASM_FLAG_OUTPUT_BROKEN. Is this a regression of
the fix for the problem of GCC 14.2.0 or is something else doing on
here?

  arch/s390/include/asm/bitops.h: Assembler messages:
  arch/s390/include/asm/bitops.h:60: Error: operand 1: syntax error; missing ')' after base register
  arch/s390/include/asm/bitops.h:60: Error: operand 2: syntax error; ')' not allowed here
  arch/s390/include/asm/bitops.h:60: Error: junk at end of line: `,4'
  arch/s390/include/asm/bitops.h:60: Error: operand 1: syntax error; missing ')' after base register
  arch/s390/include/asm/bitops.h:60: Error: operand 2: syntax error; ')' not allowed here
  arch/s390/include/asm/bitops.h:60: Error: junk at end of line: `,64'
  arch/s390/include/asm/bitops.h:60: Error: operand 1: syntax error; missing ')' after base register
  arch/s390/include/asm/bitops.h:60: Error: operand 2: syntax error; ')' not allowed here
  arch/s390/include/asm/bitops.h:60: Error: junk at end of line: `,4'
  make[6]: *** [scripts/Makefile.build:194: fs/gfs2/glock.o] Error 1
---
 arch/s390/Makefile           | 2 +-
 arch/s390/purgatory/Makefile | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/Makefile b/arch/s390/Makefile
index 3f25498dac65..5fae311203c2 100644
--- a/arch/s390/Makefile
+++ b/arch/s390/Makefile
@@ -22,7 +22,7 @@ KBUILD_AFLAGS_DECOMPRESSOR := $(CLANG_FLAGS) -m64 -D__ASSEMBLY__
 ifndef CONFIG_AS_IS_LLVM
 KBUILD_AFLAGS_DECOMPRESSOR += $(if $(CONFIG_DEBUG_INFO),$(aflags_dwarf))
 endif
-KBUILD_CFLAGS_DECOMPRESSOR := $(CLANG_FLAGS) -m64 -O2 -mpacked-stack
+KBUILD_CFLAGS_DECOMPRESSOR := $(CLANG_FLAGS) -m64 -O2 -mpacked-stack -std=gnu11
 KBUILD_CFLAGS_DECOMPRESSOR += -DDISABLE_BRANCH_PROFILING -D__NO_FORTIFY
 KBUILD_CFLAGS_DECOMPRESSOR += -D__DECOMPRESSOR
 KBUILD_CFLAGS_DECOMPRESSOR += -fno-delete-null-pointer-checks -msoft-float -mbackchain
diff --git a/arch/s390/purgatory/Makefile b/arch/s390/purgatory/Makefile
index 24eccaa29337..bdcf2a3b6c41 100644
--- a/arch/s390/purgatory/Makefile
+++ b/arch/s390/purgatory/Makefile
@@ -13,7 +13,7 @@ CFLAGS_sha256.o := -D__DISABLE_EXPORTS -D__NO_FORTIFY
 $(obj)/mem.o: $(srctree)/arch/s390/lib/mem.S FORCE
 	$(call if_changed_rule,as_o_S)
 
-KBUILD_CFLAGS := -fno-strict-aliasing -Wall -Wstrict-prototypes
+KBUILD_CFLAGS := -std=gnu11 -fno-strict-aliasing -Wall -Wstrict-prototypes
 KBUILD_CFLAGS += -Wno-pointer-sign -Wno-sign-compare
 KBUILD_CFLAGS += -fno-zero-initialized-in-bss -fno-builtin -ffreestanding
 KBUILD_CFLAGS += -Os -m64 -msoft-float -fno-common

---
base-commit: b2832409e00b6330781458d7db0080508a35a9a8
change-id: 20250122-s390-fix-std-for-gcc-15-0abfa4caf757

Best regards,
-- 
Nathan Chancellor <nathan@kernel.org>

