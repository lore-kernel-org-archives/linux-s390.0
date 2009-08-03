Return-Path: <linux-kernel-owner+w=401wt.eu-S1753524AbZHCIRg@vger.kernel.org>
Date: Mon, 3 Aug 2009 10:17:31 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH 2/2] s390: clean up linker script using new linker
 script macros.
Message-ID: <20090803101731.08443d17@skybase>
In-Reply-To: <1249073911-30208-2-git-send-email-tabbott@ksplice.com>
References: <1249073911-30208-1-git-send-email-tabbott@ksplice.com>
	<1249073911-30208-2-git-send-email-tabbott@ksplice.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Tim Abbott <tabbott@ksplice.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Sam Ravnborg <sam@ravnborg.org>, Anders Kaseorg <andersk@ksplice.com>, Nelson Elhage <nelhage@ksplice.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Fri, 31 Jul 2009 16:58:31 -0400
Tim Abbott <tabbott@ksplice.com> wrote:

> From: Nelson Elhage <nelhage@ksplice.com>
> 
> Note that this patch moves .data.init_task inside _edata.  In
> addition, the alignment of .init.ramfs changes: It is now PAGE_ALIGNED
> and __initramfs_end is arbitrarily aligned; Previously it was
> only aligned to a 0x100-byte boundary, and always ended on an even
> byte.
> 
> This change results in fewer output sections and in some data being
> reordered, but should have no functional effect.
> 
> Signed-off-by: Nelson Elhage <nelhage@ksplice.com>
> Signed-off-by: Tim Abbott <tabbott@ksplice.com>
> Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> Cc: linux-s390@vger.kernel.org

And this one will be added to git390 as well.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
