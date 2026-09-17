Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AFB233945;
	Thu, 17 Sep 2026 02:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789611686; cv=none; b=a/U7YuzbQkY2lk00/LvncAKUTPXILP7VjS8KoaZnDB3ydQtPsXydnhmel/9st357smYe8uP+Zynq7KKJemTx62HuthB2xDrkKKU3sqyWapW31gtMukJXJJm3FPBwMHwjIcYhxRIAvM66BIU7FMjHQzbJWHms6uenEKjeuZU81oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789611686; c=relaxed/simple;
	bh=TKruj220bBeMpInQWRdN+2LLpxu/Tu+m+rJ1htldsKM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YOIaCKsdCrf4fxD5ucsaw4yib3K3Vy6Ahy62ZI25ElaQXPNH/dRK9ln65vQyqTfsnanot6lYDGUxkRnTFZmwVCk233RwLkG82daGx3H4DD/rJ1riE7B65SlJ3RxRuneRGXttP4x5j/yAlOXRa20SKHT15gNW8v7TMMBozus+ri8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=I/U3jt1H; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="I/U3jt1H"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68GG1des4057229;
	Thu, 17 Sep 2026 02:21:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=wsLomG
	8WGN26eDM38VN6HGTDJhA91Sy021ZMIYlZp2c=; b=I/U3jt1HiqWU6gVL8bs6P7
	6QDLk+sHKp1lEiFY3cuDgBMYRsRMaFIxCBClnxJcNNT2a4YNXn6adz7HYFj1KR6h
	C3cEHl7gbnX7y6Kyw2c+VsUOhtLDAwXESUeVO/dMok/CRoykvRbcf/sJQ7sMiozD
	/5bxSc+ky518hC59VjjQZwZA0uvurGk9zkiCpReVoGGRFsZzN3jiVZe4tRCpD6d4
	4tYFuduMCROte4FNzqq2lBhpIg1ZlUhyS/d+MFQUM7+6t1q8BeCc7bUt0AizX99X
	UkX19PrllfIAvQ31qt51PUev66d1ccbHpp5TzK9Tqtw7YwY3wWhKrTT7HiCPYLxw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmv5hytyg-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 17 Sep 2026 02:21:21 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68H0Ck0T2313500;
	Thu, 17 Sep 2026 02:21:21 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gr5ff8bwj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Sep 2026 02:21:21 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68H2LJ1U4719194
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Sep 2026 02:21:19 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9437C58050;
	Thu, 17 Sep 2026 02:21:19 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2767958045;
	Thu, 17 Sep 2026 02:21:18 +0000 (GMT)
Received: from [9.61.177.109] (unknown [9.61.177.109])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 17 Sep 2026 02:21:18 +0000 (GMT)
Message-ID: <099b4e3f-4156-42e4-a2e9-bdc715547bef@linux.ibm.com>
Date: Wed, 16 Sep 2026 22:21:17 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/4] s390/pci: Reuse FMB buffer and preserve state in
 device re-enablement
To: Omar Elghoul <oelghoul@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com, schnelle@linux.ibm.com,
        alifm@linux.ibm.com, farman@linux.ibm.com, gbayer@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org
References: <20260916213222.233-1-oelghoul@linux.ibm.com>
 <20260916213222.233-3-oelghoul@linux.ibm.com>
From: Matthew Rosato <mjrosato@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20260916213222.233-3-oelghoul@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDAyNSBTYWx0ZWRfX4xMa4EzfOqL8
 Sszk4JP1sAw7Qzt1mt1r4t3+895XLHbe8Q6SumC/wHaFQWcoHHj3Tma28cLJI7GCn8wv0N0P7bz
 /AddAw+D7OQ7OQ6dHIq5RdYaunHQ8vZZYc1FiO6LFiAXDUj5gU3LayorRkvPL/VNL2V0mxKblln
 0rJsZ14BOqOQMslfHVO9uNtdTnxNEaVRYr4MJM8KfwRfxgdPUdhS6EVChVHxW8CUDMkijf5jMe1
 Typ4dozH1Xt92nKS/l0K/LWa8cY6AuU/E+Fk1C1w5Nhbp5vLsWfEJP96mIsVGoQWBjHoAf5bKLl
 5UXM+2NQq4+R3ACb3tSyF/wcMTzxzyfJs6AEvBc2Aeui0FrnC1YIC0O+OtAFou1vgKyxzcE3hV0
 b6AZrgcjbtDVtCMXrS6E9Tp/P+1GIS60fujVYoZ+2yIG89gGZqr1ISIA9V6r54IlyipK033uRa9
 mb/OLtu998gA9e61ogA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDAyNSBTYWx0ZWRfXwU9C5HCp5gx4
 5OjbauRbGk0N+PTH7ZafpGnFN+D1ASUkQRdVxWHhtmntQiRTtV1D4zedSUJ2/NWZF06UiKiZQlB
 9h/cWTNCrz26whFaO9vQN3CBD+tlT58=
X-Authority-Analysis: v=2.4 cv=Zsx4uN7G c=1 sm=1 tr=0 ts=6aab4ea1 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=XNYn6gUGNGRw0UYtJOQA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: FF4LZ6b1qdqu5GRHEenFk2-DIeJ0U5Zc
X-Proofpoint-GUID: FF4LZ6b1qdqu5GRHEenFk2-DIeJ0U5Zc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-16_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609170025


> +int zpci_fmb_reenable_device(struct zpci_dev *zdev)
> +{
> +	u64 req = ZPCI_CREATE_REQ(zdev->fh, 0, ZPCI_MOD_FC_SET_MEASURE);
> +	struct zpci_fib fib = {0};
> +	u8 cc, status;
> +
> +	lockdep_assert_held(&zdev->fmb_lock);
> +
> +	if (!zdev->fmb_enabled)
> +		return zpci_fmb_enable_device(zdev);

Sashiko has a point here, won't all paths that call zpci_reenable_device
now unconditionally turn on FMB here even if it was purposely disabled?

The pattern of callers for zpci_reenable_device() is:

zpci_disable_device()
...
zpci_reenable_device()

We only care to re-enable the FMB during device re-enable if the device
had FMB enabled at the time zpci_disable_device() was called.

Thanks,
Matt

> +
> +	fib.gd = zdev->gisa;
> +	cc = zpci_mod_fc(req, &fib, &status); /* Disable function measurement */
> +
> +	/* Unlike in zpci_fmb_disable_device(), cc == 3 is not a valid state here
> +	 * because we are re-enabling function measurement for the same function
> +	 * handle.
> +	 */
> +	if (cc)
> +		return -EIO;
> +
> +	zdev->fmb_enabled = 0;
> +	return zpci_fmb_enable_device(zdev);
> +}
> +EXPORT_SYMBOL_GPL(zpci_fmb_reenable_device);
