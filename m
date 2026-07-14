Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D6D39150A
	for <linux-s390@vger.kernel.org>; Tue, 14 Jul 2026 12:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784030836; cv=none; b=G60idxB0yeEkUTOwGXaZ2yollAp76SRePBU5VPCEwRadUyIqq3S4YYMCG8IkQtXbm+p/AWLtg8VGIHOHHJXH7Ham8tiCYMLa++9AARfRzl/67VV6JlHrUJ7PCy7ljzwmzUdRnXbjDGQRxFJbNlCAJiQ1upmd+K2z22yALARRpRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784030836; c=relaxed/simple;
	bh=0jqC4pdgB5lh1c5ytRbxc+y6qmUNtrAu8ZSvYVWXHV4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OtqgRKXJ/hBQ7RPp52HOvRwOVCEdg/lAN0SOdlOTGxHsxJIGf5CrKd9yCRql9iylx9ygyeOZ24voEc6cox5NF76XEpnyLO0iQvy5+q8LuxX9z608OkoM2sO6d8LT6jLqrdPlq0/kB+5dIVuYikjeNX9fHlJ99Ek7fYwETHQmOfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eeLdex9w; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eeLdex9w"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66EBgOjZ1129788;
	Tue, 14 Jul 2026 12:07:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ufBEGs
	eW3AA2+IsycrjZ1tEFevajLJn5Ikcdb01JhqU=; b=eeLdex9wPWWAEWqjM+KTUM
	+mpm6nxMtM9V9Mgd8N0Ijg1WMmdd5sAOrmLLFPEyNz26hTxSy140iN364rXL14iL
	Y2k+ZwUTS6HvtBVq3IvRl5xv1LkIMdYsN4ZoUrKK0o48wgV8pRtKBPUkTV05VWdW
	1uaXkz2Onx+G/qQsqcPenLFBQk19cZXw6j+k9RBsGQvE/69uJRr3LSuhjonmJv3I
	vDikMMvcxZCNrSHBdRZ3hHoLiYDl8E/luUrX9XzDJjQPyc+DYiKhNe0lAWy6k7O7
	2s2p7gL6gloi1PFb34xYKkDWBnkV6tlJaEACgCsZoXlwyKMuVdAbYrrjtdp89/FQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbexwnf2u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jul 2026 12:07:07 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66EC4b17006430;
	Tue, 14 Jul 2026 12:07:06 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc2uy2b08-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jul 2026 12:07:06 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66EC73dQ25690600
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Jul 2026 12:07:03 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1AAAD20043;
	Tue, 14 Jul 2026 12:07:03 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BBA3420040;
	Tue, 14 Jul 2026 12:07:02 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.75.242])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 14 Jul 2026 12:07:02 +0000 (GMT)
Message-ID: <920fea2e-5557-4cc5-ad7f-887558116215@linux.ibm.com>
Date: Tue, 14 Jul 2026 14:07:02 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 16/17] docs/s390: Document CPACF instructions support
To: Harald Freudenberger <freude@linux.ibm.com>, richard.henderson@linaro.org,
        david@kernel.org, thuth@redhat.com, berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, linux-s390@vger.kernel.org,
        dengler@linux.ibm.com, borntraeger@linux.ibm.com,
        fcallies@linux.ibm.com, cohuck@redhat.com
References: <20260710152906.80207-1-freude@linux.ibm.com>
 <20260710152906.80207-17-freude@linux.ibm.com>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20260710152906.80207-17-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -Xg7fSMsXB_ZGFrtmYuKeefH2sbRdjxK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDEyMiBTYWx0ZWRfXx8B1p2GAu7xh
 M44Q0SZ2V+WOpLZAtbfZnVYkcV1oZ+8VSz1G7ts+aw49Ig4RN7npqliiuOkiHKh2etHm1wYArOv
 GWtDqyJhe/9AZofSEsTGy75GDYpTVbS/j/E4oCRYnXgWTp5kcOilqfQ/p4CX+kzo8nf1cwifQtS
 m8NdY5E4cOZBRs3ponAPLAimTz65JEKT2ovFh+5yLSE1zyDepN7KwZGsqBK5gvnZGOXVWuvjlxr
 bM3+TdLN/IS0ChsJvPINCmCGAQnFv19LwHfWFPY5ct5E23wXHzlNaaAg/RYbSL0Myp80u8mFKph
 hHsxbBeJJehxfGTCFjnWW1yMbarAY3WwyBCz6sXSLnof8uBpMeuek7IQbO2Zginjs/IQPyRA64h
 sqBvrZNW6uo5A7yu2WKjG0PpOFS1gbu4CpaY2kDiB1f9+WHXxyLG+W/PwT1M0sDT0pmzBnvPHD9
 +f0155MeARdkkNz99OQ==
X-Authority-Analysis: v=2.4 cv=XJoAjwhE c=1 sm=1 tr=0 ts=6a56266b cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=HKfntiqoSFCIcbcqxL8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: -Xg7fSMsXB_ZGFrtmYuKeefH2sbRdjxK
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDEyMiBTYWx0ZWRfXxOrEHD87znLB
 P7Lx7Pohoupv1kMuEUThXjxntiMfpAY3PiauI+wRiFEkVBas8lzKVfJ0x51oPho8wesd10QRgR3
 +OSeuGH2zw/VVqZAEN7RajAUtljDNiY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_03,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 clxscore=1015 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140122



On 7/10/26 17:29, Harald Freudenberger wrote:
> Add a first document covering the Qemu s390 CPACF instructions
> and functions supported.
> 
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> Reviewed-by: Finn Callies <fcallies@linux.ibm.com>

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>

