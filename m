Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10B38C25B67
	for <linux-s390@archiver.kernel.org>; Thu, 26 Oct 2023 12:30:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbjJZMa4 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 26 Oct 2023 08:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbjJZMaz (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 26 Oct 2023 08:30:55 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A24E293;
        Thu, 26 Oct 2023 05:30:53 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-578b407045bso709848a12.0;
        Thu, 26 Oct 2023 05:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698323453; x=1698928253; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Bfroj9n080MYfqbukp7pTgYHmgkaK+GzbuW5Vo7aTJE=;
        b=DuLNSFCSWzcUXLqIGkRpCQmY5FMvF/Pxya1a8Qq76V97MjiwSWn3AO+X+k4y8nSkhq
         PlPdwXgSVGlFlMHu0bK7+Uy1rRJW+F3fbtKGeE8QPyP2aFBGfD7csh7eW4mm3GQXi9Tk
         9gRw2FtfXCF0EVH/y0Ro45/KERGDdF1OxzFZG08JYiXkbHRQCCznus9b/MROCQKzWsEo
         Gg3VpX1zcj+Tp1O72WGYor6VMwqMVEWyEzgNI+Xx7+B5tsETlcv0RVoUz6NnM9KJRtXh
         I6wLNOi2wDDBr//QBRP4JwXyIBzwyJaLns3JRxPOABuV+Yy0zncrH4OI28mTBG80wfKm
         d+jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698323453; x=1698928253;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bfroj9n080MYfqbukp7pTgYHmgkaK+GzbuW5Vo7aTJE=;
        b=SzfWi02oRYyHd2qAlrqIuEYU8sHFfajvKaD5Vb+GCNJXKfgcKHUh1ch1iILrnfjLfk
         RdOfpo1o7AqY0DUn+FO73tfhSVmk40o+XPWrjLhY2noCuoWo/dq3f0/iZaVjMdknFMNC
         0/1fOpH8AHWGZByA09p7FidPKwG6TOjplhWi7z94oetEu4nGurmY+YoKRJR+p6G0SL9J
         HVirTBfehzri/+YVN731gPMiXEcQeyQhEzuCuTd53PowUZ/Nb6ztc+6M0fYwKfLq50Km
         WTMxUc4fifQijKXrT4Sq+yWL1S7HCtm5H2qE0+UJYTNnIK0ftriFoBO4vSEVN3bcG1xR
         +g9A==
X-Gm-Message-State: AOJu0YyBSgQAxkMtmOngD8/u7DzGjbsJE7gzCBiy8nxhvI32huaqf7Kz
        ji9ZuXCbL+DFTwljn22D3hDQ+zfjsmMTLpWE6y83AVNKIGQ=
X-Google-Smtp-Source: AGHT+IFFIUrsKPWXFShMEhXa4XESaWoqvUprdvYOpefCgCH61u2tDkAucw/zkQkZbGhYC9Dm0+TOMFcGDBAMNxO34Yo=
X-Received: by 2002:a17:90a:be05:b0:27c:f8e1:7506 with SMTP id
 a5-20020a17090abe0500b0027cf8e17506mr16416982pjs.22.1698323452731; Thu, 26
 Oct 2023 05:30:52 -0700 (PDT)
MIME-Version: 1.0
From:   Daan De Meyer <daan.j.demeyer@gmail.com>
Date:   Thu, 26 Oct 2023 14:30:41 +0200
Message-ID: <CAO8sHcn3+_qrnvp0580aK7jN0Wion5F7KYeBAa4MnCY4mqABPA@mail.gmail.com>
Subject: s390x stack unwinding with perf?
To:     linux-s390@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     "dcavalca@meta.com" <dcavalca@meta.com>, ngompa@fedoraproject.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi,

As part of enabling frame pointers system wide for Fedora to get fast
system wide stack unwinding, we're now looking to do the same for
s390x after previously enabling frame pointers for x86-64 and aarch64.
From what we can find, on s390x stack unwinding is done via the
"-mbackchain" compiler option. However, from some early experiments
rebuilding a small part of the distro, this option alone does not seem
to result in usable stack traces in perf (perf record -g => perf
report).

Are there any other compiler options that need to be enabled in order
to get usable stack traces in perf for s390x? Has anyone managed to
get this working before?

Cheers,

Daan De Meyer
