Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:31210 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725981AbgJFOXp (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 6 Oct 2020 10:23:45 -0400
References: <20201002193940.24012-1-sth@linux.ibm.com>
 <20201002193940.24012-2-sth@linux.ibm.com>
 <20201006114656.6b1a97b1.cohuck@redhat.com>
From: Stefan Haberland <sth@linux.ibm.com>
Subject: Re: [PATCH 01/10] s390/cio: Export information about
 Endpoint-Security Capability
Message-ID: <153dde83-0f87-69d4-df65-a43342f5fc8e@linux.ibm.com>
Date: Tue, 6 Oct 2020 16:23:36 +0200
MIME-Version: 1.0
In-Reply-To: <20201006114656.6b1a97b1.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, hoeppner@linux.ibm.com, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com, vneethv@linux.vnet.ibm.com

Hi,

talked to Vineeth, here is his answer...

Am 06.10.20 um 11:46 schrieb Cornelia Huck:
> On Fri,  2 Oct 2020 21:39:31 +0200
> Stefan Haberland <sth@linux.ibm.com> wrote:
>
>> From: Sebastian Ott <sebott@linux.ibm.com>
>>
>> Add a new sysfs attribute 'esc' per chpid. This new attribute exports
>> the Endpoint-Security-Capability byte of channel-path description bloc=
k,
>> which could be 0-None, 1-Authentication, 2 and 3-Encryption.
>>
>> For example:
>> $ cat /sys/devices/css0/chp0.34/esc
>> 0
>>
>> Reference-ID: IO1812
>> Signed-off-by: Sebastian Ott <sebott@linux.ibm.com>
>> [vneethv@linux.ibm.com: cleaned-up & modified description]
>> Signed-off-by: Vineeth Vijayan <vneethv@linux.ibm.com>
>> Reviewed-by: Jan H=C3=B6ppner <hoeppner@linux.ibm.com>
>> Reviewed-by: Peter Oberparleiter <oberpar@linux.ibm.com>
>> Acked-by: Vasily Gorbik <gor@linux.ibm.com>
>> Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
>> ---
>>  drivers/s390/cio/chp.c  | 15 +++++++++++++++
>>  drivers/s390/cio/chsc.h |  3 ++-
>>  2 files changed, 17 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/s390/cio/chp.c b/drivers/s390/cio/chp.c
>> index dfcbe54591fb..8d0de6adcad0 100644
>> --- a/drivers/s390/cio/chp.c
>> +++ b/drivers/s390/cio/chp.c
>> @@ -384,6 +384,20 @@ static ssize_t chp_chid_external_show(struct devi=
ce *dev,
>>  }
>>  static DEVICE_ATTR(chid_external, 0444, chp_chid_external_show, NULL)=
;
>> =20
>> +static ssize_t chp_esc_show(struct device *dev,
>> +			    struct device_attribute *attr, char *buf)
>> +{
>> +	struct channel_path *chp =3D to_channelpath(dev);
>> +	ssize_t rc;
>> +
>> +	mutex_lock(&chp->lock);
>> +	rc =3D sprintf(buf, "%x\n", chp->desc_fmt1.esc);
> I'm wondering: Do we need to distinguish between '0' =3D=3D 'no esc, an=
d
> the hardware says so' and '0' =3D=3D 'the chsc to get that information =
is
> not supported'? I see that for the chid the code checks for a flag in
> desc_fmt1, and I indeed see that nothing is displayed for
> chid/chid_external when I run under QEMU.

ESC=3D=3D0 due to 'missing support for the required CHSC information' is
just another symptom of "unsupported" because the CSS firmware code
doesn't bring the required support.
Also, not sure if there is any flag/value which provide this
distinction. So we think having 2 different values "Unknown" and
"Unsupported" is not required in this scenario.

So, we kept a single "ESC=3D=3D0" which indicates "Unsupported", but as y=
ou
mentioned, in different levels.

>> +	mutex_unlock(&chp->lock);
>> +
>> +	return rc;
>> +}
>> +static DEVICE_ATTR(esc, 0444, chp_esc_show, NULL);
>> +
>>  static ssize_t util_string_read(struct file *filp, struct kobject *ko=
bj,
>>  				struct bin_attribute *attr, char *buf,
>>  				loff_t off, size_t count)
> (...)
>
