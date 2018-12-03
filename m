From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH RFCv2 2/4] mm/memory_hotplug: Replace "bool want_memblock"
 by "int type"
Date: Mon, 3 Dec 2018 11:33:12 +0100
Message-ID: <5ecbff41-fc41-79fc-696e-4ca1f066f9aa@redhat.com>
References: <20181130175922.10425-1-david@redhat.com>
 <20181130175922.10425-3-david@redhat.com>
 <20181201015024.3o334nk2fe5mlasj@master>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <20181201015024.3o334nk2fe5mlasj@master>
Content-Language: en-US
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
List-Archive: <https://lore.kernel.org/linux-acpi/>
List-Post: <mailto:linux-acpi@vger.kernel.org>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: Oscar Salvador <osalvador@suse.com>, Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Dave Hansen <dave.hansen@linux.intel.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-mm@kvack.org, Michal Hocko <mhocko@suse.com>, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, Dan Williams <dan.j.williams@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, linux-s390@vger.kernel.org, Dave Jiang <dave.jiang@intel.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org, Matthew Wilcox <willy@infradead.org>, linux-acpi@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, xen-devel@lists.xenproject.org, Rob Herring <robh@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>
List-ID: <linux-s390.vger.kernel.org>

On 01.12.18 02:50, Wei Yang wrote:
> On Fri, Nov 30, 2018 at 06:59:20PM +0100, David Hildenbrand wrote:
>> Let's pass a memory block type instead. Pass "MEMORY_BLOCK_NONE" for device
>> memory and for now "MEMORY_BLOCK_UNSPECIFIED" for anything else. No
>> functional change.
> 
> I would suggest to put more words to this.

Sure, makes sense, I'll add more details. Thanks!

> 
> "
> Function arch_add_memory()'s last parameter *want_memblock* is used to
> determin whether it is necessary to create a corresponding memory block
> device. After introducing the memory block type, this patch replaces the
> bool type *want_memblock* with memory block type with following rules
> for now:
> 
>   * Pass "MEMORY_BLOCK_NONE" for device memory
>   * Pass "MEMORY_BLOCK_UNSPECIFIED" for anything else 
> 
> Since this parameter is passed deep to __add_section(), all its
> descendents are effected. Below lists those descendents.
> 
>   arch_add_memory()
>     add_pages()
>       __add_pages()
>         __add_section()
> 
> "

[...]


-- 

Thanks,

David / dhildenb
