Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 103B0C77B75
	for <linux-s390@archiver.kernel.org>; Sat,  6 May 2023 01:57:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232920AbjEFB5a (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 5 May 2023 21:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232904AbjEFB53 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 5 May 2023 21:57:29 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0EB54C10
        for <linux-s390@vger.kernel.org>; Fri,  5 May 2023 18:57:25 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-50bc394919cso3702228a12.2
        for <linux-s390@vger.kernel.org>; Fri, 05 May 2023 18:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1683338244; x=1685930244;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NEWaeK4UyXB7rn8ZKDm/RsGKdWKXNNR3xA3d9AaLO1U=;
        b=hfkmoCh9+s9eKjC4ySe+4Oi67C/X5glrG1WMZThklykBNLtF6xkISkUYXQdjRy3kqk
         YMVi+1x+ugZ7n95TeLfloGPhgP4fjXsBUAHE8HfVZlY233wq2xiIZV4axu7COJa4bdfI
         xslVOq3uM1pBH3AyUAVnmTSDlY0O9O4qouG9c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683338244; x=1685930244;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NEWaeK4UyXB7rn8ZKDm/RsGKdWKXNNR3xA3d9AaLO1U=;
        b=HU7HNsmSHZZ38NJKi2ArCb6szKBtP4k+IGLUJw1ics+dwwdPRlk+8YGc4gNr3O+HI0
         lFob5sd6AgGrChDFLMuRTRKjhnCEX9bxhSCwRP4T5I9sQsjaLEVoI8ignfTj3BkJsugx
         UZOR+Ojj1mOsTQB6soOIcpDSXrKFpNCsQbELGxJ9WR8120j5DBimEk3GBORu+hOyhkLz
         vWq9GybdL2AlLYPBYaOeDCoXX5uofY9V7ypV6TwIG+E769/efrFE1CslKk6l/ANFVcSl
         f0MpQ0niy2+rT3i+Our1hoZAXOtoOEWuyvqrFavcoPAnkk0DD8WzFF40Y+JzXpkY5XjC
         L9kA==
X-Gm-Message-State: AC+VfDxiWcYWCFsfFj7PwR8ZaTjwKsEKOuAQcBqCP9g0ylQDX9lljajZ
        dEYJmq0u5+lfZQ8B/A9P06kG5cJtN2/PI+4WbEtb5A==
X-Google-Smtp-Source: ACHHUZ6LDKgstRv8L3SvJVsve00Y2WIsXh9xVh+JIKQL3gBfMq03HRjlI4iQMtZEO+QjK/ThzdkpQw==
X-Received: by 2002:aa7:ca46:0:b0:50d:8991:d1b9 with SMTP id j6-20020aa7ca46000000b0050d8991d1b9mr1108869edt.8.1683338244048;
        Fri, 05 May 2023 18:57:24 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id h7-20020a1709060f4700b0096347ef816dsm1641006ejj.64.2023.05.05.18.57.22
        for <linux-s390@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 May 2023 18:57:22 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-965ab8ed1c0so399574066b.2
        for <linux-s390@vger.kernel.org>; Fri, 05 May 2023 18:57:22 -0700 (PDT)
X-Received: by 2002:a17:907:6eaa:b0:94a:9ae2:1642 with SMTP id
 sh42-20020a1709076eaa00b0094a9ae21642mr3442159ejc.46.1683338242456; Fri, 05
 May 2023 18:57:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230505223909.29150-1-lukas.bulwahn@gmail.com>
In-Reply-To: <20230505223909.29150-1-lukas.bulwahn@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 5 May 2023 18:57:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiX6xj9ck9u7_iN6HRFbLtpXSGfHtidUZSHfddx87FLdg@mail.gmail.com>
Message-ID: <CAHk-=wiX6xj9ck9u7_iN6HRFbLtpXSGfHtidUZSHfddx87FLdg@mail.gmail.com>
Subject: Re: [PATCH] s390: remove the unneeded select GCC12_NO_ARRAY_BOUNDS
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        linux-s390@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, May 5, 2023 at 3:39=E2=80=AFPM Lukas Bulwahn <lukas.bulwahn@gmail.c=
om> wrote:
>
> Linus, as this is just a quick clean-up improvement to your commit
> "gcc: disable '-Warray-bounds' for gcc-13 too", this can probably just
> go directly to your tree.

Done.

               Linus
