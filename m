Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:46046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727242AbgCADrf (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Sat, 29 Feb 2020 22:47:35 -0500
Date: Sat, 29 Feb 2020 19:47:32 -0800
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC v1 2/2] mm/gup/writeback: add callbacks for inaccessible
 pages
Message-Id: <20200229194732.e8bf21bbdb4f9878fecfb3ed@linux-foundation.org>
In-Reply-To: <2e3bf1a2-b672-68e0-97b6-42f08133e077@de.ibm.com>
References: <20200228154322.329228-1-imbrenda@linux.ibm.com>
        <20200228154322.329228-4-imbrenda@linux.ibm.com>
        <2e3bf1a2-b672-68e0-97b6-42f08133e077@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-next@vger.kernel.org, david@redhat.com, aarcange@redhat.com, linux-mm@kvack.org, frankja@linux.ibm.com, sfr@canb.auug.org.au, jhubbard@nvidia.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Will Deacon <will@kernel.org>

On Fri, 28 Feb 2020 17:08:19 +0100 Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> while patch 1 is a fixup for the FOLL_PIN work in your patch queue,
> I would really love to see this patch in 5.7. The exploitation code
> of kvm/s390 is in Linux next also scheduled for 5.7.

Sounds good.  My inbox eagerly awaits v2 ;)
