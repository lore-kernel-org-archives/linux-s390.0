Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:30487 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727368AbgCXMEd (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 24 Mar 2020 08:04:33 -0400
Date: Tue, 24 Mar 2020 13:04:21 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [kvm-unit-tests PATCH 03/10] s390x: smp: Test stop and store
 status on a running and stopped cpu
Message-ID: <20200324130421.59073da7.cohuck@redhat.com>
In-Reply-To: <20200324081251.28810-4-frankja@linux.ibm.com>
References: <20200324081251.28810-1-frankja@linux.ibm.com>
        <20200324081251.28810-4-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>
Cc: kvm@vger.kernel.org, thuth@redhat.com, linux-s390@vger.kernel.org, david@redhat.com

On Tue, 24 Mar 2020 04:12:44 -0400
Janosch Frank <frankja@linux.ibm.com> wrote:

> Let's also test the stop portion of the "stop and store status" sigp
> order.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  s390x/smp.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
