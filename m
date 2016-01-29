Return-Path: <linux-kernel-owner@vger.kernel.org>
Reply-To: xlpang@redhat.com
Subject: Re: [PATCH] kexec: unmap reserved pages for each error-return way
References: <1453895311-11087-1-git-send-email-dsafonov@virtuozzo.com>
 <20160127111546.2212f191f5f313b613f6b60b@linux-foundation.org>
 <56A983F3.5010506@redhat.com> <56A9D927.70402@virtuozzo.com>
From: Xunlei Pang <xpang@redhat.com>
Message-ID: <56AAD90F.20201@redhat.com>
Date: Fri, 29 Jan 2016 11:14:23 +0800
MIME-Version: 1.0
In-Reply-To: <56A9D927.70402@virtuozzo.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Dmitry Safonov <dsafonov@virtuozzo.com>, xlpang@redhat.com
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, ebiederm@xmission.com, 0x7f454c46@gmail.com, schwidefsky@de.ibm.com, holzheu@linux.vnet.ibm.com, dyoung@redhat.com
List-ID: <linux-s390.vger.kernel.org>

On 2016/01/28 at 17:02, Dmitry Safonov wrote:
> On 01/28/2016 05:58 AM, Xunlei Pang wrote:
>> Hi Dmitry,
>>  
>> On 2016/01/28 at 03:15, Andrew Morton wrote:
>>> On Wed, 27 Jan 2016 14:48:31 +0300 Dmitry Safonov <dsafonov@virtuozzo.com> wrote:
>>>
>>>> For allocation of kimage failure or kexec_prepare or load segments
>>>> errors there is no need to keep crashkernel memory mapped.
>>>> It will affect only s390 as map/unmap hook defined only for it.
>>>> As on unmap s390 also changes os_info structure let's check return code
>>>> and add info only on success.
>>>>
>>> This conflicts (both mechanically and somewhat conceptually) with
>>> Xunlei Pang's "kexec: Introduce a protection mechanism for the
>>> crashkernel reserved memory" and "kexec: provide
>>> arch_kexec_protect(unprotect)_crashkres()".
>>>
>>> http://ozlabs.org/~akpm/mmots/broken-out/kexec-introduce-a-protection-mechanism-for-the-crashkernel-reserved-memory.patch
>>> http://ozlabs.org/~akpm/mmots/broken-out/kexec-introduce-a-protection-mechanism-for-the-crashkernel-reserved-memory-v4.patch
>>>
>>> and
>>>
>>> http://ozlabs.org/~akpm/mmots/broken-out/kexec-provide-arch_kexec_protectunprotect_crashkres.patch
>>> http://ozlabs.org/~akpm/mmots/broken-out/kexec-provide-arch_kexec_protectunprotect_crashkres-v4.patch
>>>
>>> so can we please sort all that out?
>>
>> Ah, I've checked git-log history, they are almost the same idea, can crash_unmap/map_reserved_pages()
>> be re-implemented using the new  arch_kexec_unprotect/protect_crashkres() on S390?
> Sorry, didn't fetched akpm before sending.
> Yes, sounds like really right thing to do to have one united arch-helper.

Yeah, as Michael said, "memblock_remove(crash_base, crash_size)" creates a big hole in the kernel pgtable.
In order to have one united arch-helper, I guess we can forbid this to let the pgtable setup for crash memory,
then we can easily move the logic of crash_map_reserved_pages() to arch_kexec_unprotect_crashkres(),  and
move crash_unmap_reserved_pages() to arch_kexec_protect_crashkres(). After that crash_map_reserved_pages()
called in crash_shrink_memory() can be safely removed as well.

Regards,
Xunlei

>>
>> Regards,
>> Xunlei
>>
>>> _______________________________________________
>>> kexec mailing list
>>> kexec@lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/kexec
>>
>
>
> -- 
> Regards,
> Dmitry Safonov
