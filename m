From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Subject: Re: [RFC 00/19] KVM: s390/crypto/vfio: guest dedicated crypto
 adapters
Date: Mon, 16 Oct 2017 12:27:52 -0400
Message-ID: <ff3f4234-43b6-7a2f-9198-13477141bffd@linux.vnet.ibm.com>
References: <1507916344-3896-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <20171016120514.62145b4f.cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171016120514.62145b4f.cohuck@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, qemu-s390x@nongnu.org, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 10/16/2017 06:05 AM, Cornelia Huck wrote:
> On Fri, 13 Oct 2017 13:38:45 -0400
> Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:
>
>> Overview:
>> --------
>> An adjunct processor (AP) facility is an IBM Z cryptographic facility. The
>> AP facility is comprised of three AP instructions and from 1 to 256 AP
>> adapter cards. The design takes advantage of the interpretive execution mode
>> provided by the SIE architecture. With interpretive execution mode, the AP
>> instructions executed on the guest are interpreted by the hardware. This
>> allows guests direct access to AP adapter cards. The first goal of this
>> patch series is to provide direct access by a KVM guest to an AP as a
>> pass-through device. The second goal is to provide administrators with the
>> means to configure KVM guests to grant direct access to AP facilities
>> assigned to the LPAR in which the host linux system is running.
>>
>> To facilitate the comprehension of the design, let's present an overview of
>> the AP architecture.
> I have not yet looked at the patches (and I'm not sure whether I'll be
> able to do so until after the KVM Forum), but I think this also needs
> some explanation under Documentation/, so people can still make sense
> of it in the future.
That makes sense, I will create a document.
>
