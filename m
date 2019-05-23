From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: [PATCH v4 0/3] Fix vDSO clock_getres()
Date: Thu, 23 May 2019 12:21:13 +0100
Message-ID: <20190523112116.19233-1-vincenzo.frascino@arm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Paul Mackerras <paulus@samba.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, vincenzo.frascino@arm.com, Shuah Khan <shuah@kernel.org>
List-ID: <linux-s390.vger.kernel.org>

clock_getres in the vDSO library has to preserve the same behaviour
of posix_get_hrtimer_res().

In particular, posix_get_hrtimer_res() does:
    sec = 0;
    ns = hrtimer_resolution;
and hrtimer_resolution depends on the enablement of the high
resolution timers that can happen either at compile or at run time.

A possible fix is to change the vdso implementation of clock_getres,
keeping a copy of hrtimer_resolution in vdso data and using that
directly [1].

This patchset implements the proposed fix for arm64, powerpc, s390,
nds32 and adds a test to verify that the syscall and the vdso library
implementation of clock_getres return the same values.

Even if these patches are unified by the same topic, there is no
dependency between them, hence they can be merged singularly by each
arch maintainer.

Note: arm64 and nds32 respective fixes have been merged in 5.2-rc1,
hence they have been removed from this series.

[1] https://marc.info/?l=linux-arm-kernel&m=155110381930196&w=2

Changes:
--------
v4:
  - Address review comments.
v3:
  - Rebased on 5.2-rc1.
  - Address review comments.
v2:
  - Rebased on 5.1-rc5.
  - Addressed review comments.

Cc: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

Vincenzo Frascino (3):
  powerpc: Fix vDSO clock_getres()
  s390: Fix vDSO clock_getres()
  kselftest: Extend vDSO selftest to clock_getres

 arch/powerpc/include/asm/vdso_datapage.h      |   2 +
 arch/powerpc/kernel/asm-offsets.c             |   2 +-
 arch/powerpc/kernel/time.c                    |   1 +
 arch/powerpc/kernel/vdso32/gettimeofday.S     |   7 +-
 arch/powerpc/kernel/vdso64/gettimeofday.S     |   7 +-
 arch/s390/include/asm/vdso.h                  |   1 +
 arch/s390/kernel/asm-offsets.c                |   2 +-
 arch/s390/kernel/time.c                       |   1 +
 arch/s390/kernel/vdso32/clock_getres.S        |  12 +-
 arch/s390/kernel/vdso64/clock_getres.S        |  10 +-
 tools/testing/selftests/vDSO/Makefile         |   2 +
 .../selftests/vDSO/vdso_clock_getres.c        | 124 ++++++++++++++++++
 12 files changed, 155 insertions(+), 16 deletions(-)
 create mode 100644 tools/testing/selftests/vDSO/vdso_clock_getres.c

-- 
2.21.0
