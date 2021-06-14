Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41D7EC2B9F4
	for <linux-s390@archiver.kernel.org>; Mon, 14 Jun 2021 23:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DEF061029
	for <linux-s390@archiver.kernel.org>; Mon, 14 Jun 2021 23:59:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbhFOAB3 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 14 Jun 2021 20:01:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:38656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229499AbhFOAB3 (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 14 Jun 2021 20:01:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DAC476109D;
        Mon, 14 Jun 2021 23:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1623715152;
        bh=DeDcOKxjCJPYLHn+O+2KmBPi5xsxQnW4OXNCOmqwVTU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lObFGQpgL2aRuhzOqt4YeJXawc51N12QYWW1Sy+gwGJwPUS3gjkw4FuPHpDUX5Hrm
         L1aN1ytoiZ6PjVru99jv+9WctQFSZSTI/vE8p5T0sMee4hv3m/Vf9YxOCtn0bRy4V4
         M5BLBPvuhtblGdOYCnuczZywOaS8ntgiNmS8yALY=
Date:   Mon, 14 Jun 2021 16:59:11 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        borntraeger@de.ibm.com, cohuck@redhat.com, david@redhat.com,
        linux-mm@kvack.org, Nicholas Piggin <npiggin@gmail.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v4 0/2] mm: add vmalloc_no_huge and use it
Message-Id: <20210614165911.1ee6c9459ac7f746906e3f0b@linux-foundation.org>
In-Reply-To: <20210614132357.10202-1-imbrenda@linux.ibm.com>
References: <20210614132357.10202-1-imbrenda@linux.ibm.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, 14 Jun 2021 15:23:55 +0200 Claudio Imbrenda <imbrenda@linux.ibm.com> wrote:

> Add vmalloc_no_huge and export it, so modules can allocate memory with
> small pages.
> 
> Use the newly added vmalloc_no_huge in KVM on s390 to get around a
> hardware limitation.

Thanks.  I added

Fixes: 121e6f3258fe3 ("mm/vmalloc: hugepage vmalloc mappings") 

and also addressed the whitespace thing which Christoph noted.

No cc:stable since 121e6f3258fe3 wasn't in 5.12.
