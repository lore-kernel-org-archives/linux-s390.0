Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Wed, 8 Feb 2017 09:28:30 +0000
From: Will Deacon <will.deacon@arm.com>
Subject: Re: [RFC][PATCH] treewide: Move set_memory_* functions away from
 cacheflush.h
Message-ID: <20170208092830.GB30215@arm.com>
References: <1486501816-27600-1-git-send-email-labbott@redhat.com>
 <CAGXu5j+BGgs747D2cCW_is2z8QPA2crduE4SDDmu8tmxQ4Zh8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5j+BGgs747D2cCW_is2z8QPA2crduE4SDDmu8tmxQ4Zh8A@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20170208092830.11yup85-qNSgk3F1Ux9I6Gb4b7oIGHTQjo_rnU7srkU@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Laura Abbott <labbott@redhat.com>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, "x86@kernel.org" <x86@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Tue, Feb 07, 2017 at 01:25:53PM -0800, Kees Cook wrote:
> On Tue, Feb 7, 2017 at 1:10 PM, Laura Abbott <labbott@redhat.com> wrote:
> > The set_memory_* APIs came out of a desire to have a better way to
> > change memory attributes. Many of these attributes were linked to cache
> > functionality so the prototypes were put in cacheflush.h. These days,
> > the APIs have grown and have a much wider use than just cache APIs. To
> > support this growth, split off set_memory_* and friends into a separate
> > header file to avoid growing cacheflush.h for APIs that have nothing to
> > do with caches.
> >
> > Signed-off-by: Laura Abbott <labbott@redhat.com>
> > ---
> > This came out of a comment Russell made while reviewing RODATA test cases
> > http://lists.infradead.org/pipermail/linux-arm-kernel/2017-January/480855.html
> > While the final result of that series was the rodata code was refactored into
> > its own header file, the set_memory_* APIs are still out of place.
> 
> Yeah, this is a nice clean up to start on.
> 
> > This is a simple attempt at moving all the API stubs to their own file.
> > Another idea I had was throwing set_memory_{x,nx,ro,rw} in an asm-generic
> > file since those are commonly used for module setting across all arches.
> 
> It seems like asm-generic would be cleaner, yes? Only a few archs have
> anything "special" happening in the resulting header files.

I'd also prefer the asm-generic approach if it makes the arch part a simple
addition to asm/Kbuild.

Will
