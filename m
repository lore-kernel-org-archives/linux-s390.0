Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27181 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726858AbhAMLEe (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 13 Jan 2021 06:04:34 -0500
Date: Wed, 13 Jan 2021 12:02:55 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [kvm-unit-tests PATCH v4 3/9] s390x: SCLP feature checking
Message-ID: <20210113120255.7bca1b02.cohuck@redhat.com>
In-Reply-To: <20210112132054.49756-4-frankja@linux.ibm.com>
References: <20210112132054.49756-1-frankja@linux.ibm.com>
        <20210112132054.49756-4-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>
Cc: kvm@vger.kernel.org, thuth@redhat.com, david@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com, linux-s390@vger.kernel.org

On Tue, 12 Jan 2021 08:20:48 -0500
Janosch Frank <frankja@linux.ibm.com> wrote:

> Availability of SIE is announced via a feature bit in a SCLP info CPU
> entry. Let's add a framework that allows us to easily check for such
> facilities.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> ---
>  lib/s390x/io.c   |  1 +
>  lib/s390x/sclp.c | 25 +++++++++++++++++++++++++
>  lib/s390x/sclp.h | 13 ++++++++++++-
>  3 files changed, 38 insertions(+), 1 deletion(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
