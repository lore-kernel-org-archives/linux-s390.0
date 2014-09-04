From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [RFC][patch 3/6] KVM: s390: Add GISA support
Date: Thu, 4 Sep 2014 16:19:42 +0200
Message-ID: <20140904141942.GB4206@osiris>
References: <20140904105223.336503578@de.ibm.com>
 <20140904105337.081387456@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140904105337.081387456@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: frank.blaschka@de.ibm.com
Cc: qemu-devel@nongnu.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, aik@ozlabs.ru, pbonzini@redhat.com, agraf@suse.de
List-ID: <linux-s390.vger.kernel.org>

On Thu, Sep 04, 2014 at 12:52:26PM +0200, frank.blaschka@de.ibm.com wrote:
> +void kvm_s390_gisa_register_alert(struct kvm *kvm, u32 gisc)
> +{
> +	int bito = BITS_PER_BYTE * 7 + gisc;
> +
> +	set_bit(bito ^ (BITS_PER_LONG - 1), &kvm->arch.iam);
> +}

Just a very minor nit: you could also use set_bit_inv() & friends.

> +static inline u64 kvm_s390_get_base_disp_rxy(struct kvm_vcpu *vcpu)
> +{
> +	u32 x2 = (vcpu->arch.sie_block->ipa & 0x000f);
> +	u32 base2 = vcpu->arch.sie_block->ipb >> 28;
> +	u32 disp2 = ((vcpu->arch.sie_block->ipb & 0x0fff0000) >> 16) +
> +		((vcpu->arch.sie_block->ipb & 0xff00) << 4);
> +
> +	return (base2 ? vcpu->run->s.regs.gprs[base2] : 0) +
> +		(x2 ? vcpu->run->s.regs.gprs[x2] : 0) + (u64)disp2;
> +}

Not very readable ;) However.. for the RXY instruction format the 20 bit
displacement is usually signed and not unsigned like your code seems to
treat it.
