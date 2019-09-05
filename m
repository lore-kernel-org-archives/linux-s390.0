Return-Path: <linux-kselftest-owner@vger.kernel.org>
Date: Thu, 5 Sep 2019 11:43:05 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v12 01/12] lib: introduce copy_struct_{to,from}_user
 helpers
Message-ID: <20190905094305.GJ2349@hirez.programming.kicks-ass.net>
References: <20190904201933.10736-1-cyphar@cyphar.com>
 <20190904201933.10736-2-cyphar@cyphar.com>
 <20190905073205.GY2332@hirez.programming.kicks-ass.net>
 <20190905092622.tlb6nn3uisssdfbu@yavin.dot.cyphar.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190905092622.tlb6nn3uisssdfbu@yavin.dot.cyphar.com>
Sender: linux-kselftest-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Jeff Layton <jlayton@kernel.org>, "J. Bruce Fields" <bfields@fieldses.org>, Arnd Bergmann <arnd@arndb.de>, David Howells <dhowells@redhat.com>, Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, Ingo Molnar <mingo@redhat.com>, Christian Brauner <christian@brauner.io>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Eric Biederman <ebiederm@xmission.com>, Andy Lutomirski <luto@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Alexei Starovoitov <ast@kernel.org>, Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>, Tycho Andersen <tycho@tycho.ws>, David Drysdale <drysdale@google.com>, Chanho Min <chanho.min@lge.com>, Oleg Nesterov <oleg@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Aleksa Sarai <asarai@suse.de>, Linus Torvalds <torvalds@linux-foundation.org>, containers@lists.linux-foundation.org, linux-alpha@vger.kernel.org, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org, sparclinux@vger.kernel.org

On Thu, Sep 05, 2019 at 07:26:22PM +1000, Aleksa Sarai wrote:
> On 2019-09-05, Peter Zijlstra <peterz@infradead.org> wrote:
> > On Thu, Sep 05, 2019 at 06:19:22AM +1000, Aleksa Sarai wrote:
> > > +/**
> > > + * copy_struct_to_user: copy a struct to user space
> > > + * @dst:   Destination address, in user space.
> > > + * @usize: Size of @dst struct.
> > > + * @src:   Source address, in kernel space.
> > > + * @ksize: Size of @src struct.
> > > + *
> > > + * Copies a struct from kernel space to user space, in a way that gu=
arantees
> > > + * backwards-compatibility for struct syscall arguments (as long as =
future
> > > + * struct extensions are made such that all new fields are *appended=
* to the
> > > + * old struct, and zeroed-out new fields have the same meaning as th=
e old
> > > + * struct).
> > > + *
> > > + * @ksize is just sizeof(*dst), and @usize should've been passed by =
user space.
> > > + * The recommended usage is something like the following:
> > > + *
> > > + *   SYSCALL_DEFINE2(foobar, struct foo __user *, uarg, size_t, usiz=
e)
> > > + *   {
> > > + *      int err;
> > > + *      struct foo karg =3D {};
> > > + *
> > > + *      // do something with karg
> > > + *
> > > + *      err =3D copy_struct_to_user(uarg, usize, &karg, sizeof(karg)=
);
> > > + *      if (err)
> > > + *        return err;
> > > + *
> > > + *      // ...
> > > + *   }
> > > + *
> > > + * There are three cases to consider:
> > > + *  * If @usize =3D=3D @ksize, then it's copied verbatim.
> > > + *  * If @usize < @ksize, then kernel space is "returning" a newer s=
truct to an
> > > + *    older user space. In order to avoid user space getting incompl=
ete
> > > + *    information (new fields might be important), all trailing byte=
s in @src
> > > + *    (@ksize - @usize) must be zerored
> >=20
> > s/zerored/zero/, right?
>=20
> It should've been "zeroed".

That reads wrong to me; that way it reads like this function must take
that action and zero out the 'rest'; which is just wrong.

This function must verify those bytes are zero, not make them zero.

> > >                                          , otherwise -EFBIG is return=
ed.
> >=20
> > 'Funny' that, copy_struct_from_user() below seems to use E2BIG.
>=20
> This is a copy of the semantics that sched_[sg]etattr(2) uses -- E2BIG for
> a "too big" struct passed to the kernel, and EFBIG for a "too big"
> struct passed to user-space. I would personally have preferred EMSGSIZE
> instead of EFBIG, but felt using the existing error codes would be less
> confusing.

Sadly a recent commit:

  1251201c0d34 ("sched/core: Fix uclamp ABI bug, clean up and robustify sch=
ed_read_attr() ABI logic and code")

Made the situation even 'worse'.


> > > +	if (unlikely(!access_ok(src, usize)))
> > > +		return -EFAULT;
> > > +
> > > +	/* Deal with trailing bytes. */
> > > +	if (usize < ksize)
> > > +		memset(dst + size, 0, rest);
> > > +	else if (usize > ksize) {
> > > +		const void __user *addr =3D src + size;
> > > +		char buffer[BUFFER_SIZE] =3D {};
> >=20
> > Isn't that too big for on-stack?
>=20
> Is a 64-byte buffer too big? I picked the number "at random" to be the
> size of a cache line, but I could shrink it down to 32 bytes if the size
> is an issue (I wanted to avoid needless allocations -- hence it being
> on-stack).

Ah, my ctags gave me a definition of BUFFER_SIZE that was 512. I suppose
64 should be OK.

> > > +
> > > +		while (rest > 0) {
> > > +			size_t bufsize =3D min(rest, sizeof(buffer));
> > > +
> > > +			if (__copy_from_user(buffer, addr, bufsize))
> > > +				return -EFAULT;
> > > +			if (memchr_inv(buffer, 0, bufsize))
> > > +				return -E2BIG;
> > > +
> > > +			addr +=3D bufsize;
> > > +			rest -=3D bufsize;
> > > +		}
> >=20
> > The perf implementation uses get_user(); but if that is too slow, surely
> > we can do something with uaccess_try() here?
>=20
> Is there a non-x86-specific way to do that (unless I'm mistaken only x86
> has uaccess_try() or the other *_try() wrappers)? The main "performance
> improvement" (if you can even call it that) is that we use memchr_inv()
> which finds non-matching characters more efficiently than just doing a
> loop.

Oh, you're right, that's x86 only :/
