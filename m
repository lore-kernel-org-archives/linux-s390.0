Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:59135 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726824AbfLSJZJ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 19 Dec 2019 04:25:09 -0500
Date: Thu, 19 Dec 2019 10:24:59 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 1/3] s390/dasd/cio: Interpret ccw_device_get_mdc return
 value correctly
Message-ID: <20191219102459.053999a2.cohuck@redhat.com>
In-Reply-To: <20191219084352.75114-2-sth@linux.ibm.com>
References: <20191219084352.75114-1-sth@linux.ibm.com>
        <20191219084352.75114-2-sth@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Stefan Haberland <sth@linux.ibm.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, hoeppner@linux.ibm.com, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com

On Thu, 19 Dec 2019 09:43:50 +0100
Stefan Haberland <sth@linux.ibm.com> wrote:

> From: Jan H=C3=B6ppner <hoeppner@linux.ibm.com>
>=20
> The max data count (mdc) is an unsigned 16-bit integer value as per AR
> documentation and is received via ccw_device_get_mdc() for a specific
> path mask from the CIO layer. The function itself also always returns a
> positive mdc value or 0 in case mdc isn't supported or couldn't be
> determined.
>=20
> Though, the comment for this function describes a negative return value
> to indicate failures.

Note that this used to be true before 040495d110ba ("s390/cio: make use
of newly added format 1 channel-path data").

>=20
> As a result, the DASD device driver interprets the return value of
> ccw_device_get_mdc() incorrectly. The error case is essentially a dead
> code path.

To be pedantic: It did not check for <=3D 0 (as documented) either :)

>=20
> To fix this behaviour, check explicitly for a return value of 0 and
> change the comment for ccw_device_get_mdc() accordingly.
>=20
> This fix merely enables the error code path in the DASD functions
> get_fcx_max_data() and verify_fcx_max_data(). The actual functionality
> stays the same and is still correct.
>=20
> Signed-off-by: Jan H=C3=B6ppner <hoeppner@linux.ibm.com>
> Acked-by: Peter Oberparleiter <oberpar@linux.ibm.com>
> Reviewed-by: Stefan Haberland <sth@linux.ibm.com>
> Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
> ---
>  drivers/s390/block/dasd_eckd.c | 9 +++++----
>  drivers/s390/cio/device_ops.c  | 2 +-
>  2 files changed, 6 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eck=
d.c
> index c94184d080f8..f5622f4a2ecf 100644
> --- a/drivers/s390/block/dasd_eckd.c
> +++ b/drivers/s390/block/dasd_eckd.c
> @@ -1128,7 +1128,8 @@ static u32 get_fcx_max_data(struct dasd_device *dev=
ice)
>  {
>  	struct dasd_eckd_private *private =3D device->private;
>  	int fcx_in_css, fcx_in_gneq, fcx_in_features;
> -	int tpm, mdc;
> +	unsigned int mdc;
> +	int tpm;
> =20
>  	if (dasd_nofcx)
>  		return 0;
> @@ -1142,7 +1143,7 @@ static u32 get_fcx_max_data(struct dasd_device *dev=
ice)
>  		return 0;
> =20
>  	mdc =3D ccw_device_get_mdc(device->cdev, 0);
> -	if (mdc < 0) {
> +	if (mdc =3D=3D 0) {
>  		dev_warn(&device->cdev->dev, "Detecting the maximum supported data siz=
e for zHPF requests failed\n");
>  		return 0;
>  	} else {
> @@ -1153,12 +1154,12 @@ static u32 get_fcx_max_data(struct dasd_device *d=
evice)
>  static int verify_fcx_max_data(struct dasd_device *device, __u8 lpm)
>  {
>  	struct dasd_eckd_private *private =3D device->private;
> -	int mdc;
> +	unsigned int mdc;
>  	u32 fcx_max_data;
> =20
>  	if (private->fcx_max_data) {
>  		mdc =3D ccw_device_get_mdc(device->cdev, lpm);
> -		if ((mdc < 0)) {
> +		if (mdc =3D=3D 0) {
>  			dev_warn(&device->cdev->dev,
>  				 "Detecting the maximum data size for zHPF "
>  				 "requests failed (rc=3D%d) for a new path %x\n",
> diff --git a/drivers/s390/cio/device_ops.c b/drivers/s390/cio/device_ops.c
> index 65841af15748..ccecf6b9504e 100644
> --- a/drivers/s390/cio/device_ops.c
> +++ b/drivers/s390/cio/device_ops.c
> @@ -635,7 +635,7 @@ EXPORT_SYMBOL(ccw_device_tm_start_timeout);
>   * @mask: mask of paths to use
>   *
>   * Return the number of 64K-bytes blocks all paths at least support
> - * for a transport command. Return values <=3D 0 indicate failures.
> + * for a transport command. Return value 0 indicates failure.

s/Return value/The return value/ ?

>   */
>  int ccw_device_get_mdc(struct ccw_device *cdev, u8 mask)
>  {

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
