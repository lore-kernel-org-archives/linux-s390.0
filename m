Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:10103 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726670AbfGCJHH (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 3 Jul 2019 05:07:07 -0400
Date: Wed, 3 Jul 2019 11:07:04 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH] vfio-ccw: Fix the conversion of Format-0 CCWs to
 Format-1
Message-ID: <20190703110704.21509e60.cohuck@redhat.com>
In-Reply-To: <20190702180928.18113-1-farman@linux.ibm.com>
References: <20190702180928.18113-1-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Eric Farman <farman@linux.ibm.com>
Cc: Farhan Ali <alifm@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org

On Tue,  2 Jul 2019 20:09:28 +0200
Eric Farman <farman@linux.ibm.com> wrote:

> When processing Format-0 CCWs, we use the "len" variable as the
> number of CCWs to convert to Format-1.  But that variable
> contains zero here, and is not a meaningful CCW count until
> ccwchain_calc_length() returns.  Since that routine requires and
> expects Format-1 CCWs to identify the chaining behavior, the
> format conversion must be done first.

The usage of the 'len' variable in the function is a bit confusing
anyway.

> 
> Convert the 2KB we copied even if it's more than we need.
> 
> Fixes: 7f8e89a8f2fd ("vfio-ccw: Factor out the ccw0-to-ccw1 transition")
> Reported-by: Farhan Ali <alifm@linux.ibm.com>
> Signed-off-by: Eric Farman <farman@linux.ibm.com>
> ---
>  drivers/s390/cio/vfio_ccw_cp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
> index 9cddc1288059..a870bde10445 100644
> --- a/drivers/s390/cio/vfio_ccw_cp.c
> +++ b/drivers/s390/cio/vfio_ccw_cp.c
> @@ -431,7 +431,7 @@ static int ccwchain_handle_ccw(u32 cda, struct channel_program *cp)
>  
>  	/* Convert any Format-0 CCWs to Format-1 */
>  	if (!cp->orb.cmd.fmt)
> -		convert_ccw0_to_ccw1(cp->guest_cp, len);
> +		convert_ccw0_to_ccw1(cp->guest_cp, CCWCHAIN_LEN_MAX);
>  
>  	/* Count the CCWs in the current chain */
>  	len = ccwchain_calc_length(cda, cp);

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
