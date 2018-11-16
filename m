From: Hannes Reinecke <hare@suse.de>
Date: Fri, 16 Nov 2018 11:19:41 +0000
Subject: Re: [PATCH 18/23] zfcp: properly format LUN (and WWPN) for LUN sharing violation kmsg
Message-Id: <2f2b8227-9da5-bf99-fb50-3f6e82e8a1f6@suse.de>
In-Reply-To: <20181108144458.29012-19-maier@linux.ibm.com>
References: <20181108144458.29012-19-maier@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 11/8/18 3:44 PM, Steffen Maier wrote:
> zfcp: <devbusid>: LUN 0x0 on port 0x5005076......... ...
> zfcp: <devbusid>: LUN 0x1000000000000 on port 0x5005076......... ...
> 
> should be
> 
> zfcp: <devbusid>: LUN 0x0000000000000000 on port 0x5005076......... ...
> zfcp: <devbusid>: LUN 0x0001000000000000 on port 0x5005076.........
>                    is already in use by CSS., MIF Image ID .
> 
> Signed-off-by: Steffen Maier <maier@linux.ibm.com>
> Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
> ---
>   drivers/s390/scsi/zfcp_fsf.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/s390/scsi/zfcp_fsf.c b/drivers/s390/scsi/zfcp_fsf.c
> index 0bdbc596da97..b83d249d07dc 100644
> --- a/drivers/s390/scsi/zfcp_fsf.c
> +++ b/drivers/s390/scsi/zfcp_fsf.c
> @@ -1811,7 +1811,7 @@ static void zfcp_fsf_open_lun_handler(struct zfcp_fsf_req *req)
>   	case FSF_LUN_SHARING_VIOLATION:
>   		if (qual->word[0])
>   			dev_warn(&zfcp_sdev->port->adapter->ccw_device->dev,
> -				 "LUN 0x%Lx on port 0x%Lx is already in "
> +				 "LUN 0x%016Lx on port 0x%016Lx is already in "
>   				 "use by CSS%d, MIF Image ID %x\n",
>   				 zfcp_scsi_dev_lun(sdev),
>   				 (unsigned long long)zfcp_sdev->port->wwpn,
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: F. Imend�rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N�rnberg)
