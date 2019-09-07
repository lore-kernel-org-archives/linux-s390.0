Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33237 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393242AbfIGRm1 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sat, 7 Sep 2019 13:42:27 -0400
Received: by mail-pl1-f194.google.com with SMTP id t11so4681846plo.0
        for <linux-s390@vger.kernel.org>; Sat, 07 Sep 2019 10:42:27 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v12 11/12] open: openat2(2) syscall
From: Andy Lutomirski <luto@amacapital.net>
In-Reply-To: <CAHk-=whZx97Nm-gUK0ppofj2RA2LLz2vmaDUTKSSV-+yYB9q_Q@mail.gmail.com>
Date: Sat, 7 Sep 2019 10:42:23 -0700
Content-Transfer-Encoding: quoted-printable
Message-Id: <C81D6D29-F6BF-48E6-A15E-3ABCB2C992E5@amacapital.net>
References: <20190904201933.10736-1-cyphar@cyphar.com> <20190904201933.10736-12-cyphar@cyphar.com> <7236f382d72130f2afbbe8940e72cc67e5c6dce0.camel@kernel.org> <CAHk-=whZx97Nm-gUK0ppofj2RA2LLz2vmaDUTKSSV-+yYB9q_Q@mail.gmail.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jeff Layton <jlayton@kernel.org>, Aleksa Sarai <cyphar@cyphar.com>, Al Viro <viro@zeniv.linux.org.uk>, "J. Bruce Fields" <bfields@fieldses.org>, Arnd Bergmann <arnd@arndb.de>, David Howells <dhowells@redhat.com>, Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Christian Brauner <christian@brauner.io>, Eric Biederman <ebiederm@xmission.com>, Andy Lutomirski <luto@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Alexei Starovoitov <ast@kernel.org>, Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>, Tycho Andersen <tycho@tycho.ws>, David Drysdale <drysdale@google.com>, Chanho Min <chanho.min@lge.com>, Oleg Nesterov <oleg@redhat.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Aleksa Sarai <asarai@suse.de>, Linux Containers <containers@lists.linux-foundation.org>, alpha <linux-alpha@vger.kernel.org>, Linux API <linux-api@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-ia64@vger.kernel.org, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390 <linux-s390@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, linux-xtensa@linux-xtensa.org, sparclinux@vger.kernel.org



> On Sep 7, 2019, at 9:58 AM, Linus Torvalds <torvalds@linux-foundation.org>=
 wrote:
>=20
>> On Sat, Sep 7, 2019 at 5:40 AM Jeff Layton <jlayton@kernel.org> wrote:
>>=20
>> After thinking about this a bit, I wonder if we might be better served
>> with a new set of OA2_* flags instead of repurposing the O_* flags?
>=20
> I'd hate to have yet _another_ set of translation functions, and
> another chance of people just getting it wrong either in user space or
> the kernel.
>=20
> So no. Let's not make another set of flags that has no sane way to
> have type-safety to avoid more confusion.
>=20
> The new flags that _only_ work with openat2() might be named with a
> prefix/suffix to mark that, but I'm not sure it's a huge deal.
>=20
>           =20

I agree with the philosophy, but I think it doesn=E2=80=99t apply in this ca=
se.  Here are the flags:

O_RDONLY, O_WRONLY, O_RDWR: not even a proper bitmask. The kernel already ha=
s the FMODE_ bits to make this make sense. How about we make the openat2 per=
mission bits consistent with the internal representation and let the O_ perm=
ission bits remain as an awful translation.  The kernel already translates l=
ike this, and it already sucks.

O_CREAT, O_TMPFILE, O_NOCTTY, O_TRUNC: not modes on the fd at all.  These af=
fect the meaning of open().  Heck, for openat2, NOCTTY should be this defaul=
t.

O_EXCL: hopelessly overloaded.

O_APPEND, O_DIRECT, O_SYNC, O_DSYNC, O_LARGEFILE, O_NOATIME, O_PATH, O_NONBL=
OCK: genuine mode bits

O_CLOEXEC: special because it affects the fd, not the struct file.

Linus, you rejected resolveat() because you wanted a *nice* API that people w=
ould use and that might even be adopted by other OSes. Let=E2=80=99s please n=
ot make openat2() be a giant pile of crap in the name of consistency with op=
en().  open(), frankly, is horrible.
