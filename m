Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2AC3093B5;
	Tue, 24 Mar 2026 22:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774391925; cv=none; b=Eb73qUMT5XsT68qcgJynthZKKEpZ2ntLL6CBb2yg4+4pKl1sfWI8XfJIIHf01WMjryYyZFhNws+Vm7MAz+U1ED0vIotHG2u8WJaa2TAPNtNV67Chr7eCizl9MlET5iA+yF5C7R2sPPA1kJrYxIqt85nA7F8dyczGxgh56X7EPQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774391925; c=relaxed/simple;
	bh=faBT++5Tio+4QHSGjNOMrAm/+3siVkaZ4BtLc2bmyE0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=URN0l5pYgvR3eKAkI1U0WIX6OobKideuDCYsuFbV8c3Gg+YN8RWnqz3OMQcnwdyJXk7hi5iKQBdzVRlnN64dfR1gNBVpLgNFBZwvq1sLTlX5OG/dBwl36/oYtMHtPCP4CpZm6XZoBTm3fso5eLTk1/HqTzA/fLQxqL5bqv/R2aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OUdC+C2p; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OUdC+C2p"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62OHCPlw4102573;
	Tue, 24 Mar 2026 22:38:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=kEkk2J
	wYZi/5YK/Wlim3bzRAkPTNaKIEG7T3z9Q075w=; b=OUdC+C2pOAvaN6ozeNclK9
	M+AdPUkT03XabDYUJensPyqZshgaah3a3gnx1CtWpJDFMkPScHLxsB1n+pK3gqnb
	fqm9VC+s1uXNB7qhSN+Bb2uPttDEmz5feDEsRH5E23TLTrDj9vMnD7rdhhZ13fHw
	JL33T8t8ivi4nmsdxnLckp1Utga55Eu+G+gPhQBpVm0G3fTRh0y4Ze45By/M95ay
	Hmj5q5GdHydVjYq4JmvoW2rM9Wetsy4P6W2Uy2VTofzGRw5Mo/T4ObX+Yp5m8l5q
	ca+7VG7vLTdEwA3IPDTyQHilb/stnzxzXSFDXV8/UHTVaYW74Bq2LIplhfNq8stg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1ky057yv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Mar 2026 22:38:38 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62OKj83D011789;
	Tue, 24 Mar 2026 22:38:37 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d27vk3xct-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Mar 2026 22:38:37 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62OMca9I25756352
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Mar 2026 22:38:36 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E097558055;
	Tue, 24 Mar 2026 22:38:35 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 134C358043;
	Tue, 24 Mar 2026 22:38:35 +0000 (GMT)
Received: from [9.61.253.153] (unknown [9.61.253.153])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 24 Mar 2026 22:38:34 +0000 (GMT)
Message-ID: <05251498-1137-4eff-811a-52a5dff3adba@linux.ibm.com>
Date: Tue, 24 Mar 2026 15:38:33 -0700
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 3/9] PCI: Avoid saving config space state if
 inaccessible
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, lukas@wunner.de, alex@shazbot.org,
        kbusch@kernel.org, clg@redhat.com, stable@vger.kernel.org,
        schnelle@linux.ibm.com, mjrosato@linux.ibm.com
References: <20260324214051.GA1156527@bhelgaas>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20260324214051.GA1156527@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDE3MiBTYWx0ZWRfX0tKTyxsxakVL
 +umtQeXypqldr8AiVerjsdM049D6xzZq9g3TU/HAw4KPQp7WKnLx3JyESBgfyXR1+itIWhqQLkN
 V/0MzUvKi0C080SHMeqQSRICA5U4DHWM4/LAQzwk7L4R4yYsjwlLuRb5DpLFoAohw9S+EcP4Ms0
 ClmjiOxryOYkBS/fpTzHl85uVoZ8oIqhVpePh0KAj5BTTmRueNE/WwLuK19RkMDgXnEnz94k7Qc
 AtOdAvT/nKHC4GTOiA4z4uKouRTZrDQo4PsSkcb9jq+VGW4PyD12Lndmv6H6F3PSG5edwDG24ev
 0UYplzMbdaoF3UeWIrfxmPCZ15OhMlIh+SU0wefCzmmffTWcKcNNWrJHbx1KTdt0wRtX8KgK/iD
 85ufIZiYy+jQmRrj300wSt9cDllmMMQpXcqI2e8BY6rwfws8h64Ma2Qkg1YFG2EG99hNh7hrzRo
 54MRqP3ymt3UbtcC8bQ==
X-Authority-Analysis: v=2.4 cv=JK42csKb c=1 sm=1 tr=0 ts=69c3126e cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=1XWaLZrsAAAA:8 a=k7L6yOQrr6rJGXFB698A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: U37pcnkoxjLCWt27eNvY6jvCR6D6YvgT
X-Proofpoint-GUID: U37pcnkoxjLCWt27eNvY6jvCR6D6YvgT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_03,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 malwarescore=0 adultscore=0
 spamscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603240172


On 3/24/2026 2:40 PM, Bjorn Helgaas wrote:
> On Mon, Mar 16, 2026 at 12:15:38PM -0700, Farhan Ali wrote:
>> The current reset process saves the device's config space state before
>> reset and restores it afterward. However errors may occur unexpectedly and
>> it may then be impossible to save config space because the device may be
>> inaccessible (e.g. DPC) or config space may be corrupted. This results in
>> saving corrupted values that get written back to the device during state
>> restoration.
> This patch only addresses the "inaccessible" part, so I'd drop the
> "config space may be corrupted" because we aren't checking for that.

Sure, I will update the commit message.


>> With a reset we want to recover/restore the device into a functional state.
>> So avoid saving the state of the config space when the device config space
>> is inaccessible.
>>
>> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
>> Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
> Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>

Thanks for reviewing!


>> ---
>>   drivers/pci/pci.c | 14 ++++++++++++++
>>   1 file changed, 14 insertions(+)
>>
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index a93084053537..373421f4b9d8 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -5014,6 +5014,7 @@ static void pci_dev_save_and_disable(struct pci_dev *dev)
>>   {
>>   	const struct pci_error_handlers *err_handler =
>>   			dev->driver ? dev->driver->err_handler : NULL;
>> +	u32 val;
>>   
>>   	/*
>>   	 * dev->driver->err_handler->reset_prepare() is protected against
>> @@ -5033,6 +5034,19 @@ static void pci_dev_save_and_disable(struct pci_dev *dev)
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
> Obviously this is still racy because the device may become
> inaccessible partway through saving the state, and it might be worth
> acknowledging that in the comment.  But I think this is an improvement
> over what we do now.

Yeah, makes sense. Will update the comment. How about something like:

If device's config space is inaccessible it can return ~0 for
any reads. Since VFs can also return ~0 for Device and Vendor ID
check Command and Status registers. This can still be racy as a device
can become inaccessible partway through saving the state, even after this
check.



>
> Sashiko complains about this, but I think it's mainly because of that
> last sentence of the comment that says "error bits set in Status
> register".  This patch has to do with *saving*, not restoring, so I'd
> just drop that last sentence.  FWIW, Sashiko said:
>
>    The comment indicates that we should avoid restoring config space
>    for a device with error bits set in the Status register, but the
>    code only uses PCI_POSSIBLE_ERROR(val).
>
>    Since PCI_POSSIBLE_ERROR() only evaluates whether the entire 32-bit
>    value is exactly 0xFFFFFFFF (indicating complete device
>    inaccessibility), does this actually check for individual error
>    flags in the Status register?
>
>    If a device logs an error but is still accessible, val will reflect
>    those bits but will not equal 0xFFFFFFFF, causing the check to
>    evaluate to false. Should this code also check specific bits in the
>    upper 16 bits of val (such as PCI_STATUS_SIG_SYSTEM_ERROR or
>    PCI_STATUS_DETECTED_PARITY) to match the stated intention in the
>    comment?

Yup will drop the last line.

Thanks

Farhan


>
>> +		pci_warn(dev, "Device config space inaccessible\n");
>> +		return;
>> +	}
>> +
>>   	pci_save_state(dev);
>>   	/*
>>   	 * Disable the device by clearing the Command register, except for
>> -- 
>> 2.43.0
>>
