Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
Subject: Re: s390 qemu boot failure in -next
References: <20180622194736.GA5794@roeck-us.net>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 25 Jun 2018 09:10:45 +0200
MIME-Version: 1.0
In-Reply-To: <20180622194736.GA5794@roeck-us.net>
Content-Language: en-US
Message-Id: <126ac556-0602-b927-58f5-cb5f65a5e0ec@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Guenter Roeck <linux@roeck-us.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>



On 06/22/2018 09:47 PM, Guenter Roeck wrote:
> Hi,
> 
> starting with commit 's390/boot: make head.S and als.c be part of the
> decompressor only' in -next, s390 immages no longer boot in qemu.
> As far as I can see, the reason is that the command line is no longer
> passed from qemu to the kernel, which results in a panic because the
> root file system can not be mounted.
> 
> Was this change made on purpose ? If so, is there a way to get qemu
> back to working ?

Certainly not on purpose.

Vasily, I can reproduce this with KVM and an external kernel boot of the vmlinux file (the elf file)

e.g.

qemu-system-s390 -enable-kvm -nographic -kernel vmlinux -append "this string no longer is command line"

The compressed image (bzImage) seems to work fine though.

This seems to be an unfortunate side effect of QEMUs ways to "guess" its Linux (checking for start
address 0x10000, which is no longer true for the vmlinux file). With the pure vmlinux elf file
the load address is 0x100000 as there is no unpacker.

Guenter, can you check if arch/s390/boot/bzImage works for you as a workaround?
