Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6EC4C77B7E
	for <linux-s390@archiver.kernel.org>; Thu,  1 Jun 2023 13:35:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjFANfV (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 1 Jun 2023 09:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233330AbjFANfS (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 1 Jun 2023 09:35:18 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E718C13E
        for <linux-s390@vger.kernel.org>; Thu,  1 Jun 2023 06:35:15 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-96f50e26b8bso122975966b.2
        for <linux-s390@vger.kernel.org>; Thu, 01 Jun 2023 06:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1685626514; x=1688218514;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M0MHDOHZ+ksADoGSH1YMQnsp1jrJ4XOCHJuXFHrOLiU=;
        b=O/PXGn4IbX7zlX+OA/ZuADBSgNiqDVlZASh1iP6ny1zc9ezfBU29y3fSDYBHBmpfnO
         mHGES1OhBWq6AcXO7npw2nb2OaZ6bd1WjP3auy6fWL5q+7oftNPzgghwMYTY9wencWtq
         sQ+/tdJ64e9imgzF0Tu4hpFXDsZzZBGBpxQ0g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685626514; x=1688218514;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M0MHDOHZ+ksADoGSH1YMQnsp1jrJ4XOCHJuXFHrOLiU=;
        b=L+4XWT+AtQJqc5reJ+lIoze9YaZu4M/QA3BlbrXwpp4GmGk+qLig06sRB5uPd0C291
         z9hPPEpl9LTgUBV7MFMrKACOvGTq7i97AjF4ZYzxkkMHZUDV3oc3fxvsTLwvE1rBPxEy
         6lwfTUbEbNyxIKuMSYB95TQNjZCAinQoM9cqzspdZREfNLNDTJuR3TqE4MT2BvPD6FSX
         SqZQiuCMQsVcpwYMJAagqyVTpw1jClGzc9G4jEA9WdduIo81hGOUybWBW6GnJUBB984g
         XxDR9rin3UysTVcY2WVf4LPrrUYUYquK4QXrAqY+VC1v9N2I7oKrCLQTYOl6w3AuYqhT
         co0w==
X-Gm-Message-State: AC+VfDwpeyV/Rc7AQL3fj5B42EspMBd1dC1/cxTJ4546r3mnckod+6+i
        Nqv/OTJdWE4jmZYtJdMfueu2bTnsKVoC8j+SeosPHO6J
X-Google-Smtp-Source: ACHHUZ5od8/m2hW/RuMDKJ5bcmxCTTNtpim4JTCCMQLS0bdopmTvAeS91KHRluMqTsHiuy8bF0dBGw==
X-Received: by 2002:a17:907:3e26:b0:969:bac4:8e22 with SMTP id hp38-20020a1709073e2600b00969bac48e22mr8137519ejc.26.1685626514301;
        Thu, 01 Jun 2023 06:35:14 -0700 (PDT)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com. [209.85.221.48])
        by smtp.gmail.com with ESMTPSA id si16-20020a170906ced000b0094f1b8901e1sm10523562ejb.68.2023.06.01.06.35.13
        for <linux-s390@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 06:35:14 -0700 (PDT)
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-307d58b3efbso807342f8f.0
        for <linux-s390@vger.kernel.org>; Thu, 01 Jun 2023 06:35:13 -0700 (PDT)
X-Received: by 2002:a17:907:2cc6:b0:973:fe5d:ef71 with SMTP id
 hg6-20020a1709072cc600b00973fe5def71mr4787778ejc.14.1685626175454; Thu, 01
 Jun 2023 06:29:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230531130833.635651916@infradead.org> <20230531132323.722039569@infradead.org>
 <70a69deb-7ad4-45b2-8e13-34955594a7ce@app.fastmail.com> <20230601101409.GS4253@hirez.programming.kicks-ass.net>
 <14c50e58-fecc-e96a-ee73-39ef4e4617c7@gmx.de>
In-Reply-To: <14c50e58-fecc-e96a-ee73-39ef4e4617c7@gmx.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 1 Jun 2023 09:29:18 -0400
X-Gmail-Original-Message-ID: <CAHk-=whL65CLuy9D9gyO608acM5WLWo_ggAMP1cGu2XvyC0-hA@mail.gmail.com>
Message-ID: <CAHk-=whL65CLuy9D9gyO608acM5WLWo_ggAMP1cGu2XvyC0-hA@mail.gmail.com>
Subject: Re: [PATCH v2 07/12] parisc/percpu: Work around the lack of __SIZEOF_INT128__
To:     Helge Deller <deller@gmx.de>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>, dennis@kernel.org,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Heiko Carstens <hca@linux.ibm.com>, gor@linux.ibm.com,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        borntraeger@linux.ibm.com, Sven Schnelle <svens@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Joerg Roedel <joro@8bytes.org>,
        suravee.suthikulpanit@amd.com, Robin Murphy <robin.murphy@arm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Baolu Lu <baolu.lu@linux.intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-s390@vger.kernel.org, iommu@lists.linux.dev,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-crypto@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
        linux-parisc@vger.kernel.org,
        John David Anglin <dave.anglin@bell.net>,
        Sam James <sam@gentoo.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, Jun 1, 2023 at 6:32=E2=80=AFAM Helge Deller <deller@gmx.de> wrote:
>
> I don't think we need to care about gcc-10 on parisc.
> Debian and Gentoo are the only supported distributions, while Debian
> requires gcc-12 to build > 6.x kernels, and I assume Gentoo uses at least
> gcc-12 as well.
>
> So raising the gcc limit for parisc only (at least temporarily for now)
> should be fine and your workaround below wouldn't be necessary, right?

This absolutely sounds like the right option. Let's simplify the
problem space by just saying that parisc needs the newer compiler.

Right now we have that "minimum gcc version" in a somewhat annoying
place: it's in the ./scripts/min-tool-version.sh file as a shell
script.

I wonder if we could move the gcc minimum version check into the
Kconfig file instead, and make it easier to let architectures override
the minimum version.

I don't quite know how to do that sanely, though. I don't think we
have a sane way to error out at Kconfig time (except by forcing some
syntax error inside an 'if' statement or something horrendously hacky
like that).

Added Masahiro to the (already overlong) participants list.

                   Linus
