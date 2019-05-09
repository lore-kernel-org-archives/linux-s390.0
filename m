Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Thu, 9 May 2019 15:38:29 +0200
From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
Subject: Re: [PATCH] vsprintf: Do not break early boot with probing
 addresses
Message-ID: <20190509153829.06319d0c@kitsune.suse.cz>
In-Reply-To: <20190509121923.8339-1-pmladek@suse.com>
References: <20190509121923.8339-1-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20190509133829.35pSRgEMpcLhNbfDUK9sCV-aSZSNvQEOVDu8hmrRnzU@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Petr Mladek <pmladek@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-arch@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, Rasmus Villemoes <linux@rasmusvillemoes.dk>, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Michal Hocko <mhocko@suse.cz>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Stephen Rothwell <sfr@ozlabs.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linuxppc-dev@lists.ozlabs.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, "Tobin C . Harding" <me@tobin.cc>
List-ID: <linux-s390.vger.kernel.org>

On Thu,  9 May 2019 14:19:23 +0200
Petr Mladek <pmladek@suse.com> wrote:

> The commit 3e5903eb9cff70730 ("vsprintf: Prevent crash when dereferencing
> invalid pointers") broke boot on several architectures. The common
> pattern is that probe_kernel_read() is not working during early
> boot because userspace access framework is not ready.
> 
> The check is only the best effort. Let's not rush with it during
> the early boot.
> 
> Details:
> 
> 1. Report on Power:
> 
> Kernel crashes very early during boot with with CONFIG_PPC_KUAP and
> CONFIG_JUMP_LABEL_FEATURE_CHECK_DEBUG
> 
> The problem is the combination of some new code called via printk(),
> check_pointer() which calls probe_kernel_read(). That then calls
> allow_user_access() (PPC_KUAP) and that uses mmu_has_feature() too early
> (before we've patched features).

There is early_mmu_has_feature for this case. mmu_has_feature does not
work before patching so parts of kernel that can run before patching
must use the early_ variant which actually runs code reading the
feature bitmap to determine the answer.

Thanks

Michal
