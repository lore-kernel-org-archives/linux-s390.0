From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCHv2 09/14] watchdog: hpwdt: Use set_memory.h header
Date: Thu, 2 Mar 2017 06:48:34 -0800
Message-ID: <e99102e0-ae16-9720-a541-75e09bc0b68d@roeck-us.net>
References: <1488413706-9739-1-git-send-email-labbott@redhat.com>
 <1488413706-9739-10-git-send-email-labbott@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1488413706-9739-10-git-send-email-labbott@redhat.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Laura Abbott <labbott@redhat.com>, Wim Van Sebroeck <wim@iguana.be>
Cc: Mark Rutland <mark.rutland@arm.com>, David Airlie <airlied@linux.ie>, Catalin Marinas <catalin.marinas@arm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Takashi Iwai <tiwai@suse.com>, "H. Peter Anvin" <hpa@zytor.com>, linux-watchdog@vger.kernel.org, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, Jessica Yu <jeyu@redhat.com>, Daniel Borkmann <daniel@iogearbox.net>, x86@kernel.org, Russell King <linux@armlinux.org.uk>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>, Will Deacon <will.deacon@arm.com>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>
List-ID: <linux-s390.vger.kernel.org>

On 03/01/2017 04:15 PM, Laura Abbott wrote:
> set_memory_* functions have moved to set_memory.h. Switch to this
> explicitly.
>
> Signed-off-by: Laura Abbott <labbott@redhat.com>

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/hpwdt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
> index 70c7194..67fbe35 100644
> --- a/drivers/watchdog/hpwdt.c
> +++ b/drivers/watchdog/hpwdt.c
> @@ -34,7 +34,7 @@
>  #include <linux/nmi.h>
>  #include <linux/kdebug.h>
>  #include <linux/notifier.h>
> -#include <asm/cacheflush.h>
> +#include <asm/set_memory.h>
>  #endif /* CONFIG_HPWDT_NMI_DECODING */
>  #include <asm/nmi.h>
>  #include <asm/frame.h>
>
