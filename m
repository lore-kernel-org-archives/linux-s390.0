Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 14 Nov 2017 19:00:42 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 9/9] s390: drivers: Remove redundant license text
Message-ID: <20171114190042.25b8eeef.cohuck@redhat.com>
In-Reply-To: <20171114173808.25092-10-gregkh@linuxfoundation.org>
References: <20171114173808.25092-1-gregkh@linuxfoundation.org>
        <20171114173808.25092-10-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org, Sebastian Ott <sebott@linux.vnet.ibm.com>, Peter Oberparleiter <oberpar@linux.vnet.ibm.com>, Julian Wiedmann <jwi@linux.vnet.ibm.com>, Ursula Braun <ubraun@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Tue, 14 Nov 2017 18:38:08 +0100
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> Now that the SPDX tag is in all drivers/s390/ files, that identifies the
> license in a specific and legally-defined manner.  So the extra GPL text
> wording can be removed as it is no longer needed at all.
> 
> This is done on a quest to remove the 700+ different ways that files in
> the kernel describe the GPL license text.  And there's unneeded stuff
> like the address (sometimes incorrect) for the FSF which is never
> needed.
> 
> No copyright headers or other non-license-description text was removed.
> 
> Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> Cc: Sebastian Ott <sebott@linux.vnet.ibm.com>
> Cc: Peter Oberparleiter <oberpar@linux.vnet.ibm.com>
> Cc: Julian Wiedmann <jwi@linux.vnet.ibm.com>
> Cc: Ursula Braun <ubraun@linux.vnet.ibm.com>
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: Halil Pasic <pasic@linux.vnet.ibm.com>
> Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/s390/char/zcore.c        |  1 -
>  drivers/s390/cio/cmf.c           | 14 --------------
>  drivers/s390/cio/css.c           |  2 --
>  drivers/s390/cio/device.c        |  2 --
>  drivers/s390/cio/device_ops.c    |  2 --
>  drivers/s390/net/lcs.c           | 14 --------------
>  drivers/s390/net/netiucv.c       | 15 ---------------
>  drivers/s390/net/smsgiucv.c      | 14 --------------
>  drivers/s390/virtio/Makefile     |  4 ----
>  drivers/s390/virtio/virtio_ccw.c |  4 ----
>  10 files changed, 72 deletions(-)

Acked-by: Cornelia Huck <cohuck@redhat.com>
