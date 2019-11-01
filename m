Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:1580 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725904AbfKAL2l (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 1 Nov 2019 07:28:41 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xA1BSeEm104564
        for <linux-s390@vger.kernel.org>; Fri, 1 Nov 2019 07:28:40 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w050y8c9j-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 01 Nov 2019 07:28:39 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Fri, 1 Nov 2019 11:26:38 -0000
Subject: Re: [RFC 06/37] s390: UV: Add import and export to UV library
References: <20191024114059.102802-1-frankja@linux.ibm.com>
 <20191024114059.102802-7-frankja@linux.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 1 Nov 2019 12:26:33 +0100
MIME-Version: 1.0
In-Reply-To: <20191024114059.102802-7-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <b7126f40-ff10-0123-4c5e-37f57d63c3cd@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com, david@redhat.com, imbrenda@linux.ibm.com, mihajlov@linux.ibm.com, mimu@linux.ibm.com, cohuck@redhat.com, gor@linux.ibm.com



On 24.10.19 13:40, Janosch Frank wrote:
> The convert to/from secure (or also "import/export") ultravisor calls
> are need for page management, i.e. paging, of secure execution VM.
> 
> Export encrypts a secure guest's page and makes it accessible to the
> guest for paging.
> 
> Import makes a page accessible to a secure guest.
> On the first import of that page, the page will be cleared by the
> Ultravisor before it is given to the guest.
> 
> All following imports will decrypt a exported page and verify
> integrity before giving the page to the guest.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  arch/s390/include/asm/uv.h | 51 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
> 
> diff --git a/arch/s390/include/asm/uv.h b/arch/s390/include/asm/uv.h
> index 0bfbafcca136..99cdd2034503 100644
> --- a/arch/s390/include/asm/uv.h
> +++ b/arch/s390/include/asm/uv.h
> @@ -15,6 +15,7 @@
>  #include <linux/errno.h>
>  #include <linux/bug.h>
>  #include <asm/page.h>
> +#include <asm/gmap.h>
>  
>  #define UVC_RC_EXECUTED		0x0001
>  #define UVC_RC_INV_CMD		0x0002
> @@ -279,6 +280,54 @@ static inline int uv_cmd_nodata(u64 handle, u16 cmd, u32 *ret)
>  	return rc ? -EINVAL : 0;
>  }
>  
> +/*
> + * Requests the Ultravisor to encrypt a guest page and make it
> + * accessible to the host for paging (export).
> + *
> + * @paddr: Absolute host address of page to be exported
> + */
> +static inline int uv_convert_from_secure(unsigned long paddr)
> +{
> +	struct uv_cb_cfs uvcb = {
> +		.header.cmd = UVC_CMD_CONV_FROM_SEC_STOR,
> +		.header.len = sizeof(uvcb),
> +		.paddr = paddr
> +	};
> +	if (!uv_call(0, (u64)&uvcb))
> +		return 0;

As discussed on the KVM forum. We should also check for
uvcb.header.rc != UVC_RC_EXECUTED
I know, we cant really do much if this fails, but we certainly want to know.






> +	return -EINVAL;
> +}
> +
> +/*
> + * Requests the Ultravisor to make a page accessible to a guest
> + * (import). If it's brought in the first time, it will be cleared. If
> + * it has been exported before, it will be decrypted and integrity
> + * checked.
> + *
> + * @handle: Ultravisor guest handle
> + * @gaddr: Guest 2 absolute address to be imported
> + */
> +static inline int uv_convert_to_secure(struct gmap *gmap, unsigned long gaddr)
> +{
> +	int cc;
> +	struct uv_cb_cts uvcb = {
> +		.header.cmd = UVC_CMD_CONV_TO_SEC_STOR,
> +		.header.len = sizeof(uvcb),
> +		.guest_handle = gmap->se_handle,
> +		.gaddr = gaddr
> +	};
> +
> +	cc = uv_call(0, (u64)&uvcb);
> +
> +	if (!cc)
> +		return 0;
> +	if (uvcb.header.rc == 0x104)
> +		return -EEXIST;
> +	if (uvcb.header.rc == 0x10a)
> +		return -EFAULT;

again, we should probably check for rc != UVC_RC_EXECUTED to detect any other problem.

> +	return -EINVAL;
> +}
> +
>  void setup_uv(void);
>  void adjust_to_uv_max(unsigned long *vmax);
>  #else
> @@ -286,6 +335,8 @@ void adjust_to_uv_max(unsigned long *vmax);
>  static inline void setup_uv(void) {}
>  static inline void adjust_to_uv_max(unsigned long *vmax) {}
>  static inline int uv_cmd_nodata(u64 handle, u16 cmd, u32 *ret) { return 0; }
> +static inline int uv_convert_from_secure(unsigned long paddr) { return 0; }
> +static inline int uv_convert_to_secure(unsigned long handle, unsigned long gaddr) { return 0; }
>  #endif
>  
>  #if defined(CONFIG_PROTECTED_VIRTUALIZATION_GUEST) ||                          \
> 
