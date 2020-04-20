Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31627 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726764AbgDTMN2 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 20 Apr 2020 08:13:28 -0400
Date: Mon, 20 Apr 2020 14:13:17 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 1/1] vfio-ccw: Enable transparent CCW IPL from DASD
Message-ID: <20200420141317.4537498f.cohuck@redhat.com>
In-Reply-To: <20200417182939.11460-2-jrossi@linux.ibm.com>
References: <20200417182939.11460-1-jrossi@linux.ibm.com>
        <20200417182939.11460-2-jrossi@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Jared Rossi <jrossi@linux.ibm.com>
Cc: Eric Farman <farman@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, 17 Apr 2020 14:29:39 -0400
Jared Rossi <jrossi@linux.ibm.com> wrote:

> Remove the explicit prefetch check when using vfio-ccw devices.
> This check is not needed as all Linux channel programs are intended
> to use prefetch and will be executed in the same way regardless.

Hm... my understanding is that we have the reasonable expectation that
our guests will always issue channel programs that work fine with
prefetch even if the bit is not set in the orb (including CCW IPL, in
the way it is implemented in the s390-ccw QEMU bios), and therefore
this patch is just making things less complicated.

If a future guest does issue a channel program where that does not hold
true, it will run into trouble, and I'm not sure that this would be
easy to debug. Can we log this somewhere?

Also, it might make sense to add some note of our
behaviour/expectations to Documentation/s390/vfio-ccw.rst.

> 
> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
> ---
>  drivers/s390/cio/vfio_ccw_cp.c  | 16 ++++------------
>  drivers/s390/cio/vfio_ccw_cp.h  |  2 +-
>  drivers/s390/cio/vfio_ccw_fsm.c |  6 +++---
>  3 files changed, 8 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
> index 3645d1720c4b..5b47ecbb4baa 100644
> --- a/drivers/s390/cio/vfio_ccw_cp.c
> +++ b/drivers/s390/cio/vfio_ccw_cp.c
(...)
> @@ -690,7 +682,7 @@ void cp_free(struct channel_program *cp)
>  }
>  
>  /**
> - * cp_prefetch() - translate a guest physical address channel program to
> + * cp_fetch() - translate a guest physical address channel program to

I would not rename this -- we are still doing what is called
'prefetch', even though we also do it if the guest did not instruct us
to do so.

(also below)

>   *                 a real-device runnable channel program.
>   * @cp: channel_program on which to perform the operation
>   *
