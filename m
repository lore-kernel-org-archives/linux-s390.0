Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Sun, 31 Jul 2016 09:25:46 -0400
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH] ftrace/jprobes/s390: Fix conflict between jprobes and
 function graph tracing
In-Reply-To: <20160731122114.GC12673@krava>
References: <1468848401-8091-1-git-send-email-jolsa@kernel.org>
	<20160728143933.1a2abc97@gandalf.local.home>
	<20160731122114.GC12673@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20160731092546.723c933c@mschwide>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Jiri Olsa <jolsa@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Jiri Olsa <jolsa@kernel.org>, lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, Michael Grundy <grundym@us.ibm.com>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Sun, 31 Jul 2016 14:21:14 +0200
Jiri Olsa <jolsa@redhat.com> wrote:

> On Thu, Jul 28, 2016 at 02:39:33PM -0400, Steven Rostedt wrote:
> > On Mon, 18 Jul 2016 15:26:41 +0200
> > Jiri Olsa <jolsa@kernel.org> wrote:
> > 
> > > This fixes the same issue Steven already fixed for x86
> > > in following commit:
> > > 
> > >   237d28db036e ftrace/jprobes/x86: Fix conflict between jprobes and function graph tracing
> > > 
> > > It fixes the crash, that happens when function graph tracing
> > > and jprobes are used simultaneously. Please refer to above
> > > commit for details.
> > 
> > I'm guessing that this should go in via the s390 tree.
> 
> oops, I forgot to CC s390 mailing list.. CC-ing now
> 
> I can repost if needed

This is not necessary. I have seen your original patch and could test
it now. As expected it crashes without the patch and works find with
your patch.

Applied to linux-s390. Thanks.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
