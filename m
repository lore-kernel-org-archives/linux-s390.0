Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <567B8929.1060207@roeck-us.net>
References: <567B8929.1060207@roeck-us.net>
Date: Wed, 23 Dec 2015 22:24:55 -0800
Message-ID: <CAPcyv4jnJFgN-5Gsh_fss-d_iwscDt_QkadypXsp_avZ0bVjGQ@mail.gmail.com>
Subject: Re: Problems with phys_to_pfn_t in linux-next and s390
From: Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Wed, Dec 23, 2015 at 9:56 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> s390:defconfig:
>
> ERROR: "phys_to_pfn_t" [drivers/s390/block/dcssblk.ko] undefined!
>
> s390 does not set CONFIG_HAS_IOMEM, which is required for phys_to_pfn_t to
> exist.
>
> Introduced with commit e014f77c4b ("mm-dax-pmem-introduce-pfn_t-v3") and
> possibly earlier.

Addressed in v4:
https://lists.01.org/pipermail/linux-nvdimm/2015-December/003610.html
