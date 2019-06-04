Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:34448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727350AbfFDXXs (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 4 Jun 2019 19:23:48 -0400
From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 06/36] s390/kasan: fix strncpy_from_user kasan checks
Date: Tue,  4 Jun 2019 19:23:01 -0400
Message-Id: <20190604232333.7185-6-sashal@kernel.org>
In-Reply-To: <20190604232333.7185-1-sashal@kernel.org>
References: <20190604232333.7185-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Vasily Gorbik <gor@linux.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sasha Levin <sashal@kernel.org>, linux-s390@vger.kernel.org

From: Vasily Gorbik <gor@linux.ibm.com>

[ Upstream commit 01eb42afb45719cb41bb32c278e068073738899d ]

arch/s390/lib/uaccess.c is built without kasan instrumentation. Kasan
checks are performed explicitly in copy_from_user/copy_to_user
functions. But since those functions could be inlined, calls from
files like uaccess.c with instrumentation disabled won't generate
kasan reports. This is currently the case with strncpy_from_user
function which was revealed by newly added kasan test. Avoid inlining of
copy_from_user/copy_to_user when the kernel is built with kasan support
to make sure kasan checks are fully functional.

Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/include/asm/uaccess.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/s390/include/asm/uaccess.h b/arch/s390/include/asm/uaccess.h
index ad6b91013a05..5332f628c1ed 100644
--- a/arch/s390/include/asm/uaccess.h
+++ b/arch/s390/include/asm/uaccess.h
@@ -56,8 +56,10 @@ raw_copy_from_user(void *to, const void __user *from, unsigned long n);
 unsigned long __must_check
 raw_copy_to_user(void __user *to, const void *from, unsigned long n);
 
+#ifndef CONFIG_KASAN
 #define INLINE_COPY_FROM_USER
 #define INLINE_COPY_TO_USER
+#endif
 
 #ifdef CONFIG_HAVE_MARCH_Z10_FEATURES
 
-- 
2.20.1
