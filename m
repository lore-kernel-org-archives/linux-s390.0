Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:43728 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727508AbgAUOaS (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 21 Jan 2020 09:30:18 -0500
Date: Tue, 21 Jan 2020 15:30:01 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [kvm-unit-tests PATCH v4 7/9] s390x: smp: Remove unneeded cpu
 loops
Message-ID: <20200121153001.2354b787.cohuck@redhat.com>
In-Reply-To: <20200121134254.4570-8-frankja@linux.ibm.com>
References: <20200121134254.4570-1-frankja@linux.ibm.com>
        <20200121134254.4570-8-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>
Cc: kvm@vger.kernel.org, thuth@redhat.com, borntraeger@de.ibm.com, linux-s390@vger.kernel.org, david@redhat.com

On Tue, 21 Jan 2020 08:42:52 -0500
Janosch Frank <frankja@linux.ibm.com> wrote:

> Now that we have a loop which is executed after we return from the
> main function of a secondary cpu, we can remove the surplus loops.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  s390x/smp.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
