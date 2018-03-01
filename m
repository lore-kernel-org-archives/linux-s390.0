From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 01 Mar 2018 11:29:44 +0000
Subject: Re: [PATCH 1/1] KVM: s390: provide io interrupt kvm_stat
Message-Id: <e26cb9b4-6707-8ec8-cd3f-2cc4297d799e@de.ibm.com>
In-Reply-To: <dbb77d85-9b47-fc76-ea36-97cbe77352b9@redhat.com>
References: <dbb77d85-9b47-fc76-ea36-97cbe77352b9@redhat.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

queued. Might be even for kvm/master.

On 02/28/2018 07:49 PM, Christian Borntraeger wrote:
> we already count io interrupt, but we forgot to print them.
> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Fixes: d8346b7d9b ("KVM: s390: Support for I/O interrupts.")
> ---
>  arch/s390/kvm/kvm-s390.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 507bacd033cc..91c48967ccda 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -87,6 +87,7 @@ struct kvm_stats_debugfs_item debugfs_entries[] = {
>  	{ "deliver_prefix_signal", VCPU_STAT(deliver_prefix_signal) },
>  	{ "deliver_restart_signal", VCPU_STAT(deliver_restart_signal) },
>  	{ "deliver_program_interruption", VCPU_STAT(deliver_program_int) },
> +	{ "deliver_io_interrupt", VCPU_STAT(deliver_io_int) },
>  	{ "exit_wait_state", VCPU_STAT(exit_wait_state) },
>  	{ "instruction_epsw", VCPU_STAT(instruction_epsw) },
>  	{ "instruction_gs", VCPU_STAT(instruction_gs) },
> 
