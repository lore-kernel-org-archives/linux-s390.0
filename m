Return-Path: <linux-kbuild-owner@vger.kernel.org>
Date: Sat, 10 Feb 2018 21:00:02 -0500
From: Kevin Easton <kevin@guarana.org>
Subject: Re: [RFC PATCH 4/7] kconfig: support new special property shell=
Message-ID: <20180211020001.GA5693@la.guarana.org>
References: <20180209053038.pscoijvowmyudyzf@huvuddator>
 <CAK7LNATRxYCx9sE1haw815votyA5K8GQrMPPh0Q+n3kYa=JsgA@mail.gmail.com>
 <20180209124607.akjhncb5sempjqcn@huvuddator>
 <CAGXu5j+hv6G3m+fgr7ibXAnoE-2GsxtXoqr0pd5AaaNdFVQxYg@mail.gmail.com>
 <20180210054843.z3g7wvcmlccvww3h@huvuddator>
 <CAK7LNARHmAF2SxBcc1aUEH5MMzUo_furLevqy7QzGxqNRHYiyQ@mail.gmail.com>
 <20180210074924.3nhxsza5zdbaahxx@huvuddator>
 <20180210080556.mycqsjhxbaguwhay@huvuddator>
 <20180210085519.737ckf4bcl57h4g2@huvuddator>
 <246fedb8-d387-5a77-f05d-bf8a91dd6b22@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <246fedb8-d387-5a77-f05d-bf8a91dd6b22@infradead.org>
Sender: linux-kbuild-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-kbuild/>
List-Post: <mailto:linux-kbuild@vger.kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Ulf Magnusson <ulfalizer@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Kees Cook <keescook@chromium.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Nicolas Pitre <nicolas.pitre@linaro.org>, "Luis R . Rodriguez" <mcgrof@suse.com>, Sam Ravnborg <sam@ravnborg.org>, Michal Marek <michal.lkml@markovi.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Pavel Machek <pavel@ucw.cz>, linux-s390 <linux-s390@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Sat, Feb 10, 2018 at 10:05:12AM -0800, Randy Dunlap wrote:
> On 02/10/2018 12:55 AM, Ulf Magnusson wrote:
> > How many compilers don't support -fno-stack-protector by the way?
> > 
> > 	config CC_HAS_STACKPROTECTOR_STRONG
> > 		bool
> > 		option shell="$CC -Werror -fstack-protector-strong -c -x c /dev/null"
> > 	
> > 	config CC_HAS_STACKPROTECTOR_REGULAR
> > 		bool
> > 		option shell="$CC -Werror -fstack-protector -c -x c /dev/null"
> > 	
> > 	config CC_HAS_STACKPROTECTOR_NONE
> > 		bool
> > 		default y
> > 		option shell="$CC -Werror -fno-stack-protector -c -x c /dev/null"
> 
> I ran:
> gcc -Werror -fno-stack-protector -c -x c /dev/null
> 
> It worked (gcc (SUSE Linux) 4.8.5) but it did leave a null.o file for me.
> Might need to add that to 'make clean' or just rm it immediately.

gcc -Werror -fno-stack-protector -c -x c /dev/null -o /dev/null

seems to DTRT without leaving anything behind.

    - Kevin
