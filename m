From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PULL 1/4] KVM: s390: randomize sca address
Date: Tue, 25 Mar 2014 14:53:56 +0100
Message-ID: <53318A74.9010504@redhat.com>
References: <1395754523-43697-1-git-send-email-borntraeger@de.ibm.com> <1395754523-43697-2-git-send-email-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1395754523-43697-2-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Il 25/03/2014 14:35, Christian Borntraeger ha scritto:
> We allocate a page for the 2k sca, so lets use the space to improve
> hit rate of some internal cpu caches. No need to change the freeing
> of the page, as this will shift away the page offset bits anyway.
>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Reviewed-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
> ---
>  arch/s390/kvm/kvm-s390.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 7337c57..a02979f 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -215,6 +215,7 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
>  {
>  	int rc;
>  	char debug_name[16];
> +	static unsigned long sca_offset;
>
>  	rc = -EINVAL;
>  #ifdef CONFIG_KVM_S390_UCONTROL
> @@ -236,6 +237,10 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
>  	kvm->arch.sca = (struct sca_block *) get_zeroed_page(GFP_KERNEL);
>  	if (!kvm->arch.sca)
>  		goto out_err;
> +	spin_lock(&kvm_lock);
> +	sca_offset = (sca_offset + 16) & 0x7f0;
> +	kvm->arch.sca = (struct sca_block *) ((char *) kvm->arch.sca + sca_offset);
> +	spin_unlock(&kvm_lock);
>
>  	sprintf(debug_name, "kvm-%u", current->pid);
>
>

Does this have to remain the same across migration?

Paolo
