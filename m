Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7471C7EE24
	for <linux-s390@archiver.kernel.org>; Fri,  2 Jun 2023 19:58:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235709AbjFBT6H (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 2 Jun 2023 15:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235107AbjFBT6G (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 2 Jun 2023 15:58:06 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C8D1A2
        for <linux-s390@vger.kernel.org>; Fri,  2 Jun 2023 12:58:04 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-974f4897d87so113452966b.0
        for <linux-s390@vger.kernel.org>; Fri, 02 Jun 2023 12:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1685735883; x=1688327883;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8pqo3OfJjzReA0YZCNQePZ3Xh5QPxALpix/U4edhgSI=;
        b=GuDorUGuDY9ctM/b50tgfEibghu2+8+DrXTj0FdPwSQqIfSlgVAT8/rEl4gZM0yNe3
         /D0ESbj71UzYrSTzxIU3bLRIMl+l1JvdpZ9V17/Jgt1qbz41vaboe+lF09JT58OMyL8t
         B9iB2S+GUaQrR8c+7UhqQXAuJI8ydKjl7PK9I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685735883; x=1688327883;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8pqo3OfJjzReA0YZCNQePZ3Xh5QPxALpix/U4edhgSI=;
        b=evGfA/s/yTBbP+T4yXff5EQHQ4KZ+rB58E/3xsTRA+fKDZzmplIPwYoMv8HOKaYyk6
         qjxJDYZcIOedQxfbEzz043DxPYJBEx8B07WnVmm3kcGbqG6HSz6TrirIVdGeNmkYEbV+
         TPktSSjhL1Ig0ekJ5Xg89JHvd5xEiF3CU6SKf8OiP10DAZkpNjdEnhG16IxtP/VD9ISh
         8/RzxBYFX0BlVD/jEtCsJGoFg+oKH3laHc8V+Ng5LnpYmsBTXx68qR/J8zOnWo31oNWJ
         2Gd7WuOLSWUR5MZIkn5AYrC9CFb1J4wKKWQ/FHOJK7QmiBib9hkob1HD+PhVBeRrW+Rs
         vo+Q==
X-Gm-Message-State: AC+VfDwnGjw6/CRD8yY1Mj9horlAT/FtM1nk+aQX4SPJ7w1hLML9SXtY
        r/nT/jD1lJYibPqhetvScgAIto9Kwss97iwQbBE1Yddc
X-Google-Smtp-Source: ACHHUZ7kQLEmTZE/aOyeqU9kyLvAWDAqO9ryyUuR91q0qDm9Fl5hSimRizVTHVe/OiBJERzOmho2Bg==
X-Received: by 2002:a17:906:dac7:b0:96f:9963:81ee with SMTP id xi7-20020a170906dac700b0096f996381eemr11177549ejb.50.1685735883364;
        Fri, 02 Jun 2023 12:58:03 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id f14-20020a170906494e00b0097461fecc91sm1111184ejt.81.2023.06.02.12.58.02
        for <linux-s390@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jun 2023 12:58:02 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-51491b87565so3605938a12.1
        for <linux-s390@vger.kernel.org>; Fri, 02 Jun 2023 12:58:02 -0700 (PDT)
X-Received: by 2002:a05:6402:b10:b0:514:9b60:ea65 with SMTP id
 bm16-20020a0564020b1000b005149b60ea65mr2665357edb.16.1685735862382; Fri, 02
 Jun 2023 12:57:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230531130833.635651916@infradead.org> <20230531132323.722039569@infradead.org>
 <70a69deb-7ad4-45b2-8e13-34955594a7ce@app.fastmail.com> <20230601101409.GS4253@hirez.programming.kicks-ass.net>
 <14c50e58-fecc-e96a-ee73-39ef4e4617c7@gmx.de> <CAHk-=whL65CLuy9D9gyO608acM5WLWo_ggAMP1cGu2XvyC0-hA@mail.gmail.com>
 <20230602143912.GI620383@hirez.programming.kicks-ass.net> <E333E35E-5F9C-441C-B75A-082F19D37978@zytor.com>
 <20230602191014.GA695361@hirez.programming.kicks-ass.net> <B432FCD8-2ED7-42B1-BC3B-34F277A1CD9F@zytor.com>
 <20230602194021.GB695361@hirez.programming.kicks-ass.net>
In-Reply-To: <20230602194021.GB695361@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 2 Jun 2023 15:57:25 -0400
X-Gmail-Original-Message-ID: <CAHk-=wi4q=_+vQkOM0LRY7SfsH+D1-9DOSBABAzXrZwWxmJR+g@mail.gmail.com>
Message-ID: <CAHk-=wi4q=_+vQkOM0LRY7SfsH+D1-9DOSBABAzXrZwWxmJR+g@mail.gmail.com>
Subject: Re: [PATCH v2 07/12] parisc/percpu: Work around the lack of __SIZEOF_INT128__
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, Helge Deller <deller@gmx.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
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
        Joerg Roedel <joro@8bytes.org>, suravee.suthikulpanit@amd.com,
        Robin Murphy <robin.murphy@arm.com>,
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

On Fri, Jun 2, 2023 at 3:40=E2=80=AFPM Peter Zijlstra <peterz@infradead.org=
> wrote:
>
> "With 64bit builds depending on __SIZEOF_INT128__ to detect the
> presence of __int128 raise the parisc minimum compiler version to
> gcc-11.0.0."
>
> better?

I'd just say "64-bit targets need the __int128 type, which for pa-risc
means raising the minimum gcc version to 11".

The __SIZEOF_INT128__ part isn't the important part. That's just the sympto=
m.

               Linus
