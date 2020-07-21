Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:32019 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbgGUHhC (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 21 Jul 2020 03:37:02 -0400
Subject: Re: [kvm-unit-tests PATCH v2] s390x: Ultavisor guest API test
References: <20200717145813.62573-4-frankja@linux.ibm.com>
 <20200720133559.69898-1-frankja@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <73b1afb9-b4ce-7e1b-a8d2-15b642dea803@redhat.com>
Date: Tue, 21 Jul 2020 09:36:52 +0200
MIME-Version: 1.0
In-Reply-To: <20200720133559.69898-1-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, borntraeger@de.ibm.com, cohuck@redhat.com, imbrenda@linux.ibm.com

On 20/07/2020 15.35, Janosch Frank wrote:
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
>  s390x/uv-guest.c    | 158 ++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 230 insertions(+)
>  create mode 100644 lib/s390x/asm/uv.h
>  create mode 100644 s390x/uv-guest.c
[...]
> +int main(void)
> +{
> +	bool has_uvc = test_facility(158);
> +
> +	report_prefix_push("uvc");
> +	if (!has_uvc) {
> +		report_skip("Ultravisor call facility is not available");
> +		goto done;
> +	}
> +
> +	page = (unsigned long)alloc_page();
> +	test_priv();
> +	test_invalid();
> +	test_query();
> +	test_sharing();
> +	free_page((void *)page);
> +done:

It likely does not matter much, but for cleanliness, please add a
report_prefix_pop() here.

> +	return report_summary();
> +}
> 

 Thomas
