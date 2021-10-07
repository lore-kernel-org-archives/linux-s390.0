Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34F7CC433EF
	for <linux-s390@archiver.kernel.org>; Thu,  7 Oct 2021 06:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BB27610A1
	for <linux-s390@archiver.kernel.org>; Thu,  7 Oct 2021 06:50:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236997AbhJGGwL (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 7 Oct 2021 02:52:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25595 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231279AbhJGGwI (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 7 Oct 2021 02:52:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633589414;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gR2IuP1xBNRrFxO5rgcYezdc7GQgLXrw0dvVXdXEOfw=;
        b=d+ZWIxDe2VnDQ3jBBV5yk+eR/SkSXEZaQ4mfOiYFdIW2S0SX3kvpM+ZiQyUiqsKUrVOFes
        qChPYBivzgHqBhNgptM7Sh41Xa1CChPkl7rg08D/NfCMBwF4O/dIxsq4dry5ke2HzobVwj
        flqi7g0efXMGYdrJtnmD5AQ4PkBuI9o=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-519-2wQ042qtNjC4OwKIA4MwwA-1; Thu, 07 Oct 2021 02:50:11 -0400
X-MC-Unique: 2wQ042qtNjC4OwKIA4MwwA-1
Received: by mail-wr1-f71.google.com with SMTP id r16-20020adfbb10000000b00160958ed8acso3854707wrg.16
        for <linux-s390@vger.kernel.org>; Wed, 06 Oct 2021 23:50:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gR2IuP1xBNRrFxO5rgcYezdc7GQgLXrw0dvVXdXEOfw=;
        b=siFbII8ruE7vZsXG1Lm20XNPfpfA1m6s9Q/P4rlM4bEwpAyg7lyQ90rW8CtcqLtbVm
         NCPSkxEZNWzECXZjIeRbG3v+Lkw4qs3SEaqDjT24zxUu8VCg73yZfYR54j8Y6nwWr/QM
         YPoZtrjXLeVJa2q0sjVwPX1XfGOLKAQLZI+vOPdR2aKHwcWhKfGS9i9bCpNg8yqROJwg
         W2qbZK9DwB/UvQw7CrkgkEC7ebLCQGWsEhOSNcPhxJnFVT4OB78bCKFWjjBF0ItdTmqC
         HKh93EDXkPDlSFI5IwzHxmZ36TbztINr0Fut9iGXcdIRIhfaQEX4lvObzBtLL2Rcjuwn
         lc8w==
X-Gm-Message-State: AOAM531wBzyWMAG+DPt8bS9gK/ggKYURQWwJPgdKqao0p3R44IUPCHdi
        KndKZPzw59bv8/zM5Yxb9siZei1sxdoHBZLN1hU8eeduvVg6ErROk+SNQGtgWCtLK1GCYezbjQU
        y6qDcmcqMzMMaZgbjRLnIuVGTTbMuYf7SVv1XVQ6W370r14tOWDqNW30Py5XbjoNdGgwtAA==
X-Received: by 2002:a1c:35c7:: with SMTP id c190mr14465365wma.57.1633589410223;
        Wed, 06 Oct 2021 23:50:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxOuotUHTyBwzACujoGsab4OKfZgTHAnsCxJt/5wgt430jvUDzX9d4Oglqagdduip5iSkLI0w==
X-Received: by 2002:a1c:35c7:: with SMTP id c190mr14465339wma.57.1633589409957;
        Wed, 06 Oct 2021 23:50:09 -0700 (PDT)
Received: from thuth.remote.csb (nat-pool-str-t.redhat.com. [149.14.88.106])
        by smtp.gmail.com with ESMTPSA id k8sm597084wmr.32.2021.10.06.23.50.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Oct 2021 23:50:09 -0700 (PDT)
Subject: Re: [kvm-unit-tests PATCH v2 5/5] Use report_pass(...) instead of
 report(1/true, ...)
To:     Janis Schoetterl-Glausch <scgl@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     Cornelia Huck <cohuck@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org
References: <20211005090921.1816373-1-scgl@linux.ibm.com>
 <20211005090921.1816373-6-scgl@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
Message-ID: <f4617a8a-d274-c6ae-d395-73cdba19663c@redhat.com>
Date:   Thu, 7 Oct 2021 08:50:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211005090921.1816373-6-scgl@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 05/10/2021 11.09, Janis Schoetterl-Glausch wrote:
> Whitespace is kept consistent with the rest of the file.
> 
> Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
> ---
>   s390x/css.c         |  4 ++--
>   s390x/diag288.c     |  2 +-
>   s390x/selftest.c    |  2 +-
>   s390x/smp.c         | 16 ++++++++--------
>   s390x/spec_ex.c     |  7 +++----
>   x86/asyncpf.c       |  7 +++----
>   x86/emulator.c      |  2 +-
>   x86/hyperv_stimer.c | 18 ++++++++----------
>   x86/svm_tests.c     | 17 ++++++++---------
>   x86/syscall.c       |  2 +-
>   x86/taskswitch2.c   |  2 +-
>   x86/tsc_adjust.c    |  2 +-
>   x86/vmx.c           |  6 +++---
>   x86/vmx_tests.c     | 36 ++++++++++++++++++------------------
>   14 files changed, 59 insertions(+), 64 deletions(-)
> 
> diff --git a/s390x/css.c b/s390x/css.c
> index dcb4d70..881206b 100644
> --- a/s390x/css.c
> +++ b/s390x/css.c
> @@ -31,7 +31,7 @@ static void test_enumerate(void)
>   {
>   	test_device_sid = css_enumerate();
>   	if (test_device_sid & SCHID_ONE) {
> -		report(1, "Schid of first I/O device: 0x%08x", test_device_sid);
> +		report_pass("Schid of first I/O device: 0x%08x", test_device_sid);
>   		return;
>   	}
...

Thanks, I've applied patches 3 - 5 now to the repository, since there were 
no objections and they are independent from your spec_ex work. (Dropped the 
hunk to spec_ex.c here of course, so please integrate that in the next 
version of that patch directly instead).

  Thomas


