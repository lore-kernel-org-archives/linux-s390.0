From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Subject: Re: Latest git build failure on s390 - dma_get_cache_alignment()
Date: Sat, 14 Aug 2010 16:39:15 +0900
Message-ID: <20100814163804N.fujita.tomonori@lab.ntt.co.jp>
References: <AANLkTinnLY4LZ-3xbKEJVR3Qjw5xghRZ6i=tWfw8hJHH@mail.gmail.com>
	<20100813154056S.fujita.tomonori@lab.ntt.co.jp>
	<20100813172752.4acd7089.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
In-Reply-To: <20100813172752.4acd7089.sfr@canb.auug.org.au>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: sfr@canb.auug.org.au
Cc: fujita.tomonori@lab.ntt.co.jp, geert@linux-m68k.org, heiko.carstens@de.ibm.com, sachinp@in.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, linux-arch@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Fri, 13 Aug 2010 17:27:52 +1000
Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> > Any chance to test the -mm tree on linux-next compile platform?
> 
> We do, I just have to remember to import the -mm tree manually.
> 
> See: http://kisskb.ellerman.id.au/kisskb/branch/14/

Ah, thanks! Seems that I need to track that.


> Even better would be to get most of the -mm tree into linux-next
> itself ... ;-)

Yeah, is there any way to push patches into both -mm and linux-next?
