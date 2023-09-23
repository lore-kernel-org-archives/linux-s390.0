Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BC00CE7A8E
	for <linux-s390@archiver.kernel.org>; Sat, 23 Sep 2023 15:43:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231895AbjIWPnn (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Sat, 23 Sep 2023 11:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbjIWPnn (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sat, 23 Sep 2023 11:43:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BBBD100;
        Sat, 23 Sep 2023 08:43:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09A27C433C7;
        Sat, 23 Sep 2023 15:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695483816;
        bh=ljgPDKGzFtkM9CGruxS2yf0TQKHwYcBRpz7ZIM8VO3w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UdoqwjNCGj6+dmcR2by5om8f6OGdHooNrFAdirAK1+mff8rgXeaENEbWOfJO5o/PC
         OJ43I0E8Te05bmcEVu+q3++C1e9dGOgWncbQbW9sES2Ibe2Pdsm+p44SaI/GSc9eJn
         k1TIpPAI+1+0z14moXMdYfGTEFg/c4FGc6F68knV28yyNaM4SU8WYGPaWhzn5xPNAt
         FG0AxN1gAVv9xHc/jH6GfcIvluITorwBbApgU2SfgTJcYKv7Yh/vBJZDq2ZFWWRfdD
         gacKAomGi0R18n+DQTrEIea+0KrDaRDhkeAyfdIkOyz1+kcZ1YK3P1S2X1RDLM9+UU
         ZFkbq4f/xAuEw==
Date:   Sat, 23 Sep 2023 18:42:40 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Song Liu <song@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "David S. Miller" <davem@davemloft.net>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Helge Deller <deller@gmx.de>,
        Huacai Chen <chenhuacai@kernel.org>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nadav Amit <nadav.amit@gmail.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Puranjay Mohan <puranjay12@gmail.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Russell King <linux@armlinux.org.uk>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, bpf@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-mm@kvack.org, linux-modules@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev,
        netdev@vger.kernel.org, sparclinux@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v3 02/13] mm: introduce execmem_text_alloc() and
 execmem_free()
Message-ID: <20230923154240.GK3303@kernel.org>
References: <20230918072955.2507221-1-rppt@kernel.org>
 <20230918072955.2507221-3-rppt@kernel.org>
 <CAPhsuW4bQY5fo_+K2z4uUdd4r0wYF1eT3bAya=YqcEcmqdGXvg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW4bQY5fo_+K2z4uUdd4r0wYF1eT3bAya=YqcEcmqdGXvg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, Sep 21, 2023 at 03:10:26PM -0700, Song Liu wrote:
> On Mon, Sep 18, 2023 at 12:30 AM Mike Rapoport <rppt@kernel.org> wrote:
> >
> [...]
> > +
> > +#include <linux/mm.h>
> > +#include <linux/vmalloc.h>
> > +#include <linux/execmem.h>
> > +#include <linux/moduleloader.h>
> > +
> > +static void *execmem_alloc(size_t size)
> > +{
> > +       return module_alloc(size);
> > +}
> > +
> > +void *execmem_text_alloc(enum execmem_type type, size_t size)
> > +{
> > +       return execmem_alloc(size);
> > +}
> 
> execmem_text_alloc (and later execmem_data_alloc) both take "type" as
> input. I guess we can just use execmem_alloc(type, size) for everything?

We could but I still prefer to keep this distinction.
 
> Thanks,
> Song
> 
> > +
> > +void execmem_free(void *ptr)
> > +{
> > +       /*
> > +        * This memory may be RO, and freeing RO memory in an interrupt is not
> > +        * supported by vmalloc.
> > +        */
> > +       WARN_ON(in_interrupt());
> > +       vfree(ptr);
> > +}
> > --
> > 2.39.2
> >

-- 
Sincerely yours,
Mike.
