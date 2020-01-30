Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36417 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727001AbgA3NUs (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 30 Jan 2020 08:20:48 -0500
Subject: Re: [PATCH v9 2/6] KVM: s390: Cleanup initial cpu reset
References: <20200130123434.68129-1-frankja@linux.ibm.com>
 <20200130123434.68129-3-frankja@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <3096ea7a-f3a9-e3f5-336c-13c01fef385e@redhat.com>
Date: Thu, 30 Jan 2020 14:20:36 +0100
MIME-Version: 1.0
In-Reply-To: <20200130123434.68129-3-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: borntraeger@de.ibm.com, david@redhat.com, cohuck@redhat.com, linux-s390@vger.kernel.org

On 30/01/2020 13.34, Janosch Frank wrote:
> The code seems to be quite old and uses lots of unneeded spaces for
> alignment, which doesn't really help with readability.
> 
> Let's:
> * Get rid of the extra spaces
> * Remove the ULs as they are not needed on 0s
> * Define constants for the CR 0 and 14 initial values
> * Use the sizeof of the gcr array to memset it to 0
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  arch/s390/include/asm/kvm_host.h |  5 +++++
>  arch/s390/kvm/kvm-s390.c         | 18 +++++++-----------
>  2 files changed, 12 insertions(+), 11 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>
