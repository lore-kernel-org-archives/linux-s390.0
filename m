Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A5E1C47071
	for <linux-s390@archiver.kernel.org>; Thu, 16 Nov 2023 09:28:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbjKPJ2L (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 16 Nov 2023 04:28:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbjKPJ2L (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 16 Nov 2023 04:28:11 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47CAF1AE
        for <linux-s390@vger.kernel.org>; Thu, 16 Nov 2023 01:28:07 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-daead9cde1eso547599276.2
        for <linux-s390@vger.kernel.org>; Thu, 16 Nov 2023 01:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700126886; x=1700731686; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KHxIHoAh95uWA47oz0tiRhia9t+geZSbB1hJPltpI8c=;
        b=ch3RRNhBLIKaqi8d4YxOUKmkZ5zxpFPePDX6KtMB5Hz0S9SolhGqomXBh+NXOJIvP9
         SbILxIzy8dFpSwoyUoKFIp8kDKYa4+jQPaROI1TBiDAoshOKO+LY3jyH80tfAiAcV/j/
         y8OfkdexkgqUveusw1ZX1T9ohkszUG/BYyJQWoR+TSVg2WridYWJgg73k1b5RDmA5wb9
         8+P8FRzLXyB9Ota6cbAixFRzov5CiqXhLDb2t4mpcPwKu4rFQjCKPy+JlaSHPt8nx1+n
         jewPnjr2AEsKN+MxlY9QALFZQL0BGs9Y5tCeJs4F6yNo3jevA9+Q0Ennszh87utFrkBl
         EOiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700126886; x=1700731686;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KHxIHoAh95uWA47oz0tiRhia9t+geZSbB1hJPltpI8c=;
        b=Xo4vmNmY/FDGhhca7Z8I8U6/I0+hj8vkLnrs88yBKoRp2beyYsl3i5hTr2c+nuqxy5
         /BF77LTP1/MdbXZliMku/8NmkY6L7o8BVKsAZ65TMsRRInzn0BPrphPhxWAntk/gss9k
         iSv9h36CqHYg2wkC8FJFhiQpEZeIhtas5CVUEq6/QUHvwbdgQsXxuMKtOWzG7dJWttaT
         WblWbdDyK5eOe1lD82VTiTxOT2F/ix9J90Cyf0ZYBb0Jl9jlrlMDWG8iphCJOE4Yj5kt
         iGnyIfQd3XKdmZLpgHlMq2GTiHK3PWRUDYK4N2MWHevw67YwRI07inrfYkeVW8Nc6Of/
         gYHg==
X-Gm-Message-State: AOJu0YybrW4BctwJz7waO5KAtURMr496E/Wr8it7UVOlAGcsEt6hswbQ
        tegfupW13QMGvMEIsNxzkKRLr5O27v6PfeNURg+MjA==
X-Google-Smtp-Source: AGHT+IGR97YS05lsiSAJeEb41aiAbQ6qZIt7JBWSuXrTHq8koWoVZZ9M66uBhv2IyyKsBQgWAzIxwe5MzNYvs6e6U84=
X-Received: by 2002:a25:2487:0:b0:d9c:cc27:cc4a with SMTP id
 k129-20020a252487000000b00d9ccc27cc4amr11964662ybk.32.1700126886326; Thu, 16
 Nov 2023 01:28:06 -0800 (PST)
MIME-Version: 1.0
References: <20231115203401.2495875-1-iii@linux.ibm.com> <20231115203401.2495875-3-iii@linux.ibm.com>
In-Reply-To: <20231115203401.2495875-3-iii@linux.ibm.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 16 Nov 2023 10:27:26 +0100
Message-ID: <CAG_fn=WYywAHC_KfZjk2Wqv6RmZQe1wiAAryN4BC6QZBA3FJDw@mail.gmail.com>
Subject: Re: [PATCH 02/32] kmsan: Make the tests compatible with kmsan.panic=1
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
        Sven Schnelle <svens@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Nov 15, 2023 at 9:34=E2=80=AFPM Ilya Leoshkevich <iii@linux.ibm.com=
> wrote:
>
> It's useful to have both tests and kmsan.panic=3D1 during development,
> but right now the warnings, that the tests cause, lead to kernel
> panics.
>
> Temporarily set kmsan.panic=3D0 for the duration of the KMSAN testing.

Nice!

> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
