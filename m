Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0165C77B7C
	for <linux-s390@archiver.kernel.org>; Fri,  5 May 2023 10:14:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231752AbjEEKOc (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 5 May 2023 06:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231704AbjEEKOb (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 5 May 2023 06:14:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F0EA1161C
        for <linux-s390@vger.kernel.org>; Fri,  5 May 2023 03:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683281622;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oZ+W0+aJdMtjJzmRiw6PVDgzOh3temaFbWrH/wCIxiU=;
        b=H0qt/oRmfeFEm9QhCCcynQeKgfKRdHdkZZ1gddw8TQ3y5Ei5JNL+7gWFOcBupVw3OkDdxt
        vWQB9xoJJcTWe2wHvBwNLMOMZttuSjbAk0enD1RI6JMTpxPqDGW9XHH7izX6N2p80DTez0
        rY7zGWiqPGmGKliY31rXm7DaAjaMigY=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-284-uXPBQ_WuPPK7GEG1l7sKFg-1; Fri, 05 May 2023 06:13:41 -0400
X-MC-Unique: uXPBQ_WuPPK7GEG1l7sKFg-1
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-42dfffccac8so299248137.1
        for <linux-s390@vger.kernel.org>; Fri, 05 May 2023 03:13:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683281621; x=1685873621;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oZ+W0+aJdMtjJzmRiw6PVDgzOh3temaFbWrH/wCIxiU=;
        b=Z660Ruwh5/qsVtE47rlzur1Jw79D/R5aW9BLysU6zHL8ZXP6KXmtdMmaIoreNj0l7/
         j/RYddZlIFX1RBGA1fnu3QDQLlND0pGoE6z4LAEmtpcSiFcP76xs9H8HMqzR7Ns+HpE3
         0y8P8DRw+wVp5Yewx378/tIqBb4cWqTiZrL7qjtbNTnVhgPZkC6WwkUsZi5aLXUdWWEH
         ly+VKrwkW2wTuGF+xNrdXi12li+PQ50msDL4kuqJpUCaFm2vSNrRVi4XYQJd4pDK/pdO
         4w2Wz59UtDqjlHy8jqLY9PbsM5o2WFGhnRFkbg9g+R0SSOy8di1dIcXG7E+7bjdEvZDc
         9tow==
X-Gm-Message-State: AC+VfDw/sZf8Z28S0SydhVxPr/vKTl9Y+ES9gMdb+hGQRRtUCho7fnMg
        fh+mew8ehE+rcuZHyE/wINcGtoBGcf8L2G7b0ZalNagsaMSH1wzhzhndIMMA4s8N3PR9uXg5TeF
        uW/GsBQot2T4961NuOsPv8P3rhEnpfDYntxRN/zwaUiCXXQ==
X-Received: by 2002:a05:6102:3cd:b0:430:ce0:ae90 with SMTP id n13-20020a05610203cd00b004300ce0ae90mr264082vsq.14.1683281620932;
        Fri, 05 May 2023 03:13:40 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6OtXedp3osVnwEX33Yc8OMv+0d9M5ynEvZuqvO8k8HixdHSob0k1+rsHIZA+Ep6fL44O5RFoq3hvilcahA2KI=
X-Received: by 2002:a05:6102:3cd:b0:430:ce0:ae90 with SMTP id
 n13-20020a05610203cd00b004300ce0ae90mr264077vsq.14.1683281620688; Fri, 05 May
 2023 03:13:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230504171611.54844-1-imbrenda@linux.ibm.com>
In-Reply-To: <20230504171611.54844-1-imbrenda@linux.ibm.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Date:   Fri, 5 May 2023 12:13:29 +0200
Message-ID: <CABgObfZdsv3BBTOsPCf=YYOuDifGamLivEjiMfvZ7df+Yt208A@mail.gmail.com>
Subject: Re: [GIT PULL 0/2] KVM: s390: Some fixes for 6.4
To:     Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc:     kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        frankja@linux.ibm.com, borntraeger@linux.ibm.com,
        hca@linux.ibm.com, david@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, May 4, 2023 at 7:16=E2=80=AFPM Claudio Imbrenda <imbrenda@linux.ibm=
.com> wrote:
>
> Hi Paolo,
>
> just a couple of bugfixes, nothing too exceptional here.
>
>
> please pull, thanks!
>
> Claudio

Done, thank you.

Paolo

>
>
> The following changes since commit 8a46df7cd135fe576c18efa418cd1549e51f27=
32:
>
>   KVM: s390: pci: fix virtual-physical confusion on module unload/load (2=
023-04-20 16:30:35 +0200)
>
> are available in the Git repository at:
>
>   ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.gi=
t tags/kvm-s390-next-6.4-2
>
> for you to fetch changes up to c148dc8e2fa403be501612ee409db866eeed35c0:
>
>   KVM: s390: fix race in gmap_make_secure() (2023-05-04 18:26:27 +0200)
>
> ----------------------------------------------------------------
> For 6.4
>
> ----------------------------------------------------------------
> Claudio Imbrenda (2):
>       KVM: s390: pv: fix asynchronous teardown for small VMs
>       KVM: s390: fix race in gmap_make_secure()
>
>  arch/s390/kernel/uv.c | 32 +++++++++++---------------------
>  arch/s390/kvm/pv.c    |  5 +++++
>  arch/s390/mm/gmap.c   |  7 +++++++
>  3 files changed, 23 insertions(+), 21 deletions(-)
>

