Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37084 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728250AbgAaKQm (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 31 Jan 2020 05:16:42 -0500
Date: Fri, 31 Jan 2020 11:16:32 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v10 6/6] selftests: KVM: testing the local IRQs resets
Message-ID: <20200131111632.2a3c41a4.cohuck@redhat.com>
In-Reply-To: <20200131100205.74720-7-frankja@linux.ibm.com>
References: <20200131100205.74720-1-frankja@linux.ibm.com>
        <20200131100205.74720-7-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>
Cc: kvm@vger.kernel.org, thuth@redhat.com, borntraeger@de.ibm.com, david@redhat.com, linux-s390@vger.kernel.org

On Fri, 31 Jan 2020 05:02:05 -0500
Janosch Frank <frankja@linux.ibm.com> wrote:

> From: Pierre Morel <pmorel@linux.ibm.com>
> 
> Local IRQs are reset by a normal cpu reset.  The initial cpu reset and
> the clear cpu reset, as superset of the normal reset, both clear the
> IRQs too.
> 
> Let's inject an interrupt to a vCPU before calling a reset and see if
> it is gone after the reset.
> 
> We choose to inject only an emergency interrupt at this point and can
> extend the test to other types of IRQs later.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>[minor fixups]

I usually keep a blank between the email address and any annotations
(not sure if that might trip some scripts).

> ---
>  tools/testing/selftests/kvm/s390x/resets.c | 42 ++++++++++++++++++++++
>  1 file changed, 42 insertions(+)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
