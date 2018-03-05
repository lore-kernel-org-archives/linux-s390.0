From: David Hildenbrand <david@redhat.com>
Date: Mon, 05 Mar 2018 12:56:59 +0000
Subject: Re: [PATCH 2/2] KVM: add machine check counter kvm_stat
Message-Id: <f2a49129-1674-eb46-67ac-23a577ef4d31@redhat.com>
In-Reply-To: <20180305122222.37f2ceb7.cohuck@redhat.com>
References: <20180305122222.37f2ceb7.cohuck@redhat.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 05.03.2018 12:16, Christian Borntraeger wrote:
> From: QingFeng Hao <haoqf@linux.vnet.ibm.com>
> 
> This counter can be used for administration, debug or test purpose.
> 
> Suggested-by: Vladislav Mironov <mironov@de.ibm.com>
> Signed-off-by: QingFeng Hao <haoqf@linux.vnet.ibm.com>
> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  arch/s390/include/asm/kvm_host.h | 1 +
>  arch/s390/kvm/interrupt.c        | 1 +
>  arch/s390/kvm/kvm-s390.c         | 1 +
>  3 files changed, 3 insertions(+)
> 
> diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
> index 22615af0b6e6..77a49de9c511 100644
> --- a/arch/s390/include/asm/kvm_host.h
> +++ b/arch/s390/include/asm/kvm_host.h
> @@ -320,6 +320,7 @@ struct kvm_vcpu_stat {
>  	u64 deliver_restart_signal;
>  	u64 deliver_program_int;
>  	u64 deliver_io_int;
> +	u64 deliver_machine_check;
>  	u64 exit_wait_state;
>  	u64 instruction_epsw;
>  	u64 instruction_gs;
> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> index b04616b57a94..bde04a6191ca 100644
> --- a/arch/s390/kvm/interrupt.c
> +++ b/arch/s390/kvm/interrupt.c
> @@ -595,6 +595,7 @@ static int __must_check __deliver_machine_check(struct kvm_vcpu *vcpu)
>  		trace_kvm_s390_deliver_interrupt(vcpu->vcpu_id,
>  						 KVM_S390_MCHK,
>  						 mchk.cr14, mchk.mcic);
> +		vcpu->stat.deliver_machine_check++;
>  		rc = __write_machine_check(vcpu, &mchk);
>  	}
>  	return rc;
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 6ee1d13a72f9..432277ad2114 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -88,6 +88,7 @@ struct kvm_stats_debugfs_item debugfs_entries[] = {
>  	{ "deliver_restart_signal", VCPU_STAT(deliver_restart_signal) },
>  	{ "deliver_program_interruption", VCPU_STAT(deliver_program_int) },
>  	{ "deliver_io_interrupt", VCPU_STAT(deliver_io_int) },
> +	{ "deliver_machine_check", VCPU_STAT(deliver_machine_check) },
>  	{ "exit_wait_state", VCPU_STAT(exit_wait_state) },
>  	{ "instruction_epsw", VCPU_STAT(instruction_epsw) },
>  	{ "instruction_gs", VCPU_STAT(instruction_gs) },
> 


Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David / dhildenb
