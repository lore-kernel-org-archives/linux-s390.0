Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D953C433E0
	for <linux-s390@archiver.kernel.org>; Fri, 12 Feb 2021 10:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36E7264E6B
	for <linux-s390@archiver.kernel.org>; Fri, 12 Feb 2021 10:35:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbhBLKer (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 12 Feb 2021 05:34:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42531 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230436AbhBLKeh (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 12 Feb 2021 05:34:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613125991;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qPlQOMzj03nx5JCRjigQK4RasyyRp674ycyXkROq6/0=;
        b=RaNPu8FUlJ+cY8eRZMRe+y+rr7SeENMk8Qc/LS5ILL9HsebUY6lLvIM3XabsHxDWXba6gN
        S3/jPv8HH6ADJ9UyNw3PNB1qKYgqIfKHtweSYw0722AXvymlB4Rbgc77+6Yqp6XMMOcgpL
        gT9bog2fELYHCfI+5NbcIC8i0+6hJmg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-35-SsilzsLKP-eVcwmY0MU3Rw-1; Fri, 12 Feb 2021 05:33:07 -0500
X-MC-Unique: SsilzsLKP-eVcwmY0MU3Rw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 438E7801975;
        Fri, 12 Feb 2021 10:33:06 +0000 (UTC)
Received: from gondolin (ovpn-113-189.ams2.redhat.com [10.36.113.189])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B934019D9F;
        Fri, 12 Feb 2021 10:33:01 +0000 (UTC)
Date:   Fri, 12 Feb 2021 11:32:59 +0100
From:   Cornelia Huck <cohuck@redhat.com>
To:     Pierre Morel <pmorel@linux.ibm.com>
Cc:     kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        frankja@linux.ibm.com, david@redhat.com, thuth@redhat.com,
        imbrenda@linux.ibm.com
Subject: Re: [kvm-unit-tests PATCH v2 1/5] s390x: css: Store CSS
 Characteristics
Message-ID: <20210212113259.32fe6906.cohuck@redhat.com>
In-Reply-To: <1612963214-30397-2-git-send-email-pmorel@linux.ibm.com>
References: <1612963214-30397-1-git-send-email-pmorel@linux.ibm.com>
        <1612963214-30397-2-git-send-email-pmorel@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, 10 Feb 2021 14:20:10 +0100
Pierre Morel <pmorel@linux.ibm.com> wrote:

> CSS characteristics exposes the features of the Channel SubSystem.
> Let's use Store Channel Subsystem Characteristics to retrieve
> the features of the CSS.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>  lib/s390x/css.h     |  69 +++++++++++++++++++++++++++
>  lib/s390x/css_lib.c | 112 +++++++++++++++++++++++++++++++++++++++++++-
>  s390x/css.c         |  12 +++++
>  3 files changed, 192 insertions(+), 1 deletion(-)
> 

(...)

> +static const char *chsc_rsp_description[] = {
> +	"CHSC unknown error",
> +	"Command executed",
> +	"Invalid command",
> +	"Request-block error",
> +	"Command not installed",
> +	"Data not available",
> +		"Absolute address of channel-subsystem"
> +	"communication block exceeds 2 - 1.",

"2G - 1", I think?

> +	"Invalid command format",
> +	"Invalid channel-subsystem identification (CSSID)",
> +	"The command-request block specified an invalid format"
> +		"for the command response block.",
> +	"Invalid subchannel-set identification (SSID)",
> +	"A busy condition precludes execution.",
> +};

(...)

This matches both the Linux implementation and my memories, so

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

