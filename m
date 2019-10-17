Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44366 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728150AbfJQJfc (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 17 Oct 2019 05:35:32 -0400
Date: Thu, 17 Oct 2019 11:35:29 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v3 3/4] vfio-ccw: Add a trace for asynchronous requests
Message-ID: <20191017113529.338bad06.cohuck@redhat.com>
In-Reply-To: <20191016142040.14132-4-farman@linux.ibm.com>
References: <20191016142040.14132-1-farman@linux.ibm.com>
        <20191016142040.14132-4-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Eric Farman <farman@linux.ibm.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, Steffen Maier <maier@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>, Jared Rossi <jrossi@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org

On Wed, 16 Oct 2019 16:20:39 +0200
Eric Farman <farman@linux.ibm.com> wrote:

> Since the asynchronous requests are typically associated with
> error recovery, let's add a simple trace when one of those is
> issued to a device.
> 
> Signed-off-by: Eric Farman <farman@linux.ibm.com>
> ---
>  drivers/s390/cio/vfio_ccw_fsm.c   |  4 ++++
>  drivers/s390/cio/vfio_ccw_trace.c |  1 +
>  drivers/s390/cio/vfio_ccw_trace.h | 30 ++++++++++++++++++++++++++++++
>  3 files changed, 35 insertions(+)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
