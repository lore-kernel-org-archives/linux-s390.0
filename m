Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:21700 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728442AbgAGRnE (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 7 Jan 2020 12:43:04 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 007Heiwd111750
        for <linux-s390@vger.kernel.org>; Tue, 7 Jan 2020 12:43:03 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xb8umyaxg-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 07 Jan 2020 12:43:03 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Tue, 7 Jan 2020 17:43:00 -0000
Date: Tue, 7 Jan 2020 18:42:55 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH] mm/memblock: Define memblock_physmem_add()
References: <1578283835-21969-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578283835-21969-1-git-send-email-anshuman.khandual@arm.com>
Message-Id: <20200107174255.GB4684@osiris>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-mm@kvack.org, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Collin Walling <walling@linux.ibm.com>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Philipp Rudo <prudo@linux.ibm.com>, Mike Rapoport <rppt@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Jan 06, 2020 at 09:40:35AM +0530, Anshuman Khandual wrote:
> On s390 platform memblock.physmem array is being built by directly calling
> into memblock_add_range() which is a low level function not intended to be
> used outside of memblock. Hence lets conditionally add helper functions for
> physmem array when HAVE_MEMBLOCK_PHYS_MAP is enabled. Also use MAX_NUMNODES
> instead of 0 as node ID similar to memblock_add() and memblock_reserve().
> Make memblock_add_range() a static function as it is no longer getting used
> outside of memblock.
> 
> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Cc: Collin Walling <walling@linux.ibm.com>
> Cc: Gerald Schaefer <gerald.schaefer@de.ibm.com>
> Cc: Philipp Rudo <prudo@linux.ibm.com>
> Cc: Mike Rapoport <rppt@linux.ibm.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-s390@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
> Only build tested for s390, will appreciate if some one can give it a try
> on a real system.

Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>
