From: Alexander Graf <agraf@suse.de>
Subject: Re: [Qemu-devel] [RFC PATCH v2 04/15] cpu-model/s390: Introduce S390 CPU models
Date: Fri, 20 Feb 2015 16:22:20 +0100
Message-ID: <89E3550E-9E2B-4D95-A809-B7C64EBCD7C5@suse.de>
References: <1424183053-4310-1-git-send-email-mimu@linux.vnet.ibm.com> <1424183053-4310-5-git-send-email-mimu@linux.vnet.ibm.com> <54E73C8F.7000202@suse.de> <20150220160046.4743acc8@bee>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150220160046.4743acc8@bee>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Michael Mueller <mimu@linux.vnet.ibm.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Gleb Natapov <gleb@kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Andreas Faerber <afaerber@suse.de>, Richard Henderson <rth@twiddle.net>
List-ID: <linux-s390.vger.kernel.org>




> Am 20.02.2015 um 16:00 schrieb Michael Mueller <mimu@linux.vnet.ibm.com>:
> 
> On Fri, 20 Feb 2015 14:54:23 +0100
> Alexander Graf <agraf@suse.de> wrote:
> 
>>> 
>>> +/* machine related properties */
>>> +typedef struct S390CPUMachineProps {
>>> +    uint16_t class;      /* machine class */
>>> +    uint16_t ga;         /* availability number of machine */
>>> +    uint16_t order;      /* order of availability */
>>> +} S390CPUMachineProps;
>>> +
>>> +/* processor related properties */
>>> +typedef struct S390CPUProcessorProps {
>>> +    uint16_t gen;        /* S390 CMOS generation */
>>> +    uint16_t ver;        /* version of processor */
>>> +    uint32_t id;         /* processor identification*/
>>> +    uint16_t type;       /* machine type */
>>> +    uint16_t ibc;        /* IBC value */
>>> +    uint64_t *fac_list;  /* list of facilities */  
>> 
>> Just make this uint64_t fac_list[2]. That way we don't have to track any
>> messy allocations.
> 
> It will be something like "uint64_t fac_list[S390_CPU_FAC_LIST_SIZE_UINT64]" and in total 2KB not
> just 16 bytes but I will change it. 

Why? Do we actually need that many? This is a qemu internal struct.

Alex
