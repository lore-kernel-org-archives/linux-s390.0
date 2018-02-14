Return-Path: <mpe@ellerman.id.au>
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: samples/seccomp/ broken when cross compiling s390,
 ppc allyesconfig
In-Reply-To: <CAGXu5jJCN_Js9rvM4RMjxDCDd4tVzWDo-jdnFiZs1D9e3cunrw@mail.gmail.com>
References: <20180212133731.GE3443@dhcp22.suse.cz>
 <87r2ppvaeq.fsf@concordia.ellerman.id.au>
 <CAGXu5j+DnkUv9pZn93wxA6_2s+c3Ap_Q34OR0weY7Y9MJ1aP9Q@mail.gmail.com>
 <87d1192nzc.fsf@concordia.ellerman.id.au>
 <20180213103213.GP3443@dhcp22.suse.cz>
 <CAGXu5jJZROQMxzxu+Dp3mVMktSg-oTB6pqk7fUyM_6_2oa9c_A@mail.gmail.com>
 <20180214092045.GZ3443@dhcp22.suse.cz>
 <CAGXu5jJCN_Js9rvM4RMjxDCDd4tVzWDo-jdnFiZs1D9e3cunrw@mail.gmail.com>
Date: Thu, 15 Feb 2018 10:23:27 +1100
Message-ID: <87zi4bp34g.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Kees Cook <keescook@chromium.org>, Michal Hocko <mhocko@kernel.org>
Cc: Will Drewry <wad@chromium.org>, linux-s390 <linux-s390@vger.kernel.org>, PowerPC <linuxppc-dev@lists.ozlabs.org>, LKML <linux-kernel@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

Kees Cook <keescook@chromium.org> writes:
> On Wed, Feb 14, 2018 at 1:20 AM, Michal Hocko <mhocko@kernel.org> wrote:
...
>>
>> OK, so let's try to nuke it. How should I route this patch?
>
> I'm fine if goes in via ppc (especially if it can land for 4.16). If
> Michael doesn't want it, I can send it through my seccomp tree via
> James Morris.

It's not really my area, so I'd prefer if you take it, or we could
always punt to akpm :)

cheers
