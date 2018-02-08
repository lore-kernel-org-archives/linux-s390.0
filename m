Return-Path: <linux-kbuild-owner@vger.kernel.org>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [RFC PATCH 6/7] kconfig: add basic environments to evaluate C flags in Kconfig
Date: Fri,  9 Feb 2018 01:19:11 +0900
Message-Id: <1518106752-29228-7-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1518106752-29228-1-git-send-email-yamada.masahiro@socionext.com>
References: <1518106752-29228-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kbuild-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-kbuild/>
List-Post: <mailto:linux-kbuild@vger.kernel.org>
To: linux-kbuild@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Kees Cook <keescook@chromium.org>, Nicolas Pitre <nicolas.pitre@linaro.org>, "Luis R . Rodriguez" <mcgrof@suse.com>, Randy Dunlap <rdunlap@infradead.org>, Ulf Magnusson <ulfalizer@gmail.com>, Sam Ravnborg <sam@ravnborg.org>, Michal Marek <michal.lkml@markovi.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Pavel Machek <pavel@ucw.cz>, linux-s390@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Add minimum environments to start with.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 init/Kconfig | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/init/Kconfig b/init/Kconfig
index 64f9dd2..31fbc6e 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -25,6 +25,14 @@ config CC_VERSION_TEXT
 	  text does not match, silentoldconfig will be invoked because we need
 	  to re-compute compiler capabilities and symbols that depends on them.
 
+config srctree
+	string
+	option env="srctree"
+
+config CC
+	string
+	option env="CC"
+
 config CONSTRUCTORS
 	bool
 	depends on !UML
-- 
2.7.4
