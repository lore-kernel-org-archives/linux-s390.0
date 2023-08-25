Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81A1AEE49AB
	for <linux-s390@archiver.kernel.org>; Fri, 25 Aug 2023 18:22:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbjHYSVi (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 25 Aug 2023 14:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231354AbjHYSVR (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 25 Aug 2023 14:21:17 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6472F2694
        for <linux-s390@vger.kernel.org>; Fri, 25 Aug 2023 11:21:12 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1c0c6d4d650so10638515ad.0
        for <linux-s390@vger.kernel.org>; Fri, 25 Aug 2023 11:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692987672; x=1693592472;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cd1paIDws1ExLMgJh/WiTiPNEsGUGwcEQ17xiLulNdo=;
        b=nhk5Ko+OG/2Q2+PvkEDtXdRrk3or+134Updyqdlu1P6XQCscy7egtl8AziCQjtc+Bn
         zp65RvpL7MR7vfIQJtiyZ3WEwZ2/AOZJxGZQ4mDRGInpxpoBv+UhEk0r9hCNWL5bYNqC
         5O0xNrQMLaQBipxQ7a78YEG4PHOgm1S3/j8H4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692987672; x=1693592472;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cd1paIDws1ExLMgJh/WiTiPNEsGUGwcEQ17xiLulNdo=;
        b=FpMOmz/exhRU9pNySPW3U/SMjhDTBh9BAtrL6csQrJK+Taicvdz6nXeXMpFVE0GnCG
         m06S8H1zuJL6OMUCJ/VCMfcLgvs/ZzYchUbONJjcosStVJWh66DXxl4Kb+e8V81wpznR
         Km6YJ2mWc3gYvmVLsZQeLdS9+paZv3d8MdCiA9jxqtbvU8/Tyl0fHVJh5iNbO4OiY6t2
         ko6R8ogArc+LZLtIRjzaOJY+89NEyMZsyr4ZxyG/o16ycpc74hc+R9EVQcH8Lbre6olk
         DKqOoJPBGKYteyOos/WPbq/hCRnzwbDLu3k8Fob4ba7EiS7YAiAOao68e1lTrzmgfLjB
         ZGyg==
X-Gm-Message-State: AOJu0Yzcro+136Ds6AedZrok/kVKx7YiTmZ56iZ9CCDAYlyGXYjiDSTV
        ywpU/Dyo2lvjxB10ThSQNcWIFrV56i8IRXplVM8=
X-Google-Smtp-Source: AGHT+IHIDQ9FIJyjliN/xDw65w9ny7WQFMwwk363Mwv+Ejm+xJkfXuvIT+Ox7t86mTNHW1gFw7K36Q==
X-Received: by 2002:a17:902:ec87:b0:1bb:9f07:5e0 with SMTP id x7-20020a170902ec8700b001bb9f0705e0mr21488860plg.60.1692987671857;
        Fri, 25 Aug 2023 11:21:11 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 6-20020a170902c10600b001bbb598b8bbsm2056354pli.41.2023.08.25.11.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 11:21:11 -0700 (PDT)
Date:   Fri, 25 Aug 2023 11:21:10 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] kbuild: Show Kconfig fragments in "help"
Message-ID: <202308251120.159800A@keescook>
References: <20230824223606.never.762-kees@kernel.org>
 <42174d5e-59f0-4612-d7a1-11e830d0a044@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <42174d5e-59f0-4612-d7a1-11e830d0a044@csgroup.eu>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, Aug 25, 2023 at 04:56:54AM +0000, Christophe Leroy wrote:
> Le 25/08/2023 à 00:36, Kees Cook a écrit :
> > +# Base hardware support for 86xx
> 
> s/86xx/85xx
> [...]

Thanks for the typo fixes! I'll get these all fixed up. :)

-- 
Kees Cook
