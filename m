Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF7C32D0EE
	for <linux-s390@vger.kernel.org>; Mon,  2 Mar 2026 13:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772458131; cv=none; b=kxYFMr3oc8qvoN/6Q2jAAD8mCGWfXvHtbIREVn9W7ykiXyJ4+Cv8InNB4NNW+3FjasaebnFIXQ217KEEIDdsLd7v/6sts1amg8C1uhmtFQHN3GDCNQRhITssz0Fnv5aRWelH3bZEVzYGnLr/M158FSOrrSjubbPM9CyJ7iR3nm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772458131; c=relaxed/simple;
	bh=/vw1o/tgaqgXlymwWBfNq0gtWd8qwqkw++waY5+/oWo=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=shbsRoCRMfdXnziC/NzqGtgzuCVaMbvSrTSeFN6X1X3yAwEV/K9CzSJBBx6zTmWcsDfQgkmoeESoEl3T9nwTt1N5sDbyS8vw8yEWqJJEFQlX7b+24kzRUwBGZOu4txG3fv3uNNDwcKInK1diIdZubSCMklZMNNOwGpHXTt5irh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=pfYMBjDr; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="pfYMBjDr"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1vx3Jw-003bl5-Bn; Mon, 02 Mar 2026 14:28:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector2; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To
	:Message-Id:Date:Subject:To:From;
	bh=7cjIEqDAe6MTPa2yql8v8L5e7mjA+roV54bcD0Te3Y4=; b=pfYMBjDrxtDGIuseYyHfRKhdlY
	wxGF1P6KMNx6ObRuGN6ZC4wsAsw2hRQ/moIf5DlPtJ4OdcFDVbbZfYlXOaHjFV7UCzwT+RFpEzmxH
	qWXXDA4ONYMAsNi6ePJIKCLTLb8MT74QJNuqJ6sdh6Tq/4chxS0eBiQlHuCMuynNI3HaM4H+mIWD+
	MfMF3aDGj96f3wG2XdkXTZREX71lpkYTiXzClo5Rgz07oqNqD1x1j5Sva9T4TMi13zMpJPrbafMuY
	y2tpwibHn24xe00sD61gejFnTEEHP9CDzwhRxR2Z0zEadqZouQs+4eZ2DS+v9eN8M5kbcQczC3zdl
	N7bMTDQg==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1vx3Jv-0003tI-NG; Mon, 02 Mar 2026 14:28:23 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vx3Ji-008UTR-OY; Mon, 02 Mar 2026 14:28:10 +0100
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
Subject: [PATCH v2 3/5] uaccess.h: Use with() and and_with() in __scoped_user_access()
Date: Mon,  2 Mar 2026 13:27:53 +0000
Message-Id: <20260302132755.1475451-4-david.laight.linux@gmail.com>
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

Wrappers for autoterminating nested for() loops have been added to
compiler.h, use them to hide the gory details.

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
 include/linux/uaccess.h | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index 809e4f7dfdbd..64bc2492eb99 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -736,13 +736,10 @@ static __always_inline void __scoped_user_rw_access_end(const void *p)
  *
  * Don't use directly. Use scoped_masked_user_$MODE_access() instead.
  */
-#define __scoped_user_access(mode, uptr, size, elbl)				\
-for (bool done = false; !done; done = true)					\
-	for (auto _tmpptr = __scoped_user_access_begin(mode, uptr, size, elbl);	\
-	     !done; done = true)						\
-		/* Force modified pointer usage within the scope */		\
-		for (const auto uptr  __cleanup(__scoped_user_##mode##_access_end) = \
-		     _tmpptr; !done; done = true)
+#define __scoped_user_access(mode, uptr, size, elbl)					\
+	with (auto _tmpptr = __scoped_user_access_begin(mode, uptr, size, elbl))	\
+		/* Force modified pointer usage within the scope */			\
+		and_with (const auto uptr __cleanup(__scoped_user_##mode##_access_end) = _tmpptr)
 
 /**
  * scoped_user_read_access_size - Start a scoped user read access with given size
-- 
2.39.5

