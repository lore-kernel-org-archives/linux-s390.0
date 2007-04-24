Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc pseries eeh: Convert to kthread API
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <m1abwyv4oq.fsf@ebiederm.dsl.xmission.com>
References: <m1slawn9eb.fsf@ebiederm.dsl.xmission.com>
	<11769695763104-git-send-email-ebiederm@xmission.com>
	<20070422123155.GF20763@infradead.org>
	<20070423205020.GR31947@austin.ibm.com>
	<1177378733.14873.52.camel@localhost.localdomain>
	<m1ejmav80l.fsf@ebiederm.dsl.xmission.com>
	<1177382544.14873.57.camel@localhost.localdomain>
	<m1abwyv4oq.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain
Date: Tue, 24 Apr 2007 15:00:42 +1000
Message-Id: <1177390842.14873.94.camel@localhost.localdomain>
Mime-Version: 1.0
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


> Further in general it doesn't make sense to grab a module reference
> and call that sufficient because we would like to request that the
> module exits.

Which is, btw, I think a total misdesign of our module stuff, but heh, I
remember that lead to some flamewars back then...

Like anything else, modules should have separated the entrypoints for

 - Initiating a removal request
 - Releasing the module

The former is use did "rmmod", can unregister things from subsystems,
etc... (and can file if the driver decides to refuse removal requests
when it's busy doing things or whatever policy that module wants to
implement).

The later is called when all references to the modules have been
dropped, it's a bit like the kref "release" (and could be implemented as
one).

If we had done that (simple) thing back then, module refcounting would
have been much less of a problem... I remember some reasons why that was
veto'ed but I didn't and still don't agree.

Ben.
