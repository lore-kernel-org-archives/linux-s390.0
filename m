Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43243 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726669AbgANRcT (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 14 Jan 2020 12:32:19 -0500
Date: Tue, 14 Jan 2020 18:32:11 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [kvm-unit-tests PATCH 1/4] s390x: smp: Cleanup smp.c
Message-ID: <20200114183211.617ecb7e.cohuck@redhat.com>
In-Reply-To: <20200114153054.77082-2-frankja@linux.ibm.com>
References: <20200114153054.77082-1-frankja@linux.ibm.com>
        <20200114153054.77082-2-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>
Cc: kvm@vger.kernel.org, thuth@redhat.com, borntraeger@de.ibm.com, linux-s390@vger.kernel.org, david@redhat.com

On Tue, 14 Jan 2020 10:30:50 -0500
Janosch Frank <frankja@linux.ibm.com> wrote:

> Let's remove a lot of badly formatted code by introducing the
> wait_for_flag() function.
> 
> Also let's remove some stray spaces.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  s390x/smp.c | 41 +++++++++++++++++++++++------------------
>  1 file changed, 23 insertions(+), 18 deletions(-)

This looks like some nice copy/paste had been going on :)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
