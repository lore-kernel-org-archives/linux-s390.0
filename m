Return-Path: <SRS0=gLLx=RM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
From: Alex Ghiti <alex@ghiti.fr>
Subject: Re: [PATCH v6 4/4] hugetlb: allow to free gigantic pages regardless
 of the configuration
References: <20190307132015.26970-1-alex@ghiti.fr>
 <20190307132015.26970-5-alex@ghiti.fr>
 <ee22103c-5060-e39e-7085-87c07d674cd8@oracle.com>
Message-ID: <416b046e-b1c0-00e1-0773-1dd869f7e121@ghiti.fr>
Date: Sat, 9 Mar 2019 04:32:05 -0500
MIME-Version: 1.0
In-Reply-To: <ee22103c-5060-e39e-7085-87c07d674cd8@oracle.com>
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
To: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-mm@kvack.org, Paul Mackerras <paulus@samba.org>, "H . Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org, linux-s390@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org, Ingo Molnar <mingo@redhat.com>, Vlastimil Babka <vbabka@suse.cz>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Will Deacon <will.deacon@arm.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org, "David S . Miller" <davem@davemloft.net>
List-ID: <linux-s390.vger.kernel.org>

On 3/8/19 2:05 PM, Mike Kravetz wrote:
> On 3/7/19 5:20 AM, Alexandre Ghiti wrote:
>> On systems without CONTIG_ALLOC activated but that support gigantic pages,
>> boottime reserved gigantic pages can not be freed at all. This patch
>> simply enables the possibility to hand back those pages to memory
>> allocator.
>>
>> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
>> Acked-by: David S. Miller <davem@davemloft.net> [sparc]
> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
Thanks Mike,

Alex

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
