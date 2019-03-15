Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
Subject: Re: [PATCH] net: smc: fix a NULL pointer dereference
References: <20190315041555.1801-1-kjlu@umn.edu>
From: Ursula Braun <ubraun@linux.ibm.com>
Date: Fri, 15 Mar 2019 11:18:24 +0100
MIME-Version: 1.0
In-Reply-To: <20190315041555.1801-1-kjlu@umn.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <9887da6d-fc29-eedb-e172-a28edc3d1c4d@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Kangjie Lu <kjlu@umn.edu>
Cc: pakki001@umn.edu, Karsten Graul <kgraul@linux.ibm.com>, "David S. Miller" <davem@davemloft.net>, linux-s390@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>



On 3/15/19 5:15 AM, Kangjie Lu wrote:
> In case alloc_ordered_workqueue fails, the fix returns NULL
> to avoid NULL pointer dereference.
> 

Thanks, looks good. Your patch will be part of our next patch
submission for the net-tree.

Regards, Ursula

> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> ---
>  net/smc/smc_ism.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/net/smc/smc_ism.c b/net/smc/smc_ism.c
> index 2fff79db1a59..e89e918b88e0 100644
> --- a/net/smc/smc_ism.c
> +++ b/net/smc/smc_ism.c
> @@ -289,6 +289,11 @@ struct smcd_dev *smcd_alloc_dev(struct device *parent, const char *name,
>  	INIT_LIST_HEAD(&smcd->vlan);
>  	smcd->event_wq = alloc_ordered_workqueue("ism_evt_wq-%s)",
>  						 WQ_MEM_RECLAIM, name);
> +	if (!smcd->event_wq) {
> +		kfree(smcd->conn);
> +		kfree(smcd);
> +		return NULL;
> +	}
>  	return smcd;
>  }
>  EXPORT_SYMBOL_GPL(smcd_alloc_dev);
> 
