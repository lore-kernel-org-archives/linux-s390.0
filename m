Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <5370F583.1090207@intel.com>
Date: Tue, 13 May 2014 00:23:31 +0800
From: Jet Chen <jet.chen@intel.com>
MIME-Version: 1.0
Subject: Re: [sched] BUG: unable to handle kernel paging request at 093cd001
References: <5370DC83.3030406@intel.com> <1399905820-16943-1-git-send-email-vincent.guittot@linaro.org>
In-Reply-To: <1399905820-16943-1-git-send-email-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: mingo@kernel.org, fengguang.wu@intel.com, linux-ia64@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 05/12/2014 10:43 PM, Vincent Guittot wrote:
> Hi,
> 
> Sorry the previous patch, that i sent, becomes wrong after optimizing it
> Could you please try this one ?

Hi Vincent, this patch works. Thanks.

Tested-by: Jet Chen <jet.chen@intel.com>

> 
> Regards,
> Vincent
> ---
>  kernel/sched/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 4ea7b3f..205fa17 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -6234,7 +6234,7 @@ static void sched_init_numa(void)
>  	/* Compute default topology size */
>  	for (i = 0; sched_domain_topology[i].mask; i++);
>  
> -	tl = kzalloc((i + level) *
> +	tl = kzalloc((i + level + 1) *
>  			sizeof(struct sched_domain_topology_level), GFP_KERNEL);
>  	if (!tl)
>  		return;
> 
