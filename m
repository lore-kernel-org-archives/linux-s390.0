From: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 1/3] s390/kvm: Set CPU in stopped state on initial cpu
 reset
Date: Mon, 11 Jun 2012 18:46:43 +0200
Message-ID: <4FD620F3.4050405@suse.de>
References: <1339423619-42299-1-git-send-email-cornelia.huck@de.ibm.com> <1339423619-42299-2-git-send-email-cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1339423619-42299-2-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Avi Kivity <avi@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On 06/11/2012 04:06 PM, Cornelia Huck wrote:
> From: Christian Borntraeger<borntraeger@de.ibm.com>
>
> The initial cpu reset sets the cpu in the stopped state.
> Several places check for the cpu state (e.g. sigp set prefix) and
> not setting the STOPPED state triggered errors with newer guest
> kernels after reboot.
>
> Signed-off-by: Christian Borntraeger<borntraeger@de.ibm.com>
> Signed-off-by: Cornelia Huck<cornelia.huck@de.ibm.com>

Is this only broken as of now or has this been broken before? So do we 
need to send this to -stable for anyone? And what happens on RESET?


Alex
