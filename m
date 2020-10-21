Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504041AbgJUSVa (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 21 Oct 2020 14:21:30 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 532A7C0613D4
        for <linux-s390@vger.kernel.org>; Wed, 21 Oct 2020 11:21:29 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id e22so4636429ejr.4
        for <linux-s390@vger.kernel.org>; Wed, 21 Oct 2020 11:21:29 -0700 (PDT)
MIME-Version: 1.0
References: <20201021085655.1192025-1-daniel.vetter@ffwll.ch> <20201021085655.1192025-14-daniel.vetter@ffwll.ch>
In-Reply-To: <20201021085655.1192025-14-daniel.vetter@ffwll.ch>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 21 Oct 2020 11:21:17 -0700
Message-ID: <CAPcyv4jJTeH-PNjsXGrn=Ooz7=9rsZLdnFgwJ9xpQ6y14YoDrQ@mail.gmail.com>
Subject: Re: [PATCH v3 13/16] /dev/mem: Only set filp->f_mapping
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-ID: <linux-s390.vger.kernel.org>
To: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: DRI Development <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>, KVM list <kvm@vger.kernel.org>, Linux MM <linux-mm@kvack.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, "Linux-media@vger.kernel.org" <linux-media@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Daniel Vetter <daniel.vetter@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, Kees Cook <keescook@chromium.org>, Andrew Morton <akpm@linux-foundation.org>, John Hubbard <jhubbard@nvidia.com>, =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>, Jan Kara <jack@suse.cz>, Daniel Vetter <daniel.vetter@ffwll.com>

On Wed, Oct 21, 2020 at 1:57 AM Daniel Vetter <daniel.vetter@ffwll.ch> wrot=
e:
>
> When we care about pagecache maintenance, we need to make sure that
> both f_mapping and i_mapping point at the right mapping.
>
> But for iomem mappings we only care about the virtual/pte side of
> things, so f_mapping is enough. Also setting inode->i_mapping was
> confusing me as a driver maintainer, since in e.g. drivers/gpu we
> don't do that. Per Dan this seems to be copypasta from places which do
> care about pagecache consistency, but not needed. Hence remove it for
> slightly less confusion.
>
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: J=C3=A9r=C3=B4me Glisse <jglisse@redhat.com>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
