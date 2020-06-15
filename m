Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:21774 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731327AbgFOSki (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 15 Jun 2020 14:40:38 -0400
Subject: Re: [PATCH 1/2] mm, treewide: Rename kzfree() to kfree_sensitive()
References: <20200413211550.8307-1-longman@redhat.com>
 <20200413211550.8307-2-longman@redhat.com> <20200615180753.GJ4151@kadam>
From: Waiman Long <longman@redhat.com>
Message-ID: <9d084be2-29a3-7757-9386-20dbaeb5fc24@redhat.com>
Date: Mon, 15 Jun 2020 14:39:59 -0400
MIME-Version: 1.0
In-Reply-To: <20200615180753.GJ4151@kadam>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Linus Torvalds <torvalds@linux-foundation.org>, Joe Perches <joe@perches.com>, Matthew Wilcox <willy@infradead.org>, David Rientjes <rientjes@google.com>, samba-technical@lists.samba.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, linux-sctp@vger.kernel.org, target-devel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, devel@driverdev.osuosl.org, linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org, x86@kernel.org, kasan-dev@googlegroups.com, cocci@systeme.lip6.fr, linux-wpan@vger.kernel.org, intel-wired-lan@lists.osuosl.org, linux-crypto@vger.kernel.org, linux-pm@vger.kernel.org, ecryptfs@vger.kernel.org, linux-nfs@vger.kernel.org, linux-fscrypt@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-cifs@vger.kernel.org, netdev@vger.kernel.org, linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, tipc-discussion@lists.sourceforge.net, wireguard@lists.zx2c4.com, linux-ppp@vger.kernel.org, linux-integrity@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-btrfs@vger.kernel.org

On 6/15/20 2:07 PM, Dan Carpenter wrote:
> On Mon, Apr 13, 2020 at 05:15:49PM -0400, Waiman Long wrote:
>> diff --git a/mm/slab_common.c b/mm/slab_common.c
>> index 23c7500eea7d..c08bc7eb20bd 100644
>> --- a/mm/slab_common.c
>> +++ b/mm/slab_common.c
>> @@ -1707,17 +1707,17 @@ void *krealloc(const void *p, size_t new_size, gfp_t flags)
>>   EXPORT_SYMBOL(krealloc);
>>   
>>   /**
>> - * kzfree - like kfree but zero memory
>> + * kfree_sensitive - Clear sensitive information in memory before freeing
>>    * @p: object to free memory of
>>    *
>>    * The memory of the object @p points to is zeroed before freed.
>> - * If @p is %NULL, kzfree() does nothing.
>> + * If @p is %NULL, kfree_sensitive() does nothing.
>>    *
>>    * Note: this function zeroes the whole allocated buffer which can be a good
>>    * deal bigger than the requested buffer size passed to kmalloc(). So be
>>    * careful when using this function in performance sensitive code.
>>    */
>> -void kzfree(const void *p)
>> +void kfree_sensitive(const void *p)
>>   {
>>   	size_t ks;
>>   	void *mem = (void *)p;
>> @@ -1725,10 +1725,10 @@ void kzfree(const void *p)
>>   	if (unlikely(ZERO_OR_NULL_PTR(mem)))
>>   		return;
>>   	ks = ksize(mem);
>> -	memset(mem, 0, ks);
>> +	memzero_explicit(mem, ks);
>          ^^^^^^^^^^^^^^^^^^^^^^^^^
> This is an unrelated bug fix.  It really needs to be pulled into a
> separate patch by itself and back ported to stable kernels.
>
>>   	kfree(mem);
>>   }
>> -EXPORT_SYMBOL(kzfree);
>> +EXPORT_SYMBOL(kfree_sensitive);
>>   
>>   /**
>>    * ksize - get the actual amount of memory allocated for a given object
> regards,
> dan carpenter
>
Thanks for the suggestion. I will break it out and post a version soon.

Cheers,
Longman
