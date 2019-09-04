Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:17392 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729944AbfIDPJN (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 4 Sep 2019 11:09:13 -0400
Subject: Re: [PATCH 1/1] s390: vfio-ap: fix warning reset not completed
References: <20190903133618.9122-1-pasic@linux.ibm.com>
 <20190903184542.2d955111.cohuck@redhat.com>
From: Tony Krowiak <akrowiak@linux.ibm.com>
Message-ID: <633ff646-de9b-9d6b-2d35-b09a60d33eee@linux.ibm.com>
Date: Wed, 4 Sep 2019 11:08:14 -0400
MIME-Version: 1.0
In-Reply-To: <20190903184542.2d955111.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>
Cc: Harald Freudenberger <freude@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>

On 9/3/19 12:45 PM, Cornelia Huck wrote:
> On Tue,  3 Sep 2019 15:36:18 +0200
> Halil Pasic <pasic@linux.ibm.com> wrote:
> 
> "fix warning for not completed reset"?
> 
>> The intention seems to be to warn once when we don't wait enough for the
>> reset to complete. Let's use the right retry counter to accomplish that
>> semantic.
>>
>> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
>> ---
>>   drivers/s390/crypto/vfio_ap_ops.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
>> index 0604b49a4d32..5c0f53c6dde7 100644
>> --- a/drivers/s390/crypto/vfio_ap_ops.c
>> +++ b/drivers/s390/crypto/vfio_ap_ops.c
>> @@ -1143,7 +1143,7 @@ int vfio_ap_mdev_reset_queue(unsigned int apid, unsigned int apqi,
>>   				msleep(20);
>>   				status = ap_tapq(apqn, NULL);
>>   			}
>> -			WARN_ON_ONCE(retry <= 0);
>> +			WARN_ON_ONCE(retry2 <= 0);
>>   			return 0;
>>   		case AP_RESPONSE_RESET_IN_PROGRESS:
>>   		case AP_RESPONSE_BUSY:
> 
> Makes sense.
> 
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>

Agreed:
Reviewed-by: Tony Krowiak <akrowiak@linux.ibm.com>
> 
