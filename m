Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44922 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726805AbgCBNq6 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 2 Mar 2020 08:46:58 -0500
Date: Mon, 2 Mar 2020 14:46:55 +0100
From: Michal Hocko <mhocko@kernel.org>
Subject: Re: [RFC v1 1/2] mm/gup: fixup for 9947ea2c1e608e32 "mm/gup: track
 FOLL_PIN pages"
Message-ID: <20200302134655.GL4380@dhcp22.suse.cz>
References: <20200228154322.329228-1-imbrenda@linux.ibm.com>
 <20200228154322.329228-3-imbrenda@linux.ibm.com>
 <c98038da-cf52-27f5-1aed-b69287a5dec0@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c98038da-cf52-27f5-1aed-b69287a5dec0@nvidia.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: John Hubbard <jhubbard@nvidia.com>
Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-next@vger.kernel.org, akpm@linux-foundation.org, borntraeger@de.ibm.com, david@redhat.com, aarcange@redhat.com, linux-mm@kvack.org, frankja@linux.ibm.com, sfr@canb.auug.org.au, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Jan Kara <jack@suse.cz>, "Kirill A. Shutemov" <kirill@shutemov.name>

On Fri 28-02-20 15:08:35, John Hubbard wrote:
[...]
> (Aside: I'm using the linux-next commit hash. How does one get the correct hash before
> it goes to mainline? I guess maintainer scripts fix all those up?)

There is no such maging going on AFAIK. Please just do not use sha1 from
linux-next unless it is really clear that those are not going to change.
So essentially everything from mmotm is out of question.
-- 
Michal Hocko
SUSE Labs
