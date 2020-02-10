Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:55353 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726796AbgBJMQp (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 10 Feb 2020 07:16:45 -0500
Date: Mon, 10 Feb 2020 13:16:26 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 07/35] KVM: s390: add new variants of UV CALL
Message-ID: <20200210131626.39c88be8.cohuck@redhat.com>
In-Reply-To: <20200207113958.7320-8-borntraeger@de.ibm.com>
References: <20200207113958.7320-1-borntraeger@de.ibm.com>
        <20200207113958.7320-8-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Janosch Frank <frankja@linux.vnet.ibm.com>, KVM <kvm@vger.kernel.org>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Andrea Arcangeli <aarcange@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>

On Fri,  7 Feb 2020 06:39:30 -0500
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> From: Janosch Frank <frankja@linux.ibm.com>
> 
> This add 2 new variants of the UV CALL.

"This adds two new helper functions for doing UV CALLs."

?

> 
> The first variant handles UV CALLs that might have longer busy
> conditions or just need longer when doing partial completion. We should
> schedule when necessary.
> 
> The second variant handles UV CALLs that only need the handle but have
> no payload (e.g. destroying a VM). We can provide a simple wrapper for
> those.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> [borntraeger@de.ibm.com: patch merging, splitting, fixing]
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  arch/s390/include/asm/uv.h | 59 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 59 insertions(+)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
