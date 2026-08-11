Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B8A2DC798;
	Tue, 11 Aug 2026 19:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786476277; cv=none; b=a4351UnRRz/wklNhWYS5IhHME0cwDSPDiD1vWa59ipHXUftoRcUH1IqCP2yXQhr5LkeurP7fvE6yGkhhxMsHdeQzcufmNsrtRIF0ZPndU1T7HrD3GayBQrxnmGKKJXInAVxChMCtRrAWrlE6e4VXoi/KoL0r96nEef6USUFDTfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786476277; c=relaxed/simple;
	bh=ArY8TTp7yojktZ5BLY1aU/R1u83NYZ0agZEGrMsDCJA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GzMJfVt1c5uoGiGlqXJjEVh9WdWLeSvdP0dwHs+/QF+6y8ED5CG28igP5lm968znvi3AT5n5HLYBdA5s3NABt+U8WhLUSXxYt4vOnTOBcKVgh6jdF2OQJ9+daWuPYMz4yncmIT/JCNlfJ3TJS+xCMQuiYvYTds2uvjBgUESzHaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=F1feGzIE; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="F1feGzIE"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67BGVa7i846598;
	Tue, 11 Aug 2026 19:24:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ArY8TT
	p7yojktZ5BLY1aU/R1u83NYZ0agZEGrMsDCJA=; b=F1feGzIEMqjRXEL1KmpRIf
	bOJYlg9qlN+U5e7DE+k94XduLSXw4EkW0CIaaTXcrtW93AUtblKqdchTzVFe690T
	IXkX0OgVkCDI0Y5CclnukiHvBhkSThKdvyS45BHP3ni2g1hys6n+xodgNPGj8VKD
	N+KIVYw/3QLlnr7c+rNeppp7YFTtL1T7WYxOr5HaPEFDJNpTGY6B/vpbsFYA5p9g
	k+G8gsG5IDQ7roRaK7l4g+pXucrvXqoU+KOPhI0TT2w8hXngoU/EfHwHpQM7ATui
	qqscroplhiQRvt+raonFgQJ9RC0Jmb4DKjXt+V2xW0VzggwSK/Pm6oxjledJ7GLg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvp2x255-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 19:24:30 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67BJBNVN004243;
	Tue, 11 Aug 2026 19:24:29 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxg9h2dpt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 19:24:29 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67BJOSAG33948228
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Aug 2026 19:24:28 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 86B555805D;
	Tue, 11 Aug 2026 19:24:28 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 84CA658052;
	Tue, 11 Aug 2026 19:24:27 +0000 (GMT)
Received: from [9.61.58.252] (unknown [9.61.58.252])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 11 Aug 2026 19:24:27 +0000 (GMT)
Message-ID: <c1ce587e-a87a-4761-9209-c1182a6d8ffd@linux.ibm.com>
Date: Tue, 11 Aug 2026 15:24:27 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/8] s390/vfio-ap: fix potential use of uninitialized
 apm_filtered bitmap
To: Matthew Rosato <mjrosato@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, pasic@linux.ibm.com,
        alex@shazbot.org, kwankhede@nvidia.com, fiuczy@linux.ibm.com,
        pbonzini@redhat.com, frankja@linux.ibm.com, imbrenda@linux.ibm.com,
        agordeev@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        stable@vger.kernel.org
References: <20260810192257.1208410-1-akrowiak@linux.ibm.com>
 <20260810192257.1208410-7-akrowiak@linux.ibm.com>
 <2b37bd31-9626-4f05-9ffe-61193c045078@linux.ibm.com>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <2b37bd31-9626-4f05-9ffe-61193c045078@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=AMtp2X5w c=1 sm=1 tr=0 ts=6a7b76ee cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=sVmuoAO__9_hq4lJWLEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: pPR5bqXP0A8ElFDFVWXhnazYuDXSVQFQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDE2MCBTYWx0ZWRfX84i25u57KuGO
 FqXen2f72wIFA5Y5CRZeNHnzFwRDIdljvqrttbsz4U33yBC4UtG/N+GeS8nTKQ1xMNcMXYgJyse
 HkSgvm3bbghiP0zssSqIbXlikft+PEqMtXHO48zKdy0tCBoj5D3WsONq91gT5LQuIXlppy/jAvW
 XuOEq/xYbABJITZD72xnxMNGNycA+FupYqyhyfPn2xIdR2oGXBvDPgCHq43pgfanNudfyacm5hk
 fNN8F9X2lZ04lGJcnmJFeMkPQoU4mmHt5h4Mtex2MAXRcUBj76kzSFoTgbPF6V72zNcCVaZdY3V
 USmf9aOsaDCclxONa0UoL68OUtuL87CAVqunNLZ0tOtAmtDlbCiq1Bb5GRarDrzdv+ydUiZwvMM
 zLyQIc4k9Quuj6atTrYceOtKVamXIqLGWwb2C4ePGEOILtnJ9R6zOk8Pg9aG8Tq5Fs6u0dfClPJ
 WIUWHo4l7+Q8O8oaqlA==
X-Proofpoint-ORIG-GUID: pPR5bqXP0A8ElFDFVWXhnazYuDXSVQFQ
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDE2MCBTYWx0ZWRfXyl/JZJZGca32
 yPCVGViCkHoUm7Stl2DyZy1G6FVJI7Z6/rZoTK9tkTtusKK4dKz8H+TyEmHE9M6G9lwgyPsJMW7
 GmFOwjy0rVFYDAvKz+QE3kELtYqxgq8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_04,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608110160



On 8/11/26 2:02 PM, Matthew Rosato wrote:
> On 8/10/26 3:22 PM, Anthony Krowiak wrote:
>> The DECLARE_BITMAP(apm_filtered, AP_DEVICES) macro allocates the bitmap
>> on the stack without zero-initializing it.
>>
>> In vfio_ap_mdev_hot_plug_cfg(), the vfio_ap_mdev_filter_matrix() function
>> is only called to initialize and populate apm_filtered if either
>> filter_adapters or filter_domains is true. If the hot plug configuration
>> change only adds control domains (meaning filter_cdoms is true, but
>> filter_adapters and filter_domains are both false),
>> vfio_ap_mdev_filter_matrix() is bypassed.
>>
>> Consequently, apm_filtered is passed to reset_queues_for_apids() with
>> uninitialized stack garbage. This can cause reset_queues_for_apids() to
>> interpret arbitrary stack garbage bits as valid APIDs to reset, potentially
>> performing unintended guest hardware queue resets.
>>
>> Fix this by zero-initializing the apm_filtered bitmap at the beginning of
>> vfio_ap_mdev_hot_plug_cfg() using bitmap_zero().
>>
>> Fixes: eeb386aeb5b7c ("s390/vfio-ap: handle config changed and scan complete notification")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
> Sashiko mentions an unrelated, pre-existing issue with cfg_chg_trigger
> that does not appear to be resolved by this series; please have a look.

I vaguely recall that, but my head is spinning dealing with the plethora of
hades review comments addressing pre-existing issues and it got lost in
the melee. I'll hunt for it.

>
> You do not necessarily need to add another fix to this series, it could
> be a follow-on.
>
> As for this patch:
>
> Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
>
>

