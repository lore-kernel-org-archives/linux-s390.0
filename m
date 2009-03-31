Return-Path: <linux-kernel-owner+w=401wt.eu-S1757637AbZCaOXd@vger.kernel.org>
Message-ID: <49D22740.5090603@in.ibm.com>
Date: Tue, 31 Mar 2009 19:52:56 +0530
From: Sachin Sant <sachinp@in.ibm.com>
MIME-Version: 1.0
Subject: [s390] 2.6.29-git8 build failure.
References: <49CF1881.7010206@in.ibm.com>
In-Reply-To: <49CF1881.7010206@in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: heiko.carstens@de.ibm.com
Cc: linux-s390@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

Sachin Sant wrote:
> 2.6.29-git4 build failed on s390 box with
>
>  CC      drivers/char/sysrq.o
> In file included from drivers/char/sysrq.c:38:
> include/linux/irq.h: In function 'init_alloc_desc_masks':
> include/linux/irq.h:434: error: dereferencing pointer to incomplete type
> include/linux/irq.h:435: error: dereferencing pointer to incomplete type
> include/linux/irq.h:446: error: dereferencing pointer to incomplete type
> include/linux/irq.h:448: error: dereferencing pointer to incomplete type
The above mentioned defconfig build failure can still be
recreated with 2.6.29-git8 release.

Looks like the patch[1] to fix this failure still hasn't made
it's way into Linus tree.

Regards
-Sachin

[1] -> http://marc.info/?l=linux-mm-commits&m=123360349631362&w=4

-- 

---------------------------------
Sachin Sant
IBM Linux Technology Center
India Systems and Technology Labs
Bangalore, India
---------------------------------
