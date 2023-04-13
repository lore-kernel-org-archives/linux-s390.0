Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 966D2C77B71
	for <linux-s390@archiver.kernel.org>; Thu, 13 Apr 2023 07:45:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbjDMHp2 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 13 Apr 2023 03:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbjDMHp0 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 13 Apr 2023 03:45:26 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 763208A62
        for <linux-s390@vger.kernel.org>; Thu, 13 Apr 2023 00:45:23 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id e20so14319449lji.6
        for <linux-s390@vger.kernel.org>; Thu, 13 Apr 2023 00:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1681371921; x=1683963921;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ROFpaYIgq26cLIkNVEnMozH6cn/rivsqCvSc2ZNZaHk=;
        b=sT853BPAZjADMB9yC1BBJjhv8Np0nLG5ajZbEGvtw4KTKxOss+bTxAD5nVx8fCi8Ci
         z9oPYYEnhQUeMs2XBLUrgcIYiNN51pVQDIcPmPB35/UTbaKUBA38w4xLXnXynxBwmnAq
         lstVjTbzbdxgncTPnZnmg4c87lNxe9TFwDzFh7dXjZr6CWV7R+twSkH9YpDg5aHFeRkw
         GJPR/eGbVRloIzOw12kaXJ1tHGHY5XkcpGza0CaoI4BfrBzDh2J244DyfgP7XstgVB5u
         lqDKaVfeRJsk8UFYK79xNDxwL1SCQWPylh5Eq1PYiCmv9kE4K2II5sep9vreUUTUmxrY
         vQOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681371921; x=1683963921;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ROFpaYIgq26cLIkNVEnMozH6cn/rivsqCvSc2ZNZaHk=;
        b=hXLEeLxersnAlFeJWpbHz9lg0IVQUCEXGkoExzVPAXh2mweJ7pR6sJdQ8Qx4cLPzdt
         1tOnnq95h2w0z/fSzEYhcrLOiNRG5ieUmLxDf2TSBwz/w2HZlPd3tV/igSUi99njXg0l
         qR06opd9EBK2fAk5Vnmt3CETE4sPRkjNSTN8Wg40P7/Ct4VH5/9MGcpH1rWn/bjaJoue
         Dun6Dmu2lH/1e8cYtRJGknx2H7eVhSNddCl7KmxjOXY1ruSUpKjspmerJOQsytrYK0Rm
         3lpWrtyrcHqFDVUlT0zeg4TS31qfiT3Ts6IHcH2nnmX3eO6m0mN7MiYBdkXUWZdH5Ugy
         lxiQ==
X-Gm-Message-State: AAQBX9cmC6hSytfx6+dCKmTj1NPHrjD+H+x1VPIv4d8MpUYlbK3UsMa2
        bV44cNJ+jSzyCWcEDsDsXnAXs2LC2tzsktb6McgvXA==
X-Google-Smtp-Source: AKy350bBI4Fp6Ci7UvqsEgEgFGoHSlyFUIgJYynKIcaXzkcGlGr+epkjYXP55Xf+Eq2cFiXHMyEbSrHk6Xv25XlDpwY=
X-Received: by 2002:a2e:808d:0:b0:2a7:9f4c:ce94 with SMTP id
 i13-20020a2e808d000000b002a79f4cce94mr424287ljg.8.1681371921665; Thu, 13 Apr
 2023 00:45:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230324195029.2410503-1-viktor@daynix.com> <AM0PR04MB4723A8D079076FA56AB45845D48C9@AM0PR04MB4723.eurprd04.prod.outlook.com>
 <20230404141501-mutt-send-email-mst@kernel.org> <AM0PR04MB4723AB600C87D77AB486D035D4989@AM0PR04MB4723.eurprd04.prod.outlook.com>
In-Reply-To: <AM0PR04MB4723AB600C87D77AB486D035D4989@AM0PR04MB4723.eurprd04.prod.outlook.com>
From:   Viktor Prutyanov <viktor@daynix.com>
Date:   Thu, 13 Apr 2023 10:45:10 +0300
Message-ID: <CAPv0NP7gms2FMOaysnphYSK=4qgo3GVKPd7pUMxsPS1C6bTj4g@mail.gmail.com>
Subject: Re: [PATCH v6] virtio: add VIRTIO_F_NOTIFICATION_DATA feature support
To:     Alvaro Karsz <alvaro.karsz@solid-run.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
        "pasic@linux.ibm.com" <pasic@linux.ibm.com>,
        "farman@linux.ibm.com" <farman@linux.ibm.com>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "yan@daynix.com" <yan@daynix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, Apr 13, 2023 at 10:40=E2=80=AFAM Alvaro Karsz
<alvaro.karsz@solid-run.com> wrote:
>
> > Hmm.  So it seems we need to first apply yours then this patch,
> > is that right? Or the other way around? What is the right way to make i=
t not break bisect?
> > Do you mind including this patch with yours in a patchset
> > in the correct order?
>
> Ok, I'll create a patchset.

Thank you!
