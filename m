Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49024 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727451AbfJPKIq (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 16 Oct 2019 06:08:46 -0400
Date: Wed, 16 Oct 2019 12:08:43 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v2 1/4] vfio-ccw: Refactor how the traces are built
Message-ID: <20191016120843.21a868ed.cohuck@redhat.com>
In-Reply-To: <20191016015822.72425-2-farman@linux.ibm.com>
References: <20191016015822.72425-1-farman@linux.ibm.com>
        <20191016015822.72425-2-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Eric Farman <farman@linux.ibm.com>
Cc: Steffen Maier <maier@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>, Jared Rossi <jrossi@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org

On Wed, 16 Oct 2019 03:58:19 +0200
Eric Farman <farman@linux.ibm.com> wrote:

> Commit 3cd90214b70f ("vfio: ccw: add tracepoints for interesting error
> paths") added a quick trace point to determine where a channel program
> failed while being processed.  It's a great addition, but adding more
> traces to vfio-ccw is more cumbersome than it needs to be.
> 
> Let's refactor how this is done, so that additional traces are easier
> to add and can exist outside of the FSM if we ever desire.
> 
> Signed-off-by: Eric Farman <farman@linux.ibm.com>
> ---
>  drivers/s390/cio/Makefile         |  4 ++--
>  drivers/s390/cio/vfio_ccw_cp.h    |  1 +
>  drivers/s390/cio/vfio_ccw_fsm.c   |  3 ---
>  drivers/s390/cio/vfio_ccw_trace.c | 12 ++++++++++++
>  drivers/s390/cio/vfio_ccw_trace.h |  2 ++
>  5 files changed, 17 insertions(+), 5 deletions(-)
>  create mode 100644 drivers/s390/cio/vfio_ccw_trace.c

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
