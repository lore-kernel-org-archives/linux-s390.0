Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36011 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726940AbfFDIBK (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 4 Jun 2019 04:01:10 -0400
MIME-Version: 1.0
References: <1559635137-20900-1-git-send-email-krzk@kernel.org>
In-Reply-To: <1559635137-20900-1-git-send-email-krzk@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 4 Jun 2019 10:00:55 +0200
Message-ID: <CAMuHMdX04Y2n8v641bv5P+P0oeRfO7arOft_6dk6w0wQF1yzew@mail.gmail.com>
Subject: Re: [PATCH] s390: configs: Remove useless UEVENT_HELPER_PATH
Content-Type: text/plain; charset="UTF-8"
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>

On Tue, Jun 4, 2019 at 9:59 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> Remove the CONFIG_UEVENT_HELPER_PATH because:
> 1. It is disabled since commit 1be01d4a5714 ("driver: base: Disable
>    CONFIG_UEVENT_HELPER by default") as its dependency (UEVENT_HELPER) was
>    made default to 'n',
> 2. It is not recommended (help message: "This should not be used today
>    [...] creates a high system load") and was kept only for ancient
>    userland,
> 3. Certain userland specifically requests it to be disabled (systemd
>    README: "Legacy hotplug slows down the system and confuses udev").
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
