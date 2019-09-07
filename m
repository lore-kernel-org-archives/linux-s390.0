Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39556 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388065AbfIGRp4 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sat, 7 Sep 2019 13:45:56 -0400
Received: by mail-lj1-f196.google.com with SMTP id j16so8914091ljg.6
        for <linux-s390@vger.kernel.org>; Sat, 07 Sep 2019 10:45:55 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id d14sm1802876lfi.14.2019.09.07.10.45.51
        for <linux-s390@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Sep 2019 10:45:52 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id 7so8880423ljw.7
        for <linux-s390@vger.kernel.org>; Sat, 07 Sep 2019 10:45:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190904201933.10736-1-cyphar@cyphar.com> <20190904201933.10736-12-cyphar@cyphar.com>
 <7236f382d72130f2afbbe8940e72cc67e5c6dce0.camel@kernel.org>
 <CAHk-=whZx97Nm-gUK0ppofj2RA2LLz2vmaDUTKSSV-+yYB9q_Q@mail.gmail.com> <C81D6D29-F6BF-48E6-A15E-3ABCB2C992E5@amacapital.net>
In-Reply-To: <C81D6D29-F6BF-48E6-A15E-3ABCB2C992E5@amacapital.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 7 Sep 2019 10:45:33 -0700
Message-ID: <CAHk-=whe90Ec_RRrMRLE0=bJOHNS9YmVwcytVxmrfK3oCuZF6A@mail.gmail.com>
Subject: Re: [PATCH v12 11/12] open: openat2(2) syscall
Content-Type: text/plain; charset="UTF-8"
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Andy Lutomirski <luto@amacapital.net>
Cc: Jeff Layton <jlayton@kernel.org>, Aleksa Sarai <cyphar@cyphar.com>, Al Viro <viro@zeniv.linux.org.uk>, "J. Bruce Fields" <bfields@fieldses.org>, Arnd Bergmann <arnd@arndb.de>, David Howells <dhowells@redhat.com>, Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Christian Brauner <christian@brauner.io>, Eric Biederman <ebiederm@xmission.com>, Andy Lutomirski <luto@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Alexei Starovoitov <ast@kernel.org>, Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>, Tycho Andersen <tycho@tycho.ws>, David Drysdale <drysdale@google.com>, Chanho Min <chanho.min@lge.com>, Oleg Nesterov <oleg@redhat.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Aleksa Sarai <asarai@suse.de>, Linux Containers <containers@lists.linux-foundation.org>, alpha <linux-alpha@vger.kernel.org>, Linux API <linux-api@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-ia64@vger.kernel.org, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390 <linux-s390@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, linux-xtensa@linux-xtensa.org, sparclinux@vger.kernel.org

On Sat, Sep 7, 2019 at 10:42 AM Andy Lutomirski <luto@amacapital.net> wrote:
>
> Linus, you rejected resolveat() because you wanted a *nice* API

No. I rejected resoveat() because it was a completely broken garbage
API that couldn't do even basic stuff right (like O_CREAT).

We have a ton of flag space in the new openat2() model, we might as
well leave the old flags alone that people are (a) used to and (b) we
have code to support _anyway_.

Making up a new flag namespace is only going to cause us - and users -
more work, and more confusion. For no actual advantage. It's not going
to be "cleaner". It's just going to be worse.

                 Linus
