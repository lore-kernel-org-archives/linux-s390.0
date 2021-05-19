Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F46C433ED
	for <linux-s390@archiver.kernel.org>; Wed, 19 May 2021 23:04:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABC10611AD
	for <linux-s390@archiver.kernel.org>; Wed, 19 May 2021 23:04:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbhESXGL (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 19 May 2021 19:06:11 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:11158 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229465AbhESXGK (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 19 May 2021 19:06:10 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14JN4GCd186042;
        Wed, 19 May 2021 19:04:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=3oZoJnV+ZwIQFmrVajD07gyKVPdr10L1fejTAMNd/gE=;
 b=Fwan1k7o3TbAS/PIMYVXNHs4lmNEamPgOAfcnUzFErXpa/ZKAuotca71sWvPhhGvGomP
 oAyyo/pMasX2oMCq/M8MPEvAs+EK4+u5QY+rhBaBGCN8DtUfwHyUYzf9iDOHWJKKRZUZ
 +vlSY5q2L6ihxZS5qXKvbV4z3f4b8E1C4xKhH0Wz4sZR0qEfYXk2tYXntYixvJbmZrwl
 V+y1sI95QtboysmBexV5q6h91AqNJwvb3FKom6s94yLfybLzaTaTwJ9NoWF3RzIamSPv
 ug/Rgj8ElZshBF0gq8BWt95cQt5F7wCH9Vh0wfiy8Wwy907iVZN/6ENrjp+XDBbWNHpi 1A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38nbr58bw3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 May 2021 19:04:49 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 14JN4Oxg186580;
        Wed, 19 May 2021 19:04:48 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38nbr58bvt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 May 2021 19:04:48 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 14JN3wVu007466;
        Wed, 19 May 2021 23:04:48 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma03dal.us.ibm.com with ESMTP id 38j5x9ugmc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 May 2021 23:04:47 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14JN4lre11994078
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 May 2021 23:04:47 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 10C40AC060;
        Wed, 19 May 2021 23:04:47 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 72455AC05F;
        Wed, 19 May 2021 23:04:46 +0000 (GMT)
Received: from cpe-172-100-179-72.stny.res.rr.com (unknown [9.85.177.219])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 19 May 2021 23:04:46 +0000 (GMT)
Subject: Re: [PATCH v3 2/2] s390/vfio-ap: control access to PQAP(AQIC)
 interception handler
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        borntraeger@de.ibm.com, cohuck@redhat.com,
        pasic@linux.vnet.ibm.com, jjherne@linux.ibm.com,
        alex.williamson@redhat.com, kwankhede@nvidia.com
References: <20210519153921.804887-1-akrowiak@linux.ibm.com>
 <20210519153921.804887-3-akrowiak@linux.ibm.com>
 <20210519161610.GO1002214@nvidia.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Message-ID: <8c93c29a-e223-ac9a-5b54-7329587084c9@linux.ibm.com>
Date:   Wed, 19 May 2021 19:04:46 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210519161610.GO1002214@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: k0r9BPM-w5013gCD3UgRqdiTrOWkMx0w
X-Proofpoint-ORIG-GUID: ofqubM1AXwJBUkRUos-iPykRpiaaiN9a
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-19_10:2021-05-19,2021-05-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=940 mlxscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 spamscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105190143
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



On 5/19/21 12:16 PM, Jason Gunthorpe wrote:
> On Wed, May 19, 2021 at 11:39:21AM -0400, Tony Krowiak wrote:
>
>> @@ -287,13 +289,17 @@ static int handle_pqap(struct kvm_vcpu *vcpu)
>>   	if (!(vcpu->arch.sie_block->eca & ECA_AIV))
>>   		return -EOPNOTSUPP;
>>   
>> -	apqn = vcpu->run->s.regs.gprs[0] & 0xffff;
>> -	mutex_lock(&matrix_dev->lock);
>> +	rcu_read_lock();
>> +	pqap_module_hook = rcu_dereference(vcpu->kvm->arch.crypto.pqap_hook);
>> +	if (!pqap_module_hook) {
>> +		rcu_read_unlock();
>> +		goto set_status;
>> +	}
>>   
>> -	if (!vcpu->kvm->arch.crypto.pqap_hook)
>> -		goto out_unlock;
>> -	matrix_mdev = container_of(vcpu->kvm->arch.crypto.pqap_hook,
>> -				   struct ap_matrix_mdev, pqap_hook);
>> +	matrix_mdev = pqap_module_hook->data;
>> +	rcu_read_unlock();
>> +	mutex_lock(&matrix_dev->lock);
> The matrix_mdev pointer was extracted from the pqap_module_hook,
> but now there is nothing protecting it since the rcu was dropped and
> it gets freed in vfio_ap_mdev_remove.

Therein lies the rub. We can't hold the rcu_read_lock across the
entire time that the interception is being processed because of
wait conditions in the interception handler. Regardless of whether
the pointer to the matrix_mdev is retrieved as the container of
or extracted from the pqap_hook, there is nothing protecting it
and there appears to be no way to do so using RCU.
>
> And, again, module locking doesn't prevent vfio_ap_mdev_remove() from
> being called. None of these patches should be combining module locking
> with RCU.

Is there any other way besides user interaction with the mdev's
sysfs remove interface for the remove callback to get invoked?
If I try to remove the mdev using the sysfs interface while the
mdev fd is still open by the guest, the remove hangs until the
fd is closed. That being the case, the mdev release callback
will get invoked prior to the remove callback being invoked which
renders this whole debate moot. What am I missing here?

>
> Jason

