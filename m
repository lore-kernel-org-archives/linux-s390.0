Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:49536 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727379AbgCXMpp (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 24 Mar 2020 08:45:45 -0400
Date: Tue, 24 Mar 2020 13:45:19 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [kvm-unit-tests PATCH 09/10] s390x: smp: Add restart when
 running test
Message-ID: <20200324134519.50664590.cohuck@redhat.com>
In-Reply-To: <20200324081251.28810-10-frankja@linux.ibm.com>
References: <20200324081251.28810-1-frankja@linux.ibm.com>
        <20200324081251.28810-10-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>
Cc: kvm@vger.kernel.org, thuth@redhat.com, linux-s390@vger.kernel.org, david@redhat.com

On Tue, 24 Mar 2020 04:12:50 -0400
Janosch Frank <frankja@linux.ibm.com> wrote:

> Let's make sure we can restart a cpu that is already running.
> Restarting it if it is stopped is implicitely tested by the the other
> restart calls in the smp test.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  s390x/smp.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
