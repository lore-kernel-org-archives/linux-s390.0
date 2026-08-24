Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA6646D2B9;
	Mon, 24 Aug 2026 17:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787591072; cv=none; b=UdqAvFc3G/Ozan3fKMj5So2uZ3GKIG5QInXRlt33EAyrpVxJn4g8kB9UQ7DT9Hiw9uu+jyzUWAMOEBjQHSugYEX/9DVlE03qKWU/wsTeaXmIEuVdN4et4tXJ5+8IKW0ybVtveHFjVoZL4l46I7qtoai9iwz27Mu1/GN19IyV1VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787591072; c=relaxed/simple;
	bh=OX7/x9/rL1muzv1eOjsVIgi8tATeHrvg/o1sldUzP1M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IO9+6s81Bv+7jedeRAT2PewfWldpBH+mb1fnUxiHdiPU4uJZ2IgD05GnN8qDKjm1fegUIhDc9iBGvrAf3S4IO745wli3kr3aNqXzAfBhtaLTFtHW5OgbdygGFjS5tvyPSndZLlmvLzX91ct7n0ENqYqpzMEIA9FQBMQe/LU+gHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GT+rL9sz; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GT+rL9sz"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67OG1eCO1241057;
	Mon, 24 Aug 2026 17:04:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=s5w8Ci
	VV/9NHvyqxxiCQqeasYfDHYECiarLVzfIfMQA=; b=GT+rL9sz1d8PrLZoUZf1+y
	aNlOC3YUUi9DuUtNoAxQOju/Jg0iBkUmbVmVAlgeEafbUN9LNcQWDfivY4h/BaxZ
	3+6AVZUT0f6L5lYr3Eqw1cJFEUH7/g8z0ueBVqQLaT9TYswedRj122n6wcBUnzKh
	orzMqBepxlihL8LcJ276tym+32TcwsaFIGs9OinJtPl1+QyibPcRlZ8wj6GV1oUM
	E5cDtU6DMkb6BUK2YKPo2NyD1oRaZ0GLFRqOMGXgXaiRHofDrGv3aN3pmKsIIs+x
	59sA4baZTHfkVYdpogitqqPzBf5KjywNV9bSyxZgqy5HzKRaRo/XWHPpBrhOi4Vw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g726eaw03-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 17:04:23 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67OGuKwG004622;
	Mon, 24 Aug 2026 17:04:23 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7qkgy803-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 17:04:23 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67OH4LQq27722490
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Aug 2026 17:04:21 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8BED158056;
	Mon, 24 Aug 2026 17:04:21 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8458058062;
	Mon, 24 Aug 2026 17:04:20 +0000 (GMT)
Received: from [9.61.21.147] (unknown [9.61.21.147])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 24 Aug 2026 17:04:20 +0000 (GMT)
Message-ID: <7d6f0567-e548-4659-b2ec-89de1016b26c@linux.ibm.com>
Date: Mon, 24 Aug 2026 13:04:20 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] s390/vfio-ap: Fix failure to release IRQ notification
 eventfd contexts
To: Anthony Krowiak <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, pasic@linux.ibm.com,
        alex@shazbot.org, kwankhede@nvidia.com, fiuczy@linux.ibm.com,
        pbonzini@redhat.com, frankja@linux.ibm.com, imbrenda@linux.ibm.com,
        agordeev@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        stable@vger.kernel.org
References: <20260824135850.503728-1-akrowiak@linux.ibm.com>
 <20260824135850.503728-3-akrowiak@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260824135850.503728-3-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=TfimcxQh c=1 sm=1 tr=0 ts=6a8c7997 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=ySGcNW1bs4U9-k9A-0UA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDE0MyBTYWx0ZWRfX6N9Jn/dnPRqv
 d4hEotxHKNuLF7oXLtJj19LLHazqPuIQu3dTR0+G7DI/p4deefiT6aj+OpHH0+IaaFaVYvpOZQx
 bRQA4bszOivr9tm6ebZ80rvwB2yC3W4=
X-Proofpoint-GUID: H5rSnsgHW_frNBzv_trzmd0bTUsIuvey
X-Proofpoint-ORIG-GUID: H5rSnsgHW_frNBzv_trzmd0bTUsIuvey
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDE0MyBTYWx0ZWRfXwnVDrQYXkH5r
 hD1lXfaP/KD6Ql1NEuCX/4Co30eZIhER4vjPsz7LR8w0COyRblEKfoMCkI/qGcidA4XBMCFqB/2
 MRXK+8QYRSux645Bbv+3ypqTwzGnraWV6huh7LukZwRDAe2AfR9QLI54jMYlFrPu5nIPqEWPZf3
 IJHaea/pDm10B61WaUTVm9JRcV0SfI5GO5Ds3EjSeUEKOHggljrNmQKNBWqxTKkntkMJSJCe9W0
 4oQZ3K8wWLLnRqVgJUVPo4kcmdbly5SbyBgmUwErmfuTetDtX/bNKcaNRrxk1WSgTrYvwpj/x0J
 HbUQZtBaTUvr2pcsC3cRgJhaen8iYcbQTo8wqSFQMFtFqmLEJ7hXKbVWmKcRN2Tk/1TlZlSBXZc
 Vg3xWRbNn6jO7Kxa/rgs2dbsCUYAWgBKROhDGvfPV9meTawJPgzb9/yehx9c1yoQivb1DbRZK4R
 fMa/wnyz9bf1IsxHqbg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_05,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240143

On 8/24/26 9:58 AM, Anthony Krowiak wrote:
> When userspace registers IRQ notification eventfds via the
> VFIO_DEVICE_SET_IRQS ioctl, vfio_ap_set_request_irq() and
> vfio_ap_set_cfg_change_irq() each call eventfd_ctx_fdget(), which
> takes a reference on the eventfd_ctx and stores it in
> matrix_mdev->req_trigger and matrix_mdev->cfg_chg_trigger
> respectively.
> 
> These references are dropped only when userspace explicitly replaces
> or clears them via a subsequent SET_IRQS call.  If the device is
> closed without that explicit teardown - because the guest exits,
> the VM process crashes, or the device file is simply closed -
> neither vfio_ap_mdev_close_device() nor the remove path releases
> these references.  The eventfd_ctx backing objects and their
> associated file references therefore leak for the lifetime of the
> kernel.
> 
> Fix this by introducing vfio_ap_mdev_release_eventfds() and calling
> it from vfio_ap_mdev_close_device() after vfio_ap_mdev_unset_kvm().
> The VFIO core guarantees that close_device is called before
> vfio_unregister_group_dev() returns in the remove path, so fixing
> close_device is sufficient to cover both teardown paths.
> 
> Note:
> ~~~~
> The matrix_dev->mdevs lock must be held during the call to
> vfio_ap_mdev_release_eventfds(). There is a small window between the calls
> to vfio_ap_mdev_unset_kvm() which gets and releases the update locks
> and the acquisition of the matrix_dev->mdevs_lock mutex during which
> it is possible - although highly unlikely during normal operation - whereby
> a concurrent SET_IRQS call can get in.
> 
> Taking matrix_dev->mdevs_lock around vfio_ap_mdev_release_eventfds()
> is sufficient to make this race-free. The SET_IRQS ioctl path writes
> req_trigger and cfg_chg_trigger only from vfio_ap_mdev_ioctl(), which
> holds mdevs_lock for its entire duration and always calls
> eventfd_ctx_put() on the previous value before storing the new one.
> 
> Any number of concurrent SET_IRQS calls during the window between
> vfio_ap_mdev_unset_kvm() and the acquisition of mdevs_lock are
> therefore safe: each ioctl invocation puts the reference it found and
> installs a new one, leaving exactly one live reference in the field
> when it releases the lock. When release_eventfds subsequently acquires
> mdevs_lock it finds that single surviving reference and puts it.
> Conversely, a SET_IRQS call that loses the race and blocks on
> mdevs_lock will find the field NULL after release_eventfds finishes,
> take ownership of the reference it just created, and install it into a
> field that will never be read again - a transient leak. To close that
> final case, callers must ensure no new SET_IRQS ioctls can be issued
> after close_device() is called, which the VFIO core guarantees by
> releasing the device file before invoking close_device().
> 
> Fixes: bf48961f6f48e ("s390/vfio-ap: realize the VFIO_DEVICE_SET_IRQS ioctl")
> Cc: stable@vger.kernel.org
> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>


