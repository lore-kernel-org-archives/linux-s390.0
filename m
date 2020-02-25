Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:52848 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729066AbgBYMvR (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 25 Feb 2020 07:51:17 -0500
Date: Tue, 25 Feb 2020 13:51:06 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v4 27/36] KVM: s390: protvirt: UV calls in support of
 diag308 0, 1
Message-ID: <20200225135106.294aadb9.cohuck@redhat.com>
In-Reply-To: <20200224114107.4646-28-borntraeger@de.ibm.com>
References: <20200224114107.4646-1-borntraeger@de.ibm.com>
        <20200224114107.4646-28-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Janosch Frank <frankja@linux.vnet.ibm.com>, KVM <kvm@vger.kernel.org>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>

On Mon, 24 Feb 2020 06:40:58 -0500
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> From: Janosch Frank <frankja@linux.ibm.com>
> 
> diag 308 subcode 0 and 1 require several KVM and Ultravisor interactions.
> Specific to these "soft" reboots are
> 
> * The "unshare all" UVC
> * The "prepare for reset" UVC
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> [borntraeger@de.ibm.com: patch merging, splitting, fixing]
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  arch/s390/include/asm/uv.h |  4 ++++
>  arch/s390/kvm/kvm-s390.c   | 22 ++++++++++++++++++++++
>  include/uapi/linux/kvm.h   |  2 ++
>  3 files changed, 28 insertions(+)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
