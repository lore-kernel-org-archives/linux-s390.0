Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17965.39866.351929.349735@cargo.ozlabs.ibm.com>
Date: Tue, 24 Apr 2007 15:55:06 +1000
From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] powerpc pseries eeh: Convert to kthread API
In-Reply-To: <20070422123155.GF20763@infradead.org>
References: <m1slawn9eb.fsf@ebiederm.dsl.xmission.com>
	<11769695763104-git-send-email-ebiederm@xmission.com>
	<20070422123155.GF20763@infradead.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: "<Andrew Morton" <akpm@osdl.org>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, "Eric W. Biederman" <ebiederm@xmission.com>, containers@lists.osdl.org, Oleg Nesterov <oleg@tv-sign.ru>
List-ID: <linux-s390.vger.kernel.org>

Christoph Hellwig writes:

> The first question is obviously, is this really something we want?
> spawning kernel thread on demand without reaping them properly seems
> quite dangerous.

What specifically has to be done to reap a kernel thread?  Are you
concerned about the number of threads, or about having zombies hanging
around?

Paul.
