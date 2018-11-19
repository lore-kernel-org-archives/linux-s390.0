From: Farhan Ali <alifm@linux.ibm.com>
Date: Mon, 19 Nov 2018 14:45:29 +0000
Subject: Re: [RFC PATCH v1 05/10] s390/cio: Use common channel program processor for TIC
Message-Id: <d6d081df-aff1-89b5-c1fb-2342daf6b1d6@linux.ibm.com>
In-Reply-To: <e41af390-1ed2-eea2-883f-aea1d28fb7bf@linux.ibm.com>
References: <e41af390-1ed2-eea2-883f-aea1d28fb7bf@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>



On 11/08/2018 09:39 PM, Eric Farman wrote:
> Now that a channel program is examined by a separate routine,
> we can replace much of the TIC code with a call to that function.
> 
> Signed-off-by: Eric Farman<farman@linux.ibm.com>
> ---
>   drivers/s390/cio/vfio_ccw_cp.c | 39 ++++-----------------------------------
>   1 file changed, 4 insertions(+), 35 deletions(-)

Reviewed-by: Farhan Ali<alifm@linux.ibm.com>
