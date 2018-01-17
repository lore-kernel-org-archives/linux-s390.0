From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH 06/12] KVM: s390: exploit GISA and AIV for emulated
 interrupts
Date: Wed, 17 Jan 2018 09:14:03 +0100
Message-ID: <20180117081403.GB5708@osiris>
References: <20180116200217.211897-1-borntraeger@de.ibm.com>
 <20180116200217.211897-7-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180116200217.211897-7-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Michael Mueller <mimu@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Tue, Jan 16, 2018 at 09:02:11PM +0100, Christian Borntraeger wrote:
> +static int __do_deliver_io(struct kvm_vcpu *vcpu, struct kvm_s390_io_info *io)
> +{
> +	int rc;
> +
> +	rc  = put_guest_lc(vcpu, io->subchannel_id,
> +			   (u16 *)__LC_SUBCHANNEL_ID);
> +	rc |= put_guest_lc(vcpu, io->subchannel_nr,
> +			   (u16 *)__LC_SUBCHANNEL_NR);
> +	rc |= put_guest_lc(vcpu, io->io_int_parm,
> +			   (u32 *)__LC_IO_INT_PARM);
> +	rc |= put_guest_lc(vcpu, io->io_int_word,
> +			   (u32 *)__LC_IO_INT_WORD);

They all fit into one line now ;)

> +	rc |= write_guest_lc(vcpu, __LC_IO_OLD_PSW,
> +			     &vcpu->arch.sie_block->gpsw,
> +			     sizeof(psw_t));
> +	rc |= read_guest_lc(vcpu, __LC_IO_NEW_PSW,
> +			    &vcpu->arch.sie_block->gpsw,
> +			    sizeof(psw_t));
> +	return rc;
> +}

return rc = -EFAULT : 0;

from below should be moved to this function, so it has a well defined
return value instead of random garbage. Well, it's -EFAULT or 0 currently
anyway, but nobody knows...

>  static int __must_check __deliver_io(struct kvm_vcpu *vcpu,
>  				     unsigned long irq_type)
>  {
...
> +out:
>  	return rc ? -EFAULT : 0;
>  }
