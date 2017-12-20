Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 20 Dec 2017 15:09:29 +0100
From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
Subject: Re: [PATCH] s390/decompressor: add fortify_panic as x86 has.
Message-ID: <20171220150929.38ab6771@kitsune.suse.cz>
In-Reply-To: <20171213083317.GA6931@osiris>
References: <20171207103727.9461-1-msuchanek@suse.de>
        <20171207135507.275c5809@mschwideX1>
        <20171211140904.2f023b3c@kitsune.suse.cz>
        <20171213083317.GA6931@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, Marcelo Henrique Cerri <marcelo.cerri@canonical.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Wed, 13 Dec 2017 09:33:17 +0100
Heiko Carstens <heiko.carstens@de.ibm.com> wrote:

> From 4ec2a3fd66bb5b1da35807bc2e382f9b8d9eebb8 Mon Sep 17 00:00:00 2001
> From: Heiko Carstens <heiko.carstens@de.ibm.com>
> Date: Wed, 13 Dec 2017 09:21:59 +0100
> Subject: [PATCH] s390/sclp: disable FORTIFY_SOURCE for early sclp code
> 
> Michal Suchanek reported the following compile error with
> FORTIFY_SOURCE enabled:
> 
> drivers/s390/char/sclp_early_core.o: In function `memcpy':
> include/linux/string.h:340: undefined reference to `fortify_panic'
> 
> To fix this simply disable FORTIFY_SOURCE on the early sclp code as
> well, which I forgot on the initial commit.
> 
> Fixes: 79962038dffa ("s390: add support for FORTIFY_SOURCE")
> Reported-by: Michal Suchanek <msuchanek@suse.de>
> Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
> ---
>  drivers/s390/char/Makefile | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/s390/char/Makefile b/drivers/s390/char/Makefile
> index 05ac6ba15a53..614b44e70a28 100644
> --- a/drivers/s390/char/Makefile
> +++ b/drivers/s390/char/Makefile
> @@ -17,6 +17,8 @@ CFLAGS_REMOVE_sclp_early_core.o	+=
> $(CC_FLAGS_MARCH) CFLAGS_sclp_early_core.o		+=
> -march=z900 endif
>  
> +CFLAGS_sclp_early_core.o		+= -D__NO_FORTIFY
> +
>  obj-y += ctrlchar.o keyboard.o defkeymap.o sclp.o sclp_rw.o
> sclp_quiesce.o \ sclp_cmd.o sclp_config.o sclp_cpi_sys.o sclp_ocf.o
> sclp_ctl.o \ sclp_early.o sclp_early_core.o

That works for me as well.

Tested-by: Michal Suchanek <msuchanek@suse.de>

Thanks

Michal
