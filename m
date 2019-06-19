Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51576 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726142AbfFSIO1 (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 19 Jun 2019 04:14:27 -0400
Date: Wed, 19 Jun 2019 10:14:23 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [RFC PATCH v1 1/5] vfio-ccw: Move guest_cp storage into common
 struct
Message-ID: <20190619101423.5ed567e5.cohuck@redhat.com>
In-Reply-To: <20190618202352.39702-2-farman@linux.ibm.com>
References: <20190618202352.39702-1-farman@linux.ibm.com>
        <20190618202352.39702-2-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Eric Farman <farman@linux.ibm.com>
Cc: Farhan Ali <alifm@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org

On Tue, 18 Jun 2019 22:23:48 +0200
Eric Farman <farman@linux.ibm.com> wrote:

> Rather than allocating/freeing a piece of memory every time
> we try to figure out how long a CCW chain is, let's use a piece
> of memory allocated for each device.
> 
> The io_mutex added with commit 4f76617378ee9 ("vfio-ccw: protect
> the I/O region") is held for the duration of the VFIO_CCW_EVENT_IO_REQ
> event that accesses/uses this space, so there should be no race
> concerns with another CPU attempting an (unexpected) SSCH for the
> same device.
> 
> Suggested-by: Cornelia Huck <cohuck@redhat.com>
> Signed-off-by: Eric Farman <farman@linux.ibm.com>
> ---
> Conny, your suggestion [1] did not go unnoticed.  :)

:)

> 
> [1] https://patchwork.kernel.org/comment/22312659/
> ---
>  drivers/s390/cio/vfio_ccw_cp.c  | 23 ++++-------------------
>  drivers/s390/cio/vfio_ccw_cp.h  |  7 +++++++
>  drivers/s390/cio/vfio_ccw_drv.c |  7 +++++++
>  3 files changed, 18 insertions(+), 19 deletions(-)

Nice!

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
