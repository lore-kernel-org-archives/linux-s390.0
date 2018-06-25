Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Mon, 25 Jun 2018 10:49:28 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: s390 qemu boot failure in -next
Message-ID: <20180625104928.6c4cb239.cohuck@redhat.com>
In-Reply-To: <your-ad-here.call-01529915788-ext-6027@work.hours>
References: <20180622194736.GA5794@roeck-us.net>
        <126ac556-0602-b927-58f5-cb5f65a5e0ec@de.ibm.com>
        <88d9afed-f91d-c320-13c8-9a93fc52b700@de.ibm.com>
        <20180625100548.64222dad.cohuck@redhat.com>
        <your-ad-here.call-01529915788-ext-6027@work.hours>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Vasily Gorbik <gor@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Guenter Roeck <linux@roeck-us.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, qemu-s390x <qemu-s390x@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

On Mon, 25 Jun 2018 10:36:33 +0200
Vasily Gorbik <gor@linux.ibm.com> wrote:

> This change has been done on purpose. Uncompressed image is not going
> to be bootable any more. In future the decompressor phase would get
> more function (early memory detection as an example) and there is no
> chance to duplicate that code in uncompressed image as well (to keep it
> bootable on its own). The patch series commit messages contain more
> technical details.
> 
> For qemu either bzImage or arch/s390/boot/compressed/vmlinux should be
> used, which are bootable images.
> 
> But that's really confusing that uncompressed vmlinux is still kind
> of booting. May be we should discuss how to avoid this confusion
> (may be change uncompressed image enty point to a function doing
> disabled wait with badb007 or smth) and how to encourage people to use
> arch/s390/boot/compressed/vmlinux instead.

So, the intention is that you can't boot the uncompressed image
anywhere? (Was it possible before, e.g. when punching the image under
z/VM?) If yes, it would make sense to explicitly fence it. But I'm
worried that it would break previously working setups (did we document
the purpose of the images anywhere?)
