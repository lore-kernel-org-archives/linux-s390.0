Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH v3 1/1] s390: virtio: let arch accept devices without
 IOMMU feature
References: <1592390637-17441-1-git-send-email-pmorel@linux.ibm.com>
 <1592390637-17441-2-git-send-email-pmorel@linux.ibm.com>
 <20200618002956.5f179de4.pasic@linux.ibm.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Message-ID: <10b0c837-7609-fb87-857e-5c364b06ab8b@linux.ibm.com>
Date: Mon, 29 Jun 2020 15:21:38 +0200
MIME-Version: 1.0
In-Reply-To: <20200618002956.5f179de4.pasic@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, borntraeger@de.ibm.com, frankja@linux.ibm.com, mst@redhat.com, jasowang@redhat.com, cohuck@redhat.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org, thomas.lendacky@amd.com, david@gibson.dropbear.id.au, linuxram@us.ibm.com, heiko.carstens@de.ibm.com, gor@linux.ibm.com



On 2020-06-18 00:29, Halil Pasic wrote:
> On Wed, 17 Jun 2020 12:43:57 +0200
> Pierre Morel <pmorel@linux.ibm.com> wrote:
> 
>> An architecture protecting the guest memory against unauthorized host
>> access may want to enforce VIRTIO I/O device protection through the
>> use of VIRTIO_F_IOMMU_PLATFORM.
>>
>> Let's give a chance to the architecture to accept or not devices
>> without VIRTIO_F_IOMMU_PLATFORM.
>>
> [..]
> 
> 
> I'm still not really satisfied with your commit message, furthermore
> I did some thinking about the abstraction you introduce here. I will
> give a short analysis of that, but first things first. Your patch does
> the job of preventing calamity, and the details can be changed any time,
> thus:
> 
> Acked-by: Halil Pasic <pasic@linux.ibm.com>

Thanks,

Connie already answered the other points you raised and I have nothing 
to add on it.

Regards,
Pierre


-- 
Pierre Morel
IBM Lab Boeblingen
