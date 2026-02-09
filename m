Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC2829C321;
	Mon,  9 Feb 2026 18:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770661238; cv=none; b=UQMgVNtudpmhVXb/MYnk0+GTj8HaLXyJFlZpwKxSlfiiOWOQMOp7dhKbMvOTED/3mEZbuK3+Zemwd8l/i/29jcrwVWhXXiYTpvrrQfwo75m0Aj4Z7EeYR4r+iPWUUwL7S58UTXu2AndNIZSlSnV/dtpDHepU0+StYu4bkNWJcXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770661238; c=relaxed/simple;
	bh=7PXbBG4VwmEOeP5gGDpm0rCmhJixzCNNkZssgDhtOgg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n2S11pwSCvIDOih77Sxt0iJPiECfuBs44wSv1gkLBsX23TlLsl9nkWD7eBEF+LgoOqjxg3Pv47xEhyoBHc8EFvQPAP01OVCSnXm9Yqrcx/skTuemY9p7t//ab+6VGGTkWAhpRzjORX3AwTTFCodooO3PagZesO8HF4blSUJIDM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=obhooxvM; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="obhooxvM"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61982oHr2344404;
	Mon, 9 Feb 2026 18:20:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=6kUrJz
	Nyw4NnLlSAH2QCv/4meAWS923Hh1+kcqhiO90=; b=obhooxvM1R5m8Pct3QkBlg
	mjffE72xSlKAUS9xFENCB53ihf/LY1QjqZqe8V0EBYKoUFTE0G8DIS615CELgRaL
	vz12mzT7yB2K6RwxyUezf8PKCIwEWcJmFR4VznvguwBrJdxiXzXHwW10FfM2p9pu
	swqBYh6QwbPGqlJ2Wj6ow6P0+wNgye8+GpxS6ANwyYH9OiP6pYmuF29pcb0jR5Po
	HvOnHduzAtEtcsymX4MLJBJ+3u44CXslYgK8/X3aYfZUO2RH4AAYeGrKZmUFscHB
	ZG6RSkW4cK+OTvFhxfMSYqXtW+xbl/bkF8k0bPTlV/CpHUT+h2kGNkrmqS0Xb1qw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c696u8q39-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Feb 2026 18:20:31 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 619EMEwg019251;
	Mon, 9 Feb 2026 18:20:31 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4c6hxjx34p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Feb 2026 18:20:30 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 619IKT2u15008472
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Feb 2026 18:20:29 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0175358055;
	Mon,  9 Feb 2026 18:20:29 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 40C0858043;
	Mon,  9 Feb 2026 18:20:28 +0000 (GMT)
Received: from [9.61.249.49] (unknown [9.61.249.49])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  9 Feb 2026 18:20:28 +0000 (GMT)
Message-ID: <3f4d4a10-f7a7-4b60-b42a-075b6df395f7@linux.ibm.com>
Date: Mon, 9 Feb 2026 10:20:27 -0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 3/9] PCI: Avoid saving config space state if
 inaccessible
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, lukas@wunner.de, alex@shazbot.org,
        clg@redhat.com, stable@vger.kernel.org, schnelle@linux.ibm.com,
        mjrosato@linux.ibm.com, julianr@linux.ibm.com
References: <20260207003936.GA112515@bhelgaas>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20260207003936.GA112515@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=KZnfcAYD c=1 sm=1 tr=0 ts=698a256f cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8
 a=k7L6yOQrr6rJGXFB698A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA5MDE1NCBTYWx0ZWRfX7P7t/r4q+90g
 iP6moakpHDB6r4NuGIwKoiMcBsTRCjamchnno+S0U6eWJOQppQ7ThIuXfRa1VFqhHD2AlgoNiC+
 719xfYBtzvfEtP97Y3IUITeX90Rd4OSkZh+opg79r1ZcV9DtjMAA/tRsow77poZPp0+wQciJu0d
 3KfIfTelRhLxX1b/ci/bsR+7RSpf2RlN6wsSQuVrxUfeejclnBoxffMdpxFtTtkDPo0eyTEL9px
 HmNhubcDI4azeIKovK79odPUyGSjzHwZS4fG66Enk0rezPqW3q46EX5FqBopPWoB87YNfC4PLzT
 8BHqGBiOvy4A8VmcL3uroUGaWjyTFMzzejmbMh9H0h9VhKIgBdATHcpMo0H+BufMPQgSJXyQF2Y
 xM640fsxAsp95lLoXCwqY95/u0k3HR0OoGwIuBmFBrf7QFP9okqeeuQsND97eHgk7uItLjrDA88
 TFUSzox6k7biSlxRtvQ==
X-Proofpoint-ORIG-GUID: qFc341DCRiVukIx7qGmIcgHw2lejbwj5
X-Proofpoint-GUID: qFc341DCRiVukIx7qGmIcgHw2lejbwj5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-09_01,2026-02-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 clxscore=1015 suspectscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602090154

Hi Bjorn,

Thanks for reviewing!

On 2/6/2026 4:39 PM, Bjorn Helgaas wrote:
> On Thu, Jan 22, 2026 at 11:44:31AM -0800, Farhan Ali wrote:
>> The current reset process saves the device's config space state before
>> reset and restores it afterward. However errors may occur unexpectedly and
>> it may then be impossible to save config space because the device may be
>> inaccessible (e.g. DPC) or config space may be corrupted. This results in
>> saving corrupted values that get written back to the device during state
>> restoration.
>>
>> With a reset we want to recover/restore the device into a functional state.
>> So avoid saving the state of the config space when the device config space
>> is inaccessible.
>>
>> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
>> ---
>>   drivers/pci/pci.c | 14 ++++++++++++++
>>   1 file changed, 14 insertions(+)
>>
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index c105e285cff8..e7beaf1f65a7 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -4960,6 +4960,7 @@ EXPORT_SYMBOL_GPL(pci_dev_unlock);
>>   
>>   static void pci_dev_save_and_disable(struct pci_dev *dev)
>>   {
>> +	u32 val;
>>   	const struct pci_error_handlers *err_handler =
>>   			dev->driver ? dev->driver->err_handler : NULL;
>>   
>> @@ -4980,6 +4981,19 @@ static void pci_dev_save_and_disable(struct pci_dev *dev)
>>   	 */
>>   	pci_set_power_state(dev, PCI_D0);
>>   
>> +	/*
>> +	 * If device's config space is inaccessible it can return ~0 for
>> +	 * any reads. Since VFs can also return ~0 for Device and Vendor ID
>> +	 * check Command and Status registers. At the very least we should
>> +	 * avoid restoring config space for device with error bits set in
>> +	 * Status register.
>> +	 */
>> +	pci_read_config_dword(dev, PCI_COMMAND, &val);
>> +	if (PCI_POSSIBLE_ERROR(val)) {
>> +		pci_warn(dev, "Device config space inaccessible\n");
>> +		return;
>> +	}
> This seems related to Lukas' recent patches:
>
>    a2f1e22390ac ("PCI/ERR: Ensure error recoverability at all times")
>    5e09895b4063 ("Documentation: PCI: Amend error recovery doc with pci_save_state() rules")
>
> My poor understanding is that the PCI core now saves config space for
> every device at enumeration time, and if a driver wants to capture an
> updated config space after it has changed things, it is responsible
> for doing that explicitly.
>
> a2f1e22390ac gives us a baseline saved state that will be restored in
> some cases.  This pci_dev_save_and_disable() is part of the reset path
> and saves a potentially different state.  I'm a little uncomfortable
> about the fact that we save the state at different times, including
> unpredictable times after an error, and I'm not sure the driver can
> always know what gets restored.
>
> Maybe the reset path shouldn't even try to save config space again,
> since we're now guaranteed to have at least the state from
> enumeration?  I suppose skipping the save here would expose cases
> where the driver changed config space without doing a pci_save_state()
> itself, and a driver- or sysfs-initiated reset would lose that change,
> whereas today we preserve it because we save/restore as part of that
> reset.
>
> That change would also be lost if the reset was unintentional, e.g.,
> during error recovery, but I guess in that case the driver does know
> that an error occurred, so it could redo the change.
>
> It seems like the ideal thing would be if every restore used the
> enumeration saved-state or the driver's intentional saved-state, never
> a state saved at the unpredictable time of an error recovery reset.

Maybe it does makes sense to not save the config space again here. Since 
we have a baseline saved state with commit a2f1e22390ac, removing the 
saving of config space here would restore the baseline state unless a 
driver saved its most recent state. So now we would have a working saved 
state when we restore.

However my fear is drivers may have come to rely on this to save/restore 
its latest updated state and we could break some drivers?

Thanks

Farhan

>
> I hope Lukas and Alex can chime in here.
>
>>   	pci_save_state(dev);
>>   	/*
>>   	 * Disable the device by clearing the Command register, except for
>> -- 
>> 2.43.0
>>
