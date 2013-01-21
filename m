Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 2/5] jump label: constify lookup functions
In-Reply-To: <1358544300.7383.37.camel@gandalf.local.home>
References: <1357772960-4436-1-git-send-email-sasha.levin@oracle.com> <1357772960-4436-2-git-send-email-sasha.levin@oracle.com> <1358544300.7383.37.camel@gandalf.local.home>
Date: Mon, 21 Jan 2013 17:21:06 +1030
Message-ID: <87sj5vuizp.fsf@rustcorp.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>, Sasha Levin <sasha.levin@oracle.com>
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, fweisbec@gmail.com, ananth@in.ibm.com, anil.s.keshavamurthy@intel.com, masami.hiramatsu.pt@hitachi.com, jbaron@redhat.com, x86@kernel.org, linux-kernel@vger.kernel.org, MartinSchwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

Steven Rostedt <rostedt@goodmis.org> writes:
> On Wed, 2013-01-09 at 18:09 -0500, Sasha Levin wrote:
>> Modify the parameters of all the lookup and the bookkeeping functions which
>> should be const to const.
>> 
>> For example, jump_label_text_reserved() doesn't modify the memory it works on,
>> it just checks whether there are any jump labels there.
>
> This is dependent on the module patch, which Rusty is taking. I need to
> see that he has it before this can go in. At least see it in linux-next.
>
> Also, you should have Cc'd the linux-arch mailing list. I'll send it
> there.

I've put it in now.

Thanks,
Rusty.
