Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3524CC433F5
	for <linux-s390@archiver.kernel.org>; Sat,  2 Oct 2021 18:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A94761B39
	for <linux-s390@archiver.kernel.org>; Sat,  2 Oct 2021 18:13:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233782AbhJBSPe (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Sat, 2 Oct 2021 14:15:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55995 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233721AbhJBSPb (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sat, 2 Oct 2021 14:15:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633198425;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3oSEK/nQsdZlU+yYMpXszg2Kp8d5WMgwuTa52Aw2D3Y=;
        b=I8PsR+DgGuOe1K9hlg6YjY22aR5Q3e7Ss+hf0JhsEsvBw8KhKOQl8wwofCop3rYD9rw05z
        i5jXyuChArjpBK80ERj3mzsiF/HfAj4X1I5h8pfFsW2baxt/IIhhjvfOCDh48jSwdlbQ1x
        FM56uT5HnB3echT77ZAsr+x24o/MtO0=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-426-dPDK8nxxN3W7sniTB99EIQ-1; Sat, 02 Oct 2021 14:13:44 -0400
X-MC-Unique: dPDK8nxxN3W7sniTB99EIQ-1
Received: by mail-ed1-f72.google.com with SMTP id w6-20020a50d786000000b003dabc563406so8874892edi.17
        for <linux-s390@vger.kernel.org>; Sat, 02 Oct 2021 11:13:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3oSEK/nQsdZlU+yYMpXszg2Kp8d5WMgwuTa52Aw2D3Y=;
        b=pYOkGCGi0vxB1sEttWKC/G3RdmFgs6YXmP4LYsBT0Pxlrmr+a5GRiHpRXNgTXjIOPO
         HPjKiggPgbXnOiz6+DWPKFaf4b9jLIorxFAdcWlCLVyythJ5USwo9hZbasMmiv6qHABs
         wMuevC1Vv4RHna3/kDttRIel+nvXK7RQqXIHTM/6qzzvkw4aey62OLTPW3tpAs7+Hbpd
         hzOCwLrvR9kw74lSJQitsAvVk7qpiEQqxH6tOxPYMuWCzLgFfUtXvSDe5L98z42Ss5CT
         Njz8WS3hZ5xnBPwbYe6YSb7mAaMP2fXIek0HG+l3kFYrInZENmUXBArmvamZLAGQPDX/
         IQHA==
X-Gm-Message-State: AOAM530cYMDEmaMWPNZL3VK1u+U8ljiBn1UVfLXgJxGDYkOUU01fYtn3
        XhAftzIvXgheUDGBKpOc3zLRlTb22PWIOJWlgMhfSe9FYEq3hhu5azl+kdGSSnsWKDkKaLVmAt1
        ddfLlg6kKB0VD27Ljw+nL2g==
X-Received: by 2002:a17:906:3148:: with SMTP id e8mr5549044eje.240.1633198422787;
        Sat, 02 Oct 2021 11:13:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwRv0l7yLWVghnzKaRjGETRmZdWUznHgB707hsC9MH/6Nu9SV2dEEHSsiG1hSfbsv5Yq/RsSA==
X-Received: by 2002:a17:906:3148:: with SMTP id e8mr5549025eje.240.1633198422593;
        Sat, 02 Oct 2021 11:13:42 -0700 (PDT)
Received: from redhat.com ([2.55.22.213])
        by smtp.gmail.com with ESMTPSA id d10sm4409791eja.81.2021.10.02.11.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Oct 2021 11:13:41 -0700 (PDT)
Date:   Sat, 2 Oct 2021 14:13:37 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Cornelia Huck <cohuck@redhat.com>
Cc:     Halil Pasic <pasic@linux.ibm.com>,
        Jason Wang <jasowang@redhat.com>,
        Xie Yongji <xieyongji@bytedance.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, markver@us.ibm.com,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org
Subject: Re: [RFC PATCH 1/1] virtio: write back features before verify
Message-ID: <20211002082128-mutt-send-email-mst@kernel.org>
References: <20210930012049.3780865-1-pasic@linux.ibm.com>
 <87r1d64dl4.fsf@redhat.com>
 <20210930130350.0cdc7c65.pasic@linux.ibm.com>
 <87ilyi47wn.fsf@redhat.com>
 <20211001162213.18d7375e.pasic@linux.ibm.com>
 <87v92g3h9l.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v92g3h9l.fsf@redhat.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, Oct 01, 2021 at 05:18:46PM +0200, Cornelia Huck wrote:
> I'd say we need a hack here so that we assume little-endian config space
> if VERSION_1 has been offered; if your patch here works, I assume QEMU
> does what we expect (assmuming little-endian as well.) I'm mostly
> wondering what happens if you use a different VMM; can we expect it to
> work similar to QEMU?

Hard to say of course ... hopefully other VMMs are actually
implementing the spec. E.g. IIUC rust vmm is modern only.


> Even if it helps for s390, we should double-check
> what happens for other architectures.
> 
> >
> >> 
> >> Anyone have any better suggestions?
> >> 
> >
> > There is the conditional compile, as an option but I would not say it is
> > better.
> 
> Yes, I agree.
> 
> Anyone else have an idea? This is a nasty regression; we could revert the
> patch, which would remove the symptoms and give us some time, but that
> doesn't really feel right, I'd do that only as a last resort.

Well we have Halil's hack (except I would limit it
to only apply to BE, only do devices with validate,
and only in modern mode), and we will fix QEMU to be spec compliant.
Between these why do we need any conditional compiles?

-- 
MST

