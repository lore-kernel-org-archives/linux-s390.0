Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44710 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727925AbhAVNeM (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 22 Jan 2021 08:34:12 -0500
Subject: Re: [kvm-unit-tests PATCH v5 1/3] s390x: pv: implement routine to
 share/unshare memory
References: <1611322060-1972-1-git-send-email-pmorel@linux.ibm.com>
 <1611322060-1972-2-git-send-email-pmorel@linux.ibm.com>
From: Janosch Frank <frankja@linux.ibm.com>
Message-ID: <9c488fa9-9b65-ea7f-124e-f9468dc05a54@linux.ibm.com>
Date: Fri, 22 Jan 2021 14:33:00 +0100
MIME-Version: 1.0
In-Reply-To: <1611322060-1972-2-git-send-email-pmorel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, thuth@redhat.com, cohuck@redhat.com, imbrenda@linux.ibm.com, drjones@redhat.com, pbonzini@redhat.com

On 1/22/21 2:27 PM, Pierre Morel wrote:
> When communicating with the host we need to share part of
> the memory.
> 
> Let's implement the ultravisor calls for this.

Reviewed-by: Janosch Frank <frankja@linux.ibm.com>

> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> Suggested-by: Janosch Frank <frankja@linux.ibm.com>
> Acked-by: Cornelia Huck <cohuck@redhat.com>
> Acked-by: Thomas Huth <thuth@redhat.com>
> ---
>  lib/s390x/asm/uv.h | 39 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/lib/s390x/asm/uv.h b/lib/s390x/asm/uv.h
> index 39d2dc0..9c49184 100644
> --- a/lib/s390x/asm/uv.h
> +++ b/lib/s390x/asm/uv.h
> @@ -79,4 +79,43 @@ static inline int uv_call(unsigned long r1, unsigned long r2)
>  	return cc;
>  }
>  
> +static inline int share(unsigned long addr, u16 cmd)
> +{
> +	struct uv_cb_share uvcb = {
> +		.header.cmd = cmd,
> +		.header.len = sizeof(uvcb),
> +		.paddr = addr
> +	};
> +	int cc;
> +
> +	cc = uv_call(0, (u64)&uvcb);
> +	if (!cc && uvcb.header.rc == UVC_RC_EXECUTED)
> +		return 0;
> +
> +	report_info("uv_call: cmd %04x cc %d response code: %04x", cc, cmd,
> +		    uvcb.header.rc);
> +	return -1;
> +}
> +
> +/*
> + * Guest 2 request to the Ultravisor to make a page shared with the
> + * hypervisor for IO.
> + *
> + * @addr: Real or absolute address of the page to be shared
> + */
> +static inline int uv_set_shared(unsigned long addr)
> +{
> +	return share(addr, UVC_CMD_SET_SHARED_ACCESS);
> +}
> +
> +/*
> + * Guest 2 request to the Ultravisor to make a page unshared.
> + *
> + * @addr: Real or absolute address of the page to be unshared
> + */
> +static inline int uv_remove_shared(unsigned long addr)
> +{
> +	return share(addr, UVC_CMD_REMOVE_SHARED_ACCESS);
> +}
> +
>  #endif
> 
