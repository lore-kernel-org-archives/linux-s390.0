Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:65234 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2409976AbfJRMGm (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 18 Oct 2019 08:06:42 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9IBwXFl002090
        for <linux-s390@vger.kernel.org>; Fri, 18 Oct 2019 08:06:41 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vqcqbgy5n-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 18 Oct 2019 08:06:41 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <sth@linux.ibm.com>;
        Fri, 18 Oct 2019 13:06:38 +0100
Subject: Re: memory leaks in dasd_eckd_check_characteristics() error paths
From: Stefan Haberland <sth@linux.ibm.com>
References: <1570044801.5576.262.camel@lca.pw>
 <6f5584d5-755c-e416-52da-3cb99c69adaf@linux.ibm.com>
 <1571234974.5937.53.camel@lca.pw>
 <ddc3fb26-2286-de78-70dd-ef0f62bfd6c0@linux.ibm.com>
 <1571239578.5937.62.camel@lca.pw>
 <3e03a30c-f0c8-2941-7545-fcf609d77cb0@linux.ibm.com>
Date: Fri, 18 Oct 2019 14:06:34 +0200
MIME-Version: 1.0
In-Reply-To: <3e03a30c-f0c8-2941-7545-fcf609d77cb0@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Message-Id: <8a97238f-deaf-f301-a8f3-6f707be83c5d@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Qian Cai <cai@lca.pw>
Cc: Jan Hoeppner <hoeppner@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

On 16.10.19 17:28, Stefan Haberland wrote:
> On 16.10.19 17:26, Qian Cai wrote:
>> On Wed, 2019-10-16 at 16:56 +0200, Stefan Haberland wrote:
>>> On 16.10.19 16:09, Qian Cai wrote:
>>>> On Wed, 2019-10-16 at 15:29 +0200, Stefan Haberland wrote:
>>>>> Hi,
>>>>>
>>>>> thanks for reporting this.
>>>>>
>>>>> On 02.10.19 21:33, Qian Cai wrote:
>>>>>> For some reasons, dasd_eckd_check_characteristics() received -ENOMEM and then
>>>>>> dasd_generic_set_online() emits this message,
>>>>>>
>>>>>> dasd: 0.0.0122 Setting the DASD online with discipline ECKD failed with rc=-12
>>>>>>
>>>>>> After that, there are several memory leaks below. There are "config_data" and
>>>>>> then stored as,
>>>>>>
>>>>>> /* store per path conf_data */
>>>>>> device->path[pos].conf_data = conf_data;
>>>>>>
>>>>>> When it processes the error path in  dasd_generic_set_online(), it calls
>>>>>> dasd_delete_device() which nuke the whole "struct dasd_device" without freeing
>>>>>> the device->path[].conf_data first. 
>>>>> Usually dasd_delete_device() calls dasd_generic_free_discipline() which
>>>>> takes care of
>>>>> the device->path[].conf_data in dasd_eckd_uncheck_device().
>>>>> From a first look this looks sane.
>>>>>
>>>>> So I need to spend a closer look if this does not happen correctly here.
>>>> When dasd_eckd_check_characteristics() failed here,
>>>>
>>>> 	if (!private) {
>>>> 		private = kzalloc(sizeof(*private), GFP_KERNEL | GFP_DMA);
>>>> 		if (!private) {
>>>> 			dev_warn(&device->cdev->dev,
>>>> 				 "Allocating memory for private DASD data "
>>>> 				 "failed\n");
>>>> 			return -ENOMEM;
>>>> 		}
>>>> 		device->private = private;
>>>>
>>>> The device->private is NULL.
>>>>
>>>> Then, in dasd_eckd_uncheck_device(), it will return immediately.
>>>>
>>>> 	if (!private)
>>>> 		return;
>>> Yes but in this case there is no per_path configuration data stored.
>>> This is done after the private structure is allocated successfully.
>> Yes, you are right. It has been a while so I must lost a bit memory. Actually,
>> it looks like in dasd_eckd_check_characteristic() that device->private is set to
>> NULL from this path,
>>
>> 	/* Read Configuration Data */
>> 	rc = dasd_eckd_read_conf(device);
>> 	if (rc)
>> 		goto out_err1;
>>
>> out_err1:
>> 	kfree(private->conf_data);
>> 	kfree(device->private);
>> 	device->private = NULL;
>> 	return rc;
>>
>> because dasd_eckd_read_conf() returns -ENOMEM and calls,
>>
>> out_error:
>> 	kfree(rcd_buf);
>> 	*rcd_buffer = NULL;
>> 	*rcd_buffer_size = 0;
>> 	return ret;
>>
>> It will only free its own config_data in one operational path, but there could
>> has already allocated in earlier paths in dasd_eckd_read_conf() without any
>> rollback and calls return,
>>
>> 	for (lpm = 0x80; lpm; lpm>>= 1) {
>> 		if (!(lpm & opm))
>> 			continue;
>> 		rc = dasd_eckd_read_conf_lpm(device, &conf_data,
>> 					     &conf_len, lpm);
>> 		if (rc && rc != -EOPNOTSUPP) {	/* -EOPNOTSUPP is ok */
>> 			DBF_EVENT_DEVID(DBF_WARNING, device->cdev,
>> 					"Read configuration data returned "
>> 					"error %d", rc);
>> 			return rc;
>> 		}
>>
>> Later, dasd_eckd_uncheck_device() see private->device is NULL without cleaning
>> up. Does it make sense?
> Yes, this looks like an error path not handling this correctly.
>

I will provide a patch for this. Most likely I will cover this in the
error handling of the function.
Thanks again for reporting.

Regards,
Stefan
