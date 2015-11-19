From: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH 1/4] KVM: Provide function for VCPU lookup by id
Date: Thu, 19 Nov 2015 13:11:52 +0100
Message-ID: <564DBC88.5020508@redhat.com>
References: <1447922251-54261-1-git-send-email-borntraeger@de.ibm.com>
 <1447922251-54261-2-git-send-email-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1447922251-54261-2-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@suse.de>, Paul Mackerras <paulus@samba.org>, David Hildenbrand <dahi@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, kvm-ppc@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 19/11/15 09:37, Christian Borntraeger wrote:
> From: David Hildenbrand <dahi@linux.vnet.ibm.com>
> 
> Let's provide a function to lookup a VCPU by id.
> 
> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Reviewed-by: Dominik Dingel <dingel@linux.vnet.ibm.com>
> Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> [split patch from refactoring patch]
> ---
>  include/linux/kvm_host.h | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 5706a21..b9f345f 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -460,6 +460,17 @@ static inline struct kvm_vcpu *kvm_get_vcpu(struct kvm *kvm, int i)
>  	     (vcpup = kvm_get_vcpu(kvm, idx)) != NULL; \
>  	     idx++)
>  
> +static inline struct kvm_vcpu *kvm_lookup_vcpu(struct kvm *kvm, int id)
> +{
> +	struct kvm_vcpu *vcpu;
> +	int i;
> +
> +	kvm_for_each_vcpu(i, vcpu, kvm)
> +		if (vcpu->vcpu_id == id)
> +			return vcpu;
> +	return NULL;
> +}
> +

Any chance that you name this function differently? Otherwise we've got
two functions that sound very similar and also have similar prototypes:

- kvm_get_vcpu(struct kvm *kvm, int i)
- kvm_lookup_vcpu(struct kvm *kvm, int id)

I'm pretty sure this will cause confusion in the future!
==> Could you maybe name the new function something like
"kvm_lookup_vcpu_by_id" or "kvm_get_vcpu_by_id" instead?

Also a short comment before the function would be nice to make the
reader aware of the difference (e.g. when hot-plugging) between the
vcpu-id and array-id.

Otherwise: +1 for finally having a proper common function for this!

 Thomas
