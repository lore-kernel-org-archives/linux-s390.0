Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:24718 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726265AbgANPkJ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 14 Jan 2020 10:40:09 -0500
Subject: Re: [kvm-unit-tests PATCH 1/4] s390x: smp: Cleanup smp.c
References: <20200114153054.77082-1-frankja@linux.ibm.com>
 <20200114153054.77082-2-frankja@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <92df9483-35a4-9276-603c-da4135bd31fe@redhat.com>
Date: Tue, 14 Jan 2020 16:39:58 +0100
MIME-Version: 1.0
In-Reply-To: <20200114153054.77082-2-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: borntraeger@de.ibm.com, linux-s390@vger.kernel.org, david@redhat.com, cohuck@redhat.com

On 14/01/2020 16.30, Janosch Frank wrote:
> Let's remove a lot of badly formatted code by introducing the
> wait_for_flag() function.
> 
> Also let's remove some stray spaces.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  s390x/smp.c | 41 +++++++++++++++++++++++------------------
>  1 file changed, 23 insertions(+), 18 deletions(-)

OMG, did I really merge that original code in that shape?

Reviewed-by: Thomas Huth <thuth@redhat.com>
