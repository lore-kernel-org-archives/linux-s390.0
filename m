From: Pierre Morel <pmorel@linux.ibm.com>
Subject: Re: [PATCH v4 3/7] s390: ap: associate a ap_vfio_queue and a matrix
 mdev
Date: Wed, 13 Mar 2019 11:19:52 +0100
Message-ID: <52eaf739-3fad-9be8-a2f7-9657000ace3e@linux.ibm.com>
References: <1550849400-27152-1-git-send-email-pmorel@linux.ibm.com>
 <1550849400-27152-4-git-send-email-pmorel@linux.ibm.com>
 <20190304030935.525f4223@oc2783563651>
 <17fc3369-2496-2113-5a1a-1630df84f067@linux.ibm.com>
Reply-To: pmorel@linux.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <17fc3369-2496-2113-5a1a-1630df84f067@linux.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>
Cc: borntraeger@de.ibm.com, alex.williamson@redhat.com, cohuck@redhat.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 12/03/2019 22:39, Tony Krowiak wrote:
> On 3/3/19 9:09 PM, Halil Pasic wrote:
>> On Fri, 22 Feb 2019 16:29:56 +0100
>> Pierre Morel <pmorel@linux.ibm.com> wrote:
>>
>>> We need to associate the ap_vfio_queue, which will hold the
>>> per queue information for interrupt with a matrix mediated device
>>> which hold the configuration and the way to the CRYCB.
>> [..]
>>> +static int vfio_ap_get_all_domains(struct ap_matrix_mdev 
>>> *matrix_mdev, int apid)
>>> +{
>>> +    int apqi, apqn;
>>> +    int ret = 0;
>>> +    struct vfio_ap_queue *q;
>>> +    struct list_head q_list;
>>> +
>>> +    INIT_LIST_HEAD(&q_list);
>>> +
>>> +    for_each_set_bit_inv(apqi, matrix_mdev->matrix.aqm, AP_DOMAINS) {
>>> +        apqn = AP_MKQID(apid, apqi);
>>> +        q = vfio_ap_get_queue(apqn, &matrix_dev->free_list);
>>> +        if (!q) {
>>> +            ret = -EADDRNOTAVAIL;
>>> +            goto rewind;
>>> +        }
>>> +        if (q->matrix_mdev) {
>>> +            ret = -EADDRINUSE;
>>
>> You tried to get the q from matrix_dev->free_list thus modulo races
>> q->matrix_mdev should be 0. This change breaks the error codes in a
>> sense that it becomes impossible to provoke EADDRINUSE (the proper
>> error code for taken by another matrix_mdev).
> 
> It is necessary to determine if the queue is in use by another mdev, so
> it will still be necessary to traverse all of the matrix_mdev structs to
> see if q is in matrix_mdev->qlist. It seems that maintaining the qlist
> does not buy us much.
> 

Tony, Halil already pointed out this issue and I already answered.
Please, no need to duplicate the remarks.

Pierre

-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany
