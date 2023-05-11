Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 064A8C7EE25
	for <linux-s390@archiver.kernel.org>; Thu, 11 May 2023 22:37:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239367AbjEKWhW (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 11 May 2023 18:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239225AbjEKWhV (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 11 May 2023 18:37:21 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94661559E
        for <linux-s390@vger.kernel.org>; Thu, 11 May 2023 15:37:18 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-559f1819c5dso138783287b3.0
        for <linux-s390@vger.kernel.org>; Thu, 11 May 2023 15:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683844637; x=1686436637;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y7hKTTTuYzAS0vkkDuN/hWvEkav8P49YQtcFz2W5wMI=;
        b=leqASNj4yXDwWkS3XyfGWIhxAw4SXxeg+extgQ/D3LGDyC8VCP1/fZdCDvzoBwFKI4
         QsCpGgSaYJ3A6Zsn21DOX95W5x878ZXSFyOvGdFILF6cniMlbGpQ7kGstvh8Z0S2dYcr
         KAZan2e+K8+hIYGfwKwpNjm5N5qCVBq6paKd8Ge6TYCsDubNG0nFnc28YyshVIf+H1TB
         XtjHozhI9s8vKDiN1ralH7fr2aSIYGrsjfbuSUekrZzkfIqSGnPlfgmSzyftn9ttXqkA
         wtISLC6kLw6VjZt4HnbIKNxY1VCI8P1bODtk830M8QQedX+j6RlN/KsBHhJiNcIqK0oT
         5pFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683844637; x=1686436637;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y7hKTTTuYzAS0vkkDuN/hWvEkav8P49YQtcFz2W5wMI=;
        b=gAOjmnArV49PtO3MSG58oMTfzKyN2gpAShdqcG/zE8DULyQZ1zKO952xr5NlY0k4BP
         2IepeQ2BjCILsmIH2nVGIz0jBvCc46ozeJPb9YRa3z3zJZLNTGKM//J6lkqsn7jtvAbr
         WBjTA/hYSowRZnYnzOHITGP/KeHxlVlZYlHXgaq7IGpkSrqO+5ZfBvFb98aAGEXbZuw+
         lPDeZsPQWBpZxaUKa5KuCwxjxvQn0RRbF4GumwKB7H+F3SNuGVOjb/VeiR5JF0N/Hob6
         0go/dfYfjMc3z0N50ZtLcpblCYLhlmr6USlS7J32n7ks7ygUTHPkMkO1jDYegi8bVHgW
         bZtA==
X-Gm-Message-State: AC+VfDw+SShLhwRE9AiqZMHVy8orxMiUiZgzkZi/NqBqY3dW8MtVNBcu
        3ej3ypZwPcL0xIKkrITDtS54vw==
X-Google-Smtp-Source: ACHHUZ5ulkW3cY83+IL8attIxR7bTyRhvIioTTYSGrJhrY5IS/y6LwBFwFzMwChvIicQOTRvegivGA==
X-Received: by 2002:a0d:d993:0:b0:559:d294:1c48 with SMTP id b141-20020a0dd993000000b00559d2941c48mr22473279ywe.24.1683844637583;
        Thu, 11 May 2023 15:37:17 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id k189-20020a0dfac6000000b0054fa5f6c0cdsm5262641ywf.53.2023.05.11.15.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 15:37:17 -0700 (PDT)
Date:   Thu, 11 May 2023 15:37:06 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Matthew Wilcox <willy@infradead.org>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Helge Deller <deller@gmx.de>,
        John David Anglin <dave.anglin@bell.net>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        "David S. Miller" <davem@davemloft.net>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Michel Lespinasse <michel@lespinasse.org>
Subject: Re: [PATCH 00/23] arch: allow pte_offset_map[_lock]() to fail
In-Reply-To: <ZFz1j1slZHCQmwMJ@casper.infradead.org>
Message-ID: <5f1dd6f-1e75-8d98-3083-e1bd2163dcc6@google.com>
References: <77a5d8c-406b-7068-4f17-23b7ac53bc83@google.com> <ZFs0k2rrLPH9A/UU@casper.infradead.org> <d7f3c7b2-25b8-ef66-98a8-43d68f4499f@google.com> <ZFz1j1slZHCQmwMJ@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, 11 May 2023, Matthew Wilcox wrote:
> 
> I was thinking that removing CONFIG_HIGHPTE might simplify the page
> fault handling path a little, but now I've looked at it some more, and
> I'm not sure there's any simplification to be had.  It should probably
> use kmap_local instead of kmap_atomic(), though.

Re kmap_local, yes, one of the patches in the next series does make
that change.

> 
> I infer that what you need is a pte_access_start() and a
> pte_access_end() which look like they can be plausibly rcu_read_lock()
> and rcu_read_unlock(), but might need to be local_irq_save() and
> local_irq_restore() in some configurations?

Yes, except that the local_irq_restore() in PAE-like configurations
(if we need it at all) is not delayed until the pte_access_end() or
pte_unmap() - it's internal to the pte_access_start() or pte_offset_map():
interrupts only disabled across the getting of a consistent pmd entry.

Over-generalizing a little, any user of pte_offset_map() (as opposed to
pte_offset_map_lock()) has to be prepared for the ptes to change under
them: but we do need to give them something that is or was recently the
relevant page table, rather than a random page mishmashed from mismatched
pmd_low and pmd_high.

> 
> We also talked about moving x86 to always RCU-free page tables in
> order to make accessing /proc/$pid/smaps lockless.  I believe Michel
> is going to take a swing at this project.

(And /proc/$pid/numa_maps, I hope: that's even worse in some way, IIRC.)

That might be orthogonal to what I'm doing: many non-x86 architectures
already do RCU-freeing of page tables via the TLB route, but that doesn't
cover a pte_free() from retract_page_tables() or collapse_and_free_pmd().

Hugh
