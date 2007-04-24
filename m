Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17965.35054.835790.275270@cargo.ozlabs.ibm.com>
Date: Tue, 24 Apr 2007 14:34:54 +1000
From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] powerpc pseries eeh: Convert to kthread API
In-Reply-To: <m1abwyv4oq.fsf@ebiederm.dsl.xmission.com>
References: <m1slawn9eb.fsf@ebiederm.dsl.xmission.com>
	<11769695763104-git-send-email-ebiederm@xmission.com>
	<20070422123155.GF20763@infradead.org>
	<20070423205020.GR31947@austin.ibm.com>
	<1177378733.14873.52.camel@localhost.localdomain>
	<m1ejmav80l.fsf@ebiederm.dsl.xmission.com>
	<1177382544.14873.57.camel@localhost.localdomain>
	<m1abwyv4oq.fsf@ebiederm.dsl.xmission.com>
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
Cc: "<Andrew Morton" <akpm@osdl.org>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, linuxppc-dev@ozlabs.org, containers@lists.osdl.org, Oleg Nesterov <oleg@tv-sign.ru>
List-ID: <linux-s390.vger.kernel.org>

Eric W. Biederman writes:

> Well the basic problem is that for any piece of code that can be modular
> we need a way to ensure all threads it has running are shutdown when we
> remove the module.

The EEH code can't be modular, and wouldn't make any sense to be
modular, since it's part of the infrastructure for accessing PCI
devices.

Paul.
