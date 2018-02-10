Return-Path: <linux-kbuild-owner@vger.kernel.org>
Subject: Re: [RFC PATCH 4/7] kconfig: support new special property shell=
References: <1518106752-29228-1-git-send-email-yamada.masahiro@socionext.com>
 <1518106752-29228-5-git-send-email-yamada.masahiro@socionext.com>
 <20180209053038.pscoijvowmyudyzf@huvuddator>
 <CAK7LNATRxYCx9sE1haw815votyA5K8GQrMPPh0Q+n3kYa=JsgA@mail.gmail.com>
 <20180209124607.akjhncb5sempjqcn@huvuddator>
 <CAGXu5j+hv6G3m+fgr7ibXAnoE-2GsxtXoqr0pd5AaaNdFVQxYg@mail.gmail.com>
 <20180210054843.z3g7wvcmlccvww3h@huvuddator>
 <CAK7LNARHmAF2SxBcc1aUEH5MMzUo_furLevqy7QzGxqNRHYiyQ@mail.gmail.com>
 <20180210074924.3nhxsza5zdbaahxx@huvuddator>
 <20180210080556.mycqsjhxbaguwhay@huvuddator>
 <20180210085519.737ckf4bcl57h4g2@huvuddator>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <246fedb8-d387-5a77-f05d-bf8a91dd6b22@infradead.org>
Date: Sat, 10 Feb 2018 10:05:12 -0800
MIME-Version: 1.0
In-Reply-To: <20180210085519.737ckf4bcl57h4g2@huvuddator>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kbuild-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-kbuild/>
List-Post: <mailto:linux-kbuild@vger.kernel.org>
To: Ulf Magnusson <ulfalizer@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Kees Cook <keescook@chromium.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Nicolas Pitre <nicolas.pitre@linaro.org>, "Luis R . Rodriguez" <mcgrof@suse.com>, Sam Ravnborg <sam@ravnborg.org>, Michal Marek <michal.lkml@markovi.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Pavel Machek <pavel@ucw.cz>, linux-s390 <linux-s390@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On 02/10/2018 12:55 AM, Ulf Magnusson wrote:
> How many compilers don't support -fno-stack-protector by the way?
> 
> 	config CC_HAS_STACKPROTECTOR_STRONG
> 		bool
> 		option shell="$CC -Werror -fstack-protector-strong -c -x c /dev/null"
> 	
> 	config CC_HAS_STACKPROTECTOR_REGULAR
> 		bool
> 		option shell="$CC -Werror -fstack-protector -c -x c /dev/null"
> 	
> 	config CC_HAS_STACKPROTECTOR_NONE
> 		bool
> 		default y
> 		option shell="$CC -Werror -fno-stack-protector -c -x c /dev/null"

I ran:
gcc -Werror -fno-stack-protector -c -x c /dev/null

It worked (gcc (SUSE Linux) 4.8.5) but it did leave a null.o file for me.
Might need to add that to 'make clean' or just rm it immediately.


-- 
~Randy
