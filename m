Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 24 Nov 2017 15:05:23 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 02/12] s390: kvm: add SPDX identifiers to the remaining
 files
Message-ID: <20171124150523.6e4d1777.cohuck@redhat.com>
In-Reply-To: <20171124140043.10062-3-gregkh@linuxfoundation.org>
References: <20171124140043.10062-1-gregkh@linuxfoundation.org>
        <20171124140043.10062-3-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>
List-ID: <linux-s390.vger.kernel.org>

On Fri, 24 Nov 2017 15:00:33 +0100
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> It's good to have SPDX identifiers in all files to make it easier to
> audit the kernel tree for correct licenses.
> 
> Update the arch/s390/kvm/ files with the correct SPDX license
> identifier based on the license text in the file itself.  The SPDX
> identifier is a legally binding shorthand, which can be used instead of
> the full boiler plate text.
> 
> This work is based on a script and data from Thomas Gleixner, Philippe
> Ombredanne, and Kate Stewart.
> 
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Kate Stewart <kstewart@linuxfoundation.org>
> Cc: Philippe Ombredanne <pombredanne@nexb.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  arch/s390/kvm/Makefile    | 1 +
>  arch/s390/kvm/diag.c      | 1 +
>  arch/s390/kvm/gaccess.h   | 1 +
>  arch/s390/kvm/guestdbg.c  | 1 +
>  arch/s390/kvm/intercept.c | 1 +
>  arch/s390/kvm/interrupt.c | 1 +
>  arch/s390/kvm/irq.h       | 1 +
>  arch/s390/kvm/kvm-s390.c  | 1 +
>  arch/s390/kvm/kvm-s390.h  | 1 +
>  arch/s390/kvm/priv.c      | 1 +
>  arch/s390/kvm/sigp.c      | 1 +
>  arch/s390/kvm/vsie.c      | 1 +
>  12 files changed, 12 insertions(+)

Acked-by: Cornelia Huck <cohuck@redhat.com>
