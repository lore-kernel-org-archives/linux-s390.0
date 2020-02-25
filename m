Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55871 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729034AbgBYMPX (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 25 Feb 2020 07:15:23 -0500
Date: Tue, 25 Feb 2020 13:15:10 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v4 19/36] KVM: s390: protvirt: handle secure guest
 prefix pages
Message-ID: <20200225131510.083cf61a.cohuck@redhat.com>
In-Reply-To: <20200224114107.4646-20-borntraeger@de.ibm.com>
References: <20200224114107.4646-1-borntraeger@de.ibm.com>
        <20200224114107.4646-20-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Janosch Frank <frankja@linux.vnet.ibm.com>, KVM <kvm@vger.kernel.org>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>

On Mon, 24 Feb 2020 06:40:50 -0500
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> From: Janosch Frank <frankja@linux.ibm.com>
> 
> The SPX instruction is handled by the ultravisor. We do get a
> notification intercept, though. Let us update our internal view.
> 
> In addition to that, when the guest prefix page is not secure, an
> intercept 112 (0x70) is indicated. Let us make the prefix pages
> secure again.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> [borntraeger@de.ibm.com: patch merging, splitting, fixing]
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  arch/s390/include/asm/kvm_host.h |  1 +
>  arch/s390/kvm/intercept.c        | 18 ++++++++++++++++++
>  2 files changed, 19 insertions(+)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
