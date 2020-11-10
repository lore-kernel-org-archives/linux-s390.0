Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31126 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726307AbgKJLbR (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 10 Nov 2020 06:31:17 -0500
Date: Tue, 10 Nov 2020 12:31:05 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH] kvm: s390: pv: Mark mm as protected after the set
 secure parameters and improve cleanup
Message-ID: <20201110123105.4b7b1235.cohuck@redhat.com>
In-Reply-To: <20201030140141.106641-1-frankja@linux.ibm.com>
References: <20201030140141.106641-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>
Cc: kvm@vger.kernel.org, david@redhat.com, thuth@redhat.com, linux-s390@vger.kernel.org, borntraeger@de.ibm.com, imbrenda@linux.ibm.com

On Fri, 30 Oct 2020 10:01:41 -0400
Janosch Frank <frankja@linux.ibm.com> wrote:

> We can only have protected guest pages after a successful set secure
> parameters call as only then the UV allows imports and unpacks.
> 
> By moving the test we can now also check for it in s390_reset_acc()
> and do an early return if it is 0.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  arch/s390/kvm/kvm-s390.c | 2 +-
>  arch/s390/kvm/pv.c       | 3 ++-
>  arch/s390/mm/gmap.c      | 2 ++
>  3 files changed, 5 insertions(+), 2 deletions(-)

Seems reasonable to me. I assume it has been given some coverage by now?

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
