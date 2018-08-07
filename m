Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH RFC 2/2] KVM: s390: introduce and use KVM_REQ_VSIE_RESTART
References: <20180807125131.3606-1-david@redhat.com>
 <20180807125131.3606-3-david@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Tue, 7 Aug 2018 19:06:26 +0200
MIME-Version: 1.0
In-Reply-To: <20180807125131.3606-3-david@redhat.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Message-Id: <fd4bfc34-d001-26b6-17c0-03eb1df59454@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc: linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Janosch Frank <frankja@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On 07/08/2018 14:51, David Hildenbrand wrote:
> When we change the crycb (or execution controls), we also have to make sure
> that the vSIE shadow datastructures properly consider the changed
> values before rerunning the vSIE. We can achieve that by simply using a
> VCPU request now.
>
> This has to be a synchronous request (== handled before entering the
> (v)SIE again).
>
> The request will make sure that the vSIE handler is left, and that the
> request will be processed (NOP), therefore forcing a reload of all
> vSIE data (including rebuilding the crycb) when re-entering the vSIE
> interception handler the next time.
>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>   arch/s390/include/asm/kvm_host.h | 1 +
>   arch/s390/kvm/kvm-s390.c         | 7 ++++++-
>   2 files changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
> index 29c940bf8506..75d39628f21d 100644
> --- a/arch/s390/include/asm/kvm_host.h
> +++ b/arch/s390/include/asm/kvm_host.h
> @@ -44,6 +44,7 @@
>   #define KVM_REQ_ICPT_OPEREXC	KVM_ARCH_REQ(2)
>   #define KVM_REQ_START_MIGRATION KVM_ARCH_REQ(3)
>   #define KVM_REQ_STOP_MIGRATION  KVM_ARCH_REQ(4)
> +#define KVM_REQ_VSIE_RESTART	KVM_ARCH_REQ(5)
>   
>   #define SIGP_CTRL_C		0x80
>   #define SIGP_CTRL_SCN_MASK	0x3f
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index c87734a31fdb..2fdc017d91f0 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -842,8 +842,11 @@ void kvm_s390_vcpu_crypto_reset_all(struct kvm *kvm)
>   
>   	kvm_s390_vcpu_block_all(kvm);
>   
> -	kvm_for_each_vcpu(i, vcpu, kvm)
> +	kvm_for_each_vcpu(i, vcpu, kvm) {
>   		kvm_s390_vcpu_crypto_setup(vcpu);
> +		/* recreate the shadow crycb by leaving the VSIE handler */
> +		kvm_s390_sync_request(KVM_REQ_VSIE_RESTART, vcpu);
> +	}
>   
>   	kvm_s390_vcpu_unblock_all(kvm);
>   }
> @@ -3201,6 +3204,8 @@ static int kvm_s390_handle_requests(struct kvm_vcpu *vcpu)
>   
>   	/* nothing to do, just clear the request */
>   	kvm_clear_request(KVM_REQ_UNHALT, vcpu);
> +	/* we left the vsie handler, nothing to do, just clear the request */
> +	kvm_clear_request(KVM_REQ_VSIE_RESTART, vcpu);
>   
>   	return 0;
>   }

Reviewed-by: Pierre Morel<pmorel@linux.ibm.com>
Tested-by: Pierre Morel<pmorel@linux.ibm.com>


-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany
