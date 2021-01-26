Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 26 Jan 2021 14:24:26 +0530
Message-ID: <CA+G9fYuWbKX6o1HS-9vAs4PHQKhv0d33V6x0TZ6_UHVy6yp-qA@mail.gmail.com>
Subject: s390: syscall.c:165:3: error: implicit declaration of function 'sched_resched_local_allow'
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-s390.vger.kernel.org>
To: Linux-Next Mailing List <linux-next@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, linux-s390@vger.kernel.org, lkft-triage@lists.linaro.org
Cc: hca@linux.ibm.com, gor@linux.ibm.com, Christian Borntraeger <borntraeger@de.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Stephen Rothwell <sfr@canb.auug.org.au>

s390 build failed on Linux next 20210125 due to below error and suspected patch.

make --silent --keep-going --jobs=8
O=/home/tuxbuild/.cache/tuxmake/builds/1/tmp ARCH=s390
CROSS_COMPILE=s390x-linux-gnu- 'CC=sccache s390x-linux-gnu-gcc'
'HOSTCC=sccache gcc'
arch/s390/kernel/syscall.c: In function '__do_syscall':
arch/s390/kernel/syscall.c:165:3: error: implicit declaration of
function 'sched_resched_local_allow'
[-Werror=implicit-function-declaration]
  165 |   sched_resched_local_allow();
      |   ^~~~~~~~~~~~~~~~~~~~~~~~~
cc1: some warnings being treated as errors

Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>

Link to suspected patch,
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/arch/s390/kernel/syscall.c?id=29819dc5f5e3dbb1770ee2062140b6566755ba00

-- 
Linaro LKFT
https://lkft.linaro.org
