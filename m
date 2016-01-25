From: Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v2 15/16] uhid: Check write() bitness using in_compat_syscall
Date: Mon, 25 Jan 2016 14:24:29 -0800
Message-ID: <8c4d604b079099acb0df9ad849d53b589ea7aa9a.1453759363.git.luto@kernel.org>
References: <cover.1453759363.git.luto@kernel.org>
Return-path: <sparclinux-owner@vger.kernel.org>
In-Reply-To: <cover.1453759363.git.luto@kernel.org>
In-Reply-To: <cover.1453759363.git.luto@kernel.org>
References: <cover.1453759363.git.luto@kernel.org>
Sender: sparclinux-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org, linux-arch <linux-arch@vger.kernel.org>, David Miller <davem@davemloft.net>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Chris Metcalf <cmetcalf@ezchip.com>, linux-parisc@vger.kernel.org, linux-mips@linux-mips.org, sparclinux@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

uhid changes the format expected in write() depending on bitness.
It should check the syscall bitness directly.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 drivers/hid/uhid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/uhid.c b/drivers/hid/uhid.c
index e094c572b86e..16b6f11a0700 100644
--- a/drivers/hid/uhid.c
+++ b/drivers/hid/uhid.c
@@ -384,7 +384,7 @@ struct uhid_create_req_compat {
 static int uhid_event_from_user(const char __user *buffer, size_t len,
 				struct uhid_event *event)
 {
-	if (is_compat_task()) {
+	if (in_compat_syscall()) {
 		u32 type;
 
 		if (get_user(type, buffer))
-- 
2.5.0
