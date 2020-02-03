Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:49326 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728001AbgBCLTe (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 3 Feb 2020 06:19:34 -0500
Date: Mon, 3 Feb 2020 12:19:21 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [kvm-unit-tests PATCH v5 3/7] s390x: Stop the cpu that is
 executing exit()
Message-ID: <20200203121921.2999fee9.cohuck@redhat.com>
In-Reply-To: <20200201152851.82867-4-frankja@linux.ibm.com>
References: <20200201152851.82867-1-frankja@linux.ibm.com>
        <20200201152851.82867-4-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>
Cc: kvm@vger.kernel.org, thuth@redhat.com, borntraeger@de.ibm.com, linux-s390@vger.kernel.org, david@redhat.com

On Sat,  1 Feb 2020 10:28:47 -0500
Janosch Frank <frankja@linux.ibm.com> wrote:

> CPU 0 is not necessarily the CPU which does the exit if we ran into a
> test abort situation. So, let's ask stap() which cpu does the exit and
> stop it on exit.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  lib/s390x/io.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
