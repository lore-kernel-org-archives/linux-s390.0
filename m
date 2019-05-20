From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 20 May 2019 10:40:11 +0000
Subject: Re: [PATCH -next] KVM: s390: fix typo in parameter description
Message-Id: <44f535b4-a89c-748d-b275-2876d5223689@redhat.com>
In-Reply-To: <a6d67ef5-2db8-5373-04ae-d54f5bdb79db@de.ibm.com>
References: <a6d67ef5-2db8-5373-04ae-d54f5bdb79db@de.ibm.com>
To: linux-s390@vger.kernel.org, kernel-janitors@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 20/05/19 09:41, Christian Borntraeger wrote:
> On 06.05.19 09:52, Christian Borntraeger wrote:
>>
>>
>> On 04.05.19 08:51, Wei Yongjun wrote:
>>> Fix typo in parameter description.
>>>
>>> Fixes: 8b905d28ee17 ("KVM: s390: provide kvm_arch_no_poll function")
>>> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
>>
>> Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
> 
> Since I have another fix pending, I now picked this up myself and
> this will be in my next pull request for 5.2-rc2.

Ok, I'll wait for it before sending my own pending fixes to Linus.

Paolo
