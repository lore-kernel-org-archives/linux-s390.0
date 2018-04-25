From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v2 1/5] vfio: ccw: fix cleanup if cp_prefetch fails
Date: Wed, 25 Apr 2018 13:19:50 +0200
Message-ID: <584f24d1-2dc1-4100-7919-3314b8142534@linux.ibm.com>
References: <20180423110113.59385-1-bjsdjshi@linux.vnet.ibm.com>
 <20180423110113.59385-2-bjsdjshi@linux.vnet.ibm.com>
 <20180424113147.139e2e0b.cohuck@redhat.com>
 <20180425024341.GY12194@bjsdjshi@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180425024341.GY12194@bjsdjshi@linux.vnet.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, borntraeger@de.ibm.com, bjsdjshi@linux.ibm.com, pmorel@linux.ibm.com, Halil Pasic <pasic@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>



On 04/25/2018 04:43 AM, Dong Jia Shi wrote:
>> [Some procedural notes: I've created a new vfio-ccw-fixes branch based
>> on the s390 fixes branch for easier handling. Things targeted for the
>> next release will go on the vfio-ccw branch on top of the s390 features
>> branch, as before. Does that work for everybody?
> I don't see a reason that why it doesn't work for me.
> 

Works for me.

>> (And I am the only vfio-ccw maintainer with a kernel.org account,
>> right?)]
>>
> I don't have such an account, and don't know if I need to apply for one.

Neither do I have a kernel.org account -- at least for now.

Regards,
Halil
