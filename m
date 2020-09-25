Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727063AbgIYEwB (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 25 Sep 2020 00:52:01 -0400
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 1/9] compat.h: fix a spelling error in <linux/compat.h>
Date: Fri, 25 Sep 2020 06:51:38 +0200
Message-Id: <20200925045146.1283714-2-hch@lst.de>
In-Reply-To: <20200925045146.1283714-1-hch@lst.de>
References: <20200925045146.1283714-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>, Arnd Bergmann <arnd@arndb.de>, David Howells <dhowells@redhat.com>, David Laight <David.Laight@aculab.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, linux-block@vger.kernel.org, linux-scsi@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-aio@kvack.org, io-uring@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org

There is no compat_sys_readv64v2 syscall, only a compat_sys_preadv64v2
one.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/compat.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/compat.h b/include/linux/compat.h
index b354ce58966e2d..654c1ec36671a4 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -812,7 +812,7 @@ asmlinkage ssize_t compat_sys_pwritev2(compat_ulong_t fd,
 		const struct compat_iovec __user *vec,
 		compat_ulong_t vlen, u32 pos_low, u32 pos_high, rwf_t flags);
 #ifdef __ARCH_WANT_COMPAT_SYS_PREADV64V2
-asmlinkage long  compat_sys_readv64v2(unsigned long fd,
+asmlinkage long  compat_sys_preadv64v2(unsigned long fd,
 		const struct compat_iovec __user *vec,
 		unsigned long vlen, loff_t pos, rwf_t flags);
 #endif
-- 
2.28.0
