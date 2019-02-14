Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
Subject: Re: [PATCH v2] hugetlb: allow to free gigantic pages regardless of
 the configuration
References: <20190213192610.17265-1-alex@ghiti.fr>
 <d367b5c7-eb05-6d0b-f9bf-5b3fc3f392a9@intel.com>
From: Vlastimil Babka <vbabka@suse.cz>
Message-ID: <bcffa37e-22cd-f0d7-ee85-769c0d54520a@suse.cz>
Date: Thu, 14 Feb 2019 10:52:06 +0100
MIME-Version: 1.0
In-Reply-To: <d367b5c7-eb05-6d0b-f9bf-5b3fc3f392a9@intel.com>
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
To: Dave Hansen <dave.hansen@intel.com>, Alexandre Ghiti <alex@ghiti.fr>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Mike Kravetz <mike.kravetz@oracle.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
List-ID: <linux-s390.vger.kernel.org>

On 2/13/19 8:30 PM, Dave Hansen wrote:
>> -#if (defined(CONFIG_MEMORY_ISOLATION) && defined(CONFIG_COMPACTION)) || defined(CONFIG_CMA)
>> +#ifdef CONFIG_COMPACTION_CORE
>>  static __init int gigantic_pages_init(void)
>>  {
>>  	/* With compaction or CMA we can allocate gigantic pages at runtime */
>> diff --git a/fs/Kconfig b/fs/Kconfig
>> index ac474a61be37..8fecd3ea5563 100644
>> --- a/fs/Kconfig
>> +++ b/fs/Kconfig
>> @@ -207,8 +207,9 @@ config HUGETLB_PAGE
>>  config MEMFD_CREATE
>>  	def_bool TMPFS || HUGETLBFS
>>  
>> -config ARCH_HAS_GIGANTIC_PAGE
>> +config COMPACTION_CORE
>>  	bool
>> +	default y if (MEMORY_ISOLATION && MIGRATION) || CMA
> 
> This takes a hard dependency (#if) and turns it into a Kconfig *default*
> that can be overridden.  That seems like trouble.
> 
> Shouldn't it be:
> 
> config COMPACTION_CORE
> 	def_bool y
> 	depends on (MEMORY_ISOLATION && MIGRATION) || CMA

Agreed. Also I noticed that it now depends on MIGRATION instead of
COMPACTION. That intention is correct IMHO, but will fail to
compile/link when both COMPACTION and CMA are disabled, and would need
more changes in mm/internal.h and mm/compaction.c (possibly just
replacing CMA in all "if defined CONFIG_COMPACTION || defined
CONFIG_CMA" instances with COMPACTION_CORE, but there might be more
problems, wanna try? :)

Also, I realized that COMPACTION_CORE is a wrong name, sorry about that.
What the config really provides is alloc_contig_range(), so it should be
named either CONFIG_CMA_CORE (as it provides contiguous memory
allocation, but not the related reservation and accounting), or
something like CONFIG_CONTIG_ALLOC. I would also move it from fs/Kconfig
to mm/Kconfig.

Thanks!

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
