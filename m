Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:7936 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725833AbgFZR0S (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 26 Jun 2020 13:26:18 -0400
Date: Fri, 26 Jun 2020 19:26:08 +0200
From: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Subject: Re: [PATCH RFC] s390x/vmem: get rid of memory segment list
Message-ID: <20200626192608.354c43f6@thinkpad>
In-Reply-To: <20200626192253.2281d95d@thinkpad>
References: <20200625150029.45019-1-david@redhat.com>
        <20200626192253.2281d95d@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-mm@kvack.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>

On Fri, 26 Jun 2020 19:22:53 +0200
Gerald Schaefer <gerald.schaefer@de.ibm.com> wrote:

[...]
> 
> That should be OK, as it is also the same message that we already
> see for overlaps with other DCSSs. But you probably also should
> remove that case from the segment_warning() function for
> completeness.

... and also from the comment of segment_load()
