Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9DE7ECAAD5
	for <linux-s390@archiver.kernel.org>; Mon,  5 Sep 2022 07:46:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236337AbiIEHqH (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 5 Sep 2022 03:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235874AbiIEHqG (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 5 Sep 2022 03:46:06 -0400
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C173E33A11
        for <linux-s390@vger.kernel.org>; Mon,  5 Sep 2022 00:46:03 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed50:8960:eb4c:1eb8:b03d])
        by andre.telenet-ops.be with bizsmtp
        id G7m12800c4gmfJk017m1gw; Mon, 05 Sep 2022 09:46:02 +0200
Received: from geert (helo=localhost)
        by ramsan.of.borg with local-esmtp (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1oV6nx-0042ve-J4; Mon, 05 Sep 2022 09:46:01 +0200
Date:   Mon, 5 Sep 2022 09:46:01 +0200 (CEST)
From:   Geert Uytterhoeven <geert@linux-m68k.org>
X-X-Sender: geert@ramsan.of.borg
To:     linux-kernel@vger.kernel.org
cc:     linux-sh@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        linux-s390@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: Build regressions/improvements in v6.0-rc4
In-Reply-To: <20220905071915.2312316-1-geert@linux-m68k.org>
Message-ID: <alpine.DEB.2.22.394.2209050944290.964530@ramsan.of.borg>
References: <CAHk-=wiqix9N5P0BXrSSOXjPZxMh=wDDRJ3sgf=hutoTUx0nZQ@mail.gmail.com> <20220905071915.2312316-1-geert@linux-m68k.org>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, 5 Sep 2022, Geert Uytterhoeven wrote:
> JFYI, when comparing v6.0-rc4[1] to v6.0-rc3[3], the summaries are:
>  - build errors: +3/-16

   + /kisskb/src/arch/sh/kernel/machvec.c: error: array subscript 'struct sh_machine_vector[0]' is partly outside array bounds of 'long int[1]' [-Werror=array-bounds]:  => 105:33

sh4-gcc11/sh-allyesconfig (-Werror)

   + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_32.c: error: the frame size of 2144 bytes is larger than 2048 bytes [-Werror=frame-larger-than=]:  => 3768:1

x86_64-gcc8/x86-allmodconfig (in function dml32_ModeSupportAndSystemConfigurationFull())

   + /kisskb/src/include/linux/fortify-string.h: error: call to '__write_overflow_field' declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror=attribute-warning]:  => 258:25

s390x-gcc11/s390-allyesconfig (inlined from 'copy_process' at /kisskb/src/kernel/fork.c:2200:2)

> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/7e18e42e4b280c85b76967a9106a13ca61c16179/ (all 135 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/b90cb1053190353cc30f0fef0ef1f378ccc063c5/ (all 135 configs)

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds
