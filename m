Return-Path: <linux-arch-owner@vger.kernel.org>
MIME-Version: 1.0
References: <20191010054140.8483-1-cyphar@cyphar.com> <20191010054140.8483-3-cyphar@cyphar.com>
In-Reply-To: <20191010054140.8483-3-cyphar@cyphar.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 10 Oct 2019 10:07:32 -0700
Message-ID: <CAHk-=wh8L50f31vW8BwRUXhLiq3eoCQ3tg8ER4Yp2dzuU1w5rQ@mail.gmail.com>
Subject: Re: [PATCH v14 2/6] namei: LOOKUP_IN_ROOT: chroot-like path resolution
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Jeff Layton <jlayton@kernel.org>, "J. Bruce Fields" <bfields@fieldses.org>, Arnd Bergmann <arnd@arndb.de>, David Howells <dhowells@redhat.com>, Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Eric Biederman <ebiederm@xmission.com>, Andy Lutomirski <luto@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Alexei Starovoitov <ast@kernel.org>, Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>, Tycho Andersen <tycho@tycho.ws>, David Drysdale <drysdale@google.com>, Chanho Min <chanho.min@lge.com>, Oleg Nesterov <oleg@redhat.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Christian Brauner <christian@brauner.io>, Aleksa Sarai <asarai@suse.de>, Linux Containers <containers@lists.linux-foundation.org>, alpha <linux-alpha@vger.kernel.org>, Linux API <linux-api@vger.kernel.org>, GNU C Library <libc-alpha@sourceware.org>, linux-arch <linux-arch@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-ia64@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390 <linux-s390@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, linux-xtensa@linux-xtensa.org, sparclinux@vger.kernel.org

On Wed, Oct 9, 2019 at 10:42 PM Aleksa Sarai <cyphar@cyphar.com> wrote:
>
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -2277,6 +2277,11 @@ static const char *path_init(struct nameidata *nd, unsigned flags)
>
>         nd->m_seq = read_seqbegin(&mount_lock);
>
> +       /* LOOKUP_IN_ROOT treats absolute paths as being relative-to-dirfd. */
> +       if (flags & LOOKUP_IN_ROOT)
> +               while (*s == '/')
> +                       s++;
> +
>         /* Figure out the starting path and root (if needed). */
>         if (*s == '/') {
>                 error = nd_jump_root(nd);

Hmm. Wouldn't this make more sense all inside the if (*s =- '/') test?
That way if would be where we check for "should we start at the root",
which seems to make more sense conceptually.

That test for '/' currently has a "} else if (..)", but that's
pointless since it ends with a "return" anyway. So the "else" logic is
just noise.

And if you get rid of the unnecessary else, moving the LOOKUP_IN_ROOT
inside the if-statement works fine.

So this could be something like

    --- a/fs/namei.c
    +++ b/fs/namei.c
    @@ -2194,11 +2196,19 @@ static const char *path_init(struct
nameidata *nd, unsigned flags)

        nd->m_seq = read_seqbegin(&mount_lock);
        if (*s == '/') {
    -           set_root(nd);
    -           if (likely(!nd_jump_root(nd)))
    -                   return s;
    -           return ERR_PTR(-ECHILD);
    -   } else if (nd->dfd == AT_FDCWD) {
    +           /* LOOKUP_IN_ROOT treats absolute paths as being
relative-to-dirfd. */
    +           if (!(flags & LOOKUP_IN_ROOT)) {
    +                   set_root(nd);
    +                   if (likely(!nd_jump_root(nd)))
    +                           return s;
    +                   return ERR_PTR(-ECHILD);
    +           }
    +
    +           /* Skip initial '/' for LOOKUP_IN_ROOT */
    +           do { s++; } while (*s == '/');
    +   }
    +
    +   if (nd->dfd == AT_FDCWD) {
                if (flags & LOOKUP_RCU) {
                        struct fs_struct *fs = current->fs;
                        unsigned seq;

instead. The patch ends up slightly bigger (due to the re-indentation)
but now it handles all the "start at root" in the same place. Doesn't
that make sense?

             Linus
