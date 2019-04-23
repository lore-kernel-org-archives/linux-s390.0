Return-Path: <SRS0=oVSW=SZ=vger.kernel.org=kvm-owner@kernel.org>
Date: Tue, 23 Apr 2019 15:54:58 +0200
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v2 7/8] s390: vfio-ap: handle bind and unbind of AP
 queue device
In-Reply-To: <1555796980-27920-8-git-send-email-akrowiak@linux.ibm.com>
References: <1555796980-27920-1-git-send-email-akrowiak@linux.ibm.com>
        <1555796980-27920-8-git-send-email-akrowiak@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20190423155458.65966ebf.pasic@linux.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@linux.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, frankja@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, pmorel@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com
List-ID: <linux-s390.vger.kernel.org>

On Sat, 20 Apr 2019 17:49:39 -0400
Tony Krowiak <akrowiak@linux.ibm.com> wrote:

> +void vfio_ap_mdev_probe_queue(unsigned long apid, unsigned long apqi)
> +{
> +	struct ap_matrix_mdev *matrix_mdev;
> +
> +	matrix_mdev = vfio_ap_mdev_find_matrix_mdev(apid, apqi);
> +
> +	/*
> +	 * If the queue is assigned to the mdev device and the mdev device
> +	 * is in use by a guest
> +	 */
> +	if (matrix_mdev && matrix_mdev->kvm) {
> +		/* Plug the adapter into the guest */
> +		set_bit_inv(apid, matrix_mdev->shadow_crycb->apm);
> +
> +		/* Make sure the queue is also plugged in to the guest */
> +		if (!test_bit_inv(apqi, matrix_mdev->shadow_crycb->aqm))
> +			set_bit_inv(apqi, matrix_mdev->shadow_crycb->aqm);
> +
> +		vfio_ap_mdev_update_crycb(matrix_mdev);

With this you effectively grant access to all the assigned domains on
the AP identified by the apid, not only to the domain identified by
apqi! But some of these queues may still not be bound to the vfio_ap
driver.

IMHO you should only set the apid-th bit in apm if all queues (apid, q)
such that q-th bit is set in aqm are bound to the vfio_ap driver.

BTW a 'shadow' (or effective) apm would perfectly suffice. I don't think
you fiddle with shadow_crycb->a[qd]m, and if you do, I don't think that's
a good idea.

Regards,
Halil

> +	}
> +}
