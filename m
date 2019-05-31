Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH] s390/purgatory: update .gitignore
Date: Fri, 31 May 2019 11:46:51 +0900
Message-Id: <20190531024651.5925-1-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Since commit 4c0f032d4963 ("s390/purgatory: Omit use of bin2c"),
kexec-purgatory.c is not generated.

purgatory and purgatory.lds are generated files, so should be ignored
by git.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/s390/purgatory/.gitignore | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/s390/purgatory/.gitignore b/arch/s390/purgatory/.gitignore
index e9e66f178a6d..04a03433c720 100644
--- a/arch/s390/purgatory/.gitignore
+++ b/arch/s390/purgatory/.gitignore
@@ -1,2 +1,3 @@
-kexec-purgatory.c
+purgatory
+purgatory.lds
 purgatory.ro
-- 
2.17.1
