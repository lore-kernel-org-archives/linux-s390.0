Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37906 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728400AbgAaLrq (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 31 Jan 2020 06:47:46 -0500
Subject: Re: [PATCH v10 6/6] selftests: KVM: testing the local IRQs resets
References: <20200131100205.74720-1-frankja@linux.ibm.com>
 <20200131100205.74720-7-frankja@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <b72b4119-913b-9bed-069f-18c0eb4c910f@redhat.com>
Date: Fri, 31 Jan 2020 12:47:32 +0100
MIME-Version: 1.0
In-Reply-To: <20200131100205.74720-7-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: borntraeger@de.ibm.com, david@redhat.com, cohuck@redhat.com, linux-s390@vger.kernel.org

On 31/01/2020 11.02, Janosch Frank wrote:
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
> ---
>  tools/testing/selftests/kvm/s390x/resets.c | 42 ++++++++++++++++++++++
>  1 file changed, 42 insertions(+)

Reviewed-by: Thomas Huth <thuth@redhat.com>
