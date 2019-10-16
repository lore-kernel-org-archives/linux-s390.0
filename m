Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44824 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729316AbfJPKSM (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 16 Oct 2019 06:18:12 -0400
Date: Wed, 16 Oct 2019 12:17:48 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v2 4/4] vfio-ccw: Rework the io_fctl trace
Message-ID: <20191016121748.7982cb24.cohuck@redhat.com>
In-Reply-To: <20191016015822.72425-5-farman@linux.ibm.com>
References: <20191016015822.72425-1-farman@linux.ibm.com>
        <20191016015822.72425-5-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Eric Farman <farman@linux.ibm.com>
Cc: Steffen Maier <maier@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>, Jared Rossi <jrossi@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org

On Wed, 16 Oct 2019 03:58:22 +0200
Eric Farman <farman@linux.ibm.com> wrote:

> Using __field_struct for the schib is convenient, but it doesn't
> appear to let us filter based on any of the schib elements.
> Specifying, the full schid or any element within it results

s/Specifying,/Specifying/

> in various errors by the parser.  So, expand that out to its
> component elements, so we can limit the trace to a single device.
> 
> While we are at it, rename this trace to the function name, so we
> remember what is being traced instead of an abstract reference to the
> function control bit of the SCSW.
> 
> Signed-off-by: Eric Farman <farman@linux.ibm.com>
> ---
>  drivers/s390/cio/vfio_ccw_fsm.c   |  4 ++--
>  drivers/s390/cio/vfio_ccw_trace.c |  2 +-
>  drivers/s390/cio/vfio_ccw_trace.h | 18 +++++++++++-------
>  3 files changed, 14 insertions(+), 10 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
