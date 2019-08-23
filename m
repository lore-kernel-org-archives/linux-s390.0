Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55776 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392870AbfHWLss (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 23 Aug 2019 07:48:48 -0400
Date: Fri, 23 Aug 2019 13:48:45 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH RFC 1/1] vfio-ccw: add some logging
Message-ID: <20190823134845.1f7ce449.cohuck@redhat.com>
In-Reply-To: <20190816151505.9853-2-cohuck@redhat.com>
References: <20190816151505.9853-1-cohuck@redhat.com>
        <20190816151505.9853-2-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Eric Farman <farman@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org

On Fri, 16 Aug 2019 17:15:05 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

> Usually, the common I/O layer logs various things into the s390
> cio debug feature, which has been very helpful in the past when
> looking at crash dumps. As vfio-ccw devices unbind from the
> standard I/O subchannel driver, we lose some information there.
> 
> Let's introduce some vfio-ccw debug features and log some things
> there. (Unfortunately we cannot reuse the cio debug feature from
> a module.)
> 
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  drivers/s390/cio/vfio_ccw_drv.c     | 50 ++++++++++++++++++++++++++--
>  drivers/s390/cio/vfio_ccw_fsm.c     | 51 ++++++++++++++++++++++++++++-
>  drivers/s390/cio/vfio_ccw_ops.c     | 10 ++++++
>  drivers/s390/cio/vfio_ccw_private.h | 17 ++++++++++
>  4 files changed, 124 insertions(+), 4 deletions(-)

Queued.
