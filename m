From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 02/12] KVM: s390: define GISA format-0 data structure
Date: Thu, 18 Jan 2018 21:47:01 +0100
Message-ID: <a81038d6-4b2c-05ab-7159-bf91b1aca164@redhat.com>
References: <20180116200217.211897-1-borntraeger@de.ibm.com>
 <20180116200217.211897-3-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20180116200217.211897-3-borntraeger@de.ibm.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, Michael Mueller <mimu@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Two minor things

>  
> +struct kvm_s390_gisa {
> +	u32 next_alert;
> +	u8 ipm;
> +	u8 reserved01;
> +	u8:6;

Mind giving this also a reserved name

> +	u8 g:1;
> +	u8 c:1;

Can you put spaces before/after the colon?

> +	u8 iam;
> +	u8 reserved02[4];
> +	u32 airq_count;
> +};
> +
>  /*


-- 

Thanks,

David / dhildenb
