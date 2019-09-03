Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47904 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730079AbfICQpr (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 3 Sep 2019 12:45:47 -0400
Date: Tue, 3 Sep 2019 18:45:42 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 1/1] s390: vfio-ap: fix warning reset not completed
Message-ID: <20190903184542.2d955111.cohuck@redhat.com>
In-Reply-To: <20190903133618.9122-1-pasic@linux.ibm.com>
References: <20190903133618.9122-1-pasic@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: Tony Krowiak <akrowiak@linux.ibm.com>, Harald Freudenberger <freude@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>

On Tue,  3 Sep 2019 15:36:18 +0200
Halil Pasic <pasic@linux.ibm.com> wrote:

"fix warning for not completed reset"?

> The intention seems to be to warn once when we don't wait enough for the
> reset to complete. Let's use the right retry counter to accomplish that
> semantic.
> 
> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> ---
>  drivers/s390/crypto/vfio_ap_ops.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
> index 0604b49a4d32..5c0f53c6dde7 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -1143,7 +1143,7 @@ int vfio_ap_mdev_reset_queue(unsigned int apid, unsigned int apqi,
>  				msleep(20);
>  				status = ap_tapq(apqn, NULL);
>  			}
> -			WARN_ON_ONCE(retry <= 0);
> +			WARN_ON_ONCE(retry2 <= 0);
>  			return 0;
>  		case AP_RESPONSE_RESET_IN_PROGRESS:
>  		case AP_RESPONSE_BUSY:

Makes sense.

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
