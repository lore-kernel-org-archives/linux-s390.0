Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 28 Aug 2019 23:41:34 +0000
From: Changbin Du <changbin.du@gmail.com>
Subject: Re: [PATCH 01/11] ftrace: move recordmcount tools to scripts/ftrace
Message-ID: <20190828234133.quir3ptl4kidnxud@mail.google.com>
References: <20190825132330.5015-1-changbin.du@gmail.com>
 <20190825132330.5015-2-changbin.du@gmail.com>
 <20190826184444.09334ae9@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190826184444.09334ae9@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Changbin Du <changbin.du@gmail.com>, Ingo Molnar <mingo@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Jessica Yu <jeyu@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org, "John F . Reiser" <jreiser@BitWagon.com>, Matt Helsley <mhelsley@vmware.com>

On Mon, Aug 26, 2019 at 06:44:44PM -0400, Steven Rostedt wrote:
> On Sun, 25 Aug 2019 21:23:20 +0800
> Changbin Du <changbin.du@gmail.com> wrote:
> 
> > Move ftrace tools to its own directory. We will add another tool later.
> > 
> > Cc: John F. Reiser <jreiser@BitWagon.com>
> > Signed-off-by: Changbin Du <changbin.du@gmail.com>
> > ---
> >  scripts/.gitignore                   |  1 -
> >  scripts/Makefile                     |  2 +-
> >  scripts/Makefile.build               | 10 +++++-----
> >  scripts/ftrace/.gitignore            |  4 ++++
> >  scripts/ftrace/Makefile              |  4 ++++
> >  scripts/{ => ftrace}/recordmcount.c  |  0
> >  scripts/{ => ftrace}/recordmcount.h  |  0
> >  scripts/{ => ftrace}/recordmcount.pl |  0
> >  8 files changed, 14 insertions(+), 7 deletions(-)
> >  create mode 100644 scripts/ftrace/.gitignore
> >  create mode 100644 scripts/ftrace/Makefile
> >  rename scripts/{ => ftrace}/recordmcount.c (100%)
> >  rename scripts/{ => ftrace}/recordmcount.h (100%)
> >  rename scripts/{ => ftrace}/recordmcount.pl (100%)
> >  mode change 100755 => 100644
> 
> Note, we are in the process of merging recordmcount with objtool. It
> would be better to continue from that work.
> 
>  http://lkml.kernel.org/r/2767f55f4a5fbf30ba0635aed7a9c5ee92ac07dd.1563992889.git.mhelsley@vmware.com
> 
> -- Steve
Thanks for reminding. Let me check if prototype tool can merge into
objtool easily after above work.

-- 
Cheers,
Changbin Du
