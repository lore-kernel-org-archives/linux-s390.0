Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 15 Feb 2018 14:08:22 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: Re: [PATCH 00/17] Add kexec_file_load support to s390
Message-ID: <20180215050821.GB11463@linaro.org>
References: <20180212100754.55121-1-prudo@linux.vnet.ibm.com>
 <20180214073543.GA12328@dhcp-128-65.nay.redhat.com>
 <20180214105449.1325bfbe@ThinkPad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180214105449.1325bfbe@ThinkPad>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Philipp Rudo <prudo@linux.vnet.ibm.com>
Cc: Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org, linux-s390@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Eric Biederman <ebiederm@xmission.com>, Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Vivek Goyal <vgoyal@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

Hi,

On Wed, Feb 14, 2018 at 10:54:49AM +0100, Philipp Rudo wrote:
> Hi Dave,
> 
> I just browsed AKASHI's patches (v7). The way I see it the common code changes
> are on different areas of kexec_file and shouldn't get in conflict. Only in the
> arch code (s390 and arm64) some function calls might need an update. But I have
> to take a closer look on the patches first.

Yes, I mainly focus on re-factoring elf-core-header related code.

> @AKASHI: Welcome to the list. While browsing I couldn't find any
> arch_apply_relocation function for arm64. These require the biggest changes in
> my patch set. Did I just miss it or does arm64 work differently?

Well, after some discussions with arm64 key developers, we decided not to
utilize digest hash values in purgatory as they may not be very valuable, and
this resulted in a simple purgatory, which requires no re-linking/relocations.

In my next version coming soon, as our purgatory was so simple, we will
completely drop a purgatory from kexec_file_load code.
(we will still maintain a purgatory for legacy kexec_load as kexec-tools
has it now.)

Thanks,
-Takahiro AKASHI

> @Dave: Happy holiday
> 
> Thanks
> Philipp
> 
> On Wed, 14 Feb 2018 15:35:43 +0800
> Dave Young <dyoung@redhat.com> wrote:
> 
> > Hi Philipp,
> > 
> > I added AKASHI in cc, he posted arm64 kexec_file series previously.
> > I would like to read both series especially the general part, but
> > maybe at the end of this month because of a holiday..
> > 
> > From the patch log the cleanup looks nice, but still need read the
> > details.
> > 
> > On 02/12/18 at 11:07am, Philipp Rudo wrote:
> > > Hi everybody
> > > 
> > > resending the series as there was no reaction, yet. Furthermore i was told
> > > that Andrew and the x86 list should also be CCed, so welcome.
> > > 
> > > No changes made to the patches since first time i sent them. The patches
> > > apply to the current master (v4.16-rc1).
> > > 
> > > Thanks
> > > Philipp
> > > 
> > > ---
> > > 
> > > this series adds the kexec_file_load system call to s390. Before the system
> > > call is added there are some preparations/clean ups to common
> > > kexec_file_load. In detail this series contains:
> > > 
> > > Patch #1&2: Minor cleanups/fixes.
> > > 
> > > Patch #3-9: Clean up the purgatory load/relocation code. Especially remove
> > > the mis-use of the purgatory_info->sechdrs->sh_offset field, currently
> > > holding a pointer into either kexec_purgatory (ro) or purgatory_buf (rw)
> > > depending on the section. With these patches the section address will be
> > > calculated verbosely and sh_offset will contain the offset of the section
> > > in the stripped purgatory binary (purgatory_buf).
> > > 
> > > Patch #10: Allows architectures to set the purgaory load address. This
> > > patch is important for s390 as the kernel and purgatory have to be loaded
> > > to fixed addresses. In current code this is impossible as the purgatory
> > > load is opaque to the architecture.
> > > 
> > > Patch #11: Moves x86 purgatories sha implementation to common lib/
> > > directory.
> > > 
> > > Patches #12-17 finally adds the kexec_file_load system call to s390.
> > > 
> > > Please note that I had to touch arch code for x86 and power a little. In
> > > theory this should not change the behavior but I don't have a way to test
> > > it. Cross-compiling with defconfig(*) works fine for both.
> > > 
> > > Thanks
> > > Philipp
> > > 
> > > (*) On x86 with the orc unwinder turned off. objtool SEGFAULTs on s390...
> > > 
> > > Philipp Rudo (17):
> > >   kexec_file: Silence compile warnings
> > >   kexec_file: Remove checks in kexec_purgatory_load
> > >   kexec_file: Make purgatory_info->ehdr const
> > >   kexec_file: Search symbols in read-only kexec_purgatory
> > >   kexec_file: Use read-only sections in arch_kexec_apply_relocations*
> > >   kexec_file: Split up __kexec_load_puragory
> > >   kexec_file: Simplify kexec_purgatory_setup_sechdrs 1
> > >   kexec_file: Simplify kexec_purgatory_setup_sechdrs 2
> > >   kexec_file: Remove mis-use of sh_offset field
> > >   kexec_file: Allow archs to set purgatory load address
> > >   kexec_file: Move purgatories sha256 to common code
> > >   s390/kexec_file: Prepare setup.h for kexec_file_load
> > >   s390/kexec_file: Add purgatory
> > >   s390/kexec_file: Add kexec_file_load system call
> > >   s390/kexec_file: Add image loader
> > >   s390/kexec_file: Add crash support to image loader
> > >   s390/kexec_file: Add ELF loader
> > > 
> > >  arch/powerpc/kernel/kexec_elf_64.c             |   9 +-
> > >  arch/s390/Kbuild                               |   1 +
> > >  arch/s390/Kconfig                              |   4 +
> > >  arch/s390/include/asm/kexec.h                  |  23 ++
> > >  arch/s390/include/asm/purgatory.h              |  17 ++
> > >  arch/s390/include/asm/setup.h                  |  40 ++-
> > >  arch/s390/kernel/Makefile                      |   1 +
> > >  arch/s390/kernel/asm-offsets.c                 |   5 +
> > >  arch/s390/kernel/compat_wrapper.c              |   1 +
> > >  arch/s390/kernel/kexec_elf.c                   | 149 ++++++++++
> > >  arch/s390/kernel/kexec_image.c                 |  78 +++++
> > >  arch/s390/kernel/machine_kexec_file.c          | 291 +++++++++++++++++++
> > >  arch/s390/kernel/syscalls/syscall.tbl          |   1 +
> > >  arch/s390/purgatory/Makefile                   |  37 +++
> > >  arch/s390/purgatory/head.S                     | 279 ++++++++++++++++++
> > >  arch/s390/purgatory/purgatory.c                |  42 +++
> > >  arch/x86/kernel/kexec-bzimage64.c              |   8 +-
> > >  arch/x86/kernel/machine_kexec_64.c             |  66 ++---
> > >  arch/x86/purgatory/Makefile                    |   3 +
> > >  arch/x86/purgatory/purgatory.c                 |   2 +-
> > >  include/linux/kexec.h                          |  38 +--
> > >  {arch/x86/purgatory => include/linux}/sha256.h |  10 +-
> > >  kernel/kexec_file.c                            | 375 ++++++++++++-------------
> > >  {arch/x86/purgatory => lib}/sha256.c           |   4 +-
> > >  24 files changed, 1200 insertions(+), 284 deletions(-)
> > >  create mode 100644 arch/s390/include/asm/purgatory.h
> > >  create mode 100644 arch/s390/kernel/kexec_elf.c
> > >  create mode 100644 arch/s390/kernel/kexec_image.c
> > >  create mode 100644 arch/s390/kernel/machine_kexec_file.c
> > >  create mode 100644 arch/s390/purgatory/Makefile
> > >  create mode 100644 arch/s390/purgatory/head.S
> > >  create mode 100644 arch/s390/purgatory/purgatory.c
> > >  rename {arch/x86/purgatory => include/linux}/sha256.h (63%)
> > >  rename {arch/x86/purgatory => lib}/sha256.c (99%)
> > > 
> > > -- 
> > > 2.13.5
> > > 
> > > 
> > > _______________________________________________
> > > kexec mailing list
> > > kexec@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/kexec  
> > 
> > Thanks
> > Dave
> > 
> 
