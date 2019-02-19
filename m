Return-Path: <linux-kbuild-owner@vger.kernel.org>
Date: Tue, 19 Feb 2019 16:17:59 +0100
From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 02/11] riscv: remove the HAVE_KPROBES option
Message-ID: <20190219151759.GD4121@lst.de>
References: <20190213174005.28785-1-hch@lst.de> <20190213174005.28785-3-hch@lst.de> <CAK7LNAQFSQN=42X1dqt5io+gOG8mUpwXhLmspqryvmzakUCSWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNAQFSQN=42X1dqt5io+gOG8mUpwXhLmspqryvmzakUCSWw@mail.gmail.com>
Sender: linux-kbuild-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-kbuild/>
List-Post: <mailto:linux-kbuild@vger.kernel.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-xtensa@linux-xtensa.org, linux-s390 <linux-s390@vger.kernel.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-riscv@lists.infradead.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-ID: <linux-s390.vger.kernel.org>

On Fri, Feb 15, 2019 at 06:32:07PM +0900, Masahiro Yamada wrote:
> On Thu, Feb 14, 2019 at 2:40 AM Christoph Hellwig <hch@lst.de> wrote:
> >
> > HAVE_KPROBES is defined genericly in arch/Kconfig and architectures
> > should just select it if supported.
> >
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> Do you want this patch picked up by me?
> 
> Or, by Palmer?

Given that I don't think I'll have the rest of this series respun in time
for this merge window:  Palmer, can you pick it up?
