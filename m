From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [-next] strace tests fail because of "y2038: socket: Add
 compat_sys_recvmmsg_time64"
Date: Mon, 17 Dec 2018 14:06:47 +0100
Message-ID: <20181217130646.GB3560@osiris>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-next/>
List-Post: <mailto:linux-next@vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Hi Arnd,

in linux-next as of today 16 strace self tests fail on s390. I could
bisect this to b136972b063b ("y2038: socket: Add compat_sys_recvmmsg_time64").

The following tests fail:

mmsg.gen.test
clock.gen.test
regex.gen.test
sched.gen.test
trace_fstatfs.gen.test
trace_personality_regex_64.gen.test
trace_fstat.gen.test
trace_personality_32.gen.test
trace_question.gen.test
trace_personality_regex_32.gen.test
trace_personality_64.gen.test
trace_stat.gen.test
trace_statfs.gen.test
trace_lstat.gen.test
trace_stat_like.gen.test
trace_statfs_like.gen.test

If needed the s390 kernel config can be re-created with

make ARCH=s390 performance_defconfig

strace self tests can be reproduced with

> git clone https://gitlab.com/strace/strace.git
> cd strace
> ./bootstrap
> ./configure
> make
> cd tests
> make check
