Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52114 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728870AbhAUJhS (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 21 Jan 2021 04:37:18 -0500
Subject: Re: [kvm-unit-tests PATCH v4 3/3] s390x: css: pv: css test adaptation
 for PV
References: <1611220392-22628-1-git-send-email-pmorel@linux.ibm.com>
 <1611220392-22628-4-git-send-email-pmorel@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <15b91686-97a0-5811-914c-a805dda58f57@redhat.com>
Date: Thu, 21 Jan 2021 10:35:42 +0100
MIME-Version: 1.0
In-Reply-To: <1611220392-22628-4-git-send-email-pmorel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, cohuck@redhat.com, imbrenda@linux.ibm.com, drjones@redhat.com, pbonzini@redhat.com

On 21/01/2021 10.13, Pierre Morel wrote:
> We want the tests to automatically work with or without protected
> virtualisation.
> To do this we need to share the I/O memory with the host.
> 
> Let's replace all static allocations with dynamic allocations
> to clearly separate shared and private memory.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>   lib/s390x/css.h     |  3 +--
>   lib/s390x/css_lib.c | 28 ++++++++--------------------
>   s390x/css.c         | 43 +++++++++++++++++++++++++++++++------------
>   3 files changed, 40 insertions(+), 34 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>
