Return-Path: <linux-arch-owner@vger.kernel.org>
From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH RFC 0/5] cpu/speculation: Add 'cpu_spec_mitigations=' cmdline options
Date: Thu,  4 Apr 2019 11:44:10 -0500
Message-ID: <cover.1554396090.git.jpoimboe@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20190404164410.FyWPYQnV_AC5qVM5C3Jcx1ysIg_8piJ6yY46gIDHjZU@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Jiri Kosina <jikos@kernel.org>, Waiman Long <longman@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>, Jon Masters <jcm@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tyler Hicks <tyhicks@canonical.com>, Linus Torvalds <torvalds@linux-foundation.org>
List-ID: <linux-s390.vger.kernel.org>

Keeping track of the number of mitigations for all the CPU speculation
bugs has become overwhelming for many users.  It's getting more and more
complicated to decide which mitigations are needed for a given
architecture.  Complicating matters is the fact that each arch tends to
it own custom way to mitigate the same vulnerability.

Most users fall into a few basic categories:

a) they want all CPU speculation mitigations off;

b) they want all reasonable mitigations on, with SMT enabled even if
   it's vulnerable; or

c) they want all reasonable mitigations on, with SMT disabled if
   vulnerable.

Define a set of curated, arch-independent options, each of which is an
aggregation of existing options:

- cpu_spec_mitigations=off: Disable all mitigations.

- cpu_spec_mitigations=auto: [default] Enable all the default
  mitigations, but leave SMT enabled, even if it's vulnerable.

- cpu_spec_mitigations=auto,nosmt: Enable all the default mitigations,
  disabling SMT if needed by a mitigation.


Josh Poimboeuf (5):
  cpu/speculation: Add 'cpu_spec_mitigations=' cmdline options
  x86/speculation: Add support for 'cpu_spec_mitigations=' cmdline
    options
  powerpc/speculation: Add support for 'cpu_spec_mitigations=' cmdline
    options
  s390/speculation: Add support for 'cpu_spec_mitigations=' cmdline
    options
  arm64/speculation: Add support for 'cpu_spec_mitigations=' cmdline
    options

 .../admin-guide/kernel-parameters.txt         | 42 +++++++++++++++++++
 arch/arm64/kernel/cpu_errata.c                |  4 ++
 arch/arm64/kernel/cpufeature.c                |  6 +++
 arch/powerpc/kernel/security.c                |  6 +--
 arch/powerpc/kernel/setup_64.c                |  2 +-
 arch/s390/kernel/nospec-branch.c              |  4 +-
 arch/x86/include/asm/processor.h              |  1 +
 arch/x86/kernel/cpu/bugs.c                    | 32 ++++++++++++--
 arch/x86/kvm/vmx/vmx.c                        |  2 +
 arch/x86/mm/pti.c                             |  4 +-
 include/linux/cpu.h                           |  8 ++++
 kernel/cpu.c                                  | 15 +++++++
 12 files changed, 116 insertions(+), 10 deletions(-)

-- 
2.17.2
