Return-Path: <SRS0=iFEE=UC=vger.kernel.org=kvm-owner@kernel.org>
Subject: Re: [PULL 0/7] vfio-ccw: fixes
References: <20190603105038.11788-1-cohuck@redhat.com>
 <20190603111124.GB20699@osiris> <20190603131641.4ad411f0.cohuck@redhat.com>
From: Eric Farman <farman@linux.ibm.com>
Date: Mon, 3 Jun 2019 09:23:38 -0400
MIME-Version: 1.0
In-Reply-To: <20190603131641.4ad411f0.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <15ea4980-a6e2-64d5-b52f-0c7e84ae7c74@linux.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>



On 6/3/19 7:16 AM, Cornelia Huck wrote:
> On Mon, 3 Jun 2019 13:11:24 +0200
> Heiko Carstens <heiko.carstens@de.ibm.com> wrote:
> 
>> On Mon, Jun 03, 2019 at 12:50:31PM +0200, Cornelia Huck wrote:
>>> The following changes since commit 674459be116955e025d6a5e6142e2d500103de8e:
>>>
>>>   MAINTAINERS: add Vasily Gorbik and Christian Borntraeger for s390 (2019-05-31 10:14:15 +0200)
>>>
>>> are available in the Git repository at:
>>>
>>>   https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/vfio-ccw.git tags/vfio-ccw-20190603
>>>
>>> for you to fetch changes up to 9b6e57e5a51696171de990b3c41bd53d4b8ab8ac:
>>>
>>>   s390/cio: Remove vfio-ccw checks of command codes (2019-06-03 12:02:55 +0200)
>>>
>>> ----------------------------------------------------------------
>>> various vfio-ccw fixes (ccw translation, state machine)
>>>
>>> ----------------------------------------------------------------
>>>
>>> Eric Farman (7):
>>>   s390/cio: Update SCSW if it points to the end of the chain
>>>   s390/cio: Set vfio-ccw FSM state before ioeventfd
>>>   s390/cio: Split pfn_array_alloc_pin into pieces
>>>   s390/cio: Initialize the host addresses in pfn_array
>>>   s390/cio: Don't pin vfio pages for empty transfers
>>>   s390/cio: Allow zero-length CCWs in vfio-ccw
>>>   s390/cio: Remove vfio-ccw checks of command codes  
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

Agreed, it would be nice for 5.2, but the next merge window is fine with
me too.
