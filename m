Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 677FBC54FB9
	for <linux-s390@archiver.kernel.org>; Thu, 16 Nov 2023 09:15:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbjKPJPM (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 16 Nov 2023 04:15:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235659AbjKPJPL (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 16 Nov 2023 04:15:11 -0500
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F7CD194
        for <linux-s390@vger.kernel.org>; Thu, 16 Nov 2023 01:15:07 -0800 (PST)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-5a7d9d357faso6039987b3.0
        for <linux-s390@vger.kernel.org>; Thu, 16 Nov 2023 01:15:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700126106; x=1700730906; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QsOxPTssCXfEjaJKL1FvlaQBMDAuXe1RlMdSNjLvudI=;
        b=L2w/VYcSN5vXT9bGmTpDrhhO9vGrfZFGNJojaIFwWz8De9Hg0ORb7LEWZJ5Lf7k/35
         J5kXuSfRX5Ydo0pBPDF1N8FFt1P/XOZdCXKJROrF35us7bDm/TsOfWM8PRfoXSy9IFHp
         UZqVMWIA03Ntl3+X6UodmYgxmTrhlSBmCGaZBiJU5uVYdk4b5jrydAU6GStptcbtwCUu
         WJXkKy7ynDx9IeQ7ruX41BbcwOQH/nUf7+25qWdjpZux2R2IayLj4QSnWZtPCu1cqOza
         kPJGs3lxEcMNv8t3IDM5xCyeHRn+XSWhfOY2iEA4V8OTKp9QCHAsQRz98bAeArBJmWtu
         R10Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700126106; x=1700730906;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QsOxPTssCXfEjaJKL1FvlaQBMDAuXe1RlMdSNjLvudI=;
        b=ewlQZCf2pdippLmH3z5uZEyX9MR+Rhvma1Un1Kb9C9Kc08E8aT+r8ExFZjnk2h3goe
         fPm1A+drTxMn3z2DoNenLuDQAdcfwJON+M8iXVAvxIlhr2emkbSaMXBgV9tdza+RlKo2
         xQF+uJOR2EKp1bfTWMKotIkPjEYqY1Kx9J0IU4nOpuqSk3C3n2lXNuqH45xNX9spRKwE
         HW4m5X7d2Z2ZZWadcUKpwMtErnL8g5BYORQHiSjMF5kpVR+WuZKgdS5EypArYOORV6Bn
         qGIUqfZ24YqtnNaehu9MQIdIE098ZkxgiMivr3gpDa3Iw8KeBwezP2Rfdwr8UKv0OsEE
         unsA==
X-Gm-Message-State: AOJu0Yx1WIhrDD2toK8GvrFvNa6abTuvXznyZr0fQjdLDT1nwXs4Qdeq
        cFcdnMx6sf7vd1toOf3+9gkD2ZJRdF4NNNYDg/pXIw==
X-Google-Smtp-Source: AGHT+IEvSuQ2VeLe8nxzm+KAwC3Xu4zj8WHKnveqJO0J+JPLWHM+U1ETIwvgpmkEprYTf00eQ+4e7i073zU5qxwyHM4=
X-Received: by 2002:a0d:d70d:0:b0:5be:b764:a15f with SMTP id
 z13-20020a0dd70d000000b005beb764a15fmr15877402ywd.24.1700126106526; Thu, 16
 Nov 2023 01:15:06 -0800 (PST)
MIME-Version: 1.0
References: <20231115203401.2495875-1-iii@linux.ibm.com> <20231115203401.2495875-12-iii@linux.ibm.com>
In-Reply-To: <20231115203401.2495875-12-iii@linux.ibm.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 16 Nov 2023 10:14:30 +0100
Message-ID: <CAG_fn=X6+fgYb8THhb4GyZYz_1mVxAifbBeA+bOqDCmmT6Dovg@mail.gmail.com>
Subject: Re: [PATCH 11/32] kmsan: Export panic_on_kmsan
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
> When building the kmsan test as a module, modpost fails with the
> following error message:
>
>     ERROR: modpost: "panic_on_kmsan" [mm/kmsan/kmsan_test.ko] undefined!
>
> Export panic_on_kmsan in order to improve the KMSAN usability for
> modules.
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
