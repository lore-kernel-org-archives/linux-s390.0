Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
Date: Wed, 16 Jan 2019 17:13:49 +0200
From: Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH 19/21] treewide: add checks for the return value of
 memblock_alloc*()
References: <1547646261-32535-1-git-send-email-rppt@linux.ibm.com>
 <1547646261-32535-20-git-send-email-rppt@linux.ibm.com>
 <CAMuHMdWKPj-2Let44rmaVwh-b6kkGg+0cFPQ-+3k9LP86pB7NA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAMuHMdWKPj-2Let44rmaVwh-b6kkGg+0cFPQ-+3k9LP86pB7NA@mail.gmail.com>
Message-Id: <20190116151348.GD6643@rapoport-lnx>
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
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Rich Felker <dalias@libc.org>, "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, the arch/x86 maintainers <x86@kernel.org>, linux-mips@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>, Guo Ren <guoren@kernel.org>, sparclinux <sparclinux@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, linux-s390 <linux-s390@vger.kernel.org>, linux-c6x-dev@linux-c6x.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Richard Weinberger <richard@nod.at>, Linux-sh list <linux-sh@vger.kernel.org>, Russell King <linux@armlinux.org.uk>, kasan-dev@googlegroups.com, Mark Salter <msalter@redhat.com>, Dennis Zhou <dennis@kernel.org>, Matt Turner <mattst88@gmail.com>, arcml <linux-snps-arc@lists.infradead.org>, "moderated list:H8/300 ARCHITECTURE" <uclinux-h8-devel@lists.sourceforge.jp>, Petr Mladek <pmladek@suse.com>, linux-xtensa@linux-xtensa.org, alpha <linux-alpha@vger.kernel.org>, linux-um@lists.infradead.org, linux-m68k <linux-m68k@lists.linux-m68k.org>, Rob Herring <robh+dt@kernel.org>, Greentime Hu <green.hu@gmail.com>, xen-devel@lists.xenproject.org, Stafford Horne <shorne@gmail.com>, Guan Xuetao <gxt@pku.edu.cn>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Michal Simek <monstr@monstr.eu>, Tony Luck <tony.luck@intel.com>, Linux MM <linux-mm@kvack.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, USB list <linux-usb@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Paul Burton <paul.burton@mips.com>, Vineet Gupta <vgupta@synopsys.com>, Michael Ellerman <mpe@ellerman.id.au>, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, "David S. Miller" <davem@davemloft.net>, Openrisc <openrisc@lists.librecores.org>
List-ID: <linux-s390.vger.kernel.org>

On Wed, Jan 16, 2019 at 03:27:35PM +0100, Geert Uytterhoeven wrote:
> Hi Mike,
> 
> On Wed, Jan 16, 2019 at 2:46 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
> > Add check for the return value of memblock_alloc*() functions and call
> > panic() in case of error.
> > The panic message repeats the one used by panicing memblock allocators with
> > adjustment of parameters to include only relevant ones.
> >
> > The replacement was mostly automated with semantic patches like the one
> > below with manual massaging of format strings.
> >
> > @@
> > expression ptr, size, align;
> > @@
> > ptr = memblock_alloc(size, align);
> > + if (!ptr)
> > +       panic("%s: Failed to allocate %lu bytes align=0x%lx\n", __func__,
> 
> In general, you want to use %zu for size_t
> 
> > size, align);
> >
> > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> 
> Thanks for your patch!
> 
> >  74 files changed, 415 insertions(+), 29 deletions(-)
> 
> I'm wondering if this is really an improvement?

From memblock perspective it's definitely an improvement :)

git diff --stat mmotm/master include/linux/memblock.h mm/memblock.c
 include/linux/memblock.h |  59 ++---------
 mm/memblock.c            | 249 ++++++++++++++++-------------------------------
 2 files changed, 90 insertions(+), 218 deletions(-)

> For the normal memory allocator, the trend is to remove printing of errors
> from all callers, as the core takes care of that.

It's more about allocation errors handling than printing of the errors.
Indeed, there is not much that can be done if an early allocation fails,
but I believe having an explicit pattern

	ptr = alloc();
	if (!ptr)
		do_something_about_it();

is clearer than relying on the allocator to panic().

Besides, the diversity of panic and nopanic variants creates a confusion
and I've caught several places that call nopanic variant and do not check
its return value.
 
> > --- a/arch/alpha/kernel/core_marvel.c
> > +++ b/arch/alpha/kernel/core_marvel.c
> > @@ -83,6 +83,9 @@ mk_resource_name(int pe, int port, char *str)
> >
> >         sprintf(tmp, "PCI %s PE %d PORT %d", str, pe, port);
> >         name = memblock_alloc(strlen(tmp) + 1, SMP_CACHE_BYTES);
> > +       if (!name)
> > +               panic("%s: Failed to allocate %lu bytes\n", __func__,
> 
> %zu, as strlen() returns size_t.

Thanks for spotting it, will fix.

> > +                     strlen(tmp) + 1);
> >         strcpy(name, tmp);
> >
> >         return name;
> > @@ -118,6 +121,9 @@ alloc_io7(unsigned int pe)
> >         }
> >
> >         io7 = memblock_alloc(sizeof(*io7), SMP_CACHE_BYTES);
> > +       if (!io7)
> > +               panic("%s: Failed to allocate %lu bytes\n", __func__,
> 
> %zu, as sizeof() returns size_t.
> Probably there are more. Yes, it's hard to get them right in all callers.

Yeah :)
 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> -- 
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
> 

-- 
Sincerely yours,
Mike.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
