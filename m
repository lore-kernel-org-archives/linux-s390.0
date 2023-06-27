Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA29EB64DD
	for <linux-s390@archiver.kernel.org>; Tue, 27 Jun 2023 03:07:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbjF0DHC (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 26 Jun 2023 23:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbjF0DHA (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 26 Jun 2023 23:07:00 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 782D411B
        for <linux-s390@vger.kernel.org>; Mon, 26 Jun 2023 20:06:58 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-401f4408955so92881cf.1
        for <linux-s390@vger.kernel.org>; Mon, 26 Jun 2023 20:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687835217; x=1690427217;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vHjDKRRl/15ekTuy08miOOxy3w0/yhMNRIiKSHMWeKc=;
        b=U+XAZ3T2dIrYSDRflvSR1rmzQYNaCDWIXrwa1SuzZyMaNy4R1Z9M7iKbPChbnEUUcN
         HbNR42w6rgICSGyutbOx3FUPFNrEn/y7PrelQZJmyCIivX/xaF9v3GFiJpnhAtYeu4RI
         /ZCmbFdAX8t40oXyMcprKrsltgmdVNvgUKpuOluQcm4IA1tHAnjOewZE9hAeGjLHQPzC
         F4j8dAcFO/tUYsA1CRgw8DhT52AI7ytP29bgeMTekvzrlL0PghVPLmiES2dlOXNuNOv9
         MjlQKW2/dQnNI81iD4ySLmnOu8yM7NHqS0Y6SWD1+C1voL+3X694zE5VmhYQ+Sl+KeBK
         q2gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687835217; x=1690427217;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vHjDKRRl/15ekTuy08miOOxy3w0/yhMNRIiKSHMWeKc=;
        b=iWKoO+8fg9qkFiIM5WCKkeh/pmya1I98umlaCfWhdszXHrdYgflmvMSF3IdRRcyigh
         Hu+AAY7YAZcUU2e49iGKGdFGLoLt4kM6pKSmphbOm9zipveiAoONe07BSDkOynClfFHw
         OOneVHgJBHin8sExPD2Nzb1OoDtdb55Ajs4uIs9CCjhNPbNDOsrtED3O5WDj0HiaBUL1
         M1v7XinaImb/LdHqMMo4vFqDfZkXFRrEzOU9EEzkKyG/j7nmrTSiXrcz9xeTOkFlWtCo
         TlHiSFsYrAo9cAZjQVPsdggBzRsookmZiRBOVsMup4q0ouy3OgTBoodlbJSCqQLHBdR1
         bz5g==
X-Gm-Message-State: AC+VfDynWB5GhsdGeF9APogcsOkok1gt4pmuye+onG3u9nYW5lTBA/nq
        Y00BplIFUUMtCBwGPO0yaBgsmcioqF+U6KbGZEk03g==
X-Google-Smtp-Source: ACHHUZ5p5sW4PXCHzSz3Bi+SKvcosf62y2SJQOFc8Eaih/xwzKdQqVu4Rv48gDYQD7M4asyor1cgbPKZvcH6CWAHIzY=
X-Received: by 2002:ac8:59c1:0:b0:3e8:684b:195d with SMTP id
 f1-20020ac859c1000000b003e8684b195dmr619236qtf.10.1687835217476; Mon, 26 Jun
 2023 20:06:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230626171430.3167004-1-ryan.roberts@arm.com> <20230626171430.3167004-6-ryan.roberts@arm.com>
In-Reply-To: <20230626171430.3167004-6-ryan.roberts@arm.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Mon, 26 Jun 2023 21:06:21 -0600
Message-ID: <CAOUHufZB=E5jW2O_ASuGUP=X-PfVUSFxOCvC=YU1_WwJiQCibA@mail.gmail.com>
Subject: Re: [PATCH v1 05/10] mm: Implement folio_remove_rmap_range()
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, Jun 26, 2023 at 11:14=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com=
> wrote:
>
> Like page_remove_rmap() but batch-removes the rmap for a range of pages
> belonging to a folio, for effciency savings. All pages are accounted as
> small pages.
>
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>  include/linux/rmap.h |  2 ++
>  mm/rmap.c            | 62 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 64 insertions(+)

Sorry for nagging: this can be included in a followup series.
