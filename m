From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [RFC6 PATCH v6 00/21] ILP32 for ARM64
Date: Fri, 13 May 2016 14:32:12 +0100
Message-ID: <20160513133212.GC27232@e104818-lin.cambridge.arm.com>
References: <1459894127-17698-1-git-send-email-ynorov@caviumnetworks.com>
 <20160512002000.GA30997@yury-N73SV>
 <20160512133533.GF11226@e104818-lin.cambridge.arm.com>
 <20160512134431.GB30205@yury-N73SV>
 <20160512140734.GG11226@e104818-lin.cambridge.arm.com>
 <20160512142457.GC30205@yury-N73SV>
 <20160512152805.GJ11226@e104818-lin.cambridge.arm.com>
 <57358C2B.1010106@huawei.com>
 <20160513092802.GA13400@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160513092802.GA13400@localhost.localdomain>
Sender: linux-doc-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: "Zhangjian (Bamvor)" <bamvor.zhangjian@huawei.com>
Cc: linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, Kefeng Wang <wangkefeng.wang@huawei.com>, arnd@arndb.de, pinskia@gmail.com, Prasun.Kapoor@caviumnetworks.com, heiko.carstens@de.ibm.com, broonie@kernel.org, linux-doc@vger.kernel.org, Nathan_Lynch@mentor.com, linux-kernel@vger.kernel.org, agraf@suse.de, klimov.linux@gmail.com, Yury Norov <ynorov@caviumnetworks.com>, linux-arm-kernel@lists.infradead.org, schwab@suse.de, schwidefsky@de.ibm.com, joseph@codesourcery.com, christoph.muellner@theobroma-systems.com
List-ID: <linux-s390.vger.kernel.org>

On Fri, May 13, 2016 at 09:28:03AM +0000, Catalin Marinas wrote:
> > >>>>>On Thu, May 12, 2016 at 03:20:00AM +0300, Yury Norov wrote:
> > >>>>>>I debugged preadv02 and pwritev02 failures and found very weird bug.
> > >>>>>>Test passes {iovec_base = 0xffffffff, iovec_len = 64} as one element
> > >>>>>>of vector, and kernel reports successful read/write.
[...]
> The discussion is mainly around whether USER_DS for 32-bit compat apps
> should be the same as USER_DS for native 32-bit apps. Even for native
> 32-bit kernels, we don't use STACK_TOP as addr_limit. A read/write from
> 0xffffffff would fail in both cases anyway. I think the LTP test doesn't
> even try to access such memory but only to probe the range validity (I
> haven't managed to build the latest LTP yet).

OK, so I managed to get the latest LTP (tag 20160510) built for AArch32
but the preadv02 does not fail:

-----------------------------
# uname -m
aarch64

# file ./testcases/bin/preadv02
./testcases/bin/preadv02: ELF 32-bit LSB executable, ARM, EABI5 version 1 (SYSV), dynamically linked, interpreter /lib/ld-linux-armhf.so.3, for GNU/Linux 2.6.32, BuildID[sha1]=98066291426e1d3ee49d8504ce2a5bd721ab7fe8, not stripped

# ./testcases/bin/preadv02
preadv02.c:97: PASS: preadv() failed as expected: EINVAL
preadv02.c:97: PASS: preadv() failed as expected: EINVAL
preadv02.c:97: PASS: preadv() failed as expected: EINVAL
preadv02.c:97: PASS: preadv() failed as expected: EFAULT
preadv02.c:97: PASS: preadv() failed as expected: EBADF
preadv02.c:97: PASS: preadv() failed as expected: EBADF
preadv02.c:97: PASS: preadv() failed as expected: EISDIR
preadv02.c:97: PASS: preadv() failed as expected: ESPIPE

Summary:
passed   8
failed   0
skipped  0
warnings 0
-----------------------------

It's the 4th test above which passes iovec_base as -1 and expects
EFAULT. However, it seems to get the expected error. I guess that even
if access_ok() passes, the access to that location by the kernel would
fail since there isn't anything mapped.

With ILP32, however, STACK_TOP is TASK_SIZE and you may have the address
mapped already. I still think the USER_DS fix is useful, though I need
another way to check that it's actually a fix.

-- 
Catalin
