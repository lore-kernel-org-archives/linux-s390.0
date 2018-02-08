From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH 0/2] KVM: s390: avoid jump tables
Date: Thu, 8 Feb 2018 10:18:39 +0100
Message-ID: <062159ef-3bd3-ab04-0000-146376de8f57@de.ibm.com>
References: <20180206112127.19014-1-borntraeger@de.ibm.com>
 <7e9bb181-cec9-0781-03c0-b74d5d087c8a@redhat.com>
 <20180208085819.GC3937@osiris>
 <1cce9ec4-d32e-a12b-7151-f719cd68f72e@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1cce9ec4-d32e-a12b-7151-f719cd68f72e@de.ibm.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>, David Hildenbrand <david@redhat.com>
Cc: Janosch Frank <frankja@linux.vnet.ibm.com>, KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>



On 02/08/2018 10:07 AM, Christian Borntraeger wrote:
> 
> 
> On 02/08/2018 09:58 AM, Heiko Carstens wrote:
>> On Tue, Feb 06, 2018 at 01:30:28PM +0100, David Hildenbrand wrote:
>>> On 06.02.2018 12:21, Christian Borntraeger wrote:
>>>> Some old patches refreshed.
>>>>
>>>
>>> Certainly the right thing to do. Especially also interesting due to
>>> retpotline (if we get something like that on s390x). If I remember
>>> correctly, x86 highly benefits by replacing magic function pointer by
>>> switch statements.
>>
>> If you look at the generated code for the first patch: gcc now generates
>> its own jump table which then jumps (indirectly) to a brasl... So it's two
>> instead of one branch.
>> I'm not saying that this patch is not good, but there seem be a wrong
>> assumptions about the benefit here.
> 
> Seems to depend on the compiler. The gcc 7.2 from my Fedora 27 seems to do 
> the right thing for intercept.o and priv.o.
> In the end this will also help the new -mindirect-branch thing as the gcc
> support also avoids jump tables if we use thunks.

I will update the patch description and focus more on the "let us use the compiler
heuristics" and "prepare for thunks".
