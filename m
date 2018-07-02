From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v6 05/21] KVM: s390: CPU model support for AP
 virtualization
Date: Mon, 2 Jul 2018 18:04:07 +0200
Message-ID: <9da385ec-2de6-17bd-3653-6feb9641fcb2@linux.ibm.com>
References: <1530306683-7270-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1530306683-7270-6-git-send-email-akrowiak@linux.vnet.ibm.com>
 <ceb1d797-9bb3-cb6e-c510-657fc61a7f82@de.ibm.com>
 <276b5ae7-7f27-faae-1e5a-0d4c084139e9@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <276b5ae7-7f27-faae-1e5a-0d4c084139e9@linux.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Tony Krowiak <akrowiak@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>



On 07/02/2018 05:37 PM, Tony Krowiak wrote:
> On 07/02/2018 10:38 AM, Christian Borntraeger wrote:
>>
>> On 06/29/2018 11:11 PM, Tony Krowiak wrote:
>>> Introduces a new CPU model feature and two CPU model
>>> facilities to support AP virtualization for KVM guests.
>>>
>>> CPU model feature:
>>>
>>> The KVM_S390_VM_CPU_FEAT_AP feature indicates that
>>> AP instructions are available on the guest. This
>>> feature will be enabled by the kernel only if the AP
>>> instructions are installed on the linux host. This feature
>>> must be specifically turned on for the KVM guest from
>>> userspace to use the VFIO AP device driver for guest
>>> access to AP devices.
>>>
>>> CPU model facilities:
>>>
>>> 1. AP Query Configuration Information (QCI) facility is installed.
>>>
>>>     This is indicated by setting facilities bit 12 for
>>>     the guest. The kernel will not enable this facility
>>>     for the guest if it is not set on the host. This facility
>>>     must not be set by userspace if the KVM_S390_VM_CPU_FEAT_AP
>>>     feature is not installed.
>>>
>>>     If this facility is not set for the KVM guest, then only
>>>     APQNs with an APQI less than 16 will be available to the
>>>     guest regardless of the guest's matrix configuration. This
>>>     is a limitation of the AP bus running on the guest.
>>>
>>> 2. AP Facilities Test facility (APFT) is installed.
>>>
>>>     This is indicated by setting facilities bit 15 for
>>>     the guest. The kernel will not enable this facility for
>>>     the guest if it is not set on the host. This facility
>>>     must not be set by userspace if the KVM_S390_VM_CPU_FEAT_AP
>>>     feature is not installed.
>>>
>>>     If this facility is not set for the KVM guest, then no
>>>     AP devices will be available to the guest regardless of
>>>     the guest's matrix configuration. This is a limitation
>>>     of the AP bus running under the guest.
>>>
>>> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
>>> Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
>>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
>> I think it probably should be at the end of the series, other than that its good.
> 
> If I move this to the end of the series, the very next patch checks the
> 
> KVM_S390_VM_CPU_FEAT_AP feature?
> 

The point is the following: never expose a feature *before* it
is actually provided. And this is exactly what you are doing here.

AFAIU the userspace can happily negotiate KVM_S390_VM_CPU_FEAT_AP,
do it's part of the job and still not have AP instructions in the guest
if patches [0..5] are applied but [6..21] not. This is wrong.

AFAIR I requested this one being squashed with the next one for exact
this reason. That would be OK as starting with patch 6 applied we
do satisfy what the features require. It's only that the interfaces
required to set up the resources are not there yet and thus the features
can't really be used meaningfully.

Usually we expose the features at the end of a series, as such a series
often just implements support for the given feature(s).

In this special IMHO case we can get away with not doing so, but not
exposing the feature until the end of the series could still have some
merit.

Anyway we should avoid exposing half-assed stuff. In that sense the
resource cleanup (zapq) logic must not be introduced after
resources can be acquired and utilized.

Regards,
Halil
