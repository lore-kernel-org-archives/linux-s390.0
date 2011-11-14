From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 4/5] treewide: Convert uses of ATTRIB_NORETURN to __noreturn
Date: Mon, 14 Nov 2011 21:50:37 +0100
Message-ID: <CAMuHMdW+KORv6K6jMxTVOM=EeVQ6JTHHe9cOVfKZ39x4NcgvfQ__28905.7195456282$1321303852$gmane$org@mail.gmail.com>
References: <cover.1320917551.git.joe@perches.com>
	<abb1d8b542872ef3bfd695e85d3b8a0fd70645b9.1320917558.git.joe@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-m68k-owner@vger.kernel.org>
In-Reply-To: <abb1d8b542872ef3bfd695e85d3b8a0fd70645b9.1320917558.git.joe@perches.com>
Sender: linux-m68k-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-m68k/>
List-Post: <mailto:linux-m68k@vger.kernel.org>
To: Joe Perches <joe@perches.com>
Cc: Andrew Morton <akpm@google.com>, linux-kernel@vger.kernel.org, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, Ralf Baechle <ralf@linux-mips.org>, David Howells <dhowells@redhat.com>, Koichi Yasutake <yasutake.koichi@jp.panasonic.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux390@de.ibm.com, Paul Mundt <lethal@linux-sh.org>, Chris Metcalf <cmetcalf@tilera.com>, linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-mips@linux-mips.org, linux-am33-list@redhat.com, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Thu, Nov 10, 2011 at 10:41, Joe Perches <joe@perches.com> wrote:
> Use the more commonly used __noreturn instead of ATTRIB_NORETURN.
>
> Signed-off-by: Joe Perches <joe@perches.com>

=46or the m68k parts:
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-=
m68k.org

In personal conversations with technical people, I call myself a hacker=
=2E But
when I'm talking to journalists I just say "programmer" or something li=
ke that.
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0=C2=A0 -- Linus Torvalds
