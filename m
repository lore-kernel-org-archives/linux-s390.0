From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH 1/3] s390/kvm: Set CPU in stopped state on initial cpu
 reset
Date: Mon, 11 Jun 2012 21:11:42 +0200
Message-ID: <4FD642EE.30800@de.ibm.com>
References: <1339423619-42299-1-git-send-email-cornelia.huck@de.ibm.com> <1339423619-42299-2-git-send-email-cornelia.huck@de.ibm.com> <4FD620F3.4050405@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <4FD620F3.4050405@suse.de>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Alexander Graf <agraf@suse.de>
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Avi Kivity <avi@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Carsten Otte <cotte@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On 11/06/12 18:46, Alexander Graf wrote:
> On 06/11/2012 04:06 PM, Cornelia Huck wrote:
>> From: Christian Borntraeger<borntraeger@de.ibm.com>
>>
>> The initial cpu reset sets the cpu in the stopped state.
>> Several places check for the cpu state (e.g. sigp set prefix) and
>> not setting the STOPPED state triggered errors with newer guest
>> kernels after reboot.
>>
>> Signed-off-by: Christian Borntraeger<borntraeger@de.ibm.com>
>> Signed-off-by: Cornelia Huck<cornelia.huck@de.ibm.com>
> 
> Is this only broken as of now or has this been broken before? So do we need to send this to -stable for anyone? And what happens on RESET?

Looks like this problem appeared as a combination of newer guest kernels
(something like >=3.2 or so) with a reworked SMP bringup behaviour and a 
host fix (151104a7b3a82f9c56d636595ae58084049d2559 KVM: s390: make sigp 
restart return busy when stop pending)
which both are correct in itself but uncovered this third problem.

With this patch I have a qemu/kernel combination which works reliably with different
guest kernels for guest initiated resets as well as qemu monitor system_reset
as well as system_shutdown+system_reset+cont. It will probably not be the last
fix (e.g. initial reset should also take care of pending CPU local interrupts)
but we are making progress.

Christian

PS: The working combination has two patches pending for qemu which need some
cleanup, will send soon
