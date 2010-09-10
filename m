From: Sachin Sant <sachinp@in.ibm.com>
Subject: [-next Sept 10] Build break - arch/s390/mm/pgtable.c (INIT_RCU_HEAD)
Date: Fri, 10 Sep 2010 13:43:20 +0530
Message-ID: <4C89E8A0.1050905@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
Sender: linux-next-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-next/>
List-Post: <mailto:linux-next@vger.kernel.org>
To: linux-s390@vger.kernel.org, "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Today's next fails to build on a s390 box with

arch/s390/mm/pgtable.c: In function 'rcu_table_freelist_finish':
arch/s390/mm/pgtable.c:79: error: implicit declaration of function 'INIT_RCU_HEAD'
make[2]: *** [arch/s390/mm/pgtable.o] Error 1

This code in question was added via following commit:

commit e726023d9ff7e4968e3e0622782174a4695d68a4
S390] lockless get_user_pages_fast()

Thanks
-Sachin

-- 

---------------------------------
Sachin Sant
IBM Linux Technology Center
India Systems and Technology Labs
Bangalore, India
---------------------------------
