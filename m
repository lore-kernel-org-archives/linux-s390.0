From: David Hildenbrand <david@redhat.com>
Subject: Re: [RFC/PATCH 01/22] s390/mm: make gmap_protect_range more modular
Date: Wed, 8 Nov 2017 13:26:49 +0100
Message-ID: <37b67dea-22f0-e28d-9bb7-a5b5e225abd9@redhat.com>
References: <1510007400-42493-1-git-send-email-frankja@linux.vnet.ibm.com>
 <1510007400-42493-2-git-send-email-frankja@linux.vnet.ibm.com>
 <1f39ee13-92a9-5d56-84c1-495c29a08a32@redhat.com>
 <b08da302-fd79-1120-b27e-d1ed295b7bbe@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <b08da302-fd79-1120-b27e-d1ed295b7bbe@linux.vnet.ibm.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Janosch Frank <frankja@linux.vnet.ibm.com>, kvm@vger.kernel.org
Cc: schwidefsky@de.ibm.com, borntraeger@de.ibm.com, dominik.dingel@gmail.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 08.11.2017 13:21, Janosch Frank wrote:
> On 08.11.2017 11:40, David Hildenbrand wrote:
>> On 06.11.2017 23:29, Janosch Frank wrote:
>>> This patch reworks the gmap_protect_range logic and extracts the pte
>>> handling into an own function. Also we do now walk to the pmd and make
>>> it accessible in the function for later use. This way we can add huge
>>> page handling logic more easily.
>>
>> I just realized (and hope it is correct), that any gmap_shadow() checks
>> in e.g. gmap_pte_op_walk() are superfluous. This code is never reached.
>>
>> This would imply that also in this patch, you can drop all
>> gmap_is_shadow(gmap) checks and instead add BUG_ON(gmap_is_shadow()) to
>> all functions.
>>
>> Will double check and prepare a cleanup for existing code.
> 
> Hrm, looks like it.
> 
> Be aware, that I'm very protective about changes in the GMAP, especially
> on the VSIE part. I've had minimal changes on these patches setting me
> back for weeks, so if you want to change things, be absolutely sure,
> that it will work (also with further changes) or add them after this set
> is merged.

I know that pain, but getting it in a clean shape is the way to go. This
is RFC after all. And understanding the code is better than rushing just
to get changes in.

Especially if it helps to clarify your changes (e.g. mprotect_notify
never applying to shadow gmaps).

> 
> Thanks for having a look!

Will try to have a look at the other patches but might take some time
(complicated stuff ...).

-- 

Thanks,

David / dhildenb
