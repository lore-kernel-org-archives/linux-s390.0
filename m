From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 1/2] KVM: s390: optimize wakeup for exitless interrupts
Date: Tue, 13 Feb 2018 14:40:21 +0100
Message-ID: <818b6cf8-06f1-e5b8-b35b-6b9d4badd7c4@redhat.com>
References: <20180213122858.74748-1-borntraeger@de.ibm.com>
 <20180213122858.74748-2-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20180213122858.74748-2-borntraeger@de.ibm.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On 13.02.2018 13:28, Christian Borntraeger wrote:
> For interrupt injection of floating interrupts we queue the interrupt
> either in the GISA or in the floating  interrupt list. The first CPU
> that looks at these data structures - either in KVM code or hardware
> will then deliver that interrupt. To minimize latency we also:
> -a: choose a VCPU to deliver that interrupt. We prefer idle CPUs
> -b: we wake up the host thread that runs the VCPU
> -c: set an I/O intervention bit for that CPU so that it exits guest
>     context as soon as the PSW I/O mask is enabled
> This will make sure that this CPU will execute the interrupt delivery
> code of KVM very soon.
> 
> We can now optimize the injection case if we have exitless interrupts.
> The wakeup is still necessary in case the target CPU sleeps. We can
> avoid the I/O intervention request bit though. Whenever this
> intervention request would be handled, the hardware could also directly
> inject the interrupt on that CPU, no need to go through the interrupt
> injection loop of KVM.
> 
> Cc: Michael Mueller <mimu@linux.vnet.ibm.com>
> Reviewed-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  arch/s390/kvm/interrupt.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> index aabf46f5f883..337a69bc04db 100644
> --- a/arch/s390/kvm/interrupt.c
> +++ b/arch/s390/kvm/interrupt.c
> @@ -1701,7 +1701,8 @@ static void __floating_irq_kick(struct kvm *kvm, u64 type)
>  		kvm_s390_set_cpuflags(dst_vcpu, CPUSTAT_STOP_INT);
>  		break;
>  	case KVM_S390_INT_IO_MIN...KVM_S390_INT_IO_MAX:
> -		kvm_s390_set_cpuflags(dst_vcpu, CPUSTAT_IO_INT);
> +		if (!(type & KVM_S390_INT_IO_AI_MASK && kvm->arch.gisa))
> +			kvm_s390_set_cpuflags(dst_vcpu, CPUSTAT_IO_INT);
>  		break;
>  	default:
>  		kvm_s390_set_cpuflags(dst_vcpu, CPUSTAT_EXT_INT);
> 

Looks sane to me

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David / dhildenb
