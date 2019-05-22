From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: [PATCH v3 3/3] kselftest: Extend vDSO selftest to clock_getres
Date: Wed, 22 May 2019 13:50:17 +0200
Message-ID: <3a6d9b99-0026-6743-9e73-4880f3cd6b1c@c-s.fr>
References: <20190522110722.28094-1-vincenzo.frascino@arm.com>
 <20190522110722.28094-4-vincenzo.frascino@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <20190522110722.28094-4-vincenzo.frascino@arm.com>
Content-Language: fr
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
To: Vincenzo Frascino <vincenzo.frascino@arm.com>, linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Paul Mackerras <paulus@samba.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Shuah Khan <shuah@kernel.org>
List-ID: <linux-s390.vger.kernel.org>



Le 22/05/2019 à 13:07, Vincenzo Frascino a écrit :
> The current version of the multiarch vDSO selftest verifies only
> gettimeofday.
> 
> Extend the vDSO selftest to clock_getres, to verify that the
> syscall and the vDSO library function return the same information.
> 
> The extension has been used to verify the hrtimer_resoltion fix.
> 
> Cc: Shuah Khan <shuah@kernel.org>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> ---
> 
> Note: This patch is independent from the others in this series, hence it
> can be merged singularly by the kselftest maintainers.
> 
>   tools/testing/selftests/vDSO/Makefile         |   2 +
>   .../selftests/vDSO/vdso_clock_getres.c        | 137 ++++++++++++++++++
>   2 files changed, 139 insertions(+)
>   create mode 100644 tools/testing/selftests/vDSO/vdso_clock_getres.c
> 
> diff --git a/tools/testing/selftests/vDSO/Makefile b/tools/testing/selftests/vDSO/Makefile
> index 9e03d61f52fd..d5c5bfdf1ac1 100644
> --- a/tools/testing/selftests/vDSO/Makefile
> +++ b/tools/testing/selftests/vDSO/Makefile
> @@ -5,6 +5,7 @@ uname_M := $(shell uname -m 2>/dev/null || echo not)
>   ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e s/x86_64/x86/)
>   
>   TEST_GEN_PROGS := $(OUTPUT)/vdso_test
> +TEST_GEN_PROGS += $(OUTPUT)/vdso_clock_getres
>   ifeq ($(ARCH),x86)
>   TEST_GEN_PROGS += $(OUTPUT)/vdso_standalone_test_x86
>   endif
> @@ -18,6 +19,7 @@ endif
>   
>   all: $(TEST_GEN_PROGS)
>   $(OUTPUT)/vdso_test: parse_vdso.c vdso_test.c
> +$(OUTPUT)/vdso_clock_getres: vdso_clock_getres.c
>   $(OUTPUT)/vdso_standalone_test_x86: vdso_standalone_test_x86.c parse_vdso.c
>   	$(CC) $(CFLAGS) $(CFLAGS_vdso_standalone_test_x86) \
>   		vdso_standalone_test_x86.c parse_vdso.c \
> diff --git a/tools/testing/selftests/vDSO/vdso_clock_getres.c b/tools/testing/selftests/vDSO/vdso_clock_getres.c
> new file mode 100644
> index 000000000000..341a9bc34ffc
> --- /dev/null
> +++ b/tools/testing/selftests/vDSO/vdso_clock_getres.c
> @@ -0,0 +1,137 @@
> +// SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note
> +/*
> + * vdso_clock_getres.c: Sample code to test clock_getres.
> + * Copyright (c) 2019 Arm Ltd.
> + *
> + * Compile with:
> + * gcc -std=gnu99 vdso_clock_getres.c
> + *
> + * Tested on ARM, ARM64, MIPS32, x86 (32-bit and 64-bit),
> + * Power (32-bit and 64-bit), S390x (32-bit and 64-bit).
> + * Might work on other architectures.
> + */
> +
> +#define _GNU_SOURCE
> +#include <elf.h>
> +#include <err.h>
> +#include <fcntl.h>
> +#include <stdint.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <time.h>
> +#include <sys/auxv.h>
> +#include <sys/mman.h>
> +#include <sys/time.h>
> +#include <unistd.h>
> +#include <sys/syscall.h>
> +
> +#include "../kselftest.h"
> +
> +static long syscall_clock_getres(clockid_t _clkid, struct timespec *_ts)
> +{
> +	long ret;
> +
> +	ret = syscall(SYS_clock_getres, _clkid, _ts);
> +
> +	return ret;
> +}
> +
> +const char *vdso_clock_name[12] = {
> +	"CLOCK_REALTIME",
> +	"CLOCK_MONOTONIC",
> +	"CLOCK_PROCESS_CPUTIME_ID",
> +	"CLOCK_THREAD_CPUTIME_ID",
> +	"CLOCK_MONOTONIC_RAW",
> +	"CLOCK_REALTIME_COARSE",
> +	"CLOCK_MONOTONIC_COARSE",
> +	"CLOCK_BOOTTIME",
> +	"CLOCK_REALTIME_ALARM",
> +	"CLOCK_BOOTTIME_ALARM",
> +	"CLOCK_SGI_CYCLE",
> +	"CLOCK_TAI",
> +};
> +
> +/*
> + * This function calls clock_getres in vdso and by system call
> + * with different values for clock_id.
> + *
> + * Example of output:
> + *
> + * clock_id: CLOCK_REALTIME [PASS]
> + * clock_id: CLOCK_BOOTTIME [PASS]
> + * clock_id: CLOCK_TAI [PASS]
> + * clock_id: CLOCK_REALTIME_COARSE [PASS]
> + * clock_id: CLOCK_MONOTONIC [PASS]
> + * clock_id: CLOCK_MONOTONIC_RAW [PASS]
> + * clock_id: CLOCK_MONOTONIC_COARSE [PASS]
> + */
> +static inline int vdso_test_clock(unsigned int clock_id)
> +{
> +	struct timespec x, y;
> +
> +	printf("clock_id: %s", vdso_clock_name[clock_id]);
> +	clock_getres(clock_id, &x);
> +	syscall_clock_getres(clock_id, &y);
> +
> +	if ((x.tv_sec != y.tv_sec) || (x.tv_sec != y.tv_sec)) {
> +		printf(" [FAIL]\n");
> +		return KSFT_FAIL;
> +	}
> +
> +	printf(" [PASS]\n");
> +	return 0;
> +}
> +
> +int main(int argc, char **argv)
> +{
> +	int ret;
> +
> +#if _POSIX_TIMERS > 0
> +
> +#ifdef CLOCK_REALTIME

Why do you need that #ifdef and all the ones below ?

CLOCK_REALTIME (and others) is defined in include/uapi/linux/time.h, so 
it should be there when you build the test, shouldn't it ?

> +	ret = vdso_test_clock(CLOCK_REALTIME);
> +	if (ret)
> +		goto out;

Why that goto ? Nothing is done at out, so a 'return ret' would be 
better I think.

And do we really want to stop at first failure ? Wouldn't it be better 
to run all the tests regardless ?

Christophe

> +#endif
> +
> +#ifdef CLOCK_BOOTTIME
> +	ret = vdso_test_clock(CLOCK_BOOTTIME);
> +	if (ret)
> +		goto out;
> +#endif
> +
> +#ifdef CLOCK_TAI
> +	ret = vdso_test_clock(CLOCK_TAI);
> +	if (ret)
> +		goto out;
> +#endif
> +
> +#ifdef CLOCK_REALTIME_COARSE
> +	ret = vdso_test_clock(CLOCK_REALTIME_COARSE);
> +	if (ret)
> +		goto out;
> +#endif
> +
> +#ifdef CLOCK_MONOTONIC
> +	ret = vdso_test_clock(CLOCK_MONOTONIC);
> +	if (ret)
> +		goto out;
> +#endif
> +
> +#ifdef CLOCK_MONOTONIC_RAW
> +	ret = vdso_test_clock(CLOCK_MONOTONIC_RAW);
> +	if (ret)
> +		goto out;
> +#endif
> +
> +#ifdef CLOCK_MONOTONIC_COARSE
> +	ret = vdso_test_clock(CLOCK_MONOTONIC_COARSE);
> +	if (ret)
> +		goto out;
> +#endif
> +
> +#endif
> +
> +out:
> +	return ret;
> +}
> 
