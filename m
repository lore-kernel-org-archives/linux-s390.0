Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58D02C7EE2C
	for <linux-s390@archiver.kernel.org>; Mon,  8 May 2023 10:56:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235197AbjEHK4U (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 8 May 2023 06:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235285AbjEHKzO (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 8 May 2023 06:55:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D21E2945D
        for <linux-s390@vger.kernel.org>; Mon,  8 May 2023 03:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683543229;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I/QJdKr/BKvvG/1VBzKIP6fBILeWCCaqJgDwivgQuTk=;
        b=Y4AYh9kL1bMrlp9AxKazJzXwyM+KxAsaJoW2007xxNAqz4craSA/qGzUTAAvKFlfaoA0Ky
        yy7pjO2xzODmAZNJrSJbCSxiX03YBD4/6nUWPcsdoO8W1ZaVUI5+xFHRM3hPkrcvZXEWFD
        lUivWc8Ia4HiYY7LvGvZJmve9zqMfwI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-hbBkbU1fPTadK6QKLx6bqQ-1; Mon, 08 May 2023 06:53:48 -0400
X-MC-Unique: hbBkbU1fPTadK6QKLx6bqQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3f423d47945so3841335e9.0
        for <linux-s390@vger.kernel.org>; Mon, 08 May 2023 03:53:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683543226; x=1686135226;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I/QJdKr/BKvvG/1VBzKIP6fBILeWCCaqJgDwivgQuTk=;
        b=MhKBP5hh1RjEbtMx7nm+baTgN4SgBXale3N6zDgIqs7vlG9kVu4RP+GHdBPoblsxgs
         iNUj9LtlXb2un7anBjUmUqz8C00rPPJODp+tixlfcQmcLZRY+Z+seO960Z9f+UpzcYwB
         KKcrK4F1t44QvphHbJTvlWzynJ7NjTNdNqcc8pFYxIga+egR7zDjGfVHSGOHH2DGO9rt
         RYcxu6BjH95vZMBT/5aiKa7LWC73Bz5TxvdwgiOgkDv3Q3a1oL46/DPGY5Dbvof6gcho
         42BACQN2X0yIr7r3MWLtPfRZbe6pyB8XW3QQrtE0f+FGanzePTyESUeb/d0lKSxkq1cb
         +/cA==
X-Gm-Message-State: AC+VfDzi4KVzE9bzgdexKZ7VnCBoMP7WsYwwmzTVOOeSaP6vX9Zytp2l
        BzKbvW8mPwlF95TAQErk3lxxLu/snvR/3YO8YPCjy0usaKVcsQ4+KJUUV9srgi67SSCFB/lS7kW
        fZ9Zv9QBxVHA9vxfTkYlkxQ==
X-Received: by 2002:a05:600c:d2:b0:3f4:28db:f609 with SMTP id u18-20020a05600c00d200b003f428dbf609mr326422wmm.36.1683543225890;
        Mon, 08 May 2023 03:53:45 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6tCvqu2ay2+fTqUiqfANltk+6enlKtCK9i2F5odCrnPtYN0oBxuk0QKAiUX8r8vzmtWO/SMw==
X-Received: by 2002:a05:600c:d2:b0:3f4:28db:f609 with SMTP id u18-20020a05600c00d200b003f428dbf609mr326418wmm.36.1683543225648;
        Mon, 08 May 2023 03:53:45 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-43-179-212.web.vodafone.de. [109.43.179.212])
        by smtp.gmail.com with ESMTPSA id n9-20020a05600c294900b003f423508c6bsm4310248wmd.44.2023.05.08.03.53.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 03:53:45 -0700 (PDT)
Message-ID: <a4c02d73-d5d1-4587-5467-ee6a26d2c612@redhat.com>
Date:   Mon, 8 May 2023 12:53:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [kvm-unit-tests PATCH v1] lib: s390x: mmu: fix conflicting types
 for get_dat_entry
Content-Language: en-US
To:     Nico Boehr <nrb@linux.ibm.com>, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com
Cc:     kvm@vger.kernel.org, linux-s390@vger.kernel.org
References: <20230508102426.130768-1-nrb@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230508102426.130768-1-nrb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 08/05/2023 12.24, Nico Boehr wrote:
> This causes compilation to fail with GCC 13:
> 
> gcc -std=gnu99 -ffreestanding -I/kut/lib -I/kut/lib/s390x -Ilib -O2 -march=zEC12 -mbackchain -fno-delete-null-pointer-checks -g -MMD -MF lib/s390x/.mmu.d -fno-strict-aliasing -fno-common -Wall -Wwrite-strings -Wempty-body -Wuninitialized -Wignored-qualifiers -Wno-missing-braces -Werror  -fomit-frame-pointer  -fno-stack-protector    -Wno-frame-address   -fno-pic  -no-pie  -Wclobbered  -Wunused-but-set-parameter  -Wmissing-parameter-type  -Wold-style-declaration -Woverride-init -Wmissing-prototypes -Wstrict-prototypes -I/kut/lib -I/kut/lib/s390x -Ilib  -c -o lib/s390x/mmu.o lib/s390x/mmu.c
> lib/s390x/mmu.c:132:7: error: conflicting types for ‘get_dat_entry’ due to enum/integer mismatch; have ‘void *(pgd_t *, void *, enum pgt_level)’ [-Werror=enum-int-mismatch]
>    132 | void *get_dat_entry(pgd_t *pgtable, void *vaddr, enum pgt_level level)
>        |       ^~~~~~~~~~~~~
> In file included from lib/s390x/mmu.c:16:
> lib/s390x/mmu.h:96:7: note: previous declaration of ‘get_dat_entry’ with type ‘void *(pgd_t *, void *, unsigned int)’
>     96 | void *get_dat_entry(pgd_t *pgtable, void *vaddr, unsigned int level);
>        |       ^~~~~~~~~~~~~
> 
> Signed-off-by: Nico Boehr <nrb@linux.ibm.com>
> ---
>   lib/s390x/mmu.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/s390x/mmu.h b/lib/s390x/mmu.h
> index 15f88e4f424e..dadc2e600f9a 100644
> --- a/lib/s390x/mmu.h
> +++ b/lib/s390x/mmu.h
> @@ -93,6 +93,6 @@ static inline void unprotect_page(void *vaddr, unsigned long prot)
>   	unprotect_dat_entry(vaddr, prot, pgtable_level_pte);
>   }
>   
> -void *get_dat_entry(pgd_t *pgtable, void *vaddr, unsigned int level);
> +void *get_dat_entry(pgd_t *pgtable, void *vaddr, enum pgt_level level);
>   
>   #endif /* _ASMS390X_MMU_H_ */

Reviewed-by: Thomas Huth <thuth@redhat.com>

