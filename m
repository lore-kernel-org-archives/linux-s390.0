Return-Path: <SRS0=iFEE=UC=vger.kernel.org=kvm-owner@kernel.org>
Subject: Re: [PULL 0/7] vfio-ccw: fixes
References: <20190603105038.11788-1-cohuck@redhat.com>
 <20190603111124.GB20699@osiris> <20190603131641.4ad411f0.cohuck@redhat.com>
From: Farhan Ali <alifm@linux.ibm.com>
Date: Mon, 3 Jun 2019 09:00:40 -0400
MIME-Version: 1.0
In-Reply-To: <20190603131641.4ad411f0.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <394f638d-dbef-3339-9311-ccb3ef2dbea8@linux.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Eric Farman <farman@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>



On 06/03/2019 07:16 AM, Cornelia Huck wrote:
> On Mon, 3 Jun 2019 13:11:24 +0200
> Heiko Carstens <heiko.carstens@de.ibm.com> wrote:
> 
>> On Mon, Jun 03, 2019 at 12:50:31PM +0200, Cornelia Huck wrote:
>>> The following changes since commit 674459be116955e025d6a5e6142e2d500103de8e:
>>>
>>>    MAINTAINERS: add Vasily Gorbik and Christian Borntraeger for s390 (2019-05-31 10:14:15 +0200)
>>>
>>> are available in the Git repository at:
>>>
>>>    https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/vfio-ccw.git tags/vfio-ccw-20190603
>>>
>>> for you to fetch changes up to 9b6e57e5a51696171de990b3c41bd53d4b8ab8ac:
>>>
>>>    s390/cio: Remove vfio-ccw checks of command codes (2019-06-03 12:02:55 +0200)
>>>
>>> ----------------------------------------------------------------
>>> various vfio-ccw fixes (ccw translation, state machine)
>>>
>>> ----------------------------------------------------------------
>>>
>>> Eric Farman (7):
>>>    s390/cio: Update SCSW if it points to the end of the chain
>>>    s390/cio: Set vfio-ccw FSM state before ioeventfd
>>>    s390/cio: Split pfn_array_alloc_pin into pieces
>>>    s390/cio: Initialize the host addresses in pfn_array
>>>    s390/cio: Don't pin vfio pages for empty transfers
>>>    s390/cio: Allow zero-length CCWs in vfio-ccw
>>>    s390/cio: Remove vfio-ccw checks of command codes
>>
>> Given that none of the commits contains a stable tag, I assume it's ok
>> to schedule these for the next merge window (aka 'feature branch')?
> 
> All are bug fixes, but for what I think are edge cases. Would be nice
> if they could still make it into 5.2, but I have no real problem with
> deferring them to the next release, either.
> 
> Eric, Farhan: Do you agree?
> 
> 
IMHO the first 2 patches should be merged as early as possible. The 2nd 
patch specially for setting the vfio-ccw device state before notifying 
the guest, so the guest doesn't see unexpected errors. This fixes a 
problem that both Eric and I have noticed with long running fio workloads.

The rest of the patches could go as a features for the next merge window.

Thanks
Farhan
