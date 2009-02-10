From: "Sachin P. Sant" <sachinp@in.ibm.com>
Subject: Next Feb 10 : build/break arch/s390kernel.irq.o
Date: Tue, 10 Feb 2009 16:00:20 +0530
Message-ID: <4991573C.8000609@in.ibm.com>
References: <20090210194121.80256b72.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20090210194121.80256b72.sfr@canb.auug.org.au>
Sender: linux-next-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-next/>
List-Post: <mailto:linux-next@vger.kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, Mel Gorman <mel@csn.ul.ie>
List-ID: <linux-s390.vger.kernel.org>

randconfig build on s390 fails with

  CC      arch/s390/kernel/irq.o
arch/s390/kernel/irq.c:99: error: redefinition of init_irq_proc
include/linux/interrupt.h:475: error: previous definition of init_irq_proc was here
make[1]: *** [arch/s390/kernel/irq.o] Error 1
make: *** [arch/s390/kernel] Error 2

CONFIG_PROC_FS is not set. Probably introduced by commit
("Declare init_irq_proc before we use it.")

Thanks
-Sachin

-- 

---------------------------------
Sachin Sant
IBM Linux Technology Center
India Systems and Technology Labs
Bangalore, India
---------------------------------
