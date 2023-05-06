Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C31C77B75
	for <linux-s390@archiver.kernel.org>; Sat,  6 May 2023 15:00:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232526AbjEFPAT (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Sat, 6 May 2023 11:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232441AbjEFPAS (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sat, 6 May 2023 11:00:18 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499991F491
        for <linux-s390@vger.kernel.org>; Sat,  6 May 2023 08:00:14 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-b9e2f227640so3801688276.3
        for <linux-s390@vger.kernel.org>; Sat, 06 May 2023 08:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683385213; x=1685977213;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZNkRsBy8jmIVOhIRX+lWXHSIur+vpg4Wn3ELaF1i2/0=;
        b=ZmdzqLS7xSvYD2Tbhfh/xD6/b0N0VaYrB7D3bpjpM36biGof/ncmLOhzLWoIRM4cxF
         rMZuyK/868Q8/3/uztmdNnPJk14WbMEzNvGdrov5+03ZViNqoXppPMxy9vrvL9j84D7g
         GSuNPVcmceAtcQ9+Uzt80t8DcXKwULrXUvm48lNt3y8Yhi8l2Zhx+QwAMG5ni2+AlBiJ
         8hz3UAsQRprdGU/DBRYQE+5axbtEwRQoIz9QJ9KDBWWuU6JvPsIvZxjBedCh6FVtzjaJ
         vFtbxStWRajPCnXrtPlPHoocAmC6K5oWlSKo82gT/zfZCUHufdmxCEtmM7/o8TDNNtM9
         sMmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683385213; x=1685977213;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZNkRsBy8jmIVOhIRX+lWXHSIur+vpg4Wn3ELaF1i2/0=;
        b=Oyz+pvc6nJqTXJOMHAskC21Bmf/Jf2NBPbb9yvZiYODUDRXyjZX2JljShXsURjoMgf
         sawZrGI8tq0zb5N5RUXrb26YSE4M/lOBEJ9pJaWhqGqcJMjumgZgPxeaBEL1BIfTBsCK
         Q0cdI/gvUwPwjLG8HkQdcKwr0Z9i+lFldyMQzV/7lYnaP8PDwHrVRp4fjhqD+5Oj/L1N
         RInL6StL6YXKAJIMQ21zHW5CbiTAjvkM+azgORsoXva5tzC14zV+n0mCffq9TIHNsemx
         ho5hbK+iTruV9N7CGSjGLdNVVY0GfI0a+U2H0jfvCf48dkrrs86lhRgYHvA3vCfIvTD9
         PISA==
X-Gm-Message-State: AC+VfDyA9M9JW9M8cQmPMsgEqyWY7pj9CjuZp1sdjO4VyDPxhwEh7gu7
        xH/OUabp3b3PCwbadb3IMIXkuFlQxZ1LD/WuB+ScNw==
X-Google-Smtp-Source: ACHHUZ5ED6NTeLKj6ZlWakj64JmtHbV7+2WxtnKr2jb5gYyUufWJOGNRCQ+8FBR8LT9KgvEWrmKoBkfq7E5K8qY84V8=
X-Received: by 2002:a25:abec:0:b0:b9e:7ec8:5d41 with SMTP id
 v99-20020a25abec000000b00b9e7ec85d41mr4713885ybi.55.1683385213473; Sat, 06
 May 2023 08:00:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230506111628.712316-1-bhe@redhat.com> <20230506111628.712316-2-bhe@redhat.com>
In-Reply-To: <20230506111628.712316-2-bhe@redhat.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 6 May 2023 17:00:02 +0200
Message-ID: <CACRpkdYo+NPtqjbUCrohE8yhyvc3vuqycP6RctY5rsiZXiiQWw@mail.gmail.com>
Subject: Re: [PATCH RESEND 1/2] pcmcia : make PCMCIA depend on HAS_IOMEM
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        schnelle@linux.ibm.com, linux-s390@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Sat, May 6, 2023 at 1:16=E2=80=AFPM Baoquan He <bhe@redhat.com> wrote:

> On s390 systems (aka mainframes), it has classic channel devices for
> networking and permanent storage that are currently even more common
> than PCI devices. Hence it could have a fully functional s390 kernel
> with CONFIG_PCI=3Dn, then the relevant iomem mapping functions
> [including ioremap(), devm_ioremap(), etc.] are not available.
>
> Here let depend PCMCIA on HAS_IOMEM so that it won't be built to
> cause below compiling error if PCI is unset.
>
> -------------------------------------------------------
> ld: drivers/pcmcia/cistpl.o: in function `set_cis_map':
> cistpl.c:(.text+0x1202): undefined reference to `ioremap'
> ld: cistpl.c:(.text+0x13b0): undefined reference to `iounmap'
> ld: cistpl.c:(.text+0x14a6): undefined reference to `iounmap'
> ld: cistpl.c:(.text+0x1544): undefined reference to `ioremap'
> ld: drivers/pcmcia/cistpl.o: in function `release_cis_mem':
> cistpl.c:(.text+0x3f14): undefined reference to `iounmap'
>
> Signed-off-by: Baoquan He <bhe@redhat.com>
> Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Dominik Brodowski <linux@dominikbrodowski.net>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
