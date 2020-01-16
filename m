Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-pj1-f65.google.com ([209.85.216.65]:35691 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730538AbgAPG0o (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 16 Jan 2020 01:26:44 -0500
Received: by mail-pj1-f65.google.com with SMTP id s7so1088365pjc.0
        for <linux-s390@vger.kernel.org>; Wed, 15 Jan 2020 22:26:43 -0800 (PST)
From: Daniel Axtens <dja@axtens.net>
Subject: [PATCH v2 3/3] kasan: initialise array in kasan_memcmp test
Date: Thu, 16 Jan 2020 17:26:25 +1100
Message-Id: <20200116062625.32692-4-dja@axtens.net>
In-Reply-To: <20200116062625.32692-1-dja@axtens.net>
References: <20200116062625.32692-1-dja@axtens.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org, kasan-dev@googlegroups.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, linux-xtensa@linux-xtensa.org, x86@kernel.org, dvyukov@google.com, christophe.leroy@c-s.fr, Daniel Axtens <dja@axtens.net>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Alexander Potapenko <glider@google.com>

memcmp may bail out before accessing all the memory if the buffers
contain differing bytes. kasan_memcmp calls memcmp with a stack array.
Stack variables are not necessarily initialised (in the absence of a
compiler plugin, at least). Sometimes this causes the memcpy to bail
early thus fail to trigger kasan.

Make sure the array initialised to zero in the code.

No other test is dependent on the contents of an array on the stack.

Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 lib/test_kasan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/test_kasan.c b/lib/test_kasan.c
index a130d75b9385..519b0f259e97 100644
--- a/lib/test_kasan.c
+++ b/lib/test_kasan.c
@@ -619,7 +619,7 @@ static noinline void __init kasan_memcmp(void)
 {
 	char *ptr;
 	size_t size = 24;
-	int arr[9];
+	int arr[9] = {};
 
 	pr_info("out-of-bounds in memcmp\n");
 	ptr = kmalloc(size, GFP_KERNEL | __GFP_ZERO);
-- 
2.20.1
