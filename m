Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83386C197A0
	for <linux-s390@archiver.kernel.org>; Thu, 16 Nov 2023 09:42:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbjKPJmS (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 16 Nov 2023 04:42:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbjKPJmR (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 16 Nov 2023 04:42:17 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A1F187
        for <linux-s390@vger.kernel.org>; Thu, 16 Nov 2023 01:42:14 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-d9cbba16084so512808276.1
        for <linux-s390@vger.kernel.org>; Thu, 16 Nov 2023 01:42:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700127733; x=1700732533; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HbQBUq6zMPZ7ORs1zmLeLhmCeGDS7R7Qw733eYdaWDY=;
        b=Gx5PhsvmMsmSQy3ihT4tpPP7j6KuTZToX9EDbr4inLdKRMGz52HovUOZHRAPOP1YHi
         2ipifisV8I057MGg0156wIzWDSOMSKyNWlVNIy7H5l0WV+YA1gWwNjgJRm4lzJ0g/Zig
         e3Fq1d9RuFDN/NI5SHzRvYiyRzXfaf2MtyDOuSTIERdpWy4ZH7es6Rdn2nMqM8DDSDOS
         jm6U3umaLZ8fmfQOyK/Tb5+5tyN4NSc8miBvTTart/pYg2AeDL/o7YwlQxkxXlKEYHjf
         N2ZLOYF+gK0GMQ7IxMY6QqKEfFos2iFwPNb2o2x3+nYh7CNO9V+whWwNf+mIC34AvU2d
         rHRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700127733; x=1700732533;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HbQBUq6zMPZ7ORs1zmLeLhmCeGDS7R7Qw733eYdaWDY=;
        b=fUPJIjybPnlPZtbgQKwUqojj+iuqx6LaeWi3GiyfpEQbzsT87fbSZme08ducj4S19H
         0bxytg7K0W7gyrWI4VO2D7g8M4DDmgjpFu2Jz+jOsqvsiSipyek8f/aOWG5JI3gZD7VZ
         FY+KxbbvFOhWhT/GdaQSsZRnnIkwayqJx/ZYVYsWZtrtViyMjd8WVosjYnCDRh1pcfyv
         vkOwrDpjKDu7uxAsz7BmUWMW1010Xje2chYWRyUzHW4fn9nsxG6wE8InxCsD0WaeZ/6Q
         iY37a5tZDY5rDdLljPXNNkXusyP4piML+FKAdLVfzLJFoBKQjA1C6+kOU8i3N0klae4P
         8rRA==
X-Gm-Message-State: AOJu0YxW3ncjbVBGfs+3gmQTPYgSqCGoIu2TbqrvKJTqkPn9MFaLN6M0
        3X1vAa1tGdEEHnrFZLa3WGYKE3padfPR20Md0iBp8A==
X-Google-Smtp-Source: AGHT+IFonAyLHLBLw3FFUBVfouzs0zLwD6TTo4Qrxnr7Ueo57CVLxGNAvxlYkAgnfWpgWjxTtGnDhXKHUgixd6B4yVA=
X-Received: by 2002:a25:c70e:0:b0:da0:411b:ef19 with SMTP id
 w14-20020a25c70e000000b00da0411bef19mr14634881ybe.1.1700127733310; Thu, 16
 Nov 2023 01:42:13 -0800 (PST)
MIME-Version: 1.0
References: <20231115203401.2495875-1-iii@linux.ibm.com> <20231115203401.2495875-4-iii@linux.ibm.com>
In-Reply-To: <20231115203401.2495875-4-iii@linux.ibm.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 16 Nov 2023 10:41:33 +0100
Message-ID: <CAG_fn=Vw-kR4QM8jwJYQjv8ma+mh8uyGyP2SP7PhoMvn7UqYwQ@mail.gmail.com>
Subject: Re: [PATCH 03/32] kmsan: Disable KMSAN when DEFERRED_STRUCT_PAGE_INIT
 is enabled
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
> KMSAN relies on memblock returning all available pages to it
> (see kmsan_memblock_free_pages()). It partitions these pages into 3
> categories: pages available to the buddy allocator, shadow pages and
> origin pages. This partitioning is static.
>
> If new pages appear after kmsan_init_runtime(), it is considered
> an error. DEFERRED_STRUCT_PAGE_INIT causes this, so mark it as
> incompatible with KMSAN.

In the future we could probably collect the deferred pages as well,
but it's okay to disable KMSAN for now.

> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
