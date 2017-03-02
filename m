From: Jessica Yu <jeyu@redhat.com>
Subject: Re: [PATCHv2 11/14] module: Use set_memory.h header
Date: Thu, 2 Mar 2017 12:09:12 -0500
Message-ID: <20170302170912.GA13268@packer-debian-8-amd64.digitalocean.com>
References: <1488413706-9739-1-git-send-email-labbott@redhat.com>
 <1488413706-9739-12-git-send-email-labbott@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1488413706-9739-12-git-send-email-labbott@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Laura Abbott <labbott@redhat.com>
Cc: Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Kees Cook <keescook@chromium.org>, Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-arch@vger.kernel.org, David Airlie <airlied@linux.ie>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Wim Van Sebroeck <wim@iguana.be>, Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.orgDavid
List-ID: <linux-s390.vger.kernel.org>

+++ Laura Abbott [01/03/17 16:15 -0800]:
>
>set_memory_* functions have moved to set_memory.h. Switch to this
>explicitly.
>
>Signed-off-by: Laura Abbott <labbott@redhat.com>

Acked-by: Jessica Yu <jeyu@redhat.com>

Thanks,

Jessica

>---
> kernel/module.c | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/kernel/module.c b/kernel/module.c
>index 7eba6de..c0f04b3 100644
>--- a/kernel/module.c
>+++ b/kernel/module.c
>@@ -49,6 +49,7 @@
> #include <linux/rculist.h>
> #include <linux/uaccess.h>
> #include <asm/cacheflush.h>
>+#include <asm/set_memory.h>
> #include <asm/mmu_context.h>
> #include <linux/license.h>
> #include <asm/sections.h>
>-- 
>2.7.4
>
