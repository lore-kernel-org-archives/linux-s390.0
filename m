Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07584257452;
	Mon, 22 Jun 2026 21:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782164438; cv=none; b=quw9snPKHGYpAZ3wSRpgnulURPA5tCPdZxKZJZ6iPp6HPXDsnobQpW8MgJJ62nNsiyqm372h+4+J6m/RJG/Wtv7HYB1c6jj9iarIFrdyBoQ30IZj/1SpNI0F2Ocuxnbh1A3q/2jmRpsZFPE/qheiYhi/UCTXBnq/OP4T6Q0sthA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782164438; c=relaxed/simple;
	bh=rDWtP3bGK4Fnje+sic/3jtEsWBKankZeUAPn39oq3rY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fpaQr/qQvmbLz4pwyzU6lMZLdXbzaAGfBvIaVMNi1ivaQr4BKzcv9evlnNVnhjOWPxHPg6Wyj+OaC48vDl0PeuljJDmpQe2m/uIozQOSKbkN4lyq6LgqqmwpI6zcnwnWFo8mQYzreDTjYd5pxK9xQypCbMJfb1X2RwfEYbg9JaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NNxzdyDG; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NNxzdyDG"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65MJmH183990964;
	Mon, 22 Jun 2026 21:40:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=vUIRkw
	bJQamY2k/A+9tlqzaJ9s6MG/ps6a6DlqApoBY=; b=NNxzdyDGZg1zuan6LY4q1B
	dHhOSIXd6TfMNzZd5qHqTmd0E/3Ax5sztxsMh6FTvREHU1fO7RC+8Eh1sGuKt6sB
	nE9CPZIdVNuV8RB7L2k4Va/9m4G589LQUKLsXuWobHAJDJ9MzDyRuuBqXvWF40B7
	99P3ShAyKjx6b2Jwre3V9955Ca5AAE1qa7QttTYw4VLVLHGwFSMx/4SUSXvjOxTv
	P7BvMHRHrCrsW74ne4lcaz8iQOfGYY7b9grK6lX7kaHpa+2i1b5l/Ix7vue/r+/t
	Mxkzhl+FhTJhYkOwX7kvtX07TiikTlRlUpRxBlRfo/cBIoJS7GcAiKNpexsTHOew
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjc3bgs5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jun 2026 21:40:33 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65MLYgWX028835;
	Mon, 22 Jun 2026 21:40:32 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ex5jw8bsp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jun 2026 21:40:32 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65MLeVnR27918862
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Jun 2026 21:40:31 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 504FF58056;
	Mon, 22 Jun 2026 21:40:31 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 61CB958052;
	Mon, 22 Jun 2026 21:40:30 +0000 (GMT)
Received: from [9.61.253.34] (unknown [9.61.253.34])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 22 Jun 2026 21:40:30 +0000 (GMT)
Message-ID: <c83fdbc0-c01e-43c7-abca-33273b821f73@linux.ibm.com>
Date: Mon, 22 Jun 2026 17:40:29 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/4] s390/pci: Preserve FMB state in device
 re-enablement
To: Alex Williamson <alex@shazbot.org>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
        schnelle@linux.ibm.com, mjrosato@linux.ibm.com, alifm@linux.ibm.com,
        farman@linux.ibm.com, gbayer@linux.ibm.com
References: <20260612181048.91548-1-oelghoul@linux.ibm.com>
 <20260612181048.91548-3-oelghoul@linux.ibm.com>
 <20260622142201.3d5da194@shazbot.org>
Content-Language: en-US
From: Omar Elghoul <oelghoul@linux.ibm.com>
In-Reply-To: <20260622142201.3d5da194@shazbot.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=X4Ni7mTe c=1 sm=1 tr=0 ts=6a39abd1 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=c92rfblmAAAA:8
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=uE0uBCXfT79MI8kg7AIA:9 a=QEXdDO2ut3YA:10
 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDIwNiBTYWx0ZWRfX137pso0YUQVv
 rDrKYt9b8GB1GtRAnXDtrBHF5DbYEQivlhRJUtvTqQxTAm7tWlLmKeSf4NwnfDFbwmJ6RRaNszQ
 h5RIHxzOYNG3zuoZcgHn5Q6AEe8BHLc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDIwNiBTYWx0ZWRfX14hnu8+iufNx
 3wts/VxG/AGErIfORp7YtMGNQ7ngrj6Luy63jeMRv5wiqWjUiWjx6nYwV9IkxpiF36l2ENe6eyl
 5w52PsmAO5pOGHkzGdsB1vX8TWBxEU5MO2Iu7b/6yUNnyhRGY470SEBRzy6uN/jRQlTQJ+l6uAs
 5cErLz/lwA6eMaW3AWnXxVvNGg9xIfwETEAjkuaZC+lXbjep3KHs3Z+pef7qDRBCRCMXvIE0xK5
 0s0hnibdjUN9X6hFiLLvIgC5ho+f7UeGdVgHzdOOvV9qT4TDkJMPgU7hqdkpsV/K/GaBsamI885
 gue0soYII/Y5bfWROZn/a29iHWKMV/U2lerzOGaDMpxgqO1Dajsgjw0rxkGVEh97Z/EdoHtiIqa
 oc2g0tp9u5Np/AChXjE8e97QzH0r5iEy/rrnp+xdY/yrzmVvnNLP+gn5gWoRlq3+6tyLhGl278C
 3n0f3YOPuZzhFupt30Q==
X-Proofpoint-ORIG-GUID: rOf5j66sI9tZ0HtSofagCpYsA40btL9e
X-Proofpoint-GUID: rOf5j66sI9tZ0HtSofagCpYsA40btL9e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_04,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220206

On 6/22/26 4:22 PM, Alex Williamson wrote:
> On Fri, 12 Jun 2026 14:10:46 -0400
> Omar Elghoul <oelghoul@linux.ibm.com> wrote:
>> +int zpci_fmb_reenable_device(struct zpci_dev *zdev)
>> +{
>> +	u64 req = ZPCI_CREATE_REQ(zdev->fh, 0, ZPCI_MOD_FC_SET_MEASURE);
>> +	struct zpci_fib fib = {0};
>> +	u8 cc, status;
>> +	int rc;
>> +
>> +	lockdep_assert_held(&zdev->fmb_lock);
>> +
>> +	if (!zdev->fmb)
>> +		return zpci_fmb_enable_device(zdev);
>> +
>> +	fib.gd = zdev->gisa;
>> +	cc = zpci_mod_fc(req, &fib, &status); /* Disable function measurement */
>> +
>> +	/* Unlike in zpci_fmb_disable_device(), cc == 3 is not a valid state here
>> +	 * because we are re-enabling function measurement for the same function
>> +	 * handle.
>> +	 */
>> +	if (cc)
>> +		return -EIO;
>> +
>> +	zpci_fmb_clear_iommu_ctrs(zdev);
>> +
>> +	rc = zpci_fmb_do_enable(zdev);
>> +	if (rc) {
>> +		kmem_cache_free(zdev_fmb_cache, zdev->fmb);
>> +		zdev->fmb = NULL;
>> +	}
>> +
>> +	return rc;
>> +}
>> +EXPORT_SYMBOL_GPL(zpci_fmb_reenable_device);
> 
> Why is this exported?  Maybe this is leftover from the previous version
> where it was noted that the API claimed a failure on double enable that
> didn't actually occur because if used reenable.  Now we seem to have
> the alternate inconsistency, that FMB is automatically enabled as part
> of the standard PCI enable path, so the only initial operation
> available to userspace is to first disable FMB, which is an awkward
> API.  The v3 problem could have been solved in documentation, noting
> that a nested enable resets counters[1], while a nested disable
> generates an errno.  Thanks,

Acked in my reply to patch 3/4

> 
> Alex
> 
> [1] Also note the sashiko question whether reenable actually zeros the
> current fmb buffer or only the internal counters
> https://sashiko.dev/#/message/20260612182632.E4EE71F000E9%40smtp.kernel.org

This question may not be applicable because firmware resets them in
practice, but I will discuss it further with my team.

Thanks.

