Return-Path: <linux-arch-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1486501816-27600-1-git-send-email-labbott@redhat.com>
References: <1486501816-27600-1-git-send-email-labbott@redhat.com>
From: Kees Cook <keescook@chromium.org>
Date: Tue, 7 Feb 2017 13:25:53 -0800
Message-ID: <CAGXu5j+BGgs747D2cCW_is2z8QPA2crduE4SDDmu8tmxQ4Zh8A@mail.gmail.com>
Subject: Re: [RFC][PATCH] treewide: Move set_memory_* functions away from cacheflush.h
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20170207212553.zfIGqK8QamfKwgB5L5yxNYomxMf1-iwPSJajlHNLV2I@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Laura Abbott <labbott@redhat.com>
Cc: Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, "x86@kernel.org" <x86@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Tue, Feb 7, 2017 at 1:10 PM, Laura Abbott <labbott@redhat.com> wrote:
> The set_memory_* APIs came out of a desire to have a better way to
> change memory attributes. Many of these attributes were linked to cache
> functionality so the prototypes were put in cacheflush.h. These days,
> the APIs have grown and have a much wider use than just cache APIs. To
> support this growth, split off set_memory_* and friends into a separate
> header file to avoid growing cacheflush.h for APIs that have nothing to
> do with caches.
>
> Signed-off-by: Laura Abbott <labbott@redhat.com>
> ---
> This came out of a comment Russell made while reviewing RODATA test cases
> http://lists.infradead.org/pipermail/linux-arm-kernel/2017-January/480855.html
> While the final result of that series was the rodata code was refactored into
> its own header file, the set_memory_* APIs are still out of place.

Yeah, this is a nice clean up to start on.

> This is a simple attempt at moving all the API stubs to their own file.
> Another idea I had was throwing set_memory_{x,nx,ro,rw} in an asm-generic
> file since those are commonly used for module setting across all arches.

It seems like asm-generic would be cleaner, yes? Only a few archs have
anything "special" happening in the resulting header files.

-Kees

-- 
Kees Cook
Pixel Security
