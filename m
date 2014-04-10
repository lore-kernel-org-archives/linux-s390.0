From: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 0/3]  Introduce per-vm kvm device attributes
Date: Thu, 10 Apr 2014 13:37:54 +0200
Message-ID: <53468292.5080200@suse.de>
References: <1397128604-50161-1-git-send-email-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1397128604-50161-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Marcelo Tosatti <mtosatti@redhat.com>, Gleb Natapov <gleb@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Dominik Dingel <dingel@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>


On 10.04.14 13:16, Christian Borntraeger wrote:
> Marcelo, Gleb, Alex,
>
> this is a followup to the recent discussion (re config device)
>
> To avoid a bunch of new ioctl, lets reuse the device attributes on
> the "VM device". All of these attributes are architecture specific.
> Patch1 introduces the interface,
> Patch2 makes CMMA configurable
> Patch3 uses the interface introduced in patch1
>
> Marcelo, Gleb, Alex, are you ok with the approach of patch 1? Then we
> will continue using that for VM specific controls instead of adding
> new ioctls. (Otherwise we will continue with new ioctl).

Looks reasonable to me, though I wouldn't be opposed to ENABLE_CAP + 
specific ioctl for reset in this case either. Whatever works better for 
you guys.

Acked-by: Alexander Graf <agraf@suse.de>


Alex
