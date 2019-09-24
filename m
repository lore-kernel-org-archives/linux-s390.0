Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 24 Sep 2019 08:30:36 +0200
From: Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [PATCH] seccomp: remove unused arg from secure_computing()
Message-ID: <20190924063035.n3dmryhn6cb52ida@wittgenstein>
References: <20190920131907.6886-1-christian.brauner@ubuntu.com>
 <20190923094916.GB15355@zn.tnic>
 <CALCETrU_fs_At-hTpr231kpaAd0z7xJN4ku-DvzhRU6cvcJA_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALCETrU_fs_At-hTpr231kpaAd0z7xJN4ku-DvzhRU6cvcJA_w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>, LKML <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Kees Cook <keescook@chromium.org>, Will Drewry <wad@chromium.org>, Oleg Nesterov <oleg@redhat.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Parisc List <linux-parisc@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, linux-um@lists.infradead.org, X86 ML <x86@kernel.org>

On Mon, Sep 23, 2019 at 11:41:59AM -0700, Andy Lutomirski wrote:
> On Mon, Sep 23, 2019 at 2:49 AM Borislav Petkov <bp@alien8.de> wrote:
> >
> > On Fri, Sep 20, 2019 at 03:19:09PM +0200, Christian Brauner wrote:
> > > While touching seccomp code I realized that the struct seccomp_data
> > > argument to secure_computing() seems to be unused by all current
> > > callers. So let's remove it unless there is some subtlety I missed.
> > > Note, I only tested this on x86.
> >
> > What was amluto thinking in
> >
> > 2f275de5d1ed ("seccomp: Add a seccomp_data parameter secure_computing()")
> 
> IIRC there was a period of time in which x86 used secure_computing()
> for normal syscalls, and it was a good deal faster to have the arch
> code supply seccomp_data.  x86 no longer works like this, and syscalls
> aren't fast anymore ayway :(

I started looking at this and actually had a slightly bigger cleanup in
mind. It seems odd that we have secure_computing() and
__secure_computing(). Especially in the mips and x86 case. From what I
can tell they could both rely on secure_computing() and don't need
__secure_computing().
If I can make those changes, we can make __secure_computing() static and
have only a single function secure_computing() that is used by all
arches which would make this code simpler.
Apparenly mips once switched from secure_computing() to
__secure_computing() because of bpf and tracepoints. The last change to
this was:

commit 3d729deaf287c43e415c5d791c9ac8414dbeff70
Author: James Hogan <jhogan@kernel.org>
Date:   Fri Aug 11 21:56:50 2017 +0100

    MIPS: seccomp: Fix indirect syscall args

which references a broken samples/bpf/tracex5 test. But in the thread to
this last change Kees and others were less than sure that this makes
sense. So I'm not sure. Maybe I should just try and send it out...

Christian
