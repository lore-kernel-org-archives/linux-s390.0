Return-Path: <ebiederm@xmission.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH] powerpc pseries eeh: Convert to kthread API
References: <m1slawn9eb.fsf@ebiederm.dsl.xmission.com>
	<11769695763104-git-send-email-ebiederm@xmission.com>
	<20070422123155.GF20763@infradead.org>
	<20070423205020.GR31947@austin.ibm.com>
	<1177378733.14873.52.camel@localhost.localdomain>
	<m1ejmav80l.fsf@ebiederm.dsl.xmission.com>
	<1177382544.14873.57.camel@localhost.localdomain>
Date: Mon, 23 Apr 2007 21:20:37 -0600
In-Reply-To: <1177382544.14873.57.camel@localhost.localdomain> (Benjamin
	Herrenschmidt's message of "Tue, 24 Apr 2007 12:42:24 +1000")
Message-ID: <m1abwyv4oq.fsf@ebiederm.dsl.xmission.com>
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

> Not sure... I can see places where I might want to spawn an arbitrary
> number of these without having to preallocate structures... and if I
> allocate on the fly, then I need a way to free that structure when the
> kthread is reaped which I don't think we have currently, do we ? (In
> fact, I could use that for other things too now that I'm thinking of
> it ... I might have a go at providing optional kthread destructors).

Well the basic problem is that for any piece of code that can be modular
we need a way to ensure all threads it has running are shutdown when we
remove the module.

Which means a fire and forget model however simple is unfortunately
the wrong thing.

Now we might be able to wrap this in some kind of manager construct,
so you don't have to manage each thread individually, but we still
have the problem of ensuring all of the threads exit when we terminate
the module.

Further in general it doesn't make sense to grab a module reference
and call that sufficient because we would like to request that the
module exits.

Eric
