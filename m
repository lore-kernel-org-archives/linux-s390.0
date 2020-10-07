Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:4378 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727817AbgJGUqH (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 7 Oct 2020 16:46:07 -0400
Subject: Re: [PATCH 04/13] misc/habana: Use FOLL_LONGTERM for userptr
References: <20201007164426.1812530-1-daniel.vetter@ffwll.ch>
 <20201007164426.1812530-5-daniel.vetter@ffwll.ch>
From: John Hubbard <jhubbard@nvidia.com>
Message-ID: <ce781e05-044f-b62b-6a39-952d73ed1597@nvidia.com>
Date: Wed, 7 Oct 2020 13:46:04 -0700
MIME-Version: 1.0
In-Reply-To: <20201007164426.1812530-5-daniel.vetter@ffwll.ch>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
List-ID: <linux-s390.vger.kernel.org>
To: Daniel Vetter <daniel.vetter@ffwll.ch>, DRI Development <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Cc: kvm@vger.kernel.org, linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-media@vger.kernel.org, linux-s390@vger.kernel.org, Daniel Vetter <daniel.vetter@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, Andrew Morton <akpm@linux-foundation.org>, =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>, Jan Kara <jack@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Oded Gabbay <oded.gabbay@gmail.com>, Omer Shpigelman <oshpigelman@habana.ai>, Ofir Bitton <obitton@habana.ai>, Tomer Tayar <ttayar@habana.ai>, Moti Haimovski <mhaimovski@habana.ai>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Pawel Piskorski <ppiskorski@habana.ai>

On 10/7/20 9:44 AM, Daniel Vetter wrote:
> These are persistent, not just for the duration of a dma operation.
>=20
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: J=C3=A9r=C3=B4me Glisse <jglisse@redhat.com>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: linux-mm@kvack.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-samsung-soc@vger.kernel.org
> Cc: linux-media@vger.kernel.org
> Cc: Oded Gabbay <oded.gabbay@gmail.com>
> Cc: Omer Shpigelman <oshpigelman@habana.ai>
> Cc: Ofir Bitton <obitton@habana.ai>
> Cc: Tomer Tayar <ttayar@habana.ai>
> Cc: Moti Haimovski <mhaimovski@habana.ai>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Pawel Piskorski <ppiskorski@habana.ai>
> ---
>   drivers/misc/habanalabs/common/memory.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/misc/habanalabs/common/memory.c b/drivers/misc/haban=
alabs/common/memory.c
> index ef89cfa2f95a..94bef8faa82a 100644
> --- a/drivers/misc/habanalabs/common/memory.c
> +++ b/drivers/misc/habanalabs/common/memory.c
> @@ -1288,7 +1288,8 @@ static int get_user_memory(struct hl_device *hdev, =
u64 addr, u64 size,
>   		return -ENOMEM;
>   	}
>  =20
> -	rc =3D pin_user_pages_fast(start, npages, FOLL_FORCE | FOLL_WRITE,
> +	rc =3D pin_user_pages_fast(start, npages,
> +				 FOLL_FORCE | FOLL_WRITE | FOLL_LONGTERM,
>   				 userptr->pages);
>  =20
>   	if (rc !=3D npages) {
>=20

Again, from a pin_user_pages_fast() point of view, and not being at all fam=
iliar
with the habana driver (but their use of this really does seem clearly _LON=
GTERM!):

Reviewed-by: John Hubbard <jhubbard@nvidia.com>

thanks,
--=20
John Hubbard
NVIDIA
