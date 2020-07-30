Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:25439 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726367AbgG3LR6 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 30 Jul 2020 07:17:58 -0400
Date: Thu, 30 Jul 2020 13:16:17 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [kvm-unit-tests PATCH v2 3/3] s390x: Ultravisor guest API test
Message-ID: <20200730131617.7f7d5e5f.cohuck@redhat.com>
In-Reply-To: <20200727095415.494318-4-frankja@linux.ibm.com>
References: <20200727095415.494318-1-frankja@linux.ibm.com>
        <20200727095415.494318-4-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>
Cc: kvm@vger.kernel.org, thuth@redhat.com, linux-s390@vger.kernel.org, david@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com

On Mon, 27 Jul 2020 05:54:15 -0400
Janosch Frank <frankja@linux.ibm.com> wrote:

> Test the error conditions of guest 2 Ultravisor calls, namely:
>      * Query Ultravisor information
>      * Set shared access
>      * Remove shared access
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> ---
>  lib/s390x/asm/uv.h  |  68 +++++++++++++++++++
>  s390x/Makefile      |   1 +
>  s390x/unittests.cfg |   3 +
>  s390x/uv-guest.c    | 159 ++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 231 insertions(+)
>  create mode 100644 lib/s390x/asm/uv.h
>  create mode 100644 s390x/uv-guest.c
> 

(...)

> +static inline int uv_call(unsigned long r1, unsigned long r2)
> +{
> +	int cc;
> +
> +	asm volatile(
> +		"0:	.insn rrf,0xB9A40000,%[r1],%[r2],0,0\n"
> +		"		brc	3,0b\n"
> +		"		ipm	%[cc]\n"
> +		"		srl	%[cc],28\n"
> +		: [cc] "=d" (cc)
> +		: [r1] "a" (r1), [r2] "a" (r2)
> +		: "memory", "cc");
> +	return cc;
> +}

This returns the condition code, but no caller seems to check it
(instead, they look at header.rc, which is presumably only set if the
instruction executed successfully in some way?)

Looking at the kernel, it retries for cc > 1 (presumably busy
conditions), and cc != 0 seems to be considered a failure. Do we want
to look at the cc here as well?

(...)
