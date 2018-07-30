From: Halil Pasic <pasic@linux.ibm.com>
Date: Mon, 30 Jul 2018 14:18:21 +0000
Subject: Re: [PATCH v7 09/22] s390: vfio-ap: register matrix device with VFIO mdev framework
Message-Id: <f4d4e55c-5594-bc61-040c-bbe584df6e01@linux.ibm.com>
In-Reply-To: <6a31797f-c8be-bb3d-c515-029ec52a56bf@linux.ibm.com>
References: <6a31797f-c8be-bb3d-c515-029ec52a56bf@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>



On 07/30/2018 01:28 PM, Cornelia Huck wrote:
> On Mon, 30 Jul 2018 13:24:24 +0200
> Pierre Morel <pmorel@linux.ibm.com> wrote:
> 
>> On 30/07/2018 11:49, Cornelia Huck wrote:
>>> On Fri, 27 Jul 2018 16:17:47 +0200
>>> Halil Pasic <pasic@linux.ibm.com> wrote:
>>>   
>>>> On 07/26/2018 09:54 PM, Christian Borntraeger wrote:
>>>>> @@ -65,6 +66,21 @@ static int vfio_ap_matrix_dev_create(void)
>>>>>     {
>>>>>     	int ret;
>>>>>     
>>>>> +	mutex_init(&matrix_dev.lock);
>>>>> +	INIT_LIST_HEAD(&matrix_dev.mdev_list);
>>>>> +
>>>>> +	/* Test if PQAP(QCI) instruction is available */
>>>>> +	if (test_facility(12)) {
>>>>> +		ret = ap_qci(&matrix_dev.info);
>>>>> +		if (ret && (ret != -EOPNOTSUPP)) {
>>>> After Connie's curiosity was piqued I gave this another look. If
>>>> I read the ap_qci() documentation and code correctly, it can return
>>>> either 0 or -EOPNOTSUPP, but nothing else. So basically this
>>>> is a dead branch.
>>> Can it return -EOPNOTSUPP if facility 12 is present?
>>
>> I do not think it is reasonable to continue if
>> we stated that facility 12 is present but the ap_qci function failed.
>>
>> So I propose that we return an error and break the insmod.
> 
> So, would that be a bug? If yes, returning an error makes sense.
> 
> (I can't check the documentation to find out about the interaction
> between facility 12 and PQAP(QCI)...)

If we are in z architectural mode and  facility 12 is indicated and
ap_qci() returns an error code, it's because of an exception while
executing the PQAP instruction. The reason can be a bad input pointer
or other stuff. It is likely a bug. I'm not sure how this interacts
with machine checks though. I think we should report the problem
and give up.  

> --
> To unsubscribe from this list: send the line "unsubscribe linux-s390" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
