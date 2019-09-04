Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
References: <20190904201933.10736-1-cyphar@cyphar.com> <20190904201933.10736-11-cyphar@cyphar.com>
In-Reply-To: <20190904201933.10736-11-cyphar@cyphar.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 4 Sep 2019 14:09:48 -0700
Message-ID: <CAHk-=wiod1rQMU+6Zew=cLE8uX4tUdf42bM5eKngMnNVS2My7g@mail.gmail.com>
Subject: Re: [PATCH v12 10/12] namei: aggressively check for nd->root escape
 on ".." resolution
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Jeff Layton <jlayton@kernel.org>, "J. Bruce Fields" <bfields@fieldses.org>, Arnd Bergmann <arnd@arndb.de>, David Howells <dhowells@redhat.com>, Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Christian Brauner <christian@brauner.io>, Jann Horn <jannh@google.com>, Kees Cook <keescook@chromium.org>, Eric Biederman <ebiederm@xmission.com>, Andy Lutomirski <luto@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Alexei Starovoitov <ast@kernel.org>, Tycho Andersen <tycho@tycho.ws>, David Drysdale <drysdale@google.com>, Chanho Min <chanho.min@lge.com>, Oleg Nesterov <oleg@redhat.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Aleksa Sarai <asarai@suse.de>, Linux Containers <containers@lists.linux-foundation.org>, alpha <linux-alpha@vger.kernel.org>, Linux API <linux-api@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-ia64@vger.kernel.org, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390 <linux-s390@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, linux-xtensa@linux-xtensa.org, sparclinux@vger.kernel.org

On Wed, Sep 4, 2019 at 1:23 PM Aleksa Sarai <cyphar@cyphar.com> wrote:
>
> This patch allows for LOOKUP_BENEATH and LOOKUP_IN_ROOT to safely permit
> ".." resolution (in the case of LOOKUP_BENEATH the resolution will still
> fail if ".." resolution would resolve a path outside of the root --
> while LOOKUP_IN_ROOT will chroot(2)-style scope it). Magic-link jumps
> are still disallowed entirely because now they could result in
> inconsistent behaviour if resolution encounters a subsequent ".."[*].

This is the only patch in the series that makes me go "umm".

Why is it ok to re-initialize m_seq, which is used by other things
too? I think it's because we're out of RCU lookup, but there's no
comment about it, and it looks iffy to me. I'd rather have a separate
sequence count that doesn't have two users with different lifetime
rules.

But even apart from that, I think from a "patch continuity" standpoint
it would be better to introduce the sequence counts as just an error
condition first - iow, not have the "path_is_under()" check, but just
return -EXDEV if the sequence number doesn't match.

So you'd have three stages:

 1) ".." always returns -EXDEV

 2) ".." returns -EXDEV if there was a concurrent rename/mount

 3) ".." returns -EXDEV if there was a concurrent rename/mount and we
reset the sequence numbers and check if you escaped.

becasue the sequence number reset really does make me go "hmm", plus I
get this nagging little feeling in the back of my head that you can
cause nasty O(n^2) lookup cost behavior with deep paths, lots of "..",
and repeated path_is_under() calls.

So (1) sounds safe. (2) sounds simple. And (3) is where I think subtle
things start happening.

Also, I'm not 100% convinced that (3) is needed at all. I think the
retry could be done in user space instead, which needs to have a
fallback anyway. Yes? No?

                 Linus
