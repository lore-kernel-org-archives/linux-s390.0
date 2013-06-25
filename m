Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Tue, 25 Jun 2013 08:50:06 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [Suggestion] arch: s390: mm: the warnings with allmodconfig and
 "EXTRA_CFLAGS=-W"
Message-ID: <20130625085006.01a7f368@mschwide>
In-Reply-To: <51C8F861.9010101@asianux.com>
References: <51C8F685.6000209@asianux.com>
	<51C8F861.9010101@asianux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20130625065006.9nVf-cqdfTs0BrmaOdm4f8CQDGItep_9cSWKJDxCLyk@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Chen Gang <gang.chen@asianux.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, linux390@de.ibm.com, cornelia.huck@de.ibm.com, mtosatti@redhat.com, Thomas Gleixner <tglx@linutronix.de>, linux-s390@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, linux-mm@kvack.org
List-ID: <linux-s390.vger.kernel.org>

On Tue, 25 Jun 2013 09:54:41 +0800
Chen Gang <gang.chen@asianux.com> wrote:

> Hello Maintainers:
> 
> When allmodconfig for " IBM zSeries model z800 and z900"
> 
> It will report the related warnings ("EXTRA_CFLAGS=-W"):
>   mm/slub.c:1875:1: warning: ‘deactivate_slab’ uses dynamic stack allocation [enabled by default]
>   mm/slub.c:1941:1: warning: ‘unfreeze_partials.isra.32’ uses dynamic stack allocation [enabled by default]
>   mm/slub.c:2575:1: warning: ‘__slab_free’ uses dynamic stack allocation [enabled by default]
>   mm/slub.c:1582:1: warning: ‘get_partial_node.isra.34’ uses dynamic stack allocation [enabled by default]
>   mm/slub.c:2311:1: warning: ‘__slab_alloc.constprop.42’ uses dynamic stack allocation [enabled by default]
> 
> Is it OK ?

Yes, these warnings should be ok. They are enabled by CONFIG_WARN_DYNAMIC_STACK,
the purpose is to find all functions with dynamic stack allocations. The check
if the allocations are truly ok needs to be done manually as the compiler
can not find out the maximum allocation size automatically.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
