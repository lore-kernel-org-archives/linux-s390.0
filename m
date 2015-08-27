Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 27 Aug 2015 09:34:42 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH v2] s390/jump_label: Use %*ph to print small buffers
Message-ID: <20150827093442.316c5cd2@mschwide>
In-Reply-To: <1440616666-15005-1-git-send-email-kuleshovmail@gmail.com>
References: <1440616666-15005-1-git-send-email-kuleshovmail@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Alexander Kuleshov <kuleshovmail@gmail.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, linux390@de.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Thu, 27 Aug 2015 01:17:46 +0600
Alexander Kuleshov <kuleshovmail@gmail.com> wrote:

> printk() supports %*ph format specifier for printing a small buffers,
> let's use it intead of %02x %02x...
> 
> Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
> ---
>  arch/s390/kernel/jump_label.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/s390/kernel/jump_label.c b/arch/s390/kernel/jump_label.c
> index a902996..1f615f3 100644
> --- a/arch/s390/kernel/jump_label.c
> +++ b/arch/s390/kernel/jump_label.c
> @@ -44,12 +44,9 @@ static void jump_label_bug(struct jump_entry *entry, struct insn *expected,
>  	unsigned char *ipn = (unsigned char *)new;
> 
>  	pr_emerg("Jump label code mismatch at %pS [%p]\n", ipc, ipc);
> -	pr_emerg("Found:    %02x %02x %02x %02x %02x %02x\n",
> -		 ipc[0], ipc[1], ipc[2], ipc[3], ipc[4], ipc[5]);
> -	pr_emerg("Expected: %02x %02x %02x %02x %02x %02x\n",
> -		 ipe[0], ipe[1], ipe[2], ipe[3], ipe[4], ipe[5]);
> -	pr_emerg("New:      %02x %02x %02x %02x %02x %02x\n",
> -		 ipn[0], ipn[1], ipn[2], ipn[3], ipn[4], ipn[5]);
> +	pr_emerg("Found:    %6ph\n", ipc);
> +	pr_emerg("Expected: %6ph\n", ipe);
> +	pr_emerg("New:      %6ph\n", ipn);
>  	panic("Corrupted kernel text");
>  }
 
Nice. Applied to the s390 features branch. Thanks.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
