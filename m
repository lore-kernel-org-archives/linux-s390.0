Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 361E0C4332F
	for <linux-s390@archiver.kernel.org>; Wed, 25 May 2022 19:49:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344756AbiEYTtl (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 25 May 2022 15:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344309AbiEYTtl (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 25 May 2022 15:49:41 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A211766AEC
        for <linux-s390@vger.kernel.org>; Wed, 25 May 2022 12:49:38 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-300beab2b76so14391647b3.13
        for <linux-s390@vger.kernel.org>; Wed, 25 May 2022 12:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lcsU1M3aHmWM93+N/Pq2k69CNkfyIQUCxczoLH0OLPk=;
        b=hGvqDCPINlCno6IGVx/RQ4/atSQ+dW08eMaP/4u4J2Rx0AU21Orr25m5AgNUJgVoBC
         3FFOnaz5xSM9a3RRyGWmmLYgiZVdvKzEmj7vsHFg6Sh7EwGqNKrvH43xPCnlETqRbyTJ
         rUgPCSCAGnF+I3fcFxMltq5wx33LgoLK4ERO4IR4Sot/Uaxxldi6tkX+WdLxAvCCiEtI
         QP4xUPzpC2rlJZR8sd1n3W8vuHEHoaO4LC9YRcKisj9Uq+DszGcvpWkcK75IpZtbpf64
         JIxJLJ+6BngIh5kjOcaFiUEdbJbMoovEHpIlAtRm4xeoQYYTe1wf9PGaYkAV8y48Abi0
         +6Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lcsU1M3aHmWM93+N/Pq2k69CNkfyIQUCxczoLH0OLPk=;
        b=wCT9qnvy9/V5Gi70eO+ODavAX5SBduIHHhse8v3C+zn5m75+pT7zD1Spr4qodwGUDo
         7ukVqlQSsoMlkjsRPKmGzsBUz+yMFMoS1O9yWjtfN9HbePLEzxE+Gr5lRbi11Kn3lm4R
         L+wnv0ff5evKLE7yTT/XkfN1i99idyuL9UR9CpApMtv7Ebmnkq5JwAKIGk/Sltc/24/0
         9UP5UzA6P4oDLVMO7nVZAevMgEruGBABalUFB5iVbioJFp4YPgI9itA0v2tO2chfkA3Z
         RSugaobIuXS2UG1WlCNu4+Zqla5upI6uTRaSoixDLlI1bQGExS5hHVRUEW06RkOrRU5e
         D4lQ==
X-Gm-Message-State: AOAM5327nXxbv0A6DwulHJeVPoXiE9vfxle9LTGT6FWLlkxgY3DLhMtp
        weTi7rKk8Gmt4+tapjUVeXaABhVOd/8CwV8/n9NI4g==
X-Google-Smtp-Source: ABdhPJye/LYmXdbx2DRGvhYd77idEIGqJLpVK4M7sUVcSaytWZ/KajOi10nwmyuJy9EQw0Od4wYghiCxgCclb01GpVs=
X-Received: by 2002:a81:72c5:0:b0:300:7d0:a642 with SMTP id
 n188-20020a8172c5000000b0030007d0a642mr14402533ywc.80.1653508177547; Wed, 25
 May 2022 12:49:37 -0700 (PDT)
MIME-Version: 1.0
References: <YogkhvFGVcjNQ21Z@dev-arch.thelio-3990X> <CAGETcx9nvBs1b4M=2hBhrLX_2-rzLtAmV9WfTXu0MC7JnsBvwA@mail.gmail.com>
 <YogsiMCDupNUhMgL@dev-fedora.thelio-3990X> <CAGETcx-JyWwoGA3o8eep7E29Cm4DcVT6D1JFJh72jLcqm_mjCQ@mail.gmail.com>
 <Youleo3Ganxbc1sq@dev-arch.thelio-3990X> <CAGETcx-sL08h2toEyxY6ztc6xNuJiPok6iDEeuJ1mOA3nvE+vA@mail.gmail.com>
 <YowHNo4sBjr9ijZr@dev-arch.thelio-3990X> <CAGETcx91_WgpmwEA7mBSvUdyJV0a8ymfaNKTmXq=mAJYAjzq1A@mail.gmail.com>
 <Yo0KyWx+3oX3cMCS@linutronix.de> <CAGETcx_qTLwbjzMruLThLYV+MZD5W2Ox-QwLFQeW=eQgxzq-Hw@mail.gmail.com>
 <Yo3WvGnNk3LvLb7R@linutronix.de>
In-Reply-To: <Yo3WvGnNk3LvLb7R@linutronix.de>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 25 May 2022 12:49:00 -0700
Message-ID: <CAGETcx84ja_w_=vXKDOZnM8EVEcuAg1tX9Kqy57PTkDb1=H4FA@mail.gmail.com>
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

On Wed, May 25, 2022 at 12:12 AM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2022-05-24 10:46:49 [-0700], Saravana Kannan wrote:
> > > Removing probe_timeout_waitqueue (as suggested) or setting the timeou=
t
> > > to 0 avoids the delay.
> >
> > In your case, I think it might be working as intended? Curious, what
> > was the call stack in your case where it was blocked?
>
> Why is then there 10sec delay during boot? The backtrace is
> |------------[ cut here ]------------
> |WARNING: CPU: 4 PID: 1 at drivers/base/dd.c:742 wait_for_device_probe+0x=
30/0x110
> |Modules linked in:
> |CPU: 4 PID: 1 Comm: swapper/0 Not tainted 5.18.0-rc5+ #154
> |RIP: 0010:wait_for_device_probe+0x30/0x110
> |Call Trace:
> | <TASK>
> | prepare_namespace+0x2b/0x160
> | kernel_init_freeable+0x2b3/0x2dd
> | kernel_init+0x11/0x110
> | ret_from_fork+0x22/0x30
> | </TASK>
>
> Looking closer, it can't access init. This in particular box boots
> directly the kernel without an initramfs so the kernel later mounts
> /dev/sda1 and everything is good.  So that seems to be the reason=E2=80=
=A6

Hmmm... that part shouldn't matter. As long as you are hitting the
same code path. My guess is one of them has CONFIG_MODULES enabled and
the other doesn't.

In either case, I think the patch needs to be reverted (I'll send out
one soon), but that'll also mean I need to revert part of my patch
(sets the timeout back to 0) or I need to fix this case:
https://lore.kernel.org/lkml/TYAPR01MB45443DF63B9EF29054F7C41FD8C60@TYAPR01=
MB4544.jpnprd01.prod.outlook.com/

I'll try to do the latter if I can get something reasonable soon.
Otherwise, I'll just do the revert + partial revert.

-Saravana


> My other machine with an initramfs does not show this problem.
>
> > -Saravana
>
> Sebastian
