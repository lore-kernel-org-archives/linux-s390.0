Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FC6E215055;
	Tue,  3 Mar 2026 15:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772550539; cv=none; b=GlNu7849/EUEO1mbcw5ccx9iz/268Dre1bb/QPphzVRmX4JMbTDvbD2FMCtsQZrtD2egWeInXnFSaLOdsuvXRREYE+KlYCUaawNuSvLJFIgxXm7+5T3OjJGUuvaUP+VzNhU73AM6nZUkZ/snHExd41hpxFZr0XeNFnHLsis2aYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772550539; c=relaxed/simple;
	bh=3I4tZwfO6MPOA16PwtFKDqQCUHl8VFhQU/V50+AVB7k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KC2zB1zIr/4tryzjI6rhTDglKBR3+zYe3nqF5fVlhXkl4p0LICxz0H6/zQJCVPc5a80RrxHyqcEJlem8Qd2Tlh92kjSfMs5mbfJ1yIfv3zGZHWOs2ROZ5W9CRTAbC7RPoBSjs30o016OBtWlecv8GP31+xWS5vZuoGUhll0KjaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 36D46339;
	Tue,  3 Mar 2026 07:08:49 -0800 (PST)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5C1D23F73B;
	Tue,  3 Mar 2026 07:08:51 -0800 (PST)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Mark Rutland <mark.rutland@arm.com>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Jeremy Linton <jeremy.linton@arm.com>,
	David Laight <david.laight.linux@gmail.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v5 0/2] Fix bugs and performance of kstack offset randomisation
Date: Tue,  3 Mar 2026 15:08:37 +0000
Message-ID: <20260303150840.3789438-1-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[Kees; I'm hoping this is now good-to-go via your hardening tree? It would be
good to get some linux-next testing.]

Hi All,

As I reported at [1], kstack offset randomisation suffers from a couple of bugs
and, on arm64 at least, the performance is poor. This series attempts to fix
both; patch 1 provides back-portable fixes for the functional bugs. Patch 2
proposes a performance improvement approach.

I've looked at a few different options but ultimately decided that Jeremy's
original prng approach is the fastest. I made the argument that this approach is
secure "enough" in the RFC [2] and the responses indicated agreement.

More details in the commit logs.


Performance
===========

Mean and tail performance of 3 "small" syscalls was measured. syscall was made
10 million times and each individually measured and binned. These results have
low noise so I'm confident that they are trustworthy.

The baseline is v6.18-rc5 with stack randomization turned *off*. So I'm showing
performance cost of turning it on without any changes to the implementation,
then the reduced performance cost of turning it on with my changes applied.

**NOTE**: The below results were generated using the RFC patches but there is no
meaningful change, so the numbers are still valid. I've also rerun the tests
with this version on top of v7.0-rc2 on arm64 and confirmed simialr results.

arm64 (AWS Graviton3):
+-----------------+--------------+-------------+---------------+
| Benchmark       | Result Class |   v6.18-rc5 |  per-cpu-prng |
|                 |              | rndstack-on |               |
|                 |              |             |               |
+=================+==============+=============+===============+
| syscall/getpid  | mean (ns)    |  (R) 15.62% |     (R) 3.43% |
|                 | p99 (ns)     | (R) 155.01% |     (R) 3.20% |
|                 | p99.9 (ns)   | (R) 156.71% |     (R) 2.93% |
+-----------------+--------------+-------------+---------------+
| syscall/getppid | mean (ns)    |  (R) 14.09% |     (R) 2.12% |
|                 | p99 (ns)     | (R) 152.81% |         1.55% |
|                 | p99.9 (ns)   | (R) 153.67% |         1.77% |
+-----------------+--------------+-------------+---------------+
| syscall/invalid | mean (ns)    |  (R) 13.89% |     (R) 3.32% |
|                 | p99 (ns)     | (R) 165.82% |     (R) 3.51% |
|                 | p99.9 (ns)   | (R) 168.83% |     (R) 3.77% |
+-----------------+--------------+-------------+---------------+

Because arm64 was previously using get_random_u16(), it was expensive when it
didn't have any buffered bits and had to call into the crng. That's what caused
the enormous tail latency.


x86 (AWS Sapphire Rapids):
+-----------------+--------------+-------------+---------------+
| Benchmark       | Result Class |   v6.18-rc5 |  per-cpu-prng |
|                 |              | rndstack-on |               |
|                 |              |             |               |
+=================+==============+=============+===============+
| syscall/getpid  | mean (ns)    |  (R) 13.32% |     (R) 4.60% |
|                 | p99 (ns)     |  (R) 13.38% |    (R) 18.08% |
|                 | p99.9 (ns)   |      16.26% |    (R) 19.38% |
+-----------------+--------------+-------------+---------------+
| syscall/getppid | mean (ns)    |  (R) 11.96% |     (R) 5.26% |
|                 | p99 (ns)     |  (R) 11.83% |     (R) 8.35% |
|                 | p99.9 (ns)   |  (R) 11.42% |    (R) 22.37% |
+-----------------+--------------+-------------+---------------+
| syscall/invalid | mean (ns)    |  (R) 10.58% |     (R) 2.91% |
|                 | p99 (ns)     |  (R) 10.51% |     (R) 4.36% |
|                 | p99.9 (ns)   |  (R) 10.35% |    (R) 21.97% |
+-----------------+--------------+-------------+---------------+

I was surprised to see that the baseline cost on x86 is 10-12% since it is just
using rdtsc. But as I say, I believe the results are accurate.


Changes since v4 [5]
====================

- Moved add_random_kstack_offset() later in syscall entry code for powerpc, s390
  and x86. On these platforms it was previously within noinstr sections but for
  some exotic Kconfigs, [get|put]_cpu_var() was calling out to instrumentable
  code. (reported by kernel test robot)
- Removed what was previously patch 2 (inline version of prandom_u32_state()).
  With the above change, there is no longer an issue with calling the
  out-of-line version.

Changes since v3 [4]
====================

- Patch 1: Fixed typo in commit log (per David L)
- Patch 2: Reinstated prandom_u32_state() as out-of-line function, which
  forwards to inline version (per David L)
- Patch 3: Added supplementary info about benefits of removing
  choose_random_kstack_offset() (per Mark R)

Changes since v2 [3]
====================

- Moved late_initcall() to initialize kstack_rnd_state out of
  randomize_kstack.h and into main.c. (issue noticed by kernel test robot)

Changes since v1 (RFC) [2]
==========================

- Introduced patch 2 to make prandom_u32_state() __always_inline (needed since
  its called from noinstr code)
- In patch 3, prng is now per-cpu instead of per-task (per Ard)


[1] https://lore.kernel.org/all/dd8c37bc-795f-4c7a-9086-69e584d8ab24@arm.com/
[2] https://lore.kernel.org/all/20251127105958.2427758-1-ryan.roberts@arm.com/
[3] https://lore.kernel.org/all/20251215163520.1144179-1-ryan.roberts@arm.com/
[4] https://lore.kernel.org/all/20260102131156.3265118-1-ryan.roberts@arm.com/
[5] https://lore.kernel.org/all/20260119130122.1283821-1-ryan.roberts@arm.com

Thanks,
Ryan


Ryan Roberts (2):
  randomize_kstack: Maintain kstack_offset per task
  randomize_kstack: Unify random source across arches

 arch/Kconfig                         |  5 ++-
 arch/arm64/kernel/syscall.c          | 11 ------
 arch/loongarch/kernel/syscall.c      | 11 ------
 arch/powerpc/kernel/syscall.c        | 16 ++-------
 arch/riscv/kernel/traps.c            | 12 -------
 arch/s390/include/asm/entry-common.h |  8 -----
 arch/s390/kernel/syscall.c           |  2 +-
 arch/x86/entry/syscall_32.c          |  4 +--
 arch/x86/entry/syscall_64.c          |  2 +-
 arch/x86/include/asm/entry-common.h  | 12 -------
 include/linux/randomize_kstack.h     | 54 +++++++++++-----------------
 init/main.c                          |  9 ++++-
 kernel/fork.c                        |  1 +
 13 files changed, 37 insertions(+), 110 deletions(-)

--
2.43.0

