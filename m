Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50076 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728802AbgDUOCR (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 21 Apr 2020 10:02:17 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03LDYw4m082709
        for <linux-s390@vger.kernel.org>; Tue, 21 Apr 2020 10:02:17 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30gmuynwfe-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 21 Apr 2020 10:02:16 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <gerald.schaefer@de.ibm.com>;
        Tue, 21 Apr 2020 15:01:30 +0100
Date: Tue, 21 Apr 2020 16:02:01 +0200
From: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Subject: Re: [PATCH v3 0/4] Clean up hugetlb boot command line processing
In-Reply-To: <20200417185049.275845-1-mike.kravetz@oracle.com>
References: <20200417185049.275845-1-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20200421160201.0ddb9763@thinkpad>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Mike Kravetz <mike.kravetz@oracle.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, linux-doc@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, "David S . Miller" <davem@davemloft.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, Jonathan Corbet <corbet@lwn.net>, Longpeng <longpeng2@huawei.com>, Christophe Leroy <christophe.leroy@c-s.fr>, Randy Dunlap <rdunlap@infradead.org>, Mina Almasry <almasrymina@google.com>, Peter Xu <peterx@redhat.com>, Nitesh Narayan Lal <nitesh@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Gerald Schaefer <gerald.schaefer@de.ibm.com>

On Fri, 17 Apr 2020 11:50:45 -0700
Mike Kravetz <mike.kravetz@oracle.com> wrote:

> v3 -
>    Used weak attribute method of defining arch_hugetlb_valid_size.
>      This eliminates changes to arch specific hugetlb.h files (Peter)
>    Updated documentation (Peter, Randy)
>    Fixed handling of implicitly specified gigantic page preallocation
>      in existing code and removed documentation of such.  There is now
>      no difference between handling of gigantic and non-gigantic pages.
>      (Peter, Nitesh).
>      This requires the most review as there is a small change to
>      undocumented behavior.  See patch 4 commit message for details.
>    Added Acks and Reviews (Mina, Peter)
> 
> v2 -
>    Fix build errors with patch 1 (Will)
>    Change arch_hugetlb_valid_size arg to unsigned long and remove
>      irrelevant 'extern' keyword (Christophe)
>    Documentation and other misc changes (Randy, Christophe, Mina)
>    Do not process command line options if !hugepages_supported()
>      (Dave, but it sounds like we may want to additional changes to
>       hugepages_supported() for x86?  If that is needed I would prefer
>       a separate patch.)
> 
> Longpeng(Mike) reported a weird message from hugetlb command line processing
> and proposed a solution [1].  While the proposed patch does address the
> specific issue, there are other related issues in command line processing.
> As hugetlbfs evolved, updates to command line processing have been made to
> meet immediate needs and not necessarily in a coordinated manner.  The result
> is that some processing is done in arch specific code, some is done in arch
> independent code and coordination is problematic.  Semantics can vary between
> architectures.
> 
> The patch series does the following:
> - Define arch specific arch_hugetlb_valid_size routine used to validate
>   passed huge page sizes.
> - Move hugepagesz= command line parsing out of arch specific code and into
>   an arch independent routine.
> - Clean up command line processing to follow desired semantics and
>   document those semantics.
> 
> [1] https://lore.kernel.org/linux-mm/20200305033014.1152-1-longpeng2@huawei.com
> 
> Mike Kravetz (4):
>   hugetlbfs: add arch_hugetlb_valid_size
>   hugetlbfs: move hugepagesz= parsing to arch independent code
>   hugetlbfs: remove hugetlb_add_hstate() warning for existing hstate
>   hugetlbfs: clean up command line processing
> 
>  .../admin-guide/kernel-parameters.txt         |  40 ++--
>  Documentation/admin-guide/mm/hugetlbpage.rst  |  35 ++++
>  arch/arm64/mm/hugetlbpage.c                   |  30 +--
>  arch/powerpc/mm/hugetlbpage.c                 |  30 +--
>  arch/riscv/mm/hugetlbpage.c                   |  24 +--
>  arch/s390/mm/hugetlbpage.c                    |  24 +--
>  arch/sparc/mm/init_64.c                       |  43 +---
>  arch/x86/mm/hugetlbpage.c                     |  23 +--
>  include/linux/hugetlb.h                       |   2 +-
>  mm/hugetlb.c                                  | 190 +++++++++++++++---
>  10 files changed, 271 insertions(+), 170 deletions(-)
> 

Looks good and works fine for s390, thanks for cleaning up!

Acked-by: Gerald Schaefer <gerald.schaefer@de.ibm.com> # s390
