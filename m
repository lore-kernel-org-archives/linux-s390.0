From: Sachin Sant <sachinp@in.ibm.com>
Subject: next Jan 6: drivers/s390/char/defkeymap build break
Date: Wed, 06 Jan 2010 14:44:24 +0530
Message-ID: <4B445470.8010402@in.ibm.com>
References: <20100106180342.43844983.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20100106180342.43844983.sfr@canb.auug.org.au>
Sender: linux-next-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-next/>
List-Post: <mailto:linux-next@vger.kernel.org>
To: linux-s390@vger.kernel.org
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, jason.wessel@windriver.com
List-ID: <linux-s390.vger.kernel.org>

Today's next fails to build on s390 with

 CC      drivers/s390/char/defkeymap.o
drivers/s390/char/defkeymap.c:30: error: static declaration of 'shift_map' follows non-static declaration
include/linux/keyboard.h:31: error: previous declaration of 'shift_map' was here
drivers/s390/char/defkeymap.c:49: error: static declaration of 'ctrl_map' follows non-static declaration
include/linux/keyboard.h:32: error: previous declaration of 'ctrl_map' was here
make[2]: *** [drivers/s390/char/defkeymap.o] Error 1
make[1]: *** [drivers/s390/char] Error 2

Probable cause could be commit 91570de..
kgdboc,keyboard: Keyboard driver for kdb with kgdb

Thanks
-Sachin

-- 

---------------------------------
Sachin Sant
IBM Linux Technology Center
India Systems and Technology Labs
Bangalore, India
---------------------------------
