Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53787C64ED9
	for <linux-s390@archiver.kernel.org>; Sun, 19 Feb 2023 20:40:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbjBSUkx (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Sun, 19 Feb 2023 15:40:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231469AbjBSUkw (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sun, 19 Feb 2023 15:40:52 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A23B18B0F
        for <linux-s390@vger.kernel.org>; Sun, 19 Feb 2023 12:40:49 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id d4so1231768pjc.5
        for <linux-s390@vger.kernel.org>; Sun, 19 Feb 2023 12:40:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lqAwlutC29lMR1tf1e4XOcfdxhypv9zb0T2DcQuJ+3c=;
        b=MjtbsH5bW1HXHGXLRbwOKZEzdSInx4XUaJn+/0d2SKM5dw34hiBNmQU6ohqNZQA+L2
         I1GvKT2KInRCvvo+fSO/0GUShulfgU4qQvkio0wi+hAcl/UCahGdGyhq51MgW0auKO3G
         CJxCVe/nwu6tGjmlmFI7U6pzHUn2OY1PSCX/Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lqAwlutC29lMR1tf1e4XOcfdxhypv9zb0T2DcQuJ+3c=;
        b=RE0Wb3axEQLvaadrWez9M4G69o4LMTQOwuD3WMo5kI/nYnJzqZfQjfNvPX4AJ1/5ig
         RDyHqlYdpQ/0OP5EQSIbIRWIutgJcDyurc2wiuj8VjLaUTa8wpUDmreFE20Db93rrbjw
         uOoAbs3WCAR1G/RxjbF0q3GOwjQSp3Ae/MY0yMMIMd5YMLzuaJoADo4SqT5n+4ByfPSw
         BLsGZrVqV6E7rW+n/SFYOin0Ewm1y7bD+v/Y25rjSyKJChl4GTQzMhb/08AUI8H4a5it
         opeeqHIY6qZdb6VJn/siRPwOdgB/fhBu4FSOUX1EL49RfqHzKnyBUD8fbjEsFP/Klhl8
         emzg==
X-Gm-Message-State: AO0yUKUmdqXmiRF6FP6wGey/pUWS6GAq7uo2qJsM9n+envDjE6VXhfz2
        Z2/Z9Z2t5hckQ0nZ6tXOTqrxeQ==
X-Google-Smtp-Source: AK7set+6pLNAI2t6KBKr2yLlrqERzrItep/TFuzpN1S5wuT33QqMqXLLIayngNvSFYR5H3F8x2mXwg==
X-Received: by 2002:a17:903:2344:b0:19b:110d:28dc with SMTP id c4-20020a170903234400b0019b110d28dcmr2297593plh.19.1676839248654;
        Sun, 19 Feb 2023 12:40:48 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id bd6-20020a170902830600b0019a723a831dsm6357706plb.158.2023.02.19.12.40.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Feb 2023 12:40:48 -0800 (PST)
Message-ID: <63f28950.170a0220.aef42.bc00@mx.google.com>
X-Google-Original-Message-ID: <202302191240.@keescook>
Date:   Sun, 19 Feb 2023 12:40:47 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H . J . Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        John Allen <john.allen@amd.com>, kcc@google.com,
        eranian@google.com, rppt@kernel.org, jamorris@linux.microsoft.com,
        dethoma@microsoft.com, akpm@linux-foundation.org,
        Andrew.Cooper3@citrix.com, christina.schimpe@intel.com,
        david@redhat.com, debug@rivosinc.com, linux-alpha@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        Michal Simek <monstr@monstr.eu>,
        Dinh Nguyen <dinguyen@kernel.org>, linux-mips@vger.kernel.org,
        openrisc@lists.librecores.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
        xen-devel@lists.xenproject.org
Subject: Re: [PATCH v6 13/41] mm: Make pte_mkwrite() take a VMA
References: <20230218211433.26859-1-rick.p.edgecombe@intel.com>
 <20230218211433.26859-14-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230218211433.26859-14-rick.p.edgecombe@intel.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Sat, Feb 18, 2023 at 01:14:05PM -0800, Rick Edgecombe wrote:
> The x86 Control-flow Enforcement Technology (CET) feature includes a new
> type of memory called shadow stack. This shadow stack memory has some
> unusual properties, which requires some core mm changes to function
> properly.
> 
> One of these unusual properties is that shadow stack memory is writable,
> but only in limited ways. These limits are applied via a specific PTE
> bit combination. Nevertheless, the memory is writable, and core mm code
> will need to apply the writable permissions in the typical paths that
> call pte_mkwrite().
> 
> In addition to VM_WRITE, the shadow stack VMA's will have a flag denoting
> that they are special shadow stack flavor of writable memory. So make
> pte_mkwrite() take a VMA, so that the x86 implementation of it can know to
> create regular writable memory or shadow stack memory.
> 
> Apply the same changes for pmd_mkwrite() and huge_pte_mkwrite().
> 
> No functional change.
> 
> Cc: linux-doc@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-alpha@vger.kernel.org
> Cc: linux-snps-arc@lists.infradead.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-csky@vger.kernel.org
> Cc: linux-hexagon@vger.kernel.org
> Cc: linux-ia64@vger.kernel.org
> Cc: loongarch@lists.linux.dev
> Cc: linux-m68k@lists.linux-m68k.org
> Cc: Michal Simek <monstr@monstr.eu>
> Cc: Dinh Nguyen <dinguyen@kernel.org>
> Cc: linux-mips@vger.kernel.org
> Cc: openrisc@lists.librecores.org
> Cc: linux-parisc@vger.kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-riscv@lists.infradead.org
> Cc: linux-s390@vger.kernel.org
> Cc: linux-sh@vger.kernel.org
> Cc: sparclinux@vger.kernel.org
> Cc: linux-um@lists.infradead.org
> Cc: xen-devel@lists.xenproject.org
> Cc: linux-arch@vger.kernel.org
> Cc: linux-mm@kvack.org
> Tested-by: Pengfei Xu <pengfei.xu@intel.com>
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>

I'm not an arch maintainer, but it looks like a correct tree-wide
refactor.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
