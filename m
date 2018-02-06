From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 0/2] KVM: s390: avoid jump tables
Date: Tue, 6 Feb 2018 13:30:28 +0100
Message-ID: <7e9bb181-cec9-0781-03c0-b74d5d087c8a@redhat.com>
References: <20180206112127.19014-1-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20180206112127.19014-1-borntraeger@de.ibm.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On 06.02.2018 12:21, Christian Borntraeger wrote:
> Some old patches refreshed.
> 

Certainly the right thing to do. Especially also interesting due to
retpotline (if we get something like that on s390x). If I remember
correctly, x86 highly benefits by replacing magic function pointer by
switch statements.

Should we go ahead and also rework interrupt delivery?

> Christian Borntraeger (2):
>   KVM: s390: use switch vs jump table in priv.c
>   KVM: s390: use switch vs jump table in intercept.c
> 
>  arch/s390/kvm/intercept.c |  54 +++++++-------
>  arch/s390/kvm/kvm-s390.h  |   2 -
>  arch/s390/kvm/priv.c      | 183 +++++++++++++++++++++++-----------------------
>  3 files changed, 119 insertions(+), 120 deletions(-)
> 


-- 

Thanks,

David / dhildenb
