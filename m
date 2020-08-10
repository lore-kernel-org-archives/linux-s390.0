Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48267 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725862AbgHJPu2 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 10 Aug 2020 11:50:28 -0400
Date: Mon, 10 Aug 2020 17:50:15 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [kvm-unit-tests PATCH v3] s390x: Ultravisor guest API test
Message-ID: <20200810175015.23b7fcf7.cohuck@redhat.com>
In-Reply-To: <20200810154541.32974-1-frankja@linux.ibm.com>
References: <20200810173205.2daaaca1.cohuck@redhat.com>
        <20200810154541.32974-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>
Cc: kvm@vger.kernel.org, thuth@redhat.com, linux-s390@vger.kernel.org, david@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com

On Mon, 10 Aug 2020 11:45:41 -0400
Janosch Frank <frankja@linux.ibm.com> wrote:

> Test the error conditions of guest 2 Ultravisor calls, namely:
>      * Query Ultravisor information
>      * Set shared access
>      * Remove shared access
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Acked-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  lib/s390x/asm/uv.h  |  74 ++++++++++++++++++++++
>  s390x/Makefile      |   1 +
>  s390x/unittests.cfg |   3 +
>  s390x/uv-guest.c    | 150 ++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 228 insertions(+)
>  create mode 100644 lib/s390x/asm/uv.h
>  create mode 100644 s390x/uv-guest.c

Acked-by: Cornelia Huck <cohuck@redhat.com>
