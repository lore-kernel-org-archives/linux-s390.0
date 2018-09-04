From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 04 Sep 2018 08:57:36 +0000
Subject: Re: [PATCH v2] KVM: s390: Fix pfmf and conditional skey emulation
Message-Id: <7d1f6d27-b2fe-ceb1-a1eb-ab03c09552d1@de.ibm.com>
In-Reply-To: <5fd1ed91-1eaa-3946-4bd5-9219f7132d06@redhat.com>
References: <5fd1ed91-1eaa-3946-4bd5-9219f7132d06@redhat.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>



On 08/30/2018 10:13 AM, Janosch Frank wrote:
> We should not return with a lock.
> We also have to increase the address when we do page clearing.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
> 
> I knew there were more instances...

Thanks applied.


> 
> ---
>  arch/s390/kvm/priv.c | 30 ++++++++++++++++++------------
>  1 file changed, 18 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
> index d68f10441a16..8679bd74d337 100644
> --- a/arch/s390/kvm/priv.c
> +++ b/arch/s390/kvm/priv.c
> @@ -280,9 +280,11 @@ static int handle_iske(struct kvm_vcpu *vcpu)
>  			goto retry;
>  		}
>  	}
> -	if (rc)
> -		return kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
>  	up_read(&current->mm->mmap_sem);
> +	if (rc == -EFAULT)
> +		return kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
> +	if (rc < 0)
> +		return rc;
>  	vcpu->run->s.regs.gprs[reg1] &= ~0xff;
>  	vcpu->run->s.regs.gprs[reg1] |= key;
>  	return 0;
> @@ -324,9 +326,11 @@ static int handle_rrbe(struct kvm_vcpu *vcpu)
>  			goto retry;
>  		}
>  	}
> -	if (rc < 0)
> -		return kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
>  	up_read(&current->mm->mmap_sem);
> +	if (rc == -EFAULT)
> +		return kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
> +	if (rc < 0)
> +		return rc;
>  	kvm_s390_set_psw_cc(vcpu, rc);
>  	return 0;
>  }
> @@ -390,12 +394,12 @@ static int handle_sske(struct kvm_vcpu *vcpu)
>  					      FAULT_FLAG_WRITE, &unlocked);
>  			rc = !rc ? -EAGAIN : rc;
>  		}
> +		up_read(&current->mm->mmap_sem);
>  		if (rc == -EFAULT)
>  			return kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
> -
> -		up_read(&current->mm->mmap_sem);
> -		if (rc >= 0)
> -			start += PAGE_SIZE;
> +		if (rc < 0)
> +			return rc;
> +		start += PAGE_SIZE;
>  	}
>  
>  	if (m3 & (SSKE_MC | SSKE_MR)) {
> @@ -1002,13 +1006,15 @@ static int handle_pfmf(struct kvm_vcpu *vcpu)
>  						      FAULT_FLAG_WRITE, &unlocked);
>  				rc = !rc ? -EAGAIN : rc;
>  			}
> +			up_read(&current->mm->mmap_sem);
>  			if (rc == -EFAULT)
>  				return kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
> -
> -			up_read(&current->mm->mmap_sem);
> -			if (rc >= 0)
> -				start += PAGE_SIZE;
> +			if (rc == -EAGAIN)
> +				continue;
> +			if (rc < 0)
> +				return rc;
>  		}
> +		start += PAGE_SIZE;
>  	}
>  	if (vcpu->run->s.regs.gprs[reg1] & PFMF_FSC) {
>  		if (psw_bits(vcpu->arch.sie_block->gpsw).eaba == PSW_BITS_AMODE_64BIT) {
> 
