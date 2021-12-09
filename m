Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A80F1C433F5
	for <linux-s390@archiver.kernel.org>; Thu,  9 Dec 2021 11:01:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235224AbhLILFZ (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 9 Dec 2021 06:05:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:41245 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232838AbhLILFY (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 9 Dec 2021 06:05:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639047711;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Kzd9PIsUvRXEnSOefxkW/5TD40E4pw42qIqKNJVRCXY=;
        b=KNPuCzYSZtFC91Qff+NivcbG+YW96vDl9+nHkrNkAQfTSh27emuSa7qc3uk9xyzHiKDx5q
        lvRS4Q02tuNgIjGDpv0a8qyNtZdSiIxCURWp4tyaezf576l6NLAd2rouc4DKewpceLvZOJ
        QRgHr/SstwkPOBfQM0DMoEUeOl/HBwE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-33-S8OBx5-8OFiLju2eeAJm2Q-1; Thu, 09 Dec 2021 06:01:50 -0500
X-MC-Unique: S8OBx5-8OFiLju2eeAJm2Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3C90492500;
        Thu,  9 Dec 2021 11:01:49 +0000 (UTC)
Received: from rhtmp (unknown [10.39.193.178])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2F85B60BF1;
        Thu,  9 Dec 2021 11:01:44 +0000 (UTC)
Date:   Thu, 9 Dec 2021 12:01:42 +0100
From:   Philipp Rudo <prudo@redhat.com>
To:     Alexander Egorenkov <egorenar@linux.ibm.com>
Cc:     ltao@redhat.com, hca@linux.ibm.com, linux-s390@vger.kernel.org
Subject: Re: [PATCH v2 1/1] s390/kexec: handle R_390_PLT32DBL rela in
 arch_kexec_apply_relocations_add()
Message-ID: <20211209120142.60642497@rhtmp>
In-Reply-To: <20211209073817.82196-1-egorenar@linux.ibm.com>
References: <20211209073817.82196-1-egorenar@linux.ibm.com>
Organization: Red Hat inc.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu,  9 Dec 2021 08:38:17 +0100
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

Thanks!

Reviewed-by: Philipp Rudo <prudo@redhat.com>

> ---
> Changes since v1:
> =================
> * Alternative version of the fix but this time in arch_kexec_apply_relocations_add()
>   in order not to force every user of arch_kexec_do_relocs() to handle R_390_PC32DBL
>   and avoid breaking other users with unexpected bhavior 
> 
>  arch/s390/kernel/machine_kexec_file.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/s390/kernel/machine_kexec_file.c b/arch/s390/kernel/machine_kexec_file.c
> index 876cdd3c994e..8f43575a4dd3 100644
> --- a/arch/s390/kernel/machine_kexec_file.c
> +++ b/arch/s390/kernel/machine_kexec_file.c
> @@ -348,6 +348,10 @@ int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
>  		addr = section->sh_addr + relas[i].r_offset;
>  
>  		r_type = ELF64_R_TYPE(relas[i].r_info);
> +
> +		if (r_type == R_390_PLT32DBL)
> +			r_type = R_390_PC32DBL;
> +
>  		ret = arch_kexec_do_relocs(r_type, loc, val, addr);
>  		if (ret) {
>  			pr_err("Unknown rela relocation: %d\n", r_type);

