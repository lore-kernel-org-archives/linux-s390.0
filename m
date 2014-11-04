From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PULL 1/1] KVM: s390: virtio_ccw: remove unused variable
Date: Tue, 04 Nov 2014 19:46:51 +0100
Message-ID: <54591F1B.50809@redhat.com>
References: <1415014192-19194-1-git-send-email-cornelia.huck@de.ibm.com> <1415014192-19194-2-git-send-email-cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1415014192-19194-2-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Gleb Natapov <gleb@kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Sebastian Ott <sebott@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On 03/11/2014 12:29, Cornelia Huck wrote:
> From: Sebastian Ott <sebott@linux.vnet.ibm.com>
>=20
> Fix this warning:
> drivers/s390/kvm/virtio_ccw.c: In function =E2=80=98virtio_ccw_int_ha=
ndler=E2=80=99:
> drivers/s390/kvm/virtio_ccw.c:891:24: warning: unused variable =E2=80=
=98drv=E2=80=99 [-Wunused-variable]
>     struct virtio_driver *drv;
>=20
> Signed-off-by: Sebastian Ott <sebott@linux.vnet.ibm.com>
> Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> Acked-by: Rusty Russell <rusty@rustcorp.com.au>
> Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> ---
>  drivers/s390/kvm/virtio_ccw.c |    1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/s390/kvm/virtio_ccw.c b/drivers/s390/kvm/virtio_=
ccw.c
> index 6cbe6ef..bda52f1 100644
> --- a/drivers/s390/kvm/virtio_ccw.c
> +++ b/drivers/s390/kvm/virtio_ccw.c
> @@ -888,7 +888,6 @@ static void virtio_ccw_int_handler(struct ccw_dev=
ice *cdev,
>  	struct virtio_ccw_device *vcdev =3D dev_get_drvdata(&cdev->dev);
>  	int i;
>  	struct virtqueue *vq;
> -	struct virtio_driver *drv;
> =20
>  	if (!vcdev)
>  		return;
>=20

Pulled, thanks.

Paolo
