From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v5 08/15] KVM: s390: add the GIB and its related
 life-cyle functions
Date: Thu, 20 Dec 2018 13:28:49 +0100
Message-ID: <20181220132849.2b7cf473.cohuck@redhat.com>
References: <20181219191756.57973-1-mimu@linux.ibm.com>
        <20181219191756.57973-9-mimu@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181219191756.57973-9-mimu@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Michael Mueller <mimu@linux.ibm.com>
Cc: KVM Mailing List <kvm@vger.kernel.org>, Linux-S390 Mailing List <linux-s390@vger.kernel.org>, linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Wed, 19 Dec 2018 20:17:49 +0100
Michael Mueller <mimu@linux.ibm.com> wrote:

> The Guest Information Block (GIB) links the GISA of all guests
> that have adapter interrupts pending. These interrupts cannot be
> delivered because no vcpu of these guests is currently running in
> SIE context. Instead, a GIB alert is issued on the host to schedule
> these guests to run.
> 
> This mechanism allows to process adapter interrupts for currently
> not running guests.
> 
> The GIB is created during host initialization and associated with
> the Adapter Interruption Facility in case an Adapter Interruption
> Virtualization Facility is available.
> 
> The GIB initialization and thus the activation of the related code
> will be done in an upcoming patch of this series.
> 
> Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
> Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  arch/s390/include/asm/kvm_host.h | 10 +++++++++
>  arch/s390/kvm/interrupt.c        | 44 ++++++++++++++++++++++++++++++++++++++++
>  arch/s390/kvm/kvm-s390.c         |  1 +
>  arch/s390/kvm/kvm-s390.h         |  2 ++
>  4 files changed, 57 insertions(+)

> +int kvm_s390_gib_init(u8 nisc)
> +{
> +	int rc = 0;
> +
> +	if (!css_general_characteristics.aiv) {
> +		KVM_EVENT(3, "%s", "gib not initialized, no AIV facility");
> +		goto out;
> +	}
> +
> +	gib = (struct kvm_s390_gib *)get_zeroed_page(GFP_KERNEL | GFP_DMA);
> +	if (!gib) {
> +		rc = -ENOMEM;
> +		goto out;
> +	}
> +
> +	gib->nisc = nisc;
> +	if (chsc_sgib((u32)(u64)gib)) {
> +		pr_err("Associating the GIB with the AIV facility failed\n");

I presume that logging the chsc response code (or returning it instead
of -EIO) would not give any interesting information?

> +		free_page((unsigned long)gib);
> +		gib = NULL;
> +		rc = -EIO;
> +		goto out;
> +	}
> +
> +	KVM_EVENT(3, "gib 0x%pK (nisc=%d) initialized", gib, gib->nisc);
> +out:
> +	return rc;
> +}

Anyhow,
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
