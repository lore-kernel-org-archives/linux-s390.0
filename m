From: Pierre Morel <pmorel@linux.ibm.com>
Subject: Re: [PATCH v7 12/15] KVM: s390: kvm_s390_gisa_clear() now clears the
 IPM only
Date: Tue, 5 Feb 2019 11:05:43 +0100
Message-ID: <a0a9510d-c399-6f7f-36bf-3610abebfeae@linux.ibm.com>
References: <20190131085247.13826-1-mimu@linux.ibm.com>
 <20190131085247.13826-13-mimu@linux.ibm.com>
Reply-To: pmorel@linux.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190131085247.13826-13-mimu@linux.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Michael Mueller <mimu@linux.ibm.com>, KVM Mailing List <kvm@vger.kernel.org>
Cc: Linux-S390 Mailing List <linux-s390@vger.kernel.org>, linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On 31/01/2019 09:52, Michael Mueller wrote:
> Function kvm_s390_gisa_clear() now clears the Interruption
> Pending Mask of the GISA asap. If the GISA is in the alert
> list at this time it stays in the list but is removed by
> process_gib_alert_list().
> 
> Signed-off-by: Michael Mueller <mimu@linux.ibm.com>


I would have written "will be removed by ...." however

Reviewed-by: Pierre Morel<pmorel@linux.ibm.com>

-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany
