From: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH/RFC] s390: Provide a configuration and control device
Date: Tue, 01 Apr 2014 16:59:35 +0200
Message-ID: <533AD457.7030701@suse.de>
References: <1396363663-50450-1-git-send-email-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1396363663-50450-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Michael Mueller <mimu@linux.vnet.ibm.com>, Ekaterina Tumanova <tumanova@linux.vnet.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On 04/01/2014 04:47 PM, Christian Borntraeger wrote:
> We want to configure several things in KVM that go beyond what
> ENABLE_CAP (we need payload) or ONE_REG (we need it for the VM
> and we need to do more complex actions) can provide. Instead of
> adding several s390 specific ioctls, lets provide a configuration
> and control device that encapsulates different commands into
> groups of the same area (MEMORY, CPU, ..)
>
> We also provide an initial nameless base group, with a simple first
> user to set the guest name. We need that name in the kernel for
> the emulation of STSI (which provides the guest name to the guest)
> but we need to implement the emulation in supervisor mode, as it
> also provides the underlying levels of hipervisors.
>
> Currently we have the following GROUPS and ATTRs pending, which
> configure some memory management related function or allow to set
> the guest facilities, cpuids etc:
>
> #define KVM_DEV_CONFIG_GROUP            0
> #define KVM_DEV_CONFIG_NAME             0
>
> #define KVM_DEV_CONFIG_GROUP_MEM        1
> #define KVM_DEV_CONFIG_MEM_ENABLE_CMMA  0
> #define KVM_DEV_CONFIG_MEM_CLR_CMMA     1
> #define KVM_DEV_CONFIG_MEM_CLR_PAGES    2
>
> #define KVM_DEV_CONFIG_GROUP_CPU        2
> #define KVM_DEV_CONFIG_CPU_TYPE         0
> #define KVM_DEV_CONFIG_CPU_FAC          1
> #define KVM_DEV_CONFIG_CPU_FAC_MASK     2
> #define KVM_DEV_CONFIG_CPU_IBC          3
> #define KVM_DEV_CONFIG_CPU_IBC_RANGE    4

Why would CPU specific information be set in the VM?


Alex

>
>
>
> In addition other groups like
> #define KVM_DEV_CONFIG_GROUP_CRYPTO
> are under consideration to configure crypto acceleration.
>
> Unless there is a major concern, I will add this to the next
> s390 PULL requests for KVM.
>
> Christian
>
