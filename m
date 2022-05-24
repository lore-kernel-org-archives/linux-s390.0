Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96A02C433FE
	for <linux-s390@archiver.kernel.org>; Tue, 24 May 2022 17:47:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbiEXRrb (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 24 May 2022 13:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240060AbiEXRr3 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 24 May 2022 13:47:29 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A51915D5E5
        for <linux-s390@vger.kernel.org>; Tue, 24 May 2022 10:47:26 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-2ff7b90e635so124102387b3.5
        for <linux-s390@vger.kernel.org>; Tue, 24 May 2022 10:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=e6VPETmeyZX5JOF6lrU6bxZMJd0n0GPwABfSqTucdjs=;
        b=bZjveAEaUMpvjHfz1Cch8bK+pwqo5wReSl7Ni1ySDkX7vgB+ELyVHAsXpIXDy/NzwQ
         F/baQeyilKuLVyVSZ3e3AFkWzCGjLP/qgdKtUY8I6Yt9r3cYFnDW2ohFYoNsEKr6MYS5
         lTj9Ai76LjkVrc+uNTqmiubbz+0pmokn7RIRVfhrsz/Hy9byfa+AQQHsnVEgdDlwIs+L
         /MVtlD/qzhhotKGBMHeGk5luHST+bgqa6sQdqklFRiQXgo7W6TChKNkAQk57YkYZePEG
         mNoW/y/qBqR0twFm26Kyrx/dG4oRQ86aObRbtuGaU8bvLjKWJQHgSKYtBQFQLNzrfScW
         bbcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=e6VPETmeyZX5JOF6lrU6bxZMJd0n0GPwABfSqTucdjs=;
        b=MSKTVxgXW2x1J2soTe0SW5/WHq1YKfFmHN6lcaadoeVXjmq+rQ62yyTpDsc6ExRrj8
         LS73Fgy6HV7QINaZIIXWxIs2K/LzQF765N+YjBrOu38blgtf2wqfsogPI59TnHIT0QsO
         d+97tTyRBDc8RZ+7p0PcgXs4uyKor6vRjasZOtr33gKwSCUaJOoG3cVMlLC8g8uo8i2J
         mRZRr6uu6HdfmrGKzSmZZMwTpXo8uXaAZQBC2aow7+8dD5+J5Z0HFgxxYJ1r9cg2Wn/f
         vj2b5JtT1M8F7H6HBWyBcrYfwrHLQpLKS2lQGqh5RvJMpYszNZEtFYhR2sL0Wf3u6ifS
         9tSw==
X-Gm-Message-State: AOAM531hLCLkhrvZI2tpa64WYFXpxBrHD1TNglvCealsi27yHQToPID3
        g/jIDdpQLEdN1T1Ik9At8HKvsItBNfaDSLTZKtFcSQ==
X-Google-Smtp-Source: ABdhPJywyPDKCAP33MtzxfXuYMCC6HltN18smuTT+NiEjrolMWs5gH6m5KLHG22tADmM3eKx+ae1gKCOsi42FnXISCA=
X-Received: by 2002:a0d:e903:0:b0:2ff:43a3:90c8 with SMTP id
 s3-20020a0de903000000b002ff43a390c8mr29118839ywe.455.1653414445758; Tue, 24
 May 2022 10:47:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220429220933.1350374-1-saravanak@google.com>
 <YogkhvFGVcjNQ21Z@dev-arch.thelio-3990X> <CAGETcx9nvBs1b4M=2hBhrLX_2-rzLtAmV9WfTXu0MC7JnsBvwA@mail.gmail.com>
 <YogsiMCDupNUhMgL@dev-fedora.thelio-3990X> <CAGETcx-JyWwoGA3o8eep7E29Cm4DcVT6D1JFJh72jLcqm_mjCQ@mail.gmail.com>
 <Youleo3Ganxbc1sq@dev-arch.thelio-3990X> <CAGETcx-sL08h2toEyxY6ztc6xNuJiPok6iDEeuJ1mOA3nvE+vA@mail.gmail.com>
 <YowHNo4sBjr9ijZr@dev-arch.thelio-3990X> <CAGETcx91_WgpmwEA7mBSvUdyJV0a8ymfaNKTmXq=mAJYAjzq1A@mail.gmail.com>
 <Yo0KyWx+3oX3cMCS@linutronix.de>
In-Reply-To: <Yo0KyWx+3oX3cMCS@linutronix.de>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 24 May 2022 10:46:49 -0700
Message-ID: <CAGETcx_qTLwbjzMruLThLYV+MZD5W2Ox-QwLFQeW=eQgxzq-Hw@mail.gmail.com>
Subject: Re: [PATCH v1] driver core: Extend deferred probe timeout on driver registration
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rob Herring <robh@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Will Deacon <will@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        Thierry Reding <treding@nvidia.com>,
        Mark Brown <broonie@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org,
        iommu@lists.linux-foundation.org, kernel-team@android.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, John Stultz <jstultz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, May 24, 2022 at 9:41 AM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2022-05-23 20:43:06 [-0700], Saravana Kannan wrote:
> =E2=80=A6
> > Thanks for all the help. I think I know what's going on.
>
> I, too got here because my boot recently was extended by 10 seconds and
> bisected to that commit in question.
>
> > If you revert the following commit, then you'll see that your device
> > no longer hangs with my changes.
> > 35a672363ab3 driver core: Ensure wait_for_device_probe() waits until
> > the deferred_probe_timeout fires
>
> Removing probe_timeout_waitqueue (as suggested) or setting the timeout
> to 0 avoids the delay.

In your case, I think it might be working as intended? Curious, what
was the call stack in your case where it was blocked?

-Saravana
