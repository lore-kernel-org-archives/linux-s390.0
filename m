From: "Sachin P. Sant" <sachinp@in.ibm.com>
Subject: [s390] next Feb 18: defconfig build break
Date: Wed, 18 Feb 2009 15:59:20 +0530
Message-ID: <499BE300.5090405@in.ibm.com>
References: <20090218191640.0b023029.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20090218191640.0b023029.sfr@canb.auug.org.au>
Sender: linux-next-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-next/>
List-Post: <mailto:linux-next@vger.kernel.org>
To: linux-s390@vger.kernel.org
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

Next Feb 18 defconfig build on s390 fails with following error.

  CC      arch/s390/lib/string.o
In file included from include/linux/bitmap.h:8,
                 from include/linux/cpumask.h:142,
                 from include/linux/smp.h:12,
                 from /usr/local/autobench/var/tmp/build/linux/arch/s390/include/asm/spinlock.h:14,
                 from include/linux/spinlock.h:88,
                 from include/linux/seqlock.h:29,
                 from include/linux/time.h:8,
                 from include/linux/stat.h:60,
                 from include/linux/module.h:10,
                 from arch/s390/lib/string.c:13:
include/linux/string.h: In function 'strstarts':
include/linux/string.h:124: error: implicit declaration of function 'strlen'
include/linux/string.h:124: warning: incompatible implicit declaration of built-in function 'strlen'
make[1]: *** [arch/s390/lib/string.o] Error 1
make: *** [arch/s390/lib] Error 2

Thanks
-Sachin

-- 

---------------------------------
Sachin Sant
IBM Linux Technology Center
India Systems and Technology Labs
Bangalore, India
---------------------------------
