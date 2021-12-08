Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F62C433F5
	for <linux-s390@archiver.kernel.org>; Wed,  8 Dec 2021 13:59:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234556AbhLHODO (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 8 Dec 2021 09:03:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47859 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234516AbhLHODO (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 8 Dec 2021 09:03:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638971982;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o13cHTr7ShYSjw5GbRGiZQNW/00wuyCe5hY1X5W0vbE=;
        b=MVLjM2zFOdITgsVaxqUUm2Tx7Ted7sXs7lLxiyZqeis9MvZmLBJgrUKn+NHsvXq7STvmLQ
        JooSTUuapY2bwvJ5CVt7CSqd0HbquFN0HkfHLL7OBmtpVGonf+3Fk4liEl9MIr16zyq/74
        l4XmXrOKJN0FPVCR5pMkvgqx0RAKlhk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-326-NV83gC40NraTf5refpDIjw-1; Wed, 08 Dec 2021 08:59:38 -0500
X-MC-Unique: NV83gC40NraTf5refpDIjw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 058FB801AAB;
        Wed,  8 Dec 2021 13:59:38 +0000 (UTC)
Received: from rhtmp (unknown [10.39.193.91])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 089B9694BF;
        Wed,  8 Dec 2021 13:59:36 +0000 (UTC)
Date:   Wed, 8 Dec 2021 14:59:30 +0100
From:   Philipp Rudo <prudo@redhat.com>
To:     Alexander Egorenkov <egorenar@linux.ibm.com>
Cc:     ltao@redhat.com, hca@linux.ibm.com, linux-s390@vger.kernel.org
Subject: Re: [PATCH 1/1] s390/kexec: handle R_390_PLT32DBL reloc entries in
 arch_kexec_do_relocs()
Message-ID: <20211208145930.1ab4ce50@rhtmp>
In-Reply-To: <20211208105801.188140-1-egorenar@linux.ibm.com>
References: <20211208105801.188140-1-egorenar@linux.ibm.com>
Organization: Red Hat inc.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi Alexander,

thanks for taking care of this so fast!

My personal approach was slightly different (see below). The idea
behind this was that arch_kexec_do_relocs is also used by others which
might have a PLT. For them your approach would mean an ABI breakage. On
the other hand in case the other users have the same problem they would
need to handle it for themselves. Not sure what's the better approach.

Thanks
Philipp

--- a/arch/s390/kernel/machine_kexec_file.c
+++ b/arch/s390/kernel/machine_kexec_file.c
@@ -326,6 +326,10 @@ int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
                addr = section->sh_addr + relas[i].r_offset;
 
                r_type = ELF64_R_TYPE(relas[i].r_info);
+
+               if (r_type == R_390_PLT32DBL)
+                   r_type = R_390_PC32DBL;
+
                arch_kexec_do_relocs(r_type, loc, val, addr);
        }
        return 0;

On Wed,  8 Dec 2021 11:58:01 +0100
Alexander Egorenkov <egorenar@linux.ibm.com> wrote:

> Starting with gcc 11.3, the C compiler will generate PLT-relative function
> calls even if they are local and do not require it. Later on during linking,
> the linker will replace all PLT-relative calls to local functions with
> PC-relative ones. Unfortunately, the purgatory code of kexec/kdump is
> not being linked as a regular executable or shared library would have been,
> and therefore, all PLT-relative addresses remain in the generated purgatory
> object code unresolved. This leads to the situation where the purgatory
> code is being executed during kdump with all PLT-relative addresses
> unresolved. And this results in endless loops within the purgatory code.
> 
> Furthermore, the clang C compiler has always behaved like described above
> and this commit should fix kdump for kernels built with the latter.
> 
> Because the purgatory code is no regular executable or shared library,
> contains only calls to local functions and has no PLT, all R_390_PLT32DBL
> relocation entries can be resolved just like a R_390_PC32DBL one.
> 
> * https://refspecs.linuxfoundation.org/ELF/zSeries/lzsabi0_zSeries/x1633.html#AEN1699
> 
> Relocation entries of purgatory code generated with gcc 11.3
> ------------------------------------------------------------
> 
> $ readelf -r linux/arch/s390/purgatory/purgatory.o
> 
> Relocation section '.rela.text' at offset 0x370 contains 5 entries:
>   Offset          Info           Type           Sym. Value    Sym. Name + Addend
> 00000000005c  000c00000013 R_390_PC32DBL     0000000000000000 purgatory_sha_regions + 2
> 00000000007a  000d00000014 R_390_PLT32DBL    0000000000000000 sha256_update + 2
> 00000000008c  000e00000014 R_390_PLT32DBL    0000000000000000 sha256_final + 2
> 000000000092  000800000013 R_390_PC32DBL     0000000000000000 .LC0 + 2
> 0000000000a0  000f00000014 R_390_PLT32DBL    0000000000000000 memcmp + 2
> 
> Relocation entries of purgatory code generated with gcc 11.2
> ------------------------------------------------------------
> 
> $ readelf -r linux/arch/s390/purgatory/purgatory.o
> 
> Relocation section '.rela.text' at offset 0x368 contains 5 entries:
>   Offset          Info           Type           Sym. Value    Sym. Name + Addend
> 00000000005c  000c00000013 R_390_PC32DBL     0000000000000000 purgatory_sha_regions + 2
> 00000000007a  000d00000013 R_390_PC32DBL     0000000000000000 sha256_update + 2
> 00000000008c  000e00000013 R_390_PC32DBL     0000000000000000 sha256_final + 2
> 000000000092  000800000013 R_390_PC32DBL     0000000000000000 .LC0 + 2
> 0000000000a0  000f00000013 R_390_PC32DBL     0000000000000000 memcmp + 2
> 
> Signed-off-by: Alexander Egorenkov <egorenar@linux.ibm.com>
> Reported-by: Tao Liu <ltao@redhat.com>
> Suggested-by: Philipp Rudo <prudo@redhat.com>
> ---
>  arch/s390/kernel/machine_kexec_reloc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/s390/kernel/machine_kexec_reloc.c b/arch/s390/kernel/machine_kexec_reloc.c
> index b7182cec48dc..fea6fcae2270 100644
> --- a/arch/s390/kernel/machine_kexec_reloc.c
> +++ b/arch/s390/kernel/machine_kexec_reloc.c
> @@ -38,6 +38,7 @@ int arch_kexec_do_relocs(int r_type, void *loc, unsigned long val,
>  		*(u16 *)loc = (val - addr) >> 1;
>  		break;
>  	case R_390_PC32DBL:	/* PC relative 32 bit shifted by 1.  */
> +	case R_390_PLT32DBL:	/* 32 bit PC rel. PLT shifted by 1.  */
>  		*(u32 *)loc = (val - addr) >> 1;
>  		break;
>  	case R_390_PC32:	/* PC relative 32 bit.	*/

