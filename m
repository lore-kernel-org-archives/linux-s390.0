Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 17 Mar 2014 14:28:51 +0100
From: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Subject: Re: [PATCH] s390: correct misuses of module_put in
 appldata_generic_handler.
Message-ID: <20140317142851.50e5f533@thinkpad>
In-Reply-To: <1394890540-2435-1-git-send-email-zhouzhouyi@gmail.com>
References: <1394890540-2435-1-git-send-email-zhouzhouyi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Zhouyi Zhou <zhouzhouyi@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, joe@perches.com, gang.chen@asianux.com, linux390@de.ibm.com, heiko.carstens@de.ibm.com, schwidefsky@de.ibm.com, Zhouyi Zhou <yizhouzhou@ict.ac.cn>
List-ID: <linux-s390.vger.kernel.org>

On Sat, 15 Mar 2014 21:35:40 +0800
Zhouyi Zhou <zhouzhouyi@gmail.com> wrote:

> correct misuses of module_put in  appldata_generic_handler

Sorry, I don't see any misuse, could you elaborate?

> 
> Signed-off-by: Zhouyi Zhou <yizhouzhou@ict.ac.cn>
> ---
>  arch/s390/appldata/appldata_base.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/arch/s390/appldata/appldata_base.c b/arch/s390/appldata/appldata_base.c
> index 47c8630..683e0282 100644
> --- a/arch/s390/appldata/appldata_base.c
> +++ b/arch/s390/appldata/appldata_base.c
> @@ -343,7 +343,6 @@ appldata_generic_handler(struct ctl_table *ctl, int write,
>  		// protect work queue callback
>  		if (!try_module_get(ops->owner)) {
>  			mutex_unlock(&appldata_ops_mutex);
> -			module_put(ops->owner);
>  			return -ENODEV;
>  		}
>  		ops->callback(ops->data);	// init record
> @@ -354,7 +353,6 @@ appldata_generic_handler(struct ctl_table *ctl, int write,
>  		if (rc != 0) {
>  			pr_err("Starting the data collection for %s "
>  			       "failed with rc=%d\n", ops->name, rc);
> -			module_put(ops->owner);
>  		} else
>  			ops->active = 1;
>  	} else if ((buf[0] == '0') && (ops->active == 1)) {
> @@ -365,7 +363,6 @@ appldata_generic_handler(struct ctl_table *ctl, int write,
>  		if (rc != 0)
>  			pr_err("Stopping the data collection for %s "
>  			       "failed with rc=%d\n", ops->name, rc);
> -		module_put(ops->owner);
>  	}
>  	mutex_unlock(&appldata_ops_mutex);
>  out:
