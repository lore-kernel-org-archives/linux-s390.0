Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S461197AbgJWJNF (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 23 Oct 2020 05:13:05 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDF3AC0613D5
        for <linux-s390@vger.kernel.org>; Fri, 23 Oct 2020 02:13:04 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id f8so1110606oij.10
        for <linux-s390@vger.kernel.org>; Fri, 23 Oct 2020 02:13:04 -0700 (PDT)
MIME-Version: 1.0
References: <20201021085655.1192025-1-daniel.vetter@ffwll.ch> <20201021085655.1192025-5-daniel.vetter@ffwll.ch>
In-Reply-To: <20201021085655.1192025-5-daniel.vetter@ffwll.ch>
From: Daniel Vetter <daniel.vetter@ffwll.ch>
Date: Fri, 23 Oct 2020 11:12:52 +0200
Message-ID: <CAKMK7uE50TPNruEQv5JDX91q0DDqy-CXfbQzc48YeqPzSE96yA@mail.gmail.com>
Subject: Re: [PATCH v3 04/16] misc/habana: Use FOLL_LONGTERM for userptr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-ID: <linux-s390.vger.kernel.org>
To: DRI Development <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Cc: KVM list <kvm@vger.kernel.org>, Linux MM <linux-mm@kvack.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, "open list:DMA BUFFER SHARING FRAMEWORK" <linux-media@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Daniel Vetter <daniel.vetter@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, Andrew Morton <akpm@linux-foundation.org>, John Hubbard <jhubbard@nvidia.com>, =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>, Jan Kara <jack@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Oded Gabbay <oded.gabbay@gmail.com>, Omer Shpigelman <oshpigelman@habana.ai>, Ofir Bitton <obitton@habana.ai>, Tomer Tayar <ttayar@habana.ai>, Moti Haimovski <mhaimovski@habana.ai>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Pawel Piskorski <ppiskorski@habana.ai>, Daniel Vetter <daniel.vetter@ffwll.com>

Hi Oded,

Did testing on your end turn up anything, or can I put an
ack&tested-by from you on the two habana patches for the next round?

Thanks, Daniel

On Wed, Oct 21, 2020 at 10:57 AM Daniel Vetter <daniel.vetter@ffwll.ch> wro=
te:
>
> These are persistent, not just for the duration of a dma operation.
>
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
> Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.com>
> ---
>  drivers/misc/habanalabs/common/memory.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/misc/habanalabs/common/memory.c b/drivers/misc/haban=
alabs/common/memory.c
> index 327b64479f97..767d3644c033 100644
> --- a/drivers/misc/habanalabs/common/memory.c
> +++ b/drivers/misc/habanalabs/common/memory.c
> @@ -1288,7 +1288,8 @@ static int get_user_memory(struct hl_device *hdev, =
u64 addr, u64 size,
>                 return -ENOMEM;
>         }
>
> -       rc =3D pin_user_pages_fast(start, npages, FOLL_FORCE | FOLL_WRITE=
,
> +       rc =3D pin_user_pages_fast(start, npages,
> +                                FOLL_FORCE | FOLL_WRITE | FOLL_LONGTERM,
>                                  userptr->pages);
>
>         if (rc !=3D npages) {
> --
> 2.28.0
>


--=20
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
