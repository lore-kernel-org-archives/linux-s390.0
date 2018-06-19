Return-Path: <owner-linux-mm@kvack.org>
MIME-Version: 1.0
References: <20171117014601.31606-1-pasha.tatashin@oracle.com>
 <20171121072416.v77vu4osm2s4o5sq@dhcp22.suse.cz> <b16029f0-ada0-df25-071b-cd5dba0ab756@suse.cz>
 <CAGM2rea=_VJJ26tohWQWgfwcFVkp0gb6j1edH1kVLjtxfugf5Q@mail.gmail.com>
In-Reply-To: <CAGM2rea=_VJJ26tohWQWgfwcFVkp0gb6j1edH1kVLjtxfugf5Q@mail.gmail.com>
From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Tue, 19 Jun 2018 15:56:13 -0400
Message-ID: <CAGM2reYcwyOcKrO=WhB3Cf0FNL3ZearC=KvxmTNUU6rkWviQOg@mail.gmail.com>
Subject: Re: [PATCH v1] mm: relax deferred struct page requirements
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-mm@kvack.org
List-Archive: <https://lore.kernel.org/linux-mm/>
List-Post: <mailto:linux-mm@kvack.org>
To: jslaby@suse.cz
Cc: mhocko@kernel.org, Steven Sistare <steven.sistare@oracle.com>, Daniel Jordan <daniel.m.jordan@oracle.com>, benh@kernel.crashing.org, paulus@samba.org, Andrew Morton <akpm@linux-foundation.org>, kirill.shutemov@linux.intel.com, Reza Arbab <arbab@linux.vnet.ibm.com>, schwidefsky@de.ibm.com, Heiko Carstens <heiko.carstens@de.ibm.com>, x86@kernel.org, LKML <linux-kernel@vger.kernel.org>, tglx@linutronix.de, linuxppc-dev@lists.ozlabs.org, Linux Memory Management List <linux-mm@kvack.org>, linux-s390@vger.kernel.org, mgorman@techsingularity.net
List-ID: <linux-s390.vger.kernel.org>

On Tue, Jun 19, 2018 at 9:50 AM Pavel Tatashin
<pasha.tatashin@oracle.com> wrote:
>
> On Sat, Jun 16, 2018 at 4:04 AM Jiri Slaby <jslaby@suse.cz> wrote:
> >
> > On 11/21/2017, 08:24 AM, Michal Hocko wrote:
> > > On Thu 16-11-17 20:46:01, Pavel Tatashin wrote:
> > >> There is no need to have ARCH_SUPPORTS_DEFERRED_STRUCT_PAGE_INIT,
> > >> as all the page initialization code is in common code.
> > >>
> > >> Also, there is no need to depend on MEMORY_HOTPLUG, as initialization code
> > >> does not really use hotplug memory functionality. So, we can remove this
> > >> requirement as well.
> > >>
> > >> This patch allows to use deferred struct page initialization on all
> > >> platforms with memblock allocator.
> > >>
> > >> Tested on x86, arm64, and sparc. Also, verified that code compiles on
> > >> PPC with CONFIG_MEMORY_HOTPLUG disabled.
> > >
> > > There is slight risk that we will encounter corner cases on some
> > > architectures with weird memory layout/topology
> >
> > Which x86_32-pae seems to be. Many bad page state errors are emitted
> > during boot when this patch is applied:
>
> Hi Jiri,
>
> Thank you for reporting this bug.
>
> Because 32-bit systems are limited in the maximum amount of physical
> memory, they don't need deferred struct pages. So, we can add depends
> on 64BIT to DEFERRED_STRUCT_PAGE_INIT in mm/Kconfig.
>
> However, before we do this, I want to try reproducing this problem and
> root cause it, as it might expose a general problem that is not 32-bit
> specific.

Hi Jiri,

Could you please attach your config and full qemu arguments that you
used to reproduce this bug.

Thank you,
Pavel


>
> Thank you,
> Pavel
