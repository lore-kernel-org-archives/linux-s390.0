Return-Path: <linux-fsdevel-owner@vger.kernel.org>
Subject: Re: [PATCH 3/5] s390, dcssblk: Allow a NULL-kaddr to
 ->direct_access()
References: <20180724084510.6104-1-yehs2007@zoho.com>
 <20180724084510.6104-4-yehs2007@zoho.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 24 Jul 2018 10:53:39 +0200
MIME-Version: 1.0
In-Reply-To: <20180724084510.6104-4-yehs2007@zoho.com>
Content-Language: en-US
Message-Id: <192a9dac-921f-e222-3a7d-32d43679cd12@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-fsdevel/>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
To: Huaisheng Ye <yehs2007@zoho.com>, linux-nvdimm@lists.01.org, dan.j.williams@intel.com
Cc: ross.zwisler@linux.intel.com, willy@infradead.org, vishal.l.verma@intel.com, dave.jiang@intel.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, viro@zeniv.linux.org.uk, martin.petersen@oracle.com, axboe@kernel.dk, gregkh@linuxfoundation.org, bart.vanassche@wdc.com, jack@suse.cz, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org, chengnt@lenovo.com, Huaisheng Ye <yehs1@lenovo.com>
List-ID: <linux-s390.vger.kernel.org>



On 07/24/2018 10:45 AM, Huaisheng Ye wrote:
> From: Huaisheng Ye <yehs1@lenovo.com>
> 
> dcssblk_direct_access() needs to check the validity of second rank
> pointer kaddr for NULL assignment. If kaddr equals to NULL, it
> doesn't need to calculate the value.
> 
> Signed-off-by: Huaisheng Ye <yehs1@lenovo.com>
> ---
>  drivers/s390/block/dcssblk.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/s390/block/dcssblk.c b/drivers/s390/block/dcssblk.c
> index 0a312e4..9c13dc5 100644
> --- a/drivers/s390/block/dcssblk.c
> +++ b/drivers/s390/block/dcssblk.c
> @@ -915,7 +915,8 @@ static DEVICE_ATTR(save, S_IWUSR | S_IRUSR, dcssblk_save_show,
>  	unsigned long dev_sz;
>  
>  	dev_sz = dev_info->end - dev_info->start + 1;
> -	*kaddr = (void *) dev_info->start + offset;
> +	if (kaddr)
> +		*kaddr = (void *) dev_info->start + offset;

So you are trading of a load + add (dev_info->start should be cache hot) against a
compare+branch . Not sure that this is always a win.


>  	*pfn = __pfn_to_pfn_t(PFN_DOWN(dev_info->start + offset),
>  			PFN_DEV|PFN_SPECIAL);
>  
> 
