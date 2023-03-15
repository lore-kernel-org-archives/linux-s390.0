Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E004C61DA4
	for <linux-s390@archiver.kernel.org>; Wed, 15 Mar 2023 05:09:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbjCOFJL (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 15 Mar 2023 01:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbjCOFJK (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 15 Mar 2023 01:09:10 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C6B727D67
        for <linux-s390@vger.kernel.org>; Tue, 14 Mar 2023 22:09:07 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id p6so18900775plf.0
        for <linux-s390@vger.kernel.org>; Tue, 14 Mar 2023 22:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112; t=1678856947;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cDhp6I3SlNxGtr/O2yKbwiije8DSntjdlAK0nvSsNNE=;
        b=fGqFohi/U0BaTxNiwoIwD6MODRfd07bt2ES8n34/VYOh/f4HlZWFxnzVvt4O3h+BRC
         /hAb0APS4PAYxvTzi2Wvcd3eeDXlio7s+9p4lZjr4x/yQzLq47Qr+hPKSTiT+7hYxBGs
         i3CDZA9bQAiO4CFCL1K6uKFdUBa8BMNqmI8DeAuDdPC7CW1PBcSNVA8fzPdMqp1iGZKd
         MYtTLzfNUmesH/WxmH5wiwAYCcRbvl3QewEWJlqd/12S9r1FfC8WwmpkbTiZH629IJDp
         o7GcnJZZQyUv4B7T5OsfTiVlLXHGXe1c9tlVmlHIevWqwcF/P2S3qs6EzumHpyHrdo2G
         DhiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678856947;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cDhp6I3SlNxGtr/O2yKbwiije8DSntjdlAK0nvSsNNE=;
        b=GXMw15cfxaIq0JJmW2dr3PRxntVMB6PWSnenK3D6RVCyO81lccpJdyg+0c/FpKZuBj
         MdoyHdlc+KaVR/JJnEAiOSF+ZsMlPNkeyJXmjtDUFMb+nuCLx5rfr4f2dSoXySgoB9o4
         pRB51ek0h90RoZzry1ly+Vj52QDyY75DrqBdXVsUUSYgWdIN3TrPN0emwQMjdmzXFSsq
         ZgL6HpBwO3QllNJWl3BayrUkJSOmqt2TAMMTLUX4IE+INBS7qfSxVA4e9toIdmdaFNbQ
         BYM+GggkhMjvP4UBFTlYymbc1S4Esk3Av56+hkGsorS6z5Vy5qOAiQEXO52JfaY8asFw
         vVdg==
X-Gm-Message-State: AO0yUKX202cGODCNsZGEoL7UFEmoSEAKcFG2w8JbvHaAV3pSoSzNZLFh
        NEC/bpL/eQ3ns8FL2aZjUayE8w==
X-Google-Smtp-Source: AK7set8juefow6279l5hDaRc9EcSMejPwOhhh67Wy+KVPRNO0G7i+DJ7i60mGKb+GVMj9wBlxJ/qVg==
X-Received: by 2002:a17:903:1c1:b0:1a1:7b8d:670a with SMTP id e1-20020a17090301c100b001a17b8d670amr370816plh.21.1678856946844;
        Tue, 14 Mar 2023 22:09:06 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id gt22-20020a17090af2d600b0023530b1e4a0sm391684pjb.2.2023.03.14.22.09.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 22:09:06 -0700 (PDT)
Date:   Tue, 14 Mar 2023 22:09:06 -0700 (PDT)
X-Google-Original-Date: Tue, 14 Mar 2023 22:08:14 PDT (-0700)
Subject:     Re: [PATCH v2 1/6] riscv/mm/fault: simplify code for do_page_fault()
In-Reply-To: <ZBFRbVJDK8p5nelT@casper.infradead.org>
CC:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, tongtiangen@huawei.com
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     willy@infradead.org
Message-ID: <mhng-dc587968-81c2-4f28-8d27-f739230b25cb@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, 14 Mar 2023 22:02:37 PDT (-0700), willy@infradead.org wrote:
> On Tue, Mar 14, 2023 at 08:03:54PM -0700, Palmer Dabbelt wrote:
>> To make the code more hierarchical and readable, we fold vma related
>> judgments into __do_page_fault(). And to simplify the code, move the
>> tsk->thread.bad_cause's setting into bad_area(). No functional change
>> intended.
>
> I think this is exaactly the wrong thing to be doing.  Please _stop_
> using custom internal VM_FAULT flags, not adding new uses!

I'm fine with that.  The rest of the patch set was to chunk out a few to 
avoid them stepping on generic stuff, but we don't really need that in 
RISC-V land (aside from this, which is sort of a mixed bag WRT whether 
this is simpler or not).  That's sort of why I held off on merging this 
in the first place.

That said, the follow-on patches do clean up some mixing between generic 
and arch codes for other ports.  I'm not sure if those can manifest as a 
real bug or not.
