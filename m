From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 31 Jul 2018 12:19:23 +0000
Subject: Re: [PATCH v7 14/22] s390: vfio-ap: sysfs interface to activate mdev matrix
Message-Id: <b2c28520-25e2-36b9-707f-68f4d65294f7@de.ibm.com>
In-Reply-To: <e0c40c36-a212-f806-a765-3c440a7c9347@linux.ibm.com>
References: <e0c40c36-a212-f806-a765-3c440a7c9347@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>



On 07/31/2018 11:14 AM, Halil Pasic wrote:
> 
> 
> On 07/31/2018 10:38 AM, Cornelia Huck wrote:
>> On Thu, 26 Jul 2018 21:54:21 +0200
>> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
>>
>> Regardless whether the activation approach is a good idea...
>>
>>> +static int vfio_ap_verify_queues_reserved(struct ap_matrix_mdev *matrix_mdev)
>>> +{
>>> +��� unsigned long apid, apqi;
>>> +��� int ret = 0;
>>> +
>>> +��� for_each_set_bit_inv(apid, matrix_mdev->matrix.apm,
>>> +���������������� matrix_mdev->matrix.apm_max + 1) {
>>> +������� for_each_set_bit_inv(apqi, matrix_mdev->matrix.aqm,
>>> +�������������������� matrix_mdev->matrix.aqm_max + 1) {
>>> +����������� if (!ap_owned_by_def_drv((int)apid, (int)apqi))
>>> +��������������� continue;
>>> +
>>> +����������� /*
>>> +������������ * We want to log every APQN that is not reserved by
>>> +������������ * the driver, so record the return code, log a message
>>> +������������ * and allow the loop to continue
>>> +������������ */
>>> +����������� ret = -EPERM;
>>> +����������� pr_warn("%s: activate for %s failed: queue %02lx.%04lx owned by default driver\n",
>>> +��������������� VFIO_AP_MODULE_NAME, matrix_mdev->name, apid,
>>> +��������������� apqi);
>>
>> ...I do not think that the syslog is a good place to log those errors.
>> AFAICS these are setup/administration errors, and the admin may want to
>> inspect the data to find out what went wrong. Maybe better to log
>> attempts to assign APQNs reserved to the default drivers into a
>> dedicated dbf or somesuch, and log it in a format that can also be
>> digested by scripts?
>>
> 
> I agree, the error reporting is suboptimal. My preferred solution is an
> API with proper error reporting though. Even with dbf the problem, that
> one has to read some log and figure out what error corresponds to what
> request persist. Optimally the user should get feedback via the same
> interface an interactive action was triggered.
> 
> In fact, I had a proof of concept implementation but it would need some
> rebasing. Another IMHO desirable property of this interface is that it
> changes (or rejects change to) the matrix (masks) in one atomic operation.
> So there is no 'dirty' state and no transaction involved in specifying
> or changing the matrix.

lets just drop the printks for the time being. Its the normal way of kernel
things to return with -EINVAL and NOT telling why.
