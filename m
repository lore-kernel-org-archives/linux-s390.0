From: Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v2 12/16] efivars: Use in_compat_syscall to check for compat callers
Date: Mon, 25 Jan 2016 14:24:26 -0800
Message-ID: <bb33b15489a3da562dcb9c73b333152c0821a3f8.1453759363.git.luto@kernel.org>
References: <cover.1453759363.git.luto@kernel.org>
Return-path: <linux-arch-owner@vger.kernel.org>
In-Reply-To: <cover.1453759363.git.luto@kernel.org>
In-Reply-To: <cover.1453759363.git.luto@kernel.org>
References: <cover.1453759363.git.luto@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org, linux-arch <linux-arch@vger.kernel.org>, David Miller <davem@davemloft.net>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Chris Metcalf <cmetcalf@ezchip.com>, linux-parisc@vger.kernel.org, linux-mips@linux-mips.org, sparclinux@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

This should make no difference on any architecture, as x86's
historical is_compat_task behavior really did check whether the
calling syscall was a compat syscall.  x86's is_compat_task is going
away, though.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 drivers/firmware/efi/efivars.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/efivars.c b/drivers/firmware/efi/efivars.c
index 756eca8c4cf8..21c3b2016b2d 100644
--- a/drivers/firmware/efi/efivars.c
+++ b/drivers/firmware/efi/efivars.c
@@ -231,7 +231,7 @@ sanity_check(struct efi_variable *var, efi_char16_t *name, efi_guid_t vendor,
 
 static inline bool is_compat(void)
 {
-	if (IS_ENABLED(CONFIG_COMPAT) && is_compat_task())
+	if (IS_ENABLED(CONFIG_COMPAT) && in_compat_syscall())
 		return true;
 
 	return false;
-- 
2.5.0
