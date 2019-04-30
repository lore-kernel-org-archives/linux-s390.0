Return-Path: <SRS0=Ul9H=TA=vger.kernel.org=kvm-owner@kernel.org>
Date: Tue, 30 Apr 2019 15:26:05 +0200
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v7 3/4] s390: ap: implement PAPQ AQIC interception in
 kernel
In-Reply-To: <1556283688-556-4-git-send-email-pmorel@linux.ibm.com>
References: <1556283688-556-1-git-send-email-pmorel@linux.ibm.com>
        <1556283688-556-4-git-send-email-pmorel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20190430152605.3bb21f31.pasic@linux.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>
Cc: borntraeger@de.ibm.com, alex.williamson@redhat.com, cohuck@redhat.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On Fri, 26 Apr 2019 15:01:27 +0200
Pierre Morel <pmorel@linux.ibm.com> wrote:

> +/**
> + * vfio_ap_clrirq: Disable Interruption for a APQN
> + *
> + * @dev: the device associated with the ap_queue
> + * @q:   the vfio_ap_queue holding AQIC parameters
> + *
> + * Issue the host side PQAP/AQIC
> + * On success: unpin the NIB saved in *q and unregister from GIB
> + * interface
> + *
> + * Return the ap_queue_status returned by the ap_aqic()
> + */
> +static struct ap_queue_status vfio_ap_clrirq(struct vfio_ap_queue *q)
> +{
> +	struct ap_qirq_ctrl aqic_gisa = {};
> +	struct ap_queue_status status;
> +	int checks = 10;
> +
> +	status = ap_aqic(q->apqn, aqic_gisa, NULL);
> +	if (!status.response_code) {
> +		while (status.irq_enabled && checks--) {
> +			msleep(20);

Hm, that seems like a lot of time to me. And I suppose we are holding the
kvm lock: e.g. no other instruction can be interpreted by kvm in the
meantime.

> +			status = ap_tapq(q->apqn, NULL);
> +		}
> +		if (checks >= 0)
> +			vfio_ap_free_irq_data(q);

Actually we don't have to wait for the async part to do it's magic
(indicated by the status.irq_enabled --> !status.irq_enabled transition)
in the instruction handler. We have to wait so we can unpin the NIB but
that could be done async (e.g. workqueue).

BTW do you have any measurements here? How many msleep(20) do we
experience for one clear on average?

If linux is not using clear (you told so offline, and I also remember
something similar), we can probably get away with something like this,
and do it properly (from performance standpoint) later.

Regards,
Halil

> +		else
> +			WARN_ONCE("%s: failed disabling IRQ", __func__);
> +	}
> +
> +	return status;
> +}
