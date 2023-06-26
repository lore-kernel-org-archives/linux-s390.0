Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1D7AEB64DD
	for <linux-s390@archiver.kernel.org>; Mon, 26 Jun 2023 16:29:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbjFZQ3n (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 26 Jun 2023 12:29:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbjFZQ3Y (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 26 Jun 2023 12:29:24 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 924BBDD
        for <linux-s390@vger.kernel.org>; Mon, 26 Jun 2023 09:28:23 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-51d95aed33aso1523196a12.3
        for <linux-s390@vger.kernel.org>; Mon, 26 Jun 2023 09:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1687796902; x=1690388902;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CDx+IuqzGva1uK4gy9QOPWYhXMmafnbm7x3aeXYCsus=;
        b=Br+Ye6favdnO37HvoZuszkxaHJu1iQNNcuY11vq0ID+bNJi5tvgm14k+y0nk+Vjccs
         WHaUJTWDx1Xy3WcBnUvVjca5tZTziPOka0CTAcDyR3Hiu9SDayO9HAT2ZoXF2SyMEi9/
         GAbOMnj3gqZoZe/dFt5UaTjghy9ixtaY6j0Ds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687796902; x=1690388902;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CDx+IuqzGva1uK4gy9QOPWYhXMmafnbm7x3aeXYCsus=;
        b=YHTpZTijBV/YIgrFlu9o3DnyZJwRlrEog/n1vum/9euwt2IzxsRtk603z+AOK+Uc7K
         W1jcTFWqxpbpp1smy4yLCzTTz7e429MrrddgWRm/uPQoedZz+UqbjS41hcerY4Ck01D6
         ywEXG9KcIOnqlsYlzmS4T+DZEQARIiloo8J7zVP40hgD/nsmzsFip6HBymLVoul4VYIh
         WY4YWBTx8Bv+rlfTN1QBuwlA1pLdGdrsudvPe729CEjzF1JUdPl3w/rWSJl5EGGiWkMG
         6fgoxKdTc0DfPHakJktVd/yvhOxj2w8Qn8mCmRIjOuWV/gYgYIrRyZl9jaBPp9S+b93u
         Fr6g==
X-Gm-Message-State: AC+VfDxb84+KmYx0lHbYiJeXMnONTbCc12ZgfI+NiBgsWMMRlOdLGOzM
        As/hLI52TTEd0cvDUkhHjwPGgDfMaUfeJioIgv1IRXKD
X-Google-Smtp-Source: ACHHUZ5NN8ugeBlaSu1dyenRUfQFPlmDW6jmmEVFDdaMH768onm/VNVNbVG+IFpfYB+7OWrj+cC+CQ==
X-Received: by 2002:aa7:c482:0:b0:51d:419b:3bc6 with SMTP id m2-20020aa7c482000000b0051d419b3bc6mr4042778edq.28.1687796901771;
        Mon, 26 Jun 2023 09:28:21 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id y3-20020aa7c243000000b0051bdf152295sm2971505edo.76.2023.06.26.09.28.21
        for <linux-s390@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jun 2023 09:28:21 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-51d95aed33aso1523181a12.3
        for <linux-s390@vger.kernel.org>; Mon, 26 Jun 2023 09:28:21 -0700 (PDT)
X-Received: by 2002:aa7:cc07:0:b0:51d:a310:c7d8 with SMTP id
 q7-20020aa7cc07000000b0051da310c7d8mr930411edt.2.1687796900833; Mon, 26 Jun
 2023 09:28:20 -0700 (PDT)
MIME-Version: 1.0
References: <ZJWlqGlx6LymL7lO@tuxmaker.boeblingen.de.ibm.com> <ZJWrPSb631x4NIh9@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
In-Reply-To: <ZJWrPSb631x4NIh9@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 26 Jun 2023 09:28:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjjfA27W5=wx_68UcG=dUPw3RZrwpXTGSuLj8hJjJTwiw@mail.gmail.com>
Message-ID: <CAHk-=wjjfA27W5=wx_68UcG=dUPw3RZrwpXTGSuLj8hJjJTwiw@mail.gmail.com>
Subject: Re: [GIT PULL] s390 updates for 6.5
To:     Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, 23 Jun 2023 at 07:25, Alexander Gordeev <agordeev@linux.ibm.com> wrote:
>
> On Fri, Jun 23, 2023 at 04:01:13PM +0200, Alexander Gordeev wrote:
> > Hello Linus,
> >
> > please pull s390 changes for 6.5.
>
> Sorry, this is rather for 6.4 final.

Oh, I only see this now that I'm looking at 6.5 pulls.. With that
subject line, I just snoozed the pull request until today.

It's now next in my queue, though.

              Linus
