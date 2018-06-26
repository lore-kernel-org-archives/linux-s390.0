Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Tue, 26 Jun 2018 08:32:46 +0300
From: Georgi Guninski <guninski@guninski.com>
Subject: Re: s390 qemu boot failure in -next
Message-ID: <20180626053246.6kyvrj7jbuhgdkgv@sivokote.iziade.m$>
References: <20180622194736.GA5794@roeck-us.net>
 <126ac556-0602-b927-58f5-cb5f65a5e0ec@de.ibm.com>
 <88d9afed-f91d-c320-13c8-9a93fc52b700@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88d9afed-f91d-c320-13c8-9a93fc52b700@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Guenter Roeck <linux@roeck-us.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, qemu-s390x <qemu-s390x@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

On Mon, Jun 25, 2018 at 09:27:59AM +0200, Christian Borntraeger wrote:
> -            /* Overwrite parameters in the kernel image, which are "rom" */
> -            strcpy(rom_ptr(KERN_PARM_AREA), ipl->cmdline);

> +            strcpy(rom_ptr(KERN_PARM_AREA), ipl->cmdline);

Why not replace strcpy() with strncpy() or snprintf()?
strcpy() may overflow.
