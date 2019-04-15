Return-Path: <SRS0=kLZb=SR=vger.kernel.org=kvm-owner@kernel.org>
Subject: Re: [PATCH v4 6/6] vfio-ccw: add handling for async channel
 instructions
References: <20190301093902.27799-1-cohuck@redhat.com>
 <20190301093902.27799-7-cohuck@redhat.com>
From: Farhan Ali <alifm@linux.ibm.com>
Date: Mon, 15 Apr 2019 11:25:23 -0400
MIME-Version: 1.0
In-Reply-To: <20190301093902.27799-7-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <0820ad60-9654-b031-a953-658abff6d6f8@linux.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Alex Williamson <alex.williamson@redhat.com>
List-ID: <linux-s390.vger.kernel.org>



On 03/01/2019 04:39 AM, Cornelia Huck wrote:
> Add a region to the vfio-ccw device that can be used to submit
> asynchronous I/O instructions. ssch continues to be handled by the
> existing I/O region; the new region handles hsch and csch.
> 
> Interrupt status continues to be reported through the same channels
> as for ssch.
> 
> Signed-off-by: Cornelia Huck<cohuck@redhat.com>

Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
