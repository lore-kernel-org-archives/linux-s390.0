Return-Path: <linux-fsdevel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180704064058.1344-1-yehs2007@zoho.com>
References: <20180704064058.1344-1-yehs2007@zoho.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 4 Jul 2018 07:40:21 -0700
Message-ID: <CAPcyv4hJ62nDgEUpOg4ttbZbKUQctGF_adfHOJy0tHBNraeLPQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] nvdimm/pmem: check the validity of the pointer pfn
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-fsdevel/>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
To: Huaisheng Ye <yehs2007@zoho.com>
Cc: linux-nvdimm <linux-nvdimm@lists.01.org>, Ross Zwisler <ross.zwisler@linux.intel.com>, Matthew Wilcox <mawilcox@microsoft.com>, Vishal L Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Al Viro <viro@zeniv.linux.org.uk>, "Martin K. Petersen" <martin.petersen@oracle.com>, Jens Axboe <axboe@kernel.dk>, Greg KH <gregkh@linuxfoundation.org>, Bart Van Assche <bart.vanassche@wdc.com>, Jan Kara <jack@suse.com>, NingTing Cheng <chengnt@lenovo.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Huaisheng Ye <yehs1@lenovo.com>
List-ID: <linux-s390.vger.kernel.org>

On Tue, Jul 3, 2018 at 11:40 PM, Huaisheng Ye <yehs2007@zoho.com> wrote:
> From: Huaisheng Ye <yehs1@lenovo.com>
>
> Some functions within fs/dax don't need to get gfn from direct_access.
> Assigning NULL to gfn of dax_direct_access is more intuitive and simple
> than offering a useless local variable.
>
> So direct_access needs to check validity of the pointer pfn For NULL
> assignment.
>
> Signed-off-by: Huaisheng Ye <yehs1@lenovo.com>
> ---
>  drivers/nvdimm/pmem.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
> index 9d71492..018f990 100644
> --- a/drivers/nvdimm/pmem.c
> +++ b/drivers/nvdimm/pmem.c
> @@ -233,7 +233,8 @@ __weak long __pmem_direct_access(struct pmem_device *pmem, pgoff_t pgoff,
>                                         PFN_PHYS(nr_pages))))
>                 return -EIO;
>         *kaddr = pmem->virt_addr + offset;
> -       *pfn = phys_to_pfn_t(pmem->phys_addr + offset, pmem->pfn_flags);
> +       if (pfn)
> +               *pfn = phys_to_pfn_t(pmem->phys_addr + offset, pmem->pfn_flags);
>
>         /*
>          * If badblocks are present, limit known good range to the

Looks good. You also need to update the unit test infrastructure
version of this operation in:

    tools/testing/nvdimm/pmem-dax.c
