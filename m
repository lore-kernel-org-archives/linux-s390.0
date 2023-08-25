Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0DBAC71134
	for <linux-s390@archiver.kernel.org>; Fri, 25 Aug 2023 15:59:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235566AbjHYP67 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 25 Aug 2023 11:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244299AbjHYP6i (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 25 Aug 2023 11:58:38 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 973D42680
        for <linux-s390@vger.kernel.org>; Fri, 25 Aug 2023 08:58:36 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d7496b913e7so1261561276.3
        for <linux-s390@vger.kernel.org>; Fri, 25 Aug 2023 08:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692979116; x=1693583916;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=n9OoCnMu5ggn9ls0qYy10cPYlblntSxvFSs/ugRa5x0=;
        b=UpPobNiK6GZBSsEfCqQ0ai2dVcmgd0u4n48/qFsCCR5MLCFfecBdFqfXiH7EH3FhTS
         IGgJnrLX5HZkcRwcf1aHvAMnhUQT32TUPxcK3UkccosXMr76DTeUzzHDdnSiGbpXr5eH
         7fRImDD7iiek6uDBXsvm7ppwLWEA/jfQgpDResE6gGP536RI4EfqbxOx8cMRm4DYFLAu
         /2Y5Nv7iwkrjVDXbJKoML7sstrsAn0Ke4/OeX6o73zSDzO1e0uVmmoqndqoFgxLqq5Hf
         Q6KXCeQoOvHpAEMLoKgHKkxaa08EwWNcgkOyRXwc5mWAdQuTZ20dGEYCciiHIYg05ijV
         lWpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692979116; x=1693583916;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n9OoCnMu5ggn9ls0qYy10cPYlblntSxvFSs/ugRa5x0=;
        b=T+2SynpEnF8Iz1Bxfp7urzofe/tRsdnreedeyCJFf17duvT6HJHuVT0zFkbmUp3aYv
         Kvjyn0/Dc4LqLVYTyLo+38iHvzghgY7/1AKc0lLmwJ1Z5V7JPEOMHNhFKnzyRV7AScQS
         PDckx6uPE6Hpf/sXy1Ha+NKqxj0rAlm7JtXGW2l9U37I/qSs90w5aZFgzhJT41xIQToD
         ayDa+3FnN4JIAHrpQDAxDoyqB6g4mqzh0C2K9kLYwsPbLp8RGLBxxHg7F7Sku4sVjH44
         b1beEBbt4N5yQFNxxgA5DyobHINdT4cBUeUOZZEyt2Nvs2EjkX4kzNscPLNIUOa4Hk0X
         gppw==
X-Gm-Message-State: AOJu0Yx66JG60EG1ucgI/DSnMZVd/9o027qCEVyaKCKNPWx4JDd+PMlo
        lA1leF/VPFq/ZjzqTd/nhkOWskeOGcU=
X-Google-Smtp-Source: AGHT+IG3Lo+auwpH673RK736RHVhxUVht74h+63VIXkKwVAjdbIbXl5h5PENZT8JZpZZVT8KBfUSH2N/EkE=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:a2cc:0:b0:d13:856b:c10a with SMTP id
 c12-20020a25a2cc000000b00d13856bc10amr465337ybn.3.1692979115872; Fri, 25 Aug
 2023 08:58:35 -0700 (PDT)
Date:   Fri, 25 Aug 2023 08:58:34 -0700
In-Reply-To: <99289fd4-0a1e-3c05-8934-732ef7815942@linux.ibm.com>
Mime-Version: 1.0
References: <20230824124522.75408-1-frankja@linux.ibm.com> <99289fd4-0a1e-3c05-8934-732ef7815942@linux.ibm.com>
Message-ID: <ZOjPqhpejWWJrEgE@google.com>
Subject: Re: [GIT PULL 00/22] KVM: s390: Changes for 6.6
From:   Sean Christopherson <seanjc@google.com>
To:     Janosch Frank <frankja@linux.ibm.com>
Cc:     pbonzini@redhat.com, kvm@vger.kernel.org, david@redhat.com,
        borntraeger@linux.ibm.com, cohuck@redhat.com,
        linux-s390@vger.kernel.org, imbrenda@linux.ibm.com,
        hca@linux.ibm.com, mihajlov@linux.ibm.com, seiden@linux.ibm.com,
        akrowiak@linux.ibm.com, Ilya Leoshkevich <iii@linux.ibm.com>
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, Aug 25, 2023, Janosch Frank wrote:
> On 8/24/23 14:43, Janosch Frank wrote:
> > Hello Paolo,
> > 
> > please pull the following changes for 6.6.
> > 
> 
> @Paolo:
> Seems like neither Claudio (who picked the selftest) nor I had a closer look
> into the x86 selftest changes and Nina just informed me that this might lead
> to problems.
> 
> Please hold back on this pull request, I'll send a new one on Monday where
> we'll pull in the selftest changes and have a fixed up version of the
> selftest. I've spoken to Ilya privately and he's ok with Claudio fixing this
> up.

If you haven't already done a merge, I pushed

  https://github.com/kvm-x86/linux.git tags/kvm-x86-selftests-immutable-6.6

to guarantee a stable point (I have a few last minute selftests fixes for 6.6
that I'm planning on applying "soon").

Thanks for dealing with the conflicts, let me know if you run into any problems.
