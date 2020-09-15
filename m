Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:20975 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726362AbgIOIUA (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 15 Sep 2020 04:20:00 -0400
Date: Tue, 15 Sep 2020 10:19:41 +0200
From: Ivan Vecera <ivecera@redhat.com>
Subject: Re: [PATCH net-next 5/8] bridge: Add SWITCHDEV_FDB_FLUSH_TO_BRIDGE
 notifier
Message-ID: <20200915101941.7c18be01@ceranb>
In-Reply-To: <20200910172351.5622-6-jwi@linux.ibm.com>
References: <20200910172351.5622-1-jwi@linux.ibm.com>
        <20200910172351.5622-6-jwi@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Julian Wiedmann <jwi@linux.ibm.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Karsten Graul <kgraul@linux.ibm.com>, Alexandra Winter <wintera@linux.ibm.com>, Roopa Prabhu <roopa@nvidia.com>, Nikolay Aleksandrov <nikolay@nvidia.com>, Jiri Pirko <jiri@resnulli.us>

On Thu, 10 Sep 2020 19:23:48 +0200
Julian Wiedmann <jwi@linux.ibm.com> wrote:

> From: Alexandra Winter <wintera@linux.ibm.com>
> 
> so the switchdev can notifiy the bridge to flush non-permanent fdb entries
> for this port. This is useful whenever the hardware fdb of the switchdev
> is reset, but the netdev and the bridgeport are not deleted.
> 
> Note that this has the same effect as the IFLA_BRPORT_FLUSH attribute.
> 
> CC: Jiri Pirko <jiri@resnulli.us>
> CC: Ivan Vecera <ivecera@redhat.com>
> CC: Roopa Prabhu <roopa@nvidia.com>
> CC: Nikolay Aleksandrov <nikolay@nvidia.com>
> Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
> Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
> ---
>  include/net/switchdev.h | 1 +
>  net/bridge/br.c         | 5 +++++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/include/net/switchdev.h b/include/net/switchdev.h
> index ff2246914301..53e8b4994296 100644
> --- a/include/net/switchdev.h
> +++ b/include/net/switchdev.h
> @@ -203,6 +203,7 @@ enum switchdev_notifier_type {
>  	SWITCHDEV_FDB_ADD_TO_DEVICE,
>  	SWITCHDEV_FDB_DEL_TO_DEVICE,
>  	SWITCHDEV_FDB_OFFLOADED,
> +	SWITCHDEV_FDB_FLUSH_TO_BRIDGE,
>  
>  	SWITCHDEV_PORT_OBJ_ADD, /* Blocking. */
>  	SWITCHDEV_PORT_OBJ_DEL, /* Blocking. */
> diff --git a/net/bridge/br.c b/net/bridge/br.c
> index b6fe30e3768f..401eeb9142eb 100644
> --- a/net/bridge/br.c
> +++ b/net/bridge/br.c
> @@ -183,6 +183,11 @@ static int br_switchdev_event(struct notifier_block *unused,
>  		br_fdb_offloaded_set(br, p, fdb_info->addr,
>  				     fdb_info->vid, fdb_info->offloaded);
>  		break;
> +	case SWITCHDEV_FDB_FLUSH_TO_BRIDGE:
> +		fdb_info = ptr;
> +		/* Don't delete static entries */
> +		br_fdb_delete_by_port(br, p, fdb_info->vid, 0);
> +		break;
>  	}
>  
>  out:

Acked-by: Ivan Vecera <ivecera@redhat.com>
