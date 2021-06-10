Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2785DC47094
	for <linux-s390@archiver.kernel.org>; Thu, 10 Jun 2021 05:25:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAABF613E1
	for <linux-s390@archiver.kernel.org>; Thu, 10 Jun 2021 05:25:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbhFJF1J (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 10 Jun 2021 01:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbhFJF1J (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 10 Jun 2021 01:27:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D5DC061574;
        Wed,  9 Jun 2021 22:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0q4RCvc/9mzT3mQV4dTF1WnKIhRqdnIIYV31Jdhy1KQ=; b=WV2xiZA3cNN/xfc3Hy5VQQcra4
        i/kUVdx5dj/vBw9CKf7eqA2UCMB3gebnUW1fhL0LTlnOkgyCrIjCV0gqFx9+usHQBS4yvbucRBoGg
        JNC+75/rCUoVxOKlaov0NGbYIjSbwDxhx8FfXuvpM+5tXkSnW5TbXX7FSq+fqxim45alIaVx8m2JM
        RtddiwUAZEG2sUILhPcMnydEMwqkqT+MOttywz2PULGGqe57UtiCPLWggiJ/PhST4eb0l8+EgJZyk
        GEVQrc0al3ZUAifTo7iDYlWQpycpUgWOUYkaU4sqTxsRyDJEED2YCd2wUzo/0DR4zIMnpm3fuIuYg
        1hxYTrng==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lrDBH-001GCn-Eh; Thu, 10 Jun 2021 05:24:46 +0000
Date:   Thu, 10 Jun 2021 06:24:39 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        cohuck@redhat.com, david@redhat.com, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        David Rientjes <rientjes@google.com>
Subject: Re: [PATCH v2 1/2] mm/vmalloc: export __vmalloc_node_range
Message-ID: <YMGiFya4JP9VuV0Y@infradead.org>
References: <20210608180618.477766-1-imbrenda@linux.ibm.com>
 <20210608180618.477766-2-imbrenda@linux.ibm.com>
 <YMDlVdB8m62AhbB7@infradead.org>
 <20210609182809.7ae07aad@ibm-vm>
 <6bf6fb06-0930-8cae-3e2b-8cb3237a6197@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6bf6fb06-0930-8cae-3e2b-8cb3237a6197@de.ibm.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Jun 09, 2021 at 07:47:43PM +0200, Christian Borntraeger wrote:
> An alternative would be to provide a vmalloc_no_huge function in generic
> code  (similar to  vmalloc_32) (or if preferred in s390 base architecture code)
> Something like
> 
> void *vmalloc_no_huge(unsigned long size)
> {
>         return __vmalloc_node_flags(size, NUMA_NO_NODE,VM_NO_HUGE_VMAP |
>                                 GFP_KERNEL | __GFP_ZERO);
> }
> EXPORT_SYMBOL(vmalloc_no_huge);
> 
> or a similar vzalloc variant.

Exactly.  Given that this seems to be a weird pecularity of legacy s390
interfaces I'd only export it for 390 for now, although for
documentation purposes I'd probably still keep it in vmalloc.c.
