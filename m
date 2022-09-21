Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78352C32771
	for <linux-s390@archiver.kernel.org>; Wed, 21 Sep 2022 08:27:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbiIUI1G (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 21 Sep 2022 04:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbiIUI0h (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 21 Sep 2022 04:26:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F05162C4;
        Wed, 21 Sep 2022 01:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=N+sWBwv5MxF+6L51ydEyB/jrgY323m4Yuf+2/IegXt4=; b=O7cVp4ViyjbDED2MT57s8CArTF
        J7kYu9tRk1fnkzTktLGQXVs586llVSIWhD/yW4lryR7aPAkol4HRjkMiV1t+Nfz9hueTNgekkURIO
        z+yUMSQ4OFaWQ49/SUgLunFG49kuif1zJp57EW1uIukdqKgKpI9GO4fpdunpOPVTBXTrTBQGnwGsf
        9bAE3n5MrZFnNnLHrJSJcljwllDRsasEoah/KhT0pzpT2pyRAq40XdRB+k90yJo5u67lLd/SZYvLE
        ii/M9BMy5W8s49SjqmvD/EfTCTVa7WuFktvF8/eE5sreUcEjbU8lWm+6fGBXDyYtVxJinG5S6czIU
        wYN6zxEA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oav2u-0069Vh-1E; Wed, 21 Sep 2022 08:25:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 948DD300074;
        Wed, 21 Sep 2022 10:25:23 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 775192BB085DD; Wed, 21 Sep 2022 10:25:23 +0200 (CEST)
Date:   Wed, 21 Sep 2022 10:25:23 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Cc:     anil.s.keshavamurthy@intel.com, borntraeger@linux.ibm.com,
        catalin.marinas@arm.com, dave.hansen@linux.intel.com,
        gor@linux.ibm.com, guoren@kernel.org, hca@linux.ibm.com,
        hpa@zytor.com, linux-arm-kernel@lists.infradead.org,
        linux-csky@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, mark.rutland@arm.com,
        mhiramat@kernel.org, namit@vmware.com, palmer@dabbelt.com,
        paul.walmsley@sifive.com, x86@kernel.org,
        Yipeng Zou <zouyipeng@huawei.com>, chris.zjh@huawei.com,
        liaochang1@huawei.com
Subject: Re: [PATCH 0/2] make weak attributes in {k,u}probes
Message-ID: <YyrKc/tpLllEBH/m@hirez.programming.kicks-ass.net>
References: <20220917015522.44583-1-zouyipeng@huawei.com>
 <1663692878.h3l8c563n8.naveen@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1663692878.h3l8c563n8.naveen@linux.ibm.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Sep 20, 2022 at 10:32:46PM +0530, Naveen N. Rao wrote:
> Yipeng Zou wrote:
> > We have some function implementation under some arch does nothing.
> > We can mark it with weak attributes to improve.
> 
> That's not always an improvement. See [1] for an example, among many other
> patches to reduce use of __weak functions in the kernel.

More weak 'fun':

  https://lkml.kernel.org/r/20220419203807.655552918@infradead.org
