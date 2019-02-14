Return-Path: <linux-kbuild-owner@vger.kernel.org>
From: Andreas Schwab <schwab@suse.de>
Subject: Re: [PATCH 01/11] powerpc: remove dead ifdefs in <asm/checksum.h>
References: <20190213174005.28785-1-hch@lst.de>
        <20190213174005.28785-2-hch@lst.de>
Date: Thu, 14 Feb 2019 09:54:17 +0100
In-Reply-To: <20190213174005.28785-2-hch@lst.de> (Christoph Hellwig's message
        of "Wed, 13 Feb 2019 18:39:55 +0100")
Message-ID: <mvma7iyrbra.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kbuild-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-kbuild/>
List-Post: <mailto:linux-kbuild@vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, linux-xtensa@linux-xtensa.org, linux-s390@vger.kernel.org, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
List-ID: <linux-s390.vger.kernel.org>

On Feb 13 2019, Christoph Hellwig <hch@lst.de> wrote:

> __KERNEL__ is never not defined for non-uapi headers, and GENERIC_CSUM

"... never not ... non-..."  That's a bit too negative, I think.  :-)

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
