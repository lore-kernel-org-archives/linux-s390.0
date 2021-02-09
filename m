Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0E8DC433DB
	for <linux-s390@archiver.kernel.org>; Tue,  9 Feb 2021 16:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 741A360230
	for <linux-s390@archiver.kernel.org>; Tue,  9 Feb 2021 16:57:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233142AbhBIQ5c (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 9 Feb 2021 11:57:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51780 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232654AbhBIQ5b (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 9 Feb 2021 11:57:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612889764;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PlOUIPdRPfOjmjs0OqT5a1Gq5CFIq35tLD8k3rj0JsE=;
        b=JkPlmgyXZ1Ru8aSs7fsb0v54CW6YpkXvt2lCVcKL0yR4ZQ+Lec0jnLqZEnJhSJIB1rqjFp
        SeqLqcguFYG5IsVz0TejTXRurDdumma4hpwnlHygWTZOe3d8rBpIxymy5q8DcY+4mhqn6o
        8g0i4QfA2+GeV7d/U8wJ7d4exfmNbtI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-27-2YGAvjs9PvOSF6-tEwwPxA-1; Tue, 09 Feb 2021 11:56:02 -0500
X-MC-Unique: 2YGAvjs9PvOSF6-tEwwPxA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 855EC80D68B;
        Tue,  9 Feb 2021 16:55:35 +0000 (UTC)
Received: from [10.36.113.141] (ovpn-113-141.ams2.redhat.com [10.36.113.141])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6C17C60C04;
        Tue,  9 Feb 2021 16:55:34 +0000 (UTC)
Subject: Re: [kvm-unit-tests PATCH] Fix the length in the stsi check for the
 VM name
To:     Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org,
        Janosch Frank <frankja@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>
References: <20210209155705.67601-1-thuth@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <0907d0fe-def2-be6f-e375-774a70f419fb@redhat.com>
Date:   Tue, 9 Feb 2021 17:55:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210209155705.67601-1-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 09.02.21 16:57, Thomas Huth wrote:
> sizeof(somepointer) results in the size of the pointer, i.e. 8 on a
> 64-bit system, so the
> 
>   memcmp(data->ext_names[0], vm_name_ext, sizeof(vm_name_ext))
> 
> only compared the first 8 characters of the VM name here. Switch
> to a proper array to get the sizeof() right.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   s390x/stsi.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/s390x/stsi.c b/s390x/stsi.c
> index 4109b8d..87d4804 100644
> --- a/s390x/stsi.c
> +++ b/s390x/stsi.c
> @@ -106,7 +106,7 @@ static void test_3_2_2(void)
>   				 0x00, 0x03 };
>   	/* EBCDIC for "KVM/" */
>   	const uint8_t cpi_kvm[] = { 0xd2, 0xe5, 0xd4, 0x61 };
> -	const char *vm_name_ext = "kvm-unit-test";
> +	const char vm_name_ext[] = "kvm-unit-test";
>   	struct stsi_322 *data = (void *)pagebuf;
>   
>   	report_prefix_push("3.2.2");
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

