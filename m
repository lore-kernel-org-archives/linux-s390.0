Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43796 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730759AbfI3LEh (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 30 Sep 2019 07:04:37 -0400
Received: by mail-ed1-f65.google.com with SMTP id r9so8206088edl.10
        for <linux-s390@vger.kernel.org>; Mon, 30 Sep 2019 04:04:36 -0700 (PDT)
Date: Mon, 30 Sep 2019 14:04:34 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH] mm/page_alloc: fix a crash in free_pages_prepare()
Message-ID: <20190930110434.5k47w7xfvkjcohkp@box>
References: <1569613623-16820-1-git-send-email-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1569613623-16820-1-git-send-email-cai@lca.pw>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Qian Cai <cai@lca.pw>
Cc: akpm@linux-foundation.org, heiko.carstens@de.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com, linux-s390@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org

On Fri, Sep 27, 2019 at 03:47:03PM -0400, Qian Cai wrote:
> On architectures like s390, arch_free_page() could mark the page unused
> (set_page_unused()) and any access later would trigger a kernel panic.
> Fix it by moving arch_free_page() after all possible accessing calls.

Looks like Power also uses the hook. Have you check that this patch will
not affect Power?

-- 
 Kirill A. Shutemov
