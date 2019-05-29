Return-Path: <SRS0=5+JM=T5=vger.kernel.org=kvm-owner@kernel.org>
Subject: Re: [GIT PULL 1/2] kvm: fix compile on s390 part 2
References: <20190529125045.42935-1-borntraeger@de.ibm.com>
 <20190529125045.42935-2-borntraeger@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <64437661-0430-e025-4682-905a90befd8e@redhat.com>
Date: Wed, 29 May 2019 14:53:09 +0200
MIME-Version: 1.0
In-Reply-To: <20190529125045.42935-2-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On 29.05.19 14:50, Christian Borntraeger wrote:
> We also need to fence the memunmap part.
> 
> Fixes: e45adf665a53 ("KVM: Introduce a new guest mapping API")
> Fixes: d30b214d1d0a (kvm: fix compilation on s390)
> Cc: Michal Kubecek <mkubecek@suse.cz>
> Cc: KarimAllah Ahmed <karahmed@amazon.de>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  virt/kvm/kvm_main.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 134ec0283a8a..301089a462c4 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -1795,8 +1795,10 @@ void kvm_vcpu_unmap(struct kvm_vcpu *vcpu, struct kvm_host_map *map,
>  
>  	if (map->page)
>  		kunmap(map->page);
> +#ifdef CONFIG_HAS_IOMEM
>  	else
>  		memunmap(map->hva);
> +#endif
>  
>  	if (dirty) {
>  		kvm_vcpu_mark_page_dirty(vcpu, map->gfn);
> 

I *think* you dropped my r-b - never mind ;)

-- 

Thanks,

David / dhildenb
