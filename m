Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E240F4E1C99;
	Thu, 17 Sep 2026 13:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789651979; cv=none; b=EVJT3sBw/IrW0STWcUmOPo0Dlkx4X3cR0Tc3HdwI6r7QFWp8S57Av96kOs4mWFDu+f2W+rDE5QmMrhGAx65V0yQzhT3TCqwF0ziGxyDr+97O1lidLaClghn1Ei65r5V2cqg7+tRmP+oh+1aXauzpC8a5Q2eKGqtjTeyjrNihZvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789651979; c=relaxed/simple;
	bh=mgJ4pOA/BDBTrfWlpwe2JXsiMIMXaH7rAYrCZqbb0/M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B5qGesbCeKcJ39xBxPkcl/0Kbenn/GqEo+iV7XiiWwqGFaGWry55Nf2oWzuKnZD1SP1Db8jzC4gcu7D2b7b1+f5qpfNxT3AIFx32YM6qgtfimv5dK7J71gt2J4ZMYOnfd8GhMEsSr9CpOyjvobYNtRpiRvEpn9E+XA63L1cPZhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jSlJhmGQ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jSlJhmGQ"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68HA1SVm322296;
	Thu, 17 Sep 2026 13:32:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ODgGJ4
	fkGZnjmAXhi3sqtR7uq5XJ8wMB23Pd/sPw//g=; b=jSlJhmGQqM6J6PUseibufc
	dgMJ/i1Q6OKS/vLCUXOis4zJ5JvvhCNTo8s30HN+rEN+zQmcGBX3MQxs1rA6ZceK
	l0p4guS4i16CQOmRo2VB4v333EgcFMQu7GVWgXOUiFl14usPL5qBQqEJPZVYzn0T
	9mdhpidYiPwNXK/uGl5KYrxd4tqfTcUshuia5X8zeZHx0Gwyky7L2tS/Xshw2K55
	VAIuUMEaAbFnJC1yjOBPGiRSpF+n35LVbQKPK+Lu2jnjP/gKlOESgzfCV/CNY77V
	zZ/GBu4O9E51V7eFl/VftV3HvAIjrVdmydmlqH3SucvSLGMw66UFwr61AifU/K7g
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxdqjmw4-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 17 Sep 2026 13:32:51 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68H9aIqP2962377;
	Thu, 17 Sep 2026 13:32:50 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gra3ysn8e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Sep 2026 13:32:50 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68HDWmPU28246548
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Sep 2026 13:32:48 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B24F058063;
	Thu, 17 Sep 2026 13:32:48 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 02DB058065;
	Thu, 17 Sep 2026 13:32:47 +0000 (GMT)
Received: from [9.61.247.238] (unknown [9.61.247.238])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 17 Sep 2026 13:32:46 +0000 (GMT)
Message-ID: <85cb647d-b1c8-4804-b206-2cae1e03e20d@linux.ibm.com>
Date: Thu, 17 Sep 2026 09:32:46 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/4] s390/pci: Reuse FMB buffer and preserve state in
 device re-enablement
To: Matthew Rosato <mjrosato@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com, schnelle@linux.ibm.com,
        alifm@linux.ibm.com, farman@linux.ibm.com, gbayer@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org
References: <20260916213222.233-1-oelghoul@linux.ibm.com>
 <20260916213222.233-3-oelghoul@linux.ibm.com>
 <099b4e3f-4156-42e4-a2e9-bdc715547bef@linux.ibm.com>
Content-Language: en-US
From: Omar Elghoul <oelghoul@linux.ibm.com>
In-Reply-To: <099b4e3f-4156-42e4-a2e9-bdc715547bef@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDE5MCBTYWx0ZWRfXx/upzehTN8Yr
 Cwn+G3lelFZilDPvTW5woglDWoDvLeTEYtQr+W+TwI/bACAe9PpQ02oVA9rMWPlt6FRRoul/LDE
 F8ikLriu3lpubOn+Q21ZYW1FVBeMHVfnoJAqcE+KyQYkb/hnYPds3LvK1Zkrd6XbASY8+Aa2K6F
 uD1LbDqswBlkrysIZruKvytIrBSLJ5+zBAw2qQArramqSbjyHrbnOVprKoXh8zhIUz27zdJUSJs
 ropyp9fZtBQZjOnd8brVlNuYzGPeF0iRNEfnN1ErreIzno7biNBwTRjLdygQq8OoYJcLp23xB6s
 f8OcFA/PbchUl4QS4/uoFAJfF+exY3ShUJHs5Mdl/rlEIa5oBkJIT4wzwKykIXaGVRY9H7Qqp2r
 ZIODJzAUwWaI8niGOJ9tVJ1KG7opOa9LQLqmFuXswlMCyHdHfTjFGBnlL889kMkEPiu5CEUowPX
 21SAz5m5I3ZQEUeMk9A==
X-Proofpoint-GUID: eqokwp51adjx54htjj43JQ1sPjUCIxO4
X-Authority-Analysis: v=2.4 cv=DobDa2/+ c=1 sm=1 tr=0 ts=6aabec03 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=EUQsns2teDQkhDBnVLYA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: eqokwp51adjx54htjj43JQ1sPjUCIxO4
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDE5MCBTYWx0ZWRfX8dZRNK2XIQZz
 Qv5ldF9ifEFyPcmAhKsUI5SpapQ7TQEHchVe8svr4n8flUALBr6UsVAOV5U+O2oaRtCqtCPnKUv
 xWYR1IPuXo4mZ3etzAR4o1ROAALhNaU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_02,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 spamscore=0 clxscore=1015 adultscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609170190

On 9/16/26 10:21 PM, Matthew Rosato wrote:
> 
>> +int zpci_fmb_reenable_device(struct zpci_dev *zdev)
>> +{
>> +	u64 req = ZPCI_CREATE_REQ(zdev->fh, 0, ZPCI_MOD_FC_SET_MEASURE);
>> +	struct zpci_fib fib = {0};
>> +	u8 cc, status;
>> +
>> +	lockdep_assert_held(&zdev->fmb_lock);
>> +
>> +	if (!zdev->fmb_enabled)
>> +		return zpci_fmb_enable_device(zdev);
> 
> Sashiko has a point here, won't all paths that call zpci_reenable_device
> now unconditionally turn on FMB here even if it was purposely disabled?
> 
> The pattern of callers for zpci_reenable_device() is:
> 
> zpci_disable_device()
> ...
> zpci_reenable_device()
> 
> We only care to re-enable the FMB during device re-enable if the device
> had FMB enabled at the time zpci_disable_device() was called.

The way I thought of it was pcibios_enable_device() already enables
measurement, so we might as well ensure it is enabled when the zdev is
re-enabled. That default state is also helpful for the later patches
because kvm_s390_pci_register_kvm() calls zpci_reenable_device().

But I guess if we didn't want to conflate the two, we could also add an
unconditional zpci_fmb_reenable_device() within the KVM register hook,
to run after the zpci_reenable_device(), whichever you'd prefer.

Thanks

> 
> Thanks,
> Matt
> 
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
>> +	zdev->fmb_enabled = 0;
>> +	return zpci_fmb_enable_device(zdev);
>> +}
>> +EXPORT_SYMBOL_GPL(zpci_fmb_reenable_device);
> 

