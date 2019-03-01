Return-Path: <SRS0=/L37=RE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
Subject: Re: [PATCH v4 4/4] hugetlb: allow to free gigantic pages regardless
 of the configuration
References: <20190228063604.15298-1-alex@ghiti.fr>
 <20190228063604.15298-5-alex@ghiti.fr>
 <9a385cc8-581c-55cf-4a85-10b5c4dd178c@intel.com>
 <31212559-d397-88fb-eaec-60f6417436c8@oracle.com>
 <6c842251-1bed-4d79-bf6d-997006ec72e2@intel.com>
 <6ea4119a-0ecb-511d-3aab-269004245a08@oracle.com>
 <1cfaca88-a219-d057-3ab8-37fb1c1687d6@ghiti.fr>
 <f7c94eb5-d496-7e24-d44f-17eaff287012@ghiti.fr>
From: Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <0d3de196-bd71-3ec9-00cd-f8274c9c5f53@oracle.com>
Date: Fri, 1 Mar 2019 09:51:50 -0800
MIME-Version: 1.0
In-Reply-To: <f7c94eb5-d496-7e24-d44f-17eaff287012@ghiti.fr>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
List-Archive: <https://lore.kernel.org/linux-arm-kernel/>
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>, Will Deacon <will.deacon@arm.com>, Dave Hansen <dave.hansen@intel.com>, Paul Mackerras <paulus@samba.org>, "H . Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org, linux-s390@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org, Ingo Molnar <mingo@redhat.com>, Vlastimil Babka <vbabka@suse.cz>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, linuxppc-dev@lists.ozlabs.org, "David S . Miller" <davem@davemloft.net>
List-ID: <linux-s390.vger.kernel.org>

On 3/1/19 5:21 AM, Alexandre Ghiti wrote:
> On 03/01/2019 07:25 AM, Alex Ghiti wrote:
>> On 2/28/19 5:26 PM, Mike Kravetz wrote:
>>> On 2/28/19 12:23 PM, Dave Hansen wrote:
>>>> On 2/28/19 11:50 AM, Mike Kravetz wrote:
>>>>> On 2/28/19 11:13 AM, Dave Hansen wrote:
>>>>>>> +    if (hstate_is_gigantic(h) && !IS_ENABLED(CONFIG_CONTIG_ALLOC)) {
>>>>>>> +        spin_lock(&hugetlb_lock);
>>>>>>> +        if (count > persistent_huge_pages(h)) {
>>>>>>> +            spin_unlock(&hugetlb_lock);
>>>>>>> +            return -EINVAL;
>>>>>>> +        }
>>>>>>> +        goto decrease_pool;
>>>>>>> +    }
>>>>>> This choice confuses me.  The "Decrease the pool size" code already
>>>>>> works and the code just falls through to it after skipping all the
>>>>>> "Increase the pool size" code.
>>>>>>
>>>>>> Why did did you need to add this case so early?  Why not just let it
>>>>>> fall through like before?
>>>>> I assume you are questioning the goto, right?  You are correct in that
>>>>> it is unnecessary and we could just fall through.
>>>> Yeah, it just looked odd to me.
> 
>> I'd rather avoid useless checks when we already know they won't
>> be met and I think that makes the code more understandable.
>>
>> But that's up to you for the next version.

I too find some value in the goto.  It tells me this !CONFIG_CONTIG_ALLOC
case is special and we are skipping the normal checks.  But, removing the
goto is not a requirement for me.

>>>>> However, I wonder if we might want to consider a wacky condition that the
>>>>> above check would prevent.  Consider a system/configuration with 5 gigantic
...
>>
>> If I may, I think that this is the kind of info the user wants to have and we should
>> return an error when it is not possible to allocate runtime huge pages.
>> I already noticed that if someone asks for 10 huge pages, and only 5 are allocated,
>> no error is returned to the user and I found that surprising.

Upon further thought, let's not consider this wacky permanent -> surplus ->
permanent case.  I just can't see it being an actual use case.

IIUC, that 'no error' behavior is somewhat expected.  I seem to recall previous
discussions about changing with the end result to leave as is.

>>>> @@ -2428,7 +2442,9 @@ static ssize_t __nr_hugepages_store_common(bool obey_mempolicy,
>>>>       } else
>>>>           nodes_allowed = &node_states[N_MEMORY];
>>>>   -    h->max_huge_pages = set_max_huge_pages(h, count, nodes_allowed);
>>>> +    err = set_max_huge_pages(h, count, nodes_allowed);
>>>> +    if (err)
>>>> +        goto out;
>>>>         if (nodes_allowed != &node_states[N_MEMORY])
>>>>           NODEMASK_FREE(nodes_allowed);
>>> Do note that I beleive there is a bug the above change.  The code after
>>> the out label is:
>>>
>>> out:
>>>          NODEMASK_FREE(nodes_allowed);
>>>          return err;
>>> }
>>>
>>> With the new goto, we need the same
>>> if (nodes_allowed != &node_states[N_MEMORY]) before NODEMASK_FREE().
>>>
>>> Sorry, I missed this in previous versions.
>>
>> Oh right, I'm really sorry I missed that, thank you for noticing.

This is the only issue I have with the code in hugetlb.c.  For me, the
goto can stay or go.  End result is the same.
-- 
Mike Kravetz

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
