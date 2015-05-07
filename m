Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <554BC3B0.8020203@de.ibm.com>
Date: Thu, 07 May 2015 21:57:36 +0200
From: Christian Borntraeger <borntraeger@de.ibm.com>
MIME-Version: 1.0
Subject: Re: [PATCH 00/12] [RFC] x86: Memory Protection Keys
References: <20150507174132.34AF8FAF@viggo.jf.intel.com> <20150507175707.GA22172@gmail.com> <554BAA68.6000508@sr71.net> <554BBB74.70706@de.ibm.com> <554BBD0F.6080209@sr71.net> <554BC0CE.6070900@de.ibm.com> <554BC1DC.3050303@sr71.net>
In-Reply-To: <554BC1DC.3050303@sr71.net>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Dave Hansen <dave@sr71.net>, Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

Am 07.05.2015 um 21:49 schrieb Dave Hansen:
> On 05/07/2015 12:45 PM, Christian Borntraeger wrote:
>>>>>> This all looks like s390 storage keys (with the key in pagetables instead
>>>>>> of a dedicated place). There we also have 16 values for the key and 4 bits 
>>>>>> in the PSW that describe the thread local key both are matched.
>>>>>> There is an additional field F (fetch protection) that decides, if the
>>>>>> key value is used for stores or for stores+fetches.
>>>>
>>>> OK, so a thread can only be in one domain at a time?
>> Via the PSW yes.
>> Actually the docs talk about access key, which is usually the PSW. There are
>> some instructions like MOVE WITH KEY that allow to specify the key for this
>> specific instruction. For compiled code these insructions are not used in 
>> Linux and I can not really see a way to implement that properly. Furthermore
>> enabling these key ops has other implications which are unwanted.
> 
> OK, so we have to basic operations that need to be done for
> protection/storage/$FOO keys:
> 
> 1. Assign a key (or set of keys) to a memory area
> 2. Have a thread request the access (read and/or write) to a set of
>    areas be acquired or revoked.
> 
> For (2) on x86, we basically allow any combination of keys and r/w
> permissions.  On s390, we would need to ensure that acces to only one
> key was allowed at a time.
> 
> BTW, do the s390 keys affect instructions and data, or data only?

Both. In fact its also used for I/O. Maybe that also points out the
biggest difference. the storage key is a property of the physical page
frame (and not of the virtual page defined by the page tables).
So we cannot really use that for shared memory and then set different
protection keys in different mappings.

 
> The x86 ones affect data only.
> 
