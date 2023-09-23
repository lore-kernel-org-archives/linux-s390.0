Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B067CCE7A8C
	for <linux-s390@archiver.kernel.org>; Sat, 23 Sep 2023 15:41:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231878AbjIWPmD (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Sat, 23 Sep 2023 11:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbjIWPmC (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sat, 23 Sep 2023 11:42:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1560D100;
        Sat, 23 Sep 2023 08:41:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78B41C433C7;
        Sat, 23 Sep 2023 15:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695483716;
        bh=vXbqktT7b0Qri8xOnKmQsZG7jQ4zimMSvWYPtuArZ7U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bKxK0sfnvR6Mn54iFskJjz+iqQzT7d+5NzV6O/KDvtN3lXtUe/L3iPwKCcy9RJgP3
         mbD8bMb58MYWC7Tl7U7Pm9c2CxFIZly2LFF5bwScXgaoAZuVMJ1eJZhU6ecWVwTfEE
         r2oNyeJK2AahVHVr99AtDOSv5pGe23KHFoafNeDpxxm0mmvwtmbI1d6kPT0nWu68z/
         VE6hznLFs1/tWZv4nZKOvDCd21ai8PHSne6FmcZ1g1J53YE3NQHUgtGoEfJtdU67X3
         wLZ8mTH2uPqXeKbDrNozy3tf88DdS8OExFmk2KljS0ivcPxrGjBb2Vj5e645SQEJ/u
         hwwLepGJAxXyg==
Date:   Sat, 23 Sep 2023 18:40:59 +0300
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
Message-ID: <20230923154059.GJ3303@kernel.org>
References: <20230918072955.2507221-1-rppt@kernel.org>
 <20230918072955.2507221-3-rppt@kernel.org>
 <CAPhsuW7y2T+tajK71NfYhquhGJKpLpL+EoxxzqrVhEuAamDH3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW7y2T+tajK71NfYhquhGJKpLpL+EoxxzqrVhEuAamDH3w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, Sep 21, 2023 at 03:14:54PM -0700, Song Liu wrote:
> On Mon, Sep 18, 2023 at 12:30 AM Mike Rapoport <rppt@kernel.org> wrote:
> >
> [...]
> > +
> > +/**
> > + * enum execmem_type - types of executable memory ranges
> > + *
> > + * There are several subsystems that allocate executable memory.
> > + * Architectures define different restrictions on placement,
> > + * permissions, alignment and other parameters for memory that can be used
> > + * by these subsystems.
> > + * Types in this enum identify subsystems that allocate executable memory
> > + * and let architectures define parameters for ranges suitable for
> > + * allocations by each subsystem.
> > + *
> > + * @EXECMEM_DEFAULT: default parameters that would be used for types that
> > + * are not explcitly defined.
> > + * @EXECMEM_MODULE_TEXT: parameters for module text sections
> > + * @EXECMEM_KPROBES: parameters for kprobes
> > + * @EXECMEM_FTRACE: parameters for ftrace
> > + * @EXECMEM_BPF: parameters for BPF
> > + * @EXECMEM_TYPE_MAX:
> > + */
> > +enum execmem_type {
> > +       EXECMEM_DEFAULT,
> 
> I found EXECMEM_DEFAULT more confusing than helpful.

I hesitated a lot about that, but in the end decided to have
EXECMEM_DEFAULT and alias EXECMEM_MODULE_TEXT to it because this is what we
essentially have now for the most architectures.

If you'll take a look at arch-specific patches, in many cases there is only
EXECMEM_DEFAULT that an architecture defines and that default is used by
all the subsystems.
 
> Song
> 
> > +       EXECMEM_MODULE_TEXT = EXECMEM_DEFAULT,
> > +       EXECMEM_KPROBES,
> > +       EXECMEM_FTRACE,
> > +       EXECMEM_BPF,
> > +       EXECMEM_TYPE_MAX,
> > +};
> > +
> [...]

-- 
Sincerely yours,
Mike.
