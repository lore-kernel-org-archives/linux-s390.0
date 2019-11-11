Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-oi1-f196.google.com ([209.85.167.196]:38855 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726906AbfKKPn2 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 11 Nov 2019 10:43:28 -0500
MIME-Version: 1.0
References: <20191111151344.7401-1-geert@linux-m68k.org>
In-Reply-To: <20191111151344.7401-1-geert@linux-m68k.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 11 Nov 2019 16:36:18 +0100
Message-ID: <CAMuHMdXenPQJQn1qVL494cB89GZAcZqXMVhw4PW+ZgSqdgtAyQ@mail.gmail.com>
Subject: Re: Build regressions/improvements in v5.4-rc7
Content-Type: text/plain; charset="UTF-8"
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: linux-s390 <linux-s390@vger.kernel.org>, alpha <linux-alpha@vger.kernel.org>, MTD Maling List <linux-mtd@lists.infradead.org>, Arnd Bergmann <arnd@arndb.de>

On Mon, Nov 11, 2019 at 4:18 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> JFYI, when comparing v5.4-rc7[1] to v5.4-rc6[3], the summaries are:
>   - build errors: +0/-2
>   - build warnings: +48/-70

  + /kisskb/src/fs/ubifs/orphan.c: warning: format '%lu' expects
argument of type 'long unsigned int', but argument 4 has type 'ino_t'
[-Wformat]:  => 140:3, 132:3

s390x/s390-all{mod,yes}config

Why is ino_t unsigned int on s390x and alpha, while it's unsigned long
everywhere else?

> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/31f4f5b495a62c9a8b15b1c3581acd5efeb9af8c/ (232 out of 242 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/a99d8080aaf358d5d23581244e5da23b35e340b9/ (232 out of 242 configs)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
