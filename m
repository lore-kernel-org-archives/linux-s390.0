Return-Path: <SRS0=FZpJ=T4=vger.kernel.org=kvm-owner@kernel.org>
Subject: Re: [PATCH] kvm: fix compile on s390 part 2
References: <20190527091621.151415-1-borntraeger@de.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 28 May 2019 15:58:29 +0200
MIME-Version: 1.0
In-Reply-To: <20190527091621.151415-1-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <75f3f45a-701d-3855-aa16-436c4638e109@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Janosch Frank <frankja@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Michal Kubecek <mkubecek@suse.cz>, KarimAllah Ahmed <karahmed@amazon.de>
List-ID: <linux-s390.vger.kernel.org>


On 27.05.19 11:16, Christian Borntraeger wrote:
> We also need to fence the memunmap part.
> 
> Fixes: e45adf665a53 ("KVM: Introduce a new guest mapping API")
> Fixes: d30b214d1d0a (kvm: fix compilation on s390)
> Cc: Michal Kubecek <mkubecek@suse.cz>
> Cc: KarimAllah Ahmed <karahmed@amazon.de>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>

queued for kvms390/master.

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
