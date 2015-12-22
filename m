Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1450766401-20747-1-git-send-email-sudipm.mukherjee@gmail.com>
References: <1450766401-20747-1-git-send-email-sudipm.mukherjee@gmail.com>
Date: Mon, 21 Dec 2015 22:51:45 -0800
Message-ID: <CAPcyv4iS3Mnt3kdA_WggbUDAL1o8esPZJaAZuN-hz_Qs6CRCUw@mail.gmail.com>
Subject: Re: [PATCH] s390: fix build failure
From: Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-s390@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
List-ID: <linux-s390.vger.kernel.org>

On Mon, Dec 21, 2015 at 10:40 PM, Sudip Mukherjee
<sudipm.mukherjee@gmail.com> wrote:
> s390 defconfig fails with the error:
> ERROR: "phys_to_pfn_t" [drivers/s390/block/dcssblk.ko] undefined!
>
> We need CONFIG_HAS_IOMEM for phys_to_pfn_t() and for that we need to
> have CONFIG_PCI.
>
> Fixes: bfac97e7b361 ("mm, dax, pmem: introduce pfn_t")
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
> ---

Hi, I fixed this build breakage in v4 of the patch series that
introduces phys_to_pfn_t() [1].  Chnaging the config is not correct
the HAS_IOMEM dependency for the symbol needs to be satisfied.

[1]: https://lists.01.org/pipermail/linux-nvdimm/2015-December/003610.html
