From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v6 11/13] KVM: s390: add functions to (un)register GISC
 with GISA
Date: Mon, 28 Jan 2019 19:12:42 +0100
Message-ID: <20190128191242.0f65d82b@oc2783563651>
References: <20190124125939.130763-1-mimu@linux.ibm.com>
        <20190124125939.130763-12-mimu@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190124125939.130763-12-mimu@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Michael Mueller <mimu@linux.ibm.com>
Cc: KVM Mailing List <kvm@vger.kernel.org>, Linux-S390 Mailing List <linux-s390@vger.kernel.org>, linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Pierre Morel <pmorel@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Thu, 24 Jan 2019 13:59:37 +0100
Michael Mueller <mimu@linux.ibm.com> wrote:

> Add the Interruption Alert Mask (IAM) to the architecture specific
> kvm struct. This mask in the GISA is used to define for which ISC
> a GIB alert will be issued.
> 
> The functions kvm_s390_gisc_register() and kvm_s390_gisc_unregister()
> are used to (un)register a GISC (guest ISC) with a virtual machine and
> its GISA.
> 
> Upon successful completion, kvm_s390_gisc_register() returns the
> ISC to be used for GIB alert interruptions. A negative return code
> indicates an error during registration.
> 
> Theses functions will be used by other adapter types like AP and PCI to
> request pass-through interruption support.


I'm not sure this interface is going to to fit PCI that well. But IMHO
no reason to delay the whole series -- we can think about zPCI later.
Same goes for some of the names.

Another idea for later would be to sanity check in gisa destroy that
alert.mask is back to all zero -- to catch any corresponding driver
bugs.

Acked-by: Halil Pasic <pasic@linux.ibm.com>

> 
> Signed-off-by: Michael Mueller <mimu@linux.ibm.com>

[..]

>  static inline void gisa_set_ipm_gisc(struct kvm_s390_gisa *gisa, u32 gisc)
>  {
>  	set_bit_inv(IPM_BIT_OFFSET + gisc, (unsigned long *) gisa);
> @@ -2911,6 +2938,8 @@ void kvm_s390_gisa_init(struct kvm *kvm)
>  	if (!css_general_characteristics.aiv)
>  		return;
>  	gi->origin = &kvm->arch.sie_page2->gisa;
> +	gi->alert.mask = 0;

I don't think this is necessary. Otherwise you would need to
zero the alert.ref[] too, or?

Regards,
Halil

> +	spin_lock_init(&gi->alert.ref_lock);
>  	kvm_s390_gisa_clear(kvm);
>  	VM_EVENT(kvm, 3, "gisa 0x%pK initialized", gi->origin);
>  }
