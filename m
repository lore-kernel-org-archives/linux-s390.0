From: Sachin Sant <sachinp@in.ibm.com>
Subject: Next March 18: defconfig build break on s390
Date: Wed, 18 Mar 2009 15:51:09 +0530
Message-ID: <49C0CB15.1090308@in.ibm.com>
References: <20090318173830.7ea03dfb.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20090318173830.7ea03dfb.sfr@canb.auug.org.au>
Sender: linux-next-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-next/>
List-Post: <mailto:linux-next@vger.kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Today's next defconfig build on s390 fails with

In file included from arch/s390/include/asm/tlb.h:29,
from arch/s390/mm/init.c:36:
arch/s390/include/asm/tlbflush.h: In function __tlb_flush_full:
arch/s390/include/asm/tlbflush.h:54: error: incompatible type for argument 2 of cpumask_equal

In file included from arch/s390/kernel/smp.c:46:
arch/s390/include/asm/tlbflush.h: In function __tlb_flush_full:
arch/s390/include/asm/tlbflush.h:54: error: incompatible type for argument 2 of cpumask_equal

Thanks
-Sachin


-- 

---------------------------------
Sachin Sant
IBM Linux Technology Center
India Systems and Technology Labs
Bangalore, India
---------------------------------
