Return-Path: <linux-fsdevel-owner@vger.kernel.org>
Subject: Re: [External] Re: [PATCH 3/5] s390, dcssblk: Allow a NULL-kaddr to
 ->direct_access()
References: <20180724084510.6104-1-yehs2007@zoho.com>
 <20180724084510.6104-4-yehs2007@zoho.com>
 <192a9dac-921f-e222-3a7d-32d43679cd12@de.ibm.com>
 <TY2PR03MB3343901A038D3E3D836C438992550@TY2PR03MB3343.apcprd03.prod.outlook.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 24 Jul 2018 13:16:09 +0200
MIME-Version: 1.0
In-Reply-To: <TY2PR03MB3343901A038D3E3D836C438992550@TY2PR03MB3343.apcprd03.prod.outlook.com>
Content-Language: en-US
Message-Id: <814b615b-fc5d-627a-a11e-c54796b1b08d@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-fsdevel/>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
To: Huaisheng HS1 Ye <yehs1@lenovo.com>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "dan.j.williams@intel.com" <dan.j.williams@intel.com>
Cc: "ross.zwisler@linux.intel.com" <ross.zwisler@linux.intel.com>, "willy@infradead.org" <willy@infradead.org>, "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>, "dave.jiang@intel.com" <dave.jiang@intel.com>, "schwidefsky@de.ibm.com" <schwidefsky@de.ibm.com>, "heiko.carstens@de.ibm.com" <heiko.carstens@de.ibm.com>, "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "martin.petersen@oracle.com" <martin.petersen@oracle.com>, "axboe@kernel.dk" <axboe@kernel.dk>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "bart.vanassche@wdc.com" <bart.vanassche@wdc.com>, "jack@suse.cz" <jack@suse.cz>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, NingTing Cheng <chengnt@lenovo.com>, Huaisheng Ye <yehs2007@zoho.com>
List-ID: <linux-s390.vger.kernel.org>



On 07/24/2018 11:46 AM, Huaisheng HS1 Ye wrote:
> From: Christian Borntraeger <borntraeger@de.ibm.com>
> Sent: Tuesday, July 24, 2018 4:54 PM
>> On 07/24/2018 10:45 AM, Huaisheng Ye wrote:
>>> From: Huaisheng Ye <yehs1@lenovo.com>
>>>
>>> dcssblk_direct_access() needs to check the validity of second rank
>>> pointer kaddr for NULL assignment. If kaddr equals to NULL, it
>>> doesn't need to calculate the value.
>>>
>>> Signed-off-by: Huaisheng Ye <yehs1@lenovo.com>
>>> ---
>>>  drivers/s390/block/dcssblk.c | 3 ++-
>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/s390/block/dcssblk.c b/drivers/s390/block/dcssblk.c
>>> index 0a312e4..9c13dc5 100644
>>> --- a/drivers/s390/block/dcssblk.c
>>> +++ b/drivers/s390/block/dcssblk.c
>>> @@ -915,7 +915,8 @@ static DEVICE_ATTR(save, S_IWUSR | S_IRUSR, dcssblk_save_show,
>>>  	unsigned long dev_sz;
>>>
>>>  	dev_sz = dev_info->end - dev_info->start + 1;
>>> -	*kaddr = (void *) dev_info->start + offset;
>>> +	if (kaddr)
>>> +		*kaddr = (void *) dev_info->start + offset;
>>
>> So you are trading of a load + add (dev_info->start should be cache hot) against a
>> compare+branch . Not sure that this is always a win.
> 
> Hmm...the calculation process of pfn is more complicated than kaddr. I think you agree to check pfn but not sure kaddr, right?
> From the logical consistency of code, I think it shall be better to give pfn and kaddr similar treatment.

Reading it again, its more that I do not like the patch description. It reads
like an optimization, (and I think it is not) but it should rather read more
like "with an upcoming change kaddr can be NULL" or so.
