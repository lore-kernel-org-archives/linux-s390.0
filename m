From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH] kvm/s390: drop unpaired smp_mb
Date: Thu, 7 Jan 2016 09:25:03 +0100
Message-ID: <568E20DF.6090402@de.ibm.com>
References: <1452010811-25486-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1452010811-25486-1-git-send-email-mst@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc: Gleb Natapov <gleb@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 01/05/2016 05:20 PM, Michael S. Tsirkin wrote:
> smp_mb on vcpu destroy isn't paired with anything, violating pairing
> rules, and seems to be useless.
> 
> Drop it.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Applied.
(I had to fix this up a little to match kvm/next)

Thanks

> ---
> 
> Untested.
> 
>  arch/s390/kvm/kvm-s390.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 8465892..7305d2c 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -1195,7 +1195,6 @@ void kvm_arch_vcpu_destroy(struct kvm_vcpu *vcpu)
>  		    (__u64) vcpu->arch.sie_block)
>  			vcpu->kvm->arch.sca->cpu[vcpu->vcpu_id].sda = 0;
>  	}
> -	smp_mb();
> 
>  	if (kvm_is_ucontrol(vcpu->kvm))
>  		gmap_free(vcpu->arch.gmap);
> 
