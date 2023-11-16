Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6C09C47071
	for <linux-s390@archiver.kernel.org>; Thu, 16 Nov 2023 09:45:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235663AbjKPJp1 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 16 Nov 2023 04:45:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbjKPJp1 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 16 Nov 2023 04:45:27 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77F61196
        for <linux-s390@vger.kernel.org>; Thu, 16 Nov 2023 01:45:23 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-66d13ac2796so3038416d6.2
        for <linux-s390@vger.kernel.org>; Thu, 16 Nov 2023 01:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700127922; x=1700732722; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kuV5LSK+LTxWeRbqVFyqwK6y6J/MVZo38WZUFkMurd4=;
        b=ie7q4YNNpOmZWVVFQ4eh3GLCWwkUKfB8/4+ZVt+6UczviZrpiElYcAc86/h4dmzgl4
         4fFjDwB4iNAmEW8MfPJHlX5V7kQWQyPLS+pmd0vYSkXUIrTtxaVIOUO/oEPQbYTx31va
         8qTqcXetDJNg/rWBsjGku2+rW8cbZCeaLdxMwySx58y5k80Nbltu7jcClKt/qmUfensN
         L5XWH4KTJ9pJ4KjnHL1nkgjOQlh635gi6neceX/GNyaYCA2Lz32NjDGZYR0KVYmbR/pZ
         tx+fkh4enMIRp2lfoHjOYlKaEHOH3DuoW4B70kuqMNroWZUJnEdDd95UBp4xmR7trMsZ
         wcgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700127922; x=1700732722;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kuV5LSK+LTxWeRbqVFyqwK6y6J/MVZo38WZUFkMurd4=;
        b=Y6r0XRZGPuwgKLkOIcreQQewICN2/hgfX91usOMVUH5rHDnHlzXHm/6BEYG9HI4bFQ
         9t67yywrY/S/Xae4IX6uE9rPDgXrr39u24R2pMzs+yIIEFUXA65wcVZi7G5hBTGhVbXb
         7DooV/tUSATqj7BEpZp4WM8EgMRPIP8XAbqSH6CdVglK2x9zop5gWU6mQqujdMCqUewx
         BFp69gFugQPXxIKeo/4kUbHBsrD7WFoLAl3cKFLYgjuSRO05lpbsN0o3uZOK6VM9Wn1I
         r4t2MHxyFjsa6dNaEpWb5rsg/BbF7ThVpIvmq6b86GQj2YbK5OuP29JR/RiULf/Szebw
         HXQQ==
X-Gm-Message-State: AOJu0Yxuxim5Qk6YAuFYTix5zw8vDud/rCAmocpsnGn4tRgFjmB92Nox
        W3NJs9ThoTlJLGSZw/pSlARjv0vM0K9NoTXjrHITXQ==
X-Google-Smtp-Source: AGHT+IEZe2pBqGaIQDwerQVIP7hrHF/NMnZNmo8au4Dfrdlz3uGifZ2pJ0NnPGfwguQfG35pdHrd/w8j19ygDJMsLmM=
X-Received: by 2002:ad4:4d11:0:b0:672:ab2:d9d9 with SMTP id
 l17-20020ad44d11000000b006720ab2d9d9mr8242754qvl.29.1700127922512; Thu, 16
 Nov 2023 01:45:22 -0800 (PST)
MIME-Version: 1.0
References: <20231115203401.2495875-1-iii@linux.ibm.com> <20231115203401.2495875-9-iii@linux.ibm.com>
In-Reply-To: <20231115203401.2495875-9-iii@linux.ibm.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 16 Nov 2023 10:44:46 +0100
Message-ID: <CAG_fn=U8r0cZ2ZG5dr-Um9Un=S_go7-PixFXJ-PkXCMyL7VY5g@mail.gmail.com>
Subject: Re: [PATCH 08/32] kmsan: Remove an x86-specific #include from kmsan.h
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexander Gordeev <agordeev@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Marco Elver <elver@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Pekka Enberg <penberg@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-s390@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Sven Schnelle <svens@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Nov 15, 2023 at 9:34=E2=80=AFPM Ilya Leoshkevich <iii@linux.ibm.com=
> wrote:
>
> Replace the x86-specific asm/pgtable_64_types.h #include with the
> linux/pgtable.h one, which all architectures have.
>
> Fixes: f80be4571b19 ("kmsan: add KMSAN runtime core")
> Suggested-by: Heiko Carstens <hca@linux.ibm.com>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
(see the comment below)

>
> -#include <asm/pgtable_64_types.h>
> +#include <linux/pgtable.h>

For the sake of consistency with other KMSAN code, please keep the
headers sorted alphabetically.
