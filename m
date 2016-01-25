From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH v4 1/3] x86: kallsyms: disable absolute percpu symbols on !SMP
Date: Mon, 25 Jan 2016 15:19:30 +0100
Message-ID: <1453731572-18448-2-git-send-email-ard.biesheuvel@linaro.org>
References: <1453731572-18448-1-git-send-email-ard.biesheuvel@linaro.org>
Return-path: <linux-arch-owner@vger.kernel.org>
In-Reply-To: <1453731572-18448-1-git-send-email-ard.biesheuvel@linaro.org>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, x86@kernel.org, keescook@chromium.org, akpm@linux-foundation.org, mingo@kernel.org, hpa@zytor.com, heiko.carstens@de.ibm.com, benh@kernel.crashing.org, mpe@ellerman.id.au, mmarek@suse.cz, rusty@rustcorp.com.au, arnd@arndb.de, linux-arch@vger.kernel.org, linux@roeck-us.net
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
List-ID: <linux-s390.vger.kernel.org>

scripts/kallsyms.c has a special --absolute-percpu command line
option which deals with the zero based per cpu offsets that are
used when building for SMP on x86_64. This means that the option
should only be passed in that case, so add a check for CONFIG_SMP.
Otherwise, per cpu variables are recorded as absolute quantities,
(which they are not under !CONFIG_SMP) and they are not relocated
under CONFIG_RELOCATABLE=y.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 scripts/link-vmlinux.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index ba6c34ea5429..b541c21072f2 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -86,7 +86,7 @@ kallsyms()
 		kallsymopt="${kallsymopt} --page-offset=$CONFIG_PAGE_OFFSET"
 	fi
 
-	if [ -n "${CONFIG_X86_64}" ]; then
+	if [ -n "${CONFIG_X86_64}" ] && [ -n "${CONFIG_SMP}" ]; then
 		kallsymopt="${kallsymopt} --absolute-percpu"
 	fi
 
-- 
2.5.0
