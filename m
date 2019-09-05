Return-Path: <linux-arch-owner@vger.kernel.org>
From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH v12 01/12] lib: introduce copy_struct_{to,from}_user helpers
References: <20190904201933.10736-1-cyphar@cyphar.com>
        <20190904201933.10736-2-cyphar@cyphar.com>
Date: Thu, 05 Sep 2019 11:09:35 +0200
In-Reply-To: <20190904201933.10736-2-cyphar@cyphar.com> (Aleksa Sarai's
        message of "Thu, 5 Sep 2019 06:19:22 +1000")
Message-ID: <mvma7bj85yo.fsf@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Jeff Layton <jlayton@kernel.org>, "J. Bruce Fields" <bfields@fieldses.org>, Arnd Bergmann <arnd@arndb.de>, David Howells <dhowells@redhat.com>, Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Christian Brauner <christian@brauner.io>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Eric Biederman <ebiederm@xmission.com>, Andy Lutomirski <luto@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Alexei Starovoitov <ast@kernel.org>, Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>, Tycho Andersen <tycho@tycho.ws>, David Drysdale <drysdale@google.com>, Chanho Min <chanho.min@lge.com>, Oleg Nesterov <oleg@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Aleksa Sarai <asarai@suse.de>, Linus Torvalds <torvalds@linux-foundation.org>, containers@lists.linux-foundation.org, linux-alpha@vger.kernel.org, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org, sparclinux@vger.kernel.org

On Sep 05 2019, Aleksa Sarai <cyphar@cyphar.com> wrote:

> diff --git a/lib/struct_user.c b/lib/struct_user.c
> new file mode 100644
> index 000000000000..7301ab1bbe98
> --- /dev/null
> +++ b/lib/struct_user.c
> @@ -0,0 +1,182 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2019 SUSE LLC
> + * Copyright (C) 2019 Aleksa Sarai <cyphar@cyphar.com>
> + */
> +
> +#include <linux/types.h>
> +#include <linux/export.h>
> +#include <linux/uaccess.h>
> +#include <linux/kernel.h>
> +#include <linux/string.h>
> +
> +#define BUFFER_SIZE 64
> +
> +/*
> + * "memset(p, 0, size)" but for user space buffers. Caller must have already
> + * checked access_ok(p, size).
> + */
> +static int __memzero_user(void __user *p, size_t s)
> +{
> +	const char zeros[BUFFER_SIZE] = {};

Perhaps make that static?

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
