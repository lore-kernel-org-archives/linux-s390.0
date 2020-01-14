Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:41674 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726053AbgANRoV (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 14 Jan 2020 12:44:21 -0500
Date: Tue, 14 Jan 2020 18:44:11 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [kvm-unit-tests PATCH 2/4] s390x: smp: Only use smp_cpu_setup
 once
Message-ID: <20200114184411.24909aae.cohuck@redhat.com>
In-Reply-To: <20200114153054.77082-3-frankja@linux.ibm.com>
References: <20200114153054.77082-1-frankja@linux.ibm.com>
        <20200114153054.77082-3-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>
Cc: kvm@vger.kernel.org, thuth@redhat.com, borntraeger@de.ibm.com, linux-s390@vger.kernel.org, david@redhat.com

On Tue, 14 Jan 2020 10:30:51 -0500
Janosch Frank <frankja@linux.ibm.com> wrote:

> Let's stop and start instead of using setup to run a function on a
> cpu.

Looking at the code, we only support active == operating state and
!active == stopped state anyway, right?

> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  s390x/smp.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
