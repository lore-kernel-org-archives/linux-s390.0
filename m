Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51387 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726951AbhAMLGe (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 13 Jan 2021 06:06:34 -0500
Date: Wed, 13 Jan 2021 12:04:57 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [kvm-unit-tests PATCH v4 4/9] s390x: Split assembly into
 multiple files
Message-ID: <20210113120457.3cb9680b.cohuck@redhat.com>
In-Reply-To: <20210112132054.49756-5-frankja@linux.ibm.com>
References: <20210112132054.49756-1-frankja@linux.ibm.com>
        <20210112132054.49756-5-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>
Cc: kvm@vger.kernel.org, thuth@redhat.com, david@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com, linux-s390@vger.kernel.org

On Tue, 12 Jan 2021 08:20:49 -0500
Janosch Frank <frankja@linux.ibm.com> wrote:

> I've added too much to cstart64.S which is not start related
> already. Now that I want to add even more code it's time to split
> cstart64.S. lib.S has functions that are used in tests. macros.S
> contains macros which are used in cstart64.S and lib.S
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Acked-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> ---
>  s390x/Makefile   |   6 +--
>  s390x/cstart64.S | 119 ++---------------------------------------------
>  s390x/lib.S      |  65 ++++++++++++++++++++++++++
>  s390x/macros.S   |  77 ++++++++++++++++++++++++++++++
>  4 files changed, 149 insertions(+), 118 deletions(-)
>  create mode 100644 s390x/lib.S
>  create mode 100644 s390x/macros.S

Acked-by: Cornelia Huck <cohuck@redhat.com>
