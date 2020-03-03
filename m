Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:52552 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731591AbgCCRsU (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 3 Mar 2020 12:48:20 -0500
Subject: Re: [RFC 2/3] mm/vma: Introduce VM_ACCESS_FLAGS
References: <1583131666-15531-1-git-send-email-anshuman.khandual@arm.com>
 <1583131666-15531-3-git-send-email-anshuman.khandual@arm.com>
From: Vlastimil Babka <vbabka@suse.cz>
Message-ID: <52b4565f-2dab-c3e5-ead8-d76258f43a10@suse.cz>
Date: Tue, 3 Mar 2020 18:48:15 +0100
MIME-Version: 1.0
In-Reply-To: <1583131666-15531-3-git-send-email-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org
Cc: Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Mark Salter <msalter@redhat.com>, Nick Hu <nickhu@andestech.com>, Ley Foon Tan <ley.foon.tan@intel.com>, Michael Ellerman <mpe@ellerman.id.au>, Heiko Carstens <heiko.carstens@de.ibm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Guan Xuetao <gxt@pku.edu.cn>, Dave Hansen <dave.hansen@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, Rob Springer <rspringer@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org, nios2-dev@lists.rocketboards.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org

On 3/2/20 7:47 AM, Anshuman Khandual wrote:
> There are many places where all basic VMA access flags (read, write, exec)
> are initialized or checked against as a group. One such example is during
> page fault. Existing vma_is_accessible() wrapper already creates the notion
> of VMA accessibility as a group access permissions. Hence lets just create
> VM_ACCESS_FLAGS (VM_READ|VM_WRITE|VM_EXEC) which will not only reduce code
> duplication but also extend the VMA accessibility concept in general.
> 
> Cc: Russell King <linux@armlinux.org.uk>
> CC: Catalin Marinas <catalin.marinas@arm.com>
> CC: Mark Salter <msalter@redhat.com>
> Cc: Nick Hu <nickhu@andestech.com>
> CC: Ley Foon Tan <ley.foon.tan@intel.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Guan Xuetao <gxt@pku.edu.cn>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Rob Springer <rspringer@google.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-c6x-dev@linux-c6x.org
> Cc: nios2-dev@lists.rocketboards.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-s390@vger.kernel.org
> Cc: linux-sh@vger.kernel.org
> Cc: devel@driverdev.osuosl.org
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

Dunno. Such mask seems ok for testing flags, but it's a bit awkward when
initializing flags, where it covers just one of many combinations that seem
used. But no strong opinions, patch looks correct.
