Return-Path: <SRS0=MvP8=SN=vger.kernel.org=kvm-owner@kernel.org>
Subject: Re: [RFC v2 3/3] vfio-ccw: Release any channel program when
 releasing/removing vfio-ccw mdev
References: <cover.1554756534.git.alifm@linux.ibm.com>
 <ae9f20dc8873f2027f7b3c5d2aaa0bdfe06850b8.1554756534.git.alifm@linux.ibm.com>
 <20190411182755.1f3a2bd5.cohuck@redhat.com>
From: Farhan Ali <alifm@linux.ibm.com>
Date: Thu, 11 Apr 2019 16:39:32 -0400
MIME-Version: 1.0
In-Reply-To: <20190411182755.1f3a2bd5.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <7123f8b7-0348-4140-1b94-5d35ea1ef567@linux.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, farman@linux.ibm.com, pasic@linux.ibm.com, pmorel@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>



On 04/11/2019 12:27 PM, Cornelia Huck wrote:
> On Mon,  8 Apr 2019 17:05:33 -0400
> Farhan Ali<alifm@linux.ibm.com>  wrote:
> 
>> When releasing the vfio-ccw mdev, we currently do not release
>> any existing channel program and it's pinned pages. This can
> s/it's/its/
> 

Will fix.

Thanks for taking a look at the patches.

Thanks
Farhan
