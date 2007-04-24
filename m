Return-Path: <ebiederm@xmission.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH] powerpc pseries eeh: Convert to kthread API
References: <m1slawn9eb.fsf@ebiederm.dsl.xmission.com>
	<11769695763104-git-send-email-ebiederm@xmission.com>
	<20070422123155.GF20763@infradead.org>
	<20070423205020.GR31947@austin.ibm.com>
	<1177378733.14873.52.camel@localhost.localdomain>
Date: Mon, 23 Apr 2007 20:08:42 -0600
In-Reply-To: <1177378733.14873.52.camel@localhost.localdomain> (Benjamin
	Herrenschmidt's message of "Tue, 24 Apr 2007 11:38:53 +1000")
Message-ID: <m1ejmav80l.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: "<Andrew Morton" <akpm@osdl.org>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>, containers@lists.osdl.org, Oleg Nesterov <oleg@tv-sign.ru>
List-ID: <linux-s390.vger.kernel.org>

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

>> The only reason for using threads here is to get the error recovery
>> out of an interrupt context (where errors may be detected), and then,
>> an hour later, decrement a counter (which is how we limit these to 
>> 6 per hour). Thread reaping is "trivial", the thread just exits
>> after an hour.
>
> In addition, it should be a thread and not done from within keventd
> because :
>
>  - It can take a long time (well, relatively but still too long for a
> work queue)
>
>  - The driver callbacks might need to use keventd or do flush_workqueue
> to synchronize with their own workqueues when doing an internal
> recovery.
>
>> Since these are events rare, I've no particular concern about
>> performance or resource consumption. The current code seems 
>> to work just fine. :-)
>
> I think moving to kthread's is cleaner (just a wrapper around kernel
> threads that simplify dealing with reaping them out mostly) and I agree
> with Christoph that it would be nice to be able to "fire off" kthreads
> from interrupt context.. in many cases, we abuse work queues for things
> that should really done from kthreads instead (basically anything that
> takes more than a couple hundred microsecs or so).

On that note does anyone have a problem is we manage the irq spawning
safe kthreads the same way that we manage the work queue entries.

i.e. by a structure allocated by the caller?

Eric
