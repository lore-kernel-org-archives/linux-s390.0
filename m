Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3252B3859EC;
	Thu, 17 Sep 2026 02:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789611677; cv=none; b=OhypOgcMujZyD2KVJHq+ESR1O+tLH4KJDr5zifL2v6YczDJhphdG31v3DfrxTBNuQKKRYns93UqFQNzG2hxBMd2Uju7uom/ZAlGhrZ/SvdCz0OLUsgoCsLElU7QlsGk2V5CT/iGwJtFjLUCqrQAxtlYy+sZW3euM3gfHc2FUO/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789611677; c=relaxed/simple;
	bh=OoQdXIEsYDF3Hy5LAL+pIw8eouZOYLwjAWOLmsEJTZs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nd0HtzQGgq8lnZ8BZey6tu3In450VjJpRaO3t4QQOmzpdGEIoPQoUf4EBQ1cnhqlhWAU1ZiyLMNviENgIzaw6atnUVxVpImuUWdY5v+2u/SrF+rIJRhh5ypYO5ez2BSdSlejSeyts6ZkEi0UYBUVYo7dhg2VbQfu7f5pDJRzwA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DS7czaAy; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DS7czaAy"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68GG1k0H2330475;
	Thu, 17 Sep 2026 02:21:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=fbZPM4
	LAZIYtY6fMU6qJYhbXyLIhIk6Wxra0TgYPQx8=; b=DS7czaAye1sUnUqbIoq+bw
	chSdW9lnFXUZ48EF5fkkmaYyX6XjUbMy1asOkc0BYWFpI5aTHOwfrvBBKiPDgeyV
	uqTaN8E/eEIMs9jwPG5SiK1whPWVwzh1KDUsjrcUUaUNiLP8g+d1/faVHPm9nZE3
	hNcGqHWPZOPaMY5eJtA71uXI8LH4/47k2B+uKrqEJNRnp8Xqfd2DhOLtXSWrNCBZ
	KrLrMw5RRbza7ekq6PtHLyhUObyScKZQksyd2sCtZXp+g5Us1hOFFjeV72iZo5NP
	ZSeOQnHDzVMnHa3+ZBQt0U5w6TCxJqRM6TFROWwRgfvySEol9mvMHe52SU4D3+OQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxdqfxt1-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 17 Sep 2026 02:21:13 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68GN12Tt1713037;
	Thu, 17 Sep 2026 02:21:12 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gpywf1fca-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Sep 2026 02:21:12 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68H2LBg39241260
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Sep 2026 02:21:11 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 45CB25805E;
	Thu, 17 Sep 2026 02:21:11 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B83FA58045;
	Thu, 17 Sep 2026 02:21:09 +0000 (GMT)
Received: from [9.61.177.109] (unknown [9.61.177.109])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 17 Sep 2026 02:21:09 +0000 (GMT)
Message-ID: <cdd076c4-acff-4390-a87d-6fa03119e913@linux.ibm.com>
Date: Wed, 16 Sep 2026 22:21:09 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/4] s390/pci: Hold fmb_lock when enabling or disabling
 PCI devices
To: Omar Elghoul <oelghoul@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com, schnelle@linux.ibm.com,
        alifm@linux.ibm.com, farman@linux.ibm.com, gbayer@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, stable@vger.kernel.org
References: <20260916213222.233-1-oelghoul@linux.ibm.com>
 <20260916213222.233-2-oelghoul@linux.ibm.com>
From: Matthew Rosato <mjrosato@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20260916213222.233-2-oelghoul@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDAyNSBTYWx0ZWRfX0IV85SdoJPPq
 rPWP6l+IFNDmbFYLUgLjATsmY6yINcp225UjNg98Z2+EJh96zHCsCMDvxvLKBLZtysovM++Kvee
 A++xbsYHH1M753T9w8cNwVZ36xNhvo4/zLElA990zJNPYzwEdQ/vZggLEQ1/iV1d4cJVuPRE4cJ
 m3sq6jTchBF8OQvuj/BseHvDP4zWTjr9ddiYKcyqaIQBUakV0AbkI+htzc2lVzAJl4ilGhfALVp
 l3S3rT0X/YllyuQNFDbOin58r8r5RxrVXaozk63LDhKESvR9I7dp8VwmW0u265IXEBHoq/PXT0t
 IcdyXRpIgM78jiAruT2imVB3hI+U+XDR7BYlOWnIC2utMuFeaa5sDQOK22EiYkk9ZBlsplcR3z4
 SH/w6vVtVSLPYPjjeWvF9F3OT8JQcU66uaQ0Tgm6Nhjm2ZMAvAgH3TetqXUcPA/8ncbAF2qWvP7
 OQUxZx4lVOU/P/rwG0A==
X-Proofpoint-GUID: SWWwAcT1AcLP_pPeD5kxTLxrtQVXk-Dz
X-Authority-Analysis: v=2.4 cv=DobDa2/+ c=1 sm=1 tr=0 ts=6aab4e99 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=2-Wvok__LvRz137P2vUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: SWWwAcT1AcLP_pPeD5kxTLxrtQVXk-Dz
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDAyNSBTYWx0ZWRfX0LMpwNqa+F45
 DQmexL7gLryQeAjimi3nyRQcyg5GuMbGe7hP4TPr+PfGcaWhqHmv/9PE0yu2hawJSUd9vlLxJhw
 sE+EJ2YcblkNT+8ow/AMR1MdcwRwNoE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-16_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 spamscore=0 clxscore=1015 adultscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609170025

On 9/16/26 5:32 PM, Omar Elghoul wrote:
> Ensure that fmb_lock is held by pcibios_enable_device() and
> pcibios_disable_device() when calling zpci_fmb_enable_device() or
> zpci_fmb_disable_device(), respectively. Additionally, assert that the
> fmb_lock is held within the latter two functions to prevent future race
> conditions regarding new callers.
> 
> Fixes: af0a8a8453f7 ("s390/pci: implement pcibios_add_device")
> Fixes: 944239c59e93 ("s390/pci: implement pcibios_release_device")
> Cc: stable@vger.kernel.org
> Signed-off-by: Omar Elghoul <oelghoul@linux.ibm.com>
> Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>


