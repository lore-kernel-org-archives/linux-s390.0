Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CDBFCDB474
	for <linux-s390@archiver.kernel.org>; Fri, 20 Oct 2023 07:41:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376438AbjJTHly (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 20 Oct 2023 03:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376422AbjJTHlx (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 20 Oct 2023 03:41:53 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22EF4D7
        for <linux-s390@vger.kernel.org>; Fri, 20 Oct 2023 00:41:51 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-66d36b2a247so3325496d6.1
        for <linux-s390@vger.kernel.org>; Fri, 20 Oct 2023 00:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697787710; x=1698392510; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lBa0xa/eHNcCLSN4jU5w9L+UgbLX0/qpCkz9jorDITs=;
        b=AvAcrGW5aY1lChxIAg/NbMHQ3hA8v4cgab7mfBDL4APx+gjN6uvUBsgeNoU/Bvh2Y6
         nf0fIgpZF0y6jfzKhI1uhyGuzmG148xrvklISNAYk6zwEWveZqKz4oFvDMPRidT7IZdw
         nhckKrrAWYxW9G+zgFFX6JCI3/Hvrf6YK8n710rdNHmDYh4APf7KOUOEi6GSGam+RInA
         yocUWPBUf7p+M7kzj/BP07qylEu60z2U9vlSgW1AxkANHQM3AuOZOcLnhQCyC7Q+WGUn
         eHVdE0zPK51YZvVVHJPZxeQV+SXVORm4TLLXBZbtJPCKevpfdt/6wRpjmVHVzzDTndlm
         +QVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697787710; x=1698392510;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lBa0xa/eHNcCLSN4jU5w9L+UgbLX0/qpCkz9jorDITs=;
        b=QwG50bdlZamsGvf2MtHWsQrkZ7AMR11btACZhluPHaLO7qbTcnKDWUXZvaaJFl8+7Z
         tiBO6/xKBJOm52+vwfErQVKdDIOu0xTTJFOyGzt0fHZ8CAVsWfHOsAiZNx61xAmucUlu
         qgQzosr2v2zqCi2sXlhkIm/oFR4M1G1O6bGlxDEpFu3AjL0fBwayHj8Whm3e+gyFsLxD
         Oj3DucMb61j4n5qk7J6rfRiNkycPHB6EAhGgd9W2Vn/FLSLsqqwvkbV7Nf+GtXvrEeQO
         Orj1z8OoAecGWHY92tHulO0y4d0/YATdFVrNzevOpIqK5r6q35ACpit9vKkdRkwjNUvz
         mxbQ==
X-Gm-Message-State: AOJu0YzZtgwojUiCoz20vfZBhmryjYWqzCkhFphLdc6I9Gi7CT6nTfaG
        JDhNRx+3PqSiTbsvExVEftyeoWCot/Po1WjWiicDiQ==
X-Google-Smtp-Source: AGHT+IF4DP8EnmUuEgxb0AWEosQEB3fTMTya1XnxFLtaGR6STLfbHmgJkB9SCGKsieIg9mX9CbrMN19r3UImMJv5EAs=
X-Received: by 2002:ad4:596a:0:b0:66d:1230:9682 with SMTP id
 eq10-20020ad4596a000000b0066d12309682mr1436777qvb.62.1697787710110; Fri, 20
 Oct 2023 00:41:50 -0700 (PDT)
MIME-Version: 1.0
References: <20231016165247.14212-1-aleksander.lobakin@intel.com>
 <20231016165247.14212-12-aleksander.lobakin@intel.com> <20231018172747.305c65bd@kernel.org>
In-Reply-To: <20231018172747.305c65bd@kernel.org>
From:   Alexander Potapenko <glider@google.com>
Date:   Fri, 20 Oct 2023 09:41:10 +0200
Message-ID: <CAG_fn=XP819PnkoR0G6_anRNq0t_r=drCFx4PT2VgRnrBaUjdA@mail.gmail.com>
Subject: Re: [PATCH v2 11/13] ip_tunnel: convert __be16 tunnel flags to bitmaps
To:     Jakub Kicinski <kuba@kernel.org>,
        Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Alexander Lobakin <aleksander.lobakin@intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Eric Dumazet <edumazet@google.com>,
        David Ahern <dsahern@kernel.org>,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        Simon Horman <simon.horman@corigine.com>,
        netdev@vger.kernel.org, linux-btrfs@vger.kernel.org,
        dm-devel@redhat.com, ntfs3@lists.linux.dev,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, Oct 19, 2023 at 2:27=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Mon, 16 Oct 2023 18:52:45 +0200 Alexander Lobakin wrote:
> >  40 files changed, 715 insertions(+), 415 deletions(-)
>
> This already has at least two conflicts with networking if I'm looking
> right. Please let the pre-req's go in via Yury's tree and then send
> this for net-next in the next release cycle.

Yury, Andy,

The MTE part of my series will need to be reworked, so it might take a whil=
e.
Shall I maybe send v8 of
https://lore.kernel.org/lkml/20231011172836.2579017-1-glider@google.com/
(plus the test) separately to unblock Alexander?

--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
