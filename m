Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E83CFC072A2
	for <linux-s390@archiver.kernel.org>; Wed, 15 Nov 2023 15:54:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbjKOPyd (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 15 Nov 2023 10:54:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231745AbjKOPya (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 15 Nov 2023 10:54:30 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB67101;
        Wed, 15 Nov 2023 07:54:27 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-32f8441dfb5so4798388f8f.0;
        Wed, 15 Nov 2023 07:54:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700063666; x=1700668466; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mAv4yuO0oAcw2e4HAvKfHMXrrbl1fK6mnENT61XvBWY=;
        b=AIKGNKUZrHb9SQ2bIEipp9BsNkiEZCWOGm8HXoATxJ5M83eCBTHgdSPgtb/oTn+xlJ
         A/sxi64MbAgf9Skwvu+mYSkiiID4NcXFEanXZzawoJYOuGIG0N7Ah/ekQghwypVcdm0D
         DYtff8nuGaUzpgLgNEWBbrZZOvs55n1iqkJ1I4GxOFVJ3Fml7sEIH2zKeKElmP2qpcad
         lhzFvgzDDMGxjseRQqTOAPhVq0hK93pOSO+uPs4NYGmBIExkYa85JXC0tc4IHiGaoxd1
         0YTinYXg/ykUvnFKNaWR2j+1VDCy/1KOOeAEjg6mTWW5yKWYJZnqTs4RBqub4JXGz+KZ
         XP+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700063666; x=1700668466;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mAv4yuO0oAcw2e4HAvKfHMXrrbl1fK6mnENT61XvBWY=;
        b=It/22BStVCJI3gVcA29ccdagAiz9IVQ1l2YggbeZD0pJpCnqd3z6CTV8uYw024ySnH
         dzdgVPwbnReH69n9/E2UJWNOdjy5FiFx7nqcHc/R/MJhdh6mlrA+Ejx881M1mz15D2Pb
         CpGFb3cD65afb5+sbPOFyiTRGFfx9+CytG7wORWWpt3dihriDwaHGO+CDhPL4W5MvLvR
         3XGZ5Txqbsv1b8ph41kAMkByiGZmCu17iXPwV8k4a+V0oDocmTka13qgv/BtWVAZou2G
         VL7kkVVTH1zXPmAciRltIMOJyCf97hvIW3rX4JH4it6cXA81rMazRv2b17VrwfXDM6fd
         rrfQ==
X-Gm-Message-State: AOJu0YxTrBqdAprYFQn3shlr49hzcI0yM2Gw0aa6PdN67fqR0Lj0PQS1
        xjJN6Hw/U9G2v4jv+Ev5MAARgmS2SxI5FtieXZQ=
X-Google-Smtp-Source: AGHT+IGARab6HUI1V/sfRL6+E0bofbX6pKhItjE2MLcbMVX1OBGE29yLWwD0mRPq7cK2FCCSO9iaAjC9K28VvXBk4Eo=
X-Received: by 2002:a5d:64c8:0:b0:32d:8220:8991 with SMTP id
 f8-20020a5d64c8000000b0032d82208991mr10045645wri.8.1700063665559; Wed, 15 Nov
 2023 07:54:25 -0800 (PST)
MIME-Version: 1.0
References: <20230827152729.1995219-1-yonghong.song@linux.dev>
 <20230827152734.1995725-1-yonghong.song@linux.dev> <20231115153139.29313-A-hca@linux.ibm.com>
In-Reply-To: <20231115153139.29313-A-hca@linux.ibm.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 15 Nov 2023 07:54:14 -0800
Message-ID: <CAADnVQLmFp7WmzDzYEhE8PgnNpv8SrWfuCB1bz493L98dsER6Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 01/13] bpf: Add support for non-fix-size
 percpu mem allocation
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Marc Hartmayer <mhartmay@linux.ibm.com>,
        Mikhail Zaslonko <zaslonko@linux.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Nov 15, 2023 at 7:32=E2=80=AFAM Heiko Carstens <hca@linux.ibm.com> =
wrote:
>
> On Sun, Aug 27, 2023 at 08:27:34AM -0700, Yonghong Song wrote:
> > This is needed for later percpu mem allocation when the
> > allocation is done by bpf program. For such cases, a global
> > bpf_global_percpu_ma is added where a flexible allocation
> > size is needed.
> >
> > Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> > ---
> >  include/linux/bpf.h   |  4 ++--
> >  kernel/bpf/core.c     |  8 +++++---
> >  kernel/bpf/memalloc.c | 14 ++++++--------
> >  3 files changed, 13 insertions(+), 13 deletions(-)
>
> Both Marc and Mikhail reported out-of-memory conditions on s390 machines,
> and bisected it down to this upstream commit 41a5db8d8161 ("bpf: Add
> support for non-fix-size percpu mem allocation").
> This seems to eat up a lot of memory only based on the number of possible
> CPUs.
>
> If we have a machine with 8GB, 6 present CPUs and 512 possible CPUs (yes,
> this is a realistic scenario) the memory consumption directly after boot
> is:
>
> $ cat /sys/devices/system/cpu/present
> 0-5
> $ cat /sys/devices/system/cpu/possible
> 0-511
>
> Before this commit:
>
> $ cat /proc/meminfo
> MemTotal:        8141924 kB
> MemFree:         7639872 kB
>
> With this commit
>
> $ cat /proc/meminfo
> MemTotal:        8141924 kB
> MemFree:         4852248 kB
>
> So, this appears to be a significant regression.
> I'm quoting the rest of the original patch below for reference only.

Yes. Sorry about this. The issue slipped through.
It's fixed in bpf tree by commit:
https://patchwork.kernel.org/project/netdevbpf/patch/20231111013928.948838-=
1-yonghong.song@linux.dev/

The fix will be sent to Linus soon.
