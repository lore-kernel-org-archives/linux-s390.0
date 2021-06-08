Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77C54C47082
	for <linux-s390@archiver.kernel.org>; Tue,  8 Jun 2021 15:14:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 615B06128A
	for <linux-s390@archiver.kernel.org>; Tue,  8 Jun 2021 15:14:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232287AbhFHPQc (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 8 Jun 2021 11:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232116AbhFHPQb (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 8 Jun 2021 11:16:31 -0400
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88BF9C061574;
        Tue,  8 Jun 2021 08:14:21 -0700 (PDT)
Received: by mail-vk1-xa36.google.com with SMTP id k71so234426vka.11;
        Tue, 08 Jun 2021 08:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=O1gHl02oivo3RqMJKlwA/A5dzOE7PgpnMHshZI9Ylrs=;
        b=q/pGziiOz9jkwf1xpb1EEOjAPz/8OP9lR8P5rwugXRCKdIw+1wS1ArDWbo56DTgYcO
         2xIIfHxWOdAkxjck+U0UFvbyJXLOxqC0e39gdVGuoyznrtl6Kqsbm0vXEM9F9Ph6UxlB
         rR5msRf1tYIkQmYvAoVpDNmbWTNV7I44HNDPmtNDKlNk0+jSHN0zTfRpSQal7ClgWNKL
         nt58hzE/ILIPgRy01To/yIbhd4Nn1FvYEU+6H+m4XZ6Yl5ZdcJKv99WcwWeAt69su8a1
         jHh7JWQyepBhzoAemaPXbFi97EGcaWlnBbUsAZgHFnVI4KURGRzpgTzD9HaiwUKNr0lJ
         8aOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=O1gHl02oivo3RqMJKlwA/A5dzOE7PgpnMHshZI9Ylrs=;
        b=KbbPBs6QDzECgm96/DOsRDjdmqUJnnO6UBzF975xszySLWG7M9rJxY7YJrBBv+01rQ
         71E/+mqQcsOEKCi/6ye9gfy/kKTSJ0MnsrL1P9Vr1VDEgvDT6OgpevXWv/QX9hW2vSyC
         HdoCYhn8/g2M7a5EoOVVzmcWemx3czdH9AkPD2FDAWlc9YQeaP/yPiFv3ntlNJqu94Fu
         bwM4qQ64NRJCYqwlkxNG1cjKH2QmoT2YatfYt/Fi/S2R13espuSrFKCfxhb3s9XKq8iu
         k711qvgchVCQaIMgXaPyFy9e1/FQ1DJfgtJXsfFxHN+LiLdNfvIOiQ5LO/Gd2P/0IV0C
         xzhQ==
X-Gm-Message-State: AOAM532deFgQB6epF4q8ySf/ObUt/UXMCjB58Ydlk+/S9NAhY8n1jJ+A
        iCd327Lb/AjV1ga1Pkh1zGDHT92frSzcdA23qhs=
X-Google-Smtp-Source: ABdhPJzvEmzWuahJjCnq+ZMJixhpkm3KNp6kok+q20Al/eAGM2mP9WokEC+P56s7XJVWAW/iqzmnjaTihV1wlYq26Ug=
X-Received: by 2002:a05:6122:a1b:: with SMTP id 27mr387134vkn.23.1623165260736;
 Tue, 08 Jun 2021 08:14:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210608083418.137226-1-wangkefeng.wang@huawei.com>
 <20210608083418.137226-2-wangkefeng.wang@huawei.com> <CAFqt6zYmCQ=wxEjnOJ6fgJWYQyFajBuxWD=UT_D-WjWUS_4pcw@mail.gmail.com>
 <34f88fdc-1842-7954-bccc-0142a8d66eea@csgroup.eu>
In-Reply-To: <34f88fdc-1842-7954-bccc-0142a8d66eea@csgroup.eu>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Tue, 8 Jun 2021 20:44:08 +0530
Message-ID: <CAFqt6zbV32+FsEFywqb6vk90tQ442S63CO+bh=2h8OxxutYQEQ@mail.gmail.com>
Subject: Re: [PATCH v3 resend 01/15] mm: add setup_initial_init_mm() helper
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        uclinux-h8-devel@lists.sourceforge.jp, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, X86 ML <x86@kernel.org>,
        linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
        Linux-MM <linux-mm@kvack.org>, linux-m68k@lists.linux-m68k.org,
        openrisc@lists.librecores.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-snps-arc@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Jun 8, 2021 at 8:27 PM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
>
>
> Le 08/06/2021 =C3=A0 16:53, Souptick Joarder a =C3=A9crit :
> > On Tue, Jun 8, 2021 at 1:56 PM Kefeng Wang <wangkefeng.wang@huawei.com>=
 wrote:
> >>
> >> Add setup_initial_init_mm() helper to setup kernel text,
> >> data and brk.
> >>
> >> Cc: linux-snps-arc@lists.infradead.org
> >> Cc: linux-arm-kernel@lists.infradead.org
> >> Cc: linux-csky@vger.kernel.org
> >> Cc: uclinux-h8-devel@lists.sourceforge.jp
> >> Cc: linux-m68k@lists.linux-m68k.org
> >> Cc: openrisc@lists.librecores.org
> >> Cc: linuxppc-dev@lists.ozlabs.org
> >> Cc: linux-riscv@lists.infradead.org
> >> Cc: linux-sh@vger.kernel.org
> >> Cc: linux-s390@vger.kernel.org
> >> Cc: x86@kernel.org
> >> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> >> ---
> >>   include/linux/mm.h | 3 +++
> >>   mm/init-mm.c       | 9 +++++++++
> >>   2 files changed, 12 insertions(+)
> >>
> >> diff --git a/include/linux/mm.h b/include/linux/mm.h
> >> index c274f75efcf9..02aa057540b7 100644
> >> --- a/include/linux/mm.h
> >> +++ b/include/linux/mm.h
> >> @@ -244,6 +244,9 @@ int __add_to_page_cache_locked(struct page *page, =
struct address_space *mapping,
> >>
> >>   #define lru_to_page(head) (list_entry((head)->prev, struct page, lru=
))
> >>
> >> +void setup_initial_init_mm(void *start_code, void *end_code,
> >> +                          void *end_data, void *brk);
> >> +
> >
> > Gentle query -> is there any limitation to add inline functions in
> > setup_arch() functions ?
>
> Kefeng just followed comment from Mike I guess, see
> https://patchwork.ozlabs.org/project/linuxppc-dev/patch/20210604070633.32=
363-2-wangkefeng.wang@huawei.com/#2696253

Ok.
>
> Christophe
>
