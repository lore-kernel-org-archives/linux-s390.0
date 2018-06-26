Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
Subject: Re: [PATCH] s390/boot: block uncompressed vmlinux booting attempts
References: <64bcba64-b88f-3594-da6e-7c2118482c20@roeck-us.net>
 <cover.thread-8b0da3.your-ad-here.call-01529937119-ext-3705@work.hours>
 <patch-1.thread-8b0da3.git-8b0da335b2d3.your-ad-here.call-01529937119-ext-3705@work.hours>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 26 Jun 2018 09:30:19 +0200
MIME-Version: 1.0
In-Reply-To: <patch-1.thread-8b0da3.git-8b0da335b2d3.your-ad-here.call-01529937119-ext-3705@work.hours>
Content-Language: en-US
Message-Id: <7cb526fc-9da4-248b-d5c4-cb463a2c2bac@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Vasily Gorbik <gor@linux.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Guenter Roeck <linux@roeck-us.net>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, qemu-s390x <qemu-s390x@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>
List-ID: <linux-s390.vger.kernel.org>



On 06/25/2018 05:09 PM, Vasily Gorbik wrote:
> Since uncompressed kernel image "vmlinux" elf file is not bootable under
> qemu anymore, add a check which would report that.
> 
> Qemu users are encouraged to use bzImage or
> arch/s390/boot/compressed/vmlinux instead.
> 
> The check relies on s390 linux entry point ABI definition, which is only
> present in bzImage and arch/s390/boot/compressed/vmlinux.
> 
> Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>

some proposals regarding the wording below..

[...]
> +
> +	sclp_early_printk("The linux kernel boot failure: the image is corrupted or not bootable.\n");
> +	sclp_early_printk("Please check that you are using bootable kernel image \"bzImage\".\n");
> +	sclp_early_printk("(or alternatively \"arch/s390/boot/compressed/vmlinux\" image for qemu)\n");

What about making this explain things a bit more, e.g. something like

Linux kernel boot failure: The boot image does not contain all necessary
components (like the entry point and decompressor). The plain vmlinux ELF
file no longer carries all necessary parts for starting up. Please use
bzImage or arch/s390/boot/compressed/vmlinux.
