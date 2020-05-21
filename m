Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:29499 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728754AbgEUXn1 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 21 May 2020 19:43:27 -0400
Date: Thu, 21 May 2020 16:43:09 -0700
From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH v2 0/7] padata: parallelize deferred page init
Message-ID: <20200521234309.GA244176@localhost>
References: <20200520182645.1658949-1-daniel.m.jordan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520182645.1658949-1-daniel.m.jordan@oracle.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Daniel Jordan <daniel.m.jordan@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert <steffen.klassert@secunet.com>, Alex Williamson <alex.williamson@redhat.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, Dan Williams <dan.j.williams@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, David Hildenbrand <david@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>, Jonathan Corbet <corbet@lwn.net>, Kirill Tkhai <ktkhai@virtuozzo.com>, Michal Hocko <mhocko@kernel.org>, Pavel Machek <pavel@ucw.cz>, Pavel Tatashin <pasha.tatashin@soleen.com>, Peter Zijlstra <peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>, Robert Elliott <elliott@hpe.com>, Shile Zhang <shile.zhang@linux.alibaba.com>, Steven Sistare <steven.sistare@oracle.com>, Tejun Heo <tj@kernel.org>, Zi Yan <ziy@nvidia.com>, linux-crypto@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org

On Wed, May 20, 2020 at 02:26:38PM -0400, Daniel Jordan wrote:
> Please review and test, and thanks to Alex, Andrew, Josh, and Pavel for
> their feedback in the last version.

I re-tested v2:

Tested-by: Josh Triplett <josh@joshtriplett.org>

[    0.231435] node 1 initialised, 24189223 pages in 32ms
[    0.236718] node 0 initialised, 23398907 pages in 36ms
