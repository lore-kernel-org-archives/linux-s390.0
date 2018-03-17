Date: Sat, 17 Mar 2018 15:32:50 +0800
From: Fengguang Wu <fengguang.wu@intel.com>
Subject: Re: [Y2038] [PATCH v4 02/10] include: Move compat_timespec/ timeval
 to compat_time.h
Message-ID: <20180317073250.6qfmyv45hc2jmyk4@wfg-t540p.sh.intel.com>
References: <20180312175307.11032-3-deepa.kernel@gmail.com>
 <201803132313.a4R8Y434%fengguang.wu@intel.com>
 <CABeXuvqNKfuvffU24Xydixv6Ro8R=2nAH4bruzx0AW=ax-6yOQ@mail.gmail.com>
 <CAK8P3a1fxWAK94GH0cpzh6CHXgL4uJuDNCGpdJen5ib1HH1xoA@mail.gmail.com>
 <CABeXuvpFfD+a6tSSOvni=v23DuJ-bWeZwmnzg4SU+TR=WHxs7Q@mail.gmail.com>
 <CAK8P3a1p1PruO_KsiE-sGAZdmoAVi2E3zZ+SXMzU=AZsb-RY-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAK8P3a1p1PruO_KsiE-sGAZdmoAVi2E3zZ+SXMzU=AZsb-RY-A@mail.gmail.com>
Return-Path: <fengguang.wu@intel.com>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
List-Archive: <https://lore.kernel.org/linux-mips/>
List-Post: <mailto:linux-mips@vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Deepa Dinamani <deepa.kernel@gmail.com>, kbuild test robot <lkp@intel.com>, Mark Rutland <mark.rutland@arm.com>, "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>, Peter Zijlstra <peterz@infradead.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, sparclinux <sparclinux@vger.kernel.org>, devel@driverdev.osuosl.org, linux-s390 <linux-s390@vger.kernel.org>, y2038 Mailman List <y2038@lists.linaro.org>, Michael Ellerman <mpe@ellerman.id.au>, Helge Deller <deller@gmx.de>, the arch/x86 maintainers <x86@kernel.org>, sebott@linux.vnet.ibm.com, "James E.J. Bottomley" <jejb@parisc-linux.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Ingo Molnar <mingo@redhat.com>, oprofile-list@lists.sf.net, Catalin Marinas <catalin.marinas@arm.com>, Peter Oberparleiter <oberpar@linux.vnet.ibm.com>, Robert Richter <rric@kernel.org>, Chris Metcalf <cmetcalf@mellanox.com>, Will Deacon <will.deacon@arm.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Julian Wiedmann <jwi@linux.vnet.ibm.com>, John Stultz <john.stultz@linaro.org>, Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>, gerald.schaefer@de.ibm.com, Parisc List <linux-parisc@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>, cohuck@redhat.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ralf Baechle <ralf@linux-mips.org>, "David S. Miller" <davem@davemloft.net>, Jan Hoeppner <hoeppner@linux.vnet.ibm.com>, kbuild-all@01.org, Stefan Haberland <sth@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Ursula Braun <ubraun@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Thu, Mar 15, 2018 at 09:04:04AM +0100, Arnd Bergmann wrote:
>On Thu, Mar 15, 2018 at 3:51 AM, Deepa Dinamani <deepa.kernel@gmail.com> wrote:
>> On Wed, Mar 14, 2018 at 1:52 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>>> On Wed, Mar 14, 2018 at 4:50 AM, Deepa Dinamani <deepa.kernel@gmail.com> wrote:
>>>> The file arch/arm64/kernel/process.c needs asm/compat.h also to be
>>>> included directly since this is included conditionally from
>>>> include/compat.h. This does seem to be typical of arm64 as I was not
>>>> completely able to get rid of asm/compat.h includes for arm64 in this
>>>> series. My plan is to have separate patches to get rid of asm/compat.h
>>>> includes for the architectures that are not straight forward to keep
>>>> this series simple.
>>>> I will fix this and update the series.
>>>>
>>>
>>> I ran across the same thing in two more files during randconfig testing on
>>> arm64 now, adding this fixup on top for the moment, but maybe there
>>> is a better way:
>>
>> I was looking at how Al tested his uaccess patches:
>> https://www.spinics.net/lists/linux-fsdevel/msg108752.html
>>
>> He seems to be running the kbuild bot tests on his own git.
>> Is it possible to verify it this way on the 2038 tree? Or, I could
>> host a tree also.
>
>The kbuild bot should generally pick up any branch on git.kernel.org,
>and the patches sent to the mailing list. It tests a lot of things
>configurations, but I tend to find some things that it doesn't find
>by doing lots of randconfig builds on fewer target architectures
>(I only build arm, arm64 and x86 regularly).
>
>I remember that there was some discussion about a method
>to get the bot to test other branches (besides asking Fengguang
>to add it manually), but I don't remember what came out of that.

People can send email to me or lkp@intel.com for adding new git URLs
to 0day tests. Such requests are very welcome. Server load is not a
problem -- don't worry about your git pushes adding our test load.
By default all branches in a git tree will be tested, unless there are
explicit blacklist/whitelist.

We also have scripts to scan git.kernel.org/github/LKML looking for
possible new git URLs to add to 0day kbuild tests. However depending
on the team's maintenance pressure they may or may not run frequently.

Thanks,
Fengguang
