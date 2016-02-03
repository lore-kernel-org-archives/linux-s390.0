From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH 1/5] all: s390: move wrapper infrastructure to generic
 headers
Date: Wed, 3 Feb 2016 09:01:59 +0100
Message-ID: <20160203080159.GA3369@osiris>
References: <1453741047-5498-1-git-send-email-ynorov@caviumnetworks.com>
 <1453741047-5498-2-git-send-email-ynorov@caviumnetworks.com>
 <20160128121618.GB5418@osiris>
 <20160128163109.GA8529@yury-N73SV>
 <20160201114251.GB973@yury-N73SV>
 <20160202073913.GB3990@osiris>
 <20160202154331.GA3003@yury-N73SV>
 <20160202160826.GF3990@osiris>
 <20160202195434.GA3397@osiris>
 <20160202204156.GA27290@yury-N73SV>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160202204156.GA27290@yury-N73SV>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Yury Norov <ynorov@caviumnetworks.com>
Cc: linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, arnd@arndb.de, pinskia@gmail.com, Prasun.Kapoor@caviumnetworks.com, catalin.marinas@arm.com, Nathan_Lynch@mentor.com, linux-kernel@vger.kernel.org, agraf@suse.de, klimov.linux@gmail.com, broonie@kernel.org, joseph@codesourcery.com, schwidefsky@de.ibm.com, linux-arm-kernel@lists.infradead.org, christoph.muellner@theobroma-systems.com
List-ID: <linux-s390.vger.kernel.org>

On Tue, Feb 02, 2016 at 11:41:56PM +0300, Yury Norov wrote:
> On Tue, Feb 02, 2016 at 08:54:34PM +0100, Heiko Carstens wrote:
> > So I think I can summarize my point to: if you can enforce correctness, why
> > shouldn't you do it if the performance impact is only a single instruction.
> 
> For aarch64 it's 5 instructions. But what's more important (if ever),
> another wrapper takes another i-cache line...
>         <compat_SyS_ftruncate>:
>         stp     x29, x30, [sp,#-16]!
>         mov     x29, sp
>         bl      d40 <do_sys_ftruncate.constprop.3>
>         ldp     x29, x30, [sp],#16
>         ret

Why does gcc allocate a stackframe here? Don't you have tail call
optimization?
