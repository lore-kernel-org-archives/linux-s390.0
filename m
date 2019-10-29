Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 29 Oct 2019 23:19:17 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH] s390: vfio-ap: disable IRQ in remove callback results
 in kernel OOPS
Message-ID: <20191029231917.0e6a62b9.cohuck@redhat.com>
In-Reply-To: <1572386946-22566-1-git-send-email-akrowiak@linux.ibm.com>
References: <1572386946-22566-1-git-send-email-akrowiak@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, heiko.carstens@de.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com, freude@linux.ibm.com, mjrosato@linux.ibm.com, pmorel@linux.ibm.com, pasic@linux.ibm.com, jjherne@linux.ibm.com

On Tue, 29 Oct 2019 18:09:06 -0400
Tony Krowiak <akrowiak@linux.ibm.com> wrote:

> From: aekrowia <akrowiak@linux.ibm.com>

Some accident seems to have happened to your git config.

>=20
> When an AP adapter card is configured off via the SE or the SCLP
> Deconfigure Adjunct Processor command and the AP bus subsequently detects
> that the adapter card is no longer in the AP configuration, the card
> device representing the adapter card as well as each of its associated
> AP queue devices will be removed by the AP bus. If one or more of the
> affected queue devices is bound to the VFIO AP device driver, its remove
> callback will be invoked for each queue to be removed. The remove callbac=
k
> resets the queue and disables IRQ processing. If interrupt processing was
> never enabled for the queue, disabling IRQ processing will fail resulting
> in a kernel OOPS.
>=20
> This patch verifies IRQ processing is enabled before attempting to disabl=
e
> interrupts for the queue.
>=20
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> Signed-off-by: aekrowia <akrowiak@linux.ibm.com>
> ---
>  drivers/s390/crypto/vfio_ap_drv.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio=
_ap_drv.c
> index be2520cc010b..42d8308fd3a1 100644
> --- a/drivers/s390/crypto/vfio_ap_drv.c
> +++ b/drivers/s390/crypto/vfio_ap_drv.c
> @@ -79,7 +79,8 @@ static void vfio_ap_queue_dev_remove(struct ap_device *=
apdev)
>  =09apid =3D AP_QID_CARD(q->apqn);
>  =09apqi =3D AP_QID_QUEUE(q->apqn);
>  =09vfio_ap_mdev_reset_queue(apid, apqi, 1);
> -=09vfio_ap_irq_disable(q);
> +=09if (q->saved_isc !=3D VFIO_AP_ISC_INVALID)
> +=09=09vfio_ap_irq_disable(q);

Hm... would it make sense to move that check into vfio_ap_irq_disable()
instead? Or are we sure that in all other cases the irq processing had
been enabled before?

Also, if that oops is reasonably easy to trigger, it would probably
make sense to cc:stable. (Or is this a new problem?)

>  =09kfree(q);
>  =09mutex_unlock(&matrix_dev->lock);
>  }
