Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([193.142.43.55]:44394 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbfGLQKE (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 12 Jul 2019 12:10:04 -0400
Date: Fri, 12 Jul 2019 18:09:57 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 2/3] DMA mapping: Move SME handling to x86-specific
 files
In-Reply-To: <20190712053631.9814-3-bauerman@linux.ibm.com>
Message-ID: <alpine.DEB.2.21.1907121806160.1788@nanos.tec.linutronix.de>
References: <20190712053631.9814-1-bauerman@linux.ibm.com> <20190712053631.9814-3-bauerman@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Cc: x86@kernel.org, iommu@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Alexey Dobriyan <adobriyan@gmail.com>, Halil Pasic <pasic@linux.ibm.com>, Mike Anderson <andmike@linux.ibm.com>, Ram Pai <linuxram@us.ibm.com>

On Fri, 12 Jul 2019, Thiago Jung Bauermann wrote:
> diff --git a/include/linux/mem_encrypt.h b/include/linux/mem_encrypt.h
> index b310a9c18113..f2e399fb626b 100644
> --- a/include/linux/mem_encrypt.h
> +++ b/include/linux/mem_encrypt.h
> @@ -21,23 +21,11 @@
>  
>  #else	/* !CONFIG_ARCH_HAS_MEM_ENCRYPT */
>  
> -#define sme_me_mask	0ULL
> -
> -static inline bool sme_active(void) { return false; }
>  static inline bool sev_active(void) { return false; }

You want to move out sev_active as well, the only relevant thing is
mem_encrypt_active(). Everything SME/SEV is an architecture detail.

> +static inline bool mem_encrypt_active(void) { return false; }

Thanks,

	tglx
