Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792533151;
	b=UK8oIrcRZaCY/ZQNOXXOcuitgNHdbNxLw6Oinwk9wRdScvOjGxFZiwJwQENusHCjDCao
	 qlZSXZwxTS6WpFDW92Itz5Z8Yect8Ebrz6lhFIsbbWXvvnVBCKgLk9wXbhoRu7wnXuVaU
	 ayRsWQtlClvl+IpcjCf/BgBNh84UD0fWKeloFwA4H6mpyvxovOkGGe0r/fDVi7q3He4uW
	 yiKQCDQQqCNibiaMepmxiX171CYlqMHryY0V7KePozkAV4tRFFz+idBy1xdlSjZT0Pk5Z
	 Js4wJMVSNyikBHFtOO8iWym+E/HnzKqPRyuuaHVYhMPj5b2P1/ThixWFDQwfsHb7WYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792533151;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=f2TQwEyIJVhmcVpiQ46pzFHc4EcjHE8azLiBW1M17pY=;
	b=finQyYLVRKaC/jBS5gaPu77ZPJN93tP6A3l9+jNJ3MSobudAr/0FicIXjvvS5ggG+bUD
	 IDgdOmt2FUU3PkN/Njpo+M5wPJnCpjRMQPLea49HWbVL9dAYUDBq9poMk/PxrvtfwQR9c
	 OVQ7jRY5XTD7qBnIvdE109sHvZqnVWLdgI+JZ1xXDf4Q00gZu+G2u90rboEZ8UIVnHpSP
	 I1AVXZ+q1L6S9sx9myflGu3M5L9S5xOPc9Q9cj3SRBJReaz+9flHkMdqknAJKWHb141v3
	 Yer0936+9Dvwpf5bAfIhD/9VJns52PbARsa+LqzthLxV39dWDBMaXBX5zYNP5bk0wZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hyRq5taL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA65606A31D;
	Tue, 20 Oct 2026 21:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hyRq5taL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99D391F000CA;
	Tue, 20 Oct 2026 21:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792533151;
	bh=f2TQwEyIJVhmcVpiQ46pzFHc4EcjHE8azLiBW1M17pY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=hyRq5taLDeF5qCyezn/ZMs8iD/dqO3IRJOX+vuGTYz4Syox7oA4OutD2bQh/DNjGk
	 YEs8WPbUSZRAlDifHHuqnw7vNb09GrGRSBoQbkUE79EeXajf6J7BNY34xsmjTGwk4e
	 b+TgW3V2XzqRT+F6CAZT6H2E3CtrR04NKMzguAG/HxrekUQ9emdRbv0bxCEMjjn6RR
	 4lBVcV8eYtIPmN7hDsnvBv2ir4q79YnjbKAZRMS7bONQ6O1I8OD0DkBxTEE+OfVdzo
	 2IslSAaMJN78Huh4lEDTDhjAeP9KcOKy63dtkbPPLQwXifVgbOGuymG/Kox9y8SDoM
	 79CBPlEqb716w==
From: Nathan Chancellor <nathan@kernel.org>
Date: Tue, 20 Oct 2026 14:52:18 -0700
Subject: [PATCH 1/2] kbuild: Move testing of '-mfentry' back to Makefile
 from Kconfig
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261020-kconfig-fix-mfentry-check-v1-1-428258bc0fc0@kernel.org>
References: <20261020-kconfig-fix-mfentry-check-v1-0-428258bc0fc0@kernel.org>
In-Reply-To: <20261020-kconfig-fix-mfentry-check-v1-0-428258bc0fc0@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>
Cc: Julian Braha <julianbraha@gmail.com>, 
 "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, Kees Cook <kees@kernel.org>, 
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>, linux-s390@vger.kernel.org
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2559; i=nathan@kernel.org;
 h=from:subject:message-id; bh=3rlOolgxDsbnABo8mqr7CQaB1D430/b+8a1SsaoNxEo=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDFnXH81IX6FkmWyj7W+ztfOea7bxi5YJXhrvf6nkdvuJ3
 7//bg9DRykLgxgXg6yYIkv1Y9XjhoZzzjLeODUJZg4rE8gQBi5OAZiIjxojw/dFGvK78+7Ny5vy
 6srP+l2MgVl3jPgMjI8vextw78INDx5Ghr5Jh6q3fjGevSeEx7B1kWCV0GxR4Qzb125JXvpVbO7
 rOAA=
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

Unlike cc-option in Kbuild, cc-option in Kconfig does not test options
with either bit ('-m32' / '-m64') or endianness ('-mbig-endian' /
'-mlittle-endian') flags because which flag to use may depend on the
result of the configuration stage. This difference changes the result of
testing for '-mfentry' support when using the kernel.org s390 cross
compiler, which is configured for 32-bit by default.

  $ s390-linux-gcc -mfentry -o /dev/null -x c -c /dev/null
  cc1: error: '-mfentry' is supported only for 64-bit CPUs

arch/s390/Makefile sets '-m64' in KBUILD_CPPFLAGS early, so '-mfentry'
support was properly tested before the move to Kconfig.

  $ s390-linux-gcc -m64 -mfentry -o /dev/null -x c -c /dev/null

Ricardo reported another issue with moving this check from Kbuild to
Kconfig, as '-mfentry' is not supported for x86_32 without '-fno-pic',
which affects GCC builds that are configured with PIE enabled by
default. arch/x86/Makefile adds '-fno-pic' to KBUILD_CFLAGS, so this
works properly in Kbuild.

Move the '-mfentry' check back into Kbuild to avoid adding additional
complexity to the Kconfig entry.

Fixes: 454e00cf8ee5 ("kbuild: avoid re-running compiler and linker probes")
Reported-by: Ricardo Ribalda <ribalda@chromium.org>
Closes: https://lore.kernel.org/20261020-pie-v1-1-9be09f2324b1@chromium.org/
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
Cc: linux-s390@vger.kernel.org
---
 Makefile                  | 3 ++-
 scripts/Kconfig.toolchain | 4 ----
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index 8d23af898d44..f123ac983e62 100644
--- a/Makefile
+++ b/Makefile
@@ -1057,7 +1057,8 @@ ifdef CONFIG_FTRACE_MCOUNT_USE_RECORDMCOUNT
   endif
 endif
 ifdef CONFIG_HAVE_FENTRY
-  ifdef CONFIG_CC_HAS_MFENTRY
+  # s390-linux-gnu-gcc did not support -mfentry until gcc-9.
+  ifeq ($(call cc-option-yn, -mfentry),y)
     CC_FLAGS_FTRACE	+= -mfentry
     CC_FLAGS_USING	+= -DCC_USING_FENTRY
   endif
diff --git a/scripts/Kconfig.toolchain b/scripts/Kconfig.toolchain
index 254393d4f98a..01b49fa5d6be 100644
--- a/scripts/Kconfig.toolchain
+++ b/scripts/Kconfig.toolchain
@@ -169,10 +169,6 @@ config CC_OPT_NO_ALLOW_STORE_DATA_RACES
 config CC_HAS_MNOP_MCOUNT
 	def_bool $(cc-option,-mnop-mcount)
 
-# s390-linux-gnu-gcc did not support -mfentry until gcc-9.
-config CC_HAS_MFENTRY
-	def_bool $(cc-option,-mfentry)
-
 config LD_OPT_FORCE_GROUP_ALLOCATION
 	def_string "$(ld-option-str,--force-group-allocation)"
 

-- 
2.56.0

