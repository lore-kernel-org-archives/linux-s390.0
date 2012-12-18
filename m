From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH v5 0/3] s390: Guest support for virtio-ccw.
Date: Tue, 18 Dec 2012 09:13:09 +0100
Message-ID: <50D02595.8040208@de.ibm.com>
References: <1355500938-35344-1-git-send-email-cornelia.huck@de.ibm.com> <7613CB93-4C0D-4B68-B473-05DF99FE1EE9@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <7613CB93-4C0D-4B68-B473-05DF99FE1EE9@suse.de>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Alexander Graf <agraf@suse.de>, Marcelo Tosatti <mtosatti@redhat.com>, Gleb Natapov <gleb@redhat.com>
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Carsten Otte <cotte@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On 17/12/12 16:00, Alexander Graf wrote:
> 
> On 14.12.2012, at 17:02, Cornelia Huck wrote:
> 
>> Hi,
>>
>> here's the virtio-ccw guest support for kvm/next again.
>>
>> The not-kvm specific patches have made their way upstream via the
>> s390 tree in the meantime. Patch 2 fixes an inconsistency there.
>>
>> Patch 3 lost the now unneeded schid.h include; otherwise, the patches
>> are unchanged from v4.
> 
> Reviewed-by: Alexander Graf <agraf@suse.de>

Marcelo, Gleb,

can you add those patches to the KVM next tree?

Christian
