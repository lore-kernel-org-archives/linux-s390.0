Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49912 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726951AbfFNKBP (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 14 Jun 2019 06:01:15 -0400
Date: Fri, 14 Jun 2019 12:01:11 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v2 9/9] s390/cio: Combine direct and indirect CCW paths
Message-ID: <20190614120111.00b4bd48.cohuck@redhat.com>
In-Reply-To: <20190606202831.44135-10-farman@linux.ibm.com>
References: <20190606202831.44135-1-farman@linux.ibm.com>
        <20190606202831.44135-10-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Eric Farman <farman@linux.ibm.com>
Cc: Farhan Ali <alifm@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org

On Thu,  6 Jun 2019 22:28:31 +0200
Eric Farman <farman@linux.ibm.com> wrote:

> With both the direct-addressed and indirect-addressed CCW paths
> simplified to this point, the amount of shared code between them is
> (hopefully) more easily visible.  Move the processing of IDA-specific
> bits into the direct-addressed path, and add some useful commentary of
> what the individual pieces are doing.  This allows us to remove the
> entire ccwchain_fetch_idal() routine and maintain a single function
> for any non-TIC CCW.
> 
> Signed-off-by: Eric Farman <farman@linux.ibm.com>
> ---
>  drivers/s390/cio/vfio_ccw_cp.c | 115 +++++++++++----------------------
>  1 file changed, 39 insertions(+), 76 deletions(-)

Another nice cleanup :)

> 
> diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
> index 8205d0b527fc..90d86e1354c1 100644
> --- a/drivers/s390/cio/vfio_ccw_cp.c
> +++ b/drivers/s390/cio/vfio_ccw_cp.c
> @@ -534,10 +534,12 @@ static int ccwchain_fetch_direct(struct ccwchain *chain,

The one minor thing I have is that the function name
(ccwchain_fetch_direct) is now slightly confusing. But we can easily do
a patch on top renaming it (if we can come up with a better name.)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
