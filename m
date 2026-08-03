Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46797400E0C;
	Mon,  3 Aug 2026 11:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785756607; cv=none; b=WFTCywm3cLeQZTD2OH1/Q2sc78st3H0lvigki9oSOrRsO/RxMHkRdV5J+TDYBfaC5FjpjTnhHlAhAYzwCajq8dBTdu1aBwWlCqgL3xBqSzT6pZ1DgJ++shJZWvQHvY2sGuC+78fmGGtTRibaqSy9sOJJWkdAgtOpgwSjBqKr5jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785756607; c=relaxed/simple;
	bh=FdrjVkk/6pf+4o/OOc9T+Cezgl8CuLsN/UzKWOPz86Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W6wNaNhPvtEeFju5Uwp9JfA2/YAxhP7L/4u3igN/uVWAhhYCvk5kHKfJoe5jMnz3VS1fOaULc2zSTdF4LiBwW1nupKkGGs8e9l8b12CNmgu4a07xg4GSEAcmA0OxTPAf9ueWfz7M1D4hiOTJJGcYLaKpLvEQ9kyVbiqYdi8pa/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hWIMzGMu; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hWIMzGMu"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 672LleNM159788;
	Mon, 3 Aug 2026 11:30:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=xr7UkbgqVUgzcu3Iz9V5Xakc4CpMFw
	cZ1YKraCKKVKM=; b=hWIMzGMuw28/xK++4v7mRlvyQkXrC+u7WO2Ji4GtX0+mBk
	jrKZL7l2yY+R2MxGmOvwV14I7Ft4sjkRYDK5BTLGmj+ML9194p6YuO+FaU4h3zh2
	HoA9u0DT8b8ovZB4FRRUFIlWA/9+53CX+kUDJctXTSRBYn4ldSa6sQ56kxqHqRo8
	tqTx/a8VJMZSBFg0Oq2dHquHgUhINochAe9oYyiNQse4FvAss3z4YSkEbFaYzsVz
	/0sT4YqKAi3YjLWxmWSF7sNn/ewtt4jyJdETddKf5x2d72BP5OOCvNRmMaHoHre8
	Lo9Jci2WooqGXgaDkOz6RH2+IYIuSwJgFSrmx33Q==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs67hgdwj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 11:30:04 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 673BQKj6021150;
	Mon, 3 Aug 2026 11:30:04 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fsu4qd95w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 11:30:04 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 673BTwKl31588890
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Aug 2026 11:29:58 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 90F4E20063;
	Mon,  3 Aug 2026 11:29:58 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5C53E2006A;
	Mon,  3 Aug 2026 11:29:58 +0000 (GMT)
Received: from osiris (unknown [9.111.54.91])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  3 Aug 2026 11:29:58 +0000 (GMT)
Date: Mon, 3 Aug 2026 13:29:57 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: sashiko-reviews@lists.linux.dev
Cc: Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH 2/3] s390/pci: Rework__zpci_event_availability() to
 remove conditional locking
Message-ID: <20260803112957.14792B73-hca@linux.ibm.com>
References: <20260803100723.2343688-1-hca@linux.ibm.com>
 <20260803100723.2343688-3-hca@linux.ibm.com>
 <20260803101800.552771F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260803101800.552771F00A3D@smtp.kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDEwMSBTYWx0ZWRfX3nc3mwD9YwO+
 3zgMNqjrsUebpVoCG0hF33jag2SlxwlJVdAs8tw9kGCE3OzRykmEM7ti9SDzI32re/4A6VCl8vB
 S8b3JuinsjJwtzLiH2NndXXRpbsyioc=
X-Authority-Analysis: v=2.4 cv=I7VVgtgg c=1 sm=1 tr=0 ts=6a707bbd cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=yR1eWViBl3nv4v3brwEA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDEwMSBTYWx0ZWRfX8E1YJzOA9wvi
 JPf88U2jNWkcmHYIxwaZ9WwKNKRerNXm9diH2iaY7Ei3Z6miF3pJoLWXt2qsHbvQE29W0YWVdre
 YbFqbbcZufyK/1A+6BntKeqRUGy/z/1rLeRTZZIjhR+8TyBzNqFcJW1CLW1eJBitu4o+WIMFOh0
 Hph9S/znMUk4QThHqeRDmxS5gx5YeCVynp00GPXcTS/qqkvizn2sRPAuFoWAIm2yjcM0IdrwaCa
 DaPLjCymBGXe8zMU5Z6aa0nICF04EdsQAxWFlP+YmCcNNooRiwv/YfpcH/aBpGuEhsW1tt7CXgw
 2qjv6CoZo1sPBmhcyINM8y1E2aciwbOdSQY13CVGqYrvyy3+ePQDn9kohtFgkB7TLdxje5+/J+/
 ssRo+EwKhw5PzbQs/jygoY66EFRkI9udc22qyAHpErv9S+wJM4xLEHY29Ag1R/AHrThhiSv7QCv
 igl6qrhVulYhGu6LuyA==
X-Proofpoint-ORIG-GUID: H44tSBUDnBDoLYy2mbrtVk7FbUvf3p9U
X-Proofpoint-GUID: H44tSBUDnBDoLYy2mbrtVk7FbUvf3p9U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_06,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030101

On Mon, Aug 03, 2026 at 10:17:59AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] The `zdev` reference obtained via `get_zdev_by_fid()` is leaked when handling the `0x0306` PCI event.
> > -	if (existing_zdev)
> > -		mutex_lock(&zdev->state_lock);
> > +	if (ccdf->pec == 0x0306) {
> > +		/* 0x308 or 0x302 for multiple devices */
> > +		zpci_remove_reserved_devices();
> > +		zpci_scan_devices();
> > +		return;
> 
> [Severity: High]
> Does this early return leak the zdev reference?
> 
> If get_zdev_by_fid() finds an existing device, it increments its reference
> count. By returning directly here when the event code is 0x0306, it seems we
> skip calling zpci_zdev_put() at the end of the function. Could this prevent
> the device from being properly freed during hot-unplug over time?

This is correct, but trying to fix this I also looked a bit deeper
into the code and found a "pre-existing" issue. Oh, well..
