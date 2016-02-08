From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH v5 0/3] kallsyms base relative series
Date: Mon,  8 Feb 2016 18:57:45 +0100
Message-ID: <1454954268-3225-1-git-send-email-ard.biesheuvel@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, x86@kernel.org, keescook@chromium.org, akpm@linux-foundation.org, mingo@kernel.org, hpa@zytor.com, heiko.carstens@de.ibm.com, benh@kernel.crashing.org, mpe@ellerman.id.au, mmarek@suse.cz, rusty@rustcorp.com.au, arnd@arndb.de, linux-arch@vger.kernel.org, linux@roeck-us.net
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
List-ID: <linux-s390.vger.kernel.org>

This is v5 of my kallsyms base relative series, which addresses some issues
reported on 32-bit architectures (ARM and Blackfin) and Tile-GX (64-bit)
 
Changes since v4:
- use a Kconfig symbol KALLSYMS_ABSOLUTE_PERCPU and set its default
  as appropriate rather than testing for X86_64 and SMP directly in
  scripts/link-vmlinux.sh (#1)
- only split the 32-bit kallsyms symbol address space into 2 GB for absolute
  symbols and 2 GB for relative symbols if --absolute-percpu is in effect;
  this should fix all reported issues on 32-bit architectures (including the
  pathological cases involving XIP_KERNEL and VMSPLIT_1G on ARM), since absolute
  per-cpu symbols are only used on SMP x86_64 anyway (#3)
- disable the base relative kallsyms feature for 64-bit Tile: as it turns out,
  this architecture cannot support it due to the way its symbols are laid out.
- remove the relative base check against kernel_start_addr; this is no longer
  needed now that we have 4 GB of symbol address space (#3)

Patch #2 is unchanged between v4 and v5

--- v4 blurb ---
Patch #1 fixes the scripts/kallsyms invocation to only pass the x86_64
specific --absolute-percpu option if CONFIG_SMP is also set.

Patch #2 reworks the absolute percpu code to only emit those percpu symbols
as absolute, and not symbols that have been classified as 'A' (absolute) by
the linker, since that does not mean quite the same thing.

Patch #3 is the original kallsyms base relative patch, with some
modifications:
- folded the s/ULLONG_MAX/-1ULL? change made by Andrew
- ensured that the kallsyms_relative_base value itself is relocated as
  required.
- dropped all of the acks and other tags, as they have become outdated with
  the recent changes to this patch.

Ard Biesheuvel (3):
  x86: kallsyms: disable absolute percpu symbols on !SMP
  kallsyms: don't overload absolute symbol type for percpu symbols
  kallsyms: add support for relative offsets in kallsyms address table

 init/Kconfig            |  22 +++++
 kernel/kallsyms.c       |  42 ++++++--
 scripts/kallsyms.c      | 103 +++++++++++++++++---
 scripts/link-vmlinux.sh |   6 +-
 scripts/namespace.pl    |   2 +
 5 files changed, 153 insertions(+), 22 deletions(-)

-- 
2.5.0
