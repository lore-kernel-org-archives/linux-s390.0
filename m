Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CEF152E12;
	Wed,  4 Dec 2024 17:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733334051; cv=none; b=c/5XT2+yPUP1Ebej8MYVdLdSadeT1NEeHm84lk9UCFb1NW9NHDb6LlpcsovWMNTc2H9ozWCnCYFsIWz72L3BUjbvDYhGnaXjXYlms+am4kWDPx7/FtCbfOVelviopIp88IaKmVc1SK5JzeOJ0hqcQQE4lPEzl3kn2XoiNWdX4rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733334051; c=relaxed/simple;
	bh=LxkpU69xnQRzVLx5RpprBjdsbPTfZlN2KukOZTd+EfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=chkQqIWFEzACmvkeEwmD6ng6KjO7ip6oA5tb/uxfThXfSGiYgrCslJQV5tHZ5tb19RGUPf1NRvQEnrDaB0SRyYboNJPaT25lq9lxRsjPYmfCZIR1qSP95maRfjg4AeFgNAMJsOjmWwjM7D8I7lMHouX9XISjNoCh9pD3EV18Ssw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W0o+6MGi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W0o+6MGi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31D9AC4CECD;
	Wed,  4 Dec 2024 17:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733334050;
	bh=LxkpU69xnQRzVLx5RpprBjdsbPTfZlN2KukOZTd+EfQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W0o+6MGi/wfSfQDbviNlNP+lYxR+zz8vT1Crl7fh/xTX4Jh181+4KxWEO2v9s36BS
	 WYS7yjwzaQsVi1v0/yxcDMk8/xXOD9DAWKvQm4WMI/SiaQuB0jW8aF0WnLZye/9VQO
	 gU1NCyetAZCaMreIT5NwzD7jGEhsrxUMCqTPNoCOQ8UmivXus38CJD7DS36qK83YDj
	 tS01Sm1v2zIrUW3SZbYSATO2Z0Nfd3/Q8GlGVl8wcn0WQ0fC8p3UFhPQGSQW/Bsz86
	 fOIkKi+38RkqLiWFIgHeQodQlGOpqABRbMGFgHJS0rI+BSgKQiGhdxRBB0wPblMN2k
	 xkXpDUaI6NtQg==
Date: Wed, 4 Dec 2024 07:40:49 -1000
From: Tejun Heo <tj@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: David Laight <David.Laight@aculab.com>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	"linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
	clang-built-linux <llvm@lists.linux.dev>,
	linux-block <linux-block@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"lkft-triage@lists.linaro.org" <lkft-triage@lists.linaro.org>,
	Linux Regressions <regressions@lists.linux.dev>,
	Anders Roxell <anders.roxell@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Nathan Chancellor <nathan@kernel.org>, Jens Axboe <axboe@kernel.dk>
Subject: Re: s390: block/blk-iocost.c:1101:11: error: call to
 '__compiletime_assert_557' declared with 'error' attribute: clamp() low
 limit 1 greater than high limit active
Message-ID: <Z1CUIT8zAqWOnot-@slm.duckdns.org>
References: <CA+G9fYsD7mw13wredcZn0L-KBA3yeoVSTuxnss-AEWMN3ha0cA@mail.gmail.com>
 <5ffa868f-cbf0-42ae-ae10-5c39b0de05e7@stanley.mountain>
 <7920126775c74fa5915afbeedcfe2058@AcuMS.aculab.com>
 <c795c090-430a-45a6-88b2-94033d50dea2@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c795c090-430a-45a6-88b2-94033d50dea2@stanley.mountain>

Hello,

On Wed, Dec 04, 2024 at 07:50:14PM +0300, Dan Carpenter wrote:
> Tejun probably reads everything to linux-block, but let's CC him explicitly.

Oh, I'm not. Thanks for cc'ing.

> block/blk-iocost.c
>   2222                          TRACE_IOCG_PATH(iocg_idle, iocg, now,
>   2223                                          atomic64_read(&iocg->active_period),
>   2224                                          atomic64_read(&ioc->cur_period), vtime);
>   2225                          __propagate_weights(iocg, 0, 0, false, now);
>                                                           ^
> Why is "active" zero?  __propagate_weights() does a clamp() to 1 as minimum and
> we've added new build time asserts so this breaks the build.
> 
>   2226                          list_del_init(&iocg->active_list);
> 
> The other way to solve this would be to something stupid like:
> 
> diff --git a/block/blk-iocost.c b/block/blk-iocost.c
> index 384aa15e8260..551edd2f661f 100644
> --- a/block/blk-iocost.c
> +++ b/block/blk-iocost.c
> @@ -1094,7 +1094,7 @@ static void __propagate_weights(struct ioc_gq *iocg, u32 active, u32 inuse,
>          * @active. An active internal node's inuse is solely determined by the
>          * inuse to active ratio of its children regardless of @inuse.
>          */
> -       if (list_empty(&iocg->active_list) && iocg->child_active_sum) {
> +       if ((list_empty(&iocg->active_list) && iocg->child_active_sum) || active == 0) {
>                 inuse = DIV64_U64_ROUND_UP(active * iocg->child_inuse_sum,
>                                            iocg->child_active_sum);
>         } else {
> 
> But that seems really stupid.

This is a good catch. It's impressive that this can be caught at compile
time. The upper limit can become zero but the lower limit should win as
that's there to protect against divide by zero, so I think the right thinig
to do is replacing clamp() with max(min()). Is someone interested in writing
up the patch and sending it Jens' way?

Thanks.

-- 
tejun
