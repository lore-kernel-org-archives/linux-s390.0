Return-Path: <SRS0=nFot=SK=vger.kernel.org=kvm-owner@kernel.org>
Subject: Re: [PATCH v4 1/6] vfio-ccw: make it safe to access channel programs
References: <20190301093902.27799-1-cohuck@redhat.com>
 <20190301093902.27799-2-cohuck@redhat.com>
From: Farhan Ali <alifm@linux.ibm.com>
Date: Mon, 8 Apr 2019 13:02:12 -0400
MIME-Version: 1.0
In-Reply-To: <20190301093902.27799-2-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <9e81af36-ebd2-671b-5256-90e8efaad6f2@linux.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Alex Williamson <alex.williamson@redhat.com>
List-ID: <linux-s390.vger.kernel.org>



On 03/01/2019 04:38 AM, Cornelia Huck wrote:
> When we get a solicited interrupt, the start function may have
> been cleared by a csch, but we still have a channel program
> structure allocated. Make it safe to call the cp accessors in
> any case, so we can call them unconditionally.
> 
> While at it, also make sure that functions called from other parts
> of the code return gracefully if the channel program structure
> has not been initialized (even though that is a bug in the caller).
> 
> Reviewed-by: Eric Farman<farman@linux.ibm.com>
> Signed-off-by: Cornelia Huck<cohuck@redhat.com>
> ---

Hi Connie,

My series of fixes for vfio-ccw depends on this patch as I would like to 
call cp_free unconditionally :) (I had developed my code on top of your 
patches).

Could we pick this patch up as well when/if you pick up my patch series? 
I am in the process of sending out a v2.

Regarding this patch we could merge it as a stand alone patch, separate 
from this series. And also the patch LGTM

Reviewed-by: Farhan Ali <alifm@linux.ibm.com>

Thanks
Farhan
