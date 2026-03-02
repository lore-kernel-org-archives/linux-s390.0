Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17BF13859F8;
	Mon,  2 Mar 2026 13:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772458126; cv=none; b=BMIMwSyzBd7wM3PkQ6QrESUh5Plmpm/2eIDa/8azbIKw6QyZr96W59XFJqiWR+7JdcZn9ZfZKmfg99nq5RCsdBMNs7PCyKQ+q0we2LjR5+lGl4lkScueIUIsTuVzHxKXFen+Q9ZQPaVTSHOVNRGNifVYxA4PIyBGg3ryiDU3ACU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772458126; c=relaxed/simple;
	bh=+8jUA1pIhBmowlO1jxzQc7kmakXtjz0IlbAyic50DRM=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j0vg0bTjdUS1+HNVax7W0QJ+FA0xNTU9ixpmA6NAcXCKgPmoSEvL31yoFh0JkvnEz0hoBdxlhJDHfpW3IRZlYpY4oP8WIUlaHxDhFmOli2DNBdps4+8++PVXITw1LYfftMMD8CZ48Ld1EC+EgdeWoCdk46nb43bJvXAXNMF1qjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=WNKhqMbv; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="WNKhqMbv"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1vx3Jw-003ZDu-8P; Mon, 02 Mar 2026 14:28:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector2; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To
	:Message-Id:Date:Subject:To:From;
	bh=gjy8VzZho98qn7gDgAP8doLSL96/gQyRo0dz/GrFn7E=; b=WNKhqMbveWP+K3PmL7U2N/ZjgC
	CRkQIzZeOHgk5k2HnpMOotG24V0hTJvr6OyT7PqOl2Dm4nA4urOR3OWpHobtPgDSlAr7nWHDbEPwt
	tSQA2Q7DOv2iXbAH5WTGLe+U0ioyZh17n7ApFQAc/XkWeA54mqXch5dDYlog2nx7U8hngM1sDJ11s
	tNRhThx7ejIxz+T6UR24ZnQQNxcdrxg2eAm04+CH6ikcFduLKZhvpfDwjgDgloDXZCXGRn/V4LJTr
	wYXmGMM3HPxkLojYe9Z7XsbLpV20rgoagwKiSMoPtipXBJZirNaVllMP0+p8CbfIcQhj00YQaveaN
	J3vQaaWw==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1vx3Ju-0003tB-95; Mon, 02 Mar 2026 14:28:22 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vx3Jg-008UTR-FQ; Mon, 02 Mar 2026 14:28:08 +0100
From: david.laight.linux@gmail.com
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Andre Almeida <andrealmeid@igalia.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Christian Brauner <brauner@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Darren Hart <dvhart@infradead.org>,
	David Laight <david.laight.linux@gmail.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Heiko Carstens <hca@linux.ibm.com>,
	Jan Kara <jack@suse.cz>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <pjw@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Russell King <linux@armlinux.org.uk>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	x86@kernel.org,
	Kees Cook <kees@kernel.org>,
	akpm@linux-foundation.org
Subject: [PATCH v2 1/5] uaccess: Fix scoped_user_read_access() for 'pointer to const'
Date: Mon,  2 Mar 2026 13:27:51 +0000
Message-Id: <20260302132755.1475451-2-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260302132755.1475451-1-david.laight.linux@gmail.com>
References: <20260302132755.1475451-1-david.laight.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Laight <david.laight.linux@gmail.com>

If a 'const struct foo __user *ptr' is used for the address passed
to scoped_user_read_access() then you get a warning/error
uaccess.h:691:1: error: initialization discards 'const' qualifier
    from pointer target type [-Werror=discarded-qualifiers]
for the
    void __user *_tmpptr = __scoped_user_access_begin(mode, uptr, size, elbl)
assignment.

Fix by using 'auto' for both _tmpptr and the redeclaration of uptr.
Replace the CLASS() with explicit __cleanup() functions on uptr.

Fixes: e497310b4ffb "(uaccess: Provide scoped user access regions)"
Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
 include/linux/uaccess.h | 54 +++++++++++++++--------------------------
 1 file changed, 20 insertions(+), 34 deletions(-)

diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index 1f3804245c06..809e4f7dfdbd 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -647,36 +647,22 @@ static inline void user_access_restore(unsigned long flags) { }
 /* Define RW variant so the below _mode macro expansion works */
 #define masked_user_rw_access_begin(u)	masked_user_access_begin(u)
 #define user_rw_access_begin(u, s)	user_access_begin(u, s)
-#define user_rw_access_end()		user_access_end()
 
 /* Scoped user access */
-#define USER_ACCESS_GUARD(_mode)				\
-static __always_inline void __user *				\
-class_user_##_mode##_begin(void __user *ptr)			\
-{								\
-	return ptr;						\
-}								\
-								\
-static __always_inline void					\
-class_user_##_mode##_end(void __user *ptr)			\
-{								\
-	user_##_mode##_access_end();				\
-}								\
-								\
-DEFINE_CLASS(user_ ##_mode## _access, void __user *,		\
-	     class_user_##_mode##_end(_T),			\
-	     class_user_##_mode##_begin(ptr), void __user *ptr)	\
-								\
-static __always_inline class_user_##_mode##_access_t		\
-class_user_##_mode##_access_ptr(void __user *scope)		\
-{								\
-	return scope;						\
-}
 
-USER_ACCESS_GUARD(read)
-USER_ACCESS_GUARD(write)
-USER_ACCESS_GUARD(rw)
-#undef USER_ACCESS_GUARD
+/* Cleanup wrapper functions */
+static __always_inline void __scoped_user_read_access_end(const void *p)
+{
+	user_read_access_end();
+};
+static __always_inline void __scoped_user_write_access_end(const void *p)
+{
+	user_write_access_end();
+};
+static __always_inline void __scoped_user_rw_access_end(const void *p)
+{
+	user_access_end();
+};
 
 /**
  * __scoped_user_access_begin - Start a scoped user access
@@ -750,13 +736,13 @@ USER_ACCESS_GUARD(rw)
  *
  * Don't use directly. Use scoped_masked_user_$MODE_access() instead.
  */
-#define __scoped_user_access(mode, uptr, size, elbl)					\
-for (bool done = false; !done; done = true)						\
-	for (void __user *_tmpptr = __scoped_user_access_begin(mode, uptr, size, elbl); \
-	     !done; done = true)							\
-		for (CLASS(user_##mode##_access, scope)(_tmpptr); !done; done = true)	\
-			/* Force modified pointer usage within the scope */		\
-			for (const typeof(uptr) uptr = _tmpptr; !done; done = true)
+#define __scoped_user_access(mode, uptr, size, elbl)				\
+for (bool done = false; !done; done = true)					\
+	for (auto _tmpptr = __scoped_user_access_begin(mode, uptr, size, elbl);	\
+	     !done; done = true)						\
+		/* Force modified pointer usage within the scope */		\
+		for (const auto uptr  __cleanup(__scoped_user_##mode##_access_end) = \
+		     _tmpptr; !done; done = true)
 
 /**
  * scoped_user_read_access_size - Start a scoped user read access with given size
-- 
2.39.5

