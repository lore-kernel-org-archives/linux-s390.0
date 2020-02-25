Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:60181 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729207AbgBYMgp (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 25 Feb 2020 07:36:45 -0500
Date: Tue, 25 Feb 2020 13:36:32 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v4 25/36] KVM: s390: protvirt: Only sync fmt4 registers
Message-ID: <20200225133632.7ae5593e.cohuck@redhat.com>
In-Reply-To: <20200224114107.4646-26-borntraeger@de.ibm.com>
References: <20200224114107.4646-1-borntraeger@de.ibm.com>
        <20200224114107.4646-26-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Janosch Frank <frankja@linux.vnet.ibm.com>, KVM <kvm@vger.kernel.org>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>

On Mon, 24 Feb 2020 06:40:56 -0500
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> From: Janosch Frank <frankja@linux.ibm.com>
> 
> A lot of the registers are controlled by the Ultravisor and never
> visible to KVM. Also some registers are overlayed, like gbea is with
> sidad, which might leak data to userspace.
> 
> Hence we sync a minimal set of registers for both SIE formats and then
> check and sync format 2 registers if necessary.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> [borntraeger@de.ibm.com: patch merging, splitting, fixing]
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  arch/s390/kvm/kvm-s390.c | 110 +++++++++++++++++++++++++--------------
>  1 file changed, 70 insertions(+), 40 deletions(-)
> 

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
