Return-Path: <SRS0=hX7x=RJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
Subject: Re: [PATCH v5 4/4] hugetlb: allow to free gigantic pages regardless
 of the configuration
References: <20190306190005.7036-1-alex@ghiti.fr>
 <20190306190005.7036-5-alex@ghiti.fr>
 <7c81abe0-5f9d-32f9-1e9a-70ab06d48f8e@intel.com>
From: Alex Ghiti <alex@ghiti.fr>
Message-ID: <82a3f572-e9c1-0151-3d7d-a646f5e5302c@ghiti.fr>
Date: Wed, 6 Mar 2019 15:08:06 -0500
MIME-Version: 1.0
In-Reply-To: <7c81abe0-5f9d-32f9-1e9a-70ab06d48f8e@intel.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
List-Archive: <https://lore.kernel.org/linux-arm-kernel/>
To: Dave Hansen <dave.hansen@intel.com>, Vlastimil Babka <vbabka@suse.cz>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, "David S . Miller" <davem@davemloft.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Mike Kravetz <mike.kravetz@oracle.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-mm@kvack.org
List-ID: <linux-s390.vger.kernel.org>

On 3/6/19 2:16 PM, Dave Hansen wrote:
> On 3/6/19 11:00 AM, Alexandre Ghiti wrote:
>> +static int set_max_huge_pages(struct hstate *h, unsigned long count,
>> +			      nodemask_t *nodes_allowed)
>>   {
>>   	unsigned long min_count, ret;
>>   
>> -	if (hstate_is_gigantic(h) && !gigantic_page_supported())
>> -		return h->max_huge_pages;
>> +	/*
>> +	 * Gigantic pages allocation depends on the capability for large page
>> +	 * range allocation. If the system cannot provide alloc_contig_range,
>> +	 * allow users to free gigantic pages.
>> +	 */
>> +	if (hstate_is_gigantic(h) && !IS_ENABLED(CONFIG_CONTIG_ALLOC)) {
>> +		spin_lock(&hugetlb_lock);
>> +		if (count > persistent_huge_pages(h)) {
>> +			spin_unlock(&hugetlb_lock);
>> +			return -EINVAL;
>> +		}
>> +		goto decrease_pool;
>> +	}
> We talked about it during the last round and I don't seen any mention of
> it here in comments or the changelog: Why is this a goto?  Why don't we
> just let the code fall through to the "decrease_pool" label?  Why is
> this new block needed at all?  Can't we just remove the old check and
> let it be?

I'll get rid of the goto, I don't know how to justify it properly in a 
comment,
maybe because it is not necessary.
This is not a new block, this means exactly the same as before (remember
gigantic_page_supported() actually meant CONTIG_ALLOC before this series),
except that now we allow a user to free boottime allocated gigantic pages.
And no we cannot just remove the check and let it be since it would modify
the current behaviour, which is to return an error when trying to allocate
gigantic pages whereas alloc_contig_range is not defined. I thought it was
clearly commented above, I can try to make it more explicit.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
