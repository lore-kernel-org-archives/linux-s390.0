Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42380 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726589AbgATLoi (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 20 Jan 2020 06:44:38 -0500
Date: Mon, 20 Jan 2020 12:44:23 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [kvm-unit-tests PATCH v3 8/9] s390x: smp: Test all CRs on
 initial reset
Message-ID: <20200120124423.0994c108.cohuck@redhat.com>
In-Reply-To: <20200117104640.1983-9-frankja@linux.ibm.com>
References: <20200117104640.1983-1-frankja@linux.ibm.com>
        <20200117104640.1983-9-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>
Cc: kvm@vger.kernel.org, thuth@redhat.com, borntraeger@de.ibm.com, linux-s390@vger.kernel.org, david@redhat.com

On Fri, 17 Jan 2020 05:46:39 -0500
Janosch Frank <frankja@linux.ibm.com> wrote:

> All CRs are set to 0 and CRs 0 and 14 are set to pre-defined values,
> so we also need to test 1-13 and 15 for 0.
> 
> And while we're at it, let's also set some values to cr 1, 7 and 13, so
> we can actually be sure that they will be zeroed.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  s390x/smp.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
