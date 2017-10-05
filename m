Subject: Re: [PATCH 09/13] timer: Remove users of expire and data arguments to
 DEFINE_TIMER
References: <1507159627-127660-1-git-send-email-keescook@chromium.org>
 <1507159627-127660-10-git-send-email-keescook@chromium.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <8219ece3-429a-1a25-1fd5-5ee5bacde53c@roeck-us.net>
Date: Wed, 4 Oct 2017 17:12:21 -0700
MIME-Version: 1.0
In-Reply-To: <1507159627-127660-10-git-send-email-keescook@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <groeck7@gmail.com>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
List-Archive: <https://lore.kernel.org/linux-mips/>
List-Post: <mailto:linux-mips@vger.kernel.org>
To: Kees Cook <keescook@chromium.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Ralf Baechle <ralf@linux-mips.org>, Wim Van Sebroeck <wim@iguana.be>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-mips@linux-mips.org, linux-watchdog@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Chris Metcalf <cmetcalf@mellanox.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Harish Patil <harish.patil@cavium.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>, John Stultz <john.stultz@linaro.org>, Julian Wiedmann <jwi@linux.vnet.ibm.com>, Kalle Valo <kvalo@qca.qualcomm.com>, Lai Jiangshan <jiangshanlai@gmail.com>, Len Brown <len.brown@intel.com>, Manish Chopra <manish.chopra@cavium.com>, Mark Gross <mark.gross@intel.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Michael Reed <mdr@sgi.com>, netdev@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>, Paul Mackerras <paulus@samba.org>, Pavel Machek <pavel@ucw.cz>, Petr Mladek <pmladek@suse.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Sebastian Reichel <sre@kernel.org>, Stefan Richter <stefanr@s5r6.in-berlin.de>, Stephen Boyd <sboyd@codeaurora.org>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Tejun Heo <tj@kernel.org>, Ursula Braun <ubraun@linux.vnet.ibm.com>, Viresh Kumar <viresh.kumar@linaro.org>, linux1394-devel@lists.sourceforge.net, linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org, linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 10/04/2017 04:27 PM, Kees Cook wrote:
> The expire and data arguments of DEFINE_TIMER are only used in two places
> and are ignored by the code (malta-display.c only uses mod_timer(),
> never add_timer(), so the preset expires value is ignored). Set both
> sets of arguments to zero.
> 
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Wim Van Sebroeck <wim@iguana.be>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: linux-mips@linux-mips.org
> Cc: linux-watchdog@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

For watchdog:

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   arch/mips/mti-malta/malta-display.c | 6 +++---
>   drivers/watchdog/alim7101_wdt.c     | 4 ++--
>   2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/mips/mti-malta/malta-display.c b/arch/mips/mti-malta/malta-display.c
> index d4f807191ecd..ac813158b9b8 100644
> --- a/arch/mips/mti-malta/malta-display.c
> +++ b/arch/mips/mti-malta/malta-display.c
> @@ -36,10 +36,10 @@ void mips_display_message(const char *str)
>   	}
>   }
>   
> -static void scroll_display_message(unsigned long data);
> -static DEFINE_TIMER(mips_scroll_timer, scroll_display_message, HZ, 0);
> +static void scroll_display_message(unsigned long unused);
> +static DEFINE_TIMER(mips_scroll_timer, scroll_display_message, 0, 0);
>   
> -static void scroll_display_message(unsigned long data)
> +static void scroll_display_message(unsigned long unused)
>   {
>   	mips_display_message(&display_string[display_count++]);
>   	if (display_count == max_display_count)
> diff --git a/drivers/watchdog/alim7101_wdt.c b/drivers/watchdog/alim7101_wdt.c
> index 665e0e7dfe1e..3c1f6ac68ea9 100644
> --- a/drivers/watchdog/alim7101_wdt.c
> +++ b/drivers/watchdog/alim7101_wdt.c
> @@ -71,7 +71,7 @@ MODULE_PARM_DESC(use_gpio,
>   		"Use the gpio watchdog (required by old cobalt boards).");
>   
>   static void wdt_timer_ping(unsigned long);
> -static DEFINE_TIMER(timer, wdt_timer_ping, 0, 1);
> +static DEFINE_TIMER(timer, wdt_timer_ping, 0, 0);
>   static unsigned long next_heartbeat;
>   static unsigned long wdt_is_open;
>   static char wdt_expect_close;
> @@ -87,7 +87,7 @@ MODULE_PARM_DESC(nowayout,
>    *	Whack the dog
>    */
>   
> -static void wdt_timer_ping(unsigned long data)
> +static void wdt_timer_ping(unsigned long unused)
>   {
>   	/* If we got a heartbeat pulse within the WDT_US_INTERVAL
>   	 * we agree to ping the WDT
> 
