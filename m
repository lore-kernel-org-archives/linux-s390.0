Return-Path: <linux-arch-owner@vger.kernel.org>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH v2 0/8] add support for relative references in jump tables
Date: Mon,  2 Jul 2018 20:11:37 +0200
Message-ID: <20180702181145.4799-1-ard.biesheuvel@linaro.org>
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20180702181137.1GNoTtyhYKV0FTlGx-R-wzdvJ04xFkCq8SjWoCjJCE0@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Kees Cook <keescook@chromium.org>, Will Deacon <will.deacon@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Catalin Marinas <catalin.marinas@arm.com>, Ingo Molnar <mingo@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Jessica Yu <jeyu@kernel.org>, Peter Zijlstra <peterz@infradead.org>
List-ID: <linux-s390.vger.kernel.org>

This series implements support for emitting the data structures associated
with jump tables as 32-bit relative references instead of absolute
references, which take up more space on builds that target 64-bit
architectures, or implement self relocation [or both].

This series enables it for arm64 and x86, although other architectures
might benefit as well.

Patch #1 does some preparatory refactoring before patch #2 introduces the
generic pieces required for using relative references.

Patch #3 wires everything up for arm64.

Patch #4 introduces support for handling 64-bit place relative relocations
on x86_64 (see 'Changes since v1' below)

For x86, patch #5 applies some preparatory changes for the arch specific
jump label C code, which is a lot more involved than on arm64, which is
why it is split off in this case. Patch #6 wires it up for x86 as well.

Patch #7 and #8 implement the changes so that the jump_entry arrays reside
in ro_after_init memory rather than remain fully writable all of the time.

Changes since v1:
- change the relative reference to the static key to a 64-bit wide one on 64
  bit architectures; this is necessary on arm64, which allows modules to
  reside anywhere within a 4 GB window covering the core kernel text, which
  means a 32-bit signed quantity with its +/- 2 GB range is insufficient.
  Note that x86_64 changes are in preparation that widen the relocation
  range as well (using the PIE linker), so I assumed that the same change
  is appropriate for x86 as well.
- add patch #4 to handle the relocations emitted by the compiler as a result
  of the change above
- added patches to move the jump_entry arrays to ro_after_init memory, so
  that they are not as easily corrupted or manipulated.
- add Will's ack to patch #3

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Ingo Molnar <mingo@redhat.com> 
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Jessica Yu <jeyu@kernel.org> 
Cc: Peter Zijlstra <peterz@infradead.org>

Ard Biesheuvel (8):
  kernel/jump_label: abstract jump_entry member accessors
  kernel/jump_label: implement generic support for relative references
  arm64/kernel: jump_label: switch to relative references
  x86: add support for 64-bit place relative relocations
  x86: jump_label: switch to jump_entry accessors
  x86/kernel: jump_table: use relative references
  jump_label: annotate entries that operate on __init code earlier
  jump_table: move entries into ro_after_init region

 arch/Kconfig                        |   3 +
 arch/arm/kernel/vmlinux-xip.lds.S   |   1 +
 arch/arm64/Kconfig                  |   1 +
 arch/arm64/include/asm/jump_label.h |  36 ++++---
 arch/arm64/kernel/jump_label.c      |   6 +-
 arch/s390/kernel/vmlinux.lds.S      |   1 +
 arch/x86/Kconfig                    |   1 +
 arch/x86/include/asm/elf.h          |   1 +
 arch/x86/include/asm/jump_label.h   |  24 ++---
 arch/x86/kernel/jump_label.c        |  62 +++++-------
 arch/x86/kernel/machine_kexec_64.c  |   4 +
 arch/x86/kernel/module.c            |   6 ++
 arch/x86/tools/relocs.c             |  10 ++
 include/asm-generic/vmlinux.lds.h   |  11 ++-
 include/linux/jump_label.h          |  65 ++++++++++++-
 init/main.c                         |   1 -
 kernel/jump_label.c                 | 100 +++++++++-----------
 kernel/module.c                     |   9 ++
 tools/objtool/special.c             |   4 +-
 19 files changed, 205 insertions(+), 141 deletions(-)

-- 
2.17.1
