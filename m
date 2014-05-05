From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [patch] KVM: s390: return -EFAULT if copy_from_user() fails
Date: Mon, 05 May 2014 09:30:31 +0200
Message-ID: <53673E17.6040705@de.ibm.com>
References: <20140503201811.GA32753@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20140503201811.GA32753@mwanda>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, linux390@de.ibm.com, Gleb Natapov <gleb@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, kernel-janitors@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 03/05/14 22:18, Dan Carpenter wrote:
> When copy_from_user() fails, this code returns the number of bytes
> remaining instead of a negative error code.  The positive number is
> returned to the user but otherwise it is harmless.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Thanks. Applied to KVM/s390 fix queue.


> ---
> I am not able to compile this.
> 
> diff --git a/arch/s390/kvm/guestdbg.c b/arch/s390/kvm/guestdbg.c
> index 757ccef..3e8d409 100644
> --- a/arch/s390/kvm/guestdbg.c
> +++ b/arch/s390/kvm/guestdbg.c
> @@ -223,9 +223,10 @@ int kvm_s390_import_bp_data(struct kvm_vcpu *vcpu,
>  		goto error;
>  	}
> 
> -	ret = copy_from_user(bp_data, dbg->arch.hw_bp, size);
> -	if (ret)
> +	if (copy_from_user(bp_data, dbg->arch.hw_bp, size)) {
> +		ret = -EFAULT;
>  		goto error;
> +	}
> 
>  	for (i = 0; i < dbg->arch.nr_hw_bp; i++) {
>  		switch (bp_data[i].type) {
> --
> To unsubscribe from this list: send the line "unsubscribe linux-s390" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
