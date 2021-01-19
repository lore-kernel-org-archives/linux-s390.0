Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29581 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730175AbhASQaM (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 19 Jan 2021 11:30:12 -0500
Date: Tue, 19 Jan 2021 17:28:30 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [kvm-unit-tests PATCH v2] s390x: Fix uv_call() exception
 behavior
Message-ID: <20210119172754.6eefa4da.cohuck@redhat.com>
In-Reply-To: <20210118150922.5229-1-frankja@linux.ibm.com>
References: <20210118140344.3074-1-frankja@linux.ibm.com>
        <20210118150922.5229-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>
Cc: thuth@redhat.com, david@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com, linux-s390@vger.kernel.org

On Mon, 18 Jan 2021 10:09:22 -0500
Janosch Frank <frankja@linux.ibm.com> wrote:

> On a program exception we usually skip the instruction that caused the
> exception and continue. That won't work for UV calls since a "brc
> 3,0b" will retry the instruction if the CC is > 1. Let's forgo the brc
> when checking for privilege exceptions and use a uv_call_once().
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Suggested-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> 
> ---
>  lib/s390x/asm/uv.h | 24 ++++++++++++++++--------
>  s390x/uv-guest.c   |  6 +++---
>  2 files changed, 19 insertions(+), 11 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
