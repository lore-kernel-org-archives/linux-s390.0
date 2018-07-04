Return-Path: <linux-fsdevel-owner@vger.kernel.org>
Date: Wed, 4 Jul 2018 13:30:12 +0200
From: Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 3/3] fs/dax: Assigning NULL to gfn of dax_direct_access
 if useless
Message-ID: <20180704113012.trnfzeefao25clri@quack2.suse.cz>
References: <20180704064058.1344-1-yehs2007@zoho.com>
 <20180704064058.1344-3-yehs2007@zoho.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180704064058.1344-3-yehs2007@zoho.com>
Sender: linux-fsdevel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-fsdevel/>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
To: Huaisheng Ye <yehs2007@zoho.com>
Cc: linux-nvdimm@lists.01.org, dan.j.williams@intel.com, ross.zwisler@linux.intel.com, mawilcox@microsoft.com, vishal.l.verma@intel.com, dave.jiang@intel.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, viro@zeniv.linux.org.uk, martin.petersen@oracle.com, axboe@kernel.dk, gregkh@linuxfoundation.org, bart.vanassche@wdc.com, jack@suse.com, chengnt@lenovo.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org, Huaisheng Ye <yehs1@lenovo.com>
List-ID: <linux-s390.vger.kernel.org>

On Wed 04-07-18 14:40:58, Huaisheng Ye wrote:
> From: Huaisheng Ye <yehs1@lenovo.com>
> 
> Some functions within fs/dax don't need to get gfn from direct_access.
> Assigning NULL to gfn of dax_direct_access is more intuitive and simple
> than offering a useless local variable.
> 
> Signed-off-by: Huaisheng Ye <yehs1@lenovo.com>

I like this. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

for the series.

								Honza

> ---
>  fs/dax.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/dax.c b/fs/dax.c
> index aaec72de..aa75dfd 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -550,7 +550,6 @@ static int copy_user_dax(struct block_device *bdev, struct dax_device *dax_dev,
>  {
>  	void *vto, *kaddr;
>  	pgoff_t pgoff;
> -	pfn_t pfn;
>  	long rc;
>  	int id;
>  
> @@ -559,7 +558,7 @@ static int copy_user_dax(struct block_device *bdev, struct dax_device *dax_dev,
>  		return rc;
>  
>  	id = dax_read_lock();
> -	rc = dax_direct_access(dax_dev, pgoff, PHYS_PFN(size), &kaddr, &pfn);
> +	rc = dax_direct_access(dax_dev, pgoff, PHYS_PFN(size), &kaddr, NULL);
>  	if (rc < 0) {
>  		dax_read_unlock(id);
>  		return rc;
> @@ -961,7 +960,6 @@ int __dax_zero_page_range(struct block_device *bdev,
>  		pgoff_t pgoff;
>  		long rc, id;
>  		void *kaddr;
> -		pfn_t pfn;
>  
>  		rc = bdev_dax_pgoff(bdev, sector, PAGE_SIZE, &pgoff);
>  		if (rc)
> @@ -969,7 +967,7 @@ int __dax_zero_page_range(struct block_device *bdev,
>  
>  		id = dax_read_lock();
>  		rc = dax_direct_access(dax_dev, pgoff, 1, &kaddr,
> -				&pfn);
> +				NULL);
>  		if (rc < 0) {
>  			dax_read_unlock(id);
>  			return rc;
> @@ -1024,7 +1022,6 @@ int __dax_zero_page_range(struct block_device *bdev,
>  		ssize_t map_len;
>  		pgoff_t pgoff;
>  		void *kaddr;
> -		pfn_t pfn;
>  
>  		if (fatal_signal_pending(current)) {
>  			ret = -EINTR;
> @@ -1036,7 +1033,7 @@ int __dax_zero_page_range(struct block_device *bdev,
>  			break;
>  
>  		map_len = dax_direct_access(dax_dev, pgoff, PHYS_PFN(size),
> -				&kaddr, &pfn);
> +				&kaddr, NULL);
>  		if (map_len < 0) {
>  			ret = map_len;
>  			break;
> -- 
> 1.8.3.1
> 
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
