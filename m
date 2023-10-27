Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C41FEC25B47
	for <linux-s390@archiver.kernel.org>; Fri, 27 Oct 2023 08:01:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbjJ0IBL (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 27 Oct 2023 04:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234816AbjJ0IBH (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 27 Oct 2023 04:01:07 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EAEA1B4;
        Fri, 27 Oct 2023 01:01:05 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6bd32d1a040so1758482b3a.3;
        Fri, 27 Oct 2023 01:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698393664; x=1698998464; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HcgTb1uk+LNET/CdwAZQedqtTls7gJN7u/d99YpV55w=;
        b=P/eFvflarEUqQj5mTndnOvUNh5X8QKTacIA01uiR+572YFSR96Mo4NknFcqcTNjchf
         bAUsFMdoEZVdSgvsCPPXcVG2KD4xSUna28Jax0+S86KLTqH6Wc45HQQtZeqzWygUn6Lm
         Y8CxirOe7UbgWJl73QVASFXT26LaN7sg15xhVlq9ABydTa06/xNRgXhXREcW2e5LOJYE
         xCqjGPHwO4mfHgS7LyIJ6hfEZHWQmeomYiGvmuFUVy0WkTZBkr7UmHcpa1MN7FzcpqdP
         esubUsLEZkzyWwfWtMktqOu9KwlzgjzZp3GB+Jn9dnn870Dj+2awNiAlc1q+FwPobNBW
         H5DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698393664; x=1698998464;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HcgTb1uk+LNET/CdwAZQedqtTls7gJN7u/d99YpV55w=;
        b=leCieb8cETS0ggutk7wnGcWB1Dd1jirgsDqFcgEGIxWok5qRHyyQuTrNdWt1UEL1s6
         uvrnKIv1C7RplmF0PH+gRHG3jbxL6StJ66R6jTCbIG7PIxhSAAeqtpRM8H19FC/Ff7Hk
         LFq+Bwltnj4j7l/ib3GBFZcPJLWCtgNUU1pF6Emx1hqX4OBULyEknBDkbxs33QoLYTTW
         jwecJM0bcMk/r8WWUl6fZz+PXkMKiidTxHM32cobcEeAcSw6oIk8oN30YWJHtthsHDKN
         bATrvPipyklk7SncsqfiuYfcTpE4D75gsAPAjhLFi/U5HWQ0ol7MSEH7jzJsZzSgVX7M
         7epQ==
X-Gm-Message-State: AOJu0YzEPLRpVPM6S2906Id2mIfl3aUb46RWPDvr802mmkIKAJrnuPKp
        k7deiILv90PySKDRPCzmo5P13hBGJbwKD058mgpCai+WL8KeeMsu
X-Google-Smtp-Source: AGHT+IE+cWamXBpcNmOndSqM2PXeMYmq4wS3kkttK+0iU1/3Sst/PqOIa91Kf4ZC1XQ3lTMcsohN1Eq96Oc3+EdeRWA=
X-Received: by 2002:a17:90a:7563:b0:27d:853:9109 with SMTP id
 q90-20020a17090a756300b0027d08539109mr1881208pjk.20.1698393664495; Fri, 27
 Oct 2023 01:01:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAO8sHcn3+_qrnvp0580aK7jN0Wion5F7KYeBAa4MnCY4mqABPA@mail.gmail.com>
 <20231026145659.7063-A-hca@linux.ibm.com>
In-Reply-To: <20231026145659.7063-A-hca@linux.ibm.com>
From:   Daan De Meyer <daan.j.demeyer@gmail.com>
Date:   Fri, 27 Oct 2023 10:00:53 +0200
Message-ID: <CAO8sHckF_D+SjvGySsGHOpOcdy6y7pwQEF9SfV3sw4Ye4_sCKA@mail.gmail.com>
Subject: Re: s390x stack unwinding with perf?
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-perf-users@vger.kernel.org,
        "dcavalca@meta.com" <dcavalca@meta.com>, ngompa@fedoraproject.org,
        Andreas Krebbel <krebbel@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

> > Hi,
> >
> > As part of enabling frame pointers system wide for Fedora to get fast
> > system wide stack unwinding, we're now looking to do the same for
> > s390x after previously enabling frame pointers for x86-64 and aarch64.
> > From what we can find, on s390x stack unwinding is done via the
> > "-mbackchain" compiler option. However, from some early experiments
> > rebuilding a small part of the distro, this option alone does not seem
> > to result in usable stack traces in perf (perf record -g => perf
> > report).
> >
> > Are there any other compiler options that need to be enabled in order
> > to get usable stack traces in perf for s390x? Has anyone managed to
> > get this working before?
>
> So, are you saying that you want to enable "-mbackchain" for whole user
> space for Fedora? If that is the case, what certainly is missing is kernel
> support to unwind user space stack frames from the kernel, since until now
> no distribution had user space where it would be possible to unwind the
> user space stack from the kernel; which is the reason why this was never
> implemented.
>
> If this (or some other compiler options) will be enabled for user space, we
> need to add kernel support in order to make this work.

If the kernel gets support for s390x user space unwinding using the backchain,
we'll propose to enable -mbackchain in the default compilation flags for Fedora
so that s390x on Fedora will have the same profiling experience as x86-64, arm64
and ppc64. For now we'll keep the status quo since compiling with the backchain
doesn't provide any benefit until the kernel unwinder can unwind user
space stacks
using it.

Thanks for clarifying the current state of user space stack unwinding on s390x!

Cheers,

Daan





On Thu, 26 Oct 2023 at 16:57, Heiko Carstens <hca@linux.ibm.com> wrote:
>
> On Thu, Oct 26, 2023 at 02:30:41PM +0200, Daan De Meyer wrote:
> > Hi,
> >
> > As part of enabling frame pointers system wide for Fedora to get fast
> > system wide stack unwinding, we're now looking to do the same for
> > s390x after previously enabling frame pointers for x86-64 and aarch64.
> > From what we can find, on s390x stack unwinding is done via the
> > "-mbackchain" compiler option. However, from some early experiments
> > rebuilding a small part of the distro, this option alone does not seem
> > to result in usable stack traces in perf (perf record -g => perf
> > report).
> >
> > Are there any other compiler options that need to be enabled in order
> > to get usable stack traces in perf for s390x? Has anyone managed to
> > get this working before?
>
> So, are you saying that you want to enable "-mbackchain" for whole user
> space for Fedora? If that is the case, what certainly is missing is kernel
> support to unwind user space stack frames from the kernel, since until now
> no distribution had user space where it would be possible to unwind the
> user space stack from the kernel; which is the reason why this was never
> implemented.
>
> If this (or some other compiler options) will be enabled for user space, we
> need to add kernel support in order to make this work.
