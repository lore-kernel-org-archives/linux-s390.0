Return-Path: <mhocko@kernel.org>
Date: Tue, 13 Feb 2018 11:32:13 +0100
From: Michal Hocko <mhocko@kernel.org>
Subject: Re: samples/seccomp/ broken when cross compiling s390, ppc
 allyesconfig
Message-ID: <20180213103213.GP3443@dhcp22.suse.cz>
References: <20180212133731.GE3443@dhcp22.suse.cz>
 <87r2ppvaeq.fsf@concordia.ellerman.id.au>
 <CAGXu5j+DnkUv9pZn93wxA6_2s+c3Ap_Q34OR0weY7Y9MJ1aP9Q@mail.gmail.com>
 <87d1192nzc.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87d1192nzc.fsf@concordia.ellerman.id.au>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Kees Cook <keescook@chromium.org>, Will Drewry <wad@chromium.org>, linux-s390 <linux-s390@vger.kernel.org>, PowerPC <linuxppc-dev@lists.ozlabs.org>, LKML <linux-kernel@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Tue 13-02-18 21:16:55, Michael Ellerman wrote:
> Kees Cook <keescook@chromium.org> writes:
> 
> > On Mon, Feb 12, 2018 at 7:25 PM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> >> Michal Hocko <mhocko@kernel.org> writes:
> >>> Hi,
> >>> my build test machinery chokes on samples/seccomp when cross compiling
> >>> s390 and ppc64 allyesconfig. This has been the case for quite some
> >>> time already but I never found time to look at the problem and report
> >>> it. It seems this is not new issue and similar thing happend for
> >>> MIPS e9107f88c985 ("samples/seccomp/Makefile: do not build tests if
> >>> cross-compiling for MIPS").
> >>>
> >>> The build logs are attached.
> >>>
> >>> What is the best way around this? Should we simply skip compilation on
> >>> cross compile or is actually anybody relying on that? Or should I simply
> >>> disable it for s390 and ppc?
> >>
> >> The whole thing seems very confused. It's not building for the target,
> >> it's building for the host, ie. the Makefile sets hostprogs-m and
> >> HOSTCFLAGS etc.
> >>
> >> So it can't possibly work with cross compiling as it's currently
> >> written.
> >>
> >> Either the Makefile needs some serious work to properly support cross
> >> compiling or it should just be disabled when cross compiling.
> >
> > Hrm, yeah, the goal was to entirely disable cross compiling, but I
> > guess we didn't hit it with a hard enough hammer. :)
> 
> Do you know why it is written that way? Why doesn't it just try to cross
> compile like normal code?

No idea, sorry. All I know about this code is that it breaks my build
testing.
-- 
Michal Hocko
SUSE Labs
