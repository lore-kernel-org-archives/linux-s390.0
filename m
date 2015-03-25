From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 2/2] compiler.h: Fix word size check for READ/WRITE_ONCE
Date: Wed, 25 Mar 2015 14:15:36 +0100
Message-ID: <1427289336-22883-3-git-send-email-borntraeger@de.ibm.com>
References: <1427289336-22883-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
In-Reply-To: <1427289336-22883-1-git-send-email-borntraeger@de.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, torvalds@linux-foundation.org, paulmck@linux.vnet.ibm.com, linux-s390@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Turns out that my last rework for the word size check broke it:

I originally had the size > wordsize check in __read_once_size/
/__write_once_size as empty extern function in a newly created file
lib/access.c and marked it with a  __compiletime_warning.

Unfortunately this broke arm rpcdefconfig due to this line
CFLAGS_font.o := -Dstatic=
in
arch/arm/boot/compressed/Makefile.
This define made it impossible for the compiler to get rid of
the unused __write_once_size and __read_once_size and the linker
complained about the missing data_access_exceeds_word_size
as the compressed boot thing did not include lib/access.o.

So I wanted to be clever and changed data_access_exceeds_word_size
to a static inline function. Turns out that this actually disabled
the compiletime warning.

Next try, have it as a weak function. This actually does enable
the warning. It will create an empty data_access_exceeds_word_size
function in each object file, though and it will trigger a warning
for arm rpcdefconfig:
  CC      arch/arm/boot/compressed/font.o
include/linux/compiler.h: In function '__write_once_size':
include/linux/compiler.h:231: warning: call to 'data_access_exceeds_word_size' declared with attribute warning: data access exceeds word size and won't be atomic
include/linux/compiler.h: In function '__read_once_size':
include/linux/compiler.h:214: warning: call to 'data_access_exceeds_word_size' declared with attribute warning: data access exceeds word size and won't be atomic

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 include/linux/compiler.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 1b45e4a..37943c4 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -192,13 +192,10 @@ void ftrace_likely_update(struct ftrace_branch_data *f, int val, int expect);
 
 #include <uapi/linux/types.h>
 
-static __always_inline void data_access_exceeds_word_size(void)
 #ifdef __compiletime_warning
 __compiletime_warning("data access exceeds word size and won't be atomic")
 #endif
-;
-
-static __always_inline void data_access_exceeds_word_size(void)
+__weak notrace void data_access_exceeds_word_size(void)
 {
 }
 
-- 
2.1.4
