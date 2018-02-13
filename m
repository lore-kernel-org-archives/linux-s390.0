Return-Path: <keescook@google.com>
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <20180213103213.GP3443@dhcp22.suse.cz>
References: <20180212133731.GE3443@dhcp22.suse.cz>
 <87r2ppvaeq.fsf@concordia.ellerman.id.au>
 <CAGXu5j+DnkUv9pZn93wxA6_2s+c3Ap_Q34OR0weY7Y9MJ1aP9Q@mail.gmail.com>
 <87d1192nzc.fsf@concordia.ellerman.id.au>
 <20180213103213.GP3443@dhcp22.suse.cz>
From: Kees Cook <keescook@chromium.org>
Date: Tue, 13 Feb 2018 13:27:30 -0800
Message-ID: <CAGXu5jJZROQMxzxu+Dp3mVMktSg-oTB6pqk7fUyM_6_2oa9c_A@mail.gmail.com>
Subject: Re: samples/seccomp/ broken when cross compiling s390,
 ppc allyesconfig
Content-Type: text/plain; charset="UTF-8"
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Michal Hocko <mhocko@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Will Drewry <wad@chromium.org>, linux-s390 <linux-s390@vger.kernel.org>, PowerPC <linuxppc-dev@lists.ozlabs.org>, LKML <linux-kernel@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Tue, Feb 13, 2018 at 2:32 AM, Michal Hocko <mhocko@kernel.org> wrote:
> On Tue 13-02-18 21:16:55, Michael Ellerman wrote:
>> Kees Cook <keescook@chromium.org> writes:
>>
>> > On Mon, Feb 12, 2018 at 7:25 PM, Michael Ellerman <mpe@ellerman.id.au> wrote:
>> >> Michal Hocko <mhocko@kernel.org> writes:
>> >>> Hi,
>> >>> my build test machinery chokes on samples/seccomp when cross compiling
>> >>> s390 and ppc64 allyesconfig. This has been the case for quite some
>> >>> time already but I never found time to look at the problem and report
>> >>> it. It seems this is not new issue and similar thing happend for
>> >>> MIPS e9107f88c985 ("samples/seccomp/Makefile: do not build tests if
>> >>> cross-compiling for MIPS").
>> >>>
>> >>> The build logs are attached.
>> >>>
>> >>> What is the best way around this? Should we simply skip compilation on
>> >>> cross compile or is actually anybody relying on that? Or should I simply
>> >>> disable it for s390 and ppc?
>> >>
>> >> The whole thing seems very confused. It's not building for the target,
>> >> it's building for the host, ie. the Makefile sets hostprogs-m and
>> >> HOSTCFLAGS etc.
>> >>
>> >> So it can't possibly work with cross compiling as it's currently
>> >> written.
>> >>
>> >> Either the Makefile needs some serious work to properly support cross
>> >> compiling or it should just be disabled when cross compiling.
>> >
>> > Hrm, yeah, the goal was to entirely disable cross compiling, but I
>> > guess we didn't hit it with a hard enough hammer. :)
>>
>> Do you know why it is written that way? Why doesn't it just try to cross
>> compile like normal code?
>
> No idea, sorry. All I know about this code is that it breaks my build
> testing.

IIRC, one of the problems is with build ordering problems: the kernel
headers used by the samples aren't available when cross compiling.

I'm happy to kill it entirely with Michal's patch, though. Feel free
to carry in your tree!

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
Pixel Security
