Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:61128 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725648AbgGCIcG (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 3 Jul 2020 04:32:06 -0400
Date: Fri, 3 Jul 2020 10:31:54 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH v2 1/2] mm/memblock: expose only miminal interface to
 add/walk physmem
Message-ID: <20200703083154.GD4582@osiris>
References: <20200701141830.18749-1-david@redhat.com>
 <20200701141830.18749-2-david@redhat.com>
 <20200701150643.GA2999146@linux.ibm.com>
 <20200701153157.GC5008@osiris>
 <9a6728b2-05d3-0e98-dc45-a3e4821e0539@redhat.com>
 <20200702214852.f6ab03dc8d072abf35359d3b@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702214852.f6ab03dc8d072abf35359d3b@linux-foundation.org>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>, Mike Rapoport <rppt@linux.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-mm@kvack.org, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>

On Thu, Jul 02, 2020 at 09:48:52PM -0700, Andrew Morton wrote:
> On Thu, 2 Jul 2020 09:23:10 +0200 David Hildenbrand <david@redhat.com> wrote:
> 
> > >>> ---
> > >>>  arch/s390/kernel/crash_dump.c |  6 ++--
> > >>>  include/linux/memblock.h      | 28 ++++++++++++++---
> > >>>  mm/memblock.c                 | 57 ++++++++++++++++++-----------------
> > >>>  3 files changed, 55 insertions(+), 36 deletions(-)
> > > 
> > > So I guess this should go via the s390 tree, since the second patch of
> > > this series can go only upstream if both this patch and a patch which
> > > is currently only on our features are merged before.
> > > 
> > > Any objections?
> > 
> > @Andrew, fine with you if this goes via the s390 tree?
> 
> Sure, please go ahead.

Ok, applied both patches. Thanks!
