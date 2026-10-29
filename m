Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793293668;
	b=A8sD/oBU7iKvzDK2cYPE21cVBejgSe+Vmr3pQEHNmNaNwOvp6jZAz9YX4tRADXTqHzIv
	 orUJpzQcrZwbK/uCnJuXiMZ++K9Ji+geUj9v+uhSZ1urYe5URBj/wehLflmgwGfTfIVg9
	 wE7Qg4RSu8ozDpW8fNqW+Lgl8GGu+r/frHO/jxi7/pfZCkVfuNpTnQphn6DMkHUC2i/4J
	 vucK18uwka1MMYnTnsxa9lIYwUO8DeKN715i/TH6PuktgFUCT0CW/gP0AGcoFb9js+ZSx
	 w289ffrahGs1SDilZMN3IgH0tzYtszynkT251MIvvbRKcW2jcOOfco5jKroAY17r4zw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793293668;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=fC02P9DKeLV7SV+GEdY6Mr54UvwJLAaeH6neAiWLgio=;
	b=06O4Lkw60yEVSQGDHl2CDLPGbNlT8CLv7xVfXbhZlN+Pr2uD14P1KQSaCTcmvNAlo0e4
	 phHzf3w/u8/fur34hzVUF25EdYZqjeGgCJ2eJ7lCAvoOj/AHdzNOaLgJZ1gDnx6Wfy4Ek
	 6o7Tm5K3vzdOkxSqis5dQyBo7jYedavWy7xHnnf/2WyT8KgJQaLN9PANcFhYnOGNceK44
	 GV5vXUNoVInhcCom+cOtDu7UFrtsoi6LOF8zg41f4I9/jallaW3NrhdSiyNkOXal2t9Cx
	 CjfPMz+88OsftaeaYdvlsCxnBo8EciyhMGzamMDp7j0jcIIpy6FXRCcp9YQbiKGFHPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=POVeZItc;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B0B606A325;
	Thu, 29 Oct 2026 17:07:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0B0B606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=POVeZItc
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69TGE5Qw461034;
	Thu, 29 Oct 2026 17:07:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=fC02P9
	DKeLV7SV+GEdY6Mr54UvwJLAaeH6neAiWLgio=; b=POVeZItczQZMRGlPIDtXrR
	zy8GeSlM+xZEx1ewOZOR2MmpMXwINih1dmp3kJNO+mvuDaM1gxdnEcKMmJloWPbP
	tbMtCob4lG0MgUZb2+T97dHJJOfd3AAG8bdo5R2ZHzRhDHJiIM5FEKLYbQ6P8xCw
	Eyld4fDZhx5Otp+nLNxSgstOhfM1pRoMKrnyu9tPQTls4quiBt9yJ4thDn0kURNF
	qIReWDZivGASKglYg9JUvS/YuaT9C+AIrSmDWIz6/jq6cZxM+bc03L6CZDdYV5kt
	GxrhkmZEHWQcF5+GKiCPn0mn6mX6S3uW8oz2c5yedfs9voz2TfKHclOsMizW7O/w
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgmd7bmwr-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 29 Oct 2026 17:07:46 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69TGYlc53418716;
	Thu, 29 Oct 2026 17:07:45 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hk55pg03x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Oct 2026 17:07:45 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69TH7inU15598266
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Oct 2026 17:07:44 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5329758051;
	Thu, 29 Oct 2026 17:07:44 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AA3A35805E;
	Thu, 29 Oct 2026 17:07:43 +0000 (GMT)
Received: from [9.61.101.238] (unknown [9.61.101.238])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 29 Oct 2026 17:07:43 +0000 (GMT)
Message-ID: <6cbff21c-a080-493c-bef4-0943b0680b71@linux.ibm.com>
Date: Thu, 29 Oct 2026 13:07:43 -0400
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 15/15] s390/vfio-ap: Add live guest migration chapter
 to vfio-ap.rst
To: sashiko-reviews@lists.linux.dev, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>
References: <20261023174349.3545941-1-akrowiak@linux.ibm.com>
 <20261023174349.3545941-16-akrowiak@linux.ibm.com>
 <sashiko-outbox-183047@kernel.org>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <sashiko-outbox-183047@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=ZYOIpcVA c=1 sm=1 tr=0 ts=6ae37d62 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=ZVl0G4KO2zEQoFCSB98A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA2NSBTYWx0ZWRfX0AELNxKeCyYW
 6z/4C/UHygpDHgtbP7WMGmTbsVVDDcviQoHPt7UdtCx2LU9O514PzkAxJIWJlFcKYASBwrwAA3J
 5rqhGz5Xg6U9PGS88J/DkLHXANBfYuuCVviMzqY42GaTg680Kq1TX2Z+O8zL9Xa5CCPv0PDO/Rz
 jejbGpoBEz2n94TGGdKhyPvfnzQNRcVas90gnOTD+UORbZXFZLsAgqzTW5Ndk/VOaYD4opdnxk9
 EvcpRuVqxZ0VzvNWhJSYUnhCzfYFz5DLMcivbiyH+dNup/sFhcabzMrebYdCklZ+qUsoZba0aFm
 UZnjRn3t8eW6xK2v/Ai0oekBtRrQO9bOLWuuPeJupAoqiEZUM7JmLLa0Vj5CWeXeeR+Wmv0yu9b
 GsbylPjWh6UaT+SEKt+OJPmyyooPNgR0L3xK3ovDKvRA79f6urzBvB0DdCMzUhxGiZJbveIlYfB
 adIk6rBD6IqlRNP5e2w==
X-Proofpoint-GUID: jmPsZ33-5x3hSqwSOdY-4QE-wI_02VZG
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA2NSBTYWx0ZWRfX182pVtTnvXmO
 wRkEW8nv1ixBq4uaX6yA9KZTd7Bp8wNC269TRz0tEnEjSpM/SQEGMVJXGu3hB5INngEkMjNHd9X
 uIHg4sdSUSGRYjqAtif6Zq9pbUyOl34=
X-Proofpoint-ORIG-GUID: jmPsZ33-5x3hSqwSOdY-4QE-wI_02VZG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 phishscore=0 clxscore=1015
 bulkscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290065



On 10/23/26 2:09 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] s390/vfio-ap: outdated migration error logs and return codes in vfio-ap.rst
> --
>
> commit fc329ac666c2f8054a2481eb51b1b63f8f3ee4bd
> Author: Anthony Krowiak <akrowiak@linux.ibm.com>
>
> s390/vfio-ap: Add live guest migration chapter to vfio-ap.rst
>
> This commit adds a Live Guest Migration chapter to
> Documentation/arch/s390/vfio-ap.rst describing how to configure and
> troubleshoot live guest migration for KVM guests with passed-through AP
> devices, along with minor comment updates in the vfio_ap driver.
>
>> diff --git a/Documentation/arch/s390/vfio-ap.rst b/Documentation/arch/s390/vfio-ap.rst
>> index ac0c07f76ddd7..f5d9e32875035 100644
>> --- a/Documentation/arch/s390/vfio-ap.rst
>> +++ b/Documentation/arch/s390/vfio-ap.rst
> [ ... ]
>
>> +3. Assign adapters, domains and control domains to the destination mediated device
>> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> +Assign the same adapters, domains and control domains to the destination
>> +mediated device as are assigned to the source guest's mediated device. For
>> +example, using the same adapters, domains and control domains from the
>> +previous step:
>> +
>> +.. code-block:: bash
>> +
>> +   echo 0x0 > /sys/devices/vfio_ap/matrix/62177883-f1bb-47f0-914d-32a22e3a8804/assign_adapter
>> +   echo 0x14 > /sys/devices/vfio_ap/matrix/62177883-f1bb-47f0-914d-32a22e3a8804/assign_adapter
>> +   echo 0x16 > /sys/devices/vfio_ap/matrix/62177883-f1bb-47f0-914d-32a22e3a8804/assign_adapter
>> +   echo 0x33 > /sys/devices/vfio_ap/matrix/62177883-f1bb-47f0-914d-32a22e3a8804/assign_domain
>> +   echo 0x3a > /sys/devices/vfio_ap/matrix/62177883-f1bb-47f0-914d-32a22e3a8804/assign_domain
> [Severity: Low]
> This isn't a bug, but since this example states that it assigns the adapters,
> domains, and control domains from the previous steps, should it also include
> the assign_control_domain commands for 0x33 and 0x3a?

That's probably a good idea; I'll make the change.

>
> [ ... ]
>
>> +One or more queues are not bound to the vfio_ap driver on the destination host
>> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> +The queue devices passed through to the source guest are not installed in the
>> +destination host or are not bound to its vfio_ap device driver.
>> +
>> +**Source host**
>> +
>> ++--------------+----------------------------------------------------------------+
>> +| Log          | Message                                                        |
>> ++==============+================================================================+
>> +| Console log: | error: operation failed: migration failed. Message from the    |
>> +|              | source host: operation failed: job 'migration out' failed:     |
>> +|              | Sibling indicated error 1. Message from the destination host:  |
>> +|              | operation failed: job 'migration in' failed: load of migration |
>> +|              | failed: No such device: Failed to load vmstate version_id: 1,  |
>> +|              | ret: -19                                                       |
>> ++--------------+----------------------------------------------------------------+
>> +
>> +**Destination host**
>> +
>> ++--------------+----------------------------------------------------------------+
>> +| Kernel log:  | vfio_ap_mdev $UUID: Queue $APID.$APQI not available to         |
>> +|              | vfio_ap driver on target host                                  |
>> ++--------------+----------------------------------------------------------------+
>> +| QEMU log:    | shutting down, reason=failed                                   |
>> +|              | qemu-system-s390x: terminating on signal $SIGNAL_NUM from      |
>> +|              | pid $PID $DAEMON                                               |
>> ++--------------+----------------------------------------------------------------+
>> +
>> +
>> +One or more control domains are not available on the destination host
>> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> +The control domains passed through to the source guest are not installed on the
>> +destination host.
>> +
>> +**Source host**
>> +
>> ++--------------+----------------------------------------------------------------+
>> +| Log          | Message                                                        |
>> ++==============+================================================================+
>> +| Console log: | error: operation failed: migration failed. Message from the    |
>> +|              | source host: operation failed: job 'migration out' failed:     |
>> +|              | Sibling indicated error 1. Message from the destination host:  |
>> +|              | operation failed: job 'migration in' failed: load of migration |
>> +|              | failed: No such device: Failed to load vmstate version_id: 1,  |
>> +|              | ret: -19                                                       |
>> ++--------------+----------------------------------------------------------------+
>> +
>> +**Destination host**
>> +
>> ++--------------+----------------------------------------------------------------+
>> +| Kernel log:  | vfio_ap_mdev $UUID: Control domain $DOMAIN_NUM not available   |
>> +|              | on the destination host                                        |
>> ++--------------+----------------------------------------------------------------+
> [Severity: Low]
> Are the documented kernel log messages and return codes in these two sections
> out of sync with the current implementation in
> drivers/s390/crypto/vfio_ap_migration.c?
>
> When a queue or control domain from the source guest is missing on the
> destination host, do_post_copy_validation() calls
> ap_config_is_subset_of_shadow_apcb():
>
> drivers/s390/crypto/vfio_ap_migration.c:ap_config_is_subset_of_shadow_apcb() {
> 	for (int i = 0; i < source_config->num_queues; i++) {
> 		...
> 		if (!test_bit_inv(apid, matrix_mdev->shadow_apcb.apm) ||
> 		    !test_bit_inv(apqi, matrix_mdev->shadow_apcb.aqm)) {
> 			pr_err_ratelimited("vfio_ap_mdev %s: Queue %02lx.%04lx not in destination mdev's AP configuration\n",
> 					   mdev_name, apid, apqi);
> 			ret = false;
> 		}
> 	}
>
> 	for_each_set_bit_inv(domain_num, (unsigned long *)source_config->adm,
> 			     AP_DOMAINS) {
> 		if (!test_bit_inv(domain_num, matrix_mdev->shadow_apcb.adm)) {
> 			pr_err_ratelimited("vfio_ap_mdev %s: Control domain %04lx not in destination mdev's AP configuration\n",
> 					   mdev_name, domain_num);
> 			ret = false;
> 		}
> 	}
> }
>
> And do_post_copy_validation() then returns -EINVAL (-22, Invalid argument)
> rather than -ENODEV (-19, No such device):
>
> 	if (!ap_config_is_subset_of_shadow_apcb(mdev_name, matrix_mdev,
> 						source_config))
> 		return -EINVAL;
>
> Should the documentation be updated to reflect the "not in destination mdev's
> AP configuration" messages and -EINVAL (-22) return code?

This is a valid documentation bug. The documented kernel log
messages and return code do not match the current
implementation. The documentation will be updated as follows:

Queue not available:
   "vfio_ap_mdev $UUID: Queue $APID.$APQI not available to
    vfio_ap driver on target host"
should be:
   "vfio_ap_mdev $UUID: Queue $APID.$APQI not in destination
    mdev's AP configuration"

Control domain not available:
   "vfio_ap_mdev $UUID: Control domain $DOMAIN_NUM not
    available on the destination host"
should be:
   "vfio_ap_mdev $UUID: Control domain $DOMAIN_NUM not in
    destination mdev's AP configuration"

The return code in the console log (ret: -19 / -ENODEV) will
be corrected to ret: -22 / -EINVAL.

>
> [ ... ]
>
>> diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypto/vfio_ap_migration.c
>> index 660b5a21fe9e8..ac135872da2fa 100644
>> --- a/drivers/s390/crypto/vfio_ap_migration.c
>> +++ b/drivers/s390/crypto/vfio_ap_migration.c
>> @@ -217,8 +217,9 @@ static const struct vfio_migration_ops vfio_ap_migration_ops;
>>   /**
>>    * vfio_ap_setup_vfio_device_migration:
>>    *
>> + * Enable
>>    * Plug the object containing the function pointers to the migration callbacks
>> - * required to facilitate VFIO AP migration into the mdev
>> + * used to facilitate migration of a vfio-ap device.
> [Severity: Low]
> This isn't a bug, but was the stray "Enable" line in the comment above
> vfio_ap_setup_vfio_device_migration() left in by mistake?

Already addressed and will be fixed in the next series.

>

