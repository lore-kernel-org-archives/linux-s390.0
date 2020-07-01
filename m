Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45320 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731721AbgGAPgl (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 1 Jul 2020 11:36:41 -0400
Date: Wed, 1 Jul 2020 17:36:31 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH v2 1/2] mm/memblock: expose only miminal interface to
 add/walk physmem
Message-ID: <20200701153631.GD5008@osiris>
References: <20200701150643.GA2999146@linux.ibm.com>
 <62588A3E-81FA-4C79-B215-D1D33887597C@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62588A3E-81FA-4C79-B215-D1D33887597C@redhat.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: Mike Rapoport <rppt@linux.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-mm@kvack.org, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>

> >> While fixing up the documentation, sneak in some related cleanups. We can
> >> stop setting CONFIG_HAVE_MEMBLOCK_PHYS_MAP for s390x next.
> > As you noted in the previous version it should have been
> > CONFIG_ARCH_KEEP_MEMBLOCK ;-)
> Grml :) maybe maintainers can fix that up when applying in case
> there are no other comments.

Sure, just need to know how to handle this. :)
