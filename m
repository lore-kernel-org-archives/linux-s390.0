Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D02C07545
	for <linux-s390@archiver.kernel.org>; Tue, 24 Oct 2023 23:58:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344711AbjJXX64 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 24 Oct 2023 19:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344663AbjJXX6x (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 24 Oct 2023 19:58:53 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 184C610CE
        for <linux-s390@vger.kernel.org>; Tue, 24 Oct 2023 16:58:52 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6b26a3163acso4047563b3a.2
        for <linux-s390@vger.kernel.org>; Tue, 24 Oct 2023 16:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698191931; x=1698796731; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wXs6Pn0q7dHLwrvjv/VGOUkBCbTosuxQIWXIR0FEvR8=;
        b=BzzD391tHqE+Hh/rRCeKA7EZQdyRdcIn4BHeNGuTVkQKk08DUb5mxdxrKzkHv/a/4L
         3LaLEdnSWG93YvE2yGrPXNy9IKB/ASVMIVyop33GDMXSzbvUd7SnEx2Chn9S5KrdrRs4
         9Bqqs/WN0UVpUVupuPB0OiHqheYkFkveUT3FE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698191931; x=1698796731;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wXs6Pn0q7dHLwrvjv/VGOUkBCbTosuxQIWXIR0FEvR8=;
        b=sPMFGq0nOlorgjJAAoiCPS+UJOFGFg36LVsGNq/ftAJkfNDnK2arpKFqrPtFBtPHMm
         lo4XWWU3wJ6kjIlRFHf1yw74nAzD9jFJaZSeuy+DKiTrPqkAvBFKJ3V7pKLNX+kw6GSI
         b/8hu/qU1HoNyQHkgIqsk6vjLeyAy6oh8DtaN3IAWzv42fEs2ObOpKBlktkx6BitZ4uB
         /TAV3AANmMs2WofIT0tjFKwI32lr6TSAEQXVHs0uT5YrQ5Y9FIdsmLGLbdpkbTEWBk6h
         J9iFn/+WN0aacTufvFV2WT+RJc45Q2URORzTmGgZYSxOBx0mJezZdwWZd6EInfS2ri4U
         wdyA==
X-Gm-Message-State: AOJu0YxTQJkgP42yfKGH9fJwSSjPm9/sOXqTJc3S1gQ9j0Cv34SdMJn4
        VWX5CqFTPSUMGXk5QwvDGsEpSA==
X-Google-Smtp-Source: AGHT+IEBd9nH3qhCx7x7281KFVxT2YPG8yR28v8/pNE9HwnJxD7jTio62xVe2uyueP5+AwueOLYMoA==
X-Received: by 2002:aa7:991e:0:b0:6b8:2ef3:331d with SMTP id z30-20020aa7991e000000b006b82ef3331dmr10232303pff.10.1698191931447;
        Tue, 24 Oct 2023 16:58:51 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id f11-20020aa79d8b000000b006b4a5569694sm8099281pfq.83.2023.10.24.16.58.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 16:58:50 -0700 (PDT)
Date:   Tue, 24 Oct 2023 16:58:50 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] s390/cio: replace deprecated strncpy with strscpy
Message-ID: <202310241658.0144D73@keescook>
References: <20231023-strncpy-drivers-s390-cio-chsc-c-v1-1-8b76a7b83260@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023-strncpy-drivers-s390-cio-chsc-c-v1-1-8b76a7b83260@google.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, Oct 23, 2023 at 07:24:38PM +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> We expect both `params` and `id` to be NUL-terminated based on their
> usage with format strings:
> 
> 	format_node_data(iuparams, iunodeid, &lir->incident_node);
> 	format_node_data(auparams, aunodeid, &lir->attached_node);
> 
> 	switch (lir->iq.class) {
> 	case LIR_IQ_CLASS_DEGRADED:
> 		pr_warn("Link degraded: RS=%02x RSID=%04x IC=%02x "
> 			"IUPARAMS=%s IUNODEID=%s AUPARAMS=%s AUNODEID=%s\n",
> 			sei_area->rs, sei_area->rsid, lir->ic, iuparams,
> 			iunodeid, auparams, aunodeid);
> 
> NUL-padding is not required as both `params` and `id` have been memset
> to 0:
> 
> 	memset(params, 0, PARAMS_LEN);
> 	memset(id, 0, NODEID_LEN);
> 
> Considering the above, a suitable replacement is `strscpy` [2] due to
> the fact that it guarantees NUL-termination on the destination buffer
> without unnecessarily NUL-padding.
> 
> Note that there's no overread bugs in the current implementation as the
> string literal "n/a" has a size much smaller than PARAMS_LEN or
> NODEID_LEN. Nonetheless, let's favor strscpy().
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Looks good.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
