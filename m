Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4893C4320E
	for <linux-s390@archiver.kernel.org>; Thu, 29 Jul 2021 16:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 869A560F21
	for <linux-s390@archiver.kernel.org>; Thu, 29 Jul 2021 16:00:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237961AbhG2QAN (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 29 Jul 2021 12:00:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:49984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238363AbhG2P6i (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 29 Jul 2021 11:58:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1AC2860F21;
        Thu, 29 Jul 2021 15:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627574315;
        bh=1Sz6fAoKWdC/PDDp7qSPBjRK2ww0G2gNlHmNDbJYtbc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=coG04a+nWxky0ttRvEdIErZbj4b6RtAgVvSbcgEdyzP21AqGkm//ErvvSqyuwVlqu
         xaWimwK20os7mBeKJwgOl2NASOvtd/mVQXUQJIum2E9XhGobfZcVxjPjG9ybNUGUoI
         6JrD/4jFZM8d32DuIH448KApIaALtvALWQAtk3oUQ/OGhG41QPJb2eWjSF27ECi/PZ
         GU6PHvIwWVoB2LSNUJUDsOVkWuobTJsRHOQiBJMgZIOflq9opFlEzlJVB9Qhy66rVA
         cDr2bgfT5WXwNSMzPNNVQ6lbCQeBP9fr5Y2ymN4fxZ+xw+dmfVwUM1ZELIyfeFaKWC
         BgWq80R5WG8CA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id DD6755C04E6; Thu, 29 Jul 2021 08:58:34 -0700 (PDT)
Date:   Thu, 29 Jul 2021 08:58:34 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH] kcsan: use u64 instead of cycles_t
Message-ID: <20210729155834.GX4397@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210729142811.1309391-1-hca@linux.ibm.com>
 <CANpmjNM=rSFwmJCEq6gxHZBdYKVZas4rbnd2gk8GCAEjiJ_5UQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANpmjNM=rSFwmJCEq6gxHZBdYKVZas4rbnd2gk8GCAEjiJ_5UQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, Jul 29, 2021 at 04:53:10PM +0200, Marco Elver wrote:
> +Cc: Paul
> 
> On Thu, 29 Jul 2021 at 16:28, Heiko Carstens <hca@linux.ibm.com> wrote:
> >
> > cycles_t has a different type across architectures: unsigned int,
> > unsinged long, or unsigned long long. Depending on architecture this
> > will generate this warning:
> >
> > kernel/kcsan/debugfs.c: In function ‘microbenchmark’:
> > ./include/linux/kern_levels.h:5:25: warning: format ‘%llu’ expects argument of type ‘long long unsigned int’, but argument 3 has type ‘cycles_t’ {aka ‘long unsigned int’} [-Wformat=]
> >
> > To avoid this simple change the type of cycle to u64 in
> > microbenchmark(), since u64 is of type unsigned long long for all
> > architectures.
> >
> > Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> 
> Acked-by: Marco Elver <elver@google.com>
> 
> Do you have a series adding KCSAN support for s390, i.e. would you
> like to keep it together with those changes?
> 
> Otherwise this would go the usual route through Paul's -rcu tree.

Either way, please let me know!

							Thanx, Paul

> Thanks,
> -- Marco
> 
> > ---
> >  kernel/kcsan/debugfs.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/kernel/kcsan/debugfs.c b/kernel/kcsan/debugfs.c
> > index e65de172ccf7..1d1d1b0e4248 100644
> > --- a/kernel/kcsan/debugfs.c
> > +++ b/kernel/kcsan/debugfs.c
> > @@ -64,7 +64,7 @@ static noinline void microbenchmark(unsigned long iters)
> >  {
> >         const struct kcsan_ctx ctx_save = current->kcsan_ctx;
> >         const bool was_enabled = READ_ONCE(kcsan_enabled);
> > -       cycles_t cycles;
> > +       u64 cycles;
> >
> >         /* We may have been called from an atomic region; reset context. */
> >         memset(&current->kcsan_ctx, 0, sizeof(current->kcsan_ctx));
> > --
> > 2.25.1
> >
> > --
> > You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> > To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> > To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20210729142811.1309391-1-hca%40linux.ibm.com.
