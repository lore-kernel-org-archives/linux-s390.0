Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:57284 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727238AbgCXMHA (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 24 Mar 2020 08:07:00 -0400
Date: Tue, 24 Mar 2020 13:06:48 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [kvm-unit-tests PATCH 04/10] s390x: smp: Test local interrupts
 after cpu reset
Message-ID: <20200324130648.4d973757.cohuck@redhat.com>
In-Reply-To: <20200324081251.28810-5-frankja@linux.ibm.com>
References: <20200324081251.28810-1-frankja@linux.ibm.com>
        <20200324081251.28810-5-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>
Cc: kvm@vger.kernel.org, thuth@redhat.com, linux-s390@vger.kernel.org, david@redhat.com

On Tue, 24 Mar 2020 04:12:45 -0400
Janosch Frank <frankja@linux.ibm.com> wrote:

> Local interrupts (external and emergency call) should be cleared after
> any cpu reset.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  s390x/smp.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
