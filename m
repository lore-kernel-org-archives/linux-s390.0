Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Philipp Rudo <prudo@linux.vnet.ibm.com>
Subject: [PATCH 00/17] Add kexec_file_load support to s390
Date: Mon, 12 Feb 2018 11:07:37 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-Id: <20180212100754.55121-1-prudo@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: kexec@lists.infradead.org, linux-s390@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>, Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hi everybody

resending the series as there was no reaction, yet. Furthermore i was told
that Andrew and the x86 list should also be CCed, so welcome.

No changes made to the patches since first time i sent them. The patches
apply to the current master (v4.16-rc1).

Thanks
Philipp

---

this series adds the kexec_file_load system call to s390. Before the system
call is added there are some preparations/clean ups to common
kexec_file_load. In detail this series contains:

Patch #1&2: Minor cleanups/fixes.

Patch #3-9: Clean up the purgatory load/relocation code. Especially remove
the mis-use of the purgatory_info->sechdrs->sh_offset field, currently
holding a pointer into either kexec_purgatory (ro) or purgatory_buf (rw)
depending on the section. With these patches the section address will be
calculated verbosely and sh_offset will contain the offset of the section
in the stripped purgatory binary (purgatory_buf).

Patch #10: Allows architectures to set the purgaory load address. This
patch is important for s390 as the kernel and purgatory have to be loaded
to fixed addresses. In current code this is impossible as the purgatory
load is opaque to the architecture.

Patch #11: Moves x86 purgatories sha implementation to common lib/
directory.

Patches #12-17 finally adds the kexec_file_load system call to s390.

Please note that I had to touch arch code for x86 and power a little. In
theory this should not change the behavior but I don't have a way to test
it. Cross-compiling with defconfig(*) works fine for both.

Thanks
Philipp

(*) On x86 with the orc unwinder turned off. objtool SEGFAULTs on s390...

Philipp Rudo (17):
  kexec_file: Silence compile warnings
  kexec_file: Remove checks in kexec_purgatory_load
  kexec_file: Make purgatory_info->ehdr const
  kexec_file: Search symbols in read-only kexec_purgatory
  kexec_file: Use read-only sections in arch_kexec_apply_relocations*
  kexec_file: Split up __kexec_load_puragory
  kexec_file: Simplify kexec_purgatory_setup_sechdrs 1
  kexec_file: Simplify kexec_purgatory_setup_sechdrs 2
  kexec_file: Remove mis-use of sh_offset field
  kexec_file: Allow archs to set purgatory load address
  kexec_file: Move purgatories sha256 to common code
  s390/kexec_file: Prepare setup.h for kexec_file_load
  s390/kexec_file: Add purgatory
  s390/kexec_file: Add kexec_file_load system call
  s390/kexec_file: Add image loader
  s390/kexec_file: Add crash support to image loader
  s390/kexec_file: Add ELF loader

 arch/powerpc/kernel/kexec_elf_64.c             |   9 +-
 arch/s390/Kbuild                               |   1 +
 arch/s390/Kconfig                              |   4 +
 arch/s390/include/asm/kexec.h                  |  23 ++
 arch/s390/include/asm/purgatory.h              |  17 ++
 arch/s390/include/asm/setup.h                  |  40 ++-
 arch/s390/kernel/Makefile                      |   1 +
 arch/s390/kernel/asm-offsets.c                 |   5 +
 arch/s390/kernel/compat_wrapper.c              |   1 +
 arch/s390/kernel/kexec_elf.c                   | 149 ++++++++++
 arch/s390/kernel/kexec_image.c                 |  78 +++++
 arch/s390/kernel/machine_kexec_file.c          | 291 +++++++++++++++++++
 arch/s390/kernel/syscalls/syscall.tbl          |   1 +
 arch/s390/purgatory/Makefile                   |  37 +++
 arch/s390/purgatory/head.S                     | 279 ++++++++++++++++++
 arch/s390/purgatory/purgatory.c                |  42 +++
 arch/x86/kernel/kexec-bzimage64.c              |   8 +-
 arch/x86/kernel/machine_kexec_64.c             |  66 ++---
 arch/x86/purgatory/Makefile                    |   3 +
 arch/x86/purgatory/purgatory.c                 |   2 +-
 include/linux/kexec.h                          |  38 +--
 {arch/x86/purgatory => include/linux}/sha256.h |  10 +-
 kernel/kexec_file.c                            | 375 ++++++++++++-------------
 {arch/x86/purgatory => lib}/sha256.c           |   4 +-
 24 files changed, 1200 insertions(+), 284 deletions(-)
 create mode 100644 arch/s390/include/asm/purgatory.h
 create mode 100644 arch/s390/kernel/kexec_elf.c
 create mode 100644 arch/s390/kernel/kexec_image.c
 create mode 100644 arch/s390/kernel/machine_kexec_file.c
 create mode 100644 arch/s390/purgatory/Makefile
 create mode 100644 arch/s390/purgatory/head.S
 create mode 100644 arch/s390/purgatory/purgatory.c
 rename {arch/x86/purgatory => include/linux}/sha256.h (63%)
 rename {arch/x86/purgatory => lib}/sha256.c (99%)

-- 
2.13.5
