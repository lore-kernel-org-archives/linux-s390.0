Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48F77C433E0
	for <linux-s390@archiver.kernel.org>; Fri, 12 Feb 2021 10:55:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A20E64E2D
	for <linux-s390@archiver.kernel.org>; Fri, 12 Feb 2021 10:55:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbhBLKzA (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 12 Feb 2021 05:55:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58930 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229674AbhBLKy7 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 12 Feb 2021 05:54:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613127212;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x6xsQ6qKCWc5VwzynBtKW0JR1zx1CuazVJUhCMJt7f8=;
        b=ZM45gj9O7k9jNMq9AWwjW0RT4HBQ52auPCwEcx4etOql5YBdjVgpM6w1zKlYT60xQ1VMNK
        YfbOEr7CpuF75NpY7tpseLtJGDzePQg0w97oynX9AYYmK3tYlWtK8l4enzq5qr9eUK21IC
        WBzW4Nc1et2EtlABjrQZYC79XaMEF/U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-39-gkxIsTP1M6uCV-N1Wwq6Hw-1; Fri, 12 Feb 2021 05:53:30 -0500
X-MC-Unique: gkxIsTP1M6uCV-N1Wwq6Hw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0B6C680197B;
        Fri, 12 Feb 2021 10:53:29 +0000 (UTC)
Received: from gondolin (ovpn-113-189.ams2.redhat.com [10.36.113.189])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B4A166A90B;
        Fri, 12 Feb 2021 10:53:09 +0000 (UTC)
Date:   Fri, 12 Feb 2021 11:53:07 +0100
From:   Cornelia Huck <cohuck@redhat.com>
To:     Pierre Morel <pmorel@linux.ibm.com>
Cc:     kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        frankja@linux.ibm.com, david@redhat.com, thuth@redhat.com,
        imbrenda@linux.ibm.com
Subject: Re: [kvm-unit-tests PATCH v2 3/5] s390x: css: implementing Set
 CHannel Monitor
Message-ID: <20210212115307.627abe8a.cohuck@redhat.com>
In-Reply-To: <1612963214-30397-4-git-send-email-pmorel@linux.ibm.com>
References: <1612963214-30397-1-git-send-email-pmorel@linux.ibm.com>
        <1612963214-30397-4-git-send-email-pmorel@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, 10 Feb 2021 14:20:12 +0100
Pierre Morel <pmorel@linux.ibm.com> wrote:

> We implement the call of the Set CHannel Monitor instruction,
> starting the monitoring of the all Channel Sub System, and
> initializing channel subsystem monitoring.
> 
> An initial test reports the presence of the extended measurement
> block feature.
> 
> Several tests on SCHM verify the error reporting of the hypervisor.

Combine these two into one sentence?

"Initial tests report the presence of the extended measurement block
feature, and verify the error reporting of the hypervisor for SCHM."

Also, you add the infrastructure for enabling measurements at the
subchannel -- either mention this in the patch description or move it
to a separate patch or the first user?

> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>  lib/s390x/css.h     | 19 +++++++++++-
>  lib/s390x/css_lib.c | 74 +++++++++++++++++++++++++++++++++++++++++++++
>  s390x/css.c         | 36 ++++++++++++++++++++++
>  3 files changed, 128 insertions(+), 1 deletion(-)
> 

(...)

> diff --git a/lib/s390x/css_lib.c b/lib/s390x/css_lib.c
> index 5426a6b..355881d 100644
> --- a/lib/s390x/css_lib.c
> +++ b/lib/s390x/css_lib.c
> @@ -267,6 +267,80 @@ retry:
>  	return -1;
>  }
>  
> +static bool schib_update(int schid, uint64_t mb, uint16_t mbi, uint16_t flags,
> +		  bool format1)

Maybe schib_update_mb()?

> +{
> +	struct pmcw *pmcw = &schib.pmcw;
> +	int cc;
> +
> +	/* Read the SCHIB for this subchannel */
> +	cc = stsch(schid, &schib);
> +	if (cc) {
> +		report_info("stsch: sch %08x failed with cc=%d", schid, cc);
> +		return false;
> +	}
> +
> +	/* Update the SCHIB to enable the measurement block */
> +	pmcw->flags |= flags;

Do we also want to be able to disable it again?

> +
> +	if (format1)
> +		pmcw->flags2 |= PMCW_MBF1;
> +	else
> +		pmcw->flags2 &= ~PMCW_MBF1;
> +
> +	pmcw->mbi = mbi;
> +	schib.mbo = mb;
> +
> +	/* Tell the CSS we want to modify the subchannel */
> +	cc = msch(schid, &schib);
> +	if (cc) {
> +		/*
> +		 * If the subchannel is status pending or
> +		 * if a function is in progress,
> +		 * we consider both cases as errors.
> +		 */
> +		report_info("msch: sch %08x failed with cc=%d", schid, cc);
> +		return false;
> +	}
> +
> +	/*
> +	 * Read the SCHIB again to verify the measurement block origin
> +	 */
> +	cc = stsch(schid, &schib);
> +	if (cc) {
> +		report_info("stsch: updating sch %08x failed with cc=%d",
> +			    schid, cc);
> +		return false;
> +	}

Hm, you only do the stsch, but do not check the result (that is done by
the caller) -- remove the misleading comment or replace it with "Read
the SCHIB again"?

> +
> +	return true;
> +}
> +

(...)

Otherwise, LGTM.

