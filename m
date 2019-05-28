Return-Path: <linux-kselftest-owner@vger.kernel.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v4 3/3] kselftest: Extend vDSO selftest to clock_getres
In-Reply-To: <20190523112116.19233-4-vincenzo.frascino@arm.com>
References: <20190523112116.19233-1-vincenzo.frascino@arm.com> <20190523112116.19233-4-vincenzo.frascino@arm.com>
Date: Tue, 28 May 2019 16:19:21 +1000
Message-ID: <87lfyrp0d2.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kselftest-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>, linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: Christophe Leroy <christophe.leroy@c-s.fr>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Arnd Bergmann <arnd@arndb.de>

Vincenzo Frascino <vincenzo.frascino@arm.com> writes:

> The current version of the multiarch vDSO selftest verifies only
> gettimeofday.
>
> Extend the vDSO selftest to clock_getres, to verify that the
> syscall and the vDSO library function return the same information.
>
> The extension has been used to verify the hrtimer_resoltion fix.

This is passing for me even without patch 1 applied, shouldn't it fail
without the fix? What am I missing?

# uname -r
5.2.0-rc2-gcc-8.2.0

# ./vdso_clock_getres
clock_id: CLOCK_REALTIME [PASS]
clock_id: CLOCK_BOOTTIME [PASS]
clock_id: CLOCK_TAI [PASS]
clock_id: CLOCK_REALTIME_COARSE [PASS]
clock_id: CLOCK_MONOTONIC [PASS]
clock_id: CLOCK_MONOTONIC_RAW [PASS]
clock_id: CLOCK_MONOTONIC_COARSE [PASS]

cheers

> Cc: Shuah Khan <shuah@kernel.org>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> ---
>
> Note: This patch is independent from the others in this series, hence it
> can be merged singularly by the kselftest maintainers.
>
>  tools/testing/selftests/vDSO/Makefile         |   2 +
>  .../selftests/vDSO/vdso_clock_getres.c        | 124 ++++++++++++++++++
>  2 files changed, 126 insertions(+)
>  create mode 100644 tools/testing/selftests/vDSO/vdso_clock_getres.c
