From: Halil Pasic <pasic@linux.ibm.com>
Date: Mon, 24 Sep 2018 14:09:38 +0000
Subject: Re: [PATCH 2/2] virtio/s390: fix race in ccw_io_helper()
Message-Id: <f7c23739-d047-8345-b17e-a6bf335aa932@linux.ibm.com>
In-Reply-To: <20180924153257.24f367a4.cohuck@redhat.com>
References: <20180924153257.24f367a4.cohuck@redhat.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>



On 09/24/2018 03:32 PM, Cornelia Huck wrote:
> On Mon, 24 Sep 2018 14:57:26 +0200
> Halil Pasic <pasic@linux.ibm.com> wrote:
> 
>> On 09/21/2018 03:30 PM, Cornelia Huck wrote:
>>> On Fri, 21 Sep 2018 14:46:21 +0200
>>> Halil Pasic <pasic@linux.ibm.com> wrote:
> 
>> Again, not what I tried to say. By 'This' I meant 'this race'. How
>> about?
>>
>> """
>> This race normally does not cause any problems. The operations provided
>> by struct virtio_config_ops are usually invoked in a well defined sequence,
>> normally don't fail, and are normally usually quite infrequent too.
> 
> s/usually/used/

Nod. Thanks!

> 
>>
>> Yet, if some of the these operations are directly triggered via
>> sysfs attributes, like in the case described by the referenced bug,
>> userspace is given an opportunity to force races by increasing the
>> frequency of the given operations.
>> """
> 
> Fine with me.
> 
