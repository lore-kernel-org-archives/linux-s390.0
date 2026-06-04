Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38400248166;
	Thu,  4 Jun 2026 00:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780531297; cv=none; b=ryBlrIMbK8ziFrvEw0Enj9XOImuozhV6QGCl8Scw1qbFH/ey9AO7p+drD/zweNWNr9kmK2ntMZDigkTMVhjWD+FwtFbLBskH/x0qezrq+vcI/NBAwihVYJxuB6dfJ2AngE36CHBQLKkSSSe2TYg6D44sYOdqpy2pGhp7RP22e94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780531297; c=relaxed/simple;
	bh=mr0EfZ5ya38W9T9J748u3+CM5Rlrf7nAznQZC40JfW4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UAtklijJPbosiDzmowpFzn2+UnSpjA8nbMLXumdJuwepKTSxVnEzpJzOSBThrQGxHs8yK20KBp/RFVL4zcCsYn1RiQMw8hAazNabm1zjPUBzIhN48N9npagEpQuo3sb0FWlhEfPw4O2egLnXFx8UsrVLrt5JFsa8ngeki6z5Rvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=avhKVAzX; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="avhKVAzX"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 654015Fs1041639;
	Thu, 4 Jun 2026 00:01:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=+tQYYS
	Ce62KLL425XZDE8MsZHV+c2vvsQ7T0hEtb/z8=; b=avhKVAzXXvq19suG2Pv2B0
	7C3X93LiNa6moeFX8bBSiv+PUvAsrLycs4OO1GRHwS1/ZDbquf0scTrv1KSPWL/L
	F4220RDb+wIooxc8H0OU8YxclQc7KHekmFa+4jfqysMNk2+Eskn/mIoAQR88POy1
	KHPoKncfoww7IDRxrqe90ebZPA59voSDxSV1EGKXCgSWEVewB0h6gkOHB2JTBU8J
	DLo4A2OOo7dDVj5YHv8iGtEUVkMzHvBcCOqEWgDWfxJGjbLzKk08bdtlTx3EAMxZ
	n/6NQBrALk6cFHsim5BJ54GcxPoT07wg105YoNydeiefmG9qje1W8Jyi/UiSaFTg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqm55dw4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jun 2026 00:01:31 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 653Nd6h4030130;
	Thu, 4 Jun 2026 00:01:31 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ega7qjvfc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jun 2026 00:01:30 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65401TnV14877338
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 4 Jun 2026 00:01:30 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CCA5458043;
	Thu,  4 Jun 2026 00:01:29 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ECA7658061;
	Thu,  4 Jun 2026 00:01:28 +0000 (GMT)
Received: from [9.61.253.104] (unknown [9.61.253.104])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  4 Jun 2026 00:01:28 +0000 (GMT)
Message-ID: <9fa7db8b-704d-46af-a68d-bc61e85ad4b4@linux.ibm.com>
Date: Wed, 3 Jun 2026 17:01:26 -0700
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 3/4] vfio/pci: Add a reset_done callback for vfio-pci
 driver
To: Alex Williamson <alex@shazbot.org>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, helgaas@kernel.org, schnelle@linux.ibm.com,
        mjrosato@linux.ibm.com, Julian Ruess <julianr@linux.ibm.com>
References: <20260603182415.2324-1-alifm@linux.ibm.com>
 <20260603182415.2324-4-alifm@linux.ibm.com>
 <20260603164655.1f533ea5@shazbot.org>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20260603164655.1f533ea5@shazbot.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: fA1tbd5r-_Ud4PoWgfqXBxdqXhG7FwlI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDIzMCBTYWx0ZWRfX2OskymPVqjej
 1oN2iSpCKpa06c3jDfkMlUd4VZ8lgVaJFyQgSRH5p+dZAbkKBLBu+leZ6wg/2zElcS78aPPcfAX
 oXneN5ho4nzYFeG08ooEzn02XhiTftzJePDV91N3eAM7CwLlv0an2oLG2Uksa8Cx5UpfAcPdXSB
 80yLqAuyihaYhHGDzczHKMMmEJ8NutJ/eQ0ksNpwnI8h5c6ISQ8F0To6WJpvlkYOWvZge2//tac
 YjKfGA0+g12YgGgcIIkWsZP7Pnr1zaw/2GEZEXq8/jQtV99nud1UOZFXBp42MzqFH0K0s+4LVdk
 2BkPgtkNNi8wmFN0nGSiziGNoXe+vJFaaJzVmH376WATMUXn0R6GzQX+jnXEb0yveTwjNa6YXGf
 S4kFZllINTBYb/dWEqrI7Cc2EWPLNpQ3EzzqK9xPlzoWFRy+KLsn1ryTeSJD2PSZqW2wJjvVAQ6
 Bd+nfQckQJmeG4KzHGQ==
X-Proofpoint-ORIG-GUID: fA1tbd5r-_Ud4PoWgfqXBxdqXhG7FwlI
X-Authority-Analysis: v=2.4 cv=Vf3H+lp9 c=1 sm=1 tr=0 ts=6a20c05b cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=c92rfblmAAAA:8
 a=VnNF1IyMAAAA:8 a=r1p2_3pzAAAA:8 a=vLjCJnOPf0W5e20aWLAA:9 a=QEXdDO2ut3YA:10
 a=GvGzcOZaWPEFPQC_NcjD:22 a=r_pkcD-q9-ctt7trBg_g:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030230


On 6/3/2026 3:46 PM, Alex Williamson wrote:
> On Wed,  3 Jun 2026 11:24:14 -0700
> Farhan Ali <alifm@linux.ibm.com> wrote:
>
>> On error recovery for a PCI device bound to vfio-pci driver, we want to
>> recover the state of the device to its last known saved state. The callback
>> restores the state of the device to its initial saved state.
>>
>> Reviewed-by: Julian Ruess <julianr@linux.ibm.com>
>> Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
>> Acked-by: Alex Williamson <alex@shazbot.org>
>> Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
>> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
>> ---
>>   drivers/vfio/pci/vfio_pci_core.c | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
> Sashiko has some interesting comments:
>
> https://sashiko.dev/#/patchset/20260603182415.2324-4-alifm@linux.ibm.com
>
> I think the critical is a calculated risk we're taking, restoring the
> hand-off state after reset.  I don't think we'd considered the race,
> and it seems the commit log could use some improvement, especially if
> we do need to revisit this based on the calculated risk.  Thanks,
>
> Alex

Regarding the race mentioned by sashiko, pci_load_saved_state() also has 
a check to make sure the state passed is not NULL. However the race 
mentioned by sashiko seems plausible. The reset_done() callback is 
called with pci device lock held, but it might not be enough to protect 
against the race and so we need to grab the dev_set->lock here? For the 
commit message how about adding something like this? "This will 
intentionally reset all the runtime PCI configuration changes such as 
BAR programming and MSI-X enablement"

Thanks

Farhan

