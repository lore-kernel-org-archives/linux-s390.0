Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37768 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727235AbfJPKKP (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 16 Oct 2019 06:10:15 -0400
Date: Wed, 16 Oct 2019 12:10:11 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v2 2/4] vfio-ccw: Trace the FSM jumptable
Message-ID: <20191016121011.35bf651c.cohuck@redhat.com>
In-Reply-To: <20191016015822.72425-3-farman@linux.ibm.com>
References: <20191016015822.72425-1-farman@linux.ibm.com>
        <20191016015822.72425-3-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Eric Farman <farman@linux.ibm.com>
Cc: Steffen Maier <maier@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>, Jared Rossi <jrossi@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org

On Wed, 16 Oct 2019 03:58:20 +0200
Eric Farman <farman@linux.ibm.com> wrote:

> It would be nice if we could track the sequence of events within
> vfio-ccw, based on the state of the device/FSM and our calling
> sequence within it.  So let's add a simple trace here so we can
> watch the states change as things go, and allow it to be folded
> into the rest of the other cio traces.
> 
> Signed-off-by: Eric Farman <farman@linux.ibm.com>
> ---
>  drivers/s390/cio/vfio_ccw_private.h |  1 +
>  drivers/s390/cio/vfio_ccw_trace.c   |  1 +
>  drivers/s390/cio/vfio_ccw_trace.h   | 26 ++++++++++++++++++++++++++
>  3 files changed, 28 insertions(+)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
