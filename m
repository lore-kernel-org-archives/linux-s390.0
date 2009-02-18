From: Mike Frysinger <vapier.adi@gmail.com>
Subject: Re: [s390] next Feb 18: defconfig build break
Date: Wed, 18 Feb 2009 12:10:59 -0500
Message-ID: <8bd0f97a0902180910wafd35ceo47aeb9f3cc6733f3@mail.gmail.com>
References: <20090218191640.0b023029.sfr@canb.auug.org.au>
	 <499BE300.5090405@in.ibm.com>
	 <20090218224541.fe6e0355.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20090218224541.fe6e0355.sfr@canb.auug.org.au>
Sender: linux-next-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-next/>
List-Post: <mailto:linux-next@vger.kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: "Sachin P. Sant" <sachinp@in.ibm.com>, Rusty Russell <rusty@rustcorp.com.au>, linux-s390@vger.kernel.org, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On Wed, Feb 18, 2009 at 06:45, Stephen Rothwell wrote:
> On Wed, 18 Feb 2009 15:59:20 +0530 "Sachin P. Sant" wrote:
>> Next Feb 18 defconfig build on s390 fails with following error.
>>
>>   CC      arch/s390/lib/string.o
>> In file included from include/linux/bitmap.h:8,
>>                  from include/linux/cpumask.h:142,
>>                  from include/linux/smp.h:12,
>>                  from /usr/local/autobench/var/tmp/build/linux/arch/s390/include/asm/spinlock.h:14,
>>                  from include/linux/spinlock.h:88,
>>                  from include/linux/seqlock.h:29,
>>                  from include/linux/time.h:8,
>>                  from include/linux/stat.h:60,
>>                  from include/linux/module.h:10,
>>                  from arch/s390/lib/string.c:13:
>> include/linux/string.h: In function 'strstarts':
>> include/linux/string.h:124: error: implicit declaration of function 'strlen'
>> include/linux/string.h:124: warning: incompatible implicit declaration of built-in function 'strlen'
>> make[1]: *** [arch/s390/lib/string.o] Error 1
>> make: *** [arch/s390/lib] Error 2
>
> That would be a side effect of commit 43a47c6ca0e0b5479ae316e188a28b7e625d41e5 ("misc:strstarts") from the rr tree.  Rusty cc'd.

breaks all Blackfin ports as well:
In file included from include/linux/bitmap.h:9,
                 from include/linux/nodemask.h:90,
                 from include/linux/mmzone.h:17,
                 from include/linux/gfp.h:5,
                 from include/linux/kmod.h:23,
                 from include/linux/module.h:14,
                 from arch/blackfin/lib/strncmp.c:14:
include/linux/string.h: In function 'strstarts':
include/linux/string.h:124: error: implicit declaration of function 'strncmp'
make[1]: *** [arch/blackfin/lib/strncmp.o] Error 1
make: *** [arch/blackfin/lib] Error 2
-mike
