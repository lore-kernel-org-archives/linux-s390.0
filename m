From: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 3/6] KVM: s390: fix sigp sense running condition code handling
Date: Tue, 26 Jun 2012 18:03:09 +0200
Message-ID: <83568A2D-7D89-4879-9486-B2A6965C0B85@suse.de>
References: <1340719601-11867-1-git-send-email-cornelia.huck@de.ibm.com> <1340719601-11867-4-git-send-email-cornelia.huck@de.ibm.com> <06A9A05A-0EF3-4ACF-8254-1F3F10844793@suse.de> <20120626173344.6e3d6a01@BR9GNB5Z> <B15BC6F5-3B2C-47DD-9879-108CAEF71B22@suse.de> <20120626175719.76daab6e@BR9GNB5Z>
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20120626175719.76daab6e@BR9GNB5Z>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Avi Kivity <avi@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>


On 26.06.2012, at 17:57, Cornelia Huck wrote:

> On Tue, 26 Jun 2012 17:36:19 +0200
> Alexander Graf <agraf@suse.de> wrote:
> 
>> 
>> On 26.06.2012, at 17:33, Cornelia Huck wrote:
>> 
>>> On Tue, 26 Jun 2012 16:52:56 +0200
>>> Alexander Graf <agraf@suse.de> wrote:
>>> 
>>>> 
>>>> On 26.06.2012, at 16:06, Cornelia Huck wrote:
>>>> 
>>>>> From: Heiko Carstens <heiko.carstens@de.ibm.com>
>>>>> 
>>>>> Only if the sensed cpu is not running a status is stored, which
>>>>> is reflected by condition code 1. If the cpu is running, condition
>>>>> code 0 should be returned.
>>>>> Just the opposite of what the code is doing.
>>>>> 
>>>>> Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
>>>>> Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
>>>>> Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
>>>> 
>>>> Yikes. Is this a stable candidate?
>>> 
>>> This code will only hit when running on a host running virtualized
>>> itself (where sigp sense running will cause an intercept), so I doubt
>>> many people will see the effects.
>> 
>> You mean this will hit when running kvm inside of a z/VM VM? That's a pretty valid use case.
> 
> I'd have thought it was a very uncommon one. But I certainly don't
> object against putting the fix into stable.

It's not exactly useful for productive things, but just for prototyping KVM, people tend to not have spare LPARs lying around :)
So yes, this should go into stable.


Alex
