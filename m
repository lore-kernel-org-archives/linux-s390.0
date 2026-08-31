Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020D2391E76;
	Mon, 31 Aug 2026 20:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788208168; cv=none; b=sGIAQQTFBhDWwUmGLDh+5y1uE3cyFjiAxEZ36nL4/qQToZQite2gFTQ0o1rxe92FD2BAAqdfBiZ1Fuv2SmZGJ8Wv3PwnsuTg92RvBe7hafvDpEamSWaecN9Mz9YX9gp2bj6tpYUk+JKEHCU3+h2Uo7jKltorTO0m90JO3NQkXyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788208168; c=relaxed/simple;
	bh=WFVDwjE9O2uWrPGQOAGacJFSOMNqQC01giKdgn1dtNc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YdVVdCTAoh0uB4ulMgtRTcesHH4VQy34kQsCPq3AS6BpFxKMuEUa/i4bnP3X+5asj7FdSltarovW8Nc38OIn5hdsDhSdYEJ5rfa6pOzRWvEBhwipLC6DV5dR1w7olDjIj2vHLcc0Cdv3S2j9o+GYYQGYMf/tKyhqBO71D/O08mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XseQCoZn; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XseQCoZn"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VIVsFT3116274;
	Mon, 31 Aug 2026 20:29:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=DNEUVo
	nEoLJO8yGoiSjOLIT/OaTS60DPRp33Yoes9HY=; b=XseQCoZnQ97QGRFXAWeo5q
	yNKX7Ekxo5d0gN0KDWuzucfss8lQaXcJCdm+ruYVU989PMsi69r2KKLoTlk+TnPt
	/9gdZJGStyL9lqpmXkRj0EFl8e6F5QhwO2r6N6tZ1sPXHA7vSwagk4SxDwSX5s08
	BPMmzANf9OSnpyiacba4077ZPdfBagsWFuGJeMXGR1+LNK9zCQRbMBdKnS38TsO5
	G5KVI6feMchXd9SnAzTm/RcB6mu6Kn6FO3mvYLzltIRza0oCfqcxVTPnhCkYzR37
	f0vYN1M+u/ipXsZN+LvpjJlD5S8UvpCrTLfTTUWOFkU7VH23keXyKWLNwBdewHxg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbpx5bqd8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 20:29:19 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67VKQJmW021841;
	Mon, 31 Aug 2026 20:29:18 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gcbyg7s5c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 20:29:18 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67VKTH1f25887460
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Aug 2026 20:29:17 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1DE5658056;
	Mon, 31 Aug 2026 20:29:17 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 167DF58052;
	Mon, 31 Aug 2026 20:29:16 +0000 (GMT)
Received: from [9.61.36.99] (unknown [9.61.36.99])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 31 Aug 2026 20:29:15 +0000 (GMT)
Message-ID: <e8f89dd1-9c19-49b2-8e8b-879ddd7ca3cb@linux.ibm.com>
Date: Mon, 31 Aug 2026 16:29:15 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/4] s390/vfio-ap: Use AP_DOMAINS for adm_add bitmap
 size in vfio_ap_mdev_cfg_add()
To: Anthony Krowiak <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, pasic@linux.ibm.com,
        alex@shazbot.org, kwankhede@nvidia.com, fiuczy@linux.ibm.com,
        pbonzini@redhat.com, frankja@linux.ibm.com, imbrenda@linux.ibm.com,
        agordeev@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com
References: <20260831171443.222225-1-akrowiak@linux.ibm.com>
 <20260831171443.222225-5-akrowiak@linux.ibm.com>
From: Matthew Rosato <mjrosato@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20260831171443.222225-5-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=PPc/P/qC c=1 sm=1 tr=0 ts=6a95e41f cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=wJl0czCw-TtCaqEsIisA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: GBFTDa5OctdBMuTXizaunHjwSYHKgc29
X-Proofpoint-ORIG-GUID: GBFTDa5OctdBMuTXizaunHjwSYHKgc29
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDE3MyBTYWx0ZWRfX/GU9SkenRKIm
 dLFZRfM7NJ+fcFBfm/BmHgZCaEI/ZDdOcnQJi79rAiM4LK7+5uo0LhucicZ+GBNRrbsrbb/UWxa
 iuW5dzd8dfAsMInTLvDkGkS6iidQS7E=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDE3MyBTYWx0ZWRfX1Of2xjowW/Nr
 kvAMt13/aC/dPDTzfim9jwEdZBGX9W2x9yx9hgx0kfGiNuTcBp4mjbhAjZLGBCqFLdBNtN+fKOD
 /YunHqsn9WXqcKNAcGXMKbFT5Ce2OH3aVbGcwGSN1B9/zuZw4BPydd89d5/m460LVlsBzw7tA5e
 rezem8cHDtfj527WEIsfuJAqp90WBAX6VaLIBhJpzd112utEv/Fh5R+rvTGFAo+OyrdY+uFehw0
 GDHwvtBFerHrpRD12MCmqwFuWwXl9Xwa2M2Yw//bKgqibP7K/tQXmUBjCa0VXWMgkl02WmVv7aL
 NG6l1N0xASiysnuNJ10VQiZJSPM/ADv3eUDxSqJGta8s1/y2eauShDo2k9auJ0pEdqxacwi819W
 8XWobAlCKBE7pYiZgBGQmY/iXH0/xk6uzMwyzF8BlZFmGlifZILK+wYHLRbhiZ1AxqysiXlMaVN
 g4xRJJ1I87NvV4bO8MA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_06,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608310173

On 8/31/26 1:14 PM, Anthony Krowiak wrote:
> Domain and control domain bitmaps are sized by the AP_DOMAINS constant, not
> AP_DEVICES. The two constants are both 256 today so there is no functional
> impact, but using the wrong constant is inconsistent with every operation
> on aqm/adm bitmaps.
> 
> Use AP_DOMAINS to keep the code consistent and correct in case
> the two constants ever diverge.
> 
> Note:
> This patch was submitted in response to a sashiko review comment pointing
> out there are other functions besides vfio_ap_mdev_cfg_add(), so there are
> fixes included here for those also. The subject line was kept the same
> since this is in v2 of this patch.
> 
> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>


