Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 450C1C7EE31
	for <linux-s390@archiver.kernel.org>; Mon, 27 Feb 2023 09:58:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbjB0J60 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 27 Feb 2023 04:58:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjB0J6Z (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 27 Feb 2023 04:58:25 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 490961042D;
        Mon, 27 Feb 2023 01:58:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677491904; x=1709027904;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WLpJB0qI2/zRDKGnG+kitqzMLkyJLUqz1gpLf8+y3Pw=;
  b=PlC9UhwO3iZ+X+U+rY+V2CiZkJb5c8ZAh9BGeJngS91fgKHio3qK64hy
   vm1eQW3+NBVGrBTAWim3S83tiGrG1QukRqNn3jKSUJbf3cegAI8CpJC5q
   jH9DQxLYjHVkGHxjZEKXmThkj7h0tCWHcGo0fRBaimX0ykwmicxxi4LB7
   ShmbWdBx1uySvWfrRYKMaMUOKqwxecYIHArIoeJ6//GB0oLKPhursMExL
   RSjm1AF9PWcU7nZ/h7TXUceqSJs7KRwY+/sv5ryafWDit33kd5/QgHO9U
   xAwhCCmr66W1S/v/XdyviJRQ40JNT9FVm944YucpynEBI4/Q2LcDZamWt
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10633"; a="361380480"
X-IronPort-AV: E=Sophos;i="5.97,331,1669104000"; 
   d="scan'208";a="361380480"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2023 01:58:23 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10633"; a="847757997"
X-IronPort-AV: E=Sophos;i="5.97,331,1669104000"; 
   d="scan'208";a="847757997"
Received: from jrissane-mobl2.ger.corp.intel.com (HELO intel.com) ([10.249.41.42])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2023 01:58:16 -0800
Date:   Mon, 27 Feb 2023 10:58:13 +0100
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
Subject: Re: [Intel-gfx] [PATCH v5 7/7] drm/i915/gt: use __xchg instead of
 internal helper
Message-ID: <Y/x+tckkW3BbHBYa@ashyti-mobl2.lan>
References: <20230118153529.57695-1-andrzej.hajda@intel.com>
 <20230118154450.73842-1-andrzej.hajda@intel.com>
 <20230118154450.73842-7-andrzej.hajda@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230118154450.73842-7-andrzej.hajda@intel.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi Andrzej,

On Wed, Jan 18, 2023 at 04:44:50PM +0100, Andrzej Hajda wrote:
> Prefer core helper if available.
> 
> Signed-off-by: Andrzej Hajda <andrzej.hajda@intel.com>

Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>

Thanks,
Andi
