Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Wed, 26 Aug 2015 21:03:00 +0200
From: Tillmann Heidsieck <theidsieck@leenox.de>
Subject: Re: [PATCH] s390/jump_label: Use %*ph to print small buffers
In-Reply-To: <1440614969-11351-1-git-send-email-kuleshovmail@gmail.com>
References: <1440614969-11351-1-git-send-email-kuleshovmail@gmail.com>
Message-ID: <9ca5f3280075e7b94356003e250efe25@mail.leenox.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Alexander Kuleshov <kuleshovmail@gmail.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux390@de.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hi Alexander,

On 2015-08-26 20:49, Alexander Kuleshov wrote:
> printk() supports %*ph format specifier for printing a small buffers,
> let's use it intead of %02x %02x...

noble effort ...

>  	pr_emerg("Jump label code mismatch at %pS [%p]\n", ipc, ipc);
> -	pr_emerg("Found:    %02x %02x %02x %02x %02x %02x\n",
> +	pr_emerg("Found:    %6ph\n",
>  		 ipc[0], ipc[1], ipc[2], ipc[3], ipc[4], ipc[5]);
> -	pr_emerg("Expected: %02x %02x %02x %02x %02x %02x\n",
> +	pr_emerg("Expected: %6ph\n",
>  		 ipe[0], ipe[1], ipe[2], ipe[3], ipe[4], ipe[5]);
> -	pr_emerg("New:      %02x %02x %02x %02x %02x %02x\n",
> +	pr_emerg("New:      %6ph\n",
>  		 ipn[0], ipn[1], ipn[2], ipn[3], ipn[4], ipn[5]);
>  	panic("Corrupted kernel text");
>  }

... but you might want to check our code before submission (e.g. compile 
it!)

Cheers
Tillmann
