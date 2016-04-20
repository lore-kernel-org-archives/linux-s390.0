From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 10/11] x86, rwsem: provide __down_write_killable
Date: Wed, 20 Apr 2016 11:04:05 -0700
Message-ID: <91A11395-ACAA-4043-B770-2DF6CBAED54C@zytor.com>
References: <1460041951-22347-1-git-send-email-mhocko@kernel.org> <1460041951-22347-11-git-send-email-mhocko@kernel.org> <20160413090829.GB29579@gmail.com> <20160413091625.GF14351@dhcp22.suse.cz> <20160413091943.GA17858@gmail.com> <20160413102731.GA29896@gmail.com> <20160413124943.GH14351@dhcp22.suse.cz> <20160420134019.GX3448@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160420134019.GX3448@twins.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Michal Hocko <mhocko@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "David S. Miller" <davem@davemloft.net>, Tony Luck <tony.luck@intel.com>, Andrew Morton <akpm@linux-foundation.org>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, x86@kernel.org, linux-alpha@vger.kernel.org, linux-ia64@vger.kernel.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

On April 20, 2016 6:40:19 AM PDT, Peter Zijlstra <peterz@infradead.org>=
 wrote:
>On Wed, Apr 13, 2016 at 02:49:43PM +0200, Michal Hocko wrote:
>> On Wed 13-04-16 12:27:31, Ingo Molnar wrote:
>> >=20
>> > * Ingo Molnar <mingo@kernel.org> wrote:
>> >=20
>> > > I'm testing your patches today, if they are otherwise OK [...]
>> >=20
>> > got this build failure:
>> >=20
>> >   ./arch/x86/include/asm/rwsem.h:106:2: error: =E2=80=98asm=E2=80=99=
 operand has
>impossible constraints
>>=20
>> Hmm, I have no idea why 64b didn't have problem with the asm but 32b
>> complains. Anyway, the following makes both happy. I have checked th=
e
>> generated code for 64b and it hasn't changed after the patch. 32b
>also
>> seems to be generating a proper code. My gcc asm()-foo is rather wea=
k
>so
>> I would feel better if somebody double checked after me.
>
>I completely blow at this gcc-asm constraints thing too :/
>
>In any case, Ingo will you look after the rest of these patches, or do
>you want me to pick up the remaining bits?

The reason it breaks is because the same register can't be an input-out=
put register and a separate input.  However, the input side of the inpu=
t-output is probably undefined, and so gcc may not notice.
--=20
Sent from my Android device with K-9 Mail. Please excuse brevity and fo=
rmatting.
