Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49F89C7EE32
	for <linux-s390@archiver.kernel.org>; Mon, 27 Feb 2023 09:54:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbjB0JyI (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 27 Feb 2023 04:54:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjB0JyH (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 27 Feb 2023 04:54:07 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 888FF1040F;
        Mon, 27 Feb 2023 01:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677491646; x=1709027646;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=f/bLJaqaLfK7yUfdWWThO9xflQ5SoY/AGk04yxsIRKk=;
  b=SmC9Ze87Nz1fqd05wVZ3FwXvaWJc5ukPggCTVPc8oIXf1QZP18j8Cbjp
   nEgAgYkGXn0JnvikFhrdwfTdpU9BzzWWEARiHXO/IInQXWc/12YEvw20E
   o0/uAnqthgKRBLD7x7kszTjXWcOVesmXBShkjgUwAb6TJYqa5krw/OK83
   vIwMl9aETYHs+UDyEBKWeGVEbVcw02P7Ko616xDEUF/ExCPgwRqST1uhE
   X/0ucodtVAP8gsvdx12rDKbGZTPH4lJJjdV8D0qQQap9zJEn5AWeXCYNL
   3Y2r1VHUdGsn2R0glFWttIPsk59Wd7xt/Sz1ohB1Xp7BKGJy7/hQZjnmR
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10633"; a="361379819"
X-IronPort-AV: E=Sophos;i="5.97,331,1669104000"; 
   d="scan'208";a="361379819"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2023 01:54:06 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10633"; a="919240678"
X-IronPort-AV: E=Sophos;i="5.97,331,1669104000"; 
   d="scan'208";a="919240678"
Received: from jrissane-mobl2.ger.corp.intel.com (HELO intel.com) ([10.249.41.42])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2023 01:53:59 -0800
Date:   Mon, 27 Feb 2023 10:53:57 +0100
From:   Andi Shyti <andi.shyti@linux.intel.com>
To:     Andrzej Hajda <andrzej.hajda@intel.com>
Cc:     linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, openrisc@lists.librecores.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [Intel-gfx] [PATCH v5 2/7] linux/include: add non-atomic version
 of xchg
Message-ID: <Y/x9tclWV/lqBMzZ@ashyti-mobl2.lan>
References: <20230118153529.57695-1-andrzej.hajda@intel.com>
 <20230118154450.73842-1-andrzej.hajda@intel.com>
 <20230118154450.73842-2-andrzej.hajda@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230118154450.73842-2-andrzej.hajda@intel.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi Andrzej,

On Wed, Jan 18, 2023 at 04:44:45PM +0100, Andrzej Hajda wrote:
> The pattern of setting variable with new value and returning old
> one is very common in kernel. Usually atomicity of the operation
> is not required, so xchg seems to be suboptimal and confusing in
> such cases.
> 
> Signed-off-by: Andrzej Hajda <andrzej.hajda@intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>

Thanks,
Andi
