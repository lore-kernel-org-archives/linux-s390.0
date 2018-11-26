Return-Path: <linux-kbuild-owner@vger.kernel.org>
Date: Mon, 26 Nov 2018 09:36:33 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [PATCH] pcmcia: remove per-arch PCMCIA config entry
Message-ID: <20181126083633.GA10604@light.dominikbrodowski.net>
References: <1543220141-13744-1-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1543220141-13744-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kbuild-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-kbuild/>
List-Post: <mailto:linux-kbuild@vger.kernel.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-kbuild@vger.kernel.org, Christoph Hellwig <hch@lst.de>, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Jeff Dike <jdike@addtoit.com>
List-ID: <linux-s390.vger.kernel.org>

On Mon, Nov 26, 2018 at 05:15:41PM +0900, Masahiro Yamada wrote:
> Now that all architectures include drivers/pcmcia/Kconfig where
> the PCMCIA config is defined, the PCMCIA config entries in per-arch
> Kconfig files are redundant.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
> I will queue this up to my kbuild tree
> along with Christoph's clean-up patch set.

Acked-by: Dominik Brodowski <linux@dominikbrodowski.net>

Thanks,
	Dominik
