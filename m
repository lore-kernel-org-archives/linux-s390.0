From: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH/RFC 4/5] s390x/kvm: test whether a cpu is STOPPED when
 checking "has_work"
Date: Mon, 28 Jul 2014 15:49:06 +0200
Message-ID: <53D654D2.40308@suse.de>
References: <1404997839-29038-1-git-send-email-borntraeger@de.ibm.com> <1404997839-29038-5-git-send-email-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1404997839-29038-5-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, KVM <kvm@vger.kernel.org>, qemu-devel <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>


On 10.07.14 15:10, Christian Borntraeger wrote:
> From: David Hildenbrand <dahi@linux.vnet.ibm.com>
>
> If a cpu is stopped, it must never be allowed to run and no interrupt may wake it
> up. A cpu also has to be unhalted if it is halted and has work to do - this
> scenario wasn't hit in kvm case yet, as only "disabled wait" is processed within
> QEMU.
>
> Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
> Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>

This looks like it's something that generic infrastructure should take 
care of, no? How does this work for the other archs? They always get an 
interrupt on the transition between !has_work -> has_work. Why don't we 
get one for s390x?


Alex
