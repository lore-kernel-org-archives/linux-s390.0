Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:21271 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727330AbgCXMVU (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 24 Mar 2020 08:21:20 -0400
Date: Tue, 24 Mar 2020 13:21:10 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [kvm-unit-tests PATCH 05/10] s390x: smp: Loop if secondary cpu
 returns into cpu setup again
Message-ID: <20200324132110.676c6f92.cohuck@redhat.com>
In-Reply-To: <20200324081251.28810-6-frankja@linux.ibm.com>
References: <20200324081251.28810-1-frankja@linux.ibm.com>
        <20200324081251.28810-6-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>
Cc: kvm@vger.kernel.org, thuth@redhat.com, linux-s390@vger.kernel.org, david@redhat.com

On Tue, 24 Mar 2020 04:12:46 -0400
Janosch Frank <frankja@linux.ibm.com> wrote:

> Up to now a secondary cpu could have returned from the function it was
> executing and ending up somewhere in cstart64.S. This was mostly
> circumvented by an endless loop in the function that it executed.
> 
> Let's add a loop to the end of the cpu setup, so we don't have to rely
> on added loops in the tests.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  s390x/cstart64.S | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
