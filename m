From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 4/4] KVM: s390: Fix skey emulation permission check
Date: Tue, 5 Dec 2017 17:53:46 +0100
Message-ID: <545edf77-fca3-3948-0ccd-04a3cb19093b@redhat.com>
References: <20171205083321.102933-1-borntraeger@de.ibm.com>
 <20171205083321.102933-5-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20171205083321.102933-5-borntraeger@de.ibm.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Thomas Huth <thuth@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On 05.12.2017 09:33, Christian Borntraeger wrote:
> From: Janosch Frank <frankja@linux.vnet.ibm.com>
> 
> All skey functions call skey_check_enable at their start, which checks
> if we are in the PSTATE and injects a privileged operation exception
> if we are.

Correct thing to do, are we sure we even get an intercept?
(no documentation at hand :( )

> 
> Unfortunately they continue processing afterwards and perform the
> operation anyhow as skey_check_enable does not deliver an error if the
> exception injection was successful.
> 
> Let's move the PSTATE check into the skey functions and exit them on
> such an occasion, also we now do not enable skey handling anymore in
> such a case.
> 
> Signed-off-by: Janosch Frank <frankja@linux.vnet.ibm.com>
> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Fixes: a7e19ab ("KVM: s390: handle missing storage-key facility")
> Cc: <stable@vger.kernel.org> # v4.8+
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  arch/s390/kvm/priv.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
> index 28b69ab..572496c 100644
> --- a/arch/s390/kvm/priv.c
> +++ b/arch/s390/kvm/priv.c
> @@ -232,8 +232,6 @@ static int try_handle_skey(struct kvm_vcpu *vcpu)
>  		VCPU_EVENT(vcpu, 4, "%s", "retrying storage key operation");
>  		return -EAGAIN;
>  	}
> -	if (vcpu->arch.sie_block->gpsw.mask & PSW_MASK_PSTATE)
> -		return kvm_s390_inject_program_int(vcpu, PGM_PRIVILEGED_OP);
>  	return 0;
>  }
>  
> @@ -244,6 +242,9 @@ static int handle_iske(struct kvm_vcpu *vcpu)
>  	int reg1, reg2;
>  	int rc;
>  
> +	if (vcpu->arch.sie_block->gpsw.mask & PSW_MASK_PSTATE)
> +		return kvm_s390_inject_program_int(vcpu, PGM_PRIVILEGED_OP);
> +
>  	rc = try_handle_skey(vcpu);
>  	if (rc)
>  		return rc != -EAGAIN ? rc : 0;
> @@ -273,6 +274,9 @@ static int handle_rrbe(struct kvm_vcpu *vcpu)
>  	int reg1, reg2;
>  	int rc;
>  
> +	if (vcpu->arch.sie_block->gpsw.mask & PSW_MASK_PSTATE)
> +		return kvm_s390_inject_program_int(vcpu, PGM_PRIVILEGED_OP);
> +
>  	rc = try_handle_skey(vcpu);
>  	if (rc)
>  		return rc != -EAGAIN ? rc : 0;
> @@ -308,6 +312,9 @@ static int handle_sske(struct kvm_vcpu *vcpu)
>  	int reg1, reg2;
>  	int rc;
>  
> +	if (vcpu->arch.sie_block->gpsw.mask & PSW_MASK_PSTATE)
> +		return kvm_s390_inject_program_int(vcpu, PGM_PRIVILEGED_OP);
> +
>  	rc = try_handle_skey(vcpu);
>  	if (rc)
>  		return rc != -EAGAIN ? rc : 0;
> 


-- 

Thanks,

David / dhildenb
