From: Szabolcs Nagy <szabolcs.nagy@arm.com>
Subject: Re: [PATCH v6 00/21] ILP32 for ARM64
Date: Wed, 25 May 2016 11:42:04 +0100
Message-ID: <5745817C.1070406@arm.com>
References: <1464048292-30136-1-git-send-email-ynorov@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1464048292-30136-1-git-send-email-ynorov@caviumnetworks.com>
Sender: linux-doc-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Yury Norov <ynorov@caviumnetworks.com>, arnd@arndb.de, catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, libc-alpha@sourceware.org
Cc: nd@arm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, pinskia@gmail.com, broonie@kernel.org, joseph@codesourcery.com, christoph.muellner@theobroma-systems.com, bamvor.zhangjian@huawei.com, klimov.linux@gmail.com, Nathan_Lynch@mentor.com, agraf@suse.de, Prasun.Kapoor@caviumnetworks.com, kilobyte@angband.pl, geert@linux-m68k.org, philipp.tomsich@theobroma-systems.com
List-ID: <linux-s390.vger.kernel.org>

On 24/05/16 01:04, Yury Norov wrote:
> This version is based on kernel v4.6.
> It works with glibc-2.23, and tested with LTP.
> 
...
> ILP32 glibc branch is available here:
> https://github.com/norov/glibc/tree/ilp32-2.23
> 
> It is tested with this series with no major downsides. I will send it to 
> glibc-alpha soon, after final revise. Please review and comment it as well.

i spotted one __ilp32__ vs __ILP32__ typo in the glibc code,
i can review it in detail when there is a cleaned up patch set.

in general the approach seems ok, the ugly part is when lp64
and ilp32 share code, but ilp32 needs some tweaks compared to
the current code (e.g. x vs w regs in asm, long changed to
long long in syscalls, different relocations etc) those will
be hard to review. the naming is sometimes _be_ilp32 sometimes
ilp32_be, but let's hope there will be no new abi variant to
confuse this further.
