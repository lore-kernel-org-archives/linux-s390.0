From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH 3/3] s390/kvm: Perform early event mask processing during
 boot.
Date: Mon, 11 Jun 2012 20:41:44 +0200
Message-ID: <4FD63BE8.2000709@de.ibm.com>
References: <1339423619-42299-1-git-send-email-cornelia.huck@de.ibm.com> <1339423619-42299-4-git-send-email-cornelia.huck@de.ibm.com> <4FD620D0.4030503@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <4FD620D0.4030503@suse.de>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Alexander Graf <agraf@suse.de>
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Avi Kivity <avi@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Carsten Otte <cotte@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heinz Graalfs <graalfs@linux.vnet.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On 11/06/12 18:46, Alexander Graf wrote:
> On 06/11/2012 04:06 PM, Cornelia Huck wrote:
>> From: Heinz Graalfs<graalfs@linux.vnet.ibm.com>
>>
>> For processing under KVM it is required to detect
>> the actual SCLP console type in order to set it as
>> preferred console.
>>
>> Signed-off-by: Heinz Graalfs<graalfs@linux.vnet.ibm.com>
>> Acked-by: Heiko Carstens<heiko.carstens@de.ibm.com>
>> Acked-by: Peter Oberparleiter<peter.oberparleiter@de.ibm.com>
>> Signed-off-by: Cornelia Huck<cornelia.huck@de.ibm.com>
> 
> Any chance we could get this into -stable?
> 
> 
> Acked-by: Alexander Graf <agraf@suse.de>

We scheduled this for 3.6, to give it some time to settle, but it has been tested 
internally on 3.4 with the sclp console patches that we submitted last week against
qemu and on lpar/zvm. (this reminds me: can you have a look at the qemu patches
that Jens sent last week?)

If you can testify that this also works on a SLES system we can ask Avi/Marcelo,
to consider this for 3.5. The current setup of assuming virtio console if running
under KVM is obviously not correct, so it makes sense to check for the existing consoles
before activating them.

Christian
