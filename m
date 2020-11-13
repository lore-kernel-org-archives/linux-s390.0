Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:9616 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726625AbgKMR1m (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 13 Nov 2020 12:27:42 -0500
Subject: Re: [PATCH v11 07/14] s390/vfio-ap: sysfs attribute to display the
 guest's matrix
References: <20201022171209.19494-1-akrowiak@linux.ibm.com>
 <20201022171209.19494-8-akrowiak@linux.ibm.com>
 <20201028091758.73aa77a3.pasic@linux.ibm.com>
From: Tony Krowiak <akrowiak@linux.ibm.com>
Message-ID: <b96fe876-c67a-fe6c-0e3a-7b4948edeef4@linux.ibm.com>
Date: Fri, 13 Nov 2020 12:27:32 -0500
MIME-Version: 1.0
In-Reply-To: <20201028091758.73aa77a3.pasic@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
List-ID: <linux-s390.vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@linux.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, mjrosato@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com, fiuczy@linux.ibm.com, frankja@linux.ibm.com, david@redhat.com, hca@linux.ibm.com, gor@linux.ibm.com



On 10/28/20 4:17 AM, Halil Pasic wrote:
> On Thu, 22 Oct 2020 13:12:02 -0400
> Tony Krowiak <akrowiak@linux.ibm.com> wrote:
>
>> +static ssize_t guest_matrix_show(struct device *dev,
>> +				 struct device_attribute *attr, char *buf)
>> +{
>> +	ssize_t nchars;
>> +	struct mdev_device *mdev = mdev_from_dev(dev);
>> +	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
>> +
>> +	if (!vfio_ap_mdev_has_crycb(matrix_mdev))
>> +		return -ENODEV;
> I'm wondering, would it make sense to have guest_matrix display the would
> be guest matrix when we don't have a KVM? With the filtering in
> place, the question in what guest_matrix would my (assign) matrix result
> right now if I were to hook up my vfio_ap_mdev to a guest seems a
> legitimate one.

A couple of thoughts here:
* The ENODEV informs the user that there is no guest running
    which makes sense to me given this interface displays the
    guest matrix. The alternative, which I considered, was to
    display an empty matrix (i.e., nothing).
* This would be a pretty drastic change to the design because
    the shadow_apcb - which is what is displayed via this interface - is
    only updated when the guest is started and while it is running (i.e.,
    hot plug of new adapters/domains). Making this change would
    require changing that entire design concept which I am reluctant
    to do at this point in the game.


>
>
>> +
>> +	mutex_lock(&matrix_dev->lock);
>> +	nchars = vfio_ap_mdev_matrix_show(&matrix_mdev->shadow_apcb, buf);
>> +	mutex_unlock(&matrix_dev->lock);
>> +
>> +	return nchars;
>> +}
>> +static DEVICE_ATTR_RO(guest_matrix);
