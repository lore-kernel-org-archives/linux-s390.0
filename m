From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH] KVM: s390: Fix sdnxo setting for nested guests
Date: Tue, 11 Apr 2017 13:55:21 +0200
Message-ID: <20170411135521.2bc5ee53.cornelia.huck@de.ibm.com>
References: <70b26028-8076-c7ff-be17-b99946a20642@redhat.com>
        <1491568065-7491-1-git-send-email-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1491568065-7491-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Radim =?UTF-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, David Hildenbrand <david@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

On Fri,  7 Apr 2017 14:27:45 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> If the guest does not use the host register management, but it uses
> the sdnx area, we must fill in a proper sdnxo value (address of sdnx
> and the sdnxc).
> 
> Reported-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  arch/s390/kvm/vsie.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
> index 2fafc2b..025b1f2 100644
> --- a/arch/s390/kvm/vsie.c
> +++ b/arch/s390/kvm/vsie.c
> @@ -627,7 +627,7 @@ static int pin_blocks(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
>  			rc = set_validity_icpt(scb_s, 0x10b0U);
>  		if (rc)
>  			goto unpin;
> -		scb_s->sdnxo = hpa;
> +		scb_s->sdnxo = hpa | sdnxc;
>  	}
>  	return 0;
>  unpin:

Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
