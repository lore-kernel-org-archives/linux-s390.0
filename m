Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBC4FC71153
	for <linux-s390@archiver.kernel.org>; Mon, 28 Aug 2023 22:52:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233130AbjH1Wvf (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 28 Aug 2023 18:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232923AbjH1WvJ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 28 Aug 2023 18:51:09 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DF9F185
        for <linux-s390@vger.kernel.org>; Mon, 28 Aug 2023 15:51:06 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-564cd28d48dso1693134a12.0
        for <linux-s390@vger.kernel.org>; Mon, 28 Aug 2023 15:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693263066; x=1693867866;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T4nyTONQLjQNGWZ4CdwYM7KX6zvJ5hhuHchlfrQVnFg=;
        b=U/jGmUT4ZMYOwz1wyVXxKZzwd5Z7io9GqpQrDOrUqXUDPkOP69ywj9jTtekn/lPlKF
         +jI7KSDKs01z02xFMIaNQDOvk5Id0q5I/ftVNN9Pam8s85ySBUKRx5riBy+U9MXhbsC0
         WQl9Xc5fR7pgKuFqfaXTF8dec/+/LknMu9jbFswg8KZ80ZoydNjjssClQiClaGamRMbF
         RdTCfgvGzPbD0FGFv+8hQABCf0cN2lQY5j9zDwEzU2tsbIseHmaomEG6ujOP4bzA/UHF
         jbMWpV67UbmA2V5YyOGk0EMZEpfSOmOBFHj3ScjqfvZPeRep86fy2nszVjhHN5UKATfT
         OVHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693263066; x=1693867866;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T4nyTONQLjQNGWZ4CdwYM7KX6zvJ5hhuHchlfrQVnFg=;
        b=PkEpQ2Erfj1QFlode8WH0Z6uUD17ZnlR+lU8n3/SOnE23qh+sCY/EtoqbOASmpc2Fn
         Q3mRAYYBLCMohdPh3Nqy2g4kaTE+lwlZrYXqKPlcr36jcI3g+HzYn7/VC8jTDT9c27Vo
         bmTQfbKmozHhGv06lnI3ZOAFVp7+LqWkIAZSvzh08WSCzQcZX7dLWEPd2tIbXuzamEKL
         8zgTf8zdBGOBvpmJzXsF8qZvqgS8prNSe141arKnEfKVLvzlg5AMjlLftmNy09WC4nyo
         mKtaQijPKHzMZP9JmdRpBU+5GWOQ83w9rXgmp6DeYMLrHpFGQeTSjdw8l+rONBPeaDvu
         dJUA==
X-Gm-Message-State: AOJu0YyVmO4RyAZS4HRJcti+3fmF1xymMq2/f4gQd1MlujUfCZNaUjuM
        gntbVE5noYPfk+1eZN32FE69FA==
X-Google-Smtp-Source: AGHT+IFhgZce2iRj25QUKt5ra95exWE6EmZCshSfmAByuDSFGHPibt9BU7lzSXl6OJECuiWZ8kwf1Q==
X-Received: by 2002:a17:90a:b10f:b0:271:ab23:6288 with SMTP id z15-20020a17090ab10f00b00271ab236288mr871992pjq.14.1693263065657;
        Mon, 28 Aug 2023 15:51:05 -0700 (PDT)
Received: from google.com ([2620:15c:2d1:203:b64:7817:9989:9eba])
        by smtp.gmail.com with ESMTPSA id j15-20020a17090a2a8f00b00262ca945cecsm10108812pjd.54.2023.08.28.15.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 15:51:05 -0700 (PDT)
Date:   Mon, 28 Aug 2023 15:51:00 -0700
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     David Laight <David.Laight@aculab.com>
Cc:     'Heiko Carstens' <hca@linux.ibm.com>, Jens Axboe <axboe@kernel.dk>,
        Stefan Haberland <sth@linux.ibm.com>,
        Jan =?iso-8859-1?Q?H=F6ppner?= <hoeppner@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        llvm@lists.linux.dev
Subject: Re: [PATCH 1/1] s390/dasd: fix string length handling
Message-ID: <ZO0k1Par4i4FBCWF@google.com>
References: <20230828153142.2843753-1-hca@linux.ibm.com>
 <20230828153142.2843753-2-hca@linux.ibm.com>
 <f0419f6428ad404386ebca813dc1ec03@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0419f6428ad404386ebca813dc1ec03@AcuMS.aculab.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, Aug 28, 2023 at 05:18:37PM +0000, David Laight wrote:
> From: Heiko Carstens
> > Sent: 28 August 2023 16:32
> >  	if (strlen(uid.vduit) > 0)
> 
> Does the compiler know enough to optimise that brain-dead test?
> 

For the purposes of skipping diagnostics, no; clang performs semantic
analysis BEFORE optimization (which is handled by LLVM). As such, clang
will produce diagnostics on dead code.

Partly because LLVM isn't very ergonomic at emitting diagnostics from
the backend, partly because Clang code owner and developers don't want
clang to emit diagnostics dependent on optimization level.

I disagree with my compatriots, and you can read more thoughts here:
https://discourse.llvm.org/t/rfc-improving-clangs-middle-and-back-end-diagnostics/69261?u=nickdesaulniers
