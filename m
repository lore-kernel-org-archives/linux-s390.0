From: Sachin Sant <sachinp@in.ibm.com>
Subject: Next April 15: s390 allnoconfig build failure
Date: Wed, 15 Apr 2009 12:13:29 +0530
Message-ID: <49E58211.6040900@in.ibm.com>
References: <20090415144745.c4fb5c4b.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20090415144745.c4fb5c4b.sfr@canb.auug.org.au>
Sender: linux-next-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-next/>
List-Post: <mailto:linux-next@vger.kernel.org>
To: linux-s390@vger.kernel.org
Cc: linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Today's next tree build (s390 allnoconfig) failed with

arch/s390/kernel/ipl.c: In function 'stop_run':
arch/s390/kernel/ipl.c:1461: error: implicit declaration of function 
'signal_processor'
arch/s390/kernel/ipl.c:1461: error: 'sigp_stop' undeclared (first use in 
this function)
arch/s390/kernel/ipl.c:1461: error: (Each undeclared identifier is 
reported only once
arch/s390/kernel/ipl.c:1461: error: for each function it appears in.)
make[1]: *** [arch/s390/kernel/ipl.o] Error 1

Thanks
-Sachin


-- 

---------------------------------
Sachin Sant
IBM Linux Technology Center
India Systems and Technology Labs
Bangalore, India
---------------------------------
