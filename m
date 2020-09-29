Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24074 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728254AbgI2Kvb (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 29 Sep 2020 06:51:31 -0400
Date: Tue, 29 Sep 2020 12:51:18 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [kvm-unit-tests PATCH v2 2/4] s390x: pv: implement routine to
 share/unshare memory
Message-ID: <20200929125118.26566182.cohuck@redhat.com>
In-Reply-To: <1601303017-8176-3-git-send-email-pmorel@linux.ibm.com>
References: <1601303017-8176-1-git-send-email-pmorel@linux.ibm.com>
        <1601303017-8176-3-git-send-email-pmorel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, thuth@redhat.com, imbrenda@linux.ibm.com

On Mon, 28 Sep 2020 16:23:35 +0200
Pierre Morel <pmorel@linux.ibm.com> wrote:

> When communicating with the host we need to share part of
> the memory.
> 
> Let's implement the ultravisor calls for this.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> Suggested-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  lib/s390x/asm/uv.h | 50 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 50 insertions(+)

Acked-by: Cornelia Huck <cohuck@redhat.com>
