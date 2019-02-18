Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Mon, 18 Feb 2019 18:01:46 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH] s390/setup: fix early warning messages
In-Reply-To: <20190218154640.GA27699@roeck-us.net>
References: <20190218154640.GA27699@roeck-us.net>
MIME-Version: 1.0
Message-Id: <20190218180146.79930fe6@mschwideX1>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon, 18 Feb 2019 07:46:40 -0800
Guenter Roeck <linux@roeck-us.net> wrote:

> Hi,
> 
> On Thu, Feb 14, 2019 at 03:40:56PM +0100, Martin Schwidefsky wrote:
> > The setup_lowcore() function creates a new prefix page for the boot CPU.
> > The PSW mask for the system_call, external interrupt, i/o interrupt and
> > the program check handler have the DAT bit set in this new prefix page.
> > 
> > At the time setup_lowcore is called the system still runs without virtual
> > address translation, the paging_init() function creates the kernel page
> > table and loads the CR13 with the kernel ASCE.
> > 
> > Any code between setup_lowcore() and the end of paging_init() that has
> > a BUG or WARN statement will create a program check that can not be
> > handled correctly as there is no kernel page table yet.
> > 
> > To allow early WARN statements initially setup the lowcore with DAT off
> > and set the DAT bit only after paging_init() has completed.
> > 
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>  
> 
> This patch causes s390 qemu emulations to crash with a kernel stack overflow.
> Reverting the patch fixes the problem. Crash log and bisect results below.

Urgs, yes. That is EDAT-1 again that makes it work with 1MB pages but breaks
with 4K mapping where the prefix page is mapped to absolute zero.

Just using S390_lowcore instead of lowcore_ptr[0] does not work either
because low-address protection is already active. I'll think of something.

Thanks for bug report!

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
