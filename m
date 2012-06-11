From: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 3/3] s390/kvm: Perform early event mask processing during
 boot.
Date: Mon, 11 Jun 2012 18:46:08 +0200
Message-ID: <4FD620D0.4030503@suse.de>
References: <1339423619-42299-1-git-send-email-cornelia.huck@de.ibm.com> <1339423619-42299-4-git-send-email-cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1339423619-42299-4-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Avi Kivity <avi@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heinz Graalfs <graalfs@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On 06/11/2012 04:06 PM, Cornelia Huck wrote:
> From: Heinz Graalfs<graalfs@linux.vnet.ibm.com>
>
> For processing under KVM it is required to detect
> the actual SCLP console type in order to set it as
> preferred console.
>
> Signed-off-by: Heinz Graalfs<graalfs@linux.vnet.ibm.com>
> Acked-by: Heiko Carstens<heiko.carstens@de.ibm.com>
> Acked-by: Peter Oberparleiter<peter.oberparleiter@de.ibm.com>
> Signed-off-by: Cornelia Huck<cornelia.huck@de.ibm.com>

Any chance we could get this into -stable?


Acked-by: Alexander Graf <agraf@suse.de>

Alex
