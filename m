Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9990C3BB136;
	Tue, 26 May 2026 10:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779790739; cv=none; b=lTkiA7+t/XjBfWCbRGISS9MsJS635TLXHaqXEj2/SCUqmlBjQ4ETqb64OrGxFNy3A9xJ/ikhMnATWSuIX1AZlQF2gtshTl+oP+EnbxvH4C5rQR9CtywIZJxL/otx+6s2SA1GSuDFrkNa9I67TifQoCSqYQwUfS8T85U/bKADkPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779790739; c=relaxed/simple;
	bh=BkP4KfqvBcO8uvYrQ5+VyCzUTk5iDSsO4MtQo+ki9uc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FlydRG+NSPwd3pIgtRchM/Ekmh0CiTJBtvxum+JpnhJtwzgsz4nnRVMTb50XnwfMFGnmjzBLoUNReG32hKiRkKn2gRG6Vpt1h7j+IO1XH2t+AztMr/U/Jd7ze5CbPbP0vAE10edwMTksUtYEEvwHPGxgZw9oiVqdr2kCI96WqIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SgImZ1cQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SgImZ1cQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DF0C1F000E9;
	Tue, 26 May 2026 10:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779790738;
	bh=Np20joqyiqZ4myd6HsLZYUk6od6eMUxfTV3gzTY2y1k=;
	h=From:To:Cc:Subject:Date;
	b=SgImZ1cQ7tVCTVHh2tnuxZzMGtpaqJ4XDxrm9JJcPR2zUk/RuNyzSi0sLXXjBoJ5Z
	 noudrmSPlAu8AUb/crgsnGuI8IPwJezxQfzGUkoR53Pl8m+LU8HZqy1fc1BUVpZMCt
	 frWCfHMz7JKRwas/gfRH0uBxNeZtDP5PHNmenVclwPN91YIMqxNn2yHnqIb7gjMrM2
	 KqApmvar19RN1gvtmbbgN+nGla78VFLRPQCqw5fnz6zo4oxW5853XAlholrGF5yZ4Y
	 SwmPirRGhEurke9ZYQZTh+Z9XYBKEa5Ty6lTnwuSxDTP8PTCaMLMEVEz0X1EhYyDFo
	 3nPFA2ceke/MA==
From: Arnd Bergmann <arnd@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kbuild@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>,
	linux-s390@vger.kernel.org,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Bjorn Andersson <andersson@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] err.h: use __always_inline on all error pointer helpers
Date: Tue, 26 May 2026 12:18:41 +0200
Message-Id: <20260526101851.2495110-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

While testing randconfig builds on s390, I came across a
link failure with CONFIG_DMA_SHARED_BUFFER disabled:

ERROR: modpost: "dma_buf_put" [drivers/iommu/iommufd/iommufd.ko] undefined!

The problem here is that IS_ERR() is not inlined and dead code elimination
fails as a consequence.

The err.h helpers all turn into a trivial assignment ot a bit mask
and should never result in a function call, so force them to always be
inline. This should generally result in better object code aside from
avoiding the link failure above.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/err.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/err.h b/include/linux/err.h
index 8c37be0620ab..d3e38d5b3a98 100644
--- a/include/linux/err.h
+++ b/include/linux/err.h
@@ -36,7 +36,7 @@
  *
  * Return: A pointer with @error encoded within its value.
  */
-static inline void * __must_check ERR_PTR(long error)
+static __always_inline void * __must_check ERR_PTR(long error)
 {
 	return (void *) error;
 }
@@ -60,7 +60,7 @@ static inline void * __must_check ERR_PTR(long error)
  * @ptr: An error pointer.
  * Return: The error code within @ptr.
  */
-static inline long __must_check PTR_ERR(__force const void *ptr)
+static __always_inline long __must_check PTR_ERR(__force const void *ptr)
 {
 	return (long) ptr;
 }
@@ -73,7 +73,7 @@ static inline long __must_check PTR_ERR(__force const void *ptr)
  * @ptr: The pointer to check.
  * Return: true if @ptr is an error pointer, false otherwise.
  */
-static inline bool __must_check IS_ERR(__force const void *ptr)
+static __always_inline bool __must_check IS_ERR(__force const void *ptr)
 {
 	return IS_ERR_VALUE((unsigned long)ptr);
 }
@@ -87,7 +87,7 @@ static inline bool __must_check IS_ERR(__force const void *ptr)
  *
  * Like IS_ERR(), but also returns true for a null pointer.
  */
-static inline bool __must_check IS_ERR_OR_NULL(__force const void *ptr)
+static __always_inline bool __must_check IS_ERR_OR_NULL(__force const void *ptr)
 {
 	return unlikely(!ptr) || IS_ERR_VALUE((unsigned long)ptr);
 }
@@ -99,7 +99,7 @@ static inline bool __must_check IS_ERR_OR_NULL(__force const void *ptr)
  * Explicitly cast an error-valued pointer to another pointer type in such a
  * way as to make it clear that's what's going on.
  */
-static inline void * __must_check ERR_CAST(__force const void *ptr)
+static __always_inline void * __must_check ERR_CAST(__force const void *ptr)
 {
 	/* cast away the const */
 	return (void *) ptr;
@@ -122,7 +122,7 @@ static inline void * __must_check ERR_CAST(__force const void *ptr)
  *
  * Return: The error code within @ptr if it is an error pointer; 0 otherwise.
  */
-static inline int __must_check PTR_ERR_OR_ZERO(__force const void *ptr)
+static __always_inline int __must_check PTR_ERR_OR_ZERO(__force const void *ptr)
 {
 	if (IS_ERR(ptr))
 		return PTR_ERR(ptr);
-- 
2.39.5

