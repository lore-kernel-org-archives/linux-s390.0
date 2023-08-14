Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9498FC41513
	for <linux-s390@archiver.kernel.org>; Mon, 14 Aug 2023 23:33:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233479AbjHNXci (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 14 Aug 2023 19:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233490AbjHNXcP (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 14 Aug 2023 19:32:15 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF9FD1710
        for <linux-s390@vger.kernel.org>; Mon, 14 Aug 2023 16:32:13 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6873a30d02eso3215136b3a.3
        for <linux-s390@vger.kernel.org>; Mon, 14 Aug 2023 16:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692055933; x=1692660733;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cQj/nTjuU53JsbV/ZPiiH3P0xM0mPHFJjukerGJ0WyU=;
        b=Gpxx7jFnj54y5q+IJpeuy+aEXDgo953bd9rr8xLF/FYGQcZIj6HtqKRLxzsMpzbKqh
         CQX1tdoncL9IegbC+FQSZ8JXoOC5TvLrb6BwipKvb0AOA70nZpKEm737sLVRuQOqmMjy
         gnAUye5iHmt0m7hLo2TZxkEMwsa4fpHtX5QfM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692055933; x=1692660733;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cQj/nTjuU53JsbV/ZPiiH3P0xM0mPHFJjukerGJ0WyU=;
        b=Fz81gQWeeB/UStJMMWSYDOHDMtYrmNQR0q82kdYwCPhvS17z3FfATkb+TNN60ErIfi
         I3TNg7+bzEML16EppmH2OIOgFiP1QyR69Up1VCZRYv0c3yIoKDAAM7NQQFJ33RikG4SV
         A7mObWAXXDleS9/s4a4M6IQusmh44+AW8n4d4jww0k9l8YdGOEZWbo7pTMjRU7RmBx2x
         pLSu68Qi/O1u66YtDc3DzPyF7ZIyxu3gSF8foxmMvkZIKrTRJyF93QWPfXpqFaMXPYQR
         Ly7M64VDodrFSWaBOdWxm2yVNxe3MNcEp4Pan+MFCNdDnxTKyIhodrQnq1I3zBQME9Z9
         eOQw==
X-Gm-Message-State: AOJu0YxI6FExTfcp1uStqeqcLSiv4qxNy56sc0Cmgk0CO1y4v8lAfRZf
        nWSWsLtqQfUnefPQjMPJm+XFlA==
X-Google-Smtp-Source: AGHT+IEUvmrXDs073bSxRYuoTAGVJ6TPSzfLJVK6/w5nceeJap/eQ0HBWhM04vYl0/woelmndAb2Xw==
X-Received: by 2002:a05:6a20:3d29:b0:140:6979:2952 with SMTP id y41-20020a056a203d2900b0014069792952mr11631037pzi.47.1692055933101;
        Mon, 14 Aug 2023 16:32:13 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id n24-20020aa78a58000000b0068843400dc5sm983969pfa.100.2023.08.14.16.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 16:32:12 -0700 (PDT)
Date:   Mon, 14 Aug 2023 16:32:11 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] s390/ipl: refactor deprecated strncpy
Message-ID: <202308141626.3F82919BFD@keescook>
References: <20230811-arch-s390-kernel-v1-1-7edbeeab3809@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811-arch-s390-kernel-v1-1-7edbeeab3809@google.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, Aug 11, 2023 at 09:56:15PM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
> 
> Use `strscpy_pad` which has the same behavior as `strncpy` here with the
> extra safeguard of guaranteeing NUL-termination of destination strings.
> In it's current form, this may result in silent truncation if the src
> string has the same size as the destination string.
> 
> Link: www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings[1]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
>  arch/s390/kernel/ipl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/s390/kernel/ipl.c b/arch/s390/kernel/ipl.c
> index 85a00d97a314..a6dcf6f28197 100644
> --- a/arch/s390/kernel/ipl.c
> +++ b/arch/s390/kernel/ipl.c
> @@ -266,7 +266,7 @@ static ssize_t sys_##_prefix##_##_name##_store(struct kobject *kobj,	\
>  		struct kobj_attribute *attr,				\
>  		const char *buf, size_t len)				\
>  {									\
> -	strncpy(_value, buf, sizeof(_value) - 1);			\
> +	strscpy_pad(_value, buf, sizeof(_value));			\

Padding isn't needed here -- the string are consumed by __cpcmd(), which
explicitly uses strlen() and a memcpy to pass them off.

>  	strim(_value);							\

This existing code line is buggy, though -- it will not trim leading
whitespace in the buffer. (It _returns_ a string that has been
forward-adjusted.)

I think this is an API mistake -- strim() should either do in-place
changes for both ends or be defined with __much_check so the return
value doesn't get lost. (But this is a separate issue.)

-Kees

-- 
Kees Cook
