Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH] s390: vmlinux.lds: move JUMP_TABLE_DATA into output section
Date: Sun, 30 Sep 2018 18:49:50 +0200
Message-Id: <20180930164950.3841-1-ard.biesheuvel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-s390@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux@roeck-us.net, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Kees Cook <keescook@chromium.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Jessica Yu <jeyu@kernel.org>, Peter Zijlstra <peterz@infradead.org>
List-ID: <linux-s390.vger.kernel.org>

Commit e872267b8bcbb179 ("jump_table: move entries into ro_after_init
region") moved the __jump_table input section into the __ro_after_init
output section, but inadvertently put the macro in the wrong place in
the s390 linker script. Let's fix that.

Fixes: e872267b8bcbb179 ("jump_table: move entries into ro_after_init region")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Jessica Yu <jeyu@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/s390/kernel/vmlinux.lds.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kernel/vmlinux.lds.S b/arch/s390/kernel/vmlinux.lds.S
index 4042bbf3f9ad..457713f48734 100644
--- a/arch/s390/kernel/vmlinux.lds.S
+++ b/arch/s390/kernel/vmlinux.lds.S
@@ -64,9 +64,9 @@ SECTIONS
 	__start_ro_after_init = .;
 	.data..ro_after_init : {
 		 *(.data..ro_after_init)
+		JUMP_TABLE_DATA
 	}
 	EXCEPTION_TABLE(16)
-	JUMP_TABLE_DATA
 	. = ALIGN(PAGE_SIZE);
 	__end_ro_after_init = .;
 
-- 
2.17.1
