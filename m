Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 25 Sep 2017 07:23:55 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH] s390/sclp: Use setup_timer and mod_timer
In-Reply-To: <1506254414-10269-1-git-send-email-himanshujha199640@gmail.com>
References: <1506254414-10269-1-git-send-email-himanshujha199640@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20170925072355.33e0e940@mschwideX1>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Himanshu Jha <himanshujha199640@gmail.com>
Cc: heiko.carstens@de.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Sun, 24 Sep 2017 17:30:14 +0530
Himanshu Jha <himanshujha199640@gmail.com> wrote:

> Use setup_timer and mod_timer API instead of structure assignments.
> 
> This is done using Coccinelle and semantic patch used
> for this as follows:
> 
> @@
> expression x,y,z,a,b;
> @@
> 
> -init_timer (&x);
> +setup_timer (&x, y, z);
> +mod_timer (&a, b);
> -x.function = y;
> -x.data = z;
> -x.expires = b;
> -add_timer(&a);
> 
> Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
> ---
>  drivers/s390/char/sclp_con.c | 7 ++-----
>  drivers/s390/char/sclp_tty.c | 7 ++-----
>  2 files changed, 4 insertions(+), 10 deletions(-)

Added to s390/linux for the 4.15 merge window, thanks.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
