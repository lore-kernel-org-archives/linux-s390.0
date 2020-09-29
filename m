Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH v10 05/16] s390/vfio-ap: implement in-use callback for
 vfio_ap driver
References: <20200821195616.13554-1-akrowiak@linux.ibm.com>
 <20200821195616.13554-6-akrowiak@linux.ibm.com>
 <20200925112941.71589591.pasic@linux.ibm.com>
From: Tony Krowiak <akrowiak@linux.ibm.com>
Message-ID: <b6810e67-1e50-d62c-8c9e-57429e8a239f@linux.ibm.com>
Date: Tue, 29 Sep 2020 10:00:01 -0400
MIME-Version: 1.0
In-Reply-To: <20200925112941.71589591.pasic@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
List-ID: <linux-s390.vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@linux.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, mjrosato@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com, fiuczy@linux.ibm.com, frankja@linux.ibm.com, david@redhat.com, imbrenda@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com



On 9/25/20 5:29 AM, Halil Pasic wrote:
> On Fri, 21 Aug 2020 15:56:05 -0400
> Tony Krowiak <akrowiak@linux.ibm.com> wrote:
>
>> +
>> +bool vfio_ap_mdev_resource_in_use(unsigned long *apm, unsigned long *aqm)
>> +{
>> +	bool in_use;
>> +
>> +	mutex_lock(&matrix_dev->lock);
>> +	in_use = !!vfio_ap_mdev_verify_no_sharing(NULL, apm, aqm);
>> +	mutex_unlock(&matrix_dev->lock);
> See also my comment for patch 4. AFAIU as soon as you release the lock
> the in_use may become outdated in any moment.

See my response to your comment for patch 4.

>
>> +
>> +	return in_use;
>> +}
