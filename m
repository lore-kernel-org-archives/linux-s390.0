Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB439C433C1
	for <linux-s390@archiver.kernel.org>; Thu, 25 Mar 2021 17:56:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EF7161A2D
	for <linux-s390@archiver.kernel.org>; Thu, 25 Mar 2021 17:56:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbhCYRzx (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 25 Mar 2021 13:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbhCYRzn (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 25 Mar 2021 13:55:43 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98DEEC06174A;
        Thu, 25 Mar 2021 10:55:43 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616694942;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oNbiGGnvlAl57iwhF/VDCo8GHxOkRS0/W0QutwgSyhI=;
        b=mTxi4UL05VaerFfKcKou9M8yGT3e8D1hO3la7xMZinEAIXOZiiDi62KrX/eSNcrdSmyJgy
        Q3F2bLMixneoEgJ79SdSN2K3qaK/SUfT/wzH8FKyrbDkMRW7U9lrvWLR2Ufwb/g+OmyaZz
        AckXK3Eq0O08sAnRRXkCMWV8BYzrAAbupXIby3lD5Gzc8hX5LKIJez0LrwhflJIt8dQUnO
        Gwi+FWeVsuM3b0o69fDBFhxcK3ZrTPGKPRZQypUE3x9Fozr5wYlCPbwL3WtCkUBVkSPZyN
        Ldu2kTt9YqvLovBXyPafCn15CQRdhP3VA8A9e0ejzE0J4+Cvg/uKpiZxI8W0/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616694942;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oNbiGGnvlAl57iwhF/VDCo8GHxOkRS0/W0QutwgSyhI=;
        b=ymd2Br2CLWxwB3KSPpw3BK9FkQ9t5owK+Fmj6H9OpK3RRnBeWbujZ1yjedLJ+9DBvkQwRB
        wtqzQjCk0LySiDCA==
To:     Heiko Carstens <hca@linux.ibm.com>, Li Wang <liwang@redhat.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     ltp@lists.linux.it, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH 3/3] lib/vdso: remove struct arch_vdso_data from vdso data struct
In-Reply-To: <20210323215819.4161164-4-hca@linux.ibm.com>
References: <YFmUrVOyX4q+8Dy9@osiris> <20210323215819.4161164-1-hca@linux.ibm.com> <20210323215819.4161164-4-hca@linux.ibm.com>
Date:   Thu, 25 Mar 2021 18:55:41 +0100
Message-ID: <87sg4jw21u.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Mar 23 2021 at 22:58, Heiko Carstens wrote:
> Since commit d60d7de3e16d ("lib/vdso: Allow to add architecture-specific
> vdso data") it is possible to provide arch specific VDSO data.
>
> This was only added for s390, which doesn't make use this anymore.
> Therefore remove it again.
>
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Please route that with the rest of the fixes.

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
