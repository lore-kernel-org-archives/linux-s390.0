Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8043DC001DE
	for <linux-s390@archiver.kernel.org>; Fri, 11 Aug 2023 17:49:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235996AbjHKRtO (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 11 Aug 2023 13:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235921AbjHKRtN (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 11 Aug 2023 13:49:13 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 567451BD
        for <linux-s390@vger.kernel.org>; Fri, 11 Aug 2023 10:49:13 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-d075a831636so2111504276.3
        for <linux-s390@vger.kernel.org>; Fri, 11 Aug 2023 10:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691776152; x=1692380952;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IUwS78/plVVa6OoEj+AWgYgZJxdiiaMtOa1TwsZ9DQw=;
        b=Q1ZYrwwhQpPo+fdOPFXzX9x/95cTxObZcO2ycCJr7eHrysZCasYebCGJ5YR0Ccsgro
         4ygjLi0qSK82vnoTgbCPHYr8KTkqXzrY38es57zHKVpnUxrTUMquUfVLKeM/aYzNnx6S
         U6AnSnVtB9MiVgzJUGYHZ+XkKaWs5bm3Vhoq02uP/m0rE57v0YrPxMVeISa3EFTdu6RV
         fE2COONF0bWd1GE2VGPYSCBhebjek86RJe1pZHjc7n6qSokVzdjgf5O+zSgyDjouEn6t
         ST24mTi4AlzJukRWdbCkPmqJ7+7i/lN4pIz/MIXRm0NYZqdaVQ7vc2x1wCLHiGzhOBlO
         BmTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691776152; x=1692380952;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IUwS78/plVVa6OoEj+AWgYgZJxdiiaMtOa1TwsZ9DQw=;
        b=hwnVzO05efniSQRliQSpvV8Q1g4BTu3/n9NglsETbqHI/q+DOQjQu+2cTgjmSS6LhG
         ZE0QcTcddjNuxyVTPxp6xFkrdhQeCYFqv+kCUqVDMxcGs8hTpD2/IK2FAG5LPWg4q7hK
         BX9KIwOj7iZ/Z9LTZ5sEQNU+zoh9k3hk6s5cU1wFk5S8jSs/BNYxM3W4ltJ+SYGzdSAD
         2bu0n3Fo6KWsvFDV/N51n4xiKtDQj1hXA9CiUBOke/KNfK173SKk62YIoq8caXWJOM/R
         V6DLRuAPkX5EO6xrVB+qo1YOJ8wXiGqis/zbKZ/1u8+6OlmgWPBs37wmKvLSys4jWhYD
         tCIw==
X-Gm-Message-State: AOJu0YwVX5hHvokNoBDY4FlJGWRNGJOKOcAbp4aFlWy6ncYrlIN9oBMR
        afemNqs7PlciAd51SgH6kXkmfrOzB5CpkMJcK/alaA==
X-Google-Smtp-Source: AGHT+IFzajkGqhTK4Ec8035fdlJ7e7aiAbnrqAvCXY8R5Wo7McWs7Jymvrkb8MUzTpn+keNc881FFqj9Prd9pF2OZRs=
X-Received: by 2002:a25:e910:0:b0:c60:982f:680c with SMTP id
 n16-20020a25e910000000b00c60982f680cmr2199874ybd.63.1691776152522; Fri, 11
 Aug 2023 10:49:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230811-virt-to-phys-s390-v1-1-b661426ca9cd@linaro.org> <ZNY7PvtP0jI1/xF1@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
In-Reply-To: <ZNY7PvtP0jI1/xF1@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 11 Aug 2023 19:49:01 +0200
Message-ID: <CACRpkda2H_Ls7FT-GPkM2HLci0rLomwcP+Y5e7CJgXtT2NxJqA@mail.gmail.com>
Subject: Re: [PATCH] s390/mm: Make virt_to_pfn() a static inline
To:     Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        kasan-dev@googlegroups.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, Aug 11, 2023 at 3:44=E2=80=AFPM Alexander Gordeev
<agordeev@linux.ibm.com> wrote:

> Funnily enough, except drivers/s390/char/vmcp.c none of affected
> code pieces below is an offender. But anyway, to me it looks like
> a nice improvement.

I'm puzzled, vmcp.c is a char * so actually not an offender
(I am trying to push a version without casting to the compile farm),
the rest are unsigned long passed to the function which now
(after my change) has const void * as argument?

Example:

> > @@ -90,7 +90,7 @@ static long cmm_alloc_pages(long nr, long *counter,

unsigned long addr;

> > +             diag10_range(virt_to_pfn((void *)addr), 1);

Yours,
Linus Walleij
