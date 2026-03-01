Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27CC719CCF7;
	Sun,  1 Mar 2026 19:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772393657; cv=none; b=XVyAnZd9e9E4mz3/c/clGpI94XxswprJNlzXSlyTGjKWIqV0v1boxgSTBtYtFsZRoSS6TgAN2W7UTqt59lOP1OVVqKoG8Eg95m9o89d0SKaY4NsE3aR9ZcfVq5s6TZQV/oRgSAtbw5Tuth3EBw34Q7qguFTdbS4FWriLFQVmk9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772393657; c=relaxed/simple;
	bh=BS3ZMwHlDBcAakH4xSCy5YZLU7NRjvFZNyLUzpzSoag=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y+jtE+xeJ0T5/vypWHr9Pa0vCzBU/scttETG2x9NVX6fYf6gOVrxlGkedOste2ipd2dMDutumLX9B9a4VQ9jW0E6NWOJh9QEEuuj4+ZXCDblG/xt1MKTrkR6GWhIJm+hBF8VTz7IlQ0Ln3k32kxwlZogdLG3AeVt7LVYrh5/+28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fBMoKZh/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fBMoKZh/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46D9BC116C6;
	Sun,  1 Mar 2026 19:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772393656;
	bh=BS3ZMwHlDBcAakH4xSCy5YZLU7NRjvFZNyLUzpzSoag=;
	h=From:To:Cc:Subject:Date:From;
	b=fBMoKZh/LWCvwocBJu3/DdC0EKLnEGnsvFsFINLPykRPzdRWemfcP23uVosUvNyQU
	 LRS5bvFJZDxSZkMlwzOw4Q9gcfCc9YeJPDZ595R+nFJuTlGbuECzRBOyUNBixZFt5D
	 iE6iCR4qfZsuoqEikqKYjCmQqHupeKgd5ohtJHLAKZG9ct5D+lRrUezJ2xNtVUijBa
	 Af6pXyHwm+tJZeEEamUZy10vahwIWTBFKZnBtk749nsFwX6r3fnDReMFMlj+wF5hhC
	 s98itWgns3vCxpdLt7eM0O1669ALiZebwBSZ8BHviYayyJ1j0E9NlR26Z/ra4XBWdC
	 Zj+TlcM/lie1Q==
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	David Laight <david.laight.linux@gmail.com>,
	kernel test robot <lkp@intel.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	x86@kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	linuxppc-dev@lists.ozlabs.org,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org,
	Heiko Carstens <hca@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	linux-s390@vger.kernel.org,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	Peter Zijlstra <peterz@infradead.org>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Andre Almeida <andrealmeid@igalia.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] uaccess: Fix build of scoped user access with const pointer
Date: Sun,  1 Mar 2026 20:33:58 +0100
Message-ID: <4e994e13b48420ef36be686458ce3512657ddb41.1772393211.git.chleroy@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2510; i=chleroy@kernel.org; h=from:subject:message-id; bh=BS3ZMwHlDBcAakH4xSCy5YZLU7NRjvFZNyLUzpzSoag=; b=owGbwMvMwCV2d0KB2p7V54MZT6slMWQumbKswe2Zuf6EuTudmqtKPfYcXrNP0W3Fv5jev4WbX s0s28pV0lHKwiDGxSArpshy/D/3rhldX1Lzp+7Sh5nDygQyhIGLUwAmkpLB8D+a+w/zg3+ige3h eQsXCTO+PXiEYyrjCsvO1ltzHW5ZPPvO8IspVKT412bj9XLyP/d83ZRVd+LX0vcHZX+6RcXGh8T 9EmYFAA==
X-Developer-Key: i=chleroy@kernel.org; a=openpgp; fpr=10FFE6F8B390DE17ACC2632368A92FEB01B8DD78
Content-Transfer-Encoding: 8bit

After converting powerpc checksum wrappers to scoped user access,
following build failure happens:

	  CC      arch/powerpc/lib/checksum_wrappers.o
	In file included from arch/powerpc/lib/checksum_wrappers.c:12:
	arch/powerpc/lib/checksum_wrappers.c: In function 'csum_and_copy_from_user':
	./include/linux/uaccess.h:691:1: error: initialization discards 'const' qualifier from pointer target type [-Werror=discarded-qualifiers]
	  691 | ({                                                                      \
	      | ^
	./include/linux/uaccess.h:755:37: note: in expansion of macro '__scoped_user_access_begin'
	  755 |         for (void __user *_tmpptr = __scoped_user_access_begin(mode, uptr, size, elbl); \
	      |                                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
	./include/linux/uaccess.h:770:9: note: in expansion of macro '__scoped_user_access'
	  770 |         __scoped_user_access(read, usrc, size, elbl)
	      |         ^~~~~~~~~~~~~~~~~~~~
	arch/powerpc/lib/checksum_wrappers.c:17:9: note: in expansion of macro 'scoped_user_read_access_size'
	   17 |         scoped_user_read_access_size(src, len, efault)
	      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~

Cast __scoped_user_access_begin() to (void __user *) to fix it.

Fixes: e497310b4ffb ("uaccess: Provide scoped user access regions")
Signed-off-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
---
Thomas, I encountered this problem while preparing some patches to start using
scope user access widely on powerpc in order to benefit more from masked user
access. Can you make this patch go into 7.0 as a fix in order avoid dependency
on this change when we start using scoped user access ?

 include/linux/uaccess.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index 1f3804245c06..5d9f6d45d301 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -752,7 +752,8 @@ USER_ACCESS_GUARD(rw)
  */
 #define __scoped_user_access(mode, uptr, size, elbl)					\
 for (bool done = false; !done; done = true)						\
-	for (void __user *_tmpptr = __scoped_user_access_begin(mode, uptr, size, elbl); \
+	for (void __user *_tmpptr = (void __user *)					\
+				    __scoped_user_access_begin(mode, uptr, size, elbl); \
 	     !done; done = true)							\
 		for (CLASS(user_##mode##_access, scope)(_tmpptr); !done; done = true)	\
 			/* Force modified pointer usage within the scope */		\
-- 
2.49.0

