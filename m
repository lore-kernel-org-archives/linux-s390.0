Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:33899 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726465AbgATLEZ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 20 Jan 2020 06:04:25 -0500
Date: Mon, 20 Jan 2020 12:04:13 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [kvm-unit-tests PATCH v3 5/9] s390x: smp: Wait for cpu setup to
 finish
Message-ID: <20200120120413.48b6703a.cohuck@redhat.com>
In-Reply-To: <20200117104640.1983-6-frankja@linux.ibm.com>
References: <20200117104640.1983-1-frankja@linux.ibm.com>
        <20200117104640.1983-6-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>
Cc: kvm@vger.kernel.org, thuth@redhat.com, borntraeger@de.ibm.com, linux-s390@vger.kernel.org, david@redhat.com

On Fri, 17 Jan 2020 05:46:36 -0500
Janosch Frank <frankja@linux.ibm.com> wrote:

> We store the user provided psw address into restart new, so a psw
> restart does not lead us through setup again.
> 
> Also we wait on smp_cpu_setup() until the cpu has finished setup
> before returning. This is necessary for z/VM and LPAR where sigp is
> asynchronous.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> ---
>  lib/s390x/smp.c  | 2 ++
>  s390x/cstart64.S | 2 ++
>  2 files changed, 4 insertions(+)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
