Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:8894 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726194AbgG3Hfa (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 30 Jul 2020 03:35:30 -0400
Message-ID: <247044acbf1dbae8e3b48c2dcc1457cd2e59cfef.camel@linux.ibm.com>
Subject: Re: [PATCH] s390/test_unwind: fix possible memleak in test_unwind()
From: Ilya Leoshkevich <iii@linux.ibm.com>
Date: Thu, 30 Jul 2020 09:35:15 +0200
In-Reply-To: <20200730063602.31581-1-wanghai38@huawei.com>
References: <20200730063602.31581-1-wanghai38@huawei.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Wang Hai <wanghai38@huawei.com>, hca@linux.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com, colin.king@canonical.com
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 2020-07-30 at 14:36 +0800, Wang Hai wrote:
> test_unwind() misses to call kfree(bt) in an error path.
> Add the missed function call to fix it.
> 
> Fixes: 0610154650f1 ("s390/test_unwind: print verbose unwinding
> results")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wang Hai <wanghai38@huawei.com>
> ---
>  arch/s390/lib/test_unwind.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/s390/lib/test_unwind.c
> b/arch/s390/lib/test_unwind.c
> index 32b7a30b2485..b0b12b46bc57 100644
> --- a/arch/s390/lib/test_unwind.c
> +++ b/arch/s390/lib/test_unwind.c
> @@ -63,6 +63,7 @@ static noinline int test_unwind(struct task_struct
> *task, struct pt_regs *regs,
>  			break;
>  		if (state.reliable && !addr) {
>  			pr_err("unwind state reliable but addr is
> 0\n");
> +			kfree(bt);
>  			return -EINVAL;
>  		}
>  		sprint_symbol(sym, addr);

Looks good to me, thanks!

Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>
