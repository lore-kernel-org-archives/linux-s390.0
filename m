Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc pseries eeh: Convert to kthread API
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <m1zm4ytjhg.fsf@ebiederm.dsl.xmission.com>
References: <m1slawn9eb.fsf@ebiederm.dsl.xmission.com>
	<11769695763104-git-send-email-ebiederm@xmission.com>
	<20070422123155.GF20763@infradead.org>
	<20070423205020.GR31947@austin.ibm.com>
	<1177378733.14873.52.camel@localhost.localdomain>
	<m1ejmav80l.fsf@ebiederm.dsl.xmission.com>
	<1177382544.14873.57.camel@localhost.localdomain>
	<m1abwyv4oq.fsf@ebiederm.dsl.xmission.com>
	<1177390842.14873.94.camel@localhost.localdomain>
	<m1zm4ytjhg.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain
Date: Tue, 24 Apr 2007 15:58:22 +1000
Message-Id: <1177394302.14873.97.camel@localhost.localdomain>
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

> Since we need to have some way to track them having an explicit data
> structure that the callers manage seems to make sense.

Oh sure, I wasn't arguing against that at all...

It might be handy to have a release() callback (optional) that gets
called after the kthread stops/exits, once we know the data structure
isn't going to be used anymore (if practical to implement, depends on
your approach).

Ben.
