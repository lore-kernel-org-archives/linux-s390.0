From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [-next PATCH] Fix s390 keyboard driver build break
Date: Sat, 21 Aug 2010 00:40:19 -0700
Message-ID: <20100821074018.GB2160@core.coreip.homeip.net>
References: <20100821072126.8965.41003.sendpatchset@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-next-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20100821072126.8965.41003.sendpatchset@localhost.localdomain>
Sender: linux-next-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-next/>
List-Post: <mailto:linux-next@vger.kernel.org>
To: Sachin Sant <sachinp@in.ibm.com>
Cc: schwidefsky@de.ibm.com, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org, linux-next@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hi Sachin,

On Sat, Aug 21, 2010 at 12:51:26PM +0530, Sachin Sant wrote:
> Next 20100820 fails to build on s390 with 
> 
> drivers/s390/char/keyboard.c: In function 'kbd_keycode':
> drivers/s390/char/keyboard.c:308: error: too many arguments to function 'handle_sysrq'
> make[2]: *** [drivers/s390/char/keyboard.o] Error 1
> 
> The following commit changed handle_sysrq() function to accept single argument. 
> 
> commit a821bafce37b26499e2bfbf2e6b96b0636efc014
> Input: sysrq - drop tty argument form handle_sysrq()
> 
> Adapt the code accordingly to fix the build break.
> 
> Signed-off-by: Sachin Sant <sachinp@in.ibm.com>
> ---
> 
> diff -Naurp next20100820/drivers/s390/char/keyboard.c next20100820-new//drivers/s390/char/keyboard.c
> --- next20100820/drivers/s390/char/keyboard.c	2010-08-16 06:11:37.000000000 +0530
> +++ next20100820-new//drivers/s390/char/keyboard.c	2010-08-21 11:55:25.000000000 +0530
> @@ -305,7 +305,7 @@ kbd_keycode(struct kbd_data *kbd, unsign
>  		if (kbd->sysrq) {
>  			if (kbd->sysrq == K(KT_LATIN, '-')) {
>  				kbd->sysrq = 0;
> -				handle_sysrq(value, kbd->tty);
> +				handle_sysrq(value);
>  				return;
>  			}
>  			if (value == '-') {

Thank you very much for the patch. I folded it into original patch to
avoid build failures in case someone needs to bisect.

-- 
Dmitry
