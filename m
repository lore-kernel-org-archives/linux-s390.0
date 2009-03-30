From: Sachin Sant <sachinp@in.ibm.com>
Subject: Re: Next March 27 : s390 defconfig build failure
Date: Mon, 30 Mar 2009 15:21:37 +0530
Message-ID: <49D09629.2010706@in.ibm.com>
References: <20090327231924.4e4168c5.sfr@canb.auug.org.au> <49CCDB30.7010203@in.ibm.com> <20090327154027.55afeb02@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20090327154027.55afeb02@osiris.boeblingen.de.ibm.com>
Sender: linux-next-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-next/>
List-Post: <mailto:linux-next@vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-s390@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Heiko Carstens wrote:
> Thanks for reporting. Ingo, could you pick up the patch below please?
>
> Subject: [PATCH] s390/hypfs: fix build breakage
>
> From: Heiko Carstens <heiko.carstens@de.ibm.com>
>
> Fix build breakage below which probably was introduced with
> ("rcu: don't include unnecessary headers, allow kmemtrace w/ tracepoints").
>
>   CC      arch/s390/hypfs/hypfs_diag.o
> arch/s390/hypfs/hypfs_diag.c: In function 'diag204_free_buffer':
> arch/s390/hypfs/hypfs_diag.c:364: error: implicit declaration of function 'free_pages'
> arch/s390/hypfs/hypfs_diag.c: In function 'diag204_alloc_rbuf':
> arch/s390/hypfs/hypfs_diag.c:384: error: implicit declaration of function '__get_free_pages'
> arch/s390/hypfs/hypfs_diag.c:384: error: 'GFP_KERNEL' undeclared (first use in this function)
> arch/s390/hypfs/hypfs_diag.c:384: error: (Each undeclared identifier is reported only once
> arch/s390/hypfs/hypfs_diag.c:384: error: for each function it appears in.)
>
> Reported-by: Sachin Sant <sachinp@in.ibm.com>
> Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
> ---
>   
Today's next tree also has this build failure and the above mentioned
patch fixes the issue.

Tested-by : Sachin Sant <sachinp@in.ibm.com>

Thanks
-Sachin


-- 

---------------------------------
Sachin Sant
IBM Linux Technology Center
India Systems and Technology Labs
Bangalore, India
---------------------------------
