Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 181B8C433EF
	for <linux-s390@archiver.kernel.org>; Thu,  5 May 2022 20:31:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385096AbiEEUe6 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 5 May 2022 16:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381993AbiEEUe5 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 5 May 2022 16:34:57 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95E2E5EDF9
        for <linux-s390@vger.kernel.org>; Thu,  5 May 2022 13:31:16 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id t25so9325840lfg.7
        for <linux-s390@vger.kernel.org>; Thu, 05 May 2022 13:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KzJXnZ7chU1+5zJp4Dgvp3VaPPi5u4rVhagYP/eqQQE=;
        b=GcsLNO3ybt8b4qYioRwjRsGo24/f0OAD/JE388Gc5emmRyTIhlyYUbKzIgZyv53hb1
         xhiVCmKW0WOkPCvBf1e4g28vMmUQUkmrVh+o51YOtKO8cBVzloYHCXntPyZO/l8A9u4M
         5CxbT9nvJ8k+TaFHNOPLcGCSi7HogLmrn63TqdbSnLG4WHsAsFmI3EppXVPekhAxB05a
         NEbtgx7QVCxIiRy2eSQmkdwO62yYlPePGIiYe39mbWzh5zAEXFGIG2orgZSXN6r69srE
         z8JRd8pqir9+V0J5tZrITxsJOR+WTOS0fPBTlN8HA0KMIdLI2QtAq3P5nFh0k988K2Jw
         qG+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KzJXnZ7chU1+5zJp4Dgvp3VaPPi5u4rVhagYP/eqQQE=;
        b=SXFhEIflavS17bs8G0h0zcxSpOt8g5IwN0VORP8qQL2QYY826YSB8R7HF8t8vC128B
         9qAFPI2TOsl49uXEwxspR3RMRMHtVpyHU0Z0jkBcd4yFdoIu+7sTT3a7AUsPydbCf9Lh
         3MEQakCRuoACj/+8aSpePtK9ebG1Kz40Dhb6G/rL28pSH4MZXsGer0UFV9LclS9eCfJh
         Hkz5q8YeWvoGVhp0wwTuJ3Dp4bnXS2MmUvMwtLcFsftC066ml+vB/qQfOuqRz/q9hvoo
         kvBenfXjbmL/vbY4jsUMeIGsC5PIX5wxHTRTjLuErlMMpobltQfnSziROLWCqmc12HXv
         OjjQ==
X-Gm-Message-State: AOAM530Q4EzeGmaqousjFTs6yErlvEncuWdl7GOo/Xaql5nQkJiV+yMw
        wQ6MAQQZMD8ATZydm5vL2RJ1zgB6jl0T78J8p7tEkw==
X-Google-Smtp-Source: ABdhPJwbhs3kr3NEQrD1kb2FM5lFdKjT3Fw4s9E6Bf+BV+NG8NhQY5rDLxGeb5Ices7vG2JpejLiHgrpcihMdzG04I8=
X-Received: by 2002:ac2:5e86:0:b0:473:d044:60f5 with SMTP id
 b6-20020ac25e86000000b00473d04460f5mr49308lfq.87.1651782674718; Thu, 05 May
 2022 13:31:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220505072244.1155033-1-masahiroy@kernel.org> <20220505072244.1155033-15-masahiroy@kernel.org>
In-Reply-To: <20220505072244.1155033-15-masahiroy@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 5 May 2022 13:31:03 -0700
Message-ID: <CAKwvOdkTOv1VZti3KH9zxXT1xceogUPxdCV1JqoYbTKtdUy0qw@mail.gmail.com>
Subject: Re: [PATCH v3 14/15] kbuild: make built-in.a rule robust against too
 long argument error
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, clang-built-linux@googlegroups.com,
        linux-kernel@vger.kernel.org, Nicolas Schier a <nicolas@fjasle.eu>,
        Ard Biesheuvel <ardb@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linuxppc-dev@lists.ozlabs.org, linux-um@lists.infradead.org,
        linux-s390@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, May 5, 2022 at 12:25 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> Kbuild runs at the top of objtree instead of changing the working
> directory to subdirectories. I think this design is nice overall but
> some commands have a scapability issue.

s/scapability/scalability/


-- 
Thanks,
~Nick Desaulniers
