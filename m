From: Cornelia Huck <cohuck@redhat.com>
Date: Mon, 25 Feb 2019 09:20:31 +0000
Subject: Re: [PATCH 2/2] s390/cio: Use cpa range elsewhere within vfio-ccw
Message-Id: <20190225102031.5f7429d2.cohuck@redhat.com>
In-Reply-To: <20190222183941.29596-3-farman@linux.ibm.com>
References: <20190222183941.29596-3-farman@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Fri, 22 Feb 2019 19:39:41 +0100
Eric Farman <farman@linux.ibm.com> wrote:

> Since we have a little function to see whether a channel
> program address falls within a range of CCWs, let's use
> it in the other places of code that make these checks.
> 
> (Why isn't ccw_head fully removed?  Well, because this
> way some longs lines don't have to be reflowed.)
> 
> Signed-off-by: Eric Farman <farman@linux.ibm.com>
> ---
>  drivers/s390/cio/vfio_ccw_cp.c | 18 ++++++------------
>  1 file changed, 6 insertions(+), 12 deletions(-)

Also looks good to me.

I'll be happy to queue these (but would like another R-b or so.)
