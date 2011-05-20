Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 20 May 2011 13:01:21 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [RFC][PATCH] maccess,probe_kernel: Make write/read src const
 void *
Message-ID: <20110520130121.31a3ef5a@mschwide>
In-Reply-To: <1305824936.1465.4.camel@gandalf.stny.rr.com>
References: <1305824936.1465.4.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Mike Frysinger <vapier@gentoo.org>, uclinux-dist-devel <uclinux-dist-devel@blackfin.uclinux.org>
List-ID: <linux-s390.vger.kernel.org>

On Thu, 19 May 2011 13:08:56 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> maccess,probe_kernel: Make src const void *
> 
> The functions probe_kernel_write() and probe_kernel_read() do not modify
> the src pointer. Allow const pointers to be passed in without the need
> of a typecast.
> 
> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Acked-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
