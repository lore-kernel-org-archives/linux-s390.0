Return-Path: <linux-kbuild-owner@vger.kernel.org>
Date: Thu, 15 Feb 2018 15:38:12 -0800 (PST)
Subject: Re: [RFC PATCH 4/7] kconfig: support new special property shell
In-Reply-To: <CA+55aFy4WNC=pmga19CHhrX9QwOJsu1bUvGL0oNxq5EeMW94eg@mail.gmail.com>
From: Palmer Dabbelt <palmer@sifive.com>
Message-ID: <mhng-0ca7cce5-5731-4bf4-b116-b719d3aad34b@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kbuild-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-kbuild/>
List-Post: <mailto:linux-kbuild@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: keescook@chromium.org, ulfalizer@gmail.com, yamada.masahiro@socionext.com, linux-kbuild@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>, akpm@linux-foundation.org, nicolas.pitre@linaro.org, mcgrof@suse.com, rdunlap@infradead.org, sam@ravnborg.org, michal.lkml@markovi.net, schwidefsky@de.ibm.com, pavel@ucw.cz, linux-s390@vger.kernel.org, jkosina@suse.cz, linux-kernel@vger.kernel.org, tj@kernel.org, mingo@kernel.org, arjan.van.de.ven@intel.com, Arnd Bergmann <arnd@arndb.de>
List-ID: <linux-s390.vger.kernel.org>

On Sun, 11 Feb 2018 12:06:35 PST (-0800), Linus Torvalds wrote:
> On Sun, Feb 11, 2018 at 11:53 AM, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> Well, it's still not a very *big* bump. With modern distros being at
>> 7.3, and people testing pre-releases of gcc-8, something like gcc-4.5
>> is still pretty darn ancient.
>
> ... it's worth noting that our _documentation_ may claim that gcc-3.2
> is the minimum supported version, but Arnd pointed out that a few
> months ago that apparently nothing older than 4.1 has actually worked
> for a longish while, and gcc-4.3 was needed on several architectures.
>
> So the _real_ jump in required gcc version would be from 4.1 (4.3 in
> many cases) to 4.5, not from our documented "3.2 minimum".
>
> Arnd claimed that some architectures needed even newer-than-4.3, but I
> assume that's limited to things like RISC-V that simply don't have old
> gcc support at all.

Just for the record, we'd really like users to use GCC 7.3.0 and binutils 2.30 
(or newer), as even though we had support earlier versions (back to binutils 
2.28 and gcc 7.1.0) there's a handful of bugs floating around in our ports 
there.

Of course, I'm not suggesting that as a kernel-wide policy :).  It looks like 
we're going to end up with distributions shipping 7.3.0 and 2.30 as their first 
RISC-V versions, so hopefully we're safe here.

> That was from a discussion about bug report that only happened with
> gcc-4.4, and was because gcc-4.4 did insane things, so we were talking
> about how it wasn't necessarily worth supporting.
>
> So we really have had a lot of unrelated reasons why just saying
> "gcc-4.5 or newer"  would be a good thing.
>
>             Linus
