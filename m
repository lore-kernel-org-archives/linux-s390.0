Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28155C433EF
	for <linux-s390@archiver.kernel.org>; Tue, 31 May 2022 08:55:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241462AbiEaIzf (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 31 May 2022 04:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238868AbiEaIze (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 31 May 2022 04:55:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 439648FFB6
        for <linux-s390@vger.kernel.org>; Tue, 31 May 2022 01:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653987332;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iaP4Rx4SV9w6UZ0UimQmEHdq+Pczo5IQxJG2ZngiOPM=;
        b=gBmdtN37zGBnesVp9nKsmJ6Uti5+LytGymv8hm8VUru7XERM3MIbhKPtEpwuhGsl7cy7L+
        rRpS1oPqt55bPMtqUpaCFzu1gEg4j0RKsFyFuBvFjy8lN6srd7owjTRB/uySsjrZZgLTcc
        BBpqaGzfRCVBDCqpKqkO9JHDoEriIWg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-232-RSgDXQWdPzicTgzXHYMl2g-1; Tue, 31 May 2022 04:55:30 -0400
X-MC-Unique: RSgDXQWdPzicTgzXHYMl2g-1
Received: by mail-wr1-f72.google.com with SMTP id p8-20020a5d4588000000b0021033f1f79aso717010wrq.5
        for <linux-s390@vger.kernel.org>; Tue, 31 May 2022 01:55:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=iaP4Rx4SV9w6UZ0UimQmEHdq+Pczo5IQxJG2ZngiOPM=;
        b=Ha/F2HZFVkPXXY52VRKGCqCOplm7BuluvOMm1BgxHjCaK/QYGF6a5kUxG8EFbEGbUK
         7PJA2tOiwHMw61NcLd43fQ69F84sFWqw/7BjY11c5zWWuOkjBltTCdF7mKfWanpYC4Qa
         dZJykBxJ+MvKg35cZ7PHikxsLoC9ENLi+CGOAl+URcubbfxMJ7sVHPZKYIs00xY847vU
         uU2s+G4ig+/MYewq6ANmDcoAof9k+iBRVtui7hHF41gcoTaeG7mkdGHDp4ukKb+j1gfK
         nNHkJupuVgHpftRa7CAMpaVCm8OFjTS9fcks+gl/fiZkqs96/b2j/+2IEdSwTJyaogIN
         q5yw==
X-Gm-Message-State: AOAM531897oEWXVj1Mt7QlokLQE37+ZN0hzf/20xNI5JQqTKeJXtrhs/
        rk/3xx5PhT8u1l/VvlU2kufwN2m9gSCL0iI/RIdACIk469mzPodsRAmIsXAylD6csX6VHD7SWv8
        /y9VMoWmZk8nanA/YzihwQw==
X-Received: by 2002:a05:600c:4fce:b0:397:84e3:2297 with SMTP id o14-20020a05600c4fce00b0039784e32297mr20649144wmq.197.1653987329678;
        Tue, 31 May 2022 01:55:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwmtw0XS0DBlA1YvKfMMOV2qEVZg5v+DEqF8KrKAaLiktU6Q6McjheYaP8uCBOW3Vk193L4MA==
X-Received: by 2002:a05:600c:4fce:b0:397:84e3:2297 with SMTP id o14-20020a05600c4fce00b0039784e32297mr20649129wmq.197.1653987329497;
        Tue, 31 May 2022 01:55:29 -0700 (PDT)
Received: from [192.168.0.2] (ip-109-43-177-214.web.vodafone.de. [109.43.177.214])
        by smtp.gmail.com with ESMTPSA id v5-20020a1cac05000000b003974df805c7sm1551685wme.8.2022.05.31.01.55.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 May 2022 01:55:29 -0700 (PDT)
Message-ID: <ed8e3b8a-e7ac-d432-f733-82fdaf668c1b@redhat.com>
Date:   Tue, 31 May 2022 10:55:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [kvm-unit-tests PATCH v3 1/1] s390x: add migration test for
 storage keys
Content-Language: en-US
To:     Nico Boehr <nrb@linux.ibm.com>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org
Cc:     frankja@linux.ibm.com, imbrenda@linux.ibm.com, scgl@linux.ibm.com
References: <20220531083713.48534-1-nrb@linux.ibm.com>
 <20220531083713.48534-2-nrb@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
In-Reply-To: <20220531083713.48534-2-nrb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 31/05/2022 10.37, Nico Boehr wrote:
> Upon migration, we expect storage keys set by the guest to be preserved, so add
> a test for it.
> 
> We keep 128 pages and set predictable storage keys. Then, we migrate and check
> that they can be read back and match the value originally set.
> 
> Signed-off-by: Nico Boehr <nrb@linux.ibm.com>
> Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> ---
>   s390x/Makefile         |  1 +
>   s390x/migration-skey.c | 76 ++++++++++++++++++++++++++++++++++++++++++
>   s390x/unittests.cfg    |  4 +++
>   3 files changed, 81 insertions(+)
>   create mode 100644 s390x/migration-skey.c
> 
> diff --git a/s390x/Makefile b/s390x/Makefile
> index 25802428fa13..94fc5c1a3527 100644
> --- a/s390x/Makefile
> +++ b/s390x/Makefile
> @@ -33,6 +33,7 @@ tests += $(TEST_DIR)/adtl-status.elf
>   tests += $(TEST_DIR)/migration.elf
>   tests += $(TEST_DIR)/pv-attest.elf
>   tests += $(TEST_DIR)/migration-cmm.elf
> +tests += $(TEST_DIR)/migration-skey.elf
>   
>   pv-tests += $(TEST_DIR)/pv-diags.elf
>   
> diff --git a/s390x/migration-skey.c b/s390x/migration-skey.c
> new file mode 100644
> index 000000000000..f846ac435836
> --- /dev/null
> +++ b/s390x/migration-skey.c
> @@ -0,0 +1,76 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Storage Key migration tests
> + *
> + * Copyright IBM Corp. 2022
> + *
> + * Authors:
> + *  Nico Boehr <nrb@linux.ibm.com>
> + */
> +
> +#include <libcflat.h>
> +#include <asm/facility.h>
> +#include <asm/page.h>
> +#include <asm/mem.h>
> +#include <asm/interrupt.h>
> +#include <hardware.h>
> +
> +#define NUM_PAGES 128
> +static uint8_t pagebuf[NUM_PAGES][PAGE_SIZE] __attribute__((aligned(PAGE_SIZE)));
> +
> +static void test_migration(void)
> +{
> +	union skey expected_key, actual_key;
> +	int i, key_to_set;
> +
> +	for (i = 0; i < NUM_PAGES; i++) {
> +		/*
> +		 * Storage keys are 7 bit, lowest bit is always returned as zero
> +		 * by iske
> +		 */
> +		key_to_set = i * 2;
> +		set_storage_key(pagebuf[i], key_to_set, 1);
> +	}
> +
> +	puts("Please migrate me, then press return\n");
> +	(void)getchar();
> +
> +	for (i = 0; i < NUM_PAGES; i++) {
> +		report_prefix_pushf("page %d", i);
> +
> +		actual_key.val = get_storage_key(pagebuf[i]);
> +		expected_key.val = i * 2;
> +
> +		/* ignore reference bit */
> +		actual_key.str.rf = 0;
> +		expected_key.str.rf = 0;

If the reference bit gets always ignored, testing 64 pages should be enough? 
OTOH this will complicate the for-loop / creation of the key value, so I 
don't mind too much if we keep it this way.

> +		report(actual_key.val == expected_key.val, "expected_key=0x%x actual_key=0x%x", expected_key.val, actual_key.val);
> +
> +		report_prefix_pop();
> +	}
> +}
> +
> +int main(void)
> +{
> +	report_prefix_push("migration-skey");
> +	if (test_facility(169)) {
> +		report_skip("storage key removal facility is active");
> +
> +		/*
> +		 * If we just exit and don't ask migrate_cmd to migrate us, it
> +		 * will just hang forever. Hence, also ask for migration when we
> +		 * skip this test altogether.
> +		 */
> +		puts("Please migrate me, then press return\n");
> +		(void)getchar();
> +
> +		goto done;
> +	}
> +
> +	test_migration();
> +
> +done:

	} else {
		test_migration();
	}

to get rid of the goto?

> +	report_prefix_pop();
> +	return report_summary();
> +}

Either way:
Reviewed-by: Thomas Huth <thuth@redhat.com>

