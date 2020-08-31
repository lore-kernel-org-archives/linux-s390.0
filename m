Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:40682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725886AbgHaTP4 (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 31 Aug 2020 15:15:56 -0400
Date: Mon, 31 Aug 2020 12:15:53 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH 0/2] mm/gup: fix gup_fast with dynamic page table
 folding
Message-Id: <20200831121553.8be5dcdbdbc5256846ac513e@linux-foundation.org>
In-Reply-To: <9071c9fa-ba6a-90dc-2d7a-8b155141d890@de.ibm.com>
References: <20200828140314.8556-1-gerald.schaefer@linux.ibm.com>
        <9071c9fa-ba6a-90dc-2d7a-8b155141d890@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>, Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>

On Mon, 31 Aug 2020 13:53:36 +0200 Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> 
> 
> On 28.08.20 16:03, Gerald Schaefer wrote:
> have some feedback soon if option 1 or option 2 would be acceptable 
> from a common code perspective. Andrew, who of the mm people would 
> be the right one to decide?

Jason and John Hubbard are doing most of the work in there at present,

Both patches look OK to me from a non-s390 perspective.  Unless we plan
to implement Jason's more-general approach this time, I'd be inclined
to defer to the s390 people as to the preferred implementation.
