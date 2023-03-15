Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BB2DC7618D
	for <linux-s390@archiver.kernel.org>; Wed, 15 Mar 2023 05:02:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbjCOFCw (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 15 Mar 2023 01:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbjCOFCv (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 15 Mar 2023 01:02:51 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DD955F536
        for <linux-s390@vger.kernel.org>; Tue, 14 Mar 2023 22:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ahxRYQ1+4b3SShQsQkAVmdrJ+ZogUunkpbD0sM5voZ8=; b=gFvcXaDvg32/Hvg3izMFoYnjbm
        WPV+qU1/4jrUVdF9F8CNR2FIHFUFZ/glIL6SJRcsY6dR+lSG8wfJcv/IXZvNzknTHpVRTBX+4en9f
        iTOA2K6hJ75j2VLawDl6xrHMX9M75dBvPoL2YHgQY1rJg7cZOlKwKz8w9eBL0c4L6TlUsIfUKZBW/
        gqN2tDHzYjKaaaoxmDdhsWomPM0m/lcKqQxJ8OAbW4uGDWXCrkximAdJYy2ciJGhPiR23NTqKRd8S
        vwSp6d+kxVGIWzJDBtLh/AwELdoIvhB0G0w89CmpDtVa8mGEk79rLznUTMaVXFnbShCgFTi8uHwDR
        649jEg5g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pcJHZ-00DXlj-8v; Wed, 15 Mar 2023 05:02:37 +0000
Date:   Wed, 15 Mar 2023 05:02:37 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Tong Tiangen <tongtiangen@huawei.com>
Subject: Re: [PATCH v2 1/6] riscv/mm/fault: simplify code for do_page_fault()
Message-ID: <ZBFRbVJDK8p5nelT@casper.infradead.org>
References: <20230315030359.14162-1-palmer@rivosinc.com>
 <20230315030359.14162-2-palmer@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230315030359.14162-2-palmer@rivosinc.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Mar 14, 2023 at 08:03:54PM -0700, Palmer Dabbelt wrote:
> To make the code more hierarchical and readable, we fold vma related
> judgments into __do_page_fault(). And to simplify the code, move the
> tsk->thread.bad_cause's setting into bad_area(). No functional change
> intended.

I think this is exaactly the wrong thing to be doing.  Please _stop_
using custom internal VM_FAULT flags, not adding new uses!
