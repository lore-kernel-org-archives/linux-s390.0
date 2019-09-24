Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail.skyhub.de ([5.9.137.197]:33626 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390921AbfIXJvZ (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 24 Sep 2019 05:51:25 -0400
Date: Tue, 24 Sep 2019 11:51:27 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v1] seccomp: simplify secure_computing()
Message-ID: <20190924095127.GE19317@zn.tnic>
References: <20190920131907.6886-1-christian.brauner@ubuntu.com>
 <20190924064420.6353-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190924064420.6353-1-christian.brauner@ubuntu.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Brauner <christian.brauner@ubuntu.com>
Cc: keescook@chromium.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org, linux-um@lists.infradead.org, luto@kernel.org, oleg@redhat.com, tglx@linutronix.de, wad@chromium.org, x86@kernel.org

On Tue, Sep 24, 2019 at 08:44:20AM +0200, Christian Brauner wrote:
> Afaict, the struct seccomp_data argument to secure_computing() is unused
> by all current callers. So let's remove it.
> The argument was added in [1]. It was added because having the arch
> supply the syscall arguments used to be faster than having it done by
> secure_computing() (cf. Andy's comment in [2]). This is not true anymore
> though.
> 
> /* References */
> [1]: 2f275de5d1ed ("seccomp: Add a seccomp_data parameter secure_computing()")
> [2]: https://lore.kernel.org/r/CALCETrU_fs_At-hTpr231kpaAd0z7xJN4ku-DvzhRU6cvcJA_w@mail.gmail.com
> 
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Will Drewry <wad@chromium.org>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-parisc@vger.kernel.org
> Cc: linux-s390@vger.kernel.org
> Cc: linux-um@lists.infradead.org
> Cc: x86@kernel.org
> ---
> /* v1 */
> - Borislav Petkov <bp@alien8.de>:
>   - provide context for the arg addition to secure_computing() in the
>     commit message
> 
> /* v0 */
> Link: https://lore.kernel.org/r/20190920131907.6886-1-christian.brauner@ubuntu.com
> ---
>  arch/arm/kernel/ptrace.c              | 2 +-
>  arch/arm64/kernel/ptrace.c            | 2 +-
>  arch/parisc/kernel/ptrace.c           | 2 +-
>  arch/s390/kernel/ptrace.c             | 4 ++--
>  arch/um/kernel/skas/syscall.c         | 2 +-
>  arch/x86/entry/vsyscall/vsyscall_64.c | 2 +-
>  include/linux/seccomp.h               | 6 +++---
>  7 files changed, 10 insertions(+), 10 deletions(-)

Acked-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
