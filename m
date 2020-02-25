Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:47788 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730573AbgBYOai (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 25 Feb 2020 09:30:38 -0500
Date: Tue, 25 Feb 2020 15:30:24 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v4 20/36] KVM: s390/mm: handle guest unpin events
Message-ID: <20200225153024.62e1ed7f.cohuck@redhat.com>
In-Reply-To: <2c45d494-8fdf-69c1-e786-0f07c6f09a40@de.ibm.com>
References: <20200224114107.4646-1-borntraeger@de.ibm.com>
        <20200224114107.4646-21-borntraeger@de.ibm.com>
        <20200225131838.2d68e7f9.cohuck@redhat.com>
        <2c45d494-8fdf-69c1-e786-0f07c6f09a40@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Janosch Frank <frankja@linux.vnet.ibm.com>, KVM <kvm@vger.kernel.org>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>

On Tue, 25 Feb 2020 15:21:42 +0100
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 25.02.20 13:18, Cornelia Huck wrote:
> > On Mon, 24 Feb 2020 06:40:51 -0500
> > Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> >   
> >> From: Claudio Imbrenda <imbrenda@linux.ibm.com>
> >>
> >> The current code tries to first pin shared pages, if that fails (e.g.
> >> because the page is not shared) it will export them. For shared pages
> >> this means that we get a new intercept telling us that the guest is
> >> unsharing that page. We will make the page secure at that point in time
> >> and revoke the host access. This is synchronized with other host events,
> >> e.g. the code will wait until host I/O has finished.
> >>
> >> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> >> Acked-by: David Hildenbrand <david@redhat.com>
> >> [borntraeger@de.ibm.com: patch merging, splitting, fixing]
> >> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> >> ---
> >>  arch/s390/kvm/intercept.c | 24 ++++++++++++++++++++++++
> >>  1 file changed, 24 insertions(+)

> I will also fixup the misleading patch description:
> 
> The current code tries to first pin shared pages, if that fails (e.g.
> because the page is not shared) it will export them. For shared pages
> this means that we get a new intercept telling us that the guest is
> unsharing that page. We will unpin the page at that point in time,
> following the same rules as for make secure. (wait for writeback, no
> elevated page refs etc).

I'd suggest:

"...as for making a page secure (i.e. waiting for writeback, no
elevated page references, etc.)"

With the touchups,

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
