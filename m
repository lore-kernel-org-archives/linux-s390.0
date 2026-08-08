Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B033B2AA;
	Sat,  8 Aug 2026 12:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786190736; cv=none; b=NiV3TpX3z/tKItJDaED6G5Dmddtz8RXSyUasu2AgaE1EN0OQBthwvVXe4ZhGZqjVO8GiJppmR2fg/cZEXpIdmRnOEw6gQbZGzLxr8sOl+LLFOdNft4dceIBc+kL0ch7Wd81aFMN9oN+URghlGa/zSCtjz7xme/vaaufUmHsWgf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786190736; c=relaxed/simple;
	bh=bbKCrRua32z4iylyWxb015ypo9VfUWlARsU39T25Ins=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V9gIMUnJzRSyqFpzwt5ZDdoem5VWmqf6Vzl/+utHJ6VnSRMneZluJ/fTtAe+2zSWvV5wUR2dnfsTJa8JcW2PXp9ZsQRfJmXAiCS7VegNB5JBUDsvDQAgtLXuDSNYDZ3nGzpkxdttXQK4Sn0om4kVAs7ScUJjl3RnEMS2wjckkpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ds2cYSXE; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ds2cYSXE"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 678AVb4U012016;
	Sat, 8 Aug 2026 12:05:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=vTXt0Q
	2h3u47845D1YPQ2AaYzR+SQeowTWlSxc7OMh4=; b=ds2cYSXERe5umupIM661se
	mr0iJZzkUvAFAylEniQ5BpHIriNOyDU5vQoS+eQmjcsVp2N+pFzBZwfzmLAGGZrT
	gfz0Ug/r3H/hwnZ26SZYMDfEehBB6bSzzQ0wBCDDOR55ROQ04HFLjgjNYahIIVIZ
	UeTuhdoHb42o85ugLVoqqn0sNYhkHkhFiGZ9Q4W+H013OjocuOsZ/D+3Kiaer9MM
	LH9h/6R/OWhYJNjGf3UOson5wPcLL1qUbAgd7y/z1Qg0V5XkNDDz6Bh6ddJgVvRs
	CmL+nkZAE+TebmJVvuC3Y1miLqfALpZV/xw0BenJ78uH2LPnP0tw7tpbA/XyFbyw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvnvs138-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 08 Aug 2026 12:05:33 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 678BuOJ1005429;
	Sat, 8 Aug 2026 12:05:32 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswbgu7sy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 08 Aug 2026 12:05:32 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 678C5Vg59175584
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 8 Aug 2026 12:05:31 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 83D625803F;
	Sat,  8 Aug 2026 12:05:31 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D3ED65804E;
	Sat,  8 Aug 2026 12:05:30 +0000 (GMT)
Received: from [9.61.94.189] (unknown [9.61.94.189])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sat,  8 Aug 2026 12:05:30 +0000 (GMT)
Message-ID: <4e8e189d-48ec-48b2-8d1b-2a2f40f67b89@linux.ibm.com>
Date: Sat, 8 Aug 2026 08:05:30 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] s390/vfio-ap: Fix control domain removal in
 vfio_ap_mdev_cfg_remove
To: sashiko-reviews@lists.linux.dev
Cc: Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>, kvm@vger.kernel.org
References: <20260807223939.573718-1-akrowiak@linux.ibm.com>
 <20260807225802.41BCD1F000E9@smtp.kernel.org>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <20260807225802.41BCD1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=RsP16imK c=1 sm=1 tr=0 ts=6a771b8d cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=D19gQVrFAAAA:8
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=8vdVCLQQ5IgfLE6QZuoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=W4TVW4IDbPiebHqcZpNg:22
X-Proofpoint-GUID: 9Xg0m4eylzBp61semCptw8BMn7qA8P-Z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA4MDEwMSBTYWx0ZWRfX8Iwqzv/R1MJm
 FUi7SsfZJ0CR8BsFiMb+uI111IFA2bgm2JYCx6tKDMFIxugNZklfLJhAp4fWR0QyTG+nfgCEY+q
 7ANh7OgaoNCpsWckUX2UI4txb+TJvzxbg4oL3RHQ3MJflfBeKh17UN2sGbpQcYxKPnlGC38N0Lw
 DN2qqgN8EDXjRRYSfTYHQqF9Q2zsA+6ZlI2P9bR7GqI3SpHDfm6xEWzDt7LLy63+tG8L+Vsm4Xw
 rvoNcceY999FUKC8LBxk45HrEdNfvHkmglcHiW94Kd6FAc8QBgHihALXeHSlhieDusiQ9TQvWuF
 pLiTvDJtwpxPKbNangivUpaTtzOI1wJl76wCLS777NyOjjm8qW1sXHryTkLo4USs+3hJCPyPdgD
 zLyDWMt/j3hdk9CLSdNowMIZET+mB6qchWVC5DJCSt5GP7obUQaj6OLzIyEUk75AOaGwQ8oDz5X
 5pEr95mURw6KOexAekA==
X-Proofpoint-ORIG-GUID: 9Xg0m4eylzBp61semCptw8BMn7qA8P-Z
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA4MDEwMSBTYWx0ZWRfX7qjKzXOKqR0d
 /Cp8swXnoIDNIssmTVmsQGu+SqOrXICBILBux3/X2zmk8LefYPFb3O7f0sgaZeGc2oH76QfJE12
 hnN5DTnBRKejtaRZYBG770mr24dHa90=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-08_04,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608080101



On 8/7/26 6:58 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
>
> Pre-existing issues:
> - [High] Missing NULL check on `matrix_mdev->kvm` before acquiring its lock on AP configuration change paths, leading to a kernel panic if a mediated device is unattached.
> - [High] Guest APCB is not updated when the last adapter or domain is removed, leaving the guest with unauthorized hardware access.
> - [High] Iterating `mdev_list` without the appropriate mutex allows concurrent list modifications, leading to list corruption or use-after-free.
> --
>
> --- Patch [1]: [PATCH] s390/vfio-ap: Fix control domain removal in vfio_ap_mdev_cfg_remove ---
> commit 934a77df4b71bb3ee940f94ad6abdd8290e96d28
> Author: Anthony Krowiak <akrowiak@linux.ibm.com>
> Subject: s390/vfio-ap: Fix control domain removal in vfio_ap_mdev_cfg_remove
>
> This commit modifies the vfio_ap_config_remove function to use bitmap_and()
> instead of bitmap_andnot() when clearing bits from matrix_mdev->matrix.adm.
> This ensures that explicitly unplugged control domains are correctly removed
> from the KVM guest.
>
>> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
>> index 44b3a1dcc1b36..1bfdbe85023dd 100644
>> --- a/drivers/s390/crypto/vfio_ap_ops.c
>> +++ b/drivers/s390/crypto/vfio_ap_ops.c
>> @@ -2615,9 +2615,9 @@ static void vfio_ap_mdev_cfg_remove(unsigned long *ap_remove,
> [Severity: High]
> This is a pre-existing issue, but does vfio_ap_mdev_cfg_remove() safely handle
> unattached mediated devices?
>
> If an mdev is created via sysfs, matrix_mdev->kvm is initialized to NULL. If a
> host AP configuration change occurs before this mdev is attached to a guest,
> the loop in this function:
>
> drivers/s390/crypto/vfio_ap_ops.c:vfio_ap_mdev_cfg_remove() {
>      ...
>      list_for_each_entry(matrix_mdev, &matrix_dev->mdev_list, node) {
>          mutex_lock(&matrix_mdev->kvm->lock);
>      ...
> }
>
> will unconditionally dereference the NULL kvm pointer. Is there a missing NULL
> check for matrix_mdev->kvm before acquiring its lock on AP configuration change
> paths?

A patch has already been posted for this:
https://lkml.org/lkml/2026/8/7/1453

I think it would be wise to submit that patch and this as a series since
both bugs were introduced with the same patch, so the Fixes: tag
for each would be the same.

>
> [Severity: High]
> This isn't a bug introduced by this patch, but can the iteration over
> mdev_list in vfio_ap_mdev_cfg_remove() race with mdev creation?
>
> vfio_ap_mdev_probe() adds a new mdev to matrix_dev->mdev_list using list_add()
> while holding only matrix_dev->mdevs_lock:
>
> drivers/s390/crypto/vfio_ap_ops.c:vfio_ap_mdev_probe() {
>      ...
>      mutex_lock(&matrix_dev->mdevs_lock);
>      list_add(&matrix_mdev->node, &matrix_dev->mdev_list);
>      mutex_unlock(&matrix_dev->mdevs_lock);
>      ...
> }
>
> However, vfio_ap_mdev_cfg_remove() iterates over mdev_list using
> list_for_each_entry() holding only matrix_dev->guests_lock, as mdevs_lock is
> only acquired individually inside the loop body.
>
> Could this lead to kernel memory corruption or use-after-free if a user
> creates a new mdev concurrently with an asynchronous host AP configuration
> change?

This needs to be fixed.

>
>>   		do_remove |= bitmap_and(aqrem, aq_remove,
>>   					  matrix_mdev->matrix.aqm,
>>   					  AP_DOMAINS);
>> -		do_remove |= bitmap_andnot(cdrem, cd_remove,
>> -					     matrix_mdev->matrix.adm,
>> -					     AP_DOMAINS);
>> +		do_remove |= bitmap_and(cdrem, cd_remove,
>> +					matrix_mdev->matrix.adm,
>> +					AP_DOMAINS);
>>   
>>   		if (do_remove)
>>   			vfio_ap_mdev_hot_unplug_cfg(matrix_mdev, aprem, aqrem,
> [Severity: High]
> This is a pre-existing issue, but does vfio_ap_mdev_hot_unplug_cfg() properly
> update the guest APCB when the last device is removed?
>
> In vfio_ap_mdev_hot_unplug_cfg(), the decision to update the guest's APCB
> relies on bitmap_andnot():
>
> drivers/s390/crypto/vfio_ap_ops.c:vfio_ap_mdev_hot_unplug_cfg() {
>      ...
>      if (!bitmap_empty(cdrem, AP_DOMAINS))
>          do_hotplug |= bitmap_andnot(matrix_mdev->shadow_apcb.adm,
>                                      matrix_mdev->shadow_apcb.adm,
>                                      cdrem, AP_DOMAINS);
>      ...
> }
>
> The kernel's bitmap_andnot() function returns true only if the resulting
> destination bitmap is non-empty. If the last adapter, domain, or control domain
> is explicitly removed, the destination shadow APCB becomes entirely empty,
> causing bitmap_andnot() to return false.
>
> Since do_hotplug remains false, vfio_ap_mdev_update_guest_apcb() is skipped.
> Does this leave KVM guests with unauthorized access to physical hardware devices
> that have been explicitly removed from the host's AP configuration?

The logic here is correct. The
concern rests on a misreading of what bitmap_andnot() returns
and what the bitmaps represent.

There are three functions that form a pipeline:

vfio_ap_mdev_on_cfg_remove() computes which adapters,
domains and control domains have been removed from the host
AP configuration by comparing the previous and current config
info bitmaps. If nothing was removed from a given bitmap,
that bitmap is empty and there is nothing to do.

vfio_ap_mdev_cfg_remove() intersects each of those
removed-from-host bitmaps against matrix_mdev->matrix,
which represents what the administrator has assigned to the
mdev. If the intersection is empty — none of the host-removed
resources were assigned to this mdev — there is nothing to
hot-unplug for this mdev.

vfio_ap_mdev_hot_unplug_cfg() intersects those
mdev-assigned-and-host-removed bitmaps against
matrix_mdev->shadow_apcb, which represents what is actually
passed through to the guest after filtering. The shadow_apcb
is a filtered subset of matrix — a resource assigned to the
mdev may not be in the shadow APCB if it was previously
filtered out (e.g., the queue was not passable, or the
resource was not in the host config at the time of the last
filter pass). If bitmap_andnot() returns false here, it
means none of the removed resources were present in the shadow
APCB to begin with — the guest never had access to them — so
skipping vfio_ap_mdev_update_guest_apcb() is correct.

Furthermore, bitmap_andnot(dst, src, rem) returns false only
when the result dst = src & ~rem is all zeros. If none of the
rem bits are present in src, then ~rem clears nothing and
dst == src. If src was non-empty, the return value is true
and vfio_ap_mdev_update_guest_apcb() is called — even though
the APCB content is unchanged. So there is no path through this
function where a genuine removal from the guest's APCB is
silently dropped.

>

