Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49796 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727873AbfFQO3y (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 17 Jun 2019 10:29:54 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5HEHbxq087281
        for <linux-s390@vger.kernel.org>; Mon, 17 Jun 2019 10:29:52 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2t6c3d1y66-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 17 Jun 2019 10:29:52 -0400
Received: from localhost
        by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <akrowiak@linux.ibm.com>;
        Mon, 17 Jun 2019 15:29:51 +0100
Subject: Re: [PATCH v4 2/7] s390: vfio-ap: wait for queue empty on queue reset
References: <1560454780-20359-1-git-send-email-akrowiak@linux.ibm.com>
 <1560454780-20359-3-git-send-email-akrowiak@linux.ibm.com>
 <b7f2d9df-26d8-9915-5345-f17e6cd0ef93@linux.ibm.com>
From: Tony Krowiak <akrowiak@linux.ibm.com>
Date: Mon, 17 Jun 2019 10:29:42 -0400
MIME-Version: 1.0
In-Reply-To: <b7f2d9df-26d8-9915-5345-f17e6cd0ef93@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <1feb3cab-94cf-6923-96c4-866545ee7798@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Harald Freudenberger <freude@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: borntraeger@de.ibm.com, cohuck@redhat.com, frankja@linux.ibm.com, david@redhat.com, mjrosato@linux.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, pmorel@linux.ibm.com, pasic@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com

On 6/17/19 4:47 AM, Harald Freudenberger wrote:
> On 13.06.19 21:39, Tony Krowiak wrote:
>> Refactors the AP queue reset function to wait until the queue is empty
>> after the PQAP(ZAPQ) instruction is executed to zero out the queue as
>> required by the AP architecture.
>>
>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
>> ---
>>   drivers/s390/crypto/vfio_ap_ops.c | 49 +++++++++++++++++++++++++++------------
>>   1 file changed, 34 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
>> index bf2ab02b9a0b..60efd3d7896d 100644
>> --- a/drivers/s390/crypto/vfio_ap_ops.c
>> +++ b/drivers/s390/crypto/vfio_ap_ops.c
>> @@ -1128,23 +1128,46 @@ static void vfio_ap_irq_disable_apqn(int apqn)
>>   	}
>>   }
>>   
>> -int vfio_ap_mdev_reset_queue(unsigned int apid, unsigned int apqi,
>> -			     unsigned int retry)
>> +static void vfio_ap_mdev_wait_for_qempty(ap_qid_t qid)
>> +{
>> +	struct ap_queue_status status;
>> +	int retry = 5;
>> +
>> +	do {
>> +		status = ap_tapq(qid, NULL);
>> +		switch (status.response_code) {
>> +		case AP_RESPONSE_NORMAL:
>> +			if (status.queue_empty)
>> +				return;
>> +		case AP_RESPONSE_RESET_IN_PROGRESS:
>> +		case AP_RESPONSE_BUSY:
>> +			msleep(20);
>> +			break;
>> +		default:
>> +			pr_warn("%s: tapq response %02x waiting for queue %04x.%02x empty\n",
>> +				__func__, status.response_code,
>> +				AP_QID_CARD(qid), AP_QID_QUEUE(qid));
> The ap and zcrypt code uses %02x.%04x for displaying an APQN.

Oops, of course it does. My synapses must have been reversed.

> I would also recommend to handle 0x01 (AP_RESPONSE_Q_NOT_AVAIL) and
> 0x03 (AP_RESPONSE_DECONFIGURED) as this code may run when a APQN
> is removed from the configuration of the LPAR. However, it's up to you if you
> want to handle these with the default statement and issue an sysfs warning.

How would you handle them differently? If the queue is not in the
configuration, then there is nothing to wait for.

>> +			return;
>> +		}
>> +	} while (--retry);
>> +
>> +	WARN_ON_ONCE(retry <= 0);
>> +}
>> +
>> +int vfio_ap_mdev_reset_queue(unsigned int apid, unsigned int apqi)
>>   {
>>   	struct ap_queue_status status;
>> -	int retry2 = 2;
>>   	int apqn = AP_MKQID(apid, apqi);
>> +	int retry = 5;
>>   
>>   	do {
>>   		status = ap_zapq(apqn);
>>   		switch (status.response_code) {
>>   		case AP_RESPONSE_NORMAL:
>> -			while (!status.queue_empty && retry2--) {
>> -				msleep(20);
>> -				status = ap_tapq(apqn, NULL);
>> -			}
>> -			WARN_ON_ONCE(retry <= 0);
>> +			vfio_ap_mdev_wait_for_qempty(AP_MKQID(apid, apqi));
>>   			return 0;
>> +		case AP_RESPONSE_DECONFIGURED:
>> +			return -ENODEV;
>>   		case AP_RESPONSE_RESET_IN_PROGRESS:
>>   		case AP_RESPONSE_BUSY:
>>   			msleep(20);
>> @@ -1169,14 +1192,10 @@ static int vfio_ap_mdev_reset_queues(struct mdev_device *mdev)
>>   			     matrix_mdev->matrix.apm_max + 1) {
>>   		for_each_set_bit_inv(apqi, matrix_mdev->matrix.aqm,
>>   				     matrix_mdev->matrix.aqm_max + 1) {
>> -			ret = vfio_ap_mdev_reset_queue(apid, apqi, 1);
>> -			/*
>> -			 * Regardless whether a queue turns out to be busy, or
>> -			 * is not operational, we need to continue resetting
>> -			 * the remaining queues.
>> -			 */
>> +			ret = vfio_ap_mdev_reset_queue(apid, apqi);
>>   			if (ret)
>>   				rc = ret;
>> +
>>   			vfio_ap_irq_disable_apqn(AP_MKQID(apid, apqi));
>>   		}
>>   	}
>> @@ -1326,7 +1345,7 @@ void vfio_ap_mdev_remove_queue(struct ap_queue *queue)
>>   	dev_set_drvdata(&queue->ap_dev.device, NULL);
>>   	apid = AP_QID_CARD(q->apqn);
>>   	apqi = AP_QID_QUEUE(q->apqn);
>> -	vfio_ap_mdev_reset_queue(apid, apqi, 1);
>> +	vfio_ap_mdev_reset_queue(apid, apqi);
>>   	vfio_ap_irq_disable(q);
>>   	kfree(q);
>>   }
> 
