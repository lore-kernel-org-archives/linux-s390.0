Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: drivers/s390/char/keyboard.c kernel stack infoleak
References: <116f735.aa23.15da864e94a.Coremail.sohu0106@126.com>
From: Thomas Huth <huth@tuxfamily.org>
Message-ID: <0b76e8f9-e1ea-da9e-23f2-92cdbd475ec9@tuxfamily.org>
Date: Fri, 4 Aug 2017 11:09:24 +0200
MIME-Version: 1.0
In-Reply-To: <116f735.aa23.15da864e94a.Coremail.sohu0106@126.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: sohu0106 <sohu0106@126.com>
Cc: schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

 Hi,

On 03.08.2017 15:59, sohu0106 wrote:
> 
> The stack object "kbdiacr" has a total size of 4 bytes. Its last 1 bytes are padding bytes after "result" which are not initialized and leaked to userland via "copy_to_user".
> 
> 
> diff --git a/keyboard.c b/keyboard.c
> index ba0e4f9..76a6d35 100644
> --- a/keyboard.c
> +++ b/keyboard.c
> @@ -480,6 +480,8 @@ int kbd_ioctl(struct kbd_data *kbd, unsigned int cmd, unsigned long arg)
>                 struct kbdiacr diacr;
>                 int i;
>  
> +               memset( &diacr, 0, sizeof(struct kbdiacr) );
> +

I think it would be nicer to simply init the struct with "= {}"
directly, i.e.:

		struct kbdiacr diacr = {};

And by the way, please have a look at the kernel patch submission
guidelines first, especially the COO part here:

 https://www.kernel.org/doc/html/v4.12/process/submitting-patches.html#sign-your-work-the-developer-s-certificate-of-origin

So looking at your patch, please try to send plain text mails, and sign
your patch with a Signed-off-by line (i.e. no anonymous contributions).

 Thanks!
  Thomas
