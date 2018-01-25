From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v2 06/12] KVM: s390: exploit GISA and AIV for emulated
 interrupts
Date: Thu, 25 Jan 2018 17:39:53 +0100
Message-ID: <20180125173953.302fd88e.cohuck@redhat.com>
References: <20180125132848.175942-1-borntraeger@de.ibm.com>
        <20180125132848.175942-7-borntraeger@de.ibm.com>
        <040c7c5d-bbbd-89d4-ebcd-5d04ed80a40d@redhat.com>
        <b7fb3580-0eae-ee29-cae6-d58bc8a4e350@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <b7fb3580-0eae-ee29-cae6-d58bc8a4e350@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: David Hildenbrand <david@redhat.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Michael Mueller <mimu@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Thu, 25 Jan 2018 17:32:29 +0100
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 01/25/2018 03:20 PM, David Hildenbrand wrote:
> [...]
> >> @@ -918,18 +919,38 @@ static int __must_check __deliver_virtio(struct kvm_vcpu *vcpu)
> >>  	return rc ? -EFAULT : 0;
> >>  }
> >>  
> >> +static int __do_deliver_io(struct kvm_vcpu *vcpu, struct kvm_s390_io_info *io)
> >> +{
> >> +	int rc;
> >> +
> >> +	rc  = put_guest_lc(vcpu, io->subchannel_id, (u16 *)__LC_SUBCHANNEL_ID);
> >> +	rc |= put_guest_lc(vcpu, io->subchannel_nr, (u16 *)__LC_SUBCHANNEL_NR);
> >> +	rc |= put_guest_lc(vcpu, io->io_int_parm, (u32 *)__LC_IO_INT_PARM);
> >> +	rc |= put_guest_lc(vcpu, io->io_int_word, (u32 *)__LC_IO_INT_WORD);
> >> +	rc |= write_guest_lc(vcpu, __LC_IO_OLD_PSW,
> >> +			     &vcpu->arch.sie_block->gpsw,
> >> +			     sizeof(psw_t));
> >> +	rc |= read_guest_lc(vcpu, __LC_IO_NEW_PSW,
> >> +			    &vcpu->arch.sie_block->gpsw,
> >> +			    sizeof(psw_t));  
> > 
> > These should now it into less lines.  
> 
> The last two lines are way beyond 80. 
> 
> Can you factor that change out into
> > a separate patch?  
> 
> 
> Unless Conny agrees that this is absolutely mandatory I would like to avoid that.

I don't think factoring this out would be very useful.
