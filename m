Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:28040 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727529AbgCXM0s (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 24 Mar 2020 08:26:48 -0400
Date: Tue, 24 Mar 2020 13:26:33 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [kvm-unit-tests PATCH 07/10] s390x: smp: Use full PSW to
 bringup new cpu
Message-ID: <20200324132633.115f37ff.cohuck@redhat.com>
In-Reply-To: <20200324081251.28810-8-frankja@linux.ibm.com>
References: <20200324081251.28810-1-frankja@linux.ibm.com>
        <20200324081251.28810-8-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>
Cc: kvm@vger.kernel.org, thuth@redhat.com, linux-s390@vger.kernel.org, david@redhat.com

On Tue, 24 Mar 2020 04:12:48 -0400
Janosch Frank <frankja@linux.ibm.com> wrote:

> Up to now we ignored the psw mask and only used the psw address when
> bringing up a new cpu. For DAT we need to also load the mask, so let's
> do that.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  lib/s390x/smp.c  | 2 ++
>  s390x/cstart64.S | 3 ++-
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
