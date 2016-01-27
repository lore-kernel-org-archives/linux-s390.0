From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH/RFC 3/3] s390: query dynamic DEBUG_PAGEALLOC setting
Date: Wed, 27 Jan 2016 14:09:09 +0100
Message-ID: <56A8C175.9030702@de.ibm.com>
References: <1453799905-10941-1-git-send-email-borntraeger@de.ibm.com>
 <1453799905-10941-4-git-send-email-borntraeger@de.ibm.com>
 <20160126181903.GB4671@osiris>
 <alpine.DEB.2.10.1601261525580.25141@chino.kir.corp.google.com>
 <20160127001918.GA7089@js1304-P5Q-DELUXE>
 <alpine.DEB.2.10.1601261633520.6121@chino.kir.corp.google.com>
 <20160127005920.GB7089@js1304-P5Q-DELUXE> <56A8BB15.9070305@suse.cz>
 <56A8BC6D.9080101@de.ibm.com> <56A8C028.7050305@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
In-Reply-To: <56A8C028.7050305@suse.cz>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, David Rientjes <rientjes@google.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, x86@kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 01/27/2016 02:03 PM, Vlastimil Babka wrote:
> On 01/27/2016 01:47 PM, Christian Borntraeger wrote:
>> On 01/27/2016 01:41 PM, Vlastimil Babka wrote:
>>> On 01/27/2016 01:59 AM, Joonsoo Kim wrote:
>>>
>>> I think it might be worth also to convert debug_pagealloc_enabled() to be based
>>> on static key, like I did for page_owner [1]. That should help make it possible
>>> to have virtually no overhead when compiling kernel with CONFIG_DEBUG_PAGEALLOC
>>> without enabling it boot-time. I assume it's one of the goals here?
>>
>> We could do something like that but dump_stack and setup of the initial identity
>> mapping of the kernel as well as the initial page protection are not hot path
>> as far as I can tell. Any other places?
> 
> Well, mostly kernel_map_pages() which is used in page allocation hotpaths.

Right. So indeed, static_key would be a good thing, but certainly an addon patch.
