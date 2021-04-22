Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CEE2C433B4
	for <linux-s390@archiver.kernel.org>; Thu, 22 Apr 2021 10:47:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F98B613D8
	for <linux-s390@archiver.kernel.org>; Thu, 22 Apr 2021 10:47:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235959AbhDVKrn (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 22 Apr 2021 06:47:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:55242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235830AbhDVKrm (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 22 Apr 2021 06:47:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3D82A61409;
        Thu, 22 Apr 2021 10:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619088428;
        bh=c00PLQfj9zNo6Kusw3zsLW4rKknJihekgM7hsgZq3pg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JC+Ctv3WSj9GhEWkE7fGRfC/UuJtaYZ0/mddeYWGbSXVSu55XK+H64iILq3z2a3Li
         WFkZHMz15rf0YkkMoA8pz0yhG3S9D0UiB2+xYeqwGNvVK6HaIUML/Y3hKl/RVTGjmC
         vuQv8zVYlG+sg2yYxuP0lHHE028x0NeEtnYo8RaFPF39ED5lEbe3WiWUkc+H3GQRFT
         QO4VTywWvgWaEGym+bg+IXyJPgT79F3nGOt43Kn4OpaaQYWOBePeFdiqRxaen6oTw6
         zlyIJ/KFqXMfBiu4ffMb/cLcm3/TuYa7J4SkEFNlPhO+XHQ9KSdf8w4i4hyJ4zgyUz
         /+i5XCItEkxAg==
Date:   Thu, 22 Apr 2021 11:47:00 +0100
From:   Will Deacon <will@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, nathan@kernel.org,
        Viresh Kumar <viresh.kumar@linaro.org>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        kernel-team@android.com
Subject: Re: [PATCH 5/5] perf: Get rid of oprofile leftovers
Message-ID: <20210422104700.GE1442@willie-the-truck>
References: <20210414134409.1266357-1-maz@kernel.org>
 <20210414134409.1266357-6-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210414134409.1266357-6-maz@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Apr 14, 2021 at 02:44:09PM +0100, Marc Zyngier wrote:
> perf_pmu_name() and perf_num_counters() are unused. Drop them.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  include/linux/perf_event.h | 2 --
>  kernel/events/core.c       | 5 -----
>  2 files changed, 7 deletions(-)

Acked-by: Will Deacon <will@kernel.org>

Will
