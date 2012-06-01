From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH 25/27] s390, smpboot: Use generic SMP booting
 infrastructure
Date: Fri, 1 Jun 2012 12:45:06 +0200
Message-ID: <20120601104506.GB3535@osiris.boeblingen.de.ibm.com>
References: <20120601090952.31979.24799.stgit@srivatsabhat.in.ibm.com>
 <20120601091604.31979.71351.stgit@srivatsabhat.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20120601091604.31979.71351.stgit@srivatsabhat.in.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Cc: tglx@linutronix.de, peterz@infradead.org, paulmck@linux.vnet.ibm.com, rusty@rustcorp.com.au, mingo@kernel.org, yong.zhang0@gmail.com, akpm@linux-foundation.org, vatsa@linux.vnet.ibm.com, rjw@sisk.pl, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, nikunj@linux.vnet.ibm.com, Martin Schwidefsky <schwidefsky@de.ibm.com>, "supporter:S390" <linux390@de.ibm.com>, Michael Holzheu <holzheu@linux.vnet.ibm.com>, Jan Glauber <jang@linux.vnet.ibm.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Fri, Jun 01, 2012 at 02:46:09PM +0530, Srivatsa S. Bhat wrote:
> Convert s390 to use the generic framework to boot secondary CPUs.
> 
> Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> Cc: linux390@de.ibm.com (supporter:S390)
> Cc: Michael Holzheu <holzheu@linux.vnet.ibm.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jan Glauber <jang@linux.vnet.ibm.com>
> Cc: linux-s390@vger.kernel.org
> Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
> ---
> 
>  arch/s390/kernel/smp.c |   12 ++++++------
>  1 files changed, 6 insertions(+), 6 deletions(-)
> 

Looks good to me.

Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>
