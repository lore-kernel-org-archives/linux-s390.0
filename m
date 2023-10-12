Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D142CDB46E
	for <linux-s390@archiver.kernel.org>; Thu, 12 Oct 2023 15:11:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343696AbjJLPL3 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 12 Oct 2023 11:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235735AbjJLPL1 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 12 Oct 2023 11:11:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE20BC9
        for <linux-s390@vger.kernel.org>; Thu, 12 Oct 2023 08:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697123439;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G902YRH4gMYpL3ZSti9071jAR2nOwc1FYmNDsAZeTg8=;
        b=d50T85uGmp1r07zpTbm7mFcEaDRzdA6hj4Bb8QJASkYt92vTf61wNqpN35jvvLgpF+jgno
        S94T4EE1RLWLEk35ek7KaYVkB5ExeoHfdHlZrQ6wXbNgOeU8iP6ctRR8P69/C7ztt0SEuQ
        YLWCy5+OcbR/tcbZ699O0B5XCGnOLPU=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-182-yRwlOeEhO1WBxQrPGs3zqw-1; Thu, 12 Oct 2023 11:10:37 -0400
X-MC-Unique: yRwlOeEhO1WBxQrPGs3zqw-1
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3af5b5d816aso1513917b6e.3
        for <linux-s390@vger.kernel.org>; Thu, 12 Oct 2023 08:10:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697123437; x=1697728237;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G902YRH4gMYpL3ZSti9071jAR2nOwc1FYmNDsAZeTg8=;
        b=EsGyUN9oonX8lnBb3+SjzZI8tKf5nDQ3pF8E8lZ+kSh7FcWo8P4/aIGq+8eWG23vbu
         tfqXzgkSx9vo+hjNio0L0gvzzo7o2LhWi2/FjkfbPb8WsYQ4UsRM5H5GJcWAbtFNmqut
         pAlhnRpOTPiXyhysGeEnBs/vscOym/1ybkWQVPUH2KzyxlXIvY4gbjWzWHEPFp0eHWav
         p8r/DL20NbL6OB2vgF7tjed4WhDcDMYJWnewQp9bcFxEkGLk4hh0t6OGyeykc1t9eogN
         aBRnMxh5EQG+9oyW9+cyBGO6Vc6TYtK+ZhRGIxbtY/pjjO624539GbD/cXDsbx+4JOqH
         d9uA==
X-Gm-Message-State: AOJu0YxjPODrhXDJkgxS+ONpdT0wac/UbnLsAETX8U2GEJv0w4rMSbct
        SpVB89IbnVpRzE8CFo4caAywsulu9XNYHToxNjh2dsYZw2eysJdu7JHT8nJrz7xRbMk1JuqYXTQ
        46wB/RxLYKWuO3spFU5G++SMF2R/Yy/jD7suLWg==
X-Received: by 2002:aca:1c0a:0:b0:3ae:aa6:dc0c with SMTP id c10-20020aca1c0a000000b003ae0aa6dc0cmr25467614oic.9.1697123436913;
        Thu, 12 Oct 2023 08:10:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJo0OsSsOp3ULotW0l+15UUEJrghdAo4jXz8BKtcULxi61l2Ufj14ZsBlTMojK8MUO2luhwvvfwNeDNima55k=
X-Received: by 2002:aca:1c0a:0:b0:3ae:aa6:dc0c with SMTP id
 c10-20020aca1c0a000000b003ae0aa6dc0cmr25467596oic.9.1697123436675; Thu, 12
 Oct 2023 08:10:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230929155706.81033-1-imbrenda@linux.ibm.com>
In-Reply-To: <20230929155706.81033-1-imbrenda@linux.ibm.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Date:   Thu, 12 Oct 2023 17:10:24 +0200
Message-ID: <CABgObfa-2YkYuv6agzUfeGA6zzwPa21O74ruDJcsrU=Jo_VGiA@mail.gmail.com>
Subject: Re: [GIT PULL 0/1] KVM: s390: gisa: one fix for 6.6
To:     Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc:     kvm@vger.kernel.org, frankja@linux.ibm.com, borntraeger@de.ibm.com,
        linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, Sep 29, 2023 at 5:57=E2=80=AFPM Claudio Imbrenda <imbrenda@linux.ib=
m.com> wrote:
>
> Hi Paolo,
>
> a small fix for gisa, please pull :)
>
>
> Claudio
>
> The following changes since commit 6465e260f48790807eef06b583b38ca9789b60=
72:
>
>   Linux 6.6-rc3 (2023-09-24 14:31:13 -0700)
>
> are available in the Git repository at:
>
>   ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.gi=
t tags/kvm-s390-master-6.6-1

Pulled, but you need to configure separate url/pushurl. :)

Paolo

>
> for you to fetch changes up to f87ef5723536a6545ed9c43e18b13a9faceb3c80:
>
>   KVM: s390: fix gisa destroy operation might lead to cpu stalls (2023-09=
-25 08:31:47 +0200)
>
> ----------------------------------------------------------------
> One small fix for gisa to avoid stalls.
>
> ----------------------------------------------------------------
>
> Michael Mueller (1):
>   KVM: s390: fix gisa destroy operation might lead to cpu stalls
>
>  arch/s390/kvm/interrupt.c | 16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)
>
> --
> 2.41.0
>

