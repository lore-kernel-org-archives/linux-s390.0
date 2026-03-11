Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1BD347FD3;
	Wed, 11 Mar 2026 20:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773260676; cv=none; b=Y18W4Qo8lM73uf4AIAGov23wuQY9IUUZXhXC3AvytH5i+CU7cnRNy+XVO/b9m5WzGSrib6ytzERJ/eXdElIxB9xHpOawT6AgPPmqGoRtrf9H1AcOD/6VrZ/GtZimEo5QicBrUH6W15FIUnfRDItZpQEFCaR9fqSFF/IPiSLt1CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773260676; c=relaxed/simple;
	bh=jQrb+VYB5+jd5rg0WctyOmfeUt/ucIVBt4ZqyGx6CQA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=eCCwpqxJxVxAvXL8CASPBA32Rg1oJOoNQh2dcBk+UxHh4tySufY9DTLCt0+uIHsOn4+xRUxVHrDG2G24N1+F4C31MusXxbygh/FOmpxxCe46zOa5cd+8wEWeNUDH3a0RRpCNvtlbfmq6jWHjsa9zWQijIFWT/nXBmlo872hLVtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZM4jaeS4; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZM4jaeS4"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62BFuv571553765;
	Wed, 11 Mar 2026 20:24:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=pVU/KU
	tWkwIlDs8yTSxRp5Yjs1i3FIluYF4PViXe2iw=; b=ZM4jaeS45QW4eGJE2O7MSW
	vFK4pJsx07T13WT/Sdrr++NHQ8Esc/sMLia6ga5oVFe7veJ4pynAsX5pfEaJHFBE
	ZkgtGm+NUPop4ZzdqN3qykZv+xMnqlbuXzPb5GoV9L9XjRVgQXt6/bOOm8S7xce6
	WLEUVfl+Z9fCd+vLQPxFVPANS0vhrjBUtNpsWheuJ9YPGeF9IWcdfUZyXVUVqANp
	26MuBYzpPEF5z2tSzr6FNoqG9DYQDq/Hh0goa1lYkf/e+51QSZCW/dF1RPbAuitq
	2ZlUskLF15P79LpIZwWUSCWwPGFce6esKgVECONVLpoQ8AtdUjDkzhsJjzcRpYOA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcvrhb1a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Mar 2026 20:24:32 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62BI4wYI025085;
	Wed, 11 Mar 2026 20:24:32 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cs0jk6ubx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Mar 2026 20:24:32 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62BKOUG558851690
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Mar 2026 20:24:30 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5CFE458059;
	Wed, 11 Mar 2026 20:24:30 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B80D85804B;
	Wed, 11 Mar 2026 20:24:28 +0000 (GMT)
Received: from [9.61.81.79] (unknown [9.61.81.79])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 11 Mar 2026 20:24:28 +0000 (GMT)
Message-ID: <40c7df1d-1ddc-4940-a977-4861f12f5bcc@linux.ibm.com>
Date: Wed, 11 Mar 2026 16:24:28 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] Enable adapter_indicators_set to use mapped pages
To: Douglas Freimuth <freimuth@linux.ibm.com>, borntraeger@linux.ibm.com,
        imbrenda@linux.ibm.com, frankja@linux.ibm.com, david@kernel.org,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260308030438.88580-1-freimuth@linux.ibm.com>
 <20260308030438.88580-3-freimuth@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260308030438.88580-3-freimuth@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDE3MCBTYWx0ZWRfX7ouW+4Xwqo8N
 cXcd1S8sUYPeEgjXB/p2djk/bVZPtnRQFgtgr15DLioxtT9ylwaqw2dhCm2RjkwWoFppA9Cm+3S
 ZTKn6WFMrnFdCrmXfIRVE4tpBC6lzynZoxMdkst7iBp0xWvbyWlQV/biuZrOc7LOveu11X80dam
 YlZjixkXs+Sf1981Wo/S/uCfvQ+Ty4mOSDxHgKwHbzORF1q7t5/Nl4zhSnWEFgiHRgKL9Y/K1BA
 owXe8DqkkjOHSHMZ6YTlWachyJBMrSbCSSvzCfoUpiMVsnznD/ra4fvAHMljIVehpKfE6e1j7JY
 hoaDsFEOx5vtiIme3zBJAs7hANARyyKkzFaTFb7T2wpPTW8PAy+sINehayWiMMUHPGau/ANCjdr
 9dahiM7crM+J+FtsADMxl18kChxfwJoPdzljhdai3Th7/1r2Z+4NBswiceLIP4jDpkNACVm2j81
 7BZznEGGyB7ybu4Ujmw==
X-Proofpoint-GUID: mz3raqvXNLALoDwM3SB7eDy0_m6pt1kp
X-Proofpoint-ORIG-GUID: mz3raqvXNLALoDwM3SB7eDy0_m6pt1kp
X-Authority-Analysis: v=2.4 cv=QoFTHFyd c=1 sm=1 tr=0 ts=69b1cf80 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=C95L2cqcKni8q_fogVUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_02,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 malwarescore=0 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603110170

On 3/7/26 10:04 PM, Douglas Freimuth wrote:
> Patch 2: This patch enables adapter_indicators_set to use mapped pages.

See comments from patch 1 of this series.

> If adapter indicator pages are not mapped then local mapping is done as
> it is prior to this patch. For example, Secure Execution environments
> will take the local mapping path as it does prior to this patch.
> 
> Signed-off-by: Douglas Freimuth <freimuth@linux.ibm.com>



> -	idx = srcu_read_lock(&kvm->srcu);
> -	map = page_address(ind_page);
> -	bit = get_ind_bit(adapter_int->ind_addr,
> -			  adapter_int->ind_offset, adapter->swap);
> -	set_bit(bit, map);
> -	mark_page_dirty(kvm, adapter_int->ind_gaddr >> PAGE_SHIFT);
> -	set_page_dirty_lock(ind_page);
> -	map = page_address(summary_page);
> -	bit = get_ind_bit(adapter_int->summary_addr,
> -			  adapter_int->summary_offset, adapter->swap);
> -	summary_set = test_and_set_bit(bit, map);
> -	mark_page_dirty(kvm, adapter_int->summary_gaddr >> PAGE_SHIFT);
> -	set_page_dirty_lock(summary_page);
> -	srcu_read_unlock(&kvm->srcu, idx);
> -
> -	put_page(ind_page);
> -	put_page(summary_page);


Hitting compile errors if only apply up to this patch, looks like this area is the culprit.

I think you're missing a few lines here that accidentally wound up in patch 3?

+	summary_info = get_map_info(adapter, adapter_int->summary_addr);
+	if (!summary_info) {


> +		summary_page = get_map_page(kvm, adapter_int->summary_addr);
> +		if (!summary_page) {
> +			put_page(ind_page);
> +			return -1;
> +		}
