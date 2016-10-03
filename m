From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 03 Oct 2016 09:10:18 +0000
Subject: Re: [PATCH -resend 6/6] frv, mn10300, s390, sh: remove empty vga.h
Message-Id: <CAMuHMdUpKH3OXsdSV5gduw7FKb95DYknExPvR_R67E2WfLmLqA@mail.gmail.com>
References: <20161003090736.19926-1-jslaby@suse.cz> <20161003090736.19926-6-jslaby@suse.cz>
In-Reply-To: <20161003090736.19926-6-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Archive: <https://lore.kernel.org/linux-sh/>
List-Post: <mailto:linux-sh@vger.kernel.org>
To: Jiri Slaby <jslaby@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, David Howells <dhowells@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, "moderated list:PANASONIC MN10300..." <linux-am33-list@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Mon, Oct 3, 2016 at 11:07 AM, Jiri Slaby <jslaby@suse.cz> wrote:
> Provided the architectures do not need any special handling (they seem
> not to support vga at all, actually), there is no need to have an
> empty vga.h. Let them refer to the generic one instead.
>
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: David Howells <dhowells@redhat.com>
> Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Rich Felker <dalias@libc.org>
> Cc: linux-am33-list@redhat.com
> Cc: linux-s390@vger.kernel.org
> Cc: linux-sh@vger.kernel.org

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
