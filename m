From: Sachin Sant <sachinp@in.ibm.com>
Subject: Next March 27 : s390 defconfig build failure
Date: Fri, 27 Mar 2009 19:27:04 +0530
Message-ID: <49CCDB30.7010203@in.ibm.com>
References: <20090327231924.4e4168c5.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20090327231924.4e4168c5.sfr@canb.auug.org.au>
Sender: linux-next-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-next/>
List-Post: <mailto:linux-next@vger.kernel.org>
To: linux-s390@vger.kernel.org
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, heiko.carstens@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

Today's Next defconfig s390 build failed with

arch/s390/hypfs/hypfs_diag.c: In function diag204_free_buffer:
arch/s390/hypfs/hypfs_diag.c:364: error: implicit declaration of function free_pages
arch/s390/hypfs/hypfs_diag.c: In function diag204_alloc_rbuf:
arch/s390/hypfs/hypfs_diag.c:384: error: implicit declaration of function __get_free_pages
arch/s390/hypfs/hypfs_diag.c:384: error: GFP_KERNEL undeclared (first use in this function)
arch/s390/hypfs/hypfs_diag.c:384: error: (Each undeclared identifier is reported only once
arch/s390/hypfs/hypfs_diag.c:384: error: for each function it appears in.)
arch/s390/hypfs/hypfs_diag.c:384: warning: cast to pointer from integer of different size
arch/s390/hypfs/hypfs_diag.c: In function diag224_get_name_table:
arch/s390/hypfs/hypfs_diag.c:503: error: implicit declaration of function kmalloc
arch/s390/hypfs/hypfs_diag.c:503: error: GFP_KERNEL undeclared (first use in this function)
arch/s390/hypfs/hypfs_diag.c:503: error: GFP_DMA undeclared (first use in this function)
arch/s390/hypfs/hypfs_diag.c:503: warning: assignment makes pointer from integer without a cast
arch/s390/hypfs/hypfs_diag.c:507: error: implicit declaration of function kfree

Thanks
-Sachin


-- 

---------------------------------
Sachin Sant
IBM Linux Technology Center
India Systems and Technology Labs
Bangalore, India
---------------------------------
