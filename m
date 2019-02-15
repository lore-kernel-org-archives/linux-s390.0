From: Pierre Morel <pmorel@linux.ibm.com>
Subject: Re: [PATCH v3 0/9] [RFC] vfio: ap: ioctl definitions for AP Queue
 Interrupt Control
Date: Fri, 15 Feb 2019 09:44:07 +0100
Message-ID: <0aae8b92-fc8c-a2c1-ad44-a63f26a9372e@linux.ibm.com>
References: <1550152269-6317-1-git-send-email-pmorel@linux.ibm.com>
 <e3d4788e-eb01-6337-4267-432af53762e0@linux.ibm.com>
Reply-To: pmorel@linux.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <e3d4788e-eb01-6337-4267-432af53762e0@linux.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>, borntraeger@de.ibm.com
Cc: alex.williamson@redhat.com, cohuck@redhat.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, frankja@linux.ibm.com, pasic@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 14/02/2019 21:33, Tony Krowiak wrote:
> On 2/14/19 8:51 AM, Pierre Morel wrote:
> 
> The subject leads one to believe this patch series introduces
> ioctl definitions for AQIC, but there is not a single ioctl
> definition in the series. Something like this might be more
> appropriate:

This is right Tony, no ioctl here.
I kept the original subject and increment the version number to let 
people know that this is a new version of the implementation of 
PQAP/AQIC interception for which we already had 2 iterations.

May be you are right and I should have change the subject.

Thanks for making this clear.

Regards,
Pierre

-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany
