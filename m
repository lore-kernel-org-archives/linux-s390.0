Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57770 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2391579AbfJPIZ3 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 16 Oct 2019 04:25:29 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9G88kZ1062718
        for <linux-s390@vger.kernel.org>; Wed, 16 Oct 2019 04:25:28 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2vnxnnadjs-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 16 Oct 2019 04:25:28 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Wed, 16 Oct 2019 09:25:26 +0100
Date: Wed, 16 Oct 2019 10:25:16 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH v2 06/29] s390: Move RO_DATA into "text" PT_LOAD Program
 Header
References: <20191011000609.29728-1-keescook@chromium.org>
 <20191011000609.29728-7-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191011000609.29728-7-keescook@chromium.org>
Message-Id: <20191016082516.GB4267@osiris>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Borislav Petkov <bp@alien8.de>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Michael Ellerman <mpe@ellerman.id.au>, Will Deacon <will@kernel.org>, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-alpha@vger.kernel.org, linux-ia64@vger.kernel.org, linux-s390@vger.kernel.org, linux-c6x-dev@linux-c6x.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Michal Simek <monstr@monstr.eu>, linux-parisc@vger.kernel.org, linux-xtensa@linux-xtensa.org, x86@kernel.org, linux-kernel@vger.kernel.org

On Thu, Oct 10, 2019 at 05:05:46PM -0700, Kees Cook wrote:
> In preparation for moving NOTES into RO_DATA, move RO_DATA back into the
> "text" PT_LOAD Program Header, as done with other architectures. The
> "data" PT_LOAD now starts with the writable data section.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  arch/s390/kernel/vmlinux.lds.S | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/s390/kernel/vmlinux.lds.S b/arch/s390/kernel/vmlinux.lds.S
> index 7e0eb4020917..13294fef473e 100644
> --- a/arch/s390/kernel/vmlinux.lds.S
> +++ b/arch/s390/kernel/vmlinux.lds.S
> @@ -52,7 +52,7 @@ SECTIONS
> 
>  	NOTES :text :note
> 
> -	.dummy : { *(.dummy) } :data
> +	.dummy : { *(.dummy) } :text
> 
>  	RO_DATA_SECTION(PAGE_SIZE)
> 
> @@ -64,7 +64,7 @@ SECTIONS
>  	.data..ro_after_init : {
>  		 *(.data..ro_after_init)
>  		JUMP_TABLE_DATA
> -	}
> +	} :data
>  	EXCEPTION_TABLE(16)
>  	. = ALIGN(PAGE_SIZE);
>  	__end_ro_after_init = .;

Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>
