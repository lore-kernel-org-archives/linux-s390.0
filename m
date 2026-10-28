Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793204139;
	b=OV5KKnmfKeR2uwj6JcVPHq4LxUdVHr3AV1qNc8Nb1vJjb+e1LVobBRN9d6rN2FbEG66d
	 bbEnCzV+dHaJ9On6dFeI7ojr1ldlvVHGUwv7xzVyUD1zNcvmevJt5lXZi79G0UYBP/WCH
	 e2Bna3eurH26X76kABIOVg8dyxSr39Re8s6+tocgJy85udBs5bA9+UgvtwcamQid9n1d3
	 aDYquJN3/JO6lwylKZqtLtexm8CcOPIjB2pFoBa/A1Iz6k1zAPuv7BzMIAbEMZf0IlZ4l
	 zzkkaBa3IU5fsqkc7g/hfKCDnMuCsCtoYqYaNqtx59MD5NnU4I20O+0AV6/N4+Ak7rw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793204139;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=ewnhFfstuGy9qRdTR4g440cXF0QypObd3RSkD14B514=;
	b=1kydI6O2Bpvg0edEr+v+CR6JRIckP5fPnLc84j6LNaKvevU5rCxr4XQ5WEczJZgaOgyd
	 TCxMJYDvCvS+KUZMb6CxsFcY9XKqtFMhZxFLcy1Wi8G13UG4dMEouNkqQ9QyKaNzxbcpM
	 2jvWiMnax6swDcqtum5FKlzQCDxcqQo5uRMXfUWxbsyNGXJ4eUOmoHZQFWMuoM8BPw3XN
	 GvpQnynqwHQDyyiK19CPqP5G4QY4NgmBxXMmNOykDh4X+DOX1rB4NMd1EGfZorbhIUuTQ
	 eqE/iCqyj/0vdcPhMKqJtfIsrYZN3YTska0slymS60YjTqUYtiMlyasAXBgXh/J2HaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Rwb+OVLW;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D389606A31E;
	Wed, 28 Oct 2026 16:15:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D389606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Rwb+OVLW
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69SFEcOT1521293;
	Wed, 28 Oct 2026 16:15:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ewnhFf
	stuGy9qRdTR4g440cXF0QypObd3RSkD14B514=; b=Rwb+OVLWkzoH3IKQL4kAxm
	ZCFbMg3YENDGe7bfjYcw81HkruIJx20ICoqIMcCVozagocygFk3jC5b1nx7+SJ8+
	ZVTsy7dSPjKjTsCuJY06N6KW0lHrokH8G3tLidMMo9S98blnKiwxww51xGeOHmm5
	hG0cnNI/tPe0p8z7KGRRBVD4TtUYpnBuMgUr5poumpj4Dm8bwmV+HkAVDF3qZSmQ
	0I8S8NqzjRGbkmsjK2xgnLLGkU74PaPfxfrG4xCNk4upMe4GV3DOVu8SI0mGVn4W
	8geHOHaex2f77LOPjJBd/httM/DHHUbuv8Y0dDg+cLMksEoy8opNYyB2OsOx1QSQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgj3mdunj-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 28 Oct 2026 16:15:37 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69SFYr121760108;
	Wed, 28 Oct 2026 16:15:37 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hk55pb1r0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Oct 2026 16:15:36 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69SGElhF28967542
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Oct 2026 16:14:47 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AA35E58050;
	Wed, 28 Oct 2026 16:15:35 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7214758045;
	Wed, 28 Oct 2026 16:15:34 +0000 (GMT)
Received: from [9.61.240.205] (unknown [9.61.240.205])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 28 Oct 2026 16:15:34 +0000 (GMT)
Message-ID: <72ddf1a4-d672-4d9f-a205-07aec3db1248@linux.ibm.com>
Date: Wed, 28 Oct 2026 12:15:33 -0400
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 3/5] s390/pci: Reuse FMB buffer across enable and
 disable cycles
To: sashiko-reviews@lists.linux.dev, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Farhan Ali <alifm@linux.ibm.com>, Gerd Bayer <gbayer@linux.ibm.com>
References: <20261028154352.15108-1-oelghoul@linux.ibm.com>
 <20261028154352.15108-4-oelghoul@linux.ibm.com>
 <sashiko-outbox-188110@kernel.org>
Content-Language: en-US
From: Omar Elghoul <oelghoul@linux.ibm.com>
In-Reply-To: <sashiko-outbox-188110@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA2NCBTYWx0ZWRfXyWv3ZthLv4mS
 JizHyaLGu2J2pd/bHH+m4/qrBCIsCCdQYN9JDxLhoMxLeovC1bTE6H4p7eSp7W4vUayR/l1HdWl
 hvB9b0iaAxmeA76Y6wILzx3aaeYg7uk=
X-Proofpoint-ORIG-GUID: EmEIeqbdczjXx51ljM4QNLv13nwDmivY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA2NCBTYWx0ZWRfX/ODrl+yZ3yZR
 Lb/RwPhdLxFH8ENNr+HbAZmszMJXCll10ybdQK6CvTijUMZ4alWflinRYx12EoPwJW5TtC3MfSq
 89/dnHcxnUALNHJw1SIZwM/9b/lb862NWzIuNjI8GoMCcUM3m+eXVtziCwkw7MjblfPMIWK/K+Z
 EMU32SDuM9SGIYa+hHNZTdRP9U0ml+4yN0/e5NxN2Vv/9heQ5X7V3ENkjgOUEhopgpL2wOoCelh
 rEh3k9gms86U+e33E790DGLoWRVeDT6SpA+l+Zkwlm2FnJcxEBkfHx6Mjh5OsJfH48BxDbrhN8p
 Nl7uXZaAuwf44UGYMvUvpYoi9VdHXr9GighlMyLpMIxUkjV57nhl9AioT1ZM9811L+ZWwWdQI6s
 /PcEWC8EBXbPL9l753z99npHsthoN5eBfmPmmfgfYfCVYuDD4z7xY2BquE7/ebrMAmA7KjylxL1
 JUVBkYAmO97vnCKUkmA==
X-Authority-Analysis: v=2.4 cv=G7uJgNk5 c=1 sm=1 tr=0 ts=6ae21fa9 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=-OvP2GiDACUX-iG78AQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: EmEIeqbdczjXx51ljM4QNLv13nwDmivY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 phishscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610280064

On 10/28/26 11:59 AM, sashiko-bot@kernel.org wrote:
[...]
> 
> [Severity: Medium]
> Can keeping zdev->fmb non-NULL when zpci_mod_fc() fails in zpci_fmb_enable()
> leave the FMB enablement state inconsistent?

Valid concern, but unfortunately I think this is a tradeoff we are going
to have to accept. Based on this discussion [1] under a previous version
of the series, we can accept these stale reads because as Niklas said,
the firmware-written sample includes a timestamp of the last write. So
we're already transparent about giving the user stale data, and in the
unlikely event that this happens, the user will be able to recover by
disabling and re-enabling statistics via debugfs or simply re-enabling
it directly via vfio.

Thanks

[1] 
https://lore.kernel.org/all/a24337bd66864dd70ae61e28d86590052ac0fc5d.camel@linux.ibm.com/

> 
> zdev->statistics_on is initialized to true in zpci_create_device(). When
> pcibios_enable_device() or zpci_reenable_device() calls zpci_fmb_enable(),
> the return value is ignored and zdev->statistics_on remains true:
> 
> arch/s390/pci/pci.c:pcibios_enable_device() {
> 	...
> 	mutex_lock(&zdev->fmb_lock);
> 	if (zdev->statistics_on)
> 		zpci_fmb_enable(zdev);
> 	mutex_unlock(&zdev->fmb_lock);
> 	...
> }
> 
> arch/s390/pci/pci.c:zpci_reenable_device() {
> 	...
> 	guard(mutex)(&zdev->fmb_lock);
> 	if (zdev->statistics_on)
> 		zpci_fmb_enable(zdev);
> 	...
> }
> 
> Previously, zpci_fmb_enable() freed zdev->fmb and reset it to NULL on
> zpci_mod_fc() failure, and zpci_fmb_disable() reset zdev->fmb to NULL on
> disable. With zdev->fmb kept allocated both across disable/re-enable cycles
> and when zpci_mod_fc() fails (or if zpci_reenable_device() returns early on an
> error after a prior allocation), both zdev->statistics_on and zdev->fmb remain
> non-zero even though hardware measurement is not active.
> 
> In arch/s390/pci/pci_debug.c, pci_perf_show() checks whether FMB is disabled
> using both fields:
> 
> arch/s390/pci/pci_debug.c:pci_perf_show() {
> 	...
> 	mutex_lock(&zdev->fmb_lock);
> 	if (!zdev->statistics_on || !zdev->fmb) {
> 		mutex_unlock(&zdev->fmb_lock);
> 		seq_puts(m, "FMB statistics disabled\n");
> 		return 0;
> 	}
> 	...
> }
> 
> Similarly, the later commit "vfio-pci/zdev: Add VFIO FMB device features"
> relies on the same (!zdev->statistics_on || !zdev->fmb) check in
> vfio_pci_zdev_feature_fmb_read(), and zpci_fmb_request_on() rejects subsequent
> enable attempts with -EINVAL when zdev->statistics_on is still true.
> 
> Would this cause pci_perf_show() to report zeroed or stale FMB counters instead
> of "FMB statistics disabled" when enabling FMB fails?
> 

