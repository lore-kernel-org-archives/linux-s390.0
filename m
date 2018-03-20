Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 20 Mar 2018 17:49:07 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH 00/11] kexec_file: Clean up purgatory load
Message-ID: <20180320094907.GA8838@dhcp-128-65.nay.redhat.com>
References: <20180226151620.20970-1-prudo@linux.vnet.ibm.com>
 <20180309051913.GA9358@dhcp-128-65.nay.redhat.com>
 <20180309152556.0ccf3cb1@ThinkPad>
 <20180312074016.GA1854@dhcp-128-65.nay.redhat.com>
 <20180315073422.GA1876@dhcp-128-65.nay.redhat.com>
 <20180315111341.6faa90e8@ThinkPad>
 <20180316064102.GA26732@dhcp-128-65.nay.redhat.com>
 <20180320103955.13d83ef9@ThinkPad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180320103955.13d83ef9@ThinkPad>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Philipp Rudo <prudo@linux.vnet.ibm.com>
Cc: linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Eric Biederman <ebiederm@xmission.com>, Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Vivek Goyal <vgoyal@redhat.com>, Ingo Molnar <mingo@kernel.org>
List-ID: <linux-s390.vger.kernel.org>

Hi Philipp,
On 03/20/18 at 10:39am, Philipp Rudo wrote:
> Hi Dave,
> 
> sorry for the late answer.
> 
> 
> On Fri, 16 Mar 2018 14:41:02 +0800
> Dave Young <dyoung@redhat.com> wrote:
> 
> > On 03/15/18 at 11:13am, Philipp Rudo wrote:
> > > Hi Dave,
> > > 
> > > On Thu, 15 Mar 2018 15:34:22 +0800
> > > Dave Young <dyoung@redhat.com> wrote:
> > >   
> > > > On 03/12/18 at 03:40pm, Dave Young wrote:  
> > > > > Hi Philipp,
> > > > > On 03/09/18 at 03:25pm, Philipp Rudo wrote:    
> > > > > > Hi Dave,
> > > > > > 
> > > > > > On Fri, 9 Mar 2018 13:19:40 +0800
> > > > > > Dave Young <dyoung@redhat.com> wrote:
> > > > > >     
> > > > > > > Hi Philipp,
> > > > > > > On 02/26/18 at 04:16pm, Philipp Rudo wrote:    
> > > > > > > > 
> > > > > > > > Hi everybody
> > > > > > > > 
> > > > > > > > following the discussion with Dave and AKASHI, here are the common code
> > > > > > > > patches extracted from my recent patch set (Add kexec_file_load support to
> > > > > > > > s390) [1]. The patches were extracted to allow upstream integration together
> > > > > > > > with AKASHI's common code patches before the arch code gets adjusted to the
> > > > > > > > new base.
> > > > > > > > 
> > > > > > > > The reason for this series is to prepare common code for adding
> > > > > > > > kexec_file_load to s390 as well as cleaning up the mis-use of the sh_offset
> > > > > > > > field during purgatory load. In detail this series contains:
> > > > > > > > 
> > > > > > > > Patch #1&2: Minor cleanups/fixes.
> > > > > > > > 
> > > > > > > > Patch #3-9: Clean up the purgatory load/relocation code. Especially remove
> > > > > > > > the mis-use of the purgatory_info->sechdrs->sh_offset field, currently
> > > > > > > > holding a pointer into either kexec_purgatory (ro) or purgatory_buf (rw)
> > > > > > > > depending on the section. With these patches the section address will be
> > > > > > > > calculated verbosely and sh_offset will contain the offset of the section
> > > > > > > > in the stripped purgatory binary (purgatory_buf).
> > > > > > > > 
> > > > > > > > Patch #10: Allows architectures to set the purgatory load address. This
> > > > > > > > patch is important for s390 as the kernel and purgatory have to be loaded
> > > > > > > > to fixed addresses. In current code this is impossible as the purgatory
> > > > > > > > load is opaque to the architecture.
> > > > > > > > 
> > > > > > > > Patch #11: Moves x86 purgatories sha implementation to common lib/
> > > > > > > > directory to allow reuse in other architectures.
> > > > > > > > 
> > > > > > > > The patches apply to v4.16-rc3. There are no changes compared to [1] (all
> > > > > > > > requested changes only affected s390 code). Please note that I had to touch
> > > > > > > > arch code for x86 and power a little. In theory this should not change the
> > > > > > > > behavior but I don't have a way to test it. Cross-compiling with
> > > > > > > > defconfig [2] works fine for both.
> > > > > > > > 
> > > > > > > > Thanks
> > > > > > > > Philipp
> > > > > > > > 
> > > > > > > > [1] http://lists.infradead.org/pipermail/kexec/2018-February/019926.html
> > > > > > > > [2] On x86 with the orc unwinder and stack validation turned off. objtool
> > > > > > > >     SEGFAULTs on s390...
> > > > > > > > 
> > > > > > > > Philipp Rudo (11):
> > > > > > > >   kexec_file: Silence compile warnings
> > > > > > > >   kexec_file: Remove checks in kexec_purgatory_load
> > > > > > > >   kexec_file: Make purgatory_info->ehdr const
> > > > > > > >   kexec_file: Search symbols in read-only kexec_purgatory
> > > > > > > >   kexec_file: Use read-only sections in arch_kexec_apply_relocations*
> > > > > > > >   kexec_file: Split up __kexec_load_puragory
> > > > > > > >   kexec_file: Simplify kexec_purgatory_setup_sechdrs 1
> > > > > > > >   kexec_file: Simplify kexec_purgatory_setup_sechdrs 2
> > > > > > > >   kexec_file: Remove mis-use of sh_offset field
> > > > > > > >   kexec_file: Allow archs to set purgatory load address
> > > > > > > >   kexec_file: Move purgatories sha256 to common code
> > > > > > > > 
> > > > > > > >  arch/powerpc/kernel/kexec_elf_64.c             |   9 +-
> > > > > > > >  arch/x86/kernel/kexec-bzimage64.c              |   8 +-
> > > > > > > >  arch/x86/kernel/machine_kexec_64.c             |  66 ++---
> > > > > > > >  arch/x86/purgatory/Makefile                    |   3 +
> > > > > > > >  arch/x86/purgatory/purgatory.c                 |   2 +-
> > > > > > > >  include/linux/kexec.h                          |  38 +--
> > > > > > > >  {arch/x86/purgatory => include/linux}/sha256.h |  10 +-
> > > > > > > >  kernel/kexec_file.c                            | 375 ++++++++++++-------------
> > > > > > > >  {arch/x86/purgatory => lib}/sha256.c           |   4 +-
> > > > > > > >  9 files changed, 244 insertions(+), 271 deletions(-)
> > > > > > > >  rename {arch/x86/purgatory => include/linux}/sha256.h (63%)
> > > > > > > >  rename {arch/x86/purgatory => lib}/sha256.c (99%)
> > > > > > > > 
> > > > > > > > -- 
> > > > > > > > 2.13.5
> > > > > > > >       
> > > > > > > 
> > > > > > > I did a test on x86, but it failed:
> > > > > > > [   15.636489] kexec: Undefined symbol: memcpy
> > > > > > > [   15.636496] kexec-bzImage64: Loading purgatory failed
> > > > > > > [   33.603356] kexec: Undefined symbol: memcpy
> > > > > > > [   33.603362] kexec-bzImage64: Loading purgatory failed
> > > > > > > 
> > > > > > > I think this relates to the sha256 splitting patch.    
> > > > > > 
> > > > > > I looked into this a little closer and i think i understood what happens. 
> > > > > > 
> > > > > > There is no definition of memcpy in arch/x86/boot/string.c, instead it's defined
> > > > > > in arch/x86/boot/string.h as __buildin_memcpy (same for memset). Thus by
> > > > > > switching to linux/string.h there is no more definition for it. Leaving us with
> > > > > > 
> > > > > > $ readelf -s purgatory.ro
> > > > > > [...]
> > > > > >  45: 0000000000000000     0 NOTYPE  GLOBAL DEFAULT  UND memcpy
> > > > > > [...]
> > > > > > 
> > > > > > To solve this problem I see two possibilities (example patches are at the end of
> > > > > > the mail):
> > > > > > 
> > > > > > 1) Have arch dependent includes in lib/sha256.c
> > > > > > 2) Add makefile magic so memcpy is defined
> > > > > > 
> > > > > > With both solutions the resulting purgatory.ro looks good. However both
> > > > > > solutions aren't perfect. For example in 2) i had too mix the linux/string.h
> > > > > > header with arch/x86/boot/string.c, because lib/string.c has too many
> > > > > > dependencies and does not compile in the purgatory. On the other hand having
> > > > > > arch dependent includes isn't that nice either ...
> > > > > > 
> > > > > > What's your opinion on this?    
> > > > > 
> > > > > Looks like it is a mess, maybe the 1st one is better although it is also
> > > > > ugly.  Ccing Ingo see if he has some idea about this.     
> > > > 
> > > > Maybe something like below is better if no other idea:
> > > > 
> > > > diff --git a/arch/x86/boot/string_builtin.c b/arch/x86/boot/string_builtin.c
> > > > new file mode 100644
> > > > index 000000000000..9099f949fb41
> > > > --- /dev/null
> > > > +++ b/arch/x86/boot/string_builtin.c
> > > > @@ -0,0 +1,11 @@
> > > > +#include <linux/types.h>
> > > > +
> > > > +void *memcpy(void *dst, const void *src, size_t len)
> > > > +{
> > > > +	return __builtin_memcpy(dst, src, len);
> > > > +}
> > > > +
> > > > +void *memset(void *dst, int c, size_t len)
> > > > +{
> > > > +	return __builtin_memset(dst, c, len);
> > > > +}
> > > > diff --git a/arch/x86/purgatory/string.c b/arch/x86/purgatory/string.c
> > > > index d886b1fa36f0..e12c78fcd59f 100644
> > > > --- a/arch/x86/purgatory/string.c
> > > > +++ b/arch/x86/purgatory/string.c
> > > > @@ -11,3 +11,4 @@
> > > >   */
> > > > 
> > > >  #include "../boot/string.c"
> > > > +#include "../boot/string_builtin.c"  
> > > 
> > > Looks like a good idea to me. Just to be sure, with this suggestion
> > > lib/sha256.c stays unchanged, i.e. it includes linux/string.h?  
> > 
> > Yes, I assumed so, one thing is I noticed linux/string.h uses __kernel_size_t, but
> > the boot/string.h use _size_t.
> 
> I don't think the __kernel_size_t vs. _size_t is a problem. When I make gcc's
> intermediate file 
> 
> 	$ make /arch/x86/purgatory/string.i
> 
> the type doesn't change with and without my patches. In both cases size_t is
> defined as
> 
> 	size_t -> __kernel_size_t -> __kernel_ulong_t -> unsigned long
> 
> So (at least for now) we are safe.
> 
> > > 
> > > The only thing I don't really like is adding the extra boot/string.builtin.c
> > > file. For my taste adding the two functions directly to purgatory/string.c would
> > > be nicer. However in the end it's "not my problem".  
> > 
> > string.c is also included in boot/compressed/string.c which defines its
> > own version of memcpy.  And in the boot/compressed/string.c version it
> > calls warn() which is a special function for decompressor used only.
> > I'm not sure how to merge them with one string.c now.
> 
> That's why i suggested to put the two functions into _purgatory_/string.c. In
> the end the file would read
> 
> ---
> $ cat arch/x86/purgatory/string.c
> /*
>  * Simple string functions.
>  *
>  * Copyright (C) 2014 Red Hat Inc.
>  *
>  * Author:
>  *       Vivek Goyal <vgoyal@redhat.com>
>  *
>  * This source code is licensed under the GNU General Public License,
>  * Version 2.  See the file COPYING for more details.
>  */
> 
> #include <linux/types.h>
> 
> #include "../boot/string.c"
> 
> void *memcpy(void *dst, const void *src, size_t len)
> {
> 	return __builtin_memcpy(dst, src, len);
> }
> 
> void *memset(void *dst, int c, size_t len)
> {
> 	return __builtin_memset(dst, c, len);
> }
> ---
> 
> Of course it would be even nicer having them in boot/string.c. But as you
> already mentioned that would require a larger cleanup and should be done by
> somebody with more experience on x86.

Ok, I got your points, your proposal looks good to me if no better choice.

Thanks
Dave
