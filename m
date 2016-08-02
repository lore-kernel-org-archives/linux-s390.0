Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 2 Aug 2016 17:42:41 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH 0875/1285] Replace numeric parameter like 0444 with macro
References: <20160802115412.8308-1-baolex.ni@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160802115412.8308-1-baolex.ni@intel.com>
Message-Id: <20160802154241.GA3385@osiris>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Baole Ni <baolex.ni@intel.com>
Cc: wein@de.ibm.com, stefan.haberland@de.ibm.com, schwidefsky@de.ibm.com, dwmw2@infradead.org, m.chehab@samsung.com, pawel@osciak.com, m.szyprowski@samsung.com, kyungmin.park@samsung.com, k.kozlowski@samsung.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, chuansheng.liu@intel.com
List-ID: <linux-s390.vger.kernel.org>

On Tue, Aug 02, 2016 at 07:54:12PM +0800, Baole Ni wrote:
> I find that the developers often just specified the numeric value
> when calling a macro which is defined with a parameter for access permission.
> As we know, these numeric value for access permission have had the corresponding macro,
> and that using macro can improve the robustness and readability of the code,
> thus, I suggest replacing the numeric parameter with the macro.
> 
> Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
> Signed-off-by: Baole Ni <baolex.ni@intel.com>
> ---
>  drivers/s390/block/dasd_devmap.c | 38 +++++++++++++++++++-------------------
>  1 file changed, 19 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/s390/block/dasd_devmap.c b/drivers/s390/block/dasd_devmap.c
> index 3cdbce4..a70a159 100644
> --- a/drivers/s390/block/dasd_devmap.c
> +++ b/drivers/s390/block/dasd_devmap.c
> @@ -747,7 +747,7 @@ static ssize_t dasd_ff_store(struct device *dev, struct device_attribute *attr,
>  	return count;
>  }
> 
> -static DEVICE_ATTR(failfast, 0644, dasd_ff_show, dasd_ff_store);
> +static DEVICE_ATTR(failfast, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH, dasd_ff_show, dasd_ff_store);

Please consider all patches NACK'ed that touch s390 code, for the same
reasons that have been outlined by several other people.
