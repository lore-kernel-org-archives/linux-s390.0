Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7B5383334
	for <linux-s390@vger.kernel.org>; Mon, 20 Jul 2026 15:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784561593; cv=none; b=T5mtrjIwDxN3r4WKCObeIvNznJ12LjMw93nR1m1y6PDtksDvBrHDOO6rav+/FFe65YKCi0NYB75rAeVB+oeKwZI0yJMfbJTZvWgJn/+ZEVRE1d5x4YCwfoOP66s1a27nn8AtkOQT2CIO1bR6cZM6Ugw/3c0XY908qZBsBYrOTdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784561593; c=relaxed/simple;
	bh=Y8pRSNHXpk5nAHr2J6+aiRnieb7bqeK/ymraygTOaj0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fDqIhAuMj1MydUN1+6RyP9CgwToKbHqPpu30viV4G3ROc1SYA5VkdpA+ekQ+QrFfyXRbbHE9VlDEDq32IzzKjcZf2L90CKD9HIBZXsfWdrPWskh5OZGnQRLLaKr47H5kRDm17A82pXwgtzF5Ur5bC4Kjtcj84ykEUIVsvObuv9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jLJ4hSXL; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jLJ4hSXL"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66KECGLG2325012;
	Mon, 20 Jul 2026 15:33:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Sw2xFY
	2RN2NoYlHfxcfz1nyunry7a9IhXXBFNwtOwR8=; b=jLJ4hSXL3wFbyzVA5WUpLR
	8IPeMWSOiF3+kt7zGjbkhyeyE23pve2y5sBux6SOePMQRSPRPcCZxesUam8kH0Uw
	mSNExHYmm9u0pMd3utRqQQBm5zjd7pBKMaqZZ9Q9zkPl4HDBQEYNLJWPLUbLR8ko
	NiqY7wf9CmUaNivoOoMSIu4nVSqT74nmCO9v2AXaPZyFQY5DJjnsz+oybkEMQ6zf
	3s+1Da8fgMCIgKGsOPtn+p+y9AgfFMhKZrn7U5F3qe8+CAzodbatg3L3+j3DPNdU
	GQK0qafjnlJEaQI6qBhwc3iexXFHBqtO3Qq2FNUgiF07kyqR3NELBYaxRbqHurDQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg78fyxas-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 15:33:05 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66KFJgeq001113;
	Mon, 20 Jul 2026 15:33:05 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgmtjp739-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 15:33:05 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66KFX1vL11469072
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Jul 2026 15:33:01 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 242DA20040;
	Mon, 20 Jul 2026 15:33:01 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DE6432004B;
	Mon, 20 Jul 2026 15:33:00 +0000 (GMT)
Received: from [9.111.141.238] (unknown [9.111.141.238])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 20 Jul 2026 15:33:00 +0000 (GMT)
Message-ID: <1220cd72-c2cc-4ad9-8673-809bb37f9072@linux.ibm.com>
Date: Mon, 20 Jul 2026 17:33:00 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/iucv: take a reference on the socket found in
 afiucv_hs_rcv()
To: Bryam Vargas <hexlabsecurity@proton.me>
Cc: sashiko-reviews@lists.linux.dev, Hidayath Khan <hidayath@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        linux-s390@vger.kernel.org
References: <20260705-b4-disp-fc79c0dc-v1-1-d2cdcb57afa9@proton.me>
 <20260707032441.B1FB31F00A3A@smtp.kernel.org>
 <b524ae17-9fe5-4270-bb8d-3e411ef683e5@linux.ibm.com>
 <20260711041119.12764-1-hexlabsecurity@proton.me>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <20260711041119.12764-1-hexlabsecurity@proton.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDE2OSBTYWx0ZWRfX9l1WWLN5qepf
 G4FEI/sXLWhQF0p26bgIKteW/HYI5kDsxh66Wg/OWepb2gMd3nyIacN4oyki0BIRrZgxaNn33iE
 664vn7GlOEGw/4lFXB40trW6FOFCJ7l3sx6cBc+JkM9k2ONvjDl+fohWiaLMJhHJn7OLHzNRyhj
 L8wLtnaBjCleQF7pzvJaSxjIgO1m+Ms3s4DZLNOXAHfmV06zvwYsos1e5tb+8M1dZvnT6Atvmzc
 6Hw6KIw0HyH7rCreFAk8iPdYOLrFBPCq5gXrEVKizeqI1zQUThmx5Zf8ATsW6gUW4FF3AFSFgyQ
 26gGQXOuAdeJOvrrRYgVM0lxZOjnTNwMMRdr11qwx0kLCKTTBhM3kyQWkT+pdqErEbvYZoS9Gr9
 2Tve+MYXaferC9zG9IaWV3ar1bi8wpwn3qV4jeOuJO7ExA0yEN7lEIparyOLjvRmNjOGJ5AghIU
 EYwEieK+pv7HHbKwmxg==
X-Proofpoint-GUID: WpblYh98GkdypqBvVoMJX_C90C07VDrv
X-Authority-Analysis: v=2.4 cv=MelcfZ/f c=1 sm=1 tr=0 ts=6a5e3fb1 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=mpG3tCo3JFPGy_rZ:21 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22
 a=VwQbUJbxAAAA:8 a=kuH73zJZA9zSU-iPmnQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDE2OSBTYWx0ZWRfX7/AEDgmjqvyy
 JR6Lwruwv+HQo3fTL4f/Jo0YhOuyCmtYqS279JLmgSOESmitu/jmPMZdvl+32KbHkbzNuAZHueK
 RlaQnxn+liwoIPMvtSqKlu8GBaJZJbo=
X-Proofpoint-ORIG-GUID: WpblYh98GkdypqBvVoMJX_C90C07VDrv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_03,2026-07-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 clxscore=1015 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200169



On 11.07.26 06:11, Bryam Vargas wrote:
> Alexandra,
> 
> Agreed -- and thanks for the pointer to f558120cd709. The reference pin
> closes the lookup-without-hold free in afiucv_hs_rcv(), but sashiko is
> right that it doesn't touch the larger gap: the receive path changes
> sk_state from softirq without honoring sock_owned_by_user(), so it still
> races a process-context lock_sock(). Same class as the close-path UAF you
> fixed.
> 
> I'll take a first pass. Plan is an RFC that routes the softirq state
> changes through the standard sock_owned_by_user()/backlog path instead of
> mutating the socket under bh_lock_sock() alone, so a held socket defers
> rather than races. af_iucv is s390-only and I don't have HiperSockets
> hardware -- I verify against a KASAN model of the receive path -- so I'd
> rely on you or Hidayath to validate each revision on real HW before it
> lands.
> 
> I'm already in this code from a separate severed-path UAF fix [1]. If
> you'd rather keep the rework in-house on the s390 side, say so and I'll
> send my analysis and the model instead.
> 
> [1] https://lore.kernel.org/all/20260707-b4-disp-783fedbb-v1-1-463b9dbda2ea@proton.me/
> 
> Thanks,
> Bryam
> 


Hello Bryam,
your help is highly appreciated, please send the RFC and we will continue to work on this together.

Please make sure you send all discussion about iucv or af_iucv to netdev@vger.kernel.org as well.
