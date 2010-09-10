From: Sachin Sant <sachinp@in.ibm.com>
Subject: Re: [-next Sept 9] S309 Build break (mm/percpu.c)
Date: Fri, 10 Sep 2010 11:39:33 +0530
Message-ID: <4C89CB9D.6010005@in.ibm.com>
References: <4C88D48A.3070702@in.ibm.com> <4C88EE00.70004@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <4C88EE00.70004@kernel.org>
Sender: linux-next-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-next/>
List-Post: <mailto:linux-next@vger.kernel.org>
To: Tejun Heo <tj@kernel.org>
Cc: "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel <linux-kernel@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

Tejun Heo wrote:
> Commit bbddff05 (percpu: use percpu allocator on UP too) incorrectly
> excluded pcpu_build_alloc_info() on SMP configurations which use
> generic setup_per_cpu_area() like s390.  The config ifdefs are
> becoming confusing.  Fix and clean it up by,
>
> * Move pcpu_build_alloc_info() right on top of its two users -
>   pcpu_{embed|page}_first_chunk() which are already in CONFIG_SMP
>   block.
>
> * Define BUILD_{EMBED|PAGE}_FIRST_CHUNK which indicate whether each
>   first chunk function needs to be included and use them to control
>   inclusion of the three functions to reduce confusion.
>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Reported-by: Sachin Sant <sachinp@in.ibm.com>
> ---
> Can you please test this patch?
>   
Tested the patch against yesterday's next release(20100909). Works fine.

Thanks Tejun.

Regards
-Sachin

-- 

---------------------------------
Sachin Sant
IBM Linux Technology Center
India Systems and Technology Labs
Bangalore, India
---------------------------------
