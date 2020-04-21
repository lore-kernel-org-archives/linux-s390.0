Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53610 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728702AbgDUMLe (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 21 Apr 2020 08:11:34 -0400
Date: Tue, 21 Apr 2020 14:11:24 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v3 8/8] vfio-ccw: Add trace for CRW event
Message-ID: <20200421141124.408b70ac.cohuck@redhat.com>
In-Reply-To: <20200417023001.65006-9-farman@linux.ibm.com>
References: <20200417023001.65006-1-farman@linux.ibm.com>
        <20200417023001.65006-9-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Eric Farman <farman@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>, Jared Rossi <jrossi@linux.ibm.com>

On Fri, 17 Apr 2020 04:30:01 +0200
Eric Farman <farman@linux.ibm.com> wrote:

> Since CRW events are (should be) rare, let's put a trace
> in that routine too.
> 
> Signed-off-by: Eric Farman <farman@linux.ibm.com>
> ---
>  drivers/s390/cio/vfio_ccw_drv.c   |  1 +
>  drivers/s390/cio/vfio_ccw_trace.c |  1 +
>  drivers/s390/cio/vfio_ccw_trace.h | 30 ++++++++++++++++++++++++++++++
>  3 files changed, 32 insertions(+)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
