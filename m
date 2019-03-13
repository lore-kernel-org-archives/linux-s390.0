Return-Path: <SRS0=ZaPV=RQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
Subject: Re: [PATCH v6 0/4] Fix free/allocation of runtime gigantic pages
References: <20190307132015.26970-1-alex@ghiti.fr>
 <875e6287-9528-45ec-788c-9c785e548942@intel.com>
From: Alexandre Ghiti <alex@ghiti.fr>
Message-ID: <de40e6f1-c520-bcae-2009-19c0abbcd5d5@ghiti.fr>
Date: Wed, 13 Mar 2019 17:48:21 +0100
MIME-Version: 1.0
In-Reply-To: <875e6287-9528-45ec-788c-9c785e548942@intel.com>
Content-Language: fr
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
To: Dave Hansen <dave.hansen@intel.com>, Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, "David S . Miller" <davem@davemloft.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Mike Kravetz <mike.kravetz@oracle.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-mm@kvack.org
List-ID: <linux-s390.vger.kernel.org>

On 03/13/2019 05:41 PM, Dave Hansen wrote:
> On 3/7/19 5:20 AM, Alexandre Ghiti wrote:
>> This series fixes sh and sparc that did not advertise their gigantic page
>> support and then were not able to allocate and free those pages at runtime.
>> It renames MEMORY_ISOLATION && COMPACTION || CMA condition into the more
>> accurate CONTIG_ALLOC, since it allows the definition of alloc_contig_range
>> function.
>> Finally, it then fixes the wrong definition of ARCH_HAS_GIGANTIC_PAGE config
>> that, without MEMORY_ISOLATION && COMPACTION || CMA defined, did not allow
>> architectures to free boottime allocated gigantic pages although unrelated.
> Looks good, thanks for all the changes.  For everything generic in the
> set, plus the x86 bits:
>
> Acked-by: Dave Hansen <dave.hansen@intel.com>

Thanks Dave,

Alex

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
