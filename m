From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v1] KVM: s390: cleanup struct kvm_s390_float_interrupt
Date: Mon, 8 Jan 2018 14:42:23 +0100
Message-ID: <67f05b75-f5fe-7da3-ea37-df9743a4a278@redhat.com>
References: <20180108134013.32285-1-david@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20180108134013.32285-1-david@redhat.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: KVM <kvm@vger.kernel.org>
Cc: linux-s390@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
List-ID: <linux-s390.vger.kernel.org>


>  			u64 *reg)
>  {
> -	struct kvm_s390_local_interrupt *li;
>  	int cpuflags;
>  	int rc;
>  	int ext_call_pending;
>  
> -	li = &dst_vcpu->arch.local_int;
> -
> -	cpuflags = atomic_read(li->cpuflags);
> +	cpuflags = atomic_read(&vcpu->arch.sie_block->cpuflags);

Wonder why I always see errors just after sending the patch :)
vcpu -> dst_vcpu


-- 

Thanks,

David / dhildenb
