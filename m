Return-Path: <linas@austin.ibm.com>
Date: Tue, 24 Apr 2007 12:35:42 -0500
Subject: Re: [PATCH] powerpc pseries eeh: Convert to kthread API
Message-ID: <20070424173542.GY31947@austin.ibm.com>
References: <m1slawn9eb.fsf@ebiederm.dsl.xmission.com>
	<11769695763104-git-send-email-ebiederm@xmission.com>
	<20070422123155.GF20763@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070422123155.GF20763@infradead.org>
From: linas@austin.ibm.com (Linas Vepstas)
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
To: Christoph Hellwig <hch@infradead.org>, "Eric W. Biederman" <ebiederm@xmission.com>, "<Andrew Morton" <akpm@osdl.org>, containers@lists.osdl.org, Oleg Nesterov <oleg@tv-sign.ru>, linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>, linux-s390@vger.kernel.org, linuxppc-dev@ozlabs.org
List-ID: <linux-s390.vger.kernel.org>

On Thu, Apr 19, 2007 at 01:58:45AM -0600, Eric W. Biederman wrote:
> From: Eric W. Biederman <ebiederm@xmission.com>
> 
> This patch modifies the startup of eehd to use kthread_run
> not a combination of kernel_thread and daemonize.  Making
> the code slightly simpler and more maintainable.

For the patch that touched arch/powerpc/platforms/pseries/eeh_event.c,
I ran a variety of tests, and couldn't see/find/evoke any adverse
effects, so ..

Acked-by: Linas Vepstas <linas@austin.ibm.com>

> The second question is whether this is the right implementation.
> kthread_create already works by using a workqueue to create the thread
> and then waits for it.  If we really want to support creating threads
> asynchronously on demand we should have a proper API in kthread.c for
> this instead of spreading workqueues.

Yes, exactly; all I really want is to start a thread from an
interrupt context, and pass a structure to it.  This is pretty much
all that arch/powerpc/platforms/pseries/eeh_event.c is trying to do,
and little else.

--linas
