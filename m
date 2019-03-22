Return-Path: <linux-arch-owner@vger.kernel.org>
MIME-Version: 1.0
References: <20190322143008.21313-1-longman@redhat.com> <20190322143008.21313-4-longman@redhat.com>
In-Reply-To: <20190322143008.21313-4-longman@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 22 Mar 2019 10:08:29 -0700
Message-ID: <CAHk-=wi0wwmY-waC1-2SmBz4-XK-Eru2RTx6PrGzUK=P1nwexQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] locking/rwsem: Optimize down_read_trylock()
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20190322170829.id3X0uFxNqk5Fkhs3XOWOu4_A4mDMxmHtndeMbSFSCU@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>, "linux-alpha@vger.kernel.org" <linux-arm-kernel@lists.infradead.org>, linux-c6x-dev@linux-c6x.org, uclinux-h8-devel@lists.sourceforge.jp, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linux-m68k <linux-m68k@lists.linux-m68k.org>, linux-mips@vger.kernel.org, nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, Linux-sh list <linux-sh@vger.kernel.org>, sparclinux@vger.kernel.org, linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org, linux-arch <linux-arch@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Davidlohr Bueso <dave@stgolabs.net>, Andrew Morton <akpm@linux-foundation.org>, Tim Chen <tim.c.chen@linux.intel.com>
List-ID: <linux-s390.vger.kernel.org>

On Fri, Mar 22, 2019 at 7:30 AM Waiman Long <longman@redhat.com> wrote:
>
> Modify __down_read_trylock() to optimize for an unlocked rwsem and make
> it generate slightly better code.

Oh, that should teach me to read all patches in the series before
starting to comment on them.

So ignore my comment on #1.

                Linus
