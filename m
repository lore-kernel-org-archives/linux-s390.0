Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CACEDC433EF
	for <linux-s390@archiver.kernel.org>; Tue,  5 Oct 2021 11:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE6496138F
	for <linux-s390@archiver.kernel.org>; Tue,  5 Oct 2021 11:53:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233817AbhJELzp (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 5 Oct 2021 07:55:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43521 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232658AbhJELzo (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 5 Oct 2021 07:55:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633434834;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ipJvJT+v6yt9zU5Ii84mTzCzbNo7bGPcsz8IZtbMm48=;
        b=Gum5XageRzAEoLTgN5RsTyNRuA8Z+OHjUWNENKgty+Z/CIc0yr2z1fD1x6OPyK/oEaLYdY
        tHkrxrjPOV7a1IHQ0d2SUGNAez7CqmO315ipKWhWMNydpV5nfVUBoEaoZ4wyqqYZWVax4x
        EBeEnmWtFM4vkCS5N1SrYx9mwlo6cMs=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-380-8J9-qe2vM0SPI3rFgOs5sA-1; Tue, 05 Oct 2021 07:53:51 -0400
X-MC-Unique: 8J9-qe2vM0SPI3rFgOs5sA-1
Received: by mail-ed1-f72.google.com with SMTP id b7-20020a50e787000000b003d59cb1a923so20359610edn.5
        for <linux-s390@vger.kernel.org>; Tue, 05 Oct 2021 04:53:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ipJvJT+v6yt9zU5Ii84mTzCzbNo7bGPcsz8IZtbMm48=;
        b=w3CzNSq+xWLbpPmy5DdMHs5K/D7/jT0nw/zNFDZ6/cSxZD7ZAxdiUKdt6cSHsoyUEl
         XHz8Gh1jtHWRFnj836KDmFtWKuDpU/hqso0GVve7FLC7Ufu+Lq5aK9x4cPU//5cIe1xq
         +g3Q1qhLY82CvP11PrePnhfCm0u2G1dM0ZbvQdMlCqClGTQv+8ZD0cMD1qvf2E5xgaqE
         grWLvKkZmDSQaU1/6JByuFcqH/llNju46s5fBYi7iWNUgFp7tsiJfBM7vdPZWleO2yfa
         1fic2ics2tvayZgCSTDntyI/qx3WXodazobKIUMJqDTBcmWUSc45vQ8ovJZKpPLlYkTB
         ttdg==
X-Gm-Message-State: AOAM530oWHphDoISx5tr+u9i2+mttJlWa7SLzbWjS7KbbS5H1O2EXAxy
        yXEEU+Fe8BtIv8RCupbPXUFQL2WaulfGO/S1cXcY7YM4RMtPTo5k2BijWSLKo+r9sqBdX6c7RAF
        duIygfifCSvsD+Z6Z6SZ8Zw==
X-Received: by 2002:a17:907:2896:: with SMTP id em22mr10275629ejc.365.1633434829524;
        Tue, 05 Oct 2021 04:53:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy7NZJRS3nsuSLLPnAGmTBCi5hvPKn3TAype/v0D2huOK2oa40DJK7oTvG3x1UAoFyI07HuFw==
X-Received: by 2002:a17:907:2896:: with SMTP id em22mr10275596ejc.365.1633434829202;
        Tue, 05 Oct 2021 04:53:49 -0700 (PDT)
Received: from gator.home (cst2-174-28.cust.vodafone.cz. [31.30.174.28])
        by smtp.gmail.com with ESMTPSA id t20sm7636612ejc.105.2021.10.05.04.53.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 04:53:48 -0700 (PDT)
Date:   Tue, 5 Oct 2021 13:53:47 +0200
From:   Andrew Jones <drjones@redhat.com>
To:     Janis Schoetterl-Glausch <scgl@linux.ibm.com>
Cc:     Thomas Huth <thuth@redhat.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, linux-s390@vger.kernel.org
Subject: Re: [kvm-unit-tests PATCH v2 4/5] Use report_fail(...) instead of
 report(0/false, ...)
Message-ID: <20211005115347.palt5njjhopxvtsg@gator.home>
References: <20211005090921.1816373-1-scgl@linux.ibm.com>
 <20211005090921.1816373-5-scgl@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211005090921.1816373-5-scgl@linux.ibm.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Oct 05, 2021 at 11:09:20AM +0200, Janis Schoetterl-Glausch wrote:
> Whitespace is kept consistent with the rest of the file.
> 
> Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
> ---
>  lib/s390x/css_lib.c |  30 ++++----
>  x86/vmx.h           |  25 ++++---
>  arm/psci.c          |   2 +-
>  arm/timer.c         |   2 +-
>  s390x/css.c         |  18 ++---
>  s390x/spec_ex.c     |   7 +-
>  x86/asyncpf.c       |   4 +-
>  x86/hyperv_stimer.c |   6 +-
>  x86/hyperv_synic.c  |   2 +-
>  x86/svm_tests.c     | 163 ++++++++++++++++++++++----------------------
>  x86/vmx.c           |  17 +++--
>  x86/vmx_tests.c     | 136 ++++++++++++++++++------------------
>  12 files changed, 200 insertions(+), 212 deletions(-)
>

Hi Janis,

Thank you for this cleanup.

Reviewed-by: Andrew Jones <drjones@redhat.com>

