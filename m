Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Fri, 13 Aug 2010 15:45:31 +0900
Subject: Re: Latest git build failure on s390 - dma_get_cache_alignment()
From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
In-Reply-To: <AANLkTinnLY4LZ-3xbKEJVR3Qjw5xghRZ6i=tWfw8hJHH@mail.gmail.com>
References: <20100812075532.GA7814@osiris.boeblingen.de.ibm.com>
	<20100812080701.GB7814@osiris.boeblingen.de.ibm.com>
	<AANLkTinnLY4LZ-3xbKEJVR3Qjw5xghRZ6i=tWfw8hJHH@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <20100813154056S.fujita.tomonori@lab.ntt.co.jp>
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20100813064531.DLgBnK9xtsWWT2gAbOvEteYSL4ZJIdWfiWXbWFzV7Do@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: geert@linux-m68k.org, sfr@canb.auug.org.au
Cc: heiko.carstens@de.ibm.com, sachinp@in.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, fujita.tomonori@lab.ntt.co.jp, akpm@linux-foundation.org, linux-arch@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Thu, 12 Aug 2010 11:03:37 +0200
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> Seems Sun3 suffers from this as well:
> http://kisskb.ellerman.id.au/kisskb/buildresult/3022174/
> 
> <std_rant>
> Funny how these things never show up in linux-next...
> </std_rant>

Any chance to test the -mm tree on linux-next compile platform?
