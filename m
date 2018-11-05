From: Pierre Morel <pmorel@linux.ibm.com>
Subject: Re: [PATCH v1 3/7] vfio: ap: AP Queue Interrupt structures
 definitions
Date: Mon, 5 Nov 2018 09:46:56 +0100
Message-ID: <e6bf348b-0fa3-3d65-fae7-9326cf358b8c@linux.ibm.com>
References: <1541009577-29656-1-git-send-email-pmorel@linux.ibm.com>
 <1541009577-29656-4-git-send-email-pmorel@linux.ibm.com>
 <c440a74d-bea6-1416-4b54-0894e21c4a6c@linux.ibm.com>
Reply-To: pmorel@linux.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <c440a74d-bea6-1416-4b54-0894e21c4a6c@linux.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>, borntraeger@de.ibm.com
Cc: alex.williamson@redhat.com, cohuck@redhat.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, frankja@linux.ibm.com, pasic@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 02/11/2018 16:14, Tony Krowiak wrote:
> On 10/31/18 2:12 PM, Pierre Morel wrote:
>> We define all the structures we need to let GISA handle
>> the AP Queues Interrupt.

...

>> +struct aqic_gisa {
>> +    uint8_t  rzone;
>> +    uint8_t  izone;
>> +    unsigned    ir:1;
>> +    unsigned    reserved1:4;
>> +    unsigned    gisc:3;
>> +    unsigned    reserved2:6;
>> +    unsigned    f:2;
>> +    unsigned    reserved3:1;
>> +    unsigned    gisao:27;
>> +    unsigned    t:1;
>> +    unsigned    isc:3;
>> +}  __packed __aligned(8);
> 
> This struct is redundant with the 'struct ap_qirq_ctrl'
> defined in arch/s390/include/asm/ap.h. That file also includes
> the asm for the ap_aqic function.

Exact.
My code is quite old and I forgot to adapt it to the new definitions.
I will do it for this, aqic, the inline assembler and the status.

Thanks,

Pierre

-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany
