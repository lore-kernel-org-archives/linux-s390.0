From: Halil Pasic <pasic@linux.vnet.ibm.com>
Subject: Re: [PATCH] vfio-ccw: process ssch with interrupts disabled
Date: Thu, 19 Apr 2018 14:01:09 +0200
Message-ID: <dd958a03-d5e8-c826-6fc6-7229c3acbe1e@linux.vnet.ibm.com>
References: <20180413140509.9042-1-cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180413140509.9042-1-cohuck@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>, Dong Jia Shi <bjsdjshi@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>



On 04/13/2018 04:05 PM, Cornelia Huck wrote:
> When we call ssch, an interrupt might already be pending once we
> return from the START SUBCHANNEL instruction. Therefore we need to
> make sure interrupts are disabled until after we're done with our
> processing.
> 
> Note that the subchannel lock is the same as the ccwdevice lock that
> is mentioned in the documentation for ccw_device_start() and friends.
> 
> Signed-off-by: Cornelia Huck<cohuck@redhat.com>

Acked-by: Halil Pasic <pasic@linux.vnet.ibm.com>
