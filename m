From: Farhan Ali <alifm@linux.ibm.com>
Date: Mon, 19 Nov 2018 14:33:55 +0000
Subject: Re: [RFC PATCH v1 04/10] s390/cio: Breakout the processing of a channel program
Message-Id: <dfc76794-d900-f6dd-a8cc-1bfb59f19607@linux.ibm.com>
In-Reply-To: <20181109023937.96105-5-farman@linux.ibm.com>
References: <20181109023937.96105-5-farman@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>



On 11/08/2018 09:39 PM, Eric Farman wrote:
> Handle the things that are specific to one or more CCWs
> outside of the mainline of the cp_init function.
> 
> Signed-off-by: Eric Farman<farman@linux.ibm.com>
> ---
>   drivers/s390/cio/vfio_ccw_cp.c | 58 +++++++++++++++++++++++++-----------------
>   drivers/s390/cio/vfio_ccw_cp.h |  1 +
>   2 files changed, 36 insertions(+), 23 deletions(-)

I think the code cleanups in patches 4 and 5 looks good to me.
This is mostly just shifting around existing code.

Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
