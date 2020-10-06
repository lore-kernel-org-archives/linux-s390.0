Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29907 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725939AbgJFJrF (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 6 Oct 2020 05:47:05 -0400
Date: Tue, 6 Oct 2020 11:46:56 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 01/10] s390/cio: Export information about
 Endpoint-Security Capability
Message-ID: <20201006114656.6b1a97b1.cohuck@redhat.com>
In-Reply-To: <20201002193940.24012-2-sth@linux.ibm.com>
References: <20201002193940.24012-1-sth@linux.ibm.com>
        <20201002193940.24012-2-sth@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
List-ID: <linux-s390.vger.kernel.org>
To: Stefan Haberland <sth@linux.ibm.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, hoeppner@linux.ibm.com, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com

On Fri,  2 Oct 2020 21:39:31 +0200
Stefan Haberland <sth@linux.ibm.com> wrote:

> From: Sebastian Ott <sebott@linux.ibm.com>
>=20
> Add a new sysfs attribute 'esc' per chpid. This new attribute exports
> the Endpoint-Security-Capability byte of channel-path description block,
> which could be 0-None, 1-Authentication, 2 and 3-Encryption.
>=20
> For example:
> $ cat /sys/devices/css0/chp0.34/esc
> 0
>=20
> Reference-ID: IO1812
> Signed-off-by: Sebastian Ott <sebott@linux.ibm.com>
> [vneethv@linux.ibm.com: cleaned-up & modified description]
> Signed-off-by: Vineeth Vijayan <vneethv@linux.ibm.com>
> Reviewed-by: Jan H=C3=B6ppner <hoeppner@linux.ibm.com>
> Reviewed-by: Peter Oberparleiter <oberpar@linux.ibm.com>
> Acked-by: Vasily Gorbik <gor@linux.ibm.com>
> Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
> ---
>  drivers/s390/cio/chp.c  | 15 +++++++++++++++
>  drivers/s390/cio/chsc.h |  3 ++-
>  2 files changed, 17 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/s390/cio/chp.c b/drivers/s390/cio/chp.c
> index dfcbe54591fb..8d0de6adcad0 100644
> --- a/drivers/s390/cio/chp.c
> +++ b/drivers/s390/cio/chp.c
> @@ -384,6 +384,20 @@ static ssize_t chp_chid_external_show(struct device =
*dev,
>  }
>  static DEVICE_ATTR(chid_external, 0444, chp_chid_external_show, NULL);
> =20
> +static ssize_t chp_esc_show(struct device *dev,
> +			    struct device_attribute *attr, char *buf)
> +{
> +	struct channel_path *chp =3D to_channelpath(dev);
> +	ssize_t rc;
> +
> +	mutex_lock(&chp->lock);
> +	rc =3D sprintf(buf, "%x\n", chp->desc_fmt1.esc);

I'm wondering: Do we need to distinguish between '0' =3D=3D 'no esc, and
the hardware says so' and '0' =3D=3D 'the chsc to get that information is
not supported'? I see that for the chid the code checks for a flag in
desc_fmt1, and I indeed see that nothing is displayed for
chid/chid_external when I run under QEMU.

> +	mutex_unlock(&chp->lock);
> +
> +	return rc;
> +}
> +static DEVICE_ATTR(esc, 0444, chp_esc_show, NULL);
> +
>  static ssize_t util_string_read(struct file *filp, struct kobject *kobj,
>  				struct bin_attribute *attr, char *buf,
>  				loff_t off, size_t count)

(...)
