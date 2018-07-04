Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <16466385fd1.ddcc3b7a51249.6994139134661160061@zoho.com>
References: <20180704163823.9980-1-yehs2007@zoho.com> <CAPcyv4hgk89NKGhmZ1Z3XsGFzJAn1y+46WJn_61r8rj5bmqv6A@mail.gmail.com>
 <16466385fd1.ddcc3b7a51249.6994139134661160061@zoho.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 4 Jul 2018 10:16:09 -0700
Message-ID: <CAPcyv4iDUYMsHzAmuRb1S_fiwCXWEXm90Q=j_fqTeMETwvKFzg@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Assigning NULL to gfn of dax_direct_access if useless
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-fsdevel/>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
To: Huaisheng Ye <yehs2007@zoho.com>
Cc: linux-nvdimm <linux-nvdimm@lists.01.org>, Ross Zwisler <ross.zwisler@linux.intel.com>, Matthew Wilcox <willy@infradead.org>, Vishal L Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Al Viro <viro@zeniv.linux.org.uk>, "Martin K. Petersen" <martin.petersen@oracle.com>, Jens Axboe <axboe@kernel.dk>, Greg KH <gregkh@linuxfoundation.org>, Bart Van Assche <bart.vanassche@wdc.com>, Jan Kara <jack@suse.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, colyli <colyli@suse.de>, NingTing Cheng <chengnt@lenovo.com>, Huaisheng Ye <yehs1@lenovo.com>
List-ID: <linux-s390.vger.kernel.org>

On Wed, Jul 4, 2018 at 9:55 AM, Huaisheng Ye <yehs2007@zoho.com> wrote:
>
>
>
>
>  ---- On Thu, 05 Jul 2018 00:48:40 +0800 Dan Williams <dan.j.williams@intel.com> wrote ----
>  > On Wed, Jul 4, 2018 at 9:38 AM, Huaisheng Ye <yehs2007@zoho.com> wrote:
>  > > From: Huaisheng Ye <yehs1@lenovo.com>
>  > >
>  > > Changes since v1 [1]:
>  > > * Collect Jan's reviewed-by.
>  > > * According to Dan's suggestion, update the unit test infrastructure
>  > >   tools/testing/nvdimm/pmem-dax.c for checking the validity of gfn.
>  > >
>  > > [1]: https://lkml.org/lkml/2018/7/4/81
>  > >
>  > > ---
>  > >
>  > > Some functions within fs/dax don't need to get gfn from direct_access.
>  >
>  > Any reason you are calling it 'gfn'? I'm assuming that is a typo and
>  > it should be 'pfn'.
>
> Oh, sorry.
> I made a mistake, it is a typo. I will correct it right now.

Don't worry about sending a new version. I'll fix it up when I apply the series.
