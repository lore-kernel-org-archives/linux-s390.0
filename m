From: Sachin Sant <sachinp@in.ibm.com>
Subject: [-next July 21] s390 build failure : kernel/workqueue.o
Date: Wed, 21 Jul 2010 16:10:35 +0530
Message-ID: <4C46CEA3.7040503@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
Sender: linux-next-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-next/>
List-Post: <mailto:linux-next@vger.kernel.org>
To: linux-s390@vger.kernel.org
Cc: linux-kernel <linux-kernel@vger.kernel.org>, "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Today's next fails to build on a s390 box with

  CC      kernel/workqueue.o
kernel/workqueue.c: In function 'init_workqueues':
kernel/workqueue.c:3525: error: negative width in bit-field '<anonymous>'
make[1]: *** [kernel/workqueue.o] Error 1

Yesterday's next was good.
The following patches added/changed the BUILD_BUG_ON() statement.

bdbc5dd7de5d07d6c9d3536e598956165a031d4c
        workqueue: prepare for WQ_UNBOUND implementation
7a22ad757ec75186ad43a5b4670fa7423ee8f480
         workqueue: carry cpu number in work data once execution starts

I have gcc version 4.3.2 installed on the system.

Thanks
-Sachin

-- 

---------------------------------
Sachin Sant
IBM Linux Technology Center
India Systems and Technology Labs
Bangalore, India
---------------------------------
