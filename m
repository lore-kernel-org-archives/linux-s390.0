From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 2/3] x86: query dynamic DEBUG_PAGEALLOC setting
Date: Tue, 2 Feb 2016 14:21:57 -0800
Message-ID: <20160202142157.1bfc6f81807faaa026957917@linux-foundation.org>
References: <1453889401-43496-1-git-send-email-borntraeger@de.ibm.com>
	<1453889401-43496-3-git-send-email-borntraeger@de.ibm.com>
	<alpine.DEB.2.10.1601271414180.23510@chino.kir.corp.google.com>
	<56A9E3D1.3090001@de.ibm.com>
	<alpine.DEB.2.10.1601281500160.31035@chino.kir.corp.google.com>
	<alpine.DEB.2.10.1602021351290.4977@chino.kir.corp.google.com>
	<56B12560.4010201@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
In-Reply-To: <56B12560.4010201@de.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: David Rientjes <rientjes@google.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net, Joonsoo Kim <iamjoonsoo.kim@lge.com>, davej@codemonkey.org.uk
List-ID: <linux-s390.vger.kernel.org>

On Tue, 2 Feb 2016 22:53:36 +0100 Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> >> I don't think we should have a CONFIG_DEBUG_PAGEALLOC that does some stuff 
> >> and then a commandline parameter or CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT 
> >> to enable more stuff.  It should either be all enabled by the commandline 
> >> (or config option) or split into a separate entity.  
> >> CONFIG_DEBUG_PAGEALLOC_LIGHT and CONFIG_DEBUG_PAGEALLOC would be fine, but 
> >> the current state is very confusing about what is being done and what 
> >> isn't.
> >>
> > 
> > Ping?
> > 
> https://lkml.org/lkml/2016/1/29/266 

That's already in linux-next so I can't apply it.

Well, I can, but it's a hassle.  What's happening here?
