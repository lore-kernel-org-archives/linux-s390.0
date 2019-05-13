Return-Path: <SRS0=GvbC=TN=kvack.org=owner-linux-mm@kernel.org>
Subject: Re: [PATCH v2 3/8] mm/memory_hotplug: arch_remove_memory() and
 __remove_pages() with CONFIG_MEMORY_HOTPLUG
From: David Hildenbrand <david@redhat.com>
References: <20190507183804.5512-1-david@redhat.com>
 <20190507183804.5512-4-david@redhat.com>
 <CAPcyv4jpnKjeP3QEvF3_9CzdZhtFXN2nMU7P-Ee7y06J3bGZ0A@mail.gmail.com>
 <c027a782-1cef-a076-92a3-3ce36140f3f2@redhat.com>
Message-ID: <fd061541-4433-d7a2-df73-66f39b61d0c9@redhat.com>
Date: Mon, 13 May 2019 10:20:43 +0200
MIME-Version: 1.0
In-Reply-To: <c027a782-1cef-a076-92a3-3ce36140f3f2@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: owner-linux-mm@kvack.org
List-Archive: <https://lore.kernel.org/linux-mm/>
List-Post: <mailto:linux-mm@kvack.org>
To: Dan Williams <dan.j.williams@intel.com>, Michal Hocko <mhocko@suse.com>, Oscar Salvador <osalvador@suse.com>
Cc: Linux MM <linux-mm@kvack.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ia64@vger.kernel.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-s390 <linux-s390@vger.kernel.org>, Linux-sh <linux-sh@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Mike Rapoport <rppt@linux.ibm.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Alex Deucher <alexander.deucher@amd.com>, "David S. Miller" <davem@davemloft.net>, Mark Brown <broonie@kernel.org>, Chris Wilson <chris@chris-wilson.co.uk>, Christophe Leroy <christophe.leroy@c-s.fr>, Nicholas Piggin <npiggin@gmail.com>, Vasily Gorbik <gor@linux.ibm.com>, Rob Herring <robh@kernel.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, "mike.travis@hpe.com" <mike.travis@hpe.com>, Andrew Banman <andrew.banman@hpe.com>, Pavel Tatashin <pasha.tatashin@soleen.com>, Wei Yang <richardw.yang@linux.intel.com>, Arun KS <arunks@codeaurora.org>, Qian Cai <cai@lca.pw>, Mathieu Malaterre <malat@debian.org>, Baoquan He <bhe@redhat.com>, Logan Gunthorpe <logang@deltatee.com>
List-ID: <linux-s390.vger.kernel.org>

On 13.05.19 09:48, David Hildenbrand wrote:
> On 07.05.19 23:02, Dan Williams wrote:
>> On Tue, May 7, 2019 at 11:38 AM David Hildenbrand <david@redhat.com> wrote:
>>>
>>> Let's prepare for better error handling while adding memory by allowing
>>> to use arch_remove_memory() and __remove_pages() even if
>>> CONFIG_MEMORY_HOTREMOVE is not set. CONFIG_MEMORY_HOTREMOVE effectively
>>> covers
>>> - Offlining of system ram (memory block devices) - offline_pages()
>>> - Unplug of system ram - remove_memory()
>>> - Unplug/remap of device memory - devm_memremap()
>>>
>>> This allows e.g. for handling like
>>>
>>> arch_add_memory()
>>> rc = do_something();
>>> if (rc) {
>>>         arch_remove_memory();
>>> }
>>>
>>> Whereby do_something() will for example be memory block device creation
>>> after it has been factored out.
>>
>> What's left after this? Can we just get rid of CONFIG_MEMORY_HOTREMOVE
>> option completely when CONFIG_MEMORY_HOTPLUG is enabled? It's not
>> clear to me why there was ever the option to compile out the remove
>> code when the add code is included.
>>
> 
> If there are no other comments, I will go ahead and rip out
> CONFIG_MEMORY_HOTREMOVE completely, gluing the functionality to
> CONFIG_MEMORY_HOTPLUG.
> 

Hmmmm, however this will require CONFIG_MEMORY_HOTPLUG to require

- MEMORY_ISOLATION
- HAVE_BOOTMEM_INFO_NODE if (X86_64 || PPC64)

And depends on
- MIGRATION

Which would limit the configurations where memory hotplug would be
available. I guess going with this patch here is ok as a first step.

I just realized, that we'll need arch_remove_memory() for arm64 to make
this patch here work.

-- 

Thanks,

David / dhildenb
