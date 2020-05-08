Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38874 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726797AbgEHKre (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 8 May 2020 06:47:34 -0400
Date: Fri, 8 May 2020 12:47:25 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v4 1/1] vfio-ccw: Enable transparent CCW IPL from DASD
Message-ID: <20200508124725.58fb985a.cohuck@redhat.com>
In-Reply-To: <20200506212440.31323-2-jrossi@linux.ibm.com>
References: <20200506212440.31323-1-jrossi@linux.ibm.com>
        <20200506212440.31323-2-jrossi@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Jared Rossi <jrossi@linux.ibm.com>
Cc: Eric Farman <farman@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed,  6 May 2020 17:24:40 -0400
Jared Rossi <jrossi@linux.ibm.com> wrote:

> Remove the explicit prefetch check when using vfio-ccw devices.
> This check does not trigger in practice as all Linux channel programs
> are intended to use prefetch.
> 
> It is expected that all ORBs issued by Linux will request prefetch.
> Although non-prefetching ORBs are not rejected, they will prefetch
> nonetheless. A warning is issued up to once per 5 seconds when a
> forced prefetch occurs.
> 
> A non-prefetch ORB does not necessarily result in an error, however
> frequent encounters with non-prefetch ORBs indicate that channel
> programs are being executed in a way that is inconsistent with what
> the guest is requesting. While there is currently no known case of an
> error caused by forced prefetch, it is possible in theory that forced
> prefetch could result in an error if applied to a channel program that
> is dependent on non-prefetch.
> 
> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
> ---
>  Documentation/s390/vfio-ccw.rst |  6 ++++++
>  drivers/s390/cio/vfio_ccw_cp.c  | 19 ++++++++++++-------
>  2 files changed, 18 insertions(+), 7 deletions(-)
> 

Thanks, applied.
