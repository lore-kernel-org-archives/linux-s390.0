Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57935 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727744AbhAMLNl (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 13 Jan 2021 06:13:41 -0500
Date: Wed, 13 Jan 2021 12:12:02 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [kvm-unit-tests PATCH v4 7/9] s390x: Add diag318 intercept test
Message-ID: <20210113121202.3ca9b201.cohuck@redhat.com>
In-Reply-To: <20210112132054.49756-8-frankja@linux.ibm.com>
References: <20210112132054.49756-1-frankja@linux.ibm.com>
        <20210112132054.49756-8-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>
Cc: kvm@vger.kernel.org, thuth@redhat.com, david@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com, linux-s390@vger.kernel.org

On Tue, 12 Jan 2021 08:20:52 -0500
Janosch Frank <frankja@linux.ibm.com> wrote:

> Not much to test except for the privilege and specification
> exceptions.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> ---
>  lib/s390x/sclp.c  |  1 +
>  lib/s390x/sclp.h  |  6 +++++-
>  s390x/intercept.c | 19 +++++++++++++++++++
>  3 files changed, 25 insertions(+), 1 deletion(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
