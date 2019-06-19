Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40934 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726142AbfFSIWd (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 19 Jun 2019 04:22:33 -0400
Date: Wed, 19 Jun 2019 10:22:30 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [RFC PATCH v1 4/5] vfio-ccw: Factor out the ccw0-to-ccw1
 transition
Message-ID: <20190619102230.76e5638a.cohuck@redhat.com>
In-Reply-To: <20190618202352.39702-5-farman@linux.ibm.com>
References: <20190618202352.39702-1-farman@linux.ibm.com>
        <20190618202352.39702-5-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Eric Farman <farman@linux.ibm.com>
Cc: Farhan Ali <alifm@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org

On Tue, 18 Jun 2019 22:23:51 +0200
Eric Farman <farman@linux.ibm.com> wrote:

> This is a really useful function, but it's buried in the
> copy_ccw_from_iova() routine so that ccwchain_calc_length()
> can just work with Format-1 CCWs while doing its counting.
> But it means we're translating a full 2K of "CCWs" to Format-1,
> when in reality there's probably far fewer in that space.
> 
> Let's factor it out, so maybe we can do something with it later.

Agreed, this looks sensible.

> 
> Signed-off-by: Eric Farman <farman@linux.ibm.com>
> ---
>  drivers/s390/cio/vfio_ccw_cp.c | 48 ++++++++++++++++++----------------
>  1 file changed, 25 insertions(+), 23 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
