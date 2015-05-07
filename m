Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <554BBD0F.6080209@sr71.net>
Date: Thu, 07 May 2015 12:29:19 -0700
From: Dave Hansen <dave@sr71.net>
MIME-Version: 1.0
Subject: Re: [PATCH 00/12] [RFC] x86: Memory Protection Keys
References: <20150507174132.34AF8FAF@viggo.jf.intel.com> <20150507175707.GA22172@gmail.com> <554BAA68.6000508@sr71.net> <554BBB74.70706@de.ibm.com>
In-Reply-To: <554BBB74.70706@de.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On 05/07/2015 12:22 PM, Christian Borntraeger wrote:
> Am 07.05.2015 um 20:09 schrieb Dave Hansen:
>> On 05/07/2015 10:57 AM, Ingo Molnar wrote:
>>>>> There are two new instructions (RDPKRU/WRPKRU) for reading and 
>>>>> writing to the new register.  The feature is only available in 
>>>>> 64-bit mode, even though there is theoretically space in the PAE 
>>>>> PTEs.  These permissions are enforced on data access only and have 
>>>>> no effect on instruction fetches.
>>> So I'm wondering what the primary usecases are for this feature?
>>> Could you outline applications/workloads/libraries that would
>>> benefit from this?
>>
>> There are lots of things that folks would _like_ to mprotect(), but end
>> up not being feasible because of the overhead of going and mucking with
>> thousands of PTEs and shooting down remote TLBs every time you want to
>> change protections.
> 
> These protection bits would need to be cached in TLBs as well, no?

Yes, they are cached in the TLBs.  It's actually explicitly called out
in the documentation.

> So the saving would come by switching the PKRU instead of the page bits.

Right.

> This all looks like s390 storage keys (with the key in pagetables instead
> of a dedicated place). There we also have 16 values for the key and 4 bits 
> in the PSW that describe the thread local key both are matched.
> There is an additional field F (fetch protection) that decides, if the
> key value is used for stores or for stores+fetches.

OK, so a thread can only be in one domain at a time?

That's a bit different than x86 where each page can be in one protection
domain, but each CPU thread can independently enable/disable access to
each of the 16 protection domains.
