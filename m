From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] vsprintf: Do not break early boot with probing addresses
Date: Thu, 9 May 2019 21:47:27 -0700
Message-ID: <CAHk-=wiP+hwSqEW0dM6AYNWUR7jXDkeueq69et6ahfUgV7hC3w@mail.gmail.com>
References: <20190509121923.8339-1-pmladek@suse.com>
 <20190510043200.GC15652@jagdpanzerIV>
Mime-Version: 1.0
Content-Type: multipart/alternative; boundary="000000000000166f8f05888144be"
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <20190510043200.GC15652@jagdpanzerIV>
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
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Petr Mladek <pmladek@suse.com>, linux-arch@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, Rasmus Villemoes <linux@rasmusvillemoes.dk>, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Michal Hocko <mhocko@suse.cz>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Stephen Rothwell <sfr@ozlabs.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linuxppc-dev@lists.ozlabs.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, "Tobin C . Harding" <me@tobin.cc>
List-ID: <linux-s390.vger.kernel.org>

--000000000000166f8f05888144be
Content-Type: text/plain; charset="UTF-8"

[ Sorry about html and mobile crud, I'm not at the computer right now ]

How about we just undo the whole misguided probe_kernel_address() thing?

The excuse for is was that it would avoid crashes.

It turns out that was wrong, and that it just made things much worse.
Honestly, we haven't really had the crashes that the logic was supposed to
protect against in the first place, so by now it's clear that the whole
thing was a stupid and horrible mistake in the first place.

So let's admit that and just go back to the old sane model.

Seriously, we've never needed that odd probing. It causes issues. It's
wrong and pointless.

       Linus

On Thu, May 9, 2019, 21:32 Sergey Senozhatsky <
sergey.senozhatsky.work@gmail.com> wrote:

> On (05/09/19 14:19), Petr Mladek wrote:
> > 1. Report on Power:
> >
> > Kernel crashes very early during boot with with CONFIG_PPC_KUAP and
> > CONFIG_JUMP_LABEL_FEATURE_CHECK_DEBUG
> >
> > The problem is the combination of some new code called via printk(),
> > check_pointer() which calls probe_kernel_read(). That then calls
> > allow_user_access() (PPC_KUAP) and that uses mmu_has_feature() too early
> > (before we've patched features). With the JUMP_LABEL debug enabled that
> > causes us to call printk() & dump_stack() and we end up recursing and
> > overflowing the stack.
>
> Hmm... hmm... PPC does an .opd-based symbol dereference, which
> eventually probe_kernel_read()-s. So early printk(%pS) will do
>
>         printk(%pS)
>          dereference_function_descriptor()
>           probe_kernel_address()
>            dump_stack()
>             printk(%pS)
>              dereference_function_descriptor()
>               probe_kernel_address()
>                dump_stack()
>                 printk(%pS)
>                  ...
>
> I'd say... that it's not vsprintf that we want to fix, it's
> the idea that probe_kernel_address() can dump_stack() on any
> platform. On some archs probe_kernel_address()->dump_stack()
> is going nowhere:
>  dump_stack() does probe_kernel_address(), which calls dump_stack(),
>  which calls printk(%pS)->probe_kernel_address() again and again,
>  and again.
>
>         -ss
>

--000000000000166f8f05888144be
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div dir=3D"auto">[ Sorry about html and mobile crud, I&#=
39;m not at the computer right now ]</div><div dir=3D"auto"><br></div>How a=
bout we just undo the whole misguided probe_kernel_address() thing?<div dir=
=3D"auto"><br></div><div dir=3D"auto">The excuse for is was that it would a=
void crashes.</div><div dir=3D"auto"><br></div><div dir=3D"auto">It turns o=
ut that was wrong, and that it just made things much worse. Honestly, we ha=
ven&#39;t really had the crashes that the logic was supposed to protect aga=
inst in the first place, so by now it&#39;s clear that the whole thing was =
a stupid and horrible mistake in the first place.</div><div dir=3D"auto"><b=
r></div><div dir=3D"auto">So let&#39;s admit that and just go back to the o=
ld sane model.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Seriously=
, we&#39;ve never needed that odd probing. It causes issues. It&#39;s wrong=
 and pointless.</div><div dir=3D"auto"><br></div><div dir=3D"auto">=C2=A0 =
=C2=A0 =C2=A0 =C2=A0Linus</div></div><br><div class=3D"gmail_quote"><div di=
r=3D"ltr" class=3D"gmail_attr">On Thu, May 9, 2019, 21:32 Sergey Senozhatsk=
y &lt;<a href=3D"mailto:sergey.senozhatsky.work@gmail.com">sergey.senozhats=
ky.work@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On=
 (05/09/19 14:19), Petr Mladek wrote:<br>
&gt; 1. Report on Power:<br>
&gt; <br>
&gt; Kernel crashes very early during boot with with CONFIG_PPC_KUAP and<br=
>
&gt; CONFIG_JUMP_LABEL_FEATURE_CHECK_DEBUG<br>
&gt; <br>
&gt; The problem is the combination of some new code called via printk(),<b=
r>
&gt; check_pointer() which calls probe_kernel_read(). That then calls<br>
&gt; allow_user_access() (PPC_KUAP) and that uses mmu_has_feature() too ear=
ly<br>
&gt; (before we&#39;ve patched features). With the JUMP_LABEL debug enabled=
 that<br>
&gt; causes us to call printk() &amp; dump_stack() and we end up recursing =
and<br>
&gt; overflowing the stack.<br>
<br>
Hmm... hmm... PPC does an .opd-based symbol dereference, which<br>
eventually probe_kernel_read()-s. So early printk(%pS) will do<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 printk(%pS)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dereference_function_descriptor()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 probe_kernel_address()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dump_stack()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 printk(%pS)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dereference_function_descri=
ptor()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 probe_kernel_address()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dump_stack()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 printk(%pS)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0...<br>
<br>
I&#39;d say... that it&#39;s not vsprintf that we want to fix, it&#39;s<br>
the idea that probe_kernel_address() can dump_stack() on any<br>
platform. On some archs probe_kernel_address()-&gt;dump_stack()<br>
is going nowhere:<br>
=C2=A0dump_stack() does probe_kernel_address(), which calls dump_stack(),<b=
r>
=C2=A0which calls printk(%pS)-&gt;probe_kernel_address() again and again,<b=
r>
=C2=A0and again.<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 -ss<br>
</blockquote></div>

--000000000000166f8f05888144be--
