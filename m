Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47979C11F68
	for <linux-s390@archiver.kernel.org>; Wed, 30 Jun 2021 09:06:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26497619BE
	for <linux-s390@archiver.kernel.org>; Wed, 30 Jun 2021 09:06:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233653AbhF3JJO (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 30 Jun 2021 05:09:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41572 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233462AbhF3JJN (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 30 Jun 2021 05:09:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625044005;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QBRQce1xZp1f1v+kGC1iovCD8Ap2Xtm9tj0fnmuBAok=;
        b=HC0q+TKarxF6wWPjBnGmWzdV9fjM8Po75KQ5PJyizT0yLzWgRM5kgZGP68VhSQm2E0Mv8V
        0PdS8iG3TM1C+ICZiLvJY8z2hIjhGc251owwiXM05t7ZzMQoommGGvxfxA1SPZJc3ltB05
        3zKHR4MBXNL21fqmVTSluE4D+zdVx28=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-172-HKiF7AD8MBi0Pkwp3vpsDQ-1; Wed, 30 Jun 2021 05:06:41 -0400
X-MC-Unique: HKiF7AD8MBi0Pkwp3vpsDQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9A74E1835AC7;
        Wed, 30 Jun 2021 09:06:40 +0000 (UTC)
Received: from localhost (ovpn-112-48.ams2.redhat.com [10.36.112.48])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id ECA3D1A26A;
        Wed, 30 Jun 2021 09:06:36 +0000 (UTC)
From:   Cornelia Huck <cohuck@redhat.com>
To:     Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, imbrenda@linux.ibm.com,
        david@redhat.com, thuth@redhat.com
Subject: Re: [kvm-unit-tests PATCH 4/5] lib: s390x: uv: Add offset comments
 to uv_query and extend it
In-Reply-To: <20210629133322.19193-5-frankja@linux.ibm.com>
Organization: Red Hat GmbH
References: <20210629133322.19193-1-frankja@linux.ibm.com>
 <20210629133322.19193-5-frankja@linux.ibm.com>
User-Agent: Notmuch/0.32.1 (https://notmuchmail.org)
Date:   Wed, 30 Jun 2021 11:06:35 +0200
Message-ID: <87o8bnlo10.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Jun 29 2021, Janosch Frank <frankja@linux.ibm.com> wrote:

> The struct is getting longer, let's add offset comments so we know
> where we change things when we add struct members.
>
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  lib/s390x/asm/uv.h | 33 +++++++++++++++++----------------
>  1 file changed, 17 insertions(+), 16 deletions(-)
>
> diff --git a/lib/s390x/asm/uv.h b/lib/s390x/asm/uv.h
> index 96a2a7e..5ff98b8 100644
> --- a/lib/s390x/asm/uv.h
> +++ b/lib/s390x/asm/uv.h
> @@ -86,22 +86,23 @@ struct uv_cb_init {
>  } __attribute__((packed))  __attribute__((aligned(8)));
>  
>  struct uv_cb_qui {
> -	struct uv_cb_header header;
> -	uint64_t reserved08;
> -	uint64_t inst_calls_list[4];
> -	uint64_t reserved30[2];
> -	uint64_t uv_base_stor_len;
> -	uint64_t reserved48;
> -	uint64_t conf_base_phys_stor_len;
> -	uint64_t conf_base_virt_stor_len;
> -	uint64_t conf_virt_var_stor_len;
> -	uint64_t cpu_stor_len;
> -	uint32_t reserved70[3];
> -	uint32_t max_num_sec_conf;
> -	uint64_t max_guest_stor_addr;
> -	uint8_t  reserved88[158 - 136];
> -	uint16_t max_guest_cpus;
> -	uint8_t  reserveda0[200 - 160];
> +	struct uv_cb_header header;		/* 0x0000 */
> +	uint64_t reserved08;			/* 0x0008 */
> +	uint64_t inst_calls_list[4];		/* 0x0010 */
> +	uint64_t reserved30[2];			/* 0x0030 */
> +	uint64_t uv_base_stor_len;		/* 0x0040 */
> +	uint64_t reserved48;			/* 0x0048 */
> +	uint64_t conf_base_phys_stor_len;	/* 0x0050 */
> +	uint64_t conf_base_virt_stor_len;	/* 0x0058 */
> +	uint64_t conf_virt_var_stor_len;	/* 0x0060 */
> +	uint64_t cpu_stor_len;			/* 0x0068 */
> +	uint32_t reserved70[3];			/* 0x0070 */
> +	uint32_t max_num_sec_conf;		/* 0x007c */
> +	uint64_t max_guest_stor_addr;		/* 0x0080 */
> +	uint8_t  reserved88[158 - 136];		/* 0x0088 */
> +	uint16_t max_guest_cpus;		/* 0x009e */
> +	uint64_t uv_feature_indications;	/* 0x00a0 */
> +	uint8_t  reserveda0[200 - 168];		/* 0x00a8 */

Should this rather be reserveda8? The other reserveds encode their
position properly.

