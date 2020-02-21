Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:42981 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727781AbgBUNpx (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 21 Feb 2020 08:45:53 -0500
Date: Fri, 21 Feb 2020 14:45:38 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v3 00/37] KVM: s390: Add support for protected VMs
Message-ID: <20200221144538.032f4b0e.cohuck@redhat.com>
In-Reply-To: <1c54d830-79de-e3ee-4c11-d87f95f90c57@redhat.com>
References: <20200220104020.5343-1-borntraeger@de.ibm.com>
        <5556ee4a-09c6-117a-be99-4a5e136b78ea@redhat.com>
        <0665a90a-19f2-39a8-8a48-d180a622e9f2@de.ibm.com>
        <1c54d830-79de-e3ee-4c11-d87f95f90c57@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, KVM <kvm@vger.kernel.org>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org

On Fri, 21 Feb 2020 12:28:51 +0100
David Hildenbrand <david@redhat.com> wrote:

> >> Can we get a new version once the other reviewers are done, so at least
> >> I can have a final look?  
> > 
> > Just the updated patches as reply (e.g. a 3.2 for patch 9) or the full monty?  
> 
> Whatever you others prefer. I can see that Conny has some feedback.
> maybe wait for that and then (selectively) resend.

I was still looking over this version. And to be honest, I find those
3.x patches utterly confusing, especially as this is all coming in so
quickly as to make it hard to keep up.

That said, I'll probably not be able to do much (or any) reviewing
today or on Monday, so feel free to send a new version next week.
