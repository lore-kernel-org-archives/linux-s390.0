Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47890 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726642AbgATOxc (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 20 Jan 2020 09:53:32 -0500
Subject: Re: [kvm-unit-tests PATCH v3 4/9] s390x: smp: Rework cpu start and
 active tracking
References: <20200117104640.1983-1-frankja@linux.ibm.com>
 <20200117104640.1983-5-frankja@linux.ibm.com>
 <0f9984f0-9768-dba8-5e36-8e667bc05c88@redhat.com>
 <22cbcc9d-1d32-a5c9-4f3f-7892e28bc705@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <66fde098-e238-e590-a9c5-44c552e1a32b@redhat.com>
Date: Mon, 20 Jan 2020 15:53:26 +0100
MIME-Version: 1.0
In-Reply-To: <22cbcc9d-1d32-a5c9-4f3f-7892e28bc705@linux.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: thuth@redhat.com, borntraeger@de.ibm.com, linux-s390@vger.kernel.org, cohuck@redhat.com

> Well, I have restarts in the smp test and I don't want to always pass a
> psw if I know what the last restart psw was.
> Simply restarting into test_func or wait_for_flag is certainly no problem.
> 
>>

Makes sense.

>>> +	rc = sigp(addr, SIGP_RESTART, 0, NULL);
>>> +	if (rc)
>>> +		return rc;
>>> +	/*
>>> +	 * The order has been accepted, but the actual restart may not
>>> +	 * have been performed yet, so wait until the cpu is running.
>>> +	 */
>>> +	while (!smp_cpu_running(addr))
>>> +		mb();
>>
>> Should you make sure to stop the CPU before issuing the restart?
>> Otherwise you will get false positives if it is still running (but
>> hasn't processed the RESTART yet)
> 
> Good point
> 


-- 
Thanks,

David / dhildenb
