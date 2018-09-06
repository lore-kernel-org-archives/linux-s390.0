Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Thu, 6 Sep 2018 08:24:14 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH] scsi: zfcp: remove redundant put_device
References: <1536214587-32500-1-git-send-email-dingxiang@cmss.chinamobile.com>
MIME-Version: 1.0
In-Reply-To: <1536214587-32500-1-git-send-email-dingxiang@cmss.chinamobile.com>
Message-Id: <20180906062414.GA3598@osiris>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Ding Xiang <dingxiang@cmss.chinamobile.com>
Cc: schwidefsky@de.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Steffen Maier <maier@linux.ibm.com>, Benjamin Block <bblock@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Thu, Sep 06, 2018 at 02:16:27PM +0800, Ding Xiang wrote:
> device_unregister will put device, do not need to do it one more time
> 
> Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>
> ---
>  drivers/s390/scsi/zfcp_unit.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/s390/scsi/zfcp_unit.c b/drivers/s390/scsi/zfcp_unit.c
> index 1bf0a09..6b50084 100644
> --- a/drivers/s390/scsi/zfcp_unit.c
> +++ b/drivers/s390/scsi/zfcp_unit.c
> @@ -249,8 +249,6 @@ int zfcp_unit_remove(struct zfcp_port *port, u64 fcp_lun)
>  		scsi_device_put(sdev);
>  	}
> 
> -	put_device(&unit->dev);
> -
>  	device_unregister(&unit->dev);
> 
>  	return 0;

I'm quite sure this change is wrong, since the put_device() here seems to
pair with the get_device() in _zfcp_unit_find(). So we would end up with a
memory leak.

Adding Steffen and Benjamin.
