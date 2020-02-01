Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53231 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726443AbgBATDf (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sat, 1 Feb 2020 14:03:35 -0500
Subject: Re: [kvm-unit-tests PATCH v5 6/7] s390x: smp: Rework cpu start and
 active tracking
References: <20200201152851.82867-1-frankja@linux.ibm.com>
 <20200201152851.82867-7-frankja@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <7497083b-ec32-2dfc-c3c8-783b564d00b4@redhat.com>
Date: Sat, 1 Feb 2020 20:03:23 +0100
MIME-Version: 1.0
In-Reply-To: <20200201152851.82867-7-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: borntraeger@de.ibm.com, linux-s390@vger.kernel.org, david@redhat.com, cohuck@redhat.com

On 01/02/2020 16.28, Janosch Frank wrote:
> The architecture specifies that processing sigp orders may be
> asynchronous, and this is indeed the case on some hypervisors, so we
> need to wait until the cpu runs before we return from the setup/start
> function.
> 
> As there was a lot of duplicate code, a common function for cpu
> restarts has been introduced.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  lib/s390x/smp.c | 56 ++++++++++++++++++++++++++++++-------------------
>  1 file changed, 35 insertions(+), 21 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>
