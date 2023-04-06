Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CADFFC76196
	for <linux-s390@archiver.kernel.org>; Thu,  6 Apr 2023 14:13:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238890AbjDFONO (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 6 Apr 2023 10:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238961AbjDFONH (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 6 Apr 2023 10:13:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67C0EA26B
        for <linux-s390@vger.kernel.org>; Thu,  6 Apr 2023 07:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680790321;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oy2QomrGUBDfWG7234e6lYS9Z4zzgLJXtJtCEsgjhmY=;
        b=aZhN1NC/iWWs/nmzETinltHhAezLhQDbgIzpvQxSWycMVSuxgGVvVcvmNr6gV/6TrwKrlR
        H/UpujZANJOXhiL0pyb+Jdl+gBaLUXFN3Vxuybe0NgK7HVpfqujLcfvS3Ryp88SzLPd/ho
        AL6MENLq53/v3AJTB/yPGoHczRXQdj0=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-1TFsXlDTNWC3PaBPobPU9A-1; Thu, 06 Apr 2023 10:12:00 -0400
X-MC-Unique: 1TFsXlDTNWC3PaBPobPU9A-1
Received: by mail-qt1-f199.google.com with SMTP id r22-20020ac85c96000000b003e638022bc9so14805875qta.5
        for <linux-s390@vger.kernel.org>; Thu, 06 Apr 2023 07:12:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680790319; x=1683382319;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oy2QomrGUBDfWG7234e6lYS9Z4zzgLJXtJtCEsgjhmY=;
        b=MtdoNDeHWYlrC12NKWojj/4DJQQHzlR0WD26S6A1bUKeSlkmWQIRaCeJpjOARYiIHw
         VYEHu2zHtHELQlPtW4TElL363z9ctSRXrdIMoGGl224JTcoEGMz1RB/wXH8Bcrce1Lkf
         hPizJd2hn/AULhQ3hhNXMn+mu+g5+oq5D6GnRNNE0zajU0/094xixxaEggAkOHcwmg49
         6WLCnbCrh96MFBwi+vZBy+YWyVotRb9Rk7Eg9V35ym9SLa7ITUmdfaL7+D4XdhfGRq+f
         oEUEdmn3FPs5V5pxudyH6Lijx1bwdqUmwKv7LtT2AjRWWhH53w3eyE2nhCkdidWzfE8G
         dewA==
X-Gm-Message-State: AAQBX9dy0vgWI5cG8fYu6b224mljjhVlD/RbG3Oa+3mtjXdYEEK7fRZM
        vh3gAuJO5qqq5bnWVMQYQ4iAA1AwvRa+FsXkYL6EwzdgCgv1mENiQev9ZG+frvD6ObcOm+EdlDq
        jhjAzNtJqgh0R4raBWk8+zw==
X-Received: by 2002:a05:6214:c21:b0:5a2:e3e4:59b0 with SMTP id a1-20020a0562140c2100b005a2e3e459b0mr4151653qvd.44.1680790319559;
        Thu, 06 Apr 2023 07:11:59 -0700 (PDT)
X-Google-Smtp-Source: AKy350YdFg9Rpod34ylmYUyAnCfxfiKdtnShPJSS+THNG9On45kotrwTmF6ARLq441OR3LQJbmn9Kg==
X-Received: by 2002:a05:6214:c21:b0:5a2:e3e4:59b0 with SMTP id a1-20020a0562140c2100b005a2e3e459b0mr4151612qvd.44.1680790319253;
        Thu, 06 Apr 2023 07:11:59 -0700 (PDT)
Received: from vschneid.remote.csb ([154.57.232.159])
        by smtp.gmail.com with ESMTPSA id d11-20020a0cf6cb000000b005dd8b9345f4sm514523qvo.140.2023.04.06.07.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 07:11:58 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Yair Podemsky <ypodemsk@redhat.com>, linux@armlinux.org.uk,
        mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        davem@davemloft.net, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, will@kernel.org, aneesh.kumar@linux.ibm.com,
        akpm@linux-foundation.org, arnd@arndb.de, keescook@chromium.org,
        paulmck@kernel.org, jpoimboe@kernel.org, samitolvanen@google.com,
        ardb@kernel.org, juerg.haefliger@canonical.com,
        rmk+kernel@armlinux.org.uk, geert+renesas@glider.be,
        tony@atomide.com, linus.walleij@linaro.org,
        sebastian.reichel@collabora.com, nick.hawkins@hpe.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, mtosatti@redhat.com, dhildenb@redhat.com,
        alougovs@redhat.com
Subject: Re: [PATCH 3/3] mm/mmu_gather: send tlb_remove_table_smp_sync IPI
 only to CPUs in kernel mode
In-Reply-To: <20230406133805.GO386572@hirez.programming.kicks-ass.net>
References: <20230404134224.137038-1-ypodemsk@redhat.com>
 <20230404134224.137038-4-ypodemsk@redhat.com>
 <ZC1Q7uX4rNLg3vEg@lothringen> <ZC1XD/sEJY+zRujE@lothringen>
 <20230405114148.GA351571@hirez.programming.kicks-ass.net>
 <ZC1j8ivE/kK7+Gd5@lothringen> <xhsmhpm8ia46p.mognet@vschneid.remote.csb>
 <20230406133805.GO386572@hirez.programming.kicks-ass.net>
Date:   Thu, 06 Apr 2023 15:11:52 +0100
Message-ID: <xhsmh8rf59k2f.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 06/04/23 15:38, Peter Zijlstra wrote:
> On Wed, Apr 05, 2023 at 01:45:02PM +0100, Valentin Schneider wrote:
>>
>> I've been hacking on something like this (CSD deferral for NOHZ-full),
>> and unfortunately this uses the CPU-local cfd_data storage thing, which
>> means any further smp_call_function() from the same CPU to the same
>> destination will spin on csd_lock_wait(), waiting for the target CPU to
>> come out of userspace and flush the queue - and we've just spent extra
>> effort into *not* disturbing it, so that'll take a while :(
>
> I'm not sure I buy into deferring stuff.. a NOHZ_FULL cpu might 'never'
> come back. Queueing data just in case it does seems wasteful.

Putting those callbacks straight into the bin would make my life much
easier!

Unfortunately, even if they really should, I don't believe all of the
things being crammed onto NOHZ_FULL CPUs have the same definition of
'never' as we do :/

