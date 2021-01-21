Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21250 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731501AbhAUMuB (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 21 Jan 2021 07:50:01 -0500
Date: Thu, 21 Jan 2021 13:48:24 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [kvm-unit-tests PATCH v4 3/3] s390x: css: pv: css test
 adaptation for PV
Message-ID: <20210121134824.041100f3.cohuck@redhat.com>
In-Reply-To: <1611220392-22628-4-git-send-email-pmorel@linux.ibm.com>
References: <1611220392-22628-1-git-send-email-pmorel@linux.ibm.com>
        <1611220392-22628-4-git-send-email-pmorel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, thuth@redhat.com, imbrenda@linux.ibm.com, drjones@redhat.com, pbonzini@redhat.com

On Thu, 21 Jan 2021 10:13:12 +0100
Pierre Morel <pmorel@linux.ibm.com> wrote:

> We want the tests to automatically work with or without protected
> virtualisation.
> To do this we need to share the I/O memory with the host.
> 
> Let's replace all static allocations with dynamic allocations
> to clearly separate shared and private memory.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>  lib/s390x/css.h     |  3 +--
>  lib/s390x/css_lib.c | 28 ++++++++--------------------
>  s390x/css.c         | 43 +++++++++++++++++++++++++++++++------------
>  3 files changed, 40 insertions(+), 34 deletions(-)
> 

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
