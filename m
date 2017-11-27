From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 01/15] KVM: Prepare for moving vcpu_load/vcpu_put into
 arch specific code
Date: Mon, 27 Nov 2017 17:53:01 +0100
Message-ID: <838db374-6040-c805-82f3-187a2cdfc40d@redhat.com>
References: <20171125205718.7731-1-christoffer.dall@linaro.org>
 <20171125205718.7731-2-christoffer.dall@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20171125205718.7731-2-christoffer.dall@linaro.org>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christoffer Dall <christoffer.dall@linaro.org>, kvm@vger.kernel.org
Cc: Andrew Jones <drjones@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Marc Zyngier <marc.zyngier@arm.com>, kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org, James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org, Alexander Graf <agraf@suse.com>, kvm-ppc@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 25/11/2017 21:57, Christoffer Dall wrote:
> In preparation for moving calls to vcpu_load() and vcpu_put() into the
> architecture specific implementations of the KVM vcpu ioctls, move the
> calls in the main kvm_vcpu_ioctl() dispatcher function to each case
> of the ioctl select statement.  This allows us to move the vcpu_load()
> and vcpu_put() calls into architecture specific implementations of vcpu
> ioctls, one by one.
> 
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> ---
>  virt/kvm/kvm_main.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 48 insertions(+), 5 deletions(-)
> 
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 9deb5a245b83..fafafcc38b5a 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -2528,16 +2528,15 @@ static long kvm_vcpu_ioctl(struct file *filp,
>  		return kvm_arch_vcpu_ioctl(filp, ioctl, arg);
>  #endif
>  
> -
> -	r = vcpu_load(vcpu);
> -	if (r)
> -		return r;
>  	switch (ioctl) {
>  	case KVM_RUN: {
>  		struct pid *oldpid;
>  		r = -EINVAL;
>  		if (arg)
>  			goto out;
> +		r = vcpu_load(vcpu);
> +		if (r)
> +			goto out;
>  		oldpid = rcu_access_pointer(vcpu->pid);

If it is not a problem for ARM, maybe it would actually be best to leave
the locking in kvm_vcpu_ioctl (with the already existing exception of
KVM_INTERRUPT).  This would make vcpu_load void, and would also let you
keep the PID adjustment in common code.  This would be more similar to
the previous version, but without introducing __vcpu_load/__vcpu_put.

Looks good apart from this doubt!  Thanks,

Paolo
