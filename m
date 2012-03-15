From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3] ipc: provide generic compat versions of IPC syscalls
Date: Thu, 15 Mar 2012 16:25:32 +0000
References: <201112091536.pB9Fa5f7002738@farm-0002.internal.tilera.com> <201112122148.pBCLmPH0023959@farm-0002.internal.tilera.com> <4F6144B8.5010601@tilera.com>
In-Reply-To: <4F6144B8.5010601@tilera.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201203151625.32199.arnd@arndb.de>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
Return-Path: <linux-mips-bounce@linux-mips.org>
List-Archive: <https://lore.kernel.org/linux-mips/>
List-Post: <mailto:linux-mips@vger.kernel.org>
To: Chris Metcalf <cmetcalf@tilera.com>
Cc: Ralf Baechle <ralf@linux-mips.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux390@de.ibm.com, "David S. Miller" <davem@davemloft.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Christoph Hellwig <hch@lst.de>, Lucas De Marchi <lucas.demarchi@profusion.mobi>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, "J. Bruce Fields" <bfields@redhat.com>, NeilBrown <neilb@suse.de>, linux-mips@linux-mips.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Thursday 15 March 2012, Chris Metcalf wrote:
> 
> Somewhat belatedly, I'm looking to push this through the "tile" tree. 
> Andrew Morton has been keeping it in his tree but I figure I should push it
> since it directly affects "tile" and currently no one else.

Sounds good.

> However, it would be nice if anyone could provide a Reviewed-by or Acked-by
> on the patch.  Thanks!

As the main author of ipc/compat.c in its current form,

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
