Return-Path: <SRS0+69c4ad7734d58a9362c9+1337+infradead.org+hch@pentafluge.srs.infradead.org>
Date: Sun, 22 Apr 2007 13:31:55 +0100
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] powerpc pseries eeh: Convert to kthread API
Message-ID: <20070422123155.GF20763@infradead.org>
References: <m1slawn9eb.fsf@ebiederm.dsl.xmission.com>
	<11769695763104-git-send-email-ebiederm@xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <11769695763104-git-send-email-ebiederm@xmission.com>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "<Andrew Morton" <akpm@osdl.org>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>, containers@lists.osdl.org, Oleg Nesterov <oleg@tv-sign.ru>
List-ID: <linux-s390.vger.kernel.org>

On Thu, Apr 19, 2007 at 01:58:45AM -0600, Eric W. Biederman wrote:
> From: Eric W. Biederman <ebiederm@xmission.com>
> 
> This patch modifies the startup of eehd to use kthread_run
> not a combination of kernel_thread and daemonize.  Making
> the code slightly simpler and more maintainable.

This one has the same scheme as the various s390 drivers where a thread
is spawned using a workqueue on demand.  I think we should not blindly
convert it but think a litte more about it.

The first question is obviously, is this really something we want?
spawning kernel thread on demand without reaping them properly seems
quite dangerous.

The second question is whether this is the right implementation.
kthread_create already works by using a workqueue to create the thread
and then waits for it.  If we really want to support creating threads
asynchronously on demand we should have a proper API in kthread.c for
this instead of spreading workqueues.
