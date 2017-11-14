Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 14 Nov 2017 19:00:01 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 7/9] s390: virtio: add SPDX identifiers to the remaining
 files
Message-ID: <20171114190001.49058062.cohuck@redhat.com>
In-Reply-To: <20171114173808.25092-8-gregkh@linuxfoundation.org>
References: <20171114173808.25092-1-gregkh@linuxfoundation.org>
        <20171114173808.25092-8-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org, Halil Pasic <pasic@linux.vnet.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>
List-ID: <linux-s390.vger.kernel.org>

On Tue, 14 Nov 2017 18:38:06 +0100
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> It's good to have SPDX identifiers in all files to make it easier to
> audit the kernel tree for correct licenses.
> 
> Update the drivers/s390/virtio/ files with the correct SPDX license
> identifier based on the license text in the file itself.  The SPDX
> identifier is a legally binding shorthand, which can be used instead of
> the full boiler plate text.
> 
> This work is based on a script and data from Thomas Gleixner, Philippe
> Ombredanne, and Kate Stewart.
> 
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: Halil Pasic <pasic@linux.vnet.ibm.com>
> Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Kate Stewart <kstewart@linuxfoundation.org>
> Cc: Philippe Ombredanne <pombredanne@nexb.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/s390/virtio/Makefile     | 1 +
>  drivers/s390/virtio/virtio_ccw.c | 1 +
>  2 files changed, 2 insertions(+)

Acked-by: Cornelia Huck <cohuck@redhat.com>
