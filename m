Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52148 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732013AbfJONqt (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 15 Oct 2019 09:46:49 -0400
Date: Tue, 15 Oct 2019 15:46:45 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [RFC PATCH 1/4] vfio-ccw: Refactor how the traces are built
Message-ID: <20191015154645.2c35dd32.cohuck@redhat.com>
In-Reply-To: <20191014180855.19400-2-farman@linux.ibm.com>
References: <20191014180855.19400-1-farman@linux.ibm.com>
        <20191014180855.19400-2-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Eric Farman <farman@linux.ibm.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>, Jared Rossi <jrossi@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org

On Mon, 14 Oct 2019 20:08:52 +0200
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

Looks good.

I'm wondering whether we could consolidate tracepoints and s390dbf
usage somehow. These two complement each other in a way (looking at a
live system vs. looking at a crash dump, integration with other parts
of the system), but they currently also cover at least partially
different code paths. Not sure how much sense it makes to have double
coverage at least for a subset of the functionality.
